Return-Path: <SRS0=qo+9=HG=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id B12494B9DB41
	for <cygwin-patches@cygwin.com>; Mon, 14 Sep 2026 12:55:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B12494B9DB41
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B12494B9DB41
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789390519; cv=none;
	b=U4/9UPzBU3hQV6V63hIio6xuLOPCv+qm8gzKFE0tolr+4pipOknyQp/PEmq7x743xysk6n033haYqfqQiwUcn+PoYPAfHasSSkZyXzPm3syikl/IeVhKid1WhPdXstPKTJaW+WkEJGhx4oKMY56EcmCvr97Mc+2QgtftkAtLl90=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789390519; c=relaxed/simple;
	bh=md5S/LA7APVv0fAtGilDwb8y2Kk8lf6biplxnMXIC9g=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=S2/oR5tHWOS1TQCUzCFqQgZycWgazuzeAjSCpYjMsdKK9NgHXx+zQGqccaMVqGFdJoiAPQt0ZtNQTXVuIifxQMYKVyI58UqAUbQ4JcgbXcvHXsxoV4H3Y9r7OVRmv8N0M2c6XEBcC3r5jNa2K9sH4qW5zgPSSox9USwjQI2EbKI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ToAGcNte
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B12494B9DB41
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ToAGcNte
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789390512; x=1789995312;
	i=johannes.schindelin@gmx.de;
	bh=eKw696D01mUTQxoQOMFmoP3Eoh6vMgPaw0vZgpgl/CA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ToAGcNteuDAqt7ZVQqA2Er5hjKv852lwurrSTgbni1rxjZfHwnGrl9pwmElMs2Zu
	 /KuyL1AOXlmghhIUUhYjDXuq50ZfcUUTa3Gcox2R6wnhSmOOqvPANmSPUVH6h3q8N
	 hmxMZghn9TYVOiiTHjNjg9MuoxuProj1a2kHYL2HcVZPaK57hz+WMueSKxWONCgch
	 kG3tZ9X4UhGNFfiZcxhSzIqlSrxuMRXKsiCWzluqDLQvbNvza3X3ViXJGe6rcg6Sm
	 FN9yE7MiCn+4u/ufRI6tAhMh/87vSwu+6qcIwHl5IW2Zo+3+IjAlEAw10tluGSUF7
	 grXG663byC9b+FCStA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1xBshn2oQN-005JXz; Mon, 14
 Sep 2026 14:55:12 +0200
Date: Mon, 14 Sep 2026 14:55:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console: Clear readahead buffer on
 tcflush()
In-Reply-To: <20260913214534.708-1-takashi.yano@nifty.ne.jp>
Message-ID: <a7895a77-f5d2-739c-9e17-808f4142b8ec@gmx.de>
References: <20260913214534.708-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:17XSMaioz2jZ+iBtIdOygsV1bw+51uklyS8hs5ZwvvmIZBn0hrl
 1qixIRs5JgBP0jateimKCweg6T872g7OuXEqD2vnB7DqZf/YMTzYQ0PE4RtOCT41LbBE+OR
 X56BmN0NpAdJBVKd5CQR0bcTEh1wpWe7DT1aTCU/OXI7W8esmF3N7U7DN1l14ztLGZAq9+5
 lPHtYTUtzoYxp2vqY+qCw==
UI-OutboundReport: notjunk:1;M01:P0:s/1wdmj7RX4=;9QHOZU4ASnoPL172mEUCnKhna/L
 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
 8MwUvvSNdTEh6
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 14 Sep 2026, Takashi Yano wrote:

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

Thank you! This addresses the examples I gave in my review of v2.

Thinking a bit deeper about this, I have two more questions:

- Can closing a console dead-lock now?

  Consider this scenario: Process A's `ioctl(TIOCGWINSZ)` takes
  `input_mutex`, then waits for `output_mutex`. Meanwhile, process B's
  `close()` can hold `output_mutex` and request `input_mutex` through
  `set_disable_master_thread()`, when restoring the console's original
  settings. A console-owning Cygwin process launched by a native parent
  can take that restoration path. If A gets the input lock and B gets the
  output lock first, don't they both wait forever for the other?

  These are named locks for the same console, shared across processes;
  recursive acquisition does not resolve this cycle. The reverse order in
  `close()` predates v3, but v3 newly exposes an otherwise output-only
  size query to it. No reader or flush is required.

- Can the new readiness flag survive destruction of its buffer?

   A process whose controlling terminal is a PTY can open another live
   console with `O_NOCTTY`, select a complete line without reading it,
   close its last reference to that console, then reopen it while another
   process keeps the console alive. Actual console close frees and zeroes
   `con_ra`, but leaves the new static `input_ready` true. A fresh handler
   no longer resets that flag, so wouldn't its next canonical `read()`
   skip waiting, find no bytes and return zero, i.e. apparent EOF without
   an EOF keystroke?

   Before v3, the fresh handler initialized its own flag to
   false. This is a sequential close/reopen case, not closing one of
   several surviving duplicates.

We will want to keep the shared-readiness fix and input-flush
serialization, but we might need to make lock ordering consistent with
close, and retire readiness with its buffer. I don't think that we could
clear readiness on every open, or equate it with a nonempty buffer: other
descriptors and genuine canonical `VEOF` must keep working.

