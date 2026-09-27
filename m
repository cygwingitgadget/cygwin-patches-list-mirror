Return-Path: <SRS0=BQMy=HT=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 3F2104BA79A5
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 13:15:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3F2104BA79A5
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3F2104BA79A5
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790514929; cv=none;
	b=i8KBOb10V/Ipv9y/wuPquYFZIuL/eGh07reeNeANbPT8ZOkTgs9LV0n6t9nbr8IxuhoHApBflZ/5BYBS3SFm9G5aGxhaxJzQk5eMXw7sGidY3OlJQukxsvJ6qL4infMZD7++XDTJkztj62JRvV63hHf6n/xAU2DfkRnBpbP8GMg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790514929; c=relaxed/simple;
	bh=KIHC055VlTZfLZl2eW0jfyuDLgRCfe4mD0e0uDwTdnU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=nmVlKWkNLxMNKXzz9BECkN6tFf3D3cQqo5jEfKHF1lsXS53u2g0IomMVazQEawN+Mhj17N3yTRYR9ovMiDFQYg5Czhv5ebmnYYFtwGQG5sjUKqDOg0V8bVsAYawv9+LsYw/bcM+GfiBA9OKl49OKq4Va8dGlESxNmtb+hn/ZjxA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=VzEgHMcF
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3F2104BA79A5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=VzEgHMcF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790514927; x=1791119727;
	i=johannes.schindelin@gmx.de;
	bh=ReRCrAkWWOsCIS/pdq29FmvYVspGDb+i8amxZv7pnYw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VzEgHMcFIAgdlc7+kVoEIGY3+zpqrufnzUBvH8naAsEcujPYB//89RXEBT6aFxR0
	 qGLBPI9ePEIUhcU3wJrwpcFNyUT4Q/kNRr+ohIktCr/C3dA9k1s36Y7cQ5cmJfA/S
	 pIto96Iv1Kq7QTeB5n+7oewKPJEzcYXI2jvA6NY68TU9ERCEDU4PwW6dbNzdBmI3M
	 v0GFJEzM9U+VW4x/XVPL93DtNEVVmiCdawG+qqVtitZOnq0v41F1Z05m4rZL0Sc65
	 3SbyvF7woBKW2VPH+s9BMQMRF6z3q0DHz0OLz0tUNiPYP2eDtez/OTPE6PtCEwM0C
	 RgeHIYrxSrqmNbhSOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHs0-1wrmR33Ddy-00rVig; Sun, 27
 Sep 2026 15:15:27 +0200
Date: Sun, 27 Sep 2026 15:15:27 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <20260927182002.8423d03403b8f93d268aab16@nifty.ne.jp>
Message-ID: <7c662a3b-1d30-3f2b-525b-80226c394e50@gmx.de>
References: <20260926165326.16789-1-takashi.yano@nifty.ne.jp> <f280b842-7618-c159-5288-52a4fad8dfd1@gmx.de> <20260927182002.8423d03403b8f93d268aab16@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=8323328107560693317905149291272
X-Provags-ID: V03:K1:ljP46vX5tH+IjscI/lSeaMF3/nGT6rBHGYA95R8jEBBIQ6r7myx
 o5UPUWZTTjVnj7tHuvzEJD9QeSvNZE5nz0uE4q7YPInUcPiILhkTRajcxnqgnAWJs9AgA7t
 MmnsSnVdK+VUO/NvmwelUURiWV8M3xy1JBk4Olx5Q0ltuTGkvcy6evKrJMU1JtW99flWcKw
 sMby5JWkZee7o6KH3okDA==
UI-OutboundReport: notjunk:1;M01:P0:+lXMJTyDnYI=;eiHvjU7bDC2enO65D07pPzMfRaw
 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
 t9H8bGnR/drs5402A+Zky9fFC+F3o=
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328107560693317905149291272
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Sun, 27 Sep 2026, Takashi Yano wrote:

