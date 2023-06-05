Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F2C773858C2B; Mon,  5 Jun 2023 19:05:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F2C773858C2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1685991951;
	bh=Rl3AUAVzvAwPEeVfj22rvpBk5h5i9wSpxXwRU9vsgKg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tbRdpaVW7ZfrsA1GRz/VZbd2YLbuETSFpmPpBBmOQB17df1+Q0/j+fNZ+j9k+hevl
	 RDdYKlM5vnFSpE79BTRZRXSTBhek/gQR2yeI5fwM7A11I2QrWHnyfxBMpNZbAD7A6X
	 ELMkFyXeDLslbTa0ndR4NQq8B1TKXmdHVv0ZyWlo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2F44CA80D4E; Mon,  5 Jun 2023 21:05:50 +0200 (CEST)
Date: Mon, 5 Jun 2023 21:05:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Philippe Cerfon <philcerf@gmail.com>
Cc: cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@shaw.ca>
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
Message-ID: <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Philippe Cerfon <philcerf@gmail.com>,
	cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@shaw.ca>
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

[dropping newlib from the recipient list]

Hi Philippe,

On May 30 14:04, Brian Inglis wrote:
> On Tue, 30 May 2023 13:25:38 +0200, Philippe Cerfon wrote:
> > Hey there.
> > 
> > Linux exports XATTR_{NAME,SIZE,LIST}_MAX in it's linux/limits.h and
> > e.g. the CPython interpreter uses them for it's XATTRs functions.
> > 
> > I made a corresponding PR at CPython
> > https://github.com/python/cpython/pull/105075 to get the code built
> > for Cygwin, but right now this would fail due to the missing
> > XATTR_*_MAX symbols.
> > 
> > The attached patch below would add them to cygwin/limits.h.
> 
> Patches for Cygwin under winsup are submitted to cygwin-patches@cygwin.com
> (forwarded there).
> 
> > But beware, I'm absolutely no Windows/Cygwin expert ^^ - so whether
> > the values I've chosen are actually correct, is more guesswork rather
> > than definite knowledge.
> > 
> > As written in the commit message, I think:
> > - XATTR_NAME_MAX corresponds to MAX_EA_NAME_LEN
> > and
> > - XATTR_SIZE_MAX to MAX_EA_VALUE_LEN
> > 
> > though I have no idea, whether these are just lower boundaries used by
> > Cygwin, while e.g. Windows itself might set longer names or value
> > lenghts, and thus - when Cygwin would try to read such - it might get
> > into troubles (or rather e.g. CPython, as it's buffers wouldn't
> > suffice to read the EA respectively XATTR.

As on Linux, these are upper bounds of the kernel API. In case of
MAX_EA_VALUE_LEN that's especially true, because the defined API
isn't overly consistent: the datastructure allows bigger values
than the function calls are able to handle.  However, file systems
may impose lower limits without them having matching macros.
IIRC, an EA on ext4 may be only 4K, but I'm not entirely sure.

Either way, we can do what you propose, but...

- The XATTR_NAME_MAX value is incorrect. The MAX_EA_NAME_LEN value
  is an internal definition for a name *including* the trailing \0,
  the XATTR_NAME_MAX value defines the max name length *excluding*
  the trailing \0.  Compare with NAME_MAX.

- Whatever that's good for, we actually allow bigger values right
  now.  For compat reasons we only allow attributes starting with
  the "user." prefix, and the *trailing* part after "user." is
  allowed to be 255 bytes long, because we don't store the "user."
  prefix in the EA name on disk.  So in fact, XATTR_NAME_MAX should
  be 255 + strlen("user.") == 260.

- If we actually define these values in limits.h, it would also be a
  good idea to use them in ntea.cc and to throw away the MAX_EA_*_LEN
  macros.

A patch along these lines is appreciated.


Thanks,
Corinna
