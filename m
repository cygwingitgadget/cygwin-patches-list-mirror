Return-Path: <SRS0=IPbk=B4=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 05D5B4BA23ED
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 13:34:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 05D5B4BA23ED
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 05D5B4BA23ED
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774704879; cv=none;
	b=rHsQIRXZBcZZV3WjVhT5jSR2D+/e7ILdzh5AOM/evLCSGo8Popu1pvyHnrD5UO3mG7j3wdDPb3I+WgV/aVlFxbvFyi48O4qzQ65p6aZcZcSnFzn4YpumqIRZ5BcTiHfxgMCIXz2h1x4ceOCbpOJkpMSjrZbOuxq3+8ra69XfNK4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774704879; c=relaxed/simple;
	bh=ktTTGY0fJi4U3x4SCgM6BEk6tqA74YwXxT5bKWwmRHE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=QgiTXR8fUk6oNyNqB5PVvOCKvyEjXaVJqPuLngdj+AP86vx7jNfIFGzKp8e5ftIRG1cP5HJWMQDI7MbK9QHTOwk1+gzozuI9pepgYniSqzZNoYMU+eUJr3E9CkDdexuatXgRh0VME7YN8bM2ExOplu/p+w4rvtdyxch0RrXRRDU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 05D5B4BA23ED
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=VtAeH2Dh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774704877; x=1775309677;
	i=johannes.schindelin@gmx.de;
	bh=AzHxQbAwFCvey3zhB/5cn1MtVG9PUg2AtKdZK76W09M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VtAeH2DhAuKlRtoIsW4IpEtJ23uvzpAivk8f/wJui2wFg5ndWCbJCeDBjWllMJSX
	 44N/s/jMM/B7J+DcCQlJT/OKqJzhgPcv2GjabnHQTaUrLx4Oc1FmwTRfkeO/bdrwV
	 13LqVJn+Gf5OYtueR/eFf4YKuSjIKWbV6JCqNQAnoVsqIpCyMQxMsfCGI6jIkQxbI
	 BlVGFKyuFR0Qv1XR2+Gj4K1LYR5RBYy6rGVglUV33xPuZrx3AfqQZkTtbHzHuNv9L
	 /W3xn/fxW3WZabELWfeHEgdNN/55VbjDttT2EHNGS8FMCRnGu0kx4v1VD1ddfTPJ6
	 rgLTLl7RpAMxxxfCyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1vbWiD2KUC-00bQPf; Sat, 28
 Mar 2026 14:34:37 +0100
Date: Sat, 28 Mar 2026 14:34:35 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8 2/7] Cygwin: pty: Add workaround for handling of
 backspace when pcon enabled
In-Reply-To: <20260328203109.e20fad5aad072d10a35800ae@nifty.ne.jp>
Message-ID: <27ddd8d0-b988-fdf6-95c2-0c4ecd5e44d0@gmx.de>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260328105632.1916-1-takashi.yano@nifty.ne.jp> <20260328105632.1916-3-takashi.yano@nifty.ne.jp> <20260328203109.e20fad5aad072d10a35800ae@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DGlXwhxNkIu0fmjLUMJtCDFUzl7rDX/Nepi9PrLKzOvfs6kVaEx
 T5YHyM78Mh7pPWsLNPrlY8lFA1Ol4c0KeuF2aLNO3fbK+qTg7vGJAyjta5bOpickq07gkuc
 49cgNj2eIirGF07T7PRbHVbH+5hqbF1yHCJ8UBUHvbre05pk7SehDYbZMmztdaM/EK8Y9AE
 m9NVkfhic3LrapBkAewBw==
UI-OutboundReport: notjunk:1;M01:P0:ikReyqNKROk=;PTrs1GHXCU4Ld1lFb+9YC+s/hJe
 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
 iJEJbjOkxGK
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 28 Mar 2026, Takashi Yano wrote:

> On Sat, 28 Mar 2026 19:55:46 +0900 Takashi Yano wrote:
>
> > @@ -2241,28 +2246,75 @@ fhandler_pty_master::write (const void *ptr, s=
ize_t len)
> >      { /* Reaches here when non-cygwin app is foreground and pseudo co=
nsole
> >  	 is activated. */
> >        tmp_pathbuf tp;
> > -      char *buf =3D (char *) ptr;
> > +      char *buf =3D tp.c_get ();
> >        size_t nlen =3D len;
> >        if (get_ttyp ()->term_code_page !=3D CP_UTF8)
> >  	{
> >  	  static mbstate_t mbp;
> > -	  buf =3D tp.c_get ();
> >  	  nlen =3D NT_MAX_PATH;
> >  	  convert_mb_str (CP_UTF8, buf, &nlen,
> >  			  get_ttyp ()->term_code_page, (const char *) ptr, len,
> >  			  &mbp);
> >  	}
> > +      else
> > +	memcpy (buf, ptr, nlen);
> > =20
> > -      for (size_t i =3D 0; i < nlen; i++)
> > +      if (get_ttyp ()->nat_pipe_owner_pid !=3D nat_pipe_owner_pid_dup=
ped
> > +	  && !nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
> > +	{
> > +	  if (h_pcon_in_dupped)
> > +	    ForceCloseHandle (h_pcon_in_dupped);
> > +	  h_pcon_in_dupped =3D NULL;
> > +	  nat_pipe_owner_pid_dupped =3D 0;
> > +	  HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > +					   get_ttyp ()->nat_pipe_owner_pid);
> > +	  if (pcon_owner)
> > +	    {
> > +	      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> > +			       GetCurrentProcess (), &h_pcon_in_dupped,
> > +			       0, FALSE, DUPLICATE_SAME_ACCESS);
> > +	      nat_pipe_owner_pid_dupped =3D get_ttyp ()->nat_pipe_owner_pid;
> > +	      CloseHandle(pcon_owner);
> > +	    }
> > +	}
> > +      else
> > +	{
> > +	  h_pcon_in_dupped =3D get_ttyp ()->h_pcon_in;
> > +	  nat_pipe_owner_pid_dupped =3D get_ttyp ()->nat_pipe_owner_pid;
> > +	}
>=20
> Oops! This is wrong.
>=20
> Should be:
> +      if (get_ttyp ()->nat_pipe_owner_pid !=3D nat_pipe_owner_pid_duppe=
d)
> +       {
> +         if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
> +           {
> +             if (h_pcon_in_dupped)
> +               ForceCloseHandle (h_pcon_in_dupped);
> +             h_pcon_in_dupped =3D NULL;
> +             nat_pipe_owner_pid_dupped =3D 0;
> +             HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FAL=
SE,
> +                                              get_ttyp ()->nat_pipe_own=
er_pid);
> +             if (pcon_owner)
> +               {
> +                 DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> +                                  GetCurrentProcess (), &h_pcon_in_dupp=
ed,
> +                                  0, FALSE, DUPLICATE_SAME_ACCESS);
> +                 nat_pipe_owner_pid_dupped =3D get_ttyp ()->nat_pipe_ow=
ner_pid;
> +                 CloseHandle(pcon_owner);
> +               }
> +           }
> +         else
> +           {
> +             h_pcon_in_dupped =3D get_ttyp ()->h_pcon_in;
> +             nat_pipe_owner_pid_dupped =3D get_ttyp ()->nat_pipe_owner_=
pid;
> +           }
> +       }

