Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 888A13858408; Mon, 14 Jul 2025 13:27:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 888A13858408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752499662;
	bh=yL6vfJmCWaKyb4H52vZ4UpcZFqBUYBlnIAuimTyCosE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MO0UVcLuKn9/hq14gkJ8OTZW5w+2vxSwC+X5+aQJ08dQZpfnwDed6nMA5Z0qZAqyO
	 6F38qqnMeL6AOf9/gtnEWgC7ctgBkQnjRjPDKM3In1bN6dvTqy2igRvank1EZ9/ag2
	 psgOD1+4rl1b9u/7ddev581xbR2dk/xrd4qlq13E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D5EFEA80864; Mon, 14 Jul 2025 15:27:40 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:27:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Message-ID: <aHUFzEEGq448gvZ0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 14 15:22, Corinna Vinschen wrote:
> On Jul 10 19:21, Radek Barton via Cygwin-patches wrote:
> > From 8bfc01898261e341bbc8abb437e159b6b33a9312 Mon Sep 17 00:00:00 2001
> > From: Evgeny Karpov <evgeny.karpov@microsoft.com>
> > Date: Fri, 4 Jul 2025 20:20:37 +0200
> > Subject: [PATCH] Cygwin: malloc_wrapper: port to AArch64
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> > 
> > Implements import_address function by decoding adr AArch64 instructions to get
> > target address.
> > 
> > Signed-off-by: Evgeny Karpov <evgeny.karpov@microsoft.com>
> > [...]
> 
> Pushed.
> 
> 
> Thanks,
> Corinna

Sigh.  Actually I shouldn't have done that.  While Evgeny is the patch
author, the *attached* patch has you, Radek, in the Signed-off-by, and
that's what I now pushed.

Please make sure that Signed-off-by sticks to the author in the attached
patch as well, not to the person sending the patches to the list, please.  


Thanks,
Corinna
