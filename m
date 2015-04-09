Return-Path: <cygwin-patches-return-8123-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130602 invoked by alias); 9 Apr 2015 13:13:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130589 invoked by uid 89); 9 Apr 2015 13:13:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0305.bt.lon5.cpcloud.co.uk
Received: from rgout0305.bt.lon5.cpcloud.co.uk (HELO rgout0305.bt.lon5.cpcloud.co.uk) (65.20.0.211) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Apr 2015 13:13:37 +0000
X-OWM-Source-IP: 86.179.113.1(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.55267AFF.0079,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.4.6.101518:17:27.888,ip=86.179.113.1,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_400_499, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, SXL_IP_DYNAMIC[1.113.179.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_1000_LESS, RDNS_SUSP, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS, NO_URI_FOUND
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.113.1) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 551D2F0E00BD65BF; Thu, 9 Apr 2015 14:13:35 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/3] signal handler ucontext improvements
Date: Thu, 09 Apr 2015 13:13:00 -0000
Message-Id: <1428585205-14420-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00024.txt.bz2

A few further patches improving the ucontext created for a signal handler

Jon TURNEY (3):
  Initialize context before RtlContextCapture
  Only construct ucontext for SA_SIGINFO signal handlers
  Set mcontext.cr2 to the faulting address

 winsup/cygwin/ChangeLog     | 16 +++++++++++++
 winsup/cygwin/exceptions.cc | 58 +++++++++++++++++++++++++++++----------------
 2 files changed, 54 insertions(+), 20 deletions(-)

-- 
2.1.4
