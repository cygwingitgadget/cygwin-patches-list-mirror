Return-Path: <SRS0=qb86=BH=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 60AE84BA2E10
	for <cygwin-patches@cygwin.com>; Sat,  7 Mar 2026 08:27:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 60AE84BA2E10
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 60AE84BA2E10
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772872040; cv=none;
	b=Ogwy/ipPFXC8HNXTmfNl6hCH+zMpT9Ssr1cxs3UdgbZULvjVKFL/KR2vBEBg4HsYbzYvUFyx0ulZbNsM8sPGnyH1YAvtrcCZW6DvC/U5l9FxKj1hjyn5i0rqUxXgpw/ngrRWf217btSC1TLrduubQpJr8VqJEwbs7bUBBJqo/UA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772872040; c=relaxed/simple;
	bh=TxB2DOWGkCGToT4H++Zg320ZZXU7z+V1WFJzZRX3Z8g=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=VXNB3Zy2vXchx1aj9X5Y0ER8E5RdAp+J5PD8cUsUv8rzjQ07x30lVaBAmFgkWY6Qpb4adSYWW2HpS3r+8a0mUpKU5oU/XmzLQHGFdqEsdO47iJIa/+TTdT1FQiQnxqnXvZM0QZWTBRdVkJHldwEWW0rEizX9SBTQcfB22e9kTdM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60AE84BA2E10
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=kvpSTG+0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772872039; x=1773476839;
	i=johannes.schindelin@gmx.de;
	bh=pL0U6EKquKYcCfzKkwu3HslA3fAas/0aJ+mSlwBKGqw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kvpSTG+007tI501Ra2vYXBsiq2x9fNKN/oY5U1pKH/0c+P8YOdjEHXAL2fH9ybwW
	 ORyQ3K/wVwdfw1Dwl5M037T9LBQD+FsXF1PCqObwh5SX4KdlDwB9BKR2DrP+W3Xge
	 iCTtxMPqpcRgt6m8J5zp8QTJtRLAPGefPi10L9ohRaO6g7tmHqezhIv52gYFdpQZ4
	 iLnRnZCIXEKeyqNbP3UJG9nXPAI5MY2kRREB8FMBkszqQB07gUMnqCg2c9qU/YsDr
	 y9ewGl6F8oyyOYqqS8fJQDcH42RY3uJxiKboxUHNcup3/gv4E/0u7vsqE0pQhdSQz
	 3XykUFmySfIwaYK9Mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1wJ6LZ03UE-00VmOq; Sat, 07
 Mar 2026 09:27:19 +0100
Date: Sat, 7 Mar 2026 09:27:17 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Use consistently first pty slave found in
 cygheap_fdenum
In-Reply-To: <20260228090219.2551-1-takashi.yano@nifty.ne.jp>
Message-ID: <fa6eed40-2966-26dc-e1e3-e7955cbbaa12@gmx.de>
References: <20260228090219.2551-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:omZbuHFlsaE3LXX52/5WAkxRcg2qudOFwQVU3CfPoxXKWXAPe+s
 595ZPTMhC6phRoGvsHsNR1AV2OCE8ejlZbMRj6kjnNRfHCakl+63pVr2lAceV1oegrNkXfK
 ffYb10+Z34YiZp54hVz8z2o458waSROMl5kU6p9Yw8te0/PhFn4WvRDoN7MqEnFu5BG5aFR
 nMU4biJe420MBZNr/B5rw==
UI-OutboundReport: notjunk:1;M01:P0:g5dzcVEIVtM=;aq9gGruWKTlbWgleY0cTI9sQgd3
 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
 BZ9wdPuQ/DVjMQ5VWoBjiGhShkBqO
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 28 Feb 2026, Takashi Yano wrote:

> If non-cygwin app is started in GDB and terminating it normally,
> re-running the non-cygwin app might fail in setup_pseudoconsole().

Could you paste the exact symptom into the commit message? That might help
readers like myself understand better what motivated/necessitated this
patch.

> This is because set_switch_to_nat_pipe() uses the last pty slave
> instance found in cygheap_fdenum while the clearnup uses the first
> pty salve.
>=20
> With this patch, the first pty slave instance in cygheap_fdenum is
> used for setup and cleanup consistently.

That explanation makes sense to me. What I struggle with is to connect
this explanation with the change in the diff: an added `ptys =3D=3D NULL`
condition in `set_switch_to_nat_pipe()`, which does not look related to
first vs last pty slave nor to setup/cleanup.

Maybe the commit message could be improved to help readers understand the
connection?

Thanks,
Johannes

>=20
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 663b0068a..d4b2896e1 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -105,7 +105,7 @@ set_switch_to_nat_pipe (HANDLE *in, HANDLE *out, HAN=
DLE *err)
>        if (*err =3D=3D cfd->get_output_handle () ||
>  	  (fd =3D=3D 2 && *err =3D=3D GetStdHandle (STD_ERROR_HANDLE)))
>  	replace_err =3D (fhandler_base *) cfd;
> -      if (cfd->get_device () =3D=3D (dev_t) myself->ctty)
> +      if (ptys =3D=3D NULL && cfd->get_device () =3D=3D (dev_t) myself-=
>ctty)
>  	{
>  	  fhandler_base *fh =3D cfd;
>  	  if (*in =3D=3D fh->get_handle ()
> --=20
> 2.51.0
>=20
>=20
