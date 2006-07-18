Return-Path: <cygwin-patches-return-5927-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17794 invoked by alias); 18 Jul 2006 14:07:14 -0000
Received: (qmail 17672 invoked by uid 22791); 18 Jul 2006 14:07:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 18 Jul 2006 14:07:08 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id F0D8854C004; Tue, 18 Jul 2006 16:07:04 +0200 (CEST)
Date: Tue, 18 Jul 2006 14:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: allow read into untouched noreserve mappings
Message-ID: <20060718140704.GC27029@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0607121536330.3784@PC1163-8460-XP.flightsafety.com> <20060713103431.GA17383@calimero.vinschen.de> <Pine.CYG.4.58.0607130933400.1164@PC1163-8460-XP.flightsafety.com> <Pine.CYG.4.58.0607131315110.3316@PC1163-8460-XP.flightsafety.com> <20060714091601.GD8759@calimero.vinschen.de> <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com> <20060714155523.GL8759@calimero.vinschen.de> <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com> <20060717204739.GA27029@calimero.vinschen.de> <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0607171732120.1780@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00022.txt.bz2

On Jul 17 17:54, Brian Ford wrote:
> Untested this time because I have to run to an appointment.
> 
> 2006-07-17  Brian Ford  <Brian.Ford@FlightSafety.com>
> 
> 	* winsup.h (mmap_region_status): New enum.
> 	(mmap_is_attached_or_noreserve_page): Adjust prototype and rename
> 	as below.
> 	* mmap.cc (mmap_is_attached_or_noreserve_page):  Rename
> 	mmap_is_attached_or_noreserve.  Add region length parameter.
> 	Return enum above.
> 	* exceptions.cc (_cygtls::handle_exceptions): Accomodate above.
> 	* fhandler.cc (fhandler_base::raw_read): Call above for NOACCESS
> 	errors and retry on success to allow reads into untouched
> 	MAP_NORESERVE buffers.

I applied your patch to the cv-branch with some changes.  The way you
are calling search_record (see there)

> +      long record_idx = map_list->search_record ((caddr_t)addr, 1,
> +						 u_addr, u_len, -1);

always returns a u_len of 1. The result is that for each page in memory,
the loop runs 4096 times in the worst case.  I added the necessary
alignment stuff and minimized the number of calls to VirtualAlloc.

Don't be surprised that I now used getpagesize() instead of
getsystempagesize ().  I mulled over this a while.  The idea is that the
application expects a page size of 64K, not 4K.  So the functionality
makes most sense if it assumes 64K pages, too.  This also minimizes the
number of necessary calls to mmap_is_attached_or_noreserve_page, which
is a good thing, IMO.

Thanks for the patch.  It's available for further digestion and patches
in the cv-branch.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
