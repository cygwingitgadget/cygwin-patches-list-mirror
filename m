Return-Path: <cygwin-patches-return-8085-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49830 invoked by alias); 31 Mar 2015 17:47:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49817 invoked by uid 89); 31 Mar 2015 17:47:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout0305.bt.lon5.cpcloud.co.uk
Received: from rgout0305.bt.lon5.cpcloud.co.uk (HELO rgout0305.bt.lon5.cpcloud.co.uk) (65.20.0.211) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 17:47:10 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.551ADD9C.00A5,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.17.110622:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, BODY_SIZE_1100_1199, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS, NO_URI_FOUND
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5507081501E74333; Tue, 31 Mar 2015 18:47:08 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/3] Make detailled exception information available to signal handlers
Date: Tue, 31 Mar 2015 17:47:00 -0000
Message-Id: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q1/txt/msg00040.txt.bz2

Thanks for your help so far.  Here's another attempt at this.

Questions:

The ContextFlags member of the CONTEXT type is named cr2 in struct __mcontext. I 
don't understand how that can be right.

For a non-exception signal, we won't have aCONTEXT to provide.  Is one that is 
all zeroes acceptable?

Jon TURNEY (3):
  Rename struct ucontext to struct __mcontext
  Make mcontext and stack information available to signal handlers
  Add cygwin_internal() operation to convert siginfo_t * to
    EXCEPTION_RECORD *

 winsup/cygwin/ChangeLog               | 20 ++++++++++++++++++++
 winsup/cygwin/exception.h             |  1 +
 winsup/cygwin/exceptions.cc           | 20 ++++++++++++++++++--
 winsup/cygwin/external.cc             | 13 +++++++++++++
 winsup/cygwin/include/cygwin/signal.h | 18 +++++++++++-------
 winsup/cygwin/include/sys/cygwin.h    |  4 +++-
 winsup/cygwin/include/sys/ucontext.h  | 26 ++++++++++++++++++++++++++
 winsup/cygwin/include/ucontext.h      | 16 ++++++++++++++++
 8 files changed, 108 insertions(+), 10 deletions(-)
 create mode 100644 winsup/cygwin/include/sys/ucontext.h
 create mode 100644 winsup/cygwin/include/ucontext.h

-- 
2.1.4
