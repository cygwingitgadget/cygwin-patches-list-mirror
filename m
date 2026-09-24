Return-Path: <SRS0=WkfY=HQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 7FEA64BA7983
	for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 20:08:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7FEA64BA7983
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7FEA64BA7983
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790280485; cv=none;
	b=jcXrrwFj0HpToc94Y6yoMgXQcJL0VoOgR49ZlKbwysyVVlLqO6RQPp/sy2MxYWUSLfB65F/hYSRHMqFp3wesgCAA9IjRWR87ymxQQLiqsWovIcXYUl2mslzuF9rQ5upEtFjK4/DrvVLmRvnbOuh91MAFYMPEjTiCB1jqpRJWHQc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790280485; c=relaxed/simple;
	bh=pB2CvSFvxRbswfSCmMgF0Fd6sdZpL1TGZRDQxx5/nQ0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=FEt0NnOq2+djgad7yUo+//w20VTqsUOOFgykGQ2crMrmTNhNXoBT/M8TPbu40wKmXBkEwzBSTe3r9bBMRMF3D6mLwQDPkHP9wxJvhXbvD/LofoEYUql0n6h3JpH6EXRSTMlhW05QbaFcc8x3jtwIWVvM144c1WJ5DlIDsMgnvy8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=WiYAuwHd
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7FEA64BA7983
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=WiYAuwHd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790280484; x=1790885284;
	i=johannes.schindelin@gmx.de;
	bh=9Ze9hLzZnXVp6Joq1a/FksA7JSoR3EZ7F0QxhmKh/aU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WiYAuwHdnzbN5maTvrf21wOBNaWhwXmpw1Mz5F3t6gmPlhJhK3rADuHCtRW5hwWi
	 K6EeCJuthtfMw2jI8GbfojvXzIehmvIOkAB9uM3/hZhv2gpF7Pahj8DfEbdP/a/EM
	 sR91alkraMiffjk3eV62Iv2qUje6M2P/Un+wsnOQUUEyh7dGcNEbFlBnOjXgrvA/o
	 33cE1GRiBOnHaPBjeF/an/kCrh9j4QaCUv5cZxu761JSBlE8Gn0/VhL0o2cmr6yL0
	 l/b+AYy6R2zLzAibwNoSTbpjfw8cfkB7vNxN6weBexsOJ1mZ6xaLYr47rrbbIj+Ox
	 4LK5zm7/f9uQb7K8Ew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1xTyv90Tv9-00LWXS; Thu, 24
 Sep 2026 22:08:04 +0200
Date: Thu, 24 Sep 2026 22:08:04 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Clear readahead buffer on
 tcflush()
In-Reply-To: <20260915063431.602-1-takashi.yano@nifty.ne.jp>
Message-ID: <59a99c34-239b-73c0-2f74-4feb6cd81db2@gmx.de>
References: <20260915063431.602-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:tWRkhr01u3lqXj9G0OeqArA2Le61DPCakXZ3GPJa85fzakfvB3P
 MKEg/Y4YAP2AZpA+qtWeN/4zGpCfu+hPQlSna/rS5hbHsKyly1CT56jayAQLWI6QcskQ/gh
 HzMmjiYfz/OwUpH1gMAMMfe4Kq0V7bIM6Th9gM0JVM8vejV6z1QbpYaaD7l7ZHGOJHQwbI1
 oiP2/E0YmHxD0jukz8gJQ==
UI-OutboundReport: notjunk:1;M01:P0:2J+gjxg+MsM=;j9XkZERcNd3P52aqfAOFZLrAYYC
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 15 Sep 2026, Takashi Yano wrote:

> Previously, tcflush(TCIFLUSH) only discarded the input events and
> did not clear the readahead buffer. Because of this bug, when user
> program called select() -> tcflush() -> read(), the last read()
> returned the contents of the readahead buffer instead of blocking
> as it should.
>=20
> Correctly, tcflush() must discard all pending input, so read()
> should block until new input arrives. With this patch, the read-
> ahead buffer and `rapoi` are also cleared as well as input events.
>=20
> Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Add input_mutex guard. Clear rapoi as well.
> v3: Acquire input_mutex before output_mutex in ioctl() to avoid
>     deadlock in tcflush().
>     Make input_ready static as con_ra is.
> v4: Revert input_mutex in ioctl() and move tcflush() outside
>     output_mutex insted.

