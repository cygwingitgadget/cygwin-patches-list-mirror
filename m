Return-Path: <cygwin-patches-return-6187-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31172 invoked by alias); 11 Dec 2007 16:24:01 -0000
Received: (qmail 31155 invoked by uid 22791); 11 Dec 2007 16:24:00 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 11 Dec 2007 16:23:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id AB59F6D4811; Tue, 11 Dec 2007 17:23:52 +0100 (CET)
Date: Tue, 11 Dec 2007 16:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygheap page boundary allocation bug.
Message-ID: <20071211162352.GA10441@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM> <20071211141852.GA3619@ednor.casa.cgf.cx> <0b1e01c83c01$cb11e2c0$2e08a8c0@CAM.ARTIMI.COM> <20071211143847.GA3719@ednor.casa.cgf.cx> <0b2301c83c09$f075e6d0$2e08a8c0@CAM.ARTIMI.COM> <20071211153658.GB9398@calimero.vinschen.de> <0b2a01c83c0e$2b025140$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b2a01c83c0e$2b025140$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00039.txt.bz2

On Dec 11 15:54, Dave Korn wrote:
> On 11 December 2007 15:37, Corinna Vinschen wrote:
> 
> > On Dec 11 15:24, Dave Korn wrote:
> >>   Applied, thanks.  (Found some problems in w32api's wincrypt.h which I'll
> >> report to mingw list later today.  Appears to have been there for at least
> >> a fortnight.  Am I the only one who builds with WINVER >= 0x0501?)
> > 
> > Unlikely but possible.  Cygwin is using _WIN32_WINNT=0x0501 in winsup.h
> > and it doesn't have a build problem.
> 
> 
>   AFAICT, there's no way on earth that what's in cvs could possibly compile.  It
> uses the PCERT_POLICY_MAPPING structure typedef for a member of another struct
> before it (PCERT_POLICY_MAPPING) has been defined.  There's also an undefined
> type referenced in one of the function prototypes.  I had to do this:
> [...]
> before I could build winsup.  Dunno why it's not affecting everyone else too.

I know why I had no problem.  I didn't update my local copy of w32api
for a while.  Now that I updated I'm stuck like you are.  Please apply
your patch (at least as a stop-gap measure) for now and, if you don't
mind, discuss it on the mingw list.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
