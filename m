Return-Path: <SRS0=TlxR=HS=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 6B2B94BA901D
	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2026 17:12:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6B2B94BA901D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6B2B94BA901D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790442740; cv=none;
	b=sVvBdujEYF/oHYAUASIjxRZCdUXO/+APtCaBRQ9CuCqHhtYiCdTV/Gm5gK7yfBslLSeYU8hVMQmBL/TQUWnll/lukXsNeH+lQ7IH9LAG0bn2HP9QQHtUrePY4dgPllPY2R6P3/bZUer7tnsZlwqdWtUsB6pnKWmhiuCPfboh3eo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790442740; c=relaxed/simple;
	bh=3Z3rpLnV/IV+aWR9k704Z97e5JLYl3Hmqo1iOSamES8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=WrePZGKZVN4N2tX4vHO8KTVUzHtt4FbyPUS3Njysd3eY2Tn9AgDP+fhcVisAbVh8ZERTai8hCNIV47IS8j/IBtwI6cNS8fAIwX36ZebkaHu0UAZYQPrQEPmZtxj5ll2Pww2XH7Uimmp5LP4jVQLQk8cS1hVpklFyxhidBeNgea4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=efOc9l/N
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6B2B94BA901D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=efOc9l/N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790442732; x=1791047532;
	i=johannes.schindelin@gmx.de;
	bh=NJuvvQaCwRw8ktSKfOZsSF9cSNYcKb+9Lh8bFgxvMIU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=efOc9l/Nzqu0RNACQvqXChDAxTdl0zjfmcGnzYoGxiql4PAfdPCEqMO0gkiq88vO
	 ZHcsPq2XNaBsE303jZGI722By0AiPMgl2TS2qRhlkSRjGMHxVoUDRU15l/gflwy2D
	 rLngF6usUMdHC7q2CGAFF2/YZJc4hL8ZS9zqccwNJxXFZbMuqfW25hsXC/MsQlQkK
	 hql9pADYJdegyKSdSlpxt+hC6CNfpnlUJ1/PhIarp9gHQB6ERdwa1RWMeCAv8foLv
	 pxDIZ3OtafBVzi8lkd+z3Wl5TF+a7S9gJqXVrQMSHtf+mgi4hYZC+Jzs6atPFBeQc
	 8A4UjHtIAQA5LdmDvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1wXqfw2EpQ-00evH4; Sat, 26
 Sep 2026 19:12:12 +0200
Date: Sat, 26 Sep 2026 19:12:12 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: console: Clear readahead buffer on
 tcflush()
In-Reply-To: <20260926154038.3364-1-takashi.yano@nifty.ne.jp>
Message-ID: <65917936-1766-f022-c6b4-91a8a6983d39@gmx.de>
References: <20260926154038.3364-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:C7lMbfLdBofyhhqPLcoRh0Vkqh4RPMa59tu3v5HkWLGbL3ekvtD
 cdZQBct52LnBq8yceliwYfasXpGmPvV5I1ML0wx7wKTBqd7xttNY6Spt+sD+vBc3+eHG0OS
 XlqLvycUsdwtcrNf+L7bnIc7y0BOSEP2nUq7EQOh0RezZXjRCuAKterKKbPFneECyE11Z4Y
 PjMkU4JsXrLCIdjSnZPnw==
UI-OutboundReport: notjunk:1;M01:P0:aYiv7Lu+6C8=;Fx/H9d9b/OUPgPfWVY7lWhI0ZZA
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sun, 27 Sep 2026, Takashi Yano wrote:

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
> v5: Clear input_ready in close().

Excellent! I fail to have any concern about this patch iteration ;-)

Thank you so, so much for keeping at it. I know I have been complaining a
lot about the pseudo console support in Cygwin, and I cannot imagine how
annoying my frequent feedback is that requires so many patch revisions.
I'm sorry! And I am really grateful that you are taking my feedback so
gracefully and keep improving Cygwin.

Ciao,
Johannes

