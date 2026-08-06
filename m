Return-Path: <SRS0=uKAS=F7=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 987294BA2E35
	for <cygwin-patches@cygwin.com>; Thu,  6 Aug 2026 14:27:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 987294BA2E35
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 987294BA2E35
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786026433; cv=none;
	b=IEismwXSnJOwqsDdGrwEJkep0ZOQEzKzMOAQuWFVL5hQuFQ8CQgrd/SwQmLpXj1QIZLatoW17eq7JSkVOno0+EK7SWVQK02bnuYaciJ+17sdB2FM7OYHiS0SKE4lnHabaT9EIQIwVpdDnun2J3xllBz5CVKvDIwPJyki6Y8JnVw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786026433; c=relaxed/simple;
	bh=3/VzyCTKup9/zsaoJUaA3IBiQ7aAqAHTw/regdZIXnY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ciigv++NBuJWf/lhhey0BMjZjY2Zq455hDTY3twaGUb6s1Ir54IkDqSjGIJnaBwREDQ2A10F1IeMO6f1PpmuroPll89KUTPRMPP22QA4ocq9/PkMF6Oz2VpYGKRRUvkDpk58m7AW6USnsn2kWhZpZgoDSKCwMbKcLOZJTraDxfQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Wz+ehOYR
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 987294BA2E35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Wz+ehOYR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786026431; x=1786631231;
	i=johannes.schindelin@gmx.de;
	bh=fdblHrT3cvviJvTOjxKWKwI2tNXJMDsqvJL97C5L/sQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wz+ehOYR2wHwmOExVQoM9+6t1FZttX4To7jq9oldrR3u8T7TW3Er5C4e69geRcw8
	 NdGud+7lEA+4UP+JvFDGqVKGIYzHC5DrRojafj2lfxTdZr7eVbDx2fsPPiwqjbfeq
	 H1AWdUGT3dLYBK2LFn1NbJ+uAxawvVQ/llSYJxdOfT1H4KR4unURrqPXGarehyHrF
	 QfMTlgeoSQDQUxCutkfPkox+xIWM9b6JXFyx3AWhUKv9FDcl/YfjjAvMR7gm8Ayqg
	 AD9lQyFdMEDSprvvwbfoeDEfJudS3uyWRCTwt3Z4hrA5Iyjxztn6vriJrnvsIV+un
	 b/GKYCuZPeXB8hzXtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1xExNb1M5s-00ZeGJ; Thu, 06
 Aug 2026 16:21:51 +0200
Date: Thu, 6 Aug 2026 16:21:49 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Steven Doerfler <sgd-cygwinlist@lugaru.com>
Subject: Re: [PATCH] Cygwin: console: Fix regression in console input
In-Reply-To: <20260803025011.5289-1-takashi.yano@nifty.ne.jp>
Message-ID: <9a1a2379-361e-86b4-b310-d162af82a417@gmx.de>
References: <20260803025011.5289-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:UKbChY24yVT2lrtLAU9PIWwN51bJ7SpK4yGhamd6b6bNlTlpY/E
 LMCUJtLJiEyWpMwi4/rj/bfrl57cbAMbt4ySSwxHq1ZoeQYp5JHKfZ7mY5mdatjjp72ihPZ
 egJbbWSjsQ/zShuoC966RLzTLLD2V8IJaXMw/OsWxFRkf00pmIXdgLZPzlsaPgIAHt1WITf
 B7yUILIC3bNZcJYd9MNzA==
UI-OutboundReport: notjunk:1;M01:P0:DBrUtmbXFJM=;xPCqjnsGt2Io3b26GGnjF6j+9uB
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 3 Aug 2026, Takashi Yano wrote:

