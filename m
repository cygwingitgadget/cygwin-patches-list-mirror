Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3B3DA3858D20; Thu, 27 Mar 2025 11:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3B3DA3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743074646;
	bh=QHsBCXMAQlO97eck0ESDcQLAZLujwWBeaRlqItvWuwA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=BcdtnjXcxtngH2Wbq/T8tWIPcbgmKixvQWWuqxCrPaYXe5c1n6x0WeqLkaYMSBZEo
	 98aKZWRfuJH8ap5b9M1YnKg3T10DFYLEdAEHt46BQZSJRNhlxUnGALdCPiEuTNdXGu
	 UgovSdXV9uPCf+yQskSetXxHpgSmgg+JL4Vg401M=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2BBF8A806F0; Thu, 27 Mar 2025 12:24:04 +0100 (CET)
Date: Thu, 27 Mar 2025 12:24:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/4] Cygwin: vendor libudis86 1.7.2
Message-ID: <Z-U1VLWv5QfAkaqy@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f86ec933-b668-cce8-701a-0484b69aca50@jdrake.com>
 <Z-Eyyg3c3Jvs23rf@calimero.vinschen.de>
 <5c943d20-1aa9-bc9b-5a6e-8174b0184a95@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c943d20-1aa9-bc9b-5a6e-8174b0184a95@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 26 10:49, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 24 Mar 2025, Corinna Vinschen wrote:
> 
> > Hi Jeremy,
> >
> > On Mar 21 16:47, Jeremy Drake via Cygwin-patches wrote:
> > > From: Jeremy Drake <cygwin@jdrake.com>
> > >
> > > This does not include the source files responsible for generating AT&T-
> > > or Intel-syntax assembly output, and ifdefs out the large table of
> > > opcode strings since we're only interested in walking machine code, not
> > > generating disassembly.
> > >
> > > Also included is a diff from the original libudis86 sources.
> >
> > Can you please make two patches from this?
> >
> > Patch 1: Add the original code
> > Patch 2: Apply the diff
> 
> OK.
> 
> > And you're aware that you're invariably are becoming the maintainer
> > for this piece of Cygwin, right?
> 
> I do not like that the fast cwd code exists and digs around for a private
> variable in ntdll, and I was dragging my feet on integrating the ARM64
> support I prototyped because I didn't want to be responsible for
> perpetuating it.  Now I'm becoming the maintainer of my least-favorite
> corner of Cygwin ;)

:)))
