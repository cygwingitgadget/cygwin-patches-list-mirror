Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 41D803858CDA; Tue,  8 Apr 2025 13:39:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 41D803858CDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1744119598;
	bh=GwWnBpM+MPIm93wYW858HiBveWh0Mhfi6dNLuFN0QQg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=e4IdbkM88jEjlmKgN+NVZ6ebYa2RJWD0NMgh0KrhAIVj1wRdWt2OwRgwLjOusJdGH
	 6RMi8/PPR0ddPFynouQupCrRsr4qYTIEclu8T71duivNL7SJwgMnTL8LJ2eanAF+c0
	 RDgKmyVfGm5jeadLztyVblUaXL39cKa/H9g2TIP8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2953CA8059E; Tue, 08 Apr 2025 15:39:56 +0200 (CEST)
Date: Tue, 8 Apr 2025 15:39:56 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: faq: add lssparse to sparse file example
Message-ID: <Z_UnLLImHSDeW7Gh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <245987b6-3d23-51ce-05d1-84bc0b4a12ba@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <245987b6-3d23-51ce-05d1-84bc0b4a12ba@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Apr  8 13:51, Christian Franke wrote:
> From 3944b5b21502e65821a4c30d568207273320347a Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Tue, 8 Apr 2025 13:34:02 +0200
> Subject: [PATCH] Cygwin: faq: add lssparse to sparse file example
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/doc/faq-using.xml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
> index e5e4479f5..111702c6f 100644
> --- a/winsup/doc/faq-using.xml
> +++ b/winsup/doc/faq-using.xml
> @@ -855,6 +855,11 @@ possible to preset the sparse attribute with <literal>chattr</literal>.
>  	---a-S-------- 2/is_sparse
>  	---a-S-------- 2/maybe_sparse
>  	---a-S-------- 2/not_sparse
> +	$ lssparse -H 0/is_sparse # from cygutils-extra package
> +	Hole range[1]: offset=0x0,      length=0x100000
> +	Data range[2]: offset=0x100000, length=0x4
> +	$ lssparse -H 0/not_sparse
> +	Data range[1]: offset=0x0,      length=0x100004
>  </screen>
>  <para>With <literal>sparse</literal> mount option or a SSD, all
>  <literal>?/maybe_sparse</literal> files would be sparse.

LGTM, please push.

Thanks,
Corinna

