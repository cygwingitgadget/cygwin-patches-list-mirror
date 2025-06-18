Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E03BE38734BB; Wed, 18 Jun 2025 14:28:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E03BE38734BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750256915;
	bh=oz9orYcfU6TGcPkTyIs9JrmBHirZG21WsfXde7Va3/4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DlOq8cdMNVHl4AaV1tscS69Ify65NhTqt4pAteDUoIYoyMHofyAbX513lqMX0PXfY
	 z4RZWxLfCIJkuZIun8Ie2BzjYYN4PM2IijRiAki+/mz8kgyyUsml87Wy1mfd9qLeHs
	 6IjhGHqSdg1b4jXEfWo+1j9ZZCJdHklnPg7YV+iM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 612F1A80D4E; Wed, 18 Jun 2025 16:28:29 +0200 (CEST)
Date: Wed, 18 Jun 2025 16:28:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [EXTERNAL] [PATCH] Cygwin: fix MALLOC_ALIGNMENT already defined
 in newlib for AArch64
Message-ID: <aFLNDXv3D_my__4Q@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB092385493BAC19ED728089929270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB092321E4E33CF50011F35A809272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB092321E4E33CF50011F35A809272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 18 12:15, Radek Barton via Cygwin-patches wrote:
> Hello
> 
> Sending second version with Signed-off-by header.
> 
> Radek
> 
> ---
> >From e479be6a67118e70898145d478d0e0b88565f0d1 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Thu, 5 Jun 2025 13:16:20 +0200
> Subject: [PATCH v2] Cygwin: fix MALLOC_ALIGNMENT already defined in
>  newlib for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/local_includes/cygmalloc.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/local_includes/cygmalloc.h b/winsup/cygwin/local_includes/cygmalloc.h
> index 5e1fe8154..898ea56a5 100644
> --- a/winsup/cygwin/local_includes/cygmalloc.h
> +++ b/winsup/cygwin/local_includes/cygmalloc.h
> @@ -21,7 +21,10 @@ int dlmalloc_trim (size_t);
>  int dlmallopt (int p, int v);
>  void dlmalloc_stats ();
>  
> +// Already defined for AArch64 in newlib/libc/include/sys/config.h
> +#ifndef MALLOC_ALIGNMENT
>  #define MALLOC_ALIGNMENT ((size_t)16U)
> +#endif
>  
>  #if defined (DLMALLOC_VERSION)	/* Building malloc.cc */
>  
> -- 
> 2.49.0.vfs.0.4

Pushed.

Thanks,
Corinna
