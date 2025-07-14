Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E5C353858D37; Mon, 14 Jul 2025 11:45:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E5C353858D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752493501;
	bh=BzClo6OmY1Kk38InFsNd589aJYqvhued4/W7u7Xb9Oo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Nv6x46Y94fKTeldaIVgS03XG2RJIjjCFxwiEWO42b9ptezy+N7PdgsEgQ8MTF1clK
	 HkelhaAYnyZar8BTPRalkeL6T3sv9NE1NEBkQIkSmdIASsyM8N16hd5Or+7bvQllXr
	 0YHxlmBcVZE3A71qlPfH3ugyrCPf3SzwCf5Hup5I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3BB39A806FF; Mon, 14 Jul 2025 13:45:00 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:45:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: mkimport: port to support AArch64
Message-ID: <aHTtvJxFciiQwknO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB0923C4491893524EF694F6829243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923D524D8A33D763CBDD0369248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923D524D8A33D763CBDD0369248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 10 09:24, Radek Barton via Cygwin-patches wrote:
> >From e5060aa9afc7346301b7f394515d7a280b3c703d Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Mon, 9 Jun 2025 08:45:27 +0200
> Subject: [PATCH v2] Cygwin: mkimport: port to support AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch ports winsup/cygwin/scripts/mkimport script to AArch64, namely
> implements relocation to the imp_sym.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/scripts/mkimport | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimport
> index 9517c4e9e..0c1bcafbf 100755
> --- a/winsup/cygwin/scripts/mkimport
> +++ b/winsup/cygwin/scripts/mkimport
> @@ -24,6 +24,7 @@ my %import = ();
>  my %symfile = ();
>  
>  my $is_x86_64 = ($cpu eq 'x86_64' ? 1 : 0);
> +my $is_aarch64 = ($cpu eq 'aarch64' ? 1 : 0);
>  # FIXME? Do other (non-32 bit) arches on Windows still use symbol prefixes?
>  my $sym_prefix = '';
>  
> @@ -65,6 +66,16 @@ for my $f (keys %text) {
>  	.global	$glob_sym
>  $glob_sym:
>  	jmp	*$imp_sym(%rip)
> +EOF
> +	} elsif ($is_aarch64) {
> +	    print $as_fd <<EOF;
> +	.text
> +	.extern	$imp_sym
> +	.global	$glob_sym
> +$glob_sym:
> +	adr x16, $imp_sym
> +	ldr x16, [x16]
> +	br x16
>  EOF
>  	} else {
>  	    print $as_fd <<EOF;
> -- 
> 2.50.1.vfs.0.0
> 

Pushed.


Thanks,
Corinna
