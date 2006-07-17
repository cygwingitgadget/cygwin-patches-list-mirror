Return-Path: <cygwin-patches-return-5924-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25262 invoked by alias); 17 Jul 2006 20:47:44 -0000
Received: (qmail 25242 invoked by uid 22791); 17 Jul 2006 20:47:44 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 17 Jul 2006 20:47:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 07F6454C004; Mon, 17 Jul 2006 22:47:39 +0200 (CEST)
Date: Mon, 17 Jul 2006 20:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: allow read into untouched noreserve mappings
Message-ID: <20060717204739.GA27029@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0607121318080.2284@PC1163-8460-XP.flightsafety.com> <20060712202215.GS8759@calimero.vinschen.de> <Pine.CYG.4.58.0607121536330.3784@PC1163-8460-XP.flightsafety.com> <20060713103431.GA17383@calimero.vinschen.de> <Pine.CYG.4.58.0607130933400.1164@PC1163-8460-XP.flightsafety.com> <Pine.CYG.4.58.0607131315110.3316@PC1163-8460-XP.flightsafety.com> <20060714091601.GD8759@calimero.vinschen.de> <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com> <20060714155523.GL8759@calimero.vinschen.de> <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00019.txt.bz2

On Jul 17 12:25, Brian Ford wrote:
> On Fri, 14 Jul 2006, Corinna Vinschen wrote:
> 
> > The idea is to have features working for most cases and then
> > to get it working gradually better.
> 
> Well, in that spirit then, the attached patch allows read and varients to
> use untouched noreserve mappings as buffers.  If this is accepted, I'll
> consider doing something similar for recvmsg and recvfrom.  That should
> cover the majority of cases, I believe.
> 
> 2006-07-17  Brian Ford  <Brian.Ford@FlightSafety.com>
> 
> 	* winsup.h (mmap_commit_noreserve_pages): New prototype.
> 	* mmap.cc (fhandler_base::raw_read): New function.
> 	* fhandler.cc (fhandler_base::raw_read): Call it for
> 	INVALID_PARAMETER errors, and retry on success to allow
> 	reads into untouched MAP_NORESERVE buffers.

Sorry but... ERROR_INVALID_PARAMETER?  When I debugged this I got
ERROR_NOACCESS.  What system was that running on?

I would rather see the mmap_commit_noreserve_pages functionality folded
into the existing mmap_is_attached_or_noreserve_page function (add
parameter, see if len == 0 or > 0, yada yada yada) so that there's
only one function which does the work, regardless from where it's called.

Other than that it looks like a good start.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
