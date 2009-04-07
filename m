Return-Path: <cygwin-patches-return-6496-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25410 invoked by alias); 7 Apr 2009 17:24:30 -0000
Received: (qmail 25383 invoked by uid 22791); 7 Apr 2009 17:24:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 17:24:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 531AB6D5596; Tue,  7 Apr 2009 19:24:07 +0200 (CEST)
Date: Tue, 07 Apr 2009 17:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090407172407.GD852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49D70B05.6020509@gmail.com> <20090407144659.GA22338@ednor.casa.cgf.cx> <49DB69BE.80203@cwilson.fastmail.fm> <20090407150810.GF22338@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090407150810.GF22338@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00038.txt.bz2

On Apr  7 11:08, Christopher Faylor wrote:
> On Tue, Apr 07, 2009 at 10:57:02AM -0400, Charles Wilson wrote:
> >Christopher Faylor wrote:
> >> I don't entirely understand when people think it's ok to make sweeping
> >> changes for 1.7 and when they think we need to be conservative.
> >
> >MHO is that 1.7+gcc4 is already such a sweeping change (e.g.
> >"conservative" left the building sometime last year), that if we DO plan
> >on any more such sweeping changes before cygwin2.dll it's better to do
> >'em now.
> >
> >OTOH, if we DON'T actually plan on any more such changes, then there's
> >no reason to make changes gratuitously, no matter how Just Mean We Are.
> >
> >> I think it is very regrettable that Cygwin doesn't have the same int
> >> types as linux and it would be interesting to see how much would be
> >> broken by changing these types.
> >
> >"Interesting" in the sense of the old Chinese curse [*], I assume?
> 
> Or as in the "WJM" aforementioned sense.

Sounds like "WJM" matches exactly what my patch does.  I've checked it in.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