Ah, that makes sense. Even the `else` clause should be guarded by the
`nat_pipe_owner_pid !=3D nat_pipe_owner_pid_dupped` guard.

About the patch itself: I am not super-hyped about the proliferation of
handles, but honestly, I do not see any good alternative either.

Thank you!
Johannes

>=20
> > +
> > +      /* Retrieve console mode */
> > +      DWORD cons_mode =3D ENABLE_VIRTUAL_TERMINAL_INPUT;
> > +      if (h_pcon_in_dupped && memchr (buf, '\010' /* Ctrl-H */, nlen)=
)
> > +	{
> > +	  if (!nat_pipe_owner_self (nat_pipe_owner_pid_dupped))
> > +	    {
> > +	      DWORD resume_pid =3D
> > +		attach_console_temporarily (nat_pipe_owner_pid_dupped);
> > +	      GetConsoleMode (h_pcon_in_dupped, &cons_mode);
> > +	      resume_from_temporarily_attach (resume_pid);
> > +	    }
> > +	  else
> > +	    GetConsoleMode (h_pcon_in_dupped, &cons_mode);
> > +	}
> > +
> > +      len =3D nlen;
> > +      for (size_t i =3D 0, j =3D 0; i < len; i++)
> >  	{
> >  	  process_sig_state r =3D process_sigs (buf[i], get_ttyp (), this);
> > -	  if (r =3D=3D done_with_debugger)
> > +	  if (r !=3D done_with_debugger)
> >  	    {
> > -	      for (size_t j =3D i; j < nlen - 1; j++)
> > -		buf[j] =3D buf[j + 1];
> > -	      nlen--;
> > -	      i--;
> > +	      char c =3D buf[i];
> > +	      /* Workaround for pseudo console in Windows 11 */
> > +	      if (!(cons_mode & ENABLE_VIRTUAL_TERMINAL_INPUT))
> > +		/* Undesired backspace conversion in pseudo console does
> > +		   not happen if ENABLE_VIRTUAL_TERMINAL_INPUT is set. */
> > +		if (c =3D=3D '\010') /* Ctrl-H */
> > +		  c =3D '\177';  /* Backspace */
> > +	      buf[j++] =3D c;
> >  	    }
> > +	  else
> > +	    nlen--;
> >  	}
> > =20
> >        DWORD n;
> > @@ -3998,6 +4050,10 @@ fhandler_pty_slave::transfer_input (tty::xfer_d=
ir dir, HANDLE from, tty *ttyp,
> >  	    if (r[i].EventType =3D=3D KEY_EVENT && r[i].Event.KeyEvent.bKeyD=
own)
> >  	      {
> >  		DWORD ctrl_key_state =3D r[i].Event.KeyEvent.dwControlKeyState;
> > +		if (r[i].Event.KeyEvent.uChar.AsciiChar =3D=3D '\010' /* Ctrl-H */
> > +		    && !(ctrl_key_state & ALT_PRESSED))
> > +		  /* Workaround for pseudo console in Windows 11 */
> > +		  r[i].Event.KeyEvent.uChar.AsciiChar =3D '\177'; /* Backspace */
> >  		if (r[i].Event.KeyEvent.uChar.AsciiChar)
> >  		  {
> >  		    if ((ctrl_key_state & ALT_PRESSED)
> > diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/l=
ocal_includes/fhandler.h
> > index 16f55b4f7..7ea04a26c 100644
> > --- a/winsup/cygwin/local_includes/fhandler.h
> > +++ b/winsup/cygwin/local_includes/fhandler.h
> > @@ -2564,6 +2564,8 @@ private:
> >    HANDLE thread_param_copied_event;
> >    HANDLE helper_goodbye;
> >    HANDLE helper_h_process;
> > +  HANDLE h_pcon_in_dupped;
> > +  DWORD nat_pipe_owner_pid_dupped;
> > =20
> >  public:
> >    HANDLE get_echo_handle () const { return echo_r; }
> > --=20
> > 2.51.0
> >=20
>=20
>=20
> --=20
> Takashi Yano <takashi.yano@nifty.ne.jp>
>=20
