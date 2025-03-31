Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 565DC3857032; Mon, 31 Mar 2025 15:57:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 565DC3857032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743436672;
	bh=M982NEyy31cajtEjnpi0nqwMo7s0qxTvI50omW+Qmj0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MuJyteCXp7xo95X0unQxisB3/QWAKEc+S9Vq9A8VLJUBm5XlLLLzX+ZHi+oMwnXgp
	 iE5vBwNGpgjIYa3u5oVBzKRC23RwFtSM4+CISTmZrFg97aDQIyaVyzh+1tbzxhjJCe
	 sa+Igreuif929gcYJLAeMLWr6jOqaha5MhhOBlvc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 99654A80C9C; Mon, 31 Mar 2025 17:52:17 +0200 (CEST)
Date: Mon, 31 Mar 2025 17:52:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: Re: [PATCH] Cygwin: dlfcn: fix ENOENT in dlclose
Message-ID: <Z-q6MYPqNVaJT_rN@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Yuyi Wang <Strawberry_Str@hotmail.com>
References: <Z-m7GKMd5fXqlq2S@calimero.vinschen.de>
 <TYCPR01MB109268BAA2FA4C2E56092C090F8AD2@TYCPR01MB10926.jpnprd01.prod.outlook.com>
 <Z-p3Iw_ifKuIJ_MI@calimero.vinschen.de>
 <Z-qczTuTQ85MXB7k@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-qczTuTQ85MXB7k@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Mar 31 15:46, Corinna Vinschen wrote:
> On Mar 31 13:06, Corinna Vinschen wrote:
> > On Mar 31 17:18, Yuyi Wang wrote:
> > > > I tested this scenario, and this problem only occurs with
> > > > dlopening cygwin1.dll.
> > > 
> > > Not only cygwin1.dll, but also native dlls, e.g., kernel32.dll or user32.dll.
> > > I haven't tested the next release, but do you think it's the same reason for
> > > win32 dlls?
> > 
> > No, it's not.  Native DLLs are not taken into account because they
> > don't call into Cygwin's dll_dllcrt0 on init, so they are not
> > added to the DLL list.
> > 
> > Hmm.
> > 
> > I'll have to check if we should add them to the dll list or not.
> > We certainly don't need them for atexit and stuff, but the dlopen
> > counting might be necessary at fork.
> 
> FTR, even if we keep track of native dlopen'ed DLLs, we can't reproduce
> their state after fork.  We must not even try, because certain Windows
> DLLs choke on reproducing their data and bss segments and misbehave.
> 
> So we can only keep track of the number of dlopen/dlclose calls for them.

I pushed a patch:
https://sourceware.org/cgit/newlib-cygwin/commit/?id=9fb7f285d626d

Please try the next test release cygwin-3.7.0-0.31.g0bb9d599a2b9.


Thanks,
Corinna
