Return-Path: <cygwin-patches-return-7177-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5100 invoked by alias); 10 Feb 2011 09:55:49 -0000
Received: (qmail 5070 invoked by uid 22791); 10 Feb 2011 09:55:41 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 10 Feb 2011 09:55:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 03C0C2CA2C0; Thu, 10 Feb 2011 10:55:31 +0100 (CET)
Date: Thu, 10 Feb 2011 09:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: provide __xpg_strerror_r
Message-ID: <20110210095530.GC2305@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D4DAD40.3060904@redhat.com> <20110205202806.GA11118@ednor.casa.cgf.cx> <4D4DB682.3070601@redhat.com> <20110206095423.GA19356@calimero.vinschen.de> <4D532F6B.5080104@redhat.com> <20110210021547.GA26395@ednor.casa.cgf.cx> <20110210095054.GA2305@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110210095054.GA2305@calimero.vinschen.de>
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
X-SW-Source: 2011-q1/txt/msg00032.txt.bz2

On Feb 10 10:50, Corinna Vinschen wrote:
> On Feb  9 21:15, Christopher Faylor wrote:
> > On Wed, Feb 09, 2011 at 05:20:59PM -0700, Eric Blake wrote:
> > >+/* Newlib's <string.h> provides declarations for two strerror_r
> > >+   variants, according to preprocessor feature macros.  It does the
> > >+   right thing for GNU strerror_r, but its __xpg_strerror_r mishandles
> > >+   a case of EINVAL when coupled with our strerror() override.*/
> > > #if 0
> > 
> > Can't we get rid of this now?
> 
> I agree.  We should simply implement strerror_r by ourselves, even if
> it's identical to newlib's strerror_r.  In the long run it's less
> puzzeling to have all the strerror variants in one place.

Oh, and: http://cygwin.com/ml/cygwin-patches/2011-q1/msg00031.html


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
