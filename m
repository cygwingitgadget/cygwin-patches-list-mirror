Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BBB91385C6D8; Thu, 17 Jul 2025 08:33:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BBB91385C6D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752741212;
	bh=Po/hwAQJeJK25aThQ2oUA40cKoAKR5UXiMeNkC18zns=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=nmm2uMjisB0ip4XX8AejH/j+0S0tIRhOzde//jRteL56ol3uSakCAqw+/aEQ+XTRS
	 T2imHrfLv8vRMdMCAWTm3kRmE5zX2dHHP5PtCpsmwJ/PiLW+2xH6/mc2rRppuX50cP
	 IO6l7EDaW8H2ZifvUYOP1K2eb7RpqicQG+EmmRDI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 331E5A809F3; Thu, 17 Jul 2025 10:33:30 +0200 (CEST)
Date: Thu, 17 Jul 2025 10:33:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: add note about raw devices of BitLocker
 partitions
Message-ID: <aHi1Wme5GNrCbYZl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <2c6df85b-efd1-2209-5bf4-41d90b6d27db@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c6df85b-efd1-2209-5bf4-41d90b6d27db@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 16 11:38, Christian Franke wrote:
> Another un?documented Windows behavior -- occasionally useful in this case
> :)

Ok.  Maybe as a <note>?


Thanks,
Corinna

> 
> -- 
> Regards,
> Christian
> 

> From 9a506433ea47aac7b19f1e03c99d800ec2e55b11 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Wed, 16 Jul 2025 11:33:25 +0200
> Subject: [PATCH] Cygwin: doc: add note about raw devices of BitLocker
>  partitions
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/doc/specialnames.xml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/winsup/doc/specialnames.xml b/winsup/doc/specialnames.xml
> index 02375e737..4b232002a 100644
> --- a/winsup/doc/specialnames.xml
> +++ b/winsup/doc/specialnames.xml
> @@ -361,6 +361,12 @@ the information between <filename>/proc/partitions</filename> and the
>  <command>df</command> output, you should be able to figure out which
>  external drive corresponds to which raw disk device name.</para>
>  
> +<para>Raw devices of partitions protected by BitLocker provide access to the
> +<emphasis>decrypted</emphasis> NTFS image.  If the partition is locked, read
> +attempts fail with <literal>Permission denied</literal>.  The corresponding
> +block range from the raw device of the full disk provides access to the
> +<emphasis>encrypted</emphasis> image as stored on the disk.</para>
> +
>  <note><para>Apart from tape devices which are not block devices and are
>  by default accessed directly, accessing mass storage devices raw
>  is something you should only do if you know what you're doing and know how to
> -- 
> 2.45.1
> 

