Return-Path: <SRS0=RROI=HU=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id CF1774BA23C5
	for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 07:46:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CF1774BA23C5
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CF1774BA23C5
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790581598; cv=none;
	b=fN5yhHCQVyvoOHs9nDrfmysBGS1UMeb4OxHPdg2TlSOUVhGx8DWCFF1SOBrR74U42VUBlrcPBB5/V2PDS8dX6RoN3DVAKJRvhX2YzJFBYssgEh3YpaVyt7Q/trqKz/pEAUlyC5M/FPqZbhSKjuMblETV107JXLDqnVpyXW3Dfyw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790581598; c=relaxed/simple;
	bh=NRQvl7orKXMziOi5hBfMUzHYqjFkpaOFRj7r6b9QxMQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=olPCpnzH9CGL+49YcS022eheEuhdTHmCbPcD885EYTQRkt81N4/1ZD4vs4CWcnHfWT13o/jespaevxGJDvK4toz9IrRQUsm1cZxeh0ynkyHWIoCNwofEh4HhHLet15klY5kZ3qWpdi75GvcqbFMbVZQFXC+E/49r57AIKzrGKGM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=QBMWLq5J
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CF1774BA23C5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=QBMWLq5J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790581596; x=1791186396;
	i=johannes.schindelin@gmx.de;
	bh=2EFbYxzdgNQAAAN7aZQAsedg9b2DCMZcrXHXoWhbAfc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QBMWLq5JmD029mY2jJT5mCyKoU7/oKIHsHKBnKU6KF43UyYid+bahh6QHfaKA9IM
	 DwcrW9C+vGT1pmQVAVl2zBaGiMqF9x+uLfUBYR7s6lhB5OrJ1GG9x0NkHMG/U6eWI
	 FgoUb+Ps6dRk0PsRXUH4Y86Ug3gRTxquMEqe4q9l1bIiasX4pc4HA9DLlJyJpeOWH
	 64HInuY/TGUAINxECckLliUYIyPU7ZHw4uxEnlEfEuh48fqXlvUuP/FGcWMsRVaUI
	 q4TV2nyyIh1hKogdtRVAJmitjXmXjyUdAMBcKmOK6+Jz+7hmDRnGWuXZtRlUYEIXb
	 9iCXHGciQgX8c1dYtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1xFIv10haF-00TviE; Mon, 28
 Sep 2026 09:46:36 +0200
Date: Mon, 28 Sep 2026 09:46:33 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <20260927203545.526-1-takashi.yano@nifty.ne.jp>
Message-ID: <284d786f-d60c-0350-a8aa-f96779612ae5@gmx.de>
References: <20260927203545.526-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:x6KZyARsIJCDv4ulq2BMJqUdCLY0DZaNWSgt7sS7GrmwDpp09TW
 TTgERASQBxyoHBjmU44d++a2IN1Oew1Eu0etdtek38WjEMGl8FGaepNfSCAZoJPOSsrIaq6
 HH9B1qyaX2zCVVY8eQmYP7pEm+dIzLSVAqifd3BsEzWN1OzbU8jrqZc91gHSl8nUoee4lTN
 bpqBiRdDjhSdwXWieFGAQ==
UI-OutboundReport: notjunk:1;M01:P0:WuXo3hWYFHk=;3XfU61kCaZ7sKkhKqO1t3XZy+eY
 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
 lIuQLfhZRsM7TVYwiU6di9+fappL2reZYU76OM=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 28 Sep 2026, Takashi Yano wrote:

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
> v7: Do not overwrite errno in input_error case.

That looks good, with one minor correction:

