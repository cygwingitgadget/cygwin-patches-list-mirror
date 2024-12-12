Return-Path: <SRS0=5T/g=TF=gmail.com=walkerxk@sourceware.org>
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by sourceware.org (Postfix) with ESMTPS id E03063858C62
	for <cygwin-patches@cygwin.com>; Thu, 12 Dec 2024 08:43:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E03063858C62
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E03063858C62
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::52a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733993008; cv=none;
	b=wGkbVL+pHNw8zEaarf8l9d1X5R0dn6Bxl1NAfuQ8omn5GgjVy/yme8wIB8gW2+4t6QGd5bnV5BIg4TS9bR9xAq9DgsirgvL+a8o5uDSkl2qfGu0vjofDaC1O949Dlzu2oPLef2PGUA8L2T76ttohLFIvINl2UsbQbj6aSCtlap4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733993008; c=relaxed/simple;
	bh=oDkGP10PfAFKTPFamHkB+GPU9KV/pYVjzp7P3HEdo5E=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=vVKz8xdBRkDPQs4OSRFu0IqHxEo/HfRaH9ODC5AnggrPJqG9Y6fXnc+UIJThd74jGBqotzwe0Fjmp78Esdv+HXas0oQ/YNsG5eL/TyKg4QioNfq+AVWuslneBAR5dbC7joFdWFTKTAKNi0F/d5WItYnw4NSgu7Jg68HOAMEOAuw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E03063858C62
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S5aQ+Zed
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so567828a12.2
        for <cygwin-patches@cygwin.com>; Thu, 12 Dec 2024 00:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733993006; x=1734597806; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tbVYdl1xm246nf2MXdMcNxtLMd9jOktncRdVtdj0tl4=;
        b=S5aQ+ZedrFTsmfgabPVzZnxEB2FW+V/iwLLGwlyCVFzKDpo6qtWH89XQqUd44MPMK2
         w3ZvfvDPHwhLXIa1Pft6VTpFEyxILnhCPG4ZQLhf6uKMkK9dxdZXMn/JXIz/fRH5dOAC
         Dik6ul93pJHrL0tItblUuh1AA3un0227CBIQCVFc4N1ctfxwVugwbyy3lPCwKgM9fG1J
         EieOzKyKZBRoDnAc7N4q2Hp0D7t2euS0CHqIzPPCRCULFGMU3nDbjXRNDmfj8H5vXHFx
         5hweS7ZPillylcJH1kNsdy827RR/oCyOAwMT/gScaXHlqbqgmEC7erizWCB9nM7UQTIM
         g6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993006; x=1734597806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbVYdl1xm246nf2MXdMcNxtLMd9jOktncRdVtdj0tl4=;
        b=IgXvjwDU7ki9hz+kizWbDQ8vQT6M9ZRV7OeXDYqrNIsGUnijZhO9axpdIUHQtjLIQs
         R5b8kuhYo/VY8wG9SIzIE8PaEfMyczJ3bRYkU8XaANu/d9nJxbfOUpi9G2Zdiv6P9u3m
         v2n5k07DdZRMMM1BcnROkAC6rrAQ1RXN1whQbqN1Pjc9L7LiTs61QL1pgbOBi7RI2Mju
         2lCR5UBX4IEqlRbumJLeaGruwCmaPOtqjW+IrsoR6QPkT+7c9+5ium9UaXYE5ZUqKnYj
         q8QGd1RQlSPVgiv95ZUR9B/B8bZ6axq8Nw9agU/OVhLS4LIoG5gBLFngiQF8ssfoT1ku
         b5uw==
X-Gm-Message-State: AOJu0Yw6b4QUsC/mhzDDhHZOY8oJfuJ0ahnc/7rFT2iganyNHa+oYHGw
	8+OiyEQtHcXSRqVkLQBP5fveP2bFenSVpdvn2RY0pKi3hAcGnP8RpnWRXH59SxF0T6108qIa6Oi
	8q6Js5hAge5swwE1RNma0puOA5QhWWH1ASy0=
