Return-Path: <SRS0=BQMy=HT=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 669BF4BA23DC
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 19:39:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 669BF4BA23DC
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 669BF4BA23DC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790537976; cv=none;
	b=MOpGBjLSgyDcpcUzh9UWjWRdGmGLFhVN6XxYZ0Cyzuq6IhMli4RDm+aG0RhPFgSsjPbCPRVqU22FENTbU6hsDy/J4IyL4sraE3407wzOufzvLXioSYbk1qf2aLwMwAiRCcU5rCxY8WrArHAsnYyzgeOYF/NP/DdpWAtnuO7YwC4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790537976; c=relaxed/simple;
	bh=u+lD5EVEpfjZJ+OwJSkCfisqJFqBVr6Xw8EwjV2kJ/k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=dOFck9YTf28rcO8PNo0pItbMDuqmM+WE0nSGzm30r6ievvGDaJDnVQDCPoVahSQAHxk2lLe1rEgjOexHL0dYcYiTNWN3jg/kgFfJNYuCToj3WD5A5GmeJQ/d4UnepHnPEL1Ciq+tnb3ySx2Variy/1+PRQVK9qTxEiWT/LtEWjc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=DMBiEijL
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 669BF4BA23DC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=DMBiEijL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790537970; x=1791142770;
	i=johannes.schindelin@gmx.de;
	bh=K4xiujRgiyNyqLBA14a08xkte/Sso5fHCbjB+zCs5sk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DMBiEijL2SszrRPJyg+eSiKxZwiVpSHgOIj/3wGJnXepwgi8F3TLeEKChAxTnlEB
	 moana4z3t+2E0bspc7q+NyNmN/5rsgJX0wJEQDFolChbqy8gXt+WbumEH2QSbvl1U
	 Ws6ZOkGtb47Xzh0kR3NLD/kQrFoii4/KU08lZG/VamW6PvCDUFwwImgsT/Nqs5WZC
	 y/lQd5WJGpiML4UMHyo1a0ENGJJQQWRU/2cRa2rEd8AFsUZNN8ccnyItGIObD1xkS
	 a59v3ZNYvbKx/BMcwY9QJiAv7riy1d4MQITEOK13fZgkfADf1/yOh20495vFUmkTw
	 5kT4QMhPpdZq35gDPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1x8irZ3RJQ-006Uun; Sun, 27
 Sep 2026 21:39:29 +0200
Date: Sun, 27 Sep 2026 21:39:27 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <20260927132627.1002-1-takashi.yano@nifty.ne.jp>
Message-ID: <618524df-cdcd-d697-0d4c-1244bfa49c68@gmx.de>
References: <20260927132627.1002-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:14/oGgeS613jG8kxWKuvFUOeL9XREIDtnbensXWVi8DMWB+nhxt
 IMwa+ZeCKpLLeV5OjTUuloG9/aCPjEmV8E7+Cnfn8NLw9iROTUOqqJVgwmZEaWHMXWL1eT2
 2Pf7FN4VAPB5Ddxm4Uvq5i6Sag11irE7w2/8LqhxOJ8x/kVf13YzEDPU/4hdg4s+gDtpvcl
 8SCp6dnBRqFxO5xQvRSQA==
UI-OutboundReport: notjunk:1;M01:P0:YvMEq7G9h50=;6CNExVnOw2KIshiWWA2PYInBZqA
 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
 Zie5LUzSm0CbY0T2Q==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sun, 27 Sep 2026, Takashi Yano wrote:

> Previously, peek_console() used PeekConsoleInput() to confirm whether
> the console input buffer has some input records. However, this need
> attaching to the console if the process does not attach to the console.
> To reduce that overhead, this patch uses WaitForSingleObject() with
> console input handle instead. WaitForSingleObject() works without
> attaching to the console, so this simplifies the peek_console()
> code.
>=20
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Do not remove PeekConsoleInputW() call.
> v3: Revert to v1 and check empty buffer in process_input_message()
> v4: Handle input_empty and input_error returned from process_input_messa=
ge()
>     properly.
> v5: Set thread_errno rather than errno in peek_console().
> v6: Preserve errno/thread_errno as soon as the error occurs.

Great, thanks!

One more question:

> [...]
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index e0bd1726f..7c14800fd 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> [...]
> @@ -1161,29 +1159,42 @@ peek_console (select_record *me, bool)
>        else
>  	{
>  	  fh->acquire_input_mutex (mutex_timeout);
> -	  acquire_attach_mutex (mutex_timeout);
> -	  DWORD resume_pid =3D fh->attach_console (fh->get_owner ());
> -	  BOOL r =3D PeekConsoleInputW (h, &irec, 1, &events_read);
> -	  fh->detach_console (resume_pid, fh->get_owner ());
> -	  release_attach_mutex ();
> -	  if (!r || !events_read)
> +	  if (WaitForSingleObject (h, 0) !=3D WAIT_OBJECT_0)
>  	    {
>  	      fh->release_input_mutex ();
>  	      break;
>  	    }
>  	}
>        fhandler_console::input_states ret =3D fh->process_input_message =
(0);
> +      if (ret =3D=3D fhandler_console::input_error)
> +	me->thread_errno =3D get_errno ();

Do we need to preserve `errno` in `fhandler_console::read()`, too? In
https://github.com/Cygwin/cygwin/blob/2867786d2412/winsup/cygwin/fhandler/=
console.cc#L1419-L1421:

	case input_error:
	  release_input_mutex ();
	  goto err;

and then
https://github.com/cygwin/cygwin/blob/2867786d2412/winsup/cygwin/fhandler/=
console.cc#L1464-L1465:

	err:
	  __seterrno ();

the `errno` from `PeekConsoleInputW()` would be overwritten otherwise,
correct?

Ciao,
Johannes

>        fh->release_input_mutex ();
>        fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
> =20
> -      if (ret =3D=3D fhandler_console::input_winch
> -	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> -	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
> +      switch (ret)
>  	{
> +	case fhandler_console::input_processing:
> +	case fhandler_console::input_ok:
> +	  break;
> +	case fhandler_console::input_winch:
> +	  if (global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> +	      && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
> +	    {
> +	      set_sig_errno (EINTR);
> +	      return -1;
> +	    }
> +	  break;
> +	case fhandler_console::input_signalled:
>  	  set_sig_errno (EINTR);
>  	  return -1;
> +	case fhandler_console::input_error:
> +	  /* thread_errno is already set */
> +	  return -1;
> +	case fhandler_console::input_empty:
> +	  goto out;
>  	}
>      }
> +out:
>    if (fh->input_ready () || fh->get_cons_readahead_valid ())
>      return me->read_ready =3D true;
> =20
> --=20
> 2.51.0
>=20
>=20
