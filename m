Return-Path: <SRS0=kRW9=BC=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id ABF884BA2E18
	for <cygwin-patches@cygwin.com>; Mon,  2 Mar 2026 12:46:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ABF884BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ABF884BA2E18
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772455584; cv=none;
	b=D3fxYevIiLEP9mkcZOERlqHA+vUBi2SqB/ZJdJj5excagS/v7HXQMyGaFAzwVYa/TttpE6WcjC9hnNd/VREAbXjKBLzDhsn08DO23yuArC8BqJ0gt3H14A6yLXkOOa/WBK+Br6ObalUIWA1/M2dM6nBAxbFxuEKeIMCb+hfXNaw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772455584; c=relaxed/simple;
	bh=G8FJ9xH5sdoeXT9n8FyBOil/dZMwTytNHkezv88DECE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vZDQSAi3czPt7TZ/0SJla/nY+AYhcEKz0dFlAuX/8zw4p0EO+/1Tf1x9XhJPqtkAd9xMobFh3x5Hfh0/Oc1hpqzaymkAhwc4LTFh8eUzHbyhBbhpTJR/7zL4o6iMBcTxx5xV+6YP530xz/UbKaWHHt6EGErhY0zMlPjWzK7rnwU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ABF884BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Cst+hxo6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772455582; x=1773060382;
	i=johannes.schindelin@gmx.de;
	bh=fCZvg+nPCbjyYSZIBqwS7hbZLfZEG726UAN8rK2b8CE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cst+hxo6wCEXZEOvt8cZkjuE5twgLI5xol4yT3FexS96yY56rqe636KQzrSufwU1
	 U0m3XL39gAtItIJJ2sjtH6MIIPWBagcDcvbESoAR+Gkg5QykY6vqKCTIo9SywEmHv
	 ssEVF10jht9DmNt9n3G646cP1BBd+rR8qDrYcLzKQp3mXv2juxq9eHxn6v6kq/jKZ
	 x4B1CULixGeVBSkT/FNLupR7ng6qM1zV7WqNT79t/oD+bxFDnkib/S+hkInfUBxTI
	 tpRPeIHMZYqOOFIE2QxRtYRk9okqt0Y8MlHCoimnXEO0UNIvnN32Uvl9Yhjkvc30R
	 B2lDx4mHRAodgdtJfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXtS-1w5weE1cmm-00LWzz; Mon, 02
 Mar 2026 13:46:22 +0100
Date: Mon, 2 Mar 2026 13:46:20 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Omit win32-input-mode sequence from
 pseudo console
In-Reply-To: <20260228090138.2540-1-takashi.yano@nifty.ne.jp>
Message-ID: <a37215c4-63cb-3b17-dbe7-9ae29677d39a@gmx.de>
References: <20260228090138.2540-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ujmX2vGInieq1KeN1Bz4cdwadPlMD5IqpB2qR57blTM4NkK60T4
 o6g4KZ6PUppX9Fl2BlS44yCGNDYEKOtBIuHWrgR+F4i7QqvAobE+lQwcpudjtjd0IpqWxkj
 yp54bzFa3oSmiWiIRBotyVy9W1iMXrc6yuKpEV9Xw2jeCtV6y+/H0u4E1XRDXA6kUB7Tz50
 IXkYQOXMYmoWmRZpCat7A==
UI-OutboundReport: notjunk:1;M01:P0:MmqZIAXfElI=;snHh7xVQrUNaqpB75KJjHvNVKHy
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 28 Feb 2026, Takashi Yano wrote:

> In Windows 11, pseudo console uses CSI?9001h which lets the terminal
> enter win32-input-mode in console. As a result, two problems happen.
>=20
> 1) If non-cygwin app is running in script command on the console,
>    Ctrl-C terminates not only the non-cygwin app, but also script
>    command without cleanup for the pseudo console.
>=20
> 2) Some remnants sequences from win32-input-mode occasionally
>    appears on the shell in script command on the console.
>=20
> This patch fixes them by omit CSI?9001h to prevent the terminal
> from entering win32-input-mode.
>=20
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Nice! This patch looks good to me!

Thank you,
Johannes

> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 34a87c6dc..663b0068a 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2694,8 +2694,12 @@ workarounds_for_pseudo_console_output (char *outb=
uf, DWORD rlen)
>  	assert (state =3D=3D 2);
>  	if (outbuf[i-1] =3D=3D '[' && outbuf[i] =3D=3D '>')
>  	  saw_greater_than_sign =3D true;
> -	else if (isdigit (outbuf[i]) || outbuf[i] =3D=3D ';')
> -	  continue;
> +	else if (outbuf[i-1] =3D=3D '[' && outbuf[i] =3D=3D '?')
> +	  saw_question_mark =3D true;
> +	else if (isdigit (outbuf[i]))
> +	  arg =3D arg * 10 + (outbuf[i] - '0');
> +	else if (outbuf[i] =3D=3D ';')
> +	  arg =3D 0;
>  	else if (saw_greater_than_sign && outbuf[i] =3D=3D 'm')
>  	  {
>  	    /* Remove CSI > Pm m */
> @@ -2724,6 +2728,14 @@ workarounds_for_pseudo_console_output (char *outb=
uf, DWORD rlen)
>  	      }
>  	    state =3D 0;
>  	  }
> +	else if (saw_question_mark && arg =3D=3D 9001
> +		 && (outbuf[i] =3D=3D 'h' || outbuf[i] =3D=3D 'l'))
> +	  {
> +	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> +	    rlen =3D start_at + rlen - i - 1;
> +	    i =3D start_at - 1;
> +	    state =3D 0;
> +	  }
>  	else if (outbuf[i] =3D=3D '\033')
>  	  {
>  	    start_at =3D i;
> @@ -2736,6 +2748,8 @@ workarounds_for_pseudo_console_output (char *outbu=
f, DWORD rlen)
>  	  {
>  	    is_csi =3D false;
>  	    saw_greater_than_sign =3D false;
> +	    saw_question_mark =3D false;
> +	    arg =3D 0;
>  	  }
>        }
>      else if (is_osc)
> --=20
> 2.51.0
>=20
>=20
