Return-Path: <cygwin-patches-return-7446-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10716 invoked by alias); 21 Jul 2011 10:39:20 -0000
Received: (qmail 10622 invoked by uid 22791); 21 Jul 2011 10:38:25 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 21 Jul 2011 10:37:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1C8082CAEA5; Thu, 21 Jul 2011 12:37:35 +0200 (CEST)
Date: Thu, 21 Jul 2011 10:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2)
Message-ID: <20110721103735.GJ15150@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311126880.7796.9.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00022.txt.bz2

On Jul 19 20:54, Yaakov (Cygwin/X) wrote:
> This patchset implements the POSIX clock_nanosleep(2) function:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_nanosleep.html
> http://www.kernel.org/doc/man-pages/online/pages/man2/clock_nanosleep.2.html
> 
> In summary, clock_nanosleep(2) replaces nanosleep(2) as the primary
> sleeping function, with all others rewritten in terms of the former.  It
> also restores maximum precision to hires_ms::resolution(), saving the
> <5000 100ns check for the one place where resolution is rounded off.
> 
> Patches for newlib, winsup/cygwin, and winsup/doc attached.  I would
> appreciate a careful look at this one.

Given our current discussion to change cancelable_wait, does it make
sense to review this patch?  AFAICs the clock_nanosleep function will
have to be changes quite a bit, right?

Something else occured to me, but I think we should do this in an extra
step, if at all.  IMO the family of sleep functions should be moved out
of signal.cc into times.cc.  It just seems to belong there.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
