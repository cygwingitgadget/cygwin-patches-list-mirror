Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E7F27384D172; Wed,  2 Apr 2025 08:36:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E7F27384D172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743583008;
	bh=BH6HbPYj5qSet45MrD4zA3TTNACngDk6fK1uHDT+BDY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=yKZSvs2LC0SzSPJrleMXVNHd9SyivUz0rs00GUjk8iTK64BUoRGv9766IjMRgiJ5c
	 fmgx5dX0vOC4vMVUCSArakLimpbUXzHZitS6QQ60UGzNaI5JGwPlrMSlH0KkTeVgVk
	 jz1fkuQy0d8wU/AXN0x1q6KOr9TomE1lWIZpSH80=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3B456A8098D; Wed, 02 Apr 2025 10:36:46 +0200 (CEST)
Date: Wed, 2 Apr 2025 10:36:46 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-z3HnUXN7Cm2qI6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
 <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
 <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
 <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
 <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
 <236d3480-bda4-08cc-9ef5-e83ff9f668d3@jdrake.com>
 <Z-ugBR-lzNL7WxHT@calimero.vinschen.de>
 <Z-up6Q9eFQ6ir35Z@calimero.vinschen.de>
 <c302213f-6d65-2ad3-6dd5-b6a887b3ede6@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c302213f-6d65-2ad3-6dd5-b6a887b3ede6@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Apr  1 10:25, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 1 Apr 2025, Corinna Vinschen wrote:
> 
> > Oh, Jeremy, here's a question.  We only add udis86 to the main branch.
> > What about the 3.6 branch, does it still need a patch to accommodate
> > the fast_cwd magic for a newer, upcoming Windows version?
> 
> I was going to ask about that too.  I assume the plan is to keep the new
> udis86 code for 3.7, and continue applying band-aids to the old code on
> 3.6 as needed.  The question remains, do we apply band-aids for insider
> builds or wait for an actual release (or something approximating a release
> candidate)?

We shouldn't try to accommodate every insider build.  The fallback code
works for them good enough I think.  Ultimately we support the released
versions only, so starting with a release candidate is early enough.

> > And btw., I checked the file size again, and it turns out that after
> > stripping the debug symbols the DLL takes ~30 pages or 120 K more memory
> > than before udis86.  I hope that's ok.  But if you see ways to shave a
> > few pages off by dropping code from udis86, I wouldn't be too unhappy :}
> 
> Hmm, I only tested on top of msys2 (which is on gcc 13.3.0), but here's
> what I see:
> 
> $ ls -l
> total 47952
> -rwxr-xr-x 1 XXX None 24682293 Apr  1 10:14 postmsys-2.0.dll
> -rwxr-xr-x 1 XXX None 24417887 Apr  1 10:12 premsys-2.0.dll
> 
> $ echo $(( $(stat -c %s postmsys-2.0.dll) - $(stat -c %s premsys-2.0.dll) ))
> 264406
> 
> $ strip premsys-2.0.dll
> $ strip postmsys-2.0.dll
> 
> $ ls -l
> total 6428
> -rwxr-xr-x 1 XXX None 3330598 Apr  1 10:15 postmsys-2.0.dll
> -rwxr-xr-x 1 XXX None 3246118 Apr  1 10:15 premsys-2.0.dll
> 
> $ echo $(( $(stat -c %s postmsys-2.0.dll) - $(stat -c %s premsys-2.0.dll) ))
> 84480

Ah, I only ran strip -g.  That explains the difference.


Corinna
