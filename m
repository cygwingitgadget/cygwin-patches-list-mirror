Return-Path: <cygwin-patches-return-8077-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46795 invoked by alias); 26 Mar 2015 15:25:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46768 invoked by uid 89); 26 Mar 2015 15:25:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout03.bt.lon5.cpcloud.co.uk
Received: from rgout03.bt.lon5.cpcloud.co.uk (HELO rgout03.bt.lon5.cpcloud.co.uk) (65.20.0.180) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Mar 2015 15:25:41 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.551424F3.0060,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.17.110622:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __CANPHARM_COPYRIGHT, BODY_SIZE_5000_5999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 550708150144F59E; Thu, 26 Mar 2015 15:25:39 +0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] Make EXCEPTION_POINTERS available to signal handlers
Date: Thu, 26 Mar 2015 15:25:00 -0000
Message-Id: <1427383517-3360-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q1/txt/msg00032.txt.bz2

Add ucontext.h header, defining ucontext_t and mcontext_t types.

Provide sigaction sighandlers with a ucontext_t parameter containing a
mcontext_t with exception context information, if available.

	* include/sys/ucontext.h (__ucontext): New header.
	* include/ucontext.h (_UCONTEXT_H): Ditto.
	* exception.h (cygwin_exception): Add exception_record accessor.
	* exceptions.cc (call_signal_handler): Provide ucontext_t
	parameter to signal handler function, if available.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/ChangeLog              |  8 ++++++++
 winsup/cygwin/exception.h            |  1 +
 winsup/cygwin/exceptions.cc          | 16 ++++++++++++++--
 winsup/cygwin/include/sys/ucontext.h | 27 +++++++++++++++++++++++++++
 winsup/cygwin/include/ucontext.h     | 16 ++++++++++++++++
 5 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 winsup/cygwin/include/sys/ucontext.h
 create mode 100644 winsup/cygwin/include/ucontext.h

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index 869beee..ce09390 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,3 +1,11 @@
+2015-03-26  Jon TURNEY  <jon.turney@dronecode.org.uk>
+
+	* include/sys/ucontext.h (__ucontext): New header.
+	* include/ucontext.h (_UCONTEXT_H): Ditto.
+	* exception.h (cygwin_exception): Add exception_record accessor.
+	* exceptions.cc (call_signal_handler): Provide ucontext_t
+	parameter to signal handler function, if available.
+
 2015-03-25  Corinna Vinschen  <corinna@vinschen.de>
 
 	* include/sys/termios.h: Add CMIN and CTIME.
diff --git a/winsup/cygwin/exception.h b/winsup/cygwin/exception.h
index 3686bb0..0478daf 100644
--- a/winsup/cygwin/exception.h
+++ b/winsup/cygwin/exception.h
@@ -175,4 +175,5 @@ public:
     framep (in_framep), ctx (in_ctx), e (in_e), h (NULL) {}
   void dumpstack ();
   PCONTEXT context () const {return ctx;}
+  EXCEPTION_RECORD *exception_record () const {return e;}
 };
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 3af9a54..33ff989 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -16,6 +16,7 @@ details. */
 #include <stdlib.h>
 #include <syslog.h>
 #include <wchar.h>
+#include <ucontext.h>
 
 #include "cygtls.h"
 #include "pinfo.h"
@@ -1487,8 +1488,20 @@ _cygtls::call_signal_handler ()
       /* Save information locally on stack to pass to handler. */
       int thissig = sig;
       siginfo_t thissi = infodata;
+      ucontext_t *thiscontext = NULL;
       void (*thisfunc) (int, siginfo_t *, void *) = func;
 
+      ucontext_t context;
+      memset(&context, 0, sizeof(ucontext_t)); /* no ucontext_t information provided yet */
+      EXCEPTION_POINTERS ep;
+      if (thissi.si_cyg)
+        {
+          ep.ExceptionRecord = ((cygwin_exception *)thissi.si_cyg)->exception_record();
+          ep.ContextRecord = ((cygwin_exception *)thissi.si_cyg)->context();
+          context.uc_mcontext.ep = &ep;
+          thiscontext = &context;
+        }
+
       sigset_t this_oldmask = set_process_mask_delta ();
       int this_errno = saved_errno;
       reset_signal_arrived ();
@@ -1496,8 +1509,7 @@ _cygtls::call_signal_handler ()
       sig = 0;		/* Flag that we can accept another signal */
       unlock ();	/* unlock signal stack */
 
-      /* no ucontext_t information provided yet, so third arg is NULL */
-      thisfunc (thissig, &thissi, NULL);
+      thisfunc (thissig, &thissi, thiscontext);
       incyg = true;
 
       set_signal_mask (_my_tls.sigmask, this_oldmask);
diff --git a/winsup/cygwin/include/sys/ucontext.h b/winsup/cygwin/include/sys/ucontext.h
new file mode 100644
index 0000000..a44f854
--- /dev/null
+++ b/winsup/cygwin/include/sys/ucontext.h
@@ -0,0 +1,27 @@
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
+#include <signal.h>
+
+typedef struct __mcontext {
+	EXCEPTION_POINTERS *ep;
+} mcontext_t;
+
+typedef struct __ucontext {
+	struct __ucontext *uc_link;
+	sigset_t	uc_sigmask;
+	// We don't have a type stack_t, so we don't have a uc_stack member
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
