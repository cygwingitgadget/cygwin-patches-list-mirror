Return-Path: <cygwin-patches-return-7438-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19646 invoked by alias); 20 Jul 2011 09:51:19 -0000
Received: (qmail 19636 invoked by uid 22791); 20 Jul 2011 09:51:18 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-yw0-f43.google.com (HELO mail-yw0-f43.google.com) (209.85.213.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 20 Jul 2011 09:50:46 +0000
Received: by ywt2 with SMTP id 2so20251ywt.2        for <cygwin-patches@cygwin.com>; Wed, 20 Jul 2011 02:50:45 -0700 (PDT)
Received: by 10.236.187.66 with SMTP id x42mr11256266yhm.86.1311155445405;        Wed, 20 Jul 2011 02:50:45 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id c69sm8105yhm.29.2011.07.20.02.50.43        (version=SSLv3 cipher=OTHER);        Wed, 20 Jul 2011 02:50:44 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Wed, 20 Jul 2011 09:51:00 -0000
In-Reply-To: <1311153377.7796.66.camel@YAAKOV04>
References: <1311126880.7796.9.camel@YAAKOV04>		 <20110720075654.GA3667@calimero.vinschen.de>	 <1311153377.7796.66.camel@YAAKOV04>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1311155453.7796.70.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00014.txt.bz2

On Wed, 2011-07-20 at 04:16 -0500, Yaakov (Cygwin/X) wrote:
> On Wed, 2011-07-20 at 09:56 +0200, Corinna Vinschen wrote:
> > This doesn't look right.  In contrast to nanosleep, clock_nanosleep
> > is not subsumed under the _POSIX_TIMERS option.  In fact it's the only
> > function under the _POSIX_CLOCK_SELECTION option.
> 
> I did some searching, and there are actually two more:
> 
> http://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_condattr_getclock.html
> 
> The behaviour of the following functions are also affected by this
> option:
> 
> http://pubs.opengroup.org/onlinepubs/009695399/functions/clock_getres.html
> http://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_cond_wait.html
> 
> (It should be noted that the Clock Selection option was merged into the
> Base with POSIX.1-2008.)
> 
> How should we proceed now?

Actually, no need to panic, I took a closer look at this, and it's not
all that hard at all, so I'll go ahead and implement
pthread_condattr_[gs]etclock() as well.  Just give me a day or two to
get it done.  In the meantime, I'll proceed with the revised newlib
patch.


Yaakov