X-Gm-Gg: ASbGncuxu3dZ8Q7cW+SSVXrYAjyrI6iEvJmRaMcRoTX3oHnOGct1EXj3uY9/YEzB9q3
	Jm2+FjZQqbGAksU70QmIkI8ta3GtuHbOl2Oke7yo=
X-Google-Smtp-Source: AGHT+IH/pZdhsSND4lhCTpJgqqImCcEikjQ4E9Mh32poFWeS1XtOwwklZcnTJ2yR/GWFDMwRDD9HgG1soXz96MA5a6E=
X-Received: by 2002:a05:6402:348d:b0:5d1:2377:5ae2 with SMTP id
 4fb4d7f45d1cf-5d5476281efmr4777a12.7.1733993005681; Thu, 12 Dec 2024 00:43:25
 -0800 (PST)
MIME-Version: 1.0
References: <20241212083223.1891-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20241212083223.1891-1-takashi.yano@nifty.ne.jp>
From: =?UTF-8?B?5Yev5aSP?= <walkerxk@gmail.com>
Date: Thu, 12 Dec 2024 16:43:14 +0800
Message-ID: <CANK+sQkqCVQbPMuEST-0H=L38RnB6brPbzyS=UqPPK-XPb+c2w@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: signal: Fix high load when retrying to process
 pending signal
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Content-Type: multipart/alternative; boundary="000000000000259af406290eb5f9"
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--000000000000259af406290eb5f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you. Does that mean I need to compile cygwin by myself? How long will
it take to publish to test?

On Thu, Dec 12, 2024 at 4:32=E2=80=AFPM Takashi Yano <takashi.yano@nifty.ne=
.jp>
wrote:

> The commit e10f822a2b39 has a problem that CPU load gets high if
> pending signal is not processed successfully for a long time.
> With this patch, wait_sig() calls Sleep(1), rather than yield(),
> if the pending signal has not been processed successfully for a
> predetermined time to prevent CPU from high load.
>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256884.html
> Fixes: e10f822a2b39 ("Cygwin: signal: Handle queued signal without
> explicit __SIGFLUSH")
> Reported-by: =E5=87=AF=E5=A4=8F <walkerxk@gmail.com>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 59b4208a6..e01a67ebe 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -1345,6 +1345,12 @@ wait_sig (VOID *)
>
>    hntdll =3D GetModuleHandle ("ntdll.dll");
>
> +  /* GetTickCount() here is enough because GetTickCount() - t0 does
> +     not overflow until 49 days psss. Even if GetTickCount() overflows,
> +     GetTickCount() - t0 returns correct value, since underflow in
> +     unsigned wraps correctly. Pending a signal for more thtn 49
> +     days would be noncense. */
> +  DWORD t0 =3D GetTickCount ();
>    for (;;)
>      {
>        DWORD nb;
> @@ -1354,7 +1360,10 @@ wait_sig (VOID *)
>        else if (sigq.start.next
>                && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) &&
> !nb)
>         {
> -         yield ();
> +         if (GetTickCount () - t0 > 10)
> +           Sleep (1);
> +         else
> +           yield ();
>           pack.si.si_signo =3D __SIGFLUSH;
>         }
>        else if (!ReadFile (my_readsig, &pack, sizeof (pack), &nb, NULL))
> @@ -1364,6 +1373,8 @@ wait_sig (VOID *)
>           system_printf ("garbled signal pipe data nb %u, sig %d", nb,
> pack.si.si_signo);
>           continue;
>         }
> +      if (pack.si.si_signo !=3D __SIGFLUSH)
> +       t0 =3D GetTickCount ();
>
>        sigq.retry =3D false;
>        /* Don't process signals when we start exiting */
> --
> 2.45.1
>
>

--000000000000259af406290eb5f9--
