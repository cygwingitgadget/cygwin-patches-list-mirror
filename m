Return-Path: <cygwin-patches-return-8729-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123895 invoked by alias); 4 Apr 2017 17:51:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123770 invoked by uid 89); 4 Apr 2017 17:51:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=looping, continuously, HTo:U*cygwin-patches
X-HELO: rgout01.bt.lon5.cpcloud.co.uk
Received: from rgout0107.bt.lon5.cpcloud.co.uk (HELO rgout01.bt.lon5.cpcloud.co.uk) (65.20.0.127) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Apr 2017 17:51:26 +0000
X-OWM-Source-IP: 86.179.113.198 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2017.4.4.172715:17:7.944,ip=,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __FROM_DOMAIN_IN_ANY_CC1, __ANY_URI, __URI_NO_WWW, __SUBJ_ALPHA_NEGATE, __NO_HTML_TAG_RAW, BODY_SIZE_1300_1399, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_P1, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, __FROM_DOMAIN_IN_RCPT, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, BODY_SIZE_2000_LESS, __MIME_TEXT_P, NO_URI_HTTPS, BODY_SIZE_7000_LESS
Received: from localhost.localdomain (86.179.113.198) by rgout01.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58C6B8A3025257C1; Tue, 4 Apr 2017 18:51:26 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Make ldd stop after any non-continuable exception
Date: Tue, 04 Apr 2017 17:51:00 -0000
Message-Id: <20170404175110.171404-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q2/txt/msg00000.txt.bz2

Ensure that ldd always stops when the exception is flagged as
non-continuable.

Also arrange for ldd to exit with a non-zero exit code if something went
wrong which prevented us from listing all dynamic dependencies.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---

Notes:
    I saw an instance of ldd which was continuously looping with the same
    STATUS_DLL_NOT_FOUND exception being reported.

 winsup/utils/ldd.cc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/winsup/utils/ldd.cc b/winsup/utils/ldd.cc
index 8e891d8..bbc62f1 100644
--- a/winsup/utils/ldd.cc
+++ b/winsup/utils/ldd.cc
@@ -302,6 +302,9 @@ report (const char *in_fn, bool multiple)
   dlls dll_list = {};
   dlls *dll_last = &dll_list;
   const wchar_t *process_fn = NULL;
+
+  int res = 0;
+
   while (1)
     {
       bool exitnow = false;
@@ -356,6 +359,11 @@ report (const char *in_fn, bool multiple)
 		TerminateProcess (hProcess, 0);
 	      break;
 	    }
+	  if (ev.u.Exception.ExceptionRecord.ExceptionFlags &
+	      EXCEPTION_NONCONTINUABLE) {
+	    res = 1;
+	    goto print_and_exit;
+	  }
 	  break;
 	case EXIT_PROCESS_DEBUG_EVENT:
 print_and_exit:
@@ -374,7 +382,7 @@ print_and_exit:
 	break;
     }
 
-  return 0;
+  return res;
 }
 
 int
-- 
2.8.3
