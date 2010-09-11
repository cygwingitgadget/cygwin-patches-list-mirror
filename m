Return-Path: <cygwin-patches-return-7097-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7288 invoked by alias); 11 Sep 2010 08:09:49 -0000
Received: (qmail 7255 invoked by uid 22791); 11 Sep 2010 08:09:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sat, 11 Sep 2010 08:09:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A06816D435B; Sat, 11 Sep 2010 10:09:29 +0200 (CEST)
Date: Sat, 11 Sep 2010 08:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add fenv.h and support.
Message-ID: <20100911080929.GL16534@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C8A9AC8.7070904@gmail.com> <20100910214347.GA23700@ednor.casa.cgf.cx> <4C8AD089.9000605@gmail.com> <20100911051009.GA25209@ednor.casa.cgf.cx> <4C8B2B9B.8060801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C8B2B9B.8060801@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00057.txt.bz2

Hi Dave,

On Sep 11 08:11, Dave Korn wrote:
> On 11/09/2010 06:10, Christopher Faylor wrote:
> > On Sat, Sep 11, 2010 at 01:42:49AM +0100, Dave Korn wrote:
> >> On 10/09/2010 22:43, Christopher Faylor wrote:
> >>
> >>> Looks nice to me with one HUGE caveat:  Please maintain the pseudo-sorted
> >>> order in cygwin.din.  Sorry to have to impose this burden on you.
> >>  No, that's fine; I've never been sure whether we need to care about the
> >> ordinal numbers or not in that file.  (AFAIK, we don't have any realistic
> >> scenarios where anyone would be linking against the Cygwin DLL by ordinal
> >> imports, but I hate making assumptions based only on my own limited experience...)
> > 
> > It never even occurred to me about ordinal numbers but since I've been
> > reorganizing that file for years I guess it hasn't been a problem.
> 
>   I checked.  Something somewhere sorts all the exports it turns out, so they
> all get ordinals assigned in alphanumeric sort order anyway, regardless of
> cygwin.din order.  So, I ended up committing it like so:

Can you please add some words to doc/new-features.sgml?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
