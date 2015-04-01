Return-Path: <cygwin-patches-return-8099-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46541 invoked by alias); 1 Apr 2015 13:20:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46518 invoked by uid 89); 1 Apr 2015 13:20:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout01.bt.lon5.cpcloud.co.uk
Received: from rgout01.bt.lon5.cpcloud.co.uk (HELO rgout01.bt.lon5.cpcloud.co.uk) (65.20.0.178) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Apr 2015 13:19:58 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.551BF07B.00A9,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.24.91819:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, BODY_SIZE_1500_1599, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS, NO_URI_FOUND
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout01.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5508763C01DD9F65; Wed, 1 Apr 2015 14:19:55 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/3] Make detailed exception information available to signal handlers (v4)
Date: Wed, 01 Apr 2015 13:20:00 -0000
Message-Id: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00000.txt.bz2

Thanks for your comments so far.

Changes since v3:

Rename cr2 member of struct __ucontext to ctxflags
Add cr2 member after oldmask to struct __ucontext
Keep __COPY_CONSTRUCT_SIZE as it's historical value

Add uc_flags member to ucontext_t in case of future need
Set uc_sigmask
Use RtlCopyContext() if we don't have a context
Add a FIXME for uc_stack mentioning sigaltstack
Simplify additions to call_signal_handler() since a ucontext_t is now always passed
Just include signal.h in sys/ucontext.h

Change CW_EXCEPTION_RECORD_FROM_SIGINFO_T to return a copy of the EXCEPTION_RECORD
#define CW_EXCEPTION_RECORD_FROM_SIGINFO_T 

Jon TURNEY (3):
  Rename struct ucontext to struct __mcontext
  Provide ucontext to signal handlers
  Add cygwin_internal() operation to retrieve the EXCEPTION_RECORD from
    a siginfo_t *

 winsup/cygwin/ChangeLog               | 21 +++++++++++++++++++++
 winsup/cygwin/exception.h             |  1 +
 winsup/cygwin/exceptions.cc           | 22 ++++++++++++++++++++--
 winsup/cygwin/external.cc             | 14 ++++++++++++++
 winsup/cygwin/include/cygwin/signal.h | 28 +++++++++++++++++++---------
 winsup/cygwin/include/sys/cygwin.h    |  5 ++++-
 winsup/cygwin/include/sys/ucontext.h  | 26 ++++++++++++++++++++++++++
 winsup/cygwin/include/ucontext.h      | 16 ++++++++++++++++
 8 files changed, 121 insertions(+), 12 deletions(-)
 create mode 100644 winsup/cygwin/include/sys/ucontext.h
 create mode 100644 winsup/cygwin/include/ucontext.h

-- 
2.1.4