Ciao,
Johannes

>  winsup/cygwin/fhandler/console.cc       | 41 +++++++++++++++++++++----
>  winsup/cygwin/local_includes/fhandler.h |  2 +-
>  winsup/cygwin/select.cc                 |  8 ++---
>  3 files changed, 40 insertions(+), 11 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index be41bf3a2..a995f3acc 100644
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
> @@ -2217,6 +2218,7 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
rg)
>    int res =3D fhandler_termios::ioctl (cmd, arg);
>    if (res <=3D 0)
>      return res;
> +  acquire_input_mutex (mutex_timeout);
>    acquire_output_mutex (mutex_timeout);
>    switch (cmd)
>      {
> @@ -2234,6 +2236,7 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
rg)
>  			   ((struct winsize *) arg)->ws_row,
>  			   ((struct winsize *) arg)->ws_col);
>  	    release_output_mutex ();
> +	    release_input_mutex ();
>  	    return 0;
>  	  }
>  	else
> @@ -2241,17 +2244,21 @@ fhandler_console::ioctl (unsigned int cmd, void =
*arg)
>  	    syscall_printf ("WINSZ failed");
>  	    __seterrno ();
>  	    release_output_mutex ();
> +	    release_input_mutex ();
>  	    return -1;
>  	  }
>  	release_output_mutex ();
> +	release_input_mutex ();
>  	return 0;
>        case TIOCSWINSZ:
>  	bg_check (SIGTTOU);
>  	release_output_mutex ();
> +	release_input_mutex ();
>  	return 0;
>        case KDGKBMETA:
>  	*(int *) arg =3D (con.metabit) ? K_METABIT : K_ESCPREFIX;
>  	release_output_mutex ();
> +	release_input_mutex ();
>  	return 0;
>        case KDSKBMETA:
>  	if ((intptr_t) arg =3D=3D K_METABIT)
> @@ -2262,19 +2269,23 @@ fhandler_console::ioctl (unsigned int cmd, void =
*arg)
>  	  {
>  	    set_errno (EINVAL);
>  	    release_output_mutex ();
> +	    release_input_mutex ();
>  	    return -1;
>  	  }
>  	release_output_mutex ();
> +	release_input_mutex ();
>  	return 0;
>        case TIOCLINUX:
>  	if (*(unsigned char *) arg =3D=3D 6)
>  	  {
>  	    *(unsigned char *) arg =3D (unsigned char) con.nModifiers;
>  	    release_output_mutex ();
> +	    release_input_mutex ();
>  	    return 0;
>  	  }
>  	set_errno (EINVAL);
>  	release_output_mutex ();
> +	release_input_mutex ();
>  	return -1;
>        case FIONREAD:
>        case TIOCINQ:
> @@ -2291,6 +2302,7 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
rg)
>  	    {
>  	      set_errno (EINVAL);
>  	      release_output_mutex ();
> +	      release_input_mutex ();
>  	      return -1;
>  	    }
>  	  bool saw_eol =3D false;
> @@ -2327,20 +2339,24 @@ fhandler_console::ioctl (unsigned int cmd, void =
*arg)
>  	  else
>  	    *(int *) arg =3D ret;
>  	  release_output_mutex ();
> +	  release_input_mutex ();
>  	  return 0;
>  	}
>  	break;
>        case TCXONC:
>  	res =3D this->tcflow ((int)(intptr_t) arg);
>  	release_output_mutex ();
> +	release_input_mutex ();
>  	return res;
>        case TCFLSH:
>  	res =3D this->tcflush ((int)(intptr_t) arg);
>  	release_output_mutex ();
> +	release_input_mutex ();
>  	return res;
>      }
> =20
>    release_output_mutex ();
> +  release_input_mutex ();
>    return fhandler_base::ioctl (cmd, arg);
>  }
> =20
> @@ -2351,6 +2367,9 @@ fhandler_console::tcflush (int queue)
>    if (queue =3D=3D TCIFLUSH
>        || queue =3D=3D TCIOFLUSH)
>      {
> +      /* tcflush() may be called inside the input_mutex,
> +	 however, mutex of Win32 can be acquired recursively. */
> +      acquire_input_mutex (mutex_timeout);
>        acquire_attach_mutex (mutex_timeout);
>        DWORD resume_pid =3D attach_console (con.owner);
>        BOOL r =3D FlushConsoleInputBuffer (get_handle ());
> @@ -2362,6 +2381,10 @@ fhandler_console::tcflush (int queue)
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
> @@ -2386,7 +2409,7 @@ fhandler_console::tcgetattr (struct termios *t)
>  }
> =20
>  fhandler_console::fhandler_console (fh_devices devunit) :
> -  fhandler_termios (), input_ready (false), thread_sync_event (NULL),
> +  fhandler_termios (), thread_sync_event (NULL),
>    input_mutex (NULL), output_mutex (NULL), unit (MAX_CONS_DEV),
>    num_input_events_processed (0)
>  {
> @@ -4912,3 +4935,9 @@ fhandler_console::tcdrain ()
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
