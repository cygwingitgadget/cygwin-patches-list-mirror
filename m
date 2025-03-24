Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DFB48385B512; Mon, 24 Mar 2025 10:24:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DFB48385B512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742811852;
	bh=GvggbQwJaTm2K6WuPgsgb2tFo/6eyTe5I+UBpxqKUvc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OkCWYpMvT1S3q/bgrFrd4hBASxKWXYv3YTJFXCRc2q47uKeoKu22d7vXQ7wNXFsN5
	 1kb0/ApQEJKAv2NFJQ13720zvNQamfGG0Jk7Bw1etax7UiL31pM7/NoW+erwOAHI0W
	 +gL0Zd8Ih+7MVNjSMpsuwtQit8XPjWG/bJcR4WRg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 491BEA80B7A; Mon, 24 Mar 2025 11:24:10 +0100 (CET)
Date: Mon, 24 Mar 2025 11:24:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/4] Cygwin: vendor libudis86 1.7.2
Message-ID: <Z-Eyyg3c3Jvs23rf@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f86ec933-b668-cce8-701a-0484b69aca50@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f86ec933-b668-cce8-701a-0484b69aca50@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Mar 21 16:47, Jeremy Drake via Cygwin-patches wrote:
> From: Jeremy Drake <cygwin@jdrake.com>
> 
> This does not include the source files responsible for generating AT&T-
> or Intel-syntax assembly output, and ifdefs out the large table of
> opcode strings since we're only interested in walking machine code, not
> generating disassembly.
> 
> Also included is a diff from the original libudis86 sources.

Can you please make two patches from this?

Patch 1: Add the original code
Patch 2: Apply the diff

And you're aware that you're invariably are becoming the maintainer
for this piece of Cygwin, right?


Thanks,
Corinna
