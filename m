Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4EC1A3858D34; Wed, 27 Nov 2024 17:17:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4EC1A3858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732727875;
	bh=R0YV+anATmm8ZSphVuChCoMZObgJlE+pWUhbJ6y6Llg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=FFr6gTkW/UnYGlMh7DG9+ofB+lsxSmX93/CLYY6t0SYgRojm56dLJS56VWrKsd9bQ
	 4TiN454GqXULOHitUi0yk92jKZv7uPAFgn2p5whJJxNzCJ+dcvmE/yfifF9dODJHjU
	 ZeCqMcpO82rWHswFWN+baDkA3zIN85+hQkloVrAk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 46BB1A80901; Wed, 27 Nov 2024 18:17:53 +0100 (CET)
Date: Wed, 27 Nov 2024 18:17:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: uname: add host machine tag to sysname.
Message-ID: <Z0dUQXouuPfhc9u4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ecdfa413-1ad4-ea0e-4f01-33579f1616e9@jdrake.com>
 <Z0XNgZoVQI_P5FMD@calimero.vinschen.de>
 <42819a86-1e9f-6569-a08e-fd719115a2c3@jdrake.com>
 <Z0c71iqtu1Zk2vNK@calimero.vinschen.de>
 <4cdfd5dc-dfe0-7b71-3e3b-59469b2fe094@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cdfd5dc-dfe0-7b71-3e3b-59469b2fe094@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 08:47, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 27 Nov 2024, Corinna Vinschen wrote:
> 
> > I'm not opposed to a switch statement consisting of an
> > IMAGE_FILE_MACHINE_ARM64 case and a default case adding "-???" or
> > something.  Chances are so extremly slim that we'll ever see another
> > CPU emulated on x86_64, we can always add a case for that if it turns
> > out that I'm totally wrong, right?
> 
> OK, does the default case have to be a fixed string or can I use the hex?
> Lately it seems like MS is making the hex form almost "meaningful" - AMD64
> is 0x8664 and ARM64 is 0xaa64.  I don't know if they can keep that up for
> any new arch, but putting the value in there at least gives us something
> to go on until a new case can be added.

Ok.


Thanks,
Corinna
