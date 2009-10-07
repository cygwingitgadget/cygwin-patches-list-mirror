Return-Path: <cygwin-patches-return-6738-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29316 invoked by alias); 7 Oct 2009 07:50:03 -0000
Received: (qmail 29253 invoked by uid 22791); 7 Oct 2009 07:50:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 07:49:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3B6A96D5598; Wed,  7 Oct 2009 09:49:46 +0200 (CEST)
Date: Wed, 07 Oct 2009 07:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Merge pseudo-reloc-v2 support from mingw/pseudo-reloc.c
Message-ID: <20091007074946.GA27186@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACBD892.5040508@cwilson.fastmail.fm> <4ACBDD83.6080307@cwilson.fastmail.fm> <20091007030342.GA13923@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091007030342.GA13923@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00069.txt.bz2

On Oct  6 23:03, Christopher Faylor wrote:
> On Tue, Oct 06, 2009 at 08:14:59PM -0400, Charles Wilson wrote:
> >I just figured it made sense to split up the ChangeLog, because I didn't
> >want to take credit for Kai's changes, but I did want to document what I
> >did, beyond the mingw/ version (which should make it easier when I
> >submit THOSE changes back to the mingw folks).  Furthermore, I figure
> >somebody might scan the ChangeLog looking for people without a Red Hat
> >copyright assignment, and get nervous if they saw:
> >
> >date  Charles Wilson  <...>  <<--- has assignment
> >      Kai Teitz  <...>       <<--- no assignment (?)
> >
> >      A bunch of changes
> >
> >The way I split the ChangeLog up, it is clear that Kai only touched the
> >public domain file.
> >
> >Anyway, once I had split up the ChangeLog, I simply wondered if I should
> >/also/ split up the commits.  If you're happy with one-big-lump, so am I
> >-- that's easier.
> 
> I think this one is Corinna's call.

Make the checkin and the ChangeLog one lump.  The ChangeLog entry is
about the work done to put this stuff into Cygwin, which was your work.
Don't repeat the mingw entry, rather just say that you imported from
there and credit Kai with that entry.

Something like this.  Just subsume three paragraphs in one single
ChangeLog entry:

  2009-99-99  Charles "Pseudo-Reloc" Wilson  <...>

  	Additional pseudo-reloc-v2 support.
	* ntdll.h: [...]

	Cygwin modifications to pseudo-reloc.c.
	* lib/pseudo-reloc.c: [...]

	* lib/pseudo-reloc.c: Import new implementation to support
	v2 pseudo-relocs implemented by Kai Tietz from mingw.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