> On Sat, 26 Sep 2026 21:08:45 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > On Sun, 27 Sep 2026, Takashi Yano wrote:
> >=20
> > > [...]
> > > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > > index e0bd1726f..d899dcd65 100644
> > > --- a/winsup/cygwin/select.cc
> > > +++ b/winsup/cygwin/select.cc
> > > [...]
> > > @@ -1176,14 +1169,30 @@ peek_console (select_record *me, bool)
> > >        fh->release_input_mutex ();
> > >        fh->fix_input_mode_if_necessary (); /* for win32_input_mode *=
/
> > > =20
> > > -      if (ret =3D=3D fhandler_console::input_winch
> > > -	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> > > -	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
> > > +      switch (ret)
> > >  	{
> > > +	case fhandler_console::input_processing:
> > > +	case fhandler_console::input_ok:
> > > +	  break;
> > > +	case fhandler_console::input_winch:
> > > +	  if (global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> > > +	      && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
> > > +	    {
> > > +	      set_sig_errno (EINTR);
> > > +	      return -1;
> > > +	    }
> > > +	  break;
> > > +	case fhandler_console::input_signalled:
> > >  	  set_sig_errno (EINTR);
> > >  	  return -1;
> > > +	case fhandler_console::input_error:
> > > +	  __seterrno ();
> > > +	  return -1;
> >=20
> > The caller of this function, `select_stuff::poll()` reacts to that -1 =
by
> > `set_errno (s->thread_errno)`, but `thread_errno` is not set by
> > `__seterrno ()`; In fact, it is not set anywhere in the call path,
> > remaining at value 0.
> >=20
> > To set it properly, I think that the `process_input_message()` functio=
n
> > should record `GetLastError ()` when `PeekConsoleInputW ()` failed. Ma=
ybe
> > something like this?
>=20
> Since the return value of GetLastError() is preserved until
> the next Win32 error occurs, wouldn=E2=80=99t your code and mine
> produce the same result?
>=20
> __seterrno() calls seterrno(), which calls seterrno_from_win_error()
> with GetLastError().
>=20
> So, what needed here is:
>   me->thread_errno =3D get_errno();
> after __seterrno(), isn't it?
>=20
> Alternatively,
>   me->thread_errno =3D geterrno_from_win_error();
> where the the intent of the code might be clearer than above.

Oops, I should have checked my mail first before sending the follow-up
https://inbox.sourceware.org/cygwin-patches/fe46f2da-bcb0-37ea-b10b-307438=
c9bfb7@gmx.de/.
Happily, you saw my mistake.

However, I do want to point out that preserving the return value of
`GetLastError()` directly after a failed `PeekConsoleInputW()` is
necessary, as the in-between code calls:

- `detach_console()`, which can call `FreeConsole()` and `AttachConsole()`
- `release_attach_mutex()`
- `release_input_mutex()`
- `fix_input_mode_if_necessary()`, which invokes several more Win32 APIs

Each of those could cause a different value than desired to be returned by
`GetLastError()`.

Ciao,
Johannes

> > -- snip --
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandle=
r/console.cc
> > index 77786a1a60..859b56c687 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1437,10 +1437,12 @@ fhandler_console::process_input_message (size_=
t len)
> >    DWORD resume_pid =3D attach_console (con.owner);
> >    BOOL r =3D
> >      PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_r=
ead);
> > +  DWORD error =3D r ? ERROR_SUCCESS : GetLastError ();
> >    detach_console (resume_pid, con.owner);
> >    release_attach_mutex ();
> >    if (!r)
> >      {
> > +      __seterrno_from_win_error (error);
> >        termios_printf ("PeekConsoleInput failed, %E");
> >        return input_error;
> >      }
> > -- snap --
> >=20
> > Ciao,
> > Johannes
> >=20
> > > +	case fhandler_console::input_empty:
> > > +	  goto out;
> > >  	}
> > >      }
> > > +out:
> > >    if (fh->input_ready () || fh->get_cons_readahead_valid ())
> > >      return me->read_ready =3D true;
> > > =20
> > > --=20
> > > 2.51.0
> > >=20
> > >=20
>=20
>=20
> --=20
> Takashi Yano <takashi.yano@nifty.ne.jp>
>=20

--8323328107560693317905149291272--
