Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id CD7573858039
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:55:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CD7573858039
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CD7573858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750856139; cv=none;
	b=bI5kmS+393R0xEIKeEzC3wPDf5np77HsaR2iY+p5V+8P0DF8SX2Qd4k/uLrTgLsmRULaYrPbZf/taA2g3jo7B/MvBystWQHJqQw+3ZJINDXcazWNEk1Ah93symfNxLCTmzsf0TFxQa5kPlQnnyj3ndx5UKCw6k5QcJKLsYlDt30=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750856139; c=relaxed/simple;
	bh=Ljwdq0EBdauVq5S5GMDP5q8s92DmGPujfbdKCjaore4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=B8yEhYM6XPSQ0/iD/L2vZqOx54bO1/sGtTbceasbc2BbzxD8LWYE4PnpX5ADYqcXS514N77Be4GwOFcPQ7F9yJO7UY+hw9rV5t24Cams3CntibhQT3pGXXOFnq70nLQ/qwkGqXlnUqv0tGbuJgzJWb+gcK7wDeY/82EArhTOpUA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD7573858039
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jVLNu3GZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750856137; x=1751460937;
	i=johannes.schindelin@gmx.de;
	bh=v7AWURKCG/RCoqbv326cgF55P895oW/PEWzI7U2ckbA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jVLNu3GZ10iVyzg8yEXVNNGA6ci7nmFz1Wg6V+Xg0qup79wnfPeP+gVpt/jPSsCa
	 8HhR55qhvb55Nm3tzzg8wy/zD6mHfNQ8ls/h6SvZ+npu/N1Layn5xTHrLPBPoM4Wx
	 Ae2Y3s0o/RAsD5PmUUu41foSbExEePbJ+zqxqM0au7h29QrxYJMtcRlrDg5Rx8Yr/
	 IHuheJFwvBs/xY72rFTWecQf8kwIgo9gAqIn0P7MbVIhVQGpQQU4b0iv8P5cX5xx+
	 i5w8tC/NoqMM1aK2iPBgfzx7bgx5/yfXXo44NpaSJ1UA7wMwZvmK6OmTB55pCMxKd
	 PngFD8LPVkscORoWKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1uDqiT1mtw-00LV9q; Wed, 25
 Jun 2025 14:55:37 +0200
Date: Wed, 25 Jun 2025 14:55:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pipe: Simplify raw_write() a bit (stop to
 use chunk)
In-Reply-To: <20250625114202.927-1-takashi.yano@nifty.ne.jp>
Message-ID: <db956baa-e4e1-68cb-e5b2-349a113c7654@gmx.de>
References: <20250625114202.927-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dUbfEm/DB+gQ75zzHjUsPRVibLg5sshHrr51pnHiD2jqjQTupea
 pvSP97hDac8/9+oSnFlEviH+8XcpC+bTg12ZG7UH0/suCT8SgPSX8o5rYyLBkwmaSrVyxQv
 sWp+Osu7Ikje3bhKAYKx4zUFlpE2IRjZY4ZOTkd7qNiJRFu9jXa2UfBXhsN+fzgBqgbwVhk
 2a8SP7sqiKbUaOs3+21Ug==
UI-OutboundReport: notjunk:1;M01:P0:ipu5RSLYtrI=;FU+XasIctAsWXPU0vasTWFqpy1i
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Jun 2025, Takashi Yano wrote:

> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>

This is way too terse. There is a difference between being succinct and
leaving things unsaid.

Also, please make sure that v2 is a reply to v1 of the patch. I almost
commented on v1 by mistake.

> ---
>  winsup/cygwin/fhandler/pipe.cc | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index e35d523bb..c35411abf 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -443,7 +443,6 @@ ssize_t
>  fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>  {
>    size_t nbytes =3D 0;
> -  ULONG chunk;

Okay, removing this local variable is a good indicator that this diff
shows all the related logic, without having to resort to looking at the
entire `pipe.cc` file that is not reproduced in this email.

>    NTSTATUS status =3D STATUS_SUCCESS;
>    IO_STATUS_BLOCK io;
>    HANDLE evt;
> @@ -540,11 +539,6 @@ fhandler_pipe_fifo::raw_write (const void *ptr, siz=
e_t len)
>  	}
>      }
> =20
> -  if (len <=3D (size_t) avail)
> -    chunk =3D len;
> -  else
> -    chunk =3D avail;
> -
>    if (!(evt =3D CreateEvent (NULL, false, false, NULL)))
>      {
>        __seterrno ();
> @@ -561,8 +555,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size=
_t len)
>        ULONG len1;
>        DWORD waitret =3D WAIT_OBJECT_0;
> =20
> -      if (left > chunk && !is_nonblocking ())
> -	len1 =3D chunk;
> +      if (left > (size_t) avail && !is_nonblocking ())
> +	len1 =3D (ULONG) avail;
>        else
>  	len1 =3D (ULONG) left;

So there is a subtle change here, which _should_ result in the same
behavior, but it is far from obvious.

If both `left` and `len` are larger than `avail`, the behavior is
obviously the same as before because `len1` is clamped to `avail` in that
instance.

If `left` is smaller than `len`, and `len` is smaller than `avail`, `len1`
is clamped to `left`, same as before. But even if `left < avail < len`,
`chunk` would have previously been set to `avail` and the behavior is the
same.

Since the variable `left` is defined as `left =3D len - nbytes`, it is nev=
er
larger than `len`.

Without giving a simple overview of this in the commit message, every
reader will have to (re-)reason out this finding, which is suboptimal.

Please improve the commit message, for that reason.

Also note that this patch conflicts very much with
https://inbox.sourceware.org/cygwin-patches/62e79c50daf4e3ae28db3ae1a3cf52=
460f0d8968.1750775114.git.johannes.schindelin@gmx.de/
and it would therefore make most sense to focus first on landing that
patch, then redo v2 of this here patch on top.

Ciao,
Johannes
