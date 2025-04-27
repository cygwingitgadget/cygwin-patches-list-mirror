Return-Path: <SRS0=Z5Ax=XN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 259473858D1E
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 21:20:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 259473858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 259473858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745788825; cv=none;
	b=tA0Yj9I/9HxP2LltYrzdS/6iDBUnxzJg49lXgSD96fF/XLs3V6zfxubt3IfBf2rpzc+aoaOaX2tKlU14qKMxMB3Nl4Jz1fggh361KBgsirEA4dEbbqRIV6lLZ4kkofn6rb6ENZeADbW3fVhKBnOEoRmdu+wOCckorsvGKpkys9U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745788825; c=relaxed/simple;
	bh=u9ruAfHr1IvPhbMGL5+zovPTWZ42UXl3T1igFxTFShg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=r4MdEXPLKr8FI3MS9QkEz50avA8Ldl6EHfooqdF6u3eZdxwKzZ4Ckv6LV+iRmSZRT/XbwqWA//IufvaOS6/N4/8XuV1F0tsmE8nGwp4CFXdfjBXIJQo7zvKrx2mqyq1WgDAv0bgBGvJZqTIXIreNchi4XYg/dkgVCx7DLC3wYp0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 259473858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=qBdJf7gW
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CFFD945C68;
	Sun, 27 Apr 2025 17:20:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=wB+DKiEzvD0orL/bl+hZp+ajEeg=; b=qBdJf
	7gW57hVQZsVm3H0/6ubpJH4eoNK6BiRYmZPu6YPk1s7G3up9/4XSe3UJIY33kW7S
	njdz8DLLuTznP1uiJZZ2r2BJy+fETiTPax/7vhZZz+rXgo/nBMcLQI8okBIl4Jo3
	ki5V7ZjUrRoMYQOwIBQFk7eP6JVo4q7RgVZYHo=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C8A8145C64;
	Sun, 27 Apr 2025 17:20:24 -0400 (EDT)
Date: Sun, 27 Apr 2025 14:20:24 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: CI: Add running on arm64 to stress test matrix
In-Reply-To: <20250427210504.1962-1-jon.turney@dronecode.org.uk>
Message-ID: <2fd01fbc-e56a-e01d-a93e-6872bbe4a9ea@jdrake.com>
References: <20250427210504.1962-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 27 Apr 2025, Jon Turney wrote:

> Use an output variable from cygwin-install-action to inform where we
> unpack the just-built cygwin artifact, because apparently the Windows
> ARM64 runners have a different configuration (no D: drive).

There's actually an issue open about that - apparently the VMs do have the
faster drive virtual hardware used as D: on the other Windows runners, but
it's not formatted or mounted on these new runners.

LGTM

>
> Also, drop unused 'target' variable from that matrix
> ---
>  .github/workflows/cygwin.yml | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
> index fa00834ce..54d7de1bb 100644
> --- a/.github/workflows/cygwin.yml
> +++ b/.github/workflows/cygwin.yml
> @@ -204,14 +204,18 @@ jobs:
>    windows-stress-test:
>      needs: windows-build
>
> -    runs-on: windows-latest
>      strategy:
>        fail-fast: false
>        matrix:
>          include:
> -        - target: x86_64-pc-cygwin
> -          pkgarch: x86_64
> -    name: Windows tests ${{ matrix.pkgarch }}
> +        - pkgarch: x86_64
> +          runarch: x86_64
> +          runner: windows-latest
> +        - pkgarch: x86_64
> +          runarch: arm64
> +          runner: windows-11-arm
> +    runs-on: ${{ matrix.runner }}
> +    name: Windows tests ${{ matrix.pkgarch }} on ${{ matrix.runarch }}
>
>      steps:
>      - run: git config --global core.autocrlf input
> @@ -219,6 +223,7 @@ jobs:
>
>      # install cygwin
>      - name: Install Cygwin
> +      id: cygwin-install
>        uses: cygwin/cygwin-install-action@master
>        with:
>          platform: ${{ matrix.pkgarch }}
> @@ -233,9 +238,9 @@ jobs:
>        uses: actions/download-artifact@v4
>        with:
>          name: cygwin-install-${{ matrix.pkgarch }}
> -        # the path specified here should match the install-dir of
> -        # cygwin-install-action above, so we unpack the artifact over it
> -        path: 'D:\cygwin'
> +        # use the install-dir of cygwin-install-action above, so we unpack the
> +        # artifact over it
> +        path: ${{ steps.cygwin-install.outputs.root }}
>
>      # This isn't quite right, as it just overwrites existing files, it doesn't
>      # remove anything which is no longer provided. Ideally, we'd make a cygwin
> @@ -255,7 +260,7 @@ jobs:
>      - name: Capture logs artifact
>        uses: actions/upload-artifact@v4
>        with:
> -        name: stress-logs-${{ matrix.pkgarch }}
> +        name: stress-logs-${{ matrix.pkgarch }}-on-${{ matrix.runarch }}
>          path: |
>            logs
>        if: ${{ !cancelled() }}
>

