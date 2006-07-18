Return-Path: <cygwin-patches-return-5931-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23820 invoked by alias); 18 Jul 2006 20:12:35 -0000
Received: (qmail 23809 invoked by uid 22791); 18 Jul 2006 20:12:33 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 18 Jul 2006 20:12:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E21C654C004; Tue, 18 Jul 2006 22:12:28 +0200 (CEST)
Date: Tue, 18 Jul 2006 20:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: allow read into untouched noreserve mappings
Message-ID: <20060718201228.GG27029@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0607130933400.1164@PC1163-8460-XP.flightsafety.com> <Pine.CYG.4.58.0607131315110.3316@PC1163-8460-XP.flightsafety.com> <20060714091601.GD8759@calimero.vinschen.de> <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com> <20060714155523.GL8759@calimero.vinschen.de> <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com> <20060717204739.GA27029@calimero.vinschen.de> <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com> <20060718140704.GC27029@calimero.vinschen.de> <Pine.CYG.4.58.0607181132320.3164@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0607181132320.3164@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00026.txt.bz2

On Jul 18 11:59, Brian Ford wrote:
> On Tue, 18 Jul 2006, Corinna Vinschen wrote:
> > I applied your patch to the cv-branch with some changes.  The way you
> > are calling search_record (see there)
> >
> > > +      long record_idx = map_list->search_record ((caddr_t)addr, 1,
> > > +						 u_addr, u_len, -1);
> >
> > always returns a u_len of 1.  The result is that for each page in
> > memory, the loop runs 4096 times in the worst case.
> 
> I see that now :-(.
> 
> I confess to not understanding the purpose and inner workings of either
> search_record implementation.  I first tried the two parameter version,
> but then realized it was searching through file offsets rather than map
> addresses (what is that usefull for?).

The answer is in list::try_map.  It tries to find a suitable, unused
record which can be reused for another mapping.  The idea here is to
accomodate old, non-standard implementations which assume that two
consecutive mappings are using consecutive pages in memory.  An example
are old autoconf tests.  This was more of a problem when getpagesize()
was 4K.  Today it will only be used on 9x due to the alignment bug I'm
referring to in mmap64.

> What I wanted was a function that returned the mmap record for an
> arbitrary address [range].  That seems pretty basic.  Why is there not
> such a thing?
> 
> > I added the necessary alignment stuff
> 
> See, I don't understand why every caller should need to do "the necessary
> alignment stuff"?

It's simply working as designed.  Did I claim somewhere that the code is
perfect?  I don't think so.  If you have a better or more elegant
solution, provide a patch.  It's as easy as that.

> > and minimized the number of calls to VirtualAlloc.
> 
> Yeah, that was the concept I was going for.  Find the map that this
> address belongs to, commit the smaller of the address range for the region
> or the map, repeat while there is still an uncommitted address range.

You don't have to apologize.  You did that, just the search_record call
was incorrect.  To find this requires some debugging, that's all.

> > Don't be surprised that I now used getpagesize() instead of
> > getsystempagesize ().  [...]
> 
> I know this dichotomy has been discussed at length before and there
> doesn't seem to be any win-win compromise.  I'm not sure if I agree or not
> *shrug*, but my opinion doesn't matter much anyway.

You know the problem of page size vs. allocation granularity, right?
I was fighting for keeping the page size in Cygwin at 4K for a long time
but at one point it got just too awkward to support it any longer,
so I gave up.  There's really no reason to go through this once again.

> One minor nit though, this stuff could be moved after the check for an
> empty mmap region list.

Indeed.  But, hey, this is the cygwin-patches list.  Just provide a
patch!

> > Thanks for the patch.  It's available for further digestion and patches
> > in the cv-branch.
> 
> I guess it'll be a while then before this hits a release then :-(.  Thanks
> for applying anyway.

Sure.  The branch will be folded back into the main line after 1.5.21
has been released which will be very soon.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
