Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 219974BA2E05; Fri,  9 Jan 2026 10:45:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 219974BA2E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1767955528;
	bh=WzNd8ScUORUeWLa5/XTmtFjBaKM/2hUNRUS+AJGHSxM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=A0Kv7yA0CFx8d47Cnt5Nczhr2wZdZaCIPcmotX9XXWjqxudQnCzoBNFOnSVNh24Lw
	 2//xT5n5xXzF1usmjUhd5Eh4nL79P5FfJMz6s+23P9BWNispnUkG/9XOwHdsn+4woy
	 Wwpor2gJ5UVcW30JJeGmG/Emw3Y+WbuvK2FA1rto=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 40449A80BCC; Fri, 09 Jan 2026 11:45:26 +0100 (CET)
Date: Fri, 9 Jan 2026 11:45:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Remove the unnecessary fdtab lock
Message-ID: <aWDcRkuPgqRN_E-l@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260108123502.989-1-takashi.yano@nifty.ne.jp>
 <20260108214626.1487161c6da89f7f2603b05d@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108214626.1487161c6da89f7f2603b05d@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jan  8 21:46, Takashi Yano wrote:
> On Thu,  8 Jan 2026 21:34:40 +0900
> Takashi Yano wrote:
> > There were two fdtab locks: one is in inode_t::del_my_locks(), and

I would write that as "There are two more fdtab enumerations using
fdtab locking, ..."

> > The merely counts the file
  They merely count ...

> > descriptors affected by the corresponding lock, so locking fdtab seems
> > unnecessary.  The latter only only during execve(), when no other
>                            ~~~~~~~~~
> runs only

Patch is ok.

Thanks,
Corinna
