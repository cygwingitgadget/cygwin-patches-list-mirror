Return-Path: <SRS0=JvsG=ZH=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id CE1473858410
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 22:55:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CE1473858410
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CE1473858410
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750805719; cv=none;
	b=DBnMDnqevHHXQGnTRjbZOeiavS/50jnYwxDcBK+UMNp0Y0xjNSY1/wMHnop2hpgmZxRfOQAMVkPJnfkmDzomE29K4DSbuTDrmtFUtORI5AVnlCDcw0SxP7qP4Fd0u2LwpLSPFTVb/TvDqWBKPIxHoLnPytfDTETOvtayRCX+GLM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750805719; c=relaxed/simple;
	bh=ebpVkX1FlG87kZNX5y2m56D1HcdxG/0JouR9VExwwqA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=XDAdKOq0knHhTfv420nJ7fnx4xcK29oeBZ/16DYTEf8KuGEMm9y2MvxjGT7rg6bTf9vTfY/3ihR43/8Yo/qhCfmCpxvNKTQVMQyBhxJI++3j90FNZmoU/f/TasO4AW3qfMpCxMBiObEKSkSUvw4DmIuwr+wuntjhC//nVXb1qto=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CE1473858410
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=k3YtmOIj
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id AA07745CF8;
	Tue, 24 Jun 2025 18:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=84ZFMRNfmUQztwfSRUmUUlpOLbM=; b=k3Ytm
	OIjbGMkbu6wcRhwBzoi1bwbTPr6e/uanVJIi2whRyiH+NGLEbIhfBpPguDmcDxYu
	S6QoqTh/yuTKeB4dOZf0cdMKaXqm16sSYtATfxM/1M3xL4weCRpc1dsPAwSKW5Hg
	Zn4z3zMNgAeobqaMdtwfdt3Pn1inXoFvrvNabU=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id A3A1245CF5;
	Tue, 24 Jun 2025 18:55:19 -0400 (EDT)
Date: Tue, 24 Jun 2025 15:55:19 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: define ___CTOR_LIST__ and ___DTOR_LIST__ for
 AArch64
In-Reply-To: <DB9PR83MB09231C714B9D3D3166E455DE9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <14bdcfe7-aebd-7790-65fa-17854a253d33@jdrake.com>
References: <DB9PR83MB09231C714B9D3D3166E455DE9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15595026251776-1215347823-1750805719=:11368"
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15595026251776-1215347823-1750805719=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jun 2025, Radek Barton via Cygwin-patches wrote:

> Hello.
>
> This change defines  `___CTOR_LIST__`  and `___DTOR_LIST__` for AArch64=
 in the same way as for x86_x64 as AArch64 uses `pei-aarch64-little` and =
x86_x64 uses `pei-x86-64` COFF formats, which both are defined at https:/=
/github.com/Windows-on-ARM-Experiments/binutils-woarm64/blob/woarm64/ld/s=
cripttempl/pep.sc#L159 resp. https://github.com/Windows-on-ARM-Experiment=
s/binutils-woarm64/blob/woarm64/ld/emultempl/pep.em.
>
> Radek
>
> ---
> From 1dc5dbeb5e8b9f2783ceddc7dcf227bc7b922e08 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft=
.com>
> Date: Fri, 6 Jun 2025 14:12:28 +0200
> Subject: [PATCH] Cygwin: define ___CTOR_LIST__  and ___DTOR_LIST__ for =
AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/cygwin.sc.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
> index 69526f5d8..5007a3694 100644
> --- a/winsup/cygwin/cygwin.sc.in
> +++ b/winsup/cygwin/cygwin.sc.in
> @@ -17,7 +17,7 @@ SECTIONS
>      *(SORT(.text$*))
>      *(.glue_7t)
>      *(.glue_7)
> -#ifdef __x86_64__
> +#if defined(__x86_64__) || defined(__aarch64__)
>      . =3D ALIGN(8);
>       ___CTOR_LIST__ =3D .; __CTOR_LIST__ =3D .;
>  			LONG (-1); LONG (-1); *(SORT(.ctors.*)); *(.ctors); *(.ctor); LONG =
(0); LONG (0);
> --
> 2.49.0.vfs.0.4

LGTM
--15595026251776-1215347823-1750805719=:11368--
