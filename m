Return-Path: <SRS0=dvnW=CF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 5ECAD4BA2E1C
	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2026 08:14:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5ECAD4BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5ECAD4BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775463265; cv=none;
	b=Rr74dII/gyjRmkFh/ABgnvADhFpds7ctAoFabpmRYiN0M83yB0RcFnzao8WJ2esYLw0QP2AaBdgkHtpsCCUVFc+t73TVbykkZwanz7BaM6FAmuLHVTrel/n+Frm0fecHk3NouzUaTiUrV0JLFp1MrdYTqkrf9o8ziXASlfvbUZY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775463265; c=relaxed/simple;
	bh=tmQlZBeVCu7bbJfrhiksi1SRheKkIycVOcGZmuLjs74=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=fhzK0pXKymil/IE3ihE8x/hlpyUqNJ4TMq1oYw+am18wXiLGGqX8bcppWS6o2eO3PGdRR6Ncq1KMwrQO1KGeVabD2qVYcQb8Ns2L4Iwb1FVuHtVKIFCaLApDsfzdVLx87r2MHEyzjI5I4rAqImuWEwH4IB/QCVdgB+3Xt0Oi6PU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5ECAD4BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=MN2ckOvK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775463264; x=1776068064;
	i=johannes.schindelin@gmx.de;
	bh=5zk2xa3H9NZNsT/z3y0sb0J023kjV7pvKaazyROJGbk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MN2ckOvK1/6cuOYnKiw+O95uaymen2ZpkBlvk7hCTfTeW6I2+OCgoOqeiwa/YRLS
	 7AobWaSfklfj+diftq2mPC23XUE15st3fsH5nWVDd2IMA3hsCc66vHs1tdA1SZMzV
	 GSnYCHtmyiWmfziHbYSnWnqByfdwcUmJcMSI7Lg0YYB0B1de/n/8RsNB6WiNJCDlJ
	 M5z3ZYpOgIJI4cZYEg7DgKjJtEj6Vq298+FMZLDwXaOdmzStaKPRKkQX3HRt923PB
	 kUmz+xroRZ0hJfILcx50QfPfKuCJ6EoBkvhOQfKyRDPXKsm6UF1ci1/6GkLS+f5WO
	 sgxhTK57vKo8Ds1+yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCpb-1vasVz0Eop-00gkvn; Mon, 06
 Apr 2026 10:14:24 +0200
Date: Mon, 6 Apr 2026 10:14:22 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make pcon_start handling more multi thread
 durable
In-Reply-To: <20260325130917.68025-1-takashi.yano@nifty.ne.jp>
Message-ID: <22c40c24-dcb1-7386-629b-adc41e3c91e2@gmx.de>
References: <20260325130917.68025-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vdCbOW5z+M6JxmfpkynLNQg+JhotjJRJ1zFxlUg3XQ5nHava7Cn
 1n+VXVp1tfM89Nb01rXHBJ/Zb5vgSIFlQG4Yl5gjxJt6E3+zaBTZvLFB+ThEPm2p5mnolln
 iX2RFgwFxKqOEG4WPvCsIe8ijq/BAyMi+KYOlgOKgzpGtvnuURhGkmjI5ieQysjIxqa9AUm
 GZx0Qt3WJLKHoMVM1DfDA==
UI-OutboundReport: notjunk:1;M01:P0:jAMnmpMdsew=;+moxtdYeZ21AfKOuRoAOmyXh99Q
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 6 Apr 2026, Takashi Yano wrote:

> Currently, if the CSI6n response is devided into "CSI10;2" and "R",
> and another thread call master write() with "c", the data written to
> nat pipe will be interleaved like "CSI10;2cR". The first "CSI10;2"
> make the 'state' 1, and in state =3D=3D 1, all the data written goes
> to 'wpbuf[]'. This may break statup of pseudo console.
>=20
> With this patch, the thread ID of the thread that write the first ESC
> char to 'wpbuf[]' is stored in 'wp_tid', and only if the thread ID
> matches 'wp_tid' will be written to 'wpbuf[]'.

This looks correct and well-targeted. The interleaving scenario you
describe is a real problem, and keying on the thread ID is a clean way to
ensure that only the thread which initiated the escape sequence gets to
append to wpbuf[].

Two small typos in the commit message that are worth fixing before you pus=
h
(to make Corinna happy :-) ):

	s/devided/divided/

	s/statup/startup/

> Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.=
")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 8e6fb9c23..dda892269 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2230,6 +2230,7 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>        static char wpbuf[wpbuf_len];
>        static int ixput =3D 0;
>        static int state =3D 0;
> +      static DWORD wp_tid =3D 0;
> =20
>        DWORD n;
>        WaitForSingleObject (input_mutex, mutex_timeout);
> @@ -2242,8 +2243,9 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  		line_edit (wpbuf, ixput, ti, &ret);
>  	      ixput =3D 0;
>  	      state =3D 1;
> +	      wp_tid =3D _my_tls.thread_id;
>  	    }
> -	  if (state =3D=3D 1)
> +	  if (state =3D=3D 1 && wp_tid =3D=3D _my_tls.thread_id)
>  	    {
>  	      if (ixput < wpbuf_len)
>  		wpbuf[ixput++] =3D p[i];
> @@ -2259,7 +2261,7 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	    line_edit (p + i, 1, ti, &ret);
>  	  len =3D orig_len - i - 1;
>  	  ptr =3D p + i + 1;
> -	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
> +	  if (state =3D=3D 1 && wp_tid =3D=3D _my_tls.thread_id && p[i] =3D=3D=
 'R')
>  	    state =3D 2;
>  	  if (state =3D=3D 2)
>  	    {

One very minor nitpick. The code continues like this:

	  if (state =3D=3D 1 && wp_tid =3D=3D _my_tls.thread_id && p[i] =3D=3D 'R=
')
 	    state =3D 2;
 	  if (state =3D=3D 2)
 	    {
	  [...]
 	  ixput =3D 0;
 	  state =3D 0;

In this state=3D=3D2 cleanup block, `state` and `ixput` are reset to 0 but
`wp_tid` is not. It is harmless since the next pcon_start will overwrite i=
t
when state transitions to 1, but resetting `wp_tid =3D 0` here alongside t=
he
other variables would be slightly cleaner for readability. Up to you.

Note for the record: this patch has an implicit dependency on the earlier
"Fix write data handling in pcon_start phase" patch being applied first.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you,
Johannes

> --=20
> 2.51.0
>=20
>=20
>=20
