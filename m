Return-Path: <cygwin-patches-return-8612-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90987 invoked by alias); 22 Aug 2016 18:09:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90952 invoked by uid 89); 22 Aug 2016 18:09:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=H*RU:CriticalPath, Hx-spam-relays-external:CriticalPath, HCc:D*uk, cygwin-patches
X-HELO: rgout0307.bt.lon5.cpcloud.co.uk
Received: from rgout0307.bt.lon5.cpcloud.co.uk (HELO rgout0307.bt.lon5.cpcloud.co.uk) (65.20.0.213) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Aug 2016 18:09:29 +0000
X-OWM-Source-IP: 86.166.190.87 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.8.22.171216:17:27.888,ip=86.166.190.87,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __FROM_DOMAIN_IN_ANY_CC1, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, URI_ENDS_IN_HTML, __URI_NO_MAILTO, __URI_NO_WWW, __CP_URI_IN_BODY, __MULTIPLE_URI_TEXT, __URI_IN_BODY, BODY_SIZE_1300_1399, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[87.190.166.86.fur], __SXL_URI_TIMEOUT[msdn.microsoft.com.uri.vir2.sophosxl.com], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, __FROM_DOMAIN_IN_RCPT, RDNS_SUSP, BODY_SIZE_7000_LESS, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, LEGITIMATE_NEGATE
Received: from localhost.localdomain (86.166.190.87) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 57BB330F0001EEF2; Mon, 22 Aug 2016 19:09:21 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/2] Thread name support (v2)
Date: Mon, 22 Aug 2016 18:09:00 -0000
Message-Id: <20160822180848.351616-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00020.txt.bz2

Re-heat Yaakov's patch [1] for adding pthread_getname_np and pthread_setname_np
Use the native interface [2] for sending thread names to debugger 
 
[1] https://cygwin.com/ml/cygwin-patches/2012-q1/msg00022.html
[2] https://msdn.microsoft.com/en-us/library/xcb2z8hs.aspx

Changes since v1:
- pthread_setname_np() returns ERANGE for names longer than 16 characters to match linux
- code style fixes
- leave setting the name of the profiling thread in libgmon.a as future work

Jon Turney (2):
  Add pthread_getname_np and pthread_setname_np
  Send thread names to debugger

 winsup/cygwin/common.din               |  2 +
 winsup/cygwin/cygthread.cc             |  2 +
 winsup/cygwin/dcrt0.cc                 |  1 +
 winsup/cygwin/exceptions.cc            |  2 +-
 winsup/cygwin/include/cygwin/version.h |  3 +-
 winsup/cygwin/include/pthread.h        |  2 +
 winsup/cygwin/miscfuncs.cc             | 26 +++++++++++++
 winsup/cygwin/miscfuncs.h              |  2 +
 winsup/cygwin/net.cc                   |  1 +
 winsup/cygwin/release/2.6.0            |  1 +
 winsup/cygwin/thread.cc                | 69 +++++++++++++++++++++++++++++++++-
 winsup/cygwin/thread.h                 |  1 +
 winsup/doc/new-features.xml            |  4 ++
 winsup/doc/posix.xml                   |  2 +
 14 files changed, 115 insertions(+), 3 deletions(-)

-- 
2.8.3