>  winsup/cygwin/fhandler/console.cc       | 30 +++++++++++++++++++------
>  winsup/cygwin/local_includes/fhandler.h |  2 +-
>  winsup/cygwin/select.cc                 |  8 +++----
>  3 files changed, 28 insertions(+), 12 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index d72bb39e0..fe15f15fa 100644
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
> @@ -1362,7 +1363,7 @@ fhandler_console::read (void *pv, size_t& buflen)
>        (get_ttyp ()->ti.c_cc[VTIME]*100 ? : INFINITE)));
> =20
>  read_more:
> -  while (!input_ready && !get_cons_readahead_valid ())
> +  while (!::input_ready && !get_cons_readahead_valid ())
>      {
>        int bgres;
>        if ((bgres =3D bg_check (SIGTTIN)) <=3D bg_eof)
> @@ -1446,7 +1447,7 @@ wait_retry:
>      get_readahead_into_buffer (buf + copied_chars, buflen - copied_char=
s);
> =20
>    if (!con_ra.ralen)
> -    input_ready =3D false;
> +    ::input_ready =3D false;
>    release_input_mutex ();
> =20
>    fix_input_mode_if_necessary (); /* for win32_input_mode */
> @@ -1500,7 +1501,7 @@ fhandler_console::process_input_message (size_t le=
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
> @@ -1879,14 +1880,14 @@ fhandler_console::process_input_message (size_t =
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
> @@ -2322,6 +2323,7 @@ fhandler_console::close (int flag)
>    if (con_ra.rabuf)
>      free (con_ra.rabuf);
>    memset (&con_ra, 0, sizeof (con_ra));
> +  ::input_ready =3D false;
> =20
>    if (!have_execed && !invisible_console
>        && (!CTTY_IS_VALID (myself->ctty)
> @@ -2490,8 +2492,9 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
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
> @@ -2506,6 +2509,9 @@ fhandler_console::tcflush (int queue)
>    if (queue =3D=3D TCIFLUSH
>        || queue =3D=3D TCIOFLUSH)
>      {
> +      /* tcflush() may be called inside the input_mutex,
> +	 however, mutex of Win32 can be acquired recursively. */
> +      acquire_input_mutex (mutex_timeout);
>        acquire_attach_mutex (mutex_timeout);
>        DWORD resume_pid =3D attach_console (con.owner);
>        BOOL r =3D FlushConsoleInputBuffer (get_handle ());
> @@ -2517,6 +2523,10 @@ fhandler_console::tcflush (int queue)
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
> @@ -2543,7 +2553,7 @@ fhandler_console::tcgetattr (struct termios *t)
>  }
> =20
>  fhandler_console::fhandler_console (fh_devices devunit) :
> -  fhandler_termios (), input_ready (false), thread_sync_event (NULL),
> +  fhandler_termios (), thread_sync_event (NULL),
>    input_mutex (NULL), output_mutex (NULL), unit (MAX_CONS_DEV),
>    num_input_events_processed (0)
>  {
> @@ -5122,3 +5132,9 @@ fhandler_console::tcdrain ()
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
> index 438b02bf0..a86da207b 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2187,7 +2187,6 @@ public:
>      tty_min tty_min_state;
>      dev_console con;
>    };
> -  bool input_ready;
>    enum input_states
>    {
>      input_error =3D -1,
> @@ -2374,6 +2373,7 @@ private:
>    int fstat (struct stat *buf);
>    void discard_key_events (size_t n);
>    void fix_input_mode_if_necessary ();
> +  bool input_ready ();
> =20
>    class console_unit
>    {
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index 37b28d5d1..e0bd1726f 100644
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
> @@ -1154,7 +1154,7 @@ peek_console (select_record *me, bool)
>    HANDLE h;
>    set_handle_or_return_if_not_open (h, me);
> =20
> -  while (!fh->input_ready && !fh->get_cons_readahead_valid ())
> +  while (!fh->input_ready () && !fh->get_cons_readahead_valid ())
>      {
>        if (fh->bg_check (SIGTTIN, true) <=3D bg_eof)
>  	return me->read_ready =3D true;
> @@ -1184,7 +1184,7 @@ peek_console (select_record *me, bool)
>  	  return -1;
>  	}
>      }
> -  if (fh->input_ready || fh->get_cons_readahead_valid ())
> +  if (fh->input_ready () || fh->get_cons_readahead_valid ())
>      return me->read_ready =3D true;
> =20
>    return me->write_ready;
> @@ -1284,7 +1284,7 @@ fhandler_console::select_read (select_stuff *ss)
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
