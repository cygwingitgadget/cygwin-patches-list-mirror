Return-Path: <SRS0=+fqX=DZ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id BEFCE4BA540B
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 13:33:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BEFCE4BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BEFCE4BA540B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779975209; cv=none;
	b=mtOaHdv7J6HA7hwnxM4u6hDMNcz7B5US0ZQeWKD6tqHMuCUEe9vDX7bfbbBvZAoPVRjhXyYEEXlttzGV7WTMuuQFXtCmnlXzDyZVkuNOVj3NBZqv3L+Gn2aHfl/fxTvjNfkCea7BTNubHWrlzj2ZYzMT25nurjWd+awa9oWSUNw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779975209; c=relaxed/simple;
	bh=56Ofx1j+VtI2Rke4EJiThJz8dp6Ztn1LW5AXLcXewtg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=qjG2Q564PZIZTjM8dYf+CCH2BxzuPiwO6BNF8DD8BrNrXuG254AsCQ1i/RSubZhBMFEaWXpxmWnHjB0fpb9vn826QVsd7Na5dBpM3b7SsybmdrxnGWnDX0R/vfQx8wQ2Pbu3NXG8+pf4iEQwPGSKi7BcYRLAvcO8HnoOjlvF+YM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Zn3InwcA
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BEFCE4BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Zn3InwcA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779975207; x=1780580007;
	i=johannes.schindelin@gmx.de;
	bh=HUeMkTzTXOVEYMYB1Y2H+n7Q6fW3luYnorz7fwX3noM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zn3InwcAnOSOuyJuLfQ6/RkvpFdSyviMEtT2nfrcF+WISUMqhn6N8Xmo1vLX7RHy
	 PxprG11xheJYlgVJe7UhM5en54q8QEn/PPl+bjoo4mMvFN4ajeVtRI2OxRPcXci3V
	 W9DRJXYe2WIxncFXMb7kQWNzjNdiTtYdB9r9Jv/S5GMsu27awOHZg3qWl4PssZ15O
	 pTrV5Oghxu+RL8bYFBlsIdZg/bGV+ugEm1vDvNfS3rS50Bgt9XFt4HM02fW8A86Zg
	 gAzcokPFORBnOHynS6JeGN0QxJ5fJ0pIbFqfIA2mftzJRNsdHu6fPfJ2PzaFsKCA1
	 yW5UOiNtjAh6PzGcwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1wgIGT0Q7u-00WE2d; Thu, 28
 May 2026 15:33:27 +0200
Date: Thu, 28 May 2026 15:33:24 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix handling of surrogate pairs
In-Reply-To: <20260526095224.1958-1-takashi.yano@nifty.ne.jp>
Message-ID: <7cbdd3da-8d1f-c836-8873-0b4207f0f98e@gmx.de>
References: <20260526095224.1958-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6VQFxfoKwgBhIE+YB/431wdy9PFxrIl/mlbuvQuaX7ePZKZQSSh
 KEHuSz+UOr8Meqilu+GunNUOvaR3rHayvYk/oL+BeY41gCOnhvYk069Tiod3LA6JCTBFSdz
 rkE11eF/hUisw8bAZWGkNLaTDkLc2RRs/0gTvLLfM9HSPXKndlYzozKhqdtVvPI7H+3S5Vf
 KIr8Se/BL0+5Y89luw0jA==
UI-OutboundReport: notjunk:1;M01:P0:ihFL/KuAHK4=;BHaQM+PAhYRq6g11XF6xGSla7eR
 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
 Hp2KuYCUarC1yaqV2Q=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 26 May 2026, Takashi Yano wrote:

> The commit 782aac590af7 introduced surrogate-pair handling. However,
> it does not work as expected in the legacy console. This is because
> a KeyDown event for ALT key with UnicodeChar =3D=3D 0 is inserted the
> between surrogate pair. The current code reads the next key event
> unconditionally for the second UnicodeChar, but it is not correct.
> This patch searches the next appropriate key event with a valid
> UnicodeChar, ensuring that the second code unit is valid.
>=20
> Fixes: 782aac590af7 ("Cygwin: console: Handle Unicode surrogate pairs.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 6fd4cd965..45eff6efe 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1452,9 +1452,21 @@ fhandler_console::process_input_message (void)
>  	    }
>  	  else
>  	    {
> -	      WCHAR second =3D unicode_char >=3D 0xd800 && unicode_char <=3D 0=
xdbff
> -		  && i + 1 < total_read ?
> -		  input_rec[i + 1].Event.KeyEvent.uChar.UnicodeChar : 0;
> +	      WCHAR second =3D 0;
> +	      DWORD second_pos =3D i;
> +	      if (unicode_char >=3D 0xd800 && unicode_char <=3D 0xdbff)
> +		for (DWORD j =3D i + 1; j < total_read; j++)
> +		  {
> +		    /* Do not check bKeyDown. bKeyDown is 0 for surrogate
> +		       pair in legacy console */
> +		    if (input_rec[j].EventType =3D=3D KEY_EVENT &&
> +			input_rec[j].Event.KeyEvent.uChar.UnicodeChar)
> +		      {
> +			second =3D input_rec[j].Event.KeyEvent.uChar.UnicodeChar;
> +			second_pos =3D j;
> +			break;
> +		      }
> +		  }
> =20
>  	      if (second < 0xdc00 || second > 0xdfff)
>  		{
> @@ -1465,7 +1477,7 @@ fhandler_console::process_input_message (void)

It's a bit unfortunate that the diff here hides the fact that the
following is in the `else` branch...

In any case, the patch makes sense to me, and I really appreciate the
commit message that puts the diff into context.

Thanks!
Johannes

>  		  /* handle surrogate pairs */
>  		  WCHAR pair[2] =3D { unicode_char, second };
>  		  nread =3D sys_wcstombs (tmp + 1, 59, pair, 2);
> -		  i++;
> +		  i =3D second_pos;
>  		}
> =20
>  	      /* Determine if the keystroke is modified by META.  The tricky
> --=20
> 2.51.0
>=20
>=20
