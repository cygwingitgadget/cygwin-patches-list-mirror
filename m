Return-Path: <SRS0=diia=7M=redhat.com=vinschen@sourceware.org>
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by sourceware.org (Postfix) with ESMTP id BCDBA4BA2E04
	for <cygwin-patches@cygwin.com>; Wed,  7 Jan 2026 11:15:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BCDBA4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=redhat.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BCDBA4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767784510; cv=none;
	b=m184mgGDJ+sG1Y1Rzs8S1EfaLMsrFFTnNza2BeGnDSnjKwxnT2VcOtrIVJXbO0SXFiKvrhM0TQ+IfJcYMskcHE3XeJP6aFptUSdJgMFe5jNUnQJTSongg2W8tPgw+4bZ3cdRi8vu1IpKSPW+OsaR0vL6U+9x2yNkrLbywHHeNCw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767784510; c=relaxed/simple;
	bh=yrT8GitaVK9Q6Cq0AUeshSnr29bU92e90bbxIV7XQac=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=tMcZBCzxpdzVimDCxr6u8nIA2QoAM5q3N6HeoLzIxhV0CFlIvPuhBu/4gqV+bEtGw+xVsUxdo8MiXhmRohRJhKWD6TYpcRdr3ZuZ6TfemROZZpZ6/WvmA5HrhU5pij/Zkd/AztmSK7Ff/BhiA1PUZkF/nfJAan/lmDZIFvFqcV4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BCDBA4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oku5nBsd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767784505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NiCKZqgRiYQBkW5ropo/ixE0EiaaPoe2H4XR9cT9aEM=;
	b=Oku5nBsdB6QB9ja4k59x2artv9UV6CNq7BevnwD36tDYGHBVH8S0Nd36e+JXlzjlKS01Ng
	P+QGRqmX3aA5lQxEgfnCshVP5UIRpPq/6c9sjo1KOBpQy8WjuPm1R+uKRjo+ZYGYAAzIa/
	wifICcOZcm832WUDaP11DUaoFHcbZLg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-GbqYxYFZNRWcP2cSUvA6-g-1; Wed,
 07 Jan 2026 06:15:01 -0500
X-MC-Unique: GbqYxYFZNRWcP2cSUvA6-g-1
X-Mimecast-MFC-AGG-ID: GbqYxYFZNRWcP2cSUvA6-g_1767784501
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF2FB180034A;
	Wed,  7 Jan 2026 11:15:00 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.45.225.235])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A8171800285;
	Wed,  7 Jan 2026 11:15:00 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E3181A80D4B; Wed, 07 Jan 2026 12:14:57 +0100 (CET)
Date: Wed, 7 Jan 2026 12:14:57 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com, newlib@sourceware.org
Subject: Re: [PATCH] Cygwin: Add AArch64 support in config.guess, dfp.m4, and
 configure.ac
Message-ID: <aV5AMflh7_AUdQTR@calimero.vinschen.de>
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	cygwin-patches@cygwin.com, newlib@sourceware.org
References: <PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yFTsZbTcIT3GVdogGmzD4hRw-kjaR4CFzKDLn8cp694_1767784501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

[CC newlib]

Hi Thirumalai,

the config changes in top-level are shared between various projects
(gcc, binutils/gdb, newlib/cygwin) and are maintained centralized.
Please have a look at the top-level MAINTAINERS file and search for
config.guess.

The actual config repo is at
https://https.git.savannah.gnu.org/git/config.git and patches should go
to config-patches AT gnu DOT org.

We can selectively update our top-level config afterwards, I think.


Thanks,
Corinna


On Jan  5 12:49, Thirumalai Nagalingam wrote:
> Hi Everyone,
> 
> This patch adds support for AArch64 targets across the build
> configuration files.
> 
> The changes include:
> - Recognizing aarch64-pc-cygwin targets in config.guess
> - Enabling dfp support for aarch64, consistent with existing x86 targets
> - Disabling libgcj for aarch64 MinGW targets, matching x86_64 behaviour
> - Ensuring appropriate target flags are applied for aarch64 MinGW builds
> 
> These updates prepare the build system for aarch64-based Windows
> environments.
> 
>   *   No functional changes are introduced in this patch.
> 
> 
> Please let me know if there are any concerns or if this should be split
> into separate patches.
> 
> Thanks & regards
> Thirumalai Nagalingam
> <thirumalai.nagalingam@multicorewareinc.com<mailto:thirumalai.nagalingam@multicorewareinc.com>>
> 
> In-lined patch:
> 
> config.guess  | 3 +++
>  config/dfp.m4 | 4 ++--
>  configure.ac  | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/config.guess b/config.guess
> index 1972fda8e..f7c9844b8 100755
> --- a/config.guess
> +++ b/config.guess
> @@ -911,6 +911,9 @@ EOF
>      i*:UWIN*:*)
>         echo "$UNAME_MACHINE"-pc-uwin
>         exit ;;
> +    aarch64:CYGWIN*:*:*)
> +       echo aarch64-pc-cygwin
> +       exit ;;
>      amd64:CYGWIN*:*:* | x86_64:CYGWIN*:*:*)
>         echo x86_64-pc-cygwin
>         exit ;;
> diff --git a/config/dfp.m4 b/config/dfp.m4
> index 5b29089ce..714bee6b2 100644
> --- a/config/dfp.m4
> +++ b/config/dfp.m4
> @@ -22,8 +22,8 @@ Valid choices are 'yes', 'bid', 'dpd', and 'no'.]) ;;
>    case $1 in
>      powerpc*-*-linux* | i?86*-*-linux* | x86_64*-*-linux* | s390*-*-linux* | \
>      i?86*-*-elfiamcu | i?86*-*-gnu* | \
> -    i?86*-*-mingw* | x86_64*-*-mingw* | \
> -    i?86*-*-cygwin* | x86_64*-*-cygwin*)
> +    aarch64-*-mingw* | i?86*-*-mingw* | x86_64*-*-mingw* | \
> +    aarch64-*-cygwin* | i?86*-*-cygwin* | x86_64*-*-cygwin*)
>        enable_decimal_float=yes
>        ;;
>      *)
> diff --git a/configure.ac b/configure.ac
> index 05ddf6987..7e8a6b1c6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -869,7 +869,7 @@ case "${target}" in
>    i[[3456789]]86-*-mingw*)
>      noconfigdirs="$noconfigdirs ${libgcj}"
>      ;;
> -  x86_64-*-mingw*)
> +  aarch64-*-mingw* | x86_64-*-mingw*)
>      noconfigdirs="$noconfigdirs ${libgcj}"
>      ;;
>    mmix-*-*)
> @@ -3225,7 +3225,7 @@ case " $target_configdirs " in
>  esac
> 
>  case "$target" in
> -  x86_64-*mingw* | *-w64-mingw*)
> +  aarch64-*mingw* | x86_64-*mingw* | *-w64-mingw*)
>    # MinGW-w64 does not use newlib, nor does it use winsup. It may,
>    # however, use a symlink named 'mingw' in ${prefix} .
> 
> 


