Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 35807385DC05; Thu, 17 Jul 2025 09:29:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 35807385DC05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752744576;
	bh=JXmmC60iGjPJyBEUl6RYAOy8/QZZ+xZiPMN9a5qNBjM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=s7VAFChQlF3b3E4FXip+KSUERsfQqISX7LrIzH8p9gl/mXpLjohlyg/Lq5zfWMwFv
	 FwAipxPo3MvEXzNZb6R9VekrtIjEjRk99eEciP7nqQQl4G0uJaF/PB8mYkO4K/LzNQ
	 crsLeJb0ut0wCFEwHvuJNwPAIWadd49Of+vvUSdc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8722CA809F3; Thu, 17 Jul 2025 11:29:34 +0200 (CEST)
Date: Thu, 17 Jul 2025 11:29:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3] Cygwin: cygcheck: port to AArch64
Message-ID: <aHjCfuQIeFMxO0Sj@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB09236B2289D6307E787D64FC9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB09232BEB586BCF0576FD69CD9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHTs_sKuNZ1OkBvc@calimero.vinschen.de>
 <DB9PR83MB09230DE13A8F922630FC2CF69251A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB09230DE13A8F922630FC2CF69251A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 17 08:55, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Hmm. It's quite a while since I've been writing this and honestly I no longer remember why I though the offset should be different for AArch64. Now, looking into the documentation and the surrounding source code, I'd say 108 is a correct value. Furthermore, I've tried `cygcheck -s -v` with both and 112 was crashing while 108 seemed to work.
> 
> Thank you for noticing this.
> 
> Radek
> 
> ---
> >From a27cdd462d1067e8bffe7dade7c3d2088ed7866f Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Mon, 9 Jun 2025 13:08:35 +0200
> Subject: [PATCH v3] Cygwin: cygcheck: port to AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch ports `winsup/utils/mingw/cygcheck.cc` to AArch64:
>  - Adds arch=aarch64 to packages API URL.
>  - Ports dll_info function.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/utils/mingw/cygcheck.cc | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Pushed.


Thanks,
Corinna
