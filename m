Return-Path: <cygwin-patches-return-4163-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31597 invoked by alias); 4 Sep 2003 04:00:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31575 invoked from network); 4 Sep 2003 04:00:03 -0000
Date: Thu, 04 Sep 2003 04:00:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] nanosleep()
Message-ID: <20030904040002.GA14598@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030903232651.00814100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030903232651.00814100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00179.txt.bz2

On Wed, Sep 03, 2003 at 11:26:51PM -0400, Pierre A. Humblet wrote:
>This patch to nanosleep, sleep and usleep 
>a) makes them Posix conformant: the system clock (gettimeofday) must 
>   advance by at least d during Xsleep(d) 
>  (e.g. exim relies on this to create unique ids).

And it doesn't, do that now, because...?

>b) improves the resolution of the result by using the multimedia 
>   timer. 

And it does that how...?

>c) calls timeBeginPeriod in forked processes.

This one at least doesn't deserve a discussion.  Or does it?  Is
timeBeginPeriod necessary in a forked process?

Large patches with lots of reorganization and minimal explanation about
why are quite time consuming to review.  This is why on most patches
list the usual rule is one patch per concept.  I meant to mention this
after your massive signal patch.

For instance, c) above is a concept.  It could probably have been a
separate patch.

So, I would appreciate it if you could break this down into separate
concepts and explain the concepts as you go along.  Call me selfish, but
it reduces my workload to have you explain what you are doing in bite
size chunks so that I don't have to spend a lot of time trying to
separate out your patch into separate issues myself.

cgf

>2003-09-03  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* hires.h (_DELAY_MAX): Define.
>	(hires_ms::minperiod): Declare static.
>	(hires_ms::resolution): New.
>	(hires_ms::dmsecs): New.
>	(hires_ms::~hires_ms): Delete.
> 	(gtod): Declare. 
>	* time.c (hires_ms::prime): Always calculate minperiod and 
>	set it to 1 in case of failure.
>	(hires_ms::resolution): Define.
>	(hires_ms::~hires_ms): Delete.
>	(hires_ms::usecs): Check minperiod to prime.
>	(gtod) Define.
>	* signal.cc (nanosleep): Round delay up to resolution.
>	Fix test for negative remainder. Use timeGetTime through gtod.
>	(sleep): Round up return value.
