Return-Path: <cygwin-patches-return-8125-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 792 invoked by alias); 9 Apr 2015 13:13:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 778 invoked by uid 89); 9 Apr 2015 13:13:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0304.bt.lon5.cpcloud.co.uk
Received: from rgout0304.bt.lon5.cpcloud.co.uk (HELO rgout0304.bt.lon5.cpcloud.co.uk) (65.20.0.210) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Apr 2015 13:13:45 +0000
X-OWM-Source-IP: 86.179.113.1(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.55267B06.006E,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.4.6.101518:17:27.888,ip=86.179.113.1,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_4000_4999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[1.113.179.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.113.1) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 551D2F0E00BD6684; Thu, 9 Apr 2015 14:13:42 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] Only construct ucontext for SA_SIGINFO signal handlers
Date: Thu, 09 Apr 2015 13:13:00 -0000
Message-Id: <1428585205-14420-3-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1428585205-14420-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1428585205-14420-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00026.txt.bz2

	* exceptions.cc (call_signal_handler): Only bother to construct
	the ucontext for signal handlers with SA_SIGINFO set.  Set
	mcontext.oldmask.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/ChangeLog     |  6 +++++
 winsup/cygwin/exceptions.cc | 54 +++++++++++++++++++++++++++------------------
 2 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 9d50c1e..0223052 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1485,42 +1485,52 @@ _cygtls::call_signal_handler ()
       debug_only_printf ("dealing with signal %d", sig);
       this_sa_flags = sa_flags;
 
+      sigset_t this_oldmask = set_process_mask_delta ();
+
       /* Save information locally on stack to pass to handler. */
       int thissig = sig;
       siginfo_t thissi = infodata;
       void (*thisfunc) (int, siginfo_t *, void *) = func;
 
-      ucontext_t thiscontext;
-      thiscontext.uc_link = 0;
-      thiscontext.uc_flags = 0;
-      if (thissi.si_cyg)
-        memcpy (&thiscontext.uc_mcontext, ((cygwin_exception *)thissi.si_cyg)->context(), sizeof(CONTEXT));
-      else
+      ucontext_t context;
+      ucontext_t *thiscontext = NULL;
+
+      /* Only make a context for SA_SIGINFO handlers */
+      if (this_sa_flags & SA_SIGINFO)
         {
-          /* FIXME: Really this should be the context which the signal interrupted? */
-          memset(&thiscontext.uc_mcontext, 0, sizeof(struct __mcontext));
-          thiscontext.uc_mcontext.ctxflags = CONTEXT_FULL;
-          RtlCaptureContext ((CONTEXT *)&thiscontext.uc_mcontext);
+          context.uc_link = 0;
+          context.uc_flags = 0;
+          if (thissi.si_cyg)
+            memcpy (&context.uc_mcontext, ((cygwin_exception *)thissi.si_cyg)->context(), sizeof(CONTEXT));
+          else
+            {
+              /* FIXME: Really this should be the context which the signal interrupted? */
+              memset(&context.uc_mcontext, 0, sizeof(struct __mcontext));
+              context.uc_mcontext.ctxflags = CONTEXT_FULL;
+              RtlCaptureContext ((CONTEXT *)&context.uc_mcontext);
+            }
+
+          /* FIXME: If/when sigaltstack is implemented, this will need to do
+             something more complicated */
+          context.uc_stack.ss_sp = NtCurrentTeb ()->Tib.StackBase;
+          context.uc_stack.ss_flags = 0;
+          if (!NtCurrentTeb ()->DeallocationStack)
+            context.uc_stack.ss_size = (uintptr_t)NtCurrentTeb ()->Tib.StackLimit - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
+          else
+            context.uc_stack.ss_size = (uintptr_t)NtCurrentTeb ()->DeallocationStack - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
+
+          context.uc_sigmask = context.uc_mcontext.oldmask = this_oldmask;
+
+          thiscontext = &context;
         }
 
-      /* FIXME: If/when sigaltstack is implemented, this will need to do
-         something more complicated */
-      thiscontext.uc_stack.ss_sp = NtCurrentTeb ()->Tib.StackBase;
-      thiscontext.uc_stack.ss_flags = 0;
-      if (!NtCurrentTeb ()->DeallocationStack)
-        thiscontext.uc_stack.ss_size = (uintptr_t)NtCurrentTeb ()->Tib.StackLimit - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
-      else
-        thiscontext.uc_stack.ss_size = (uintptr_t)NtCurrentTeb ()->DeallocationStack - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
-
-      sigset_t this_oldmask = set_process_mask_delta ();
-      thiscontext.uc_sigmask = this_oldmask;
       int this_errno = saved_errno;
       reset_signal_arrived ();
       incyg = false;
       sig = 0;		/* Flag that we can accept another signal */
       unlock ();	/* unlock signal stack */
 
-      thisfunc (thissig, &thissi, &thiscontext);
+      thisfunc (thissig, &thissi, thiscontext);
       incyg = true;
 
       set_signal_mask (_my_tls.sigmask, this_oldmask);
-- 
2.1.4
