Return-Path: <cygwin-patches-return-8108-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86966 invoked by alias); 2 Apr 2015 16:25:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86580 invoked by uid 89); 2 Apr 2015 16:25:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout06.bt.lon5.cpcloud.co.uk
Received: from rgout06.bt.lon5.cpcloud.co.uk (HELO rgout06.bt.lon5.cpcloud.co.uk) (65.20.0.183) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Apr 2015 16:24:59 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.551D6D59.0049,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.30.162421:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5515161400C84636; Thu, 2 Apr 2015 17:24:57 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] Try to make sure struct _mcontext is 16-byte aligned
Date: Thu, 02 Apr 2015 16:25:00 -0000
Message-Id: <1427991886-6156-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00009.txt.bz2

On x86_64, RtlCaptureContext() uses fxsave to save FPU/MMX/SSE state.

fxsave requires that the destination address is 16-byte aligned, or it will
fault.

CONTEXT is already annotated __attribute__ ((aligned (16))), do the same with
struct _mcontext.

Rearrange ucontext_t so that it's struct _mcontext element is also correctly
aligned.

	* include/cygwin/signal.h (struct __mcontext): 16-byte align.
	* include/sys/ucontext.h (ucontext_t): Ditto.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/ChangeLog               | 5 +++++
 winsup/cygwin/include/cygwin/signal.h | 2 +-
 winsup/cygwin/include/sys/ucontext.h  | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index 9871b96..3b0e111 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,3 +1,8 @@
+2015-04-02  Jon TURNEY  <jon.turney@dronecode.org.uk>
+
+	* include/cygwin/signal.h (struct __mcontext): 16-byte align.
+	* include/sys/ucontext.h (ucontext_t): Ditto.
+
 2015-04-02  Corinna Vinschen  <corinna@vinschen.de>
 
 	* sec_acl.cc (CYG_ACE_ISBITS_TO_WIN): Fix typo.
diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/cygwin/signal.h
index 04e65aa..f2a6fa3 100644
--- a/winsup/cygwin/include/cygwin/signal.h
+++ b/winsup/cygwin/include/cygwin/signal.h
@@ -49,7 +49,7 @@ struct _fpstate
   __uint32_t padding[24];
 };
 
-struct __mcontext
+ __attribute__ ((aligned (16))) struct __mcontext
 {
   __uint64_t p1home;
   __uint64_t p2home;
diff --git a/winsup/cygwin/include/sys/ucontext.h b/winsup/cygwin/include/sys/ucontext.h
index 9362d90..859eb29 100644
--- a/winsup/cygwin/include/sys/ucontext.h
+++ b/winsup/cygwin/include/sys/ucontext.h
@@ -15,11 +15,11 @@ details. */
 
 typedef struct __mcontext mcontext_t;
 
-typedef struct __ucontext {
+typedef  __attribute__ ((aligned (16))) struct __ucontext {
+	mcontext_t	uc_mcontext;
 	struct __ucontext *uc_link;
 	sigset_t	uc_sigmask;
 	stack_t	uc_stack;
-	mcontext_t	uc_mcontext;
 	unsigned long int	uc_flags;
 } ucontext_t;
 
-- 
2.1.4
