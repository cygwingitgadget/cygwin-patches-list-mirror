Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7F31C384D151; Wed,  2 Apr 2025 08:37:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F31C384D151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743583077;
	bh=ygBUGGaoZWu297ugpZO8NTjQkYUsg8IXsnp/Edtk1rQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rJMBbl1nfSEMs2UytSy6TfTyvnA7DqJ42b41qeaVSUdptHQQK6IHA0fiG9o7bBjnl
	 sI6M4nyHqS2D0Scs5zOgbVBgyMUgSqzxZ+bVxeTuDx+f6DCffwhOOjgowPkW8dmGiL
	 Zzh+ycGnm3qg4GOUWgV6UaiSgOms74n8JgBP3tjY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 24DABA8098D; Wed, 02 Apr 2025 10:37:55 +0200 (CEST)
Date: Wed, 2 Apr 2025 10:37:55 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-z3Y4RwfkBdIt3g@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
 <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
 <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
 <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
 <236d3480-bda4-08cc-9ef5-e83ff9f668d3@jdrake.com>
 <Z-ugBR-lzNL7WxHT@calimero.vinschen.de>
 <Z-up6Q9eFQ6ir35Z@calimero.vinschen.de>
 <c302213f-6d65-2ad3-6dd5-b6a887b3ede6@jdrake.com>
 <c9bbf5d2-8e93-49fe-c19b-a05aef399039@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9bbf5d2-8e93-49fe-c19b-a05aef399039@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Apr  1 22:25, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 1 Apr 2025, Jeremy Drake via Cygwin-patches wrote:
> 
> > On Tue, 1 Apr 2025, Corinna Vinschen wrote:
> >
> > > And btw., I checked the file size again, and it turns out that after
> > > stripping the debug symbols the DLL takes ~30 pages or 120 K more memory
> > > than before udis86.  I hope that's ok.  But if you see ways to shave a
> > > few pages off by dropping code from udis86, I wouldn't be too unhappy :}
> >
> > Hmm, I only tested on top of msys2 (which is on gcc 13.3.0), but here's
> > what I see:
> >
> > $ ls -l
> > total 47952
> > -rwxr-xr-x 1 XXX None 24682293 Apr  1 10:14 postmsys-2.0.dll
> > -rwxr-xr-x 1 XXX None 24417887 Apr  1 10:12 premsys-2.0.dll
> >
> > $ echo $(( $(stat -c %s postmsys-2.0.dll) - $(stat -c %s premsys-2.0.dll) ))
> > 264406
> >
> > $ strip premsys-2.0.dll
> > $ strip postmsys-2.0.dll
> >
> > $ ls -l
> > total 6428
> > -rwxr-xr-x 1 XXX None 3330598 Apr  1 10:15 postmsys-2.0.dll
> > -rwxr-xr-x 1 XXX None 3246118 Apr  1 10:15 premsys-2.0.dll
> >
> > $ echo $(( $(stat -c %s postmsys-2.0.dll) - $(stat -c %s premsys-2.0.dll) ))
> > 84480
> >
> > One thing I noticed that could make the code using udis86 smaller and
> > faster is to use members of the ud_t struct directly instead of calling
> > accessor functions.  I don't know for sure if these members are intended
> > to be public or not (but they do seem to know how to declare members as
> > non-public: in ud_operand_t, they have an "internal use only" comment
> > followed by members named with leading underscores).  I don't think it
> > would make a large dent in the size of the code relative to the size of
> > udis86 itself though.
> 
> I changed the code to use the struct directly, and amazingly the dll was
> the exact same size after stripping.  I then tried building the udis86/*.c
> with -ffunction-sections -fdata-sections, and that resulted in a *larger*
> dll.  Building just udis86.c with -ffunction-sections (in addition to the
> struct access change) resulted in a 1k savings.  Instead #ifdef'ing out
> the unused functions (including those now unused because the struct
> members are read directly) in udis86.c resulted in a 2k savings.  In
> addition to ifdef'ing out functions, building all 3 udis86/*.c files with
> -Os resulted in an overall 4608 byte savings in stripped dll size.

Yeah, that doesn't make sense.  No worries, don't put too much time into
that.  But thanks for looking anyway.


Corinna
