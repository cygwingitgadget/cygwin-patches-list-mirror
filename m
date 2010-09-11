Return-Path: <cygwin-patches-return-7094-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15890 invoked by alias); 11 Sep 2010 00:20:39 -0000
Received: (qmail 15875 invoked by uid 22791); 11 Sep 2010 00:20:38 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-wy0-f171.google.com (HELO mail-wy0-f171.google.com) (74.125.82.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Sep 2010 00:20:32 +0000
Received: by wyb29 with SMTP id 29so3787153wyb.2        for <cygwin-patches@cygwin.com>; Fri, 10 Sep 2010 17:20:30 -0700 (PDT)
Received: by 10.227.128.201 with SMTP id l9mr440993wbs.22.1284164429795;        Fri, 10 Sep 2010 17:20:29 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.5-4.cable.virginmedia.com [82.6.108.62])        by mx.google.com with ESMTPS id i14sm2748940wbe.0.2010.09.10.17.20.28        (version=SSLv3 cipher=RC4-MD5);        Fri, 10 Sep 2010 17:20:28 -0700 (PDT)
Message-ID: <4C8AD089.9000605@gmail.com>
Date: Sat, 11 Sep 2010 00:20:00 -0000
From: Dave Korn <dave.korn.cygwin@gmail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add fenv.h and support.
References: <4C8A9AC8.7070904@gmail.com> <20100910214347.GA23700@ednor.casa.cgf.cx>
In-Reply-To: <20100910214347.GA23700@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00054.txt.bz2

On 10/09/2010 22:43, Christopher Faylor wrote:

> Looks nice to me with one HUGE caveat:  Please maintain the pseudo-sorted
> order in cygwin.din.  Sorry to have to impose this burden on you.

  No, that's fine; I've never been sure whether we need to care about the
ordinal numbers or not in that file.  (AFAIK, we don't have any realistic
scenarios where anyone would be linking against the Cygwin DLL by ordinal
imports, but I hate making assumptions based only on my own limited experience...)

> Other than that, please check in and thanks for the patch.  It was obviously
> a lot of work.

  Heh, actually not all that much.  I had one of those in-the-zone moments and
did both this and the gnu ld plugin infrastructure in one ~20h no-sleep coding
binge, then spent another few hours tidying it up after I'd slept a bit!

  So, I'll fix the cygwin.din and check in shortly.  Thanks for reviewing.

  (BTW, the request for advice re: automated compliance checking stands; I
would really like to run some proper formal testsuites against this, even if
they don't fully work on Cygwin.  Eric, surely you've looked at this stuff?  I
was certainly hoping so, anyway!)

    cheers,
      DaveK
