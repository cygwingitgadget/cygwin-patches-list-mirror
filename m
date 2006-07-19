Return-Path: <cygwin-patches-return-5934-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20515 invoked by alias); 19 Jul 2006 15:12:16 -0000
Received: (qmail 20504 invoked by uid 22791); 19 Jul 2006 15:12:15 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw03.flightsafety.com (HELO mailgw03.flightsafety.com) (66.109.93.20)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Jul 2006 15:12:00 +0000
Received: from mailgw03.flightsafety.com (localhost [127.0.0.1]) 	by mailgw03.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6JFA44l016946 	for <cygwin-patches@cygwin.com>; Wed, 19 Jul 2006 10:10:04 -0500 (CDT)
Received: from xgate2k3.flightsafety.com ([192.168.31.134]) 	by mailgw03.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6JFA3pg016938 	for <cygwin-patches@cygwin.com>; Wed, 19 Jul 2006 10:10:04 -0500 (CDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by xgate2k3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 19 Jul 2006 11:12:13 -0400
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 19 Jul 2006 10:12:12 -0500
Date: Wed, 19 Jul 2006 15:12:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: allow read into untouched noreserve mappings
In-Reply-To: <20060718201228.GG27029@calimero.vinschen.de>
Message-ID: <Pine.CYG.4.58.0607190957540.3164@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0607130933400.1164@PC1163-8460-XP.flightsafety.com>  <Pine.CYG.4.58.0607131315110.3316@PC1163-8460-XP.flightsafety.com>  <20060714091601.GD8759@calimero.vinschen.de>  <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com>  <20060714155523.GL8759@calimero.vinschen.de>  <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com>  <20060717204739.GA27029@calimero.vinschen.de>  <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com>  <20060718140704.GC27029@calimero.vinschen.de>  <Pine.CYG.4.58.0607181132320.3164@PC1163-8460-XP.flightsafety.com>  <20060718201228.GG27029@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00029.txt.bz2

On Tue, 18 Jul 2006, Corinna Vinschen wrote:

> On Jul 18 11:59, Brian Ford wrote:
> > I confess to not understanding the purpose and inner workings of either
> > search_record implementation.  I first tried the two parameter version,
> > but then realized it was searching through file offsets rather than map
> > addresses (what is that usefull for?).
>
> The answer is in list::try_map.  It tries to find a suitable, unused
> record which can be reused for another mapping.  The idea here is to
> accomodate old, non-standard implementations which assume that two
> consecutive mappings are using consecutive pages in memory.  An example
> are old autoconf tests.  This was more of a problem when getpagesize()
> was 4K.  Today it will only be used on 9x due to the alignment bug I'm
> referring to in mmap64.

Thanks for the constructive information; it is greatly appreciated.  I
don't totally understand it yet, but I'll study it.

> > On Tue, 18 Jul 2006, Corinna Vinschen wrote:
> > > Don't be surprised that I now used getpagesize() instead of
> > > getsystempagesize ().  [...]
> >
> > I know this dichotomy has been discussed at length before and there
> > doesn't seem to be any win-win compromise.  I'm not sure if I agree or not
> > *shrug*, but my opinion doesn't matter much anyway.
>
> You know the problem of page size vs. allocation granularity, right?
> I was fighting for keeping the page size in Cygwin at 4K for a long time
> but at one point it got just too awkward to support it any longer,
> so I gave up.  There's really no reason to go through this once again.

Yes, exactly.  I was trying to acknowledge that.

I was thinking this was just an internal detail of an extension that
was trying to minimize swap usage and therefor smaller with more faults
was better.  After sleeping on it, I'm even less sure of that stance now.

> > One minor nit though, this stuff could be moved after the check for an
> > empty mmap region list.
>
> Indeed.  But, hey, this is the cygwin-patches list.  Just provide a
> patch!

I wasn't sure that minor nits and code rearrangements would be accepted as
patches, or would just be considered insulting.  If the former, I would be
happy to submit patches that IMHO make the code more readable as I try to
understand it myself.  (Things like assignments inside conditionals and
repeated function calls, even if they are inlined, make it harder for me
to see what's going on.)

> > I guess it'll be a while then before this hits a release then :-(.  Thanks
> > for applying anyway.
>
> Sure.  The branch will be folded back into the main line after 1.5.21
> has been released which will be very soon.

Great, thanks!  And now back to patches only :-).

If anyone would like to reply off list, that would be fine with me.
Thanks.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...