Thank you for this version. It correctly flushes the Windows input queue,
`con_ra`, `input_ready`, and also `cons_rapoi` under `input_mutex`.

It also fixes v3's lock-order problem by calling `tcflush()` after
releasing `output_mutex`.

However, one concern remains unresolved: `input_ready` is process-static,
but `close()` frees and zeroes `con_ra` without clearing `input_ready`. In
the same process, closing the last reference to a secondary console and
reopening it could therefore retain `input_ready =3D=3D true` with an empt=
y
buffer, potentially producing an apparent EOF. Or am I misreading the
code?

Ciao,
Johannes

>=20
>  winsup/cygwin/fhandler/console.cc       | 29 +++++++++++++++++++------
>  winsup/cygwin/local_includes/fhandler.h |  2 +-
>  winsup/cygwin/select.cc                 |  8 +++----
>  3 files changed, 27 insertions(+), 12 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index be41bf3a2..e1849aada 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -70,6 +70,7 @@ bool NO_COPY fhandler_console::invisible_console;
>  /* con_ra is shared in the same process.
>     Only one console can exist in a process, therefore, static is suitab=
le. */
>  static struct fhandler_base::rabuf_t con_ra;
> +static bool input_ready;
> =20
>  /* Write pending buffer for ESC sequence handling
>     in xterm compatible mode */
> @@ -1224,7 +1225,7 @@ fhandler_console::read (void *pv, size_t& buflen)
>        (get_ttyp ()->ti.c_cc[VTIME]*100 ? : INFINITE)));
> =20
>  read_more:
> -  while (!input_ready && !get_cons_readahead_valid ())
> +  while (!::input_ready && !get_cons_readahead_valid ())
>      {
>        int bgres;
>        if ((bgres =3D bg_check (SIGTTIN)) <=3D bg_eof)
> @@ -1305,7 +1306,7 @@ wait_retry:
>      get_readahead_into_buffer (buf + copied_chars, buflen - copied_char=
s);
> =20
>    if (!con_ra.ralen)
> -    input_ready =3D false;
> +    ::input_ready =3D false;
>    release_input_mutex ();
> =20
>    if (buflen > copied_chars && !(get_ttyp ()->ti.c_lflag & ICANON)
> @@ -1357,7 +1358,7 @@ fhandler_console::process_input_message (size_t le=
n)
>    /* This code is reached only when being passed the input_ready check,
>       however, the check was done outside input_mutex. Therefore, anothe=
r
>       thread may set input_ready after the check. Check it again here. *=
/
> -  if (input_ready && (len =3D=3D 0 || (get_ttyp ()->ti.c_lflag & ICANON=
)))
> +  if (::input_ready && (len =3D=3D 0 || (get_ttyp ()->ti.c_lflag & ICAN=
ON)))
>      return input_ok;
> =20
>    for (i =3D 0; i < total_read; i ++)
> @@ -1736,14 +1737,14 @@ fhandler_console::process_input_message (size_t =
len)
>  	    }
>  	  else if (res =3D=3D line_edit_input_done)
>  	    {
> -	      input_ready =3D true;
> +	      ::input_ready =3D true;
>  	      stat =3D input_ok;
>  	      if (ti->c_lflag & ICANON)
>  		goto out;
>  	    }
>  	}
>        /* len =3D=3D 0 if called from select.cc:peek_console() */
> -      if (input_ready && (len =3D=3D 0 || con_ra.ralen >=3D len))
> +      if (::input_ready && (len =3D=3D 0 || con_ra.ralen >=3D len))
>  	goto out;
>      }
>  out:
> @@ -2335,8 +2336,9 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
rg)
>  	release_output_mutex ();
>  	return res;
>        case TCFLSH:
> -	res =3D this->tcflush ((int)(intptr_t) arg);
>  	release_output_mutex ();
> +	/* tcflush() does not need output_mutex */
> +	res =3D this->tcflush ((int)(intptr_t) arg);
>  	return res;
>      }
> =20
> @@ -2351,6 +2353,9 @@ fhandler_console::tcflush (int queue)
>    if (queue =3D=3D TCIFLUSH
>        || queue =3D=3D TCIOFLUSH)
>      {
> +      /* tcflush() may be called inside the input_mutex,
> +	 however, mutex of Win32 can be acquired recursively. */
> +      acquire_input_mutex (mutex_timeout);
>        acquire_attach_mutex (mutex_timeout);
>        DWORD resume_pid =3D attach_console (con.owner);
>        BOOL r =3D FlushConsoleInputBuffer (get_handle ());
> @@ -2362,6 +2367,10 @@ fhandler_console::tcflush (int queue)
>  	  res =3D -1;
>  	}
>        con.num_processed =3D 0;
> +      eat_readahead (-1);
> +      ::input_ready =3D false;
> +      con.cons_rapoi =3D NULL;
> +      release_input_mutex ();
>      }
>    return res;
>  }
> @@ -2386,7 +2395,7 @@ fhandler_console::tcgetattr (struct termios *t)
>  }
> =20
>  fhandler_console::fhandler_console (fh_devices devunit) :
> -  fhandler_termios (), input_ready (false), thread_sync_event (NULL),
> +  fhandler_termios (), thread_sync_event (NULL),
>    input_mutex (NULL), output_mutex (NULL), unit (MAX_CONS_DEV),
>    num_input_events_processed (0)
>  {
> @@ -4912,3 +4921,9 @@ fhandler_console::tcdrain ()
>  {
>    return 0;
>  }
> +
> +bool
> +fhandler_console::input_ready ()
> +{
> +  return ::input_ready;
> +}
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index d11b3ec4f..73d121508 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2183,7 +2183,6 @@ public:
>      tty_min tty_min_state;
>      dev_console con;
>    };
> -  bool input_ready;
>    enum input_states
>    {
>      input_error =3D -1,
> @@ -2366,6 +2365,7 @@ private:
>    void wpbuf_send ();
>    int fstat (struct stat *buf);
>    void discard_key_events (size_t n);
> +  bool input_ready ();
> =20
>    class console_unit
>    {
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index b72083447..120273b70 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1140,7 +1140,7 @@ peek_console (select_record *me, bool)
>    if (fh->get_cons_readahead_valid ())
>      return me->read_ready =3D true;
> =20
> -  if (fh->input_ready)
> +  if (fh->input_ready ())
>      return me->read_ready =3D true;
> =20
>    if (me->read_ready)
> @@ -1155,7 +1155,7 @@ peek_console (select_record *me, bool)
>    set_handle_or_return_if_not_open (h, me);
> =20
>    fh->acquire_input_mutex (mutex_timeout);
> -  while (!fh->input_ready && !fh->get_cons_readahead_valid ())
> +  while (!fh->input_ready () && !fh->get_cons_readahead_valid ())
>      {
>        if (fh->bg_check (SIGTTIN, true) <=3D bg_eof)
>  	{
> @@ -1182,7 +1182,7 @@ peek_console (select_record *me, bool)
>  	}
>      }
>    fh->release_input_mutex ();
> -  if (fh->input_ready || fh->get_cons_readahead_valid ())
> +  if (fh->input_ready () || fh->get_cons_readahead_valid ())
>      return me->read_ready =3D true;
> =20
>    return me->write_ready;
> @@ -1282,7 +1282,7 @@ fhandler_console::select_read (select_stuff *ss)
> =20
>    s->peek =3D peek_console;
>    s->read_selected =3D true;
> -  s->read_ready =3D input_ready || get_cons_readahead_valid ();
> +  s->read_ready =3D input_ready () || get_cons_readahead_valid ();
>    s->cleanup =3D console_cleanup;
>    return s;
>  }
> --=20
> 2.51.0
>=20
>=20
