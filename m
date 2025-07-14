Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B30A43858D37; Mon, 14 Jul 2025 13:37:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B30A43858D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752500262;
	bh=jUcOkVOz1+OaLwMvMjWeOvx/8K60Bq4wAzCuibFVu/Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=DMAh+EOltmg5WXP7Ep59+xVnDZJhUzSYZIBf31oehyc/sR9iP/WyaiogNZCte7HD3
	 R2sHGKQtASIjU1xGoGGjIqBnJKHay3Nj375M7WX60arxhlaMSe7EQqLTHtyebsY/mx
	 RLNn8aIm2nEj0FDRV+FgRcgpYBOyq3wX2y8k9fEY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 17475A806FF; Mon, 14 Jul 2025 15:37:41 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:37:41 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: warn about unprivileged access to raw
 devices
Message-ID: <aHUIJb8zEUePlkut@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7d18c6c8-3d74-0f97-cf45-05a7a263c386@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d18c6c8-3d74-0f97-cf45-05a7a263c386@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 14 14:58, Christian Franke wrote:
> From 344a329a5706de125b3ef11dc7324101b08b3c67 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Mon, 14 Jul 2025 14:44:01 +0200
> Subject: [PATCH] Cygwin: doc: warn about unprivileged access to raw devices
> 
> Raw devices of partitions may be accessible from unprivileged
> processes, for example if connected via USB.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/doc/specialnames.xml | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/doc/specialnames.xml b/winsup/doc/specialnames.xml
> index a1f9d3f5e..02375e737 100644
> --- a/winsup/doc/specialnames.xml
> +++ b/winsup/doc/specialnames.xml
> @@ -368,7 +368,15 @@ handle the information.  <emphasis role='bold'>Writing</emphasis> to a raw
>  mass storage device you should only do if you
>  <emphasis role='bold'>really</emphasis> know what you're doing and are aware
>  of the fact that any mistake can destroy important information, for the
> -device, and for you.  So, please, handle this ability with care.
> +device, and for you.  So, please, handle this ability with care.</para>
> +
> +<para><emphasis role='bold'>Important:</emphasis> Windows may allow raw read
> +<emphasis role='bold'>and write</emphasis> access to partitions (for example
> +<filename>/dev/sda2</filename>) even from unprivileged processes.  This is
> +usually the case for partitions on "removable" drives like USB flash drives
> +or regular SATA/NVMe drives behind USB docking stations.  If
> +<command>chkdsk X:</command> works, raw access to the same partition is
> +possible from the same user account.
>  <emphasis role='bold'>You have been warned.</emphasis></para></note>
>  
>  <para>
> -- 
> 2.45.1
> 

Pushed.... oh, right, you have push perms, sigh :}


Thanks,
Corinna
