Return-Path: <SRS0=BQMy=HT=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 086834BA23CD
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 11:54:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 086834BA23CD
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 086834BA23CD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790510078; cv=none;
	b=sqmqc95SbHcmZ4U16nM5kxvaIa3TOYyPvG2M3Po2IU6WZ/FsGEypTzhTMTwvYtYjqJQknOmKVW6bUkNELCvj2PoB2XevWK7S4mDUuLQ8eriPN8WzLN2bjYHB0W+7oot+bB+40pHTSeBCRxHJLDL3FdmXooyPXu6gScJ+g6kfm9A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790510078; c=relaxed/simple;
	bh=+tgi8ZNlSotVRIM9Mtm+LBd2CtydtuCvemvFA0YGpsw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=W2+KxuJTzYYYfFBxiS/qwzzjfjdZk9dojvM0++3kcB6rIewAD/jDgjjy/WoSaFk3f3Dj2XMzGYDCa/CdFqp9jreF9y6B2SeEoyBm8/vSdoI4Rj+9FI6XxaGCiS5CtpNzRL1/iMo3WZBKFP4wOABCvC3SmOXA6cZjPSQ/5yppPBg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Gj0fhJGX
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 086834BA23CD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Gj0fhJGX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790510069; x=1791114869;
	i=johannes.schindelin@gmx.de;
	bh=qgWJK0Nirz1ipg7IklcXOYEoTDU9q2ZT1oVNsz90rAY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gj0fhJGXTpiO0Ktsb3uamBFDCCHpDPm7eWm6QYHbhOvCeiuUFQwTkGnwM/Zrug5O
	 mC2cihT6HSErz2k62CvQuWQy+VVK3pfo7jISE8MNjrRolq2JBaDnXXsvc9yi/AfYP
	 6O9jQOTjyjvscpP+E3TAqAjA/NtkMYZAk8yVkh8fldjqLhuoKHaJMeX8ZHFyPfGO2
	 /cQJa1cahlO9YaV5woijc+r8wzQf7zLbDT69ICSdLgCLC/+L8AKfi3YepYpdTw5WL
	 OdlzHbBdyZXM0QUOtaZg+npAl414FIuBZXD001FsNxYyRSp2eQRiUYI9nMZ8D8fau
	 DkYkgVYEwTTrnTQTGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1x0O7z1PBa-009SLO; Sun, 27
 Sep 2026 13:54:29 +0200
Date: Sun, 27 Sep 2026 13:54:26 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <f280b842-7618-c159-5288-52a4fad8dfd1@gmx.de>
Message-ID: <fe46f2da-bcb0-37ea-b10b-307438c9bfb7@gmx.de>
References: <20260926165326.16789-1-takashi.yano@nifty.ne.jp> <f280b842-7618-c159-5288-52a4fad8dfd1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:vrTTWVfgycgEfDtBYc1fEYfKVpfQ8Q/odCjkdATGiAmJLqrD+Ev
 W+iC7SBW7IFt9nLBCt6lh5K+TVrJZBU7pHwENUQHQeAhHxonq1y7k1ditndyiUnpQUNBXHy
 4aMedQ2vyH+XcMb1svK7Ud/5R/Xp4iyKT7Q4fLKhItacGnlRhCaiilBmmIOBpKz/3c0derb
 4R7VRVNFewQXfdECngJUA==
UI-OutboundReport: notjunk:1;M01:P0:PBxg9nWKQ34=;fuysWeV2lVd2qN6J0RrUd+AdT/U
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 26 Sep 2026, Johannes Schindelin wrote:

> On Sun, 27 Sep 2026, Takashi Yano wrote:
>=20
> > [...]
> > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > index e0bd1726f..d899dcd65 100644
> > --- a/winsup/cygwin/select.cc
> > +++ b/winsup/cygwin/select.cc
> > [...]
> > @@ -1176,14 +1169,30 @@ peek_console (select_record *me, bool)
> >        fh->release_input_mutex ();
> >        fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
> > =20
> > -      if (ret =3D=3D fhandler_console::input_winch
> > -	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> > -	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
> > +      switch (ret)
> >  	{
> > +	case fhandler_console::input_processing:
> > +	case fhandler_console::input_ok:
> > +	  break;
> > +	case fhandler_console::input_winch:
> > +	  if (global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> > +	      && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
> > +	    {
> > +	      set_sig_errno (EINTR);
> > +	      return -1;
> > +	    }
> > +	  break;
> > +	case fhandler_console::input_signalled:
> >  	  set_sig_errno (EINTR);
> >  	  return -1;
> > +	case fhandler_console::input_error:
> > +	  __seterrno ();
> > +	  return -1;
>=20
> The caller of this function, `select_stuff::poll()` reacts to that -1 by
> `set_errno (s->thread_errno)`, but `thread_errno` is not set by
> `__seterrno ()`; In fact, it is not set anywhere in the call path,
> remaining at value 0.
>=20
> To set it properly, I think that the `process_input_message()` function
> should record `GetLastError ()` when `PeekConsoleInputW ()` failed. Mayb=
e
> something like this?
>=20
> -- snip --
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 77786a1a60..859b56c687 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1437,10 +1437,12 @@ fhandler_console::process_input_message (size_t =
len)
>    DWORD resume_pid =3D attach_console (con.owner);
>    BOOL r =3D
>      PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_rea=
d);
> +  DWORD error =3D r ? ERROR_SUCCESS : GetLastError ();
>    detach_console (resume_pid, con.owner);
>    release_attach_mutex ();
>    if (!r)
>      {
> +      __seterrno_from_win_error (error);
>        termios_printf ("PeekConsoleInput failed, %E");
>        return input_error;
>      }
> -- snap --

Oy, I completely missed that `__seterrno_from_win_error ()` does _not_ set
`thread_errno`, sorry! The complete fix also needs something like this
immediately after `process_input_message()` returns, before `cleanup()` ca=
n
disturb `errno`:

=2D- snip --
int ret =3D fh->process_input_message (0);
if (ret =3D=3D fhandler_console::input_error)
  me->thread_errno =3D errno;
=2D- snap --

Sorry about that!
Johannes