> The commit fac73911f5a0 ("Cygwin: console: Fix typeahead input for
> bash") introduced a bug where select() consumes some input chars in
> canonical mode, preventing read() from reading them. This is due to
> discarding input events when process_input_message() does not return
> `input_ok` even if it is called from select().
> The basic idea of that commit was making process_input_message()
> not to store processed chars into readahead buffer. This was not
> correct because the key input events ware processed twice, once by
> select() and again by read(). Thus even if that commit worked as
> intended, the side effect such as input echo would be applied twice.
>=20
> With this patch, process_input_message() handles only the minimum
> necessary of input events in both cases, those processed by select()
> and those processed by read(). To achive this behaviour, the function
> returns without processing when `input_ready` is already satisfied,
> or after it has processed the specified number of chars.
>=20
> Addresses: https://cygwin.com/pipermail/cygwin/2026-August/259915.html
> Reported-by: Steven Doerfler <sgd-cygwinlist@lugaru.com>
> Fixes: fac73911f5a0 ("Cygwin: console: Fix typeahead input for bash")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Revewed-by:

This explanation, as well as the diff, look sound to me.

You may want to fix the typos "Revewed" -> "Reviewed", "ware" -> "were"
and "achive" -> "achieve", but those are tiny nits.

You could also fix the pre-existing typo in the comment "recored" ->
"recorded" while at it, but again, that's just a nit.

> ---
>  winsup/cygwin/fhandler/console.cc | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 0219a37ef..3904fbd57 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1406,7 +1406,6 @@ fhandler_console::input_states
>  fhandler_console::process_input_message (size_t len)
>  {
>    char tmp[60];
> -  size_t num_chars =3D 0;
> =20
>    if (!shared_console_info[unit])
>      return input_error;
> @@ -1429,6 +1428,10 @@ fhandler_console::process_input_message (size_t l=
en)
>        return input_error;
>      }
> =20
> +  /* len =3D=3D 0 if called from select.cc:peek_console() */
> +  if (input_ready && (len =3D=3D 0 || (get_ttyp ()->ti.c_lflag & ICANON=
)))
> +    return input_ok;

It is worth pointing out that while this `input_ready &&` part looks
superfluous (both callers guard the call behind `!input_ready`), it is a
concurrency guard: a second thread reading the same console fd can set
`inpuy_ready` in the window between `read()`'s lock-free `while
(!input_ready)` check and `acquire_input_mutex`.

Maybe worth an extra code comment?

> +
>    for (i =3D 0; i < total_read; i ++)
>      {
>        DWORD nread =3D 1;
> @@ -1794,7 +1797,6 @@ fhandler_console::process_input_message (size_t le=
n)
>  	}
> =20
>        num_input_events_processed =3D i + 1;
> -      num_chars +=3D nread;
>        if (toadd)
>  	{
>  	  ssize_t ret;
> @@ -1813,21 +1815,17 @@ fhandler_console::process_input_message (size_t =
len)
>  	    }
>  	}
>        /* len =3D=3D 0 if called from select.cc:peek_console() */
> -      if (len && num_chars >=3D len)
> +      if (input_ready && (len =3D=3D 0 || con_ra.ralen >=3D len))

Something GPT 5.6 Sol stumbled over, before noticing that this is a
pre-existing issue: the raw multi-pass caller passes full `buflen` (not
`buflen - copied_chars`). That was already there before this patch (and
both GPT and Opus think that this is incorrect, I haven't had time to wrap
my head around it), and the new `ralen`-based check is actually
neutral-to-better; and `tcflush(TCIFLUSH)` doesn't flush `con_ra`.

I'm fairly certain that this is out of scope for this here bug fix, if it
is an issue at all (what do you think? Is this `buflen` issue real? Should
`tcflush()` also flush `con_ra`?).

In any case, I'm happy with this patch! Feel free to add my "Reviewed-by".

Thanks!
Johannes

>  	goto out;
>      }
>  out:
> -  if (len =3D=3D 0)
> -    /* If len =3D=3D 0, cancel reading from console input buffer.
> -       Clear readahead buffer. */
> -    eat_readahead (-1);
>    /* Discard processed recored. */
>    DWORD discard_len =3D min (total_read, i + 1);
>    /* If input is signalled, do not discard input here because
>       discard_key_events() is already called from line_edit(). */
>    if (stat =3D=3D input_signalled)
>      discard_len =3D 0;
> -  if (discard_len && (len || stat !=3D input_ok))
> +  if (discard_len)
>      discard_key_events (discard_len);
>    return stat;
>  }
> --=20
> 2.51.0
>=20
>=20
