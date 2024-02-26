Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EA4493858C55; Mon, 26 Feb 2024 15:48:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EA4493858C55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1708962497;
	bh=dB3Bkz4zaHGQEoDDiMOaiDZqx7N24ihDFShhdex4c1o=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=eoVrV/UXvjFsDDNeLRDCKfr5MJkzggQ6/ppcQUmqYMPeQ0NRBs50mOMQLa2tIiuu7
	 0QscHILsXfust4pLEpS0J0BpUcEysl7reNtvBiur3/xBi1LAhJC23lqYe6qT993gcu
	 JajHgKszCN1TQA58lLEk+a19w1niAkfVT0PYsBd0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 12275A80C0C; Mon, 26 Feb 2024 16:48:16 +0100 (CET)
Date: Mon, 26 Feb 2024 16:48:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] Cygwin: introduce constexpr errmap_size and errmap[]
 consistency checks
Message-ID: <ZdyywDSKMTtZCk-8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7f17e15c-ef28-06fd-3a6d-cac60a651960@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f17e15c-ef28-06fd-3a6d-cac60a651960@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 26 15:21, Christian Franke wrote:
> From 947daa02b0b64131626c2ecedb74ca6893aab6c6 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Mon, 26 Feb 2024 13:37:33 +0100
> Subject: [PATCH 1/4] Cygwin: introduce constexpr errmap_size and errmap[]
>  consistency checks
> 
> Use constexpr instead of const for errmap[] to allow static_assert
> checks on its values.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/errno.cc                |  2 +-
>  winsup/cygwin/local_includes/errmap.h | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)

:+1:
Patchset pushed.


Thanks,
Corinna

