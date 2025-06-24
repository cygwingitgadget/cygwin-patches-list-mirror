Return-Path: <SRS0=JvsG=ZH=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 78FB43858410
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 22:56:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 78FB43858410
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 78FB43858410
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750805772; cv=none;
	b=M8+oxBNh6pf2oncGNxF78PHLGlI1xM/mdP1gjp96AxTqnK45rh6GYvF0+VGxCZxzzAii6Xbu/RUM6tWmJihdWuVfZQ+9Xxoot+kDRsSptsr+AQZr/JO35FgaG2Q+xThxZRdxKSN4Tn5Z7zSBGLpv2iPLUStUFimXUWzAD5PvQD8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750805772; c=relaxed/simple;
	bh=77WbVqT0Dc7dmqGJWN9YQbQ3qp9isZNhk891U5olpgI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jD5brT0PTX5AxlV2HRd0Suag5M84rhvrtQxsJVS3lvw0hINX1uPyhwRB+B6wJyGJJ0bEONQfjPivKlcv/WvnJCDzWf8nkZiWoaa2VK0OCd6fv+oeceV9ZdwMv42sQiSDcgbFILq6PAAK+bTmi+Go9mWu4DvBR10of4IZZsN3qDc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 78FB43858410
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Iq/qk2qz
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 5755E45CF8;
	Tue, 24 Jun 2025 18:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=uowXwkQDQ2JSOqeXgnfS7xaKLG0=; b=Iq/qk
	2qzATIaAfc5jVVhsxOf6+VjescAtuadSF03LXr8Nv7OZyAND8DMaknevIIeAyySq
	acFNOq0Gb07hHruFdO4haqSrhngKyZqFgbiP2rv5nbdn+TWPPpFyHiVzq6NSjMNE
	ZmjjBAiiFS4auwtfhpRdmmmfGs3ucIH3zK5vBE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 53E3845CF5;
	Tue, 24 Jun 2025 18:56:12 -0400 (EDT)
Date: Tue, 24 Jun 2025 15:56:12 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for
 AArch64
In-Reply-To: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <8c7cbfca-ade5-d0a5-92c4-b5df7adff17e@jdrake.com>
References: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15599321219072-950127010-1750805772=:11368"
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15599321219072-950127010-1750805772=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jun 2025, Radek Barton via Cygwin-patches wrote:

> Hello.
>
> This change defines `OUTPUT_FORMAT` and `SEARCH_DIR` in `winsup/cygwin/=
cygwin.sc.in` file for AArch64.
>
> Radek
>
> ---
> From 420a2c9bd13c338c037e583b663ccdabf4c02cd4 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft=
.com>
> Date: Fri, 6 Jun 2025 14:13:16 +0200
> Subject: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch6=
4
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/cygwin.sc.in | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
> index 5007a3694..3322810cc 100644
> --- a/winsup/cygwin/cygwin.sc.in
> +++ b/winsup/cygwin/cygwin.sc.in
> @@ -1,6 +1,9 @@
>  #ifdef __x86_64__
>  OUTPUT_FORMAT(pei-x86-64)
>  SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=3D/usr/li=
b/w32api");
> +#elif __aarch64__
> +OUTPUT_FORMAT(pei-aarch64-little)
> +SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api"); SEARCH_DIR("=3D/usr/l=
ib/w32api");
>  #else
>  #error unimplemented for this target
>  #endif
> --
> 2.49.0.vfs.0.4
>
>

LGTM
--15599321219072-950127010-1750805772=:11368--
