Return-Path: <cygwin-patches-return-8100-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46684 invoked by alias); 1 Apr 2015 13:20:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46562 invoked by uid 89); 1 Apr 2015 13:20:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout01.bt.lon5.cpcloud.co.uk
Received: from rgout01.bt.lon5.cpcloud.co.uk (HELO rgout01.bt.lon5.cpcloud.co.uk) (65.20.0.178) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Apr 2015 13:20:00 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.551BF07E.007B,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.24.102118:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __FRAUD_BODY_WEBMAIL, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_3000_3999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, __FRAUD_WEBMAIL, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout01.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5508763C01DD9FB0; Wed, 1 Apr 2015 14:19:58 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Rename struct ucontext to struct __mcontext
Date: Wed, 01 Apr 2015 13:20:00 -0000
Message-Id: <1427894373-2576-2-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00003.txt.bz2

	* include/cygwin/signal.h : Rename struct ucontext to struct
	__mcontext.  Fix layout differences from the Win32 API CONTEXT
	type.  Remove unused member _internal.  Rename member which
	corresponds to ContextFlags.  Add cr2 member.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/ChangeLog               |  7 +++++++
 winsup/cygwin/include/cygwin/signal.h | 28 +++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index 0d07bb1..be612d5 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,3 +1,10 @@
+2015-04-01  Jon TURNEY  <jon.turney@dronecode.org.uk>
+
+	* include/cygwin/signal.h : Rename struct ucontext to struct
+	__mcontext.  Fix layout differences from the Win32 API CONTEXT
+	type.  Remove unused member _internal.  Rename member which
+	corresponds to ContextFlags.  Add cr2 member.
+
 2015-03-31  Renato Silva  <br.renatosilva@gmail.com>
 
 	* net.cc (cygwin_gethostname): Fix buffer size error handling.
diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/cygwin/signal.h
index 58bbff0..04e65aa 100644
--- a/winsup/cygwin/include/cygwin/signal.h
+++ b/winsup/cygwin/include/cygwin/signal.h
@@ -18,6 +18,10 @@
 extern "C" {
 #endif
 
+/*
+  Define a struct __mcontext, which should be identical in layout to the Win32
+  API type CONTEXT with the addition of oldmask and cr2 fields at the end.
+*/
 #ifdef __x86_64__
 
 struct _uc_fpxreg {
@@ -45,7 +49,7 @@ struct _fpstate
   __uint32_t padding[24];
 };
 
-struct ucontext
+struct __mcontext
 {
   __uint64_t p1home;
   __uint64_t p2home;
@@ -53,7 +57,7 @@ struct ucontext
   __uint64_t p4home;
   __uint64_t p5home;
   __uint64_t p6home;
-  __uint32_t cr2;
+  __uint32_t ctxflags;
   __uint32_t mxcsr;
   __uint16_t cs;
   __uint16_t ds;
@@ -86,14 +90,15 @@ struct ucontext
   __uint64_t r15;
   __uint64_t rip;
   struct _fpstate fpregs;
+  __uint64_t vregs[52];
   __uint64_t vcx;
   __uint64_t dbc;
   __uint64_t btr;
   __uint64_t bfr;
   __uint64_t etr;
   __uint64_t efr;
-  __uint8_t _internal;
   __uint64_t oldmask;
+  __uint64_t cr2;
 };
 
 #else /* !x86_64 */
@@ -117,9 +122,9 @@ struct _fpstate
   __uint32_t nxst;
 };
 
-struct ucontext
+struct __mcontext
 {
-  __uint32_t cr2;
+  __uint32_t ctxflags;
   __uint32_t dr0;
   __uint32_t dr1;
   __uint32_t dr2;
@@ -143,15 +148,20 @@ struct ucontext
   __uint32_t eflags;
   __uint32_t esp;
   __uint32_t ss;
-  __uint8_t _internal;
+  __uint32_t reserved[128];
   __uint32_t oldmask;
+  __uint32_t cr2;
 };
 
 #endif /* !x86_64 */
 
-/* Needed for GDB.   It only compiles in the context copy code if this
-   macro s defined. */
-#define __COPY_CONTEXT_SIZE ((size_t) (uintptr_t) &((struct ucontext *) 0)->_internal)
+/* Needed for GDB.  It only compiles in the context copy code if this macro is
+   defined.  This is not sizeof(CONTEXT) due to historical accidents. */
+#ifdef __x86_64__
+#define __COPY_CONTEXT_SIZE 816
+#else
+#define __COPY_CONTEXT_SIZE 204
+#endif
 
 typedef union sigval
 {
-- 
2.1.4
