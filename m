Return-Path: <cygwin-patches-return-8605-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129712 invoked by alias); 28 Jul 2016 11:44:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127479 invoked by uid 89); 28 Jul 2016 11:44:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=cygwin-patches, cygwinpatches, HTo:U*cygwin-patches
X-HELO: rgout03.bt.lon5.cpcloud.co.uk
Received: from rgout03.bt.lon5.cpcloud.co.uk (HELO rgout03.bt.lon5.cpcloud.co.uk) (65.20.0.180) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Jul 2016 11:44:45 +0000
X-OWM-Source-IP: 86.179.112.245 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.7.28.103916:17:27.888,ip=86.179.112.245,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, URI_ENDS_IN_HTML, __URI_NO_MAILTO, __URI_NO_WWW, __CP_URI_IN_BODY, __MULTIPLE_URI_TEXT, __URI_IN_BODY, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1200_1299, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[245.112.179.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, MULTIPLE_RCPTS_RND, RDNS_SUSP, BODY_SIZE_7000_LESS, LEGITIMATE_NEGATE
Received: from localhost.localdomain (86.179.112.245) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5799EA7C0000E107; Thu, 28 Jul 2016 12:44:41 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/2] Thread name support
Date: Thu, 28 Jul 2016 11:44:00 -0000
Message-Id: <20160728114341.1728-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00013.txt.bz2

Re-heat Yaakov's patch [1] for adding pthread_getname_np and pthread_setname_np
Use the native interface [2] for sending thread names to debugger 
 
[1] https://cygwin.com/ml/cygwin-patches/2012-q1/msg00022.html
[2] https://msdn.microsoft.com/en-us/library/xcb2z8hs.aspx

Jon Turney (2):
  Add pthread_getname_np and pthread_setname_np
  Send thread names to debugger

 winsup/cygwin/common.din               |  2 ++
 winsup/cygwin/cygthread.cc             |  2 ++
 winsup/cygwin/dcrt0.cc                 |  1 +
 winsup/cygwin/exceptions.cc            |  2 +-
 winsup/cygwin/include/cygwin/version.h |  3 +-
 winsup/cygwin/include/pthread.h        |  2 ++
 winsup/cygwin/miscfuncs.cc             | 28 +++++++++++++++
 winsup/cygwin/miscfuncs.h              |  2 ++
 winsup/cygwin/net.cc                   |  2 ++
 winsup/cygwin/profil.c                 |  2 ++
 winsup/cygwin/release/2.6.0            |  4 +++
 winsup/cygwin/thread.cc                | 66 +++++++++++++++++++++++++++++++++-
 winsup/cygwin/thread.h                 |  1 +
 winsup/doc/new-features.xml            | 12 +++++++
 winsup/doc/posix.xml                   |  2 ++
 15 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 winsup/cygwin/release/2.6.0

-- 
2.8.3
