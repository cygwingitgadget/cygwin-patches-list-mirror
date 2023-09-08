Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6A31B3858D35; Fri,  8 Sep 2023 14:08:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6A31B3858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1694182090;
	bh=QX/i1k/evPj04kdDvLYQPZ6lBrVWdT5c4WiTTMw4CLY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=aQvIXmFvn0gGEOVwRiwWBJRyscECdYPAUsLqXMUz4RIQdn0Lmx8865sV5wrX3nKYi
	 UARgyNNLmPniWvSI23ULNlD9vpF9hRkcRZluh2P5aLms3025Vk/COqttwvrl5c/9Hs
	 DaYWPvr1dJjc1vMo4P7VaxK62AWLLBOVKADg/DEM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9C0BCA8056F; Fri,  8 Sep 2023 16:08:08 +0200 (CEST)
Date: Fri, 8 Sep 2023 16:08:08 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix __cpuset_zero_s prototype
Message-ID: <ZPsqyAfQi1L7YSEn@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230908053639.5689-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908053639.5689-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Sep  7 22:36, Mark Geisert wrote:
> Add a missing "void" to the prototype for __cpuset_zero_s().
> 
> Reported-by: Marco Mason <marco.mason@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin/2023-September/254423.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: c6cfc99648d6 (Cygwin: sys/cpuset.h: add cpuset-specific external functions)

Thanks, can you also add an entry to the 3.4.10 release file
(which doesn't exist yet), please?


Corinna