>=20
>  winsup/cygwin/fhandler/console.cc       | 26 ++++++++++++++++++-
>  winsup/cygwin/local_includes/fhandler.h |  3 ++-
>  winsup/cygwin/select.cc                 | 33 ++++++++++++++++---------
>  3 files changed, 49 insertions(+), 13 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index fe15f15fa..c9d870769 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1418,6 +1418,7 @@ wait_retry:
>  	{
>  	case input_error:
>  	  release_input_mutex ();
> +	  /* errno is already set in process_input_message() */
>  	  goto err;
>  	case input_processing:
>  	  release_input_mutex ();
> @@ -1432,9 +1433,28 @@ wait_retry:
>  	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
>  	    continue;
>  	  goto sig_exit;
> +	case input_empty:
> +	  /* Reaches here when the input buffer is empty even though
> +	     the input handle is signalled. */
> +	  release_input_mutex ();
> +	  if (is_nonblocking ())
> +	    {
> +	      if (copied_chars)
> +		{
> +		  fix_input_mode_if_necessary (); /* for win32_input_mode */
> +		  buflen =3D copied_chars;
> +		  return;
> +		}
> +	      set_sig_errno (EAGAIN);
> +	      buflen =3D (size_t) -1;
> +	      return;
> +	    }
> +	  cygwait (40);
> +	  continue;
>  	default:
>  	  /* Should not come here */
>  	  release_input_mutex ();
> +	  __seterrno ();

This is correct, and the `switch (cygwait (...))` default case needs the
same handling, see:

https://github.com/cygwin/cygwin/blob/6bee3713a347/winsup/cygwin/fhandler/=
console.cc#L1344-L1357

Something like this should do the trick:

=2D- snip --
 	default:
 	  if (GetLastError () =3D=3D ERROR_INVALID_HANDLE)
 	    { /* Confirm the handle is still valid */
 	      DWORD mode;
 	      acquire_attach_mutex (mutex_timeout);
 	      DWORD resume_pid =3D attach_console (con.owner);
 	      BOOL res =3D GetConsoleMode (get_handle (), &mode);
 	      detach_console (resume_pid, con.owner);
 	      release_attach_mutex ();
 	      if (res)
 		goto wait_retry;
 	    }
+	  __seterrno ();
 	  goto err;
 	}
=2D- snap --

Thank you!
Johannes

>  	  goto err;
>  	}
>      }
> @@ -1462,7 +1482,6 @@ wait_retry:
>    return;
> =20
>  err:
> -  __seterrno ();
>    buflen =3D (size_t) -1;
>    return;
> =20
> @@ -1489,10 +1508,12 @@ fhandler_console::process_input_message (size_t =
len)
>    DWORD resume_pid =3D attach_console (con.owner);
>    BOOL r =3D
>      PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_rea=
d);
> +  DWORD error =3D GetLastError ();
>    detach_console (resume_pid, con.owner);
>    release_attach_mutex ();
>    if (!r)
>      {
> +      __seterrno_from_win_error (error);
>        termios_printf ("PeekConsoleInput failed, %E");
>        return input_error;
>      }
> @@ -1504,6 +1525,9 @@ fhandler_console::process_input_message (size_t le=
n)
>    if (::input_ready && (len =3D=3D 0 || (get_ttyp ()->ti.c_lflag & ICAN=
ON)))
>      return input_ok;
> =20
> +  if (total_read =3D=3D 0)
> +    return input_empty;
> +
>    for (i =3D 0; i < total_read; i ++)
>      {
>        DWORD nread =3D 1;
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index a86da207b..65e326135 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2193,7 +2193,8 @@ public:
>      input_processing =3D 0,
>      input_ok =3D 1,
>      input_signalled =3D 2,
> -    input_winch =3D 3
> +    input_winch =3D 3,
> +    input_empty =3D 4,
>    };
>    typedef cons_handle_set_t handle_set_t;
>    HANDLE thread_sync_event;
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index e0bd1726f..7c14800fd 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
>        return 1;
>      }
> =20
> -  INPUT_RECORD irec;
> -  DWORD events_read;
>    HANDLE h;
>    set_handle_or_return_if_not_open (h, me);
> =20
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
