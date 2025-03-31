Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 067793865488; Mon, 31 Mar 2025 11:06:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 067793865488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743419174;
	bh=/RKDbmh4cW5oLmi5qIpDIqPzQcsm4KqqtzuM5YHRAIc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LjioprjrO3HRe/vnTO2rFqoFDaBCadkY1gnm43eayN2t6UqwWi6+hT77Yg+ERHcO5
	 ztTW+kR/s52Sn8ppLlybMIZ/+eQ+Pt6R4XOsRTSNl1+ttVbiBRDGwCY9k83Pedpk8A
	 tw2AWIFVWK5947JvB8PKvIHJAaE3te6+hD+RV7RA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E8742A80A71; Mon, 31 Mar 2025 13:06:11 +0200 (CEST)
Date: Mon, 31 Mar 2025 13:06:11 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: Re: [PATCH] Cygwin: dlfcn: fix ENOENT in dlclose
Message-ID: <Z-p3Iw_ifKuIJ_MI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Yuyi Wang <Strawberry_Str@hotmail.com>
References: <Z-m7GKMd5fXqlq2S@calimero.vinschen.de>
 <TYCPR01MB109268BAA2FA4C2E56092C090F8AD2@TYCPR01MB10926.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCPR01MB109268BAA2FA4C2E56092C090F8AD2@TYCPR01MB10926.jpnprd01.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 31 17:18, Yuyi Wang wrote:
> > I tested this scenario, and this problem only occurs with
> > dlopening cygwin1.dll.
> 
> Not only cygwin1.dll, but also native dlls, e.g., kernel32.dll or user32.dll.
> I haven't tested the next release, but do you think it's the same reason for
> win32 dlls?

No, it's not.  Native DLLs are not taken into account because they
don't call into Cygwin's dll_dllcrt0 on init, so they are not
added to the DLL list.

Hmm.

I'll have to check if we should add them to the dll list or not.
We certainly don't need them for atexit and stuff, but the dlopen
counting might be necessary at fork.


Corinna
