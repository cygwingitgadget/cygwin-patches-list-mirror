Return-Path: <cygwin-patches-return-5930-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21347 invoked by alias); 18 Jul 2006 18:24:26 -0000
Received: (qmail 21332 invoked by uid 22791); 18 Jul 2006 18:24:25 -0000
X-Spam-Check-By: sourceware.org
Received: from Unknown (HELO mailgw03.flightsafety.com) (66.109.93.20)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 18 Jul 2006 18:24:12 +0000
Received: from mailgw03.flightsafety.com (localhost [127.0.0.1]) 	by mailgw03.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6IIM9JK007982 	for <cygwin-patches@cygwin.com>; Tue, 18 Jul 2006 13:22:09 -0500 (CDT)
Received: from dradmast.flightsafety.com ([192.168.93.130]) 	by mailgw03.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6IIM7wA007964 	for <cygwin-patches@cygwin.com>; Tue, 18 Jul 2006 13:22:08 -0500 (CDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by dradmast.flightsafety.com with Microsoft SMTPSVC(6.0.3790.211); 	 Tue, 18 Jul 2006 13:22:32 -0500
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Tue, 18 Jul 2006 11:59:04 -0500
Date: Tue, 18 Jul 2006 18:24:00 -0000
From: Brian Ford <Brian.Ford@FlightSafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: allow read into untouched noreserve mappings
In-Reply-To: <20060718140704.GC27029@calimero.vinschen.de>
Message-ID: <Pine.CYG.4.58.0607181132320.3164@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0607121536330.3784@PC1163-8460-XP.flightsafety.com>  <20060713103431.GA17383@calimero.vinschen.de>  <Pine.CYG.4.58.0607130933400.1164@PC1163-8460-XP.flightsafety.com>  <Pine.CYG.4.58.0607131315110.3316@PC1163-8460-XP.flightsafety.com>  <20060714091601.GD8759@calimero.vinschen.de>  <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com>  <20060714155523.GL8759@calimero.vinschen.de>  <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com>  <20060717204739.GA27029@calimero.vinschen.de>  <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com>  <20060718140704.GC27029@calimero.vinschen.de>
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
X-SW-Source: 2006-q3/txt/msg00025.txt.bz2

Appologies for the previous message being un-timely.  We had a network
outage, and it got queued before your response.

On Tue, 18 Jul 2006, Corinna Vinschen wrote:

> I applied your patch to the cv-branch with some changes.  The way you
> are calling search_record (see there)
>
> > +      long record_idx = map_list->search_record ((caddr_t)addr, 1,
> > +						 u_addr, u_len, -1);
>
> always returns a u_len of 1.  The result is that for each page in
> memory, the loop runs 4096 times in the worst case.

I see that now :-(.

I confess to not understanding the purpose and inner workings of either
search_record implementation.  I first tried the two parameter version,
but then realized it was searching through file offsets rather than map
addresses (what is that usefull for?).

What I wanted was a function that returned the mmap record for an
arbitrary address [range].  That seems pretty basic.  Why is there not
such a thing?

> I added the necessary alignment stuff

See, I don't understand why every caller should need to do "the necessary
alignment stuff"?

> and minimized the number of calls to VirtualAlloc.

Yeah, that was the concept I was going for.  Find the map that this
address belongs to, commit the smaller of the address range for the region
or the map, repeat while there is still an uncommitted address range.

> Don't be surprised that I now used getpagesize() instead of
> getsystempagesize ().  I mulled over this a while.  The idea is that the
> application expects a page size of 64K, not 4K.  So the functionality
> makes most sense if it assumes 64K pages, too.  This also minimizes the
> number of necessary calls to mmap_is_attached_or_noreserve_page, which
> is a good thing, IMO.

I know this dichotomy has been discussed at length before and there
doesn't seem to be any win-win compromise.  I'm not sure if I agree or not
*shrug*, but my opinion doesn't matter much anyway.

One minor nit though, this stuff could be moved after the check for an
empty mmap region list.

> Thanks for the patch.  It's available for further digestion and patches
> in the cv-branch.

I guess it'll be a while then before this hits a release then :-(.  Thanks
for applying anyway.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...
