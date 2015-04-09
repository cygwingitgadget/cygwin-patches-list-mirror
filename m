Return-Path: <cygwin-patches-return-8124-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130925 invoked by alias); 9 Apr 2015 13:13:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130857 invoked by uid 89); 9 Apr 2015 13:13:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0305.bt.lon5.cpcloud.co.uk
Received: from rgout0305.bt.lon5.cpcloud.co.uk (HELO rgout0305.bt.lon5.cpcloud.co.uk) (65.20.0.211) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Apr 2015 13:13:40 +0000
X-OWM-Source-IP: 86.179.113.1(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.55267B03.00CB,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.4.6.93621:17:27.888,ip=86.179.113.1,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_1300_1399, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[1.113.179.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.113.1) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 551D2F0E00BD6649; Thu, 9 Apr 2015 14:13:39 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Initialize context before RtlContextCapture
Date: Thu, 09 Apr 2015 13:13:00 -0000
Message-Id: <1428585205-14420-2-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1428585205-14420-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1428585205-14420-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00025.txt.bz2

	* exceptions.cc (call_signal_handler): Zero initialize context and set
	context flags, as RlCaptureContext doesn't.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/ChangeLog     | 5 +++++
 winsup/cygwin/exceptions.cc | 8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 0d1f36d..9d50c1e 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1496,8 +1496,12 @@ _cygtls::call_signal_handler ()
       if (thissi.si_cyg)
         memcpy (&thiscontext.uc_mcontext, ((cygwin_exception *)thissi.si_cyg)->context(), sizeof(CONTEXT));
       else
-        RtlCaptureContext ((CONTEXT *)&thiscontext.uc_mcontext);
-        /* FIXME: Really this should be the context which the signal interrupted? */
+        {
+          /* FIXME: Really this should be the context which the signal interrupted? */
+          memset(&thiscontext.uc_mcontext, 0, sizeof(struct __mcontext));
+          thiscontext.uc_mcontext.ctxflags = CONTEXT_FULL;
+          RtlCaptureContext ((CONTEXT *)&thiscontext.uc_mcontext);
+        }
 
       /* FIXME: If/when sigaltstack is implemented, this will need to do
          something more complicated */
-- 
2.1.4
