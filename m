Return-Path: <cygwin-patches-return-7437-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12991 invoked by alias); 20 Jul 2011 09:16:25 -0000
Received: (qmail 12977 invoked by uid 22791); 20 Jul 2011 09:16:25 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 20 Jul 2011 09:16:11 +0000
Received: by yxk38 with SMTP id 38so11523yxk.2        for <cygwin-patches@cygwin.com>; Wed, 20 Jul 2011 02:16:10 -0700 (PDT)
Received: by 10.236.170.197 with SMTP id p45mr2582617yhl.522.1311153368961;        Wed, 20 Jul 2011 02:16:08 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id c63sm5159122yhe.46.2011.07.20.02.16.07        (version=SSLv3 cipher=OTHER);        Wed, 20 Jul 2011 02:16:08 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Wed, 20 Jul 2011 09:16:00 -0000
In-Reply-To: <20110720075654.GA3667@calimero.vinschen.de>
References: <1311126880.7796.9.camel@YAAKOV04>	 <20110720075654.GA3667@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1311153377.7796.66.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00013.txt.bz2

On Wed, 2011-07-20 at 09:56 +0200, Corinna Vinschen wrote:
> This doesn't look right.  In contrast to nanosleep, clock_nanosleep
> is not subsumed under the _POSIX_TIMERS option.  In fact it's the only
> function under the _POSIX_CLOCK_SELECTION option.

I did some searching, and there are actually two more:

http://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_condattr_getclock.html

The behaviour of the following functions are also affected by this
option:

http://pubs.opengroup.org/onlinepubs/009695399/functions/clock_getres.html
http://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_cond_wait.html

(It should be noted that the Clock Selection option was merged into the
Base with POSIX.1-2008.)

How should we proceed now?


Yaakov

