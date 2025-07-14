Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8C691385840F; Mon, 14 Jul 2025 11:56:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C691385840F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752494185;
	bh=1EdNRQmZgq1C5MW+1Qbe4sRq0EKPPshARuulWtE5i7E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IKNrmbT718NdSz7Ov3j2hIkvsaBBwroeLyn93cswvTETDRKiHtS9dnrNMHewJsd/1
	 r87tWGYewxaZ6/cDKZryqjPWQ2gpzYSeM++1AjJNshR8F/XkH2/WCDlktnvFfU202g
	 rfs7UH0sZFvOs3WXUftoqR8xsayuejXwW1dsjqD0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D5CD8A806FF; Mon, 14 Jul 2025 13:56:23 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:56:23 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: gendef: stub implementations of routines for
 AArch64
Message-ID: <aHTwZ-lCwbHtuIKp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB0923C9E8CCEA2C6CF37A60739242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB09233DE9CBD5304BB8D2D69E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB9PR83MB09233DE9CBD5304BB8D2D69E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Radek,

On Jul 10 09:18, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Sending the same patch with more detailed commit message.
> 
> Radek
> 
> ---
> >From 98a989bfaef11097d5ce6705c3780ea6ebb284e9 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Fri, 6 Jun 2025 14:31:30 +0200
> Subject: [PATCH v2] Cygwin: gendef: stub implementations of routines for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch aspires to provide only minimal changes to
> `winsup/cygwin/scripts/gendef` allowing to pass the AArch64 build. It does not
> provide any implementations of the generated routines.

On second thought, I'm not sure what you're trying to accomplish here.
I understand if certain parts of Cygwin for aarch64 may not work right
from the start, and stuff like an option to exclude cygserver from the
build for the time being sounds ok to me.

But the code gendef generates is pretty crucial for Cygwin's operation.
I don't quite see how being able to build a completely disfunctional DLL
is going to help during bootstrap.

Can you please explain how you're planning to go forward from here, so
we can all understand if and why this patch makes sense during bootstrap?


Thanks,
Corinna
