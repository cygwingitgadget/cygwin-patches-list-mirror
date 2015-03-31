Return-Path: <cygwin-patches-return-8086-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49977 invoked by alias); 31 Mar 2015 17:47:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49835 invoked by uid 89); 31 Mar 2015 17:47:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout0302.bt.lon5.cpcloud.co.uk
Received: from rgout0302.bt.lon5.cpcloud.co.uk (HELO rgout0302.bt.lon5.cpcloud.co.uk) (65.20.0.208) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 17:47:13 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090201.551ADD9E.007C,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.17.110622:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5507081501E74369; Tue, 31 Mar 2015 18:47:10 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Rename struct ucontext to struct __mcontext
Date: Tue, 31 Mar 2015 17:47:00 -0000
Message-Id: <1427824014-19504-2-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q1/txt/msg00041.txt.bz2

	* include/cygwin/signal.h : Rename struct ucontext to struct
	__mcontext.  Remove unused member _internal.  Fix differences from
	the Win32 API CONTEXT type.

XXX: the ContextFlags member of the CONTEXT type is named cr2.  This looks
wrong.
---
 winsup/cygwin/ChangeLog               |  6 ++++++
 winsup/cygwin/include/cygwin/signal.h | 18 +++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index 505f4ce..1b4f4f3 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,3 +1,9 @@
+2015-03-30  Jon TURNEY  <jon.turney@dronecode.org.uk>
+
+	* include/cygwin/signal.h : Rename struct ucontext to struct
+	__mcontext.  Remove unused member _internal.  Fix differences from
+	the Win32 API CONTEXT type.
+
 2015-03-30  Corinna Vinschen  <corinna@vinschen.de>
 
 	* cygtls.h (struct _cygtls): Convert thread_context to type CONTEXT.
diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/cygwin/signal.h
index 58bbff0..3fefdf7 100644
--- a/winsup/cygwin/include/cygwin/signal.h
+++ b/winsup/cygwin/include/cygwin/signal.h
@@ -18,6 +18,10 @@
 extern "C" {
 #endif
 
+/*
+  Define a struct __mcontext, which should be identical in layout to the Win32
+  API type CONTEXT with the addition of an oldmask field at the end.
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
@@ -86,13 +90,13 @@ struct ucontext
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
 };
 
@@ -117,7 +121,7 @@ struct _fpstate
   __uint32_t nxst;
 };
 
-struct ucontext
+struct __mcontext
 {
   __uint32_t cr2;
   __uint32_t dr0;
@@ -143,15 +147,15 @@ struct ucontext
   __uint32_t eflags;
   __uint32_t esp;
   __uint32_t ss;
-  __uint8_t _internal;
+  __uint32_t reserved[128];
   __uint32_t oldmask;
 };
 
 #endif /* !x86_64 */
 
-/* Needed for GDB.   It only compiles in the context copy code if this
-   macro s defined. */
-#define __COPY_CONTEXT_SIZE ((size_t) (uintptr_t) &((struct ucontext *) 0)->_internal)
+/* Needed for GDB 7.9 and earlier.  It only compiles in the context copy code if
+   this macro is defined. */
+#define __COPY_CONTEXT_SIZE ((size_t) (uintptr_t) &((struct ucontext *) 0)->oldmask)
 
 typedef union sigval
 {
-- 
2.1.4
