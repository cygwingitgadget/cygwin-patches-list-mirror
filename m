Return-Path: <SRS0=kvBp=ZY=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 240B73858D1E
	for <cygwin-patches@cygwin.com>; Fri, 11 Jul 2025 18:09:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 240B73858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 240B73858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752257394; cv=none;
	b=caVFS6gRW37D1UzI9h+nuQYR4voMXaoH9gXNutzsnNm3nBAcBC/GL0rvI949Y6+TxXm2G4Dtgk3o1no+9ohbpv92iKW1jEAfV/ya1ORsVWiNJZ4OPvzp//UIAGCu/eETFbtA1pXzQsqvl9ftmghCVTCR8uj3dE3aYBvsH9PLRwM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752257394; c=relaxed/simple;
	bh=6n0P++opngKXLO2lvbNRM0Oe9aOORu0Knjq/7yP8lN8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ckmTJWsFsRLNdnk14Fw+BYqCt0ZKlMNoEfXO3BZcyD9xu7DAE5+eHb8nOeauDDkWO4Ejv1p06e/gs3rLfYiTKzc33NyQHbHGJfi+Z+WnM4sEBdUImp7HKhDVdOnhS8N9oq/QzzlTQvGMqyKocXEXz0f0YcgDo/cXe5ycXh/7j/8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 240B73858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=uKNgU8yj
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id F355F45CC5;
	Fri, 11 Jul 2025 14:09:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=nJixXwPxvPx9/KjuUt7CsifN5LY=; b=uKNgU
	8yj9w5V565Tl0J9RYdfXbS7avWv2Psut20jX1xZ+8DWY/y4JUnhPIs/VnD+swB/6
	L88IhI8DWwl9sruIZtLtivf/9LCzqCfOrivwsoxP9N9Z00jcEyR2NUuySuJfQfLK
	5zZS9ZDTtHFR89vblklOGvMk+8a/WgrY1Na1Gc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id EDB8045CBF;
	Fri, 11 Jul 2025 14:09:53 -0400 (EDT)
Date: Fri, 11 Jul 2025 11:09:53 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: winchild: fix missing stdlib.h
In-Reply-To: <DB9PR83MB0923E35BD3BF01AA01217A45924BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <0f61cece-ebe3-d091-eb27-bc0bb8023f2a@jdrake.com>
References: <DB9PR83MB0923E35BD3BF01AA01217A45924BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="12017318494208-2143896231-1752257393=:74162"
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--12017318494208-2143896231-1752257393=:74162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Jul 2025, Radek Barton via Cygwin-patches wrote:

> Hello.
>
> The `posix_spawn/winchild` test was added recently by 2af1914b6ad673a20=
41cf94cc8e78e1bdec57a27 commit. It fails to build for AArch64
> due to missing `stdlib.h` header where `malloc` and `free` functions ar=
e defined. This patch fixes the missing header.

Oops.  I'll apply this, thanks.

>
> Radek
>
> ---
> From 9a2b435dd837bbc0baba16a5ef8dbcff1bdeabf5 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft=
.com>
> Date: Tue, 1 Jul 2025 17:49:55 +0200
> Subject: [PATCH] Cygwin: winchild: fix missing stdlib.h
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> The posix_spawn/winchild test was added recently by
> 2af1914b6ad673a2041cf94cc8e78e1bdec57a27 commit. It fails to build for =
AArch64
> due to missing stdlib.h header where malloc and free functions are defi=
ned.
> This patch fixes the missing header.
>
> Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> ---
>  winsup/testsuite/winsup.api/posix_spawn/winchild.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/winsup/testsuite/winsup.api/posix_spawn/winchild.c b/winsu=
p/testsuite/winsup.api/posix_spawn/winchild.c
> index 6fdfa002c..43fd35c58 100644
> --- a/winsup/testsuite/winsup.api/posix_spawn/winchild.c
> +++ b/winsup/testsuite/winsup.api/posix_spawn/winchild.c
> @@ -3,7 +3,7 @@
>  #include <winternl.h>
>  #include <ctype.h>
>  #include <stdio.h>
> -
> +#include <stdlib.h>
>
>  int wmain (int argc, wchar_t **argv)
>  {
> --
> 2.50.1.vfs.0.0
>
>

--12017318494208-2143896231-1752257393=:74162--
