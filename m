Return-Path: <cygwin-patches-return-8080-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51746 invoked by alias); 30 Mar 2015 17:33:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51730 invoked by uid 89); 30 Mar 2015 17:33:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout01.bt.lon5.cpcloud.co.uk
Received: from rgout01.bt.lon5.cpcloud.co.uk (HELO rgout01.bt.lon5.cpcloud.co.uk) (65.20.0.178) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Mar 2015 17:33:07 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090205.551988D0.0028,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.24.102118:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __BOUNCE_CHALLENGE_SUBJ, __BOUNCE_NDR_SUBJ_EXEMPT, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __SUBJ_ALPHA_NEGATE, __FORWARDED_MSG, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_FOUND, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout01.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5508763C01A1D6E2; Mon, 30 Mar 2015 18:33:04 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Make EXCEPTION_POINTERS available to signal handlers
Date: Mon, 30 Mar 2015 17:33:00 -0000
Message-Id: <1427736757-13884-1-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <20150330102129.GH29875@calimero.vinschen.de>
References: <20150330102129.GH29875@calimero.vinschen.de>
X-SW-Source: 2015-q1/txt/msg00035.txt.bz2

Thanks for your comments.

>    We should remove or rename struct ucontext in cygwin/signal.h, so we
>    can use that name for your above struct __ucontext.  That leads to the
>    next point...

Ok, building on your clean-up, this is [1/2]

> * Since struct ucontext from cygwin/signal.h is actually a redefinition
>    of CONTEXT + an oldmask value. it's basically the Cygwin/Windows
>    representation of gregset_t + fpregset_t + cr2 + oldmask, aka
>    mcontext_t.
> 
>    As for oldmask, this can be fetched easily from _my_tls, so in theory
>    we can use the current definition of ucontext from cygwin/signal.h as
>    mcontext_t.
> 
>    But this drops the EXCEPTION_RECORD.  I'm not sure it belongs here.
>    Keep in mind that a signal handler is not only called in case an
>    exception occured.  I think the context is all a signal handler needs.

Yes, I had my doubts that EXCEPTION_RECORD didn't belong ucontext.

I've writen [2/2] to just provide mcontext_t (= CONTEXT) as part of the 
ucontext_t.

But ultimately, I'd like to have access to EXCEPTION_RECORD to drive some 
Windows-specific crash reporting code, so I'll take another look at how that 
might be done...

> * As for stack_t, we have that.  It's defined in newlib's sys/signal.h.
>    The stack base and stack size can be fetched from the TEB; with a
>    test for a user-defined stack, see pthread_wrapper in miscfuncs.cc.
> 
>    While we're at it we should contemplate to define SIGSTKSZ and
>    MINSIGSTKSZ along the lines of 64K, I guess.

For the moment, I have omitted the POSIX-required uc_link, uc_sigmask and 
uc_stack members from ucontext_t. They can be added when I understand how to 
give them meaningful values.

Jon TURNEY (2):
  Rename struct ucontext to struct mcontext
  Make CONTEXT available to signal handlers

 winsup/cygwin/ChangeLog               | 12 ++++++++++++
 winsup/cygwin/exceptions.cc           | 13 +++++++++++--
 winsup/cygwin/include/cygwin/signal.h | 16 +++++++++-------
 winsup/cygwin/include/sys/ucontext.h  | 22 ++++++++++++++++++++++
 winsup/cygwin/include/ucontext.h      | 16 ++++++++++++++++
 5 files changed, 70 insertions(+), 9 deletions(-)
 create mode 100644 winsup/cygwin/include/sys/ucontext.h
 create mode 100644 winsup/cygwin/include/ucontext.h

-- 
2.1.4
