Return-Path: <cygwin-patches-return-8082-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52533 invoked by alias); 30 Mar 2015 17:33:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52481 invoked by uid 89); 30 Mar 2015 17:33:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout01.bt.lon5.cpcloud.co.uk
Received: from rgout01.bt.lon5.cpcloud.co.uk (HELO rgout01.bt.lon5.cpcloud.co.uk) (65.20.0.178) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Mar 2015 17:33:13 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090201.551988D8.0166,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.24.102118:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __CANPHARM_COPYRIGHT, BODY_SIZE_4000_4999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout01.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5508763C01A1D859; Mon, 30 Mar 2015 18:33:12 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Make CONTEXT available to signal handlers
Date: Mon, 30 Mar 2015 17:33:00 -0000
Message-Id: <1427736757-13884-3-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1427736757-13884-1-git-send-email-jon.turney@dronecode.org.uk>
References: <20150330102129.GH29875@calimero.vinschen.de> <1427736757-13884-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q1/txt/msg00037.txt.bz2

Add ucontext.h header, defining ucontext_t and mcontext_t types.

Provide sigaction sighandlers with a ucontext_t parameter containing a
mcontext_t with exception context information, if available.

	* include/sys/ucontext.h : New header.
	* include/ucontext.h : Ditto.
	* exceptions.cc (call_signal_handler): Provide ucontext_t
	parameter to signal handler function, if available.
---
 winsup/cygwin/ChangeLog              |  7 +++++++
 winsup/cygwin/exceptions.cc          | 13 +++++++++++--
 winsup/cygwin/include/sys/ucontext.h | 22 ++++++++++++++++++++++
 winsup/cygwin/include/ucontext.h     | 16 ++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 winsup/cygwin/include/sys/ucontext.h
 create mode 100644 winsup/cygwin/include/ucontext.h

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index cfc29a8..8da5fa2 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,5 +1,12 @@
 2015-03-30  Jon TURNEY  <jon.turney@dronecode.org.uk>
 
+	* include/sys/ucontext.h : New header.
+	* include/ucontext.h : Ditto.
+	* exceptions.cc (call_signal_handler): Provide ucontext_t
+	parameter to signal handler function, if available.
+
+2015-03-30  Jon TURNEY  <jon.turney@dronecode.org.uk>
+
 	* include/cygwin/signal.h : Rename struct ucontext to struct mcontext.
 	Remove unused member oldmask and simplify __COPY_CONTEXT_SIZE.
 
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index af53457..80899d1 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -16,6 +16,7 @@ details. */
 #include <stdlib.h>
 #include <syslog.h>
 #include <wchar.h>
+#include <ucontext.h>
 
 #include "cygtls.h"
 #include "pinfo.h"
@@ -1487,8 +1488,17 @@ _cygtls::call_signal_handler ()
       /* Save information locally on stack to pass to handler. */
       int thissig = sig;
       siginfo_t thissi = infodata;
+      ucontext_t *thiscontext = NULL;
       void (*thisfunc) (int, siginfo_t *, void *) = func;
 
+      ucontext_t context;
+      memset(&context, 0, sizeof(ucontext_t)); /* no ucontext_t information provided yet */
+      if (thissi.si_cyg)
+        {
+          memcpy(&context.uc_mcontext, ((cygwin_exception *)thissi.si_cyg)->context(), sizeof(CONTEXT));
+          thiscontext = &context;
+        }
+
       sigset_t this_oldmask = set_process_mask_delta ();
       int this_errno = saved_errno;
       reset_signal_arrived ();
@@ -1496,8 +1506,7 @@ _cygtls::call_signal_handler ()
       sig = 0;		/* Flag that we can accept another signal */
       unlock ();	/* unlock signal stack */
 
-      /* no ucontext_t information provided yet, so third arg is NULL */
-      thisfunc (thissig, &thissi, NULL);
+      thisfunc (thissig, &thissi, thiscontext);
       incyg = true;
 
       set_signal_mask (_my_tls.sigmask, this_oldmask);
diff --git a/winsup/cygwin/include/sys/ucontext.h b/winsup/cygwin/include/sys/ucontext.h
new file mode 100644
index 0000000..df9b32b
--- /dev/null
+++ b/winsup/cygwin/include/sys/ucontext.h
@@ -0,0 +1,22 @@
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
+typedef struct mcontext mcontext_t;
+
+typedef struct ucontext {
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
