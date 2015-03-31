Return-Path: <cygwin-patches-return-8087-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50268 invoked by alias); 31 Mar 2015 17:47:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50211 invoked by uid 89); 31 Mar 2015 17:47:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout0305.bt.lon5.cpcloud.co.uk
Received: from rgout0305.bt.lon5.cpcloud.co.uk (HELO rgout0305.bt.lon5.cpcloud.co.uk) (65.20.0.211) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 17:47:14 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.551ADDA1.0078,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.17.110622:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __CANPHARM_COPYRIGHT, BODY_SIZE_4000_4999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5507081501E743C9; Tue, 31 Mar 2015 18:47:13 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] Make mcontext and stack information available to signal handlers
Date: Tue, 31 Mar 2015 17:47:00 -0000
Message-Id: <1427824014-19504-3-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q1/txt/msg00042.txt.bz2

Add ucontext.h header, defining ucontext_t and mcontext_t types.

Provide sigaction sighandlers with a ucontext_t parameter, containing stack and
context information.

XXX: How do we indicate context information is not available (si_cyg == NULL)

	* include/sys/ucontext.h : New header.
	* include/ucontext.h : Ditto.
	* exceptions.cc (call_signal_handler): Provide ucontext_t
	parameter to signal handler function.
---
 winsup/cygwin/ChangeLog              |  7 +++++++
 winsup/cygwin/exceptions.cc          | 20 ++++++++++++++++++--
 winsup/cygwin/include/sys/ucontext.h | 26 ++++++++++++++++++++++++++
 winsup/cygwin/include/ucontext.h     | 16 ++++++++++++++++
 4 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 winsup/cygwin/include/sys/ucontext.h
 create mode 100644 winsup/cygwin/include/ucontext.h

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index 1b4f4f3..f037112 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,5 +1,12 @@
 2015-03-30  Jon TURNEY  <jon.turney@dronecode.org.uk>
 
+	* include/sys/ucontext.h : New header.
+	* include/ucontext.h : Ditto.
+	* exceptions.cc (call_signal_handler): Provide ucontext_t
+	parameter to signal handler function.
+
+2015-03-30  Jon TURNEY  <jon.turney@dronecode.org.uk>
+
 	* include/cygwin/signal.h : Rename struct ucontext to struct
 	__mcontext.  Remove unused member _internal.  Fix differences from
 	the Win32 API CONTEXT type.
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index af53457..1c15bae 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -16,6 +16,7 @@ details. */
 #include <stdlib.h>
 #include <syslog.h>
 #include <wchar.h>
+#include <ucontext.h>
 
 #include "cygtls.h"
 #include "pinfo.h"
@@ -1487,8 +1488,24 @@ _cygtls::call_signal_handler ()
       /* Save information locally on stack to pass to handler. */
       int thissig = sig;
       siginfo_t thissi = infodata;
+      ucontext_t *thiscontext = NULL;
       void (*thisfunc) (int, siginfo_t *, void *) = func;
 
+      ucontext_t context;
+      thiscontext = &context;
+      memset (&context, 0, sizeof(ucontext_t));
+      if (thissi.si_cyg)
+        {
+          memcpy (&context.uc_mcontext, ((cygwin_exception *)thissi.si_cyg)->context(), sizeof(CONTEXT));
+        }
+
+      context.uc_stack.ss_sp = NtCurrentTeb ()->Tib.StackBase;
+      context.uc_stack.ss_flags = 0;
+      if (!NtCurrentTeb ()->DeallocationStack)
+        context.uc_stack.ss_size = (uintptr_t)NtCurrentTeb ()->Tib.StackLimit - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
+      else
+        context.uc_stack.ss_size = (uintptr_t)NtCurrentTeb ()->DeallocationStack - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
+
       sigset_t this_oldmask = set_process_mask_delta ();
       int this_errno = saved_errno;
       reset_signal_arrived ();
@@ -1496,8 +1513,7 @@ _cygtls::call_signal_handler ()
       sig = 0;		/* Flag that we can accept another signal */
       unlock ();	/* unlock signal stack */
 
-      /* no ucontext_t information provided yet, so third arg is NULL */
-      thisfunc (thissig, &thissi, NULL);
+      thisfunc (thissig, &thissi, thiscontext);
       incyg = true;
 
       set_signal_mask (_my_tls.sigmask, this_oldmask);
diff --git a/winsup/cygwin/include/sys/ucontext.h b/winsup/cygwin/include/sys/ucontext.h
new file mode 100644
index 0000000..ef0e849
--- /dev/null
+++ b/winsup/cygwin/include/sys/ucontext.h
@@ -0,0 +1,26 @@
+/* ucontext.h
+
+   Copyright 2015 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _SYS_UCONTEXT_H_
+#define _SYS_UCONTEXT_H_
+
+#include <cygwin/signal.h>
+#include <sys/signal.h>
+
+typedef struct __mcontext mcontext_t;
+
+typedef struct __ucontext {
+	struct __ucontext *uc_link;
+	sigset_t	uc_sigmask;
+	stack_t	uc_stack;
+	mcontext_t	uc_mcontext;
+} ucontext_t;
+
+#endif /* !_SYS_UCONTEXT_H_ */
diff --git a/winsup/cygwin/include/ucontext.h b/winsup/cygwin/include/ucontext.h
new file mode 100644
index 0000000..4240597
--- /dev/null
+++ b/winsup/cygwin/include/ucontext.h
@@ -0,0 +1,16 @@
+/* ucontext.h
+
+   Copyright 2015 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _UCONTEXT_H
+#define _UCONTEXT_H
+
+#include <sys/ucontext.h>
+
+#endif /* _UCONTEXT_H */
-- 
2.1.4
