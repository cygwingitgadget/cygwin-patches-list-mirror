Return-Path: <SRS0=sC3n=XY=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 53D853858D34
	for <cygwin-patches@cygwin.com>; Thu,  8 May 2025 07:19:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 53D853858D34
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 53D853858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746688795; cv=none;
	b=baurPFMRfjwEdW2pTvQdWa3tVs/PwKdj0mK1inoWRUBPlCvVYKZDEQ6n18CJe3445cEZwCg/vH4FtS/us7wxHnunQK95cXHElmQWkRH2SSQEvzv39i63RA/tNXCSCisQtb8/hbmrda4XYyAOIEqAyPPCHlB2pVr2JWuLQGQhvBU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746688795; c=relaxed/simple;
	bh=YX5VjNNPE/V7KVPpgoD05U8na8DrFqnUKiLJXnuKohw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=KJpQ/kYU5hR3z/ZBzvUuIQFH+A+WtGiu5XExT/deRdT6L2O+Rgm7rNlJSSJJ2BOQjHy6FXcC1H8RfrO1j4tKgjCxjl0y97zEDrHZ+HLy6GR0GIrGVIlucCqvKP/hwR4W/2ugWT4TxkOe7AA284G8iyNTBMXObzMSDqWPaROLgiQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 53D853858D34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=EhycSa+g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746688788; x=1747293588;
	i=johannes.schindelin@gmx.de;
	bh=G2oPx/OqagZFMHWaBcdCUHzYJvudvETeTs9aHzSZZ7E=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EhycSa+gPlNmrrYMKkpVUHefK+LrIqzsqhAGKeAAxNMvQ4DXDbKkqCa98e/wibyf
	 lNQHAyyLIQsObLwAuzPUE7MzJhi836AxRiO2NRl4+RLkVHCx5GP6PTs1SyAAwtTBW
	 bcNEVaJWHoJliqaJOcqXrM55ttwini6kUnmeqFkJSBJdyvYIDW25YicuCuHX9uwBU
	 Ohdi6EPLi3g5kzC20SgoMdyh+og5ZyUUZb0Khs7OL0cIY6Q1D0I3wDCPcT4vl4MDj
	 803s3Ay5OYYqGbXvJdKkLYzhHnc4a34a9Hsa6Sb9uSMl6cGFUsvx8J5os4H4Io3IJ
	 A+9B6eQLc4mQgDxDSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.189]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1upaHg1oCC-00qjez; Thu, 08
 May 2025 09:19:48 +0200
Date: Thu, 8 May 2025 09:19:47 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Store console mode only when console
 is opened
In-Reply-To: <20250507073114.12640-1-takashi.yano@nifty.ne.jp>
Message-ID: <a7787513-177a-05e5-401d-3710e975de55@gmx.de>
References: <20250507073114.12640-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YIiZl/YgWLyfyc81PhSnN7DSaWqU6vGqEVEqoXshPeBReJ/dvPy
 GsDAW3EBnkBIsSbQXttuIRBSLA9eyGRgywcIFXhv8Na8GEhfKXUU8hfRHkGJcuEkiC8UEiI
 1yGBFbB0aKIA2E/bYY6yy3EJTltEUwMdbOS4XMCpKMewiMHD6KIX2DaGCkvxRm6OAPwaqif
 vmEqnHD3MJW3GZO3BjBFw==
UI-OutboundReport: notjunk:1;M01:P0:RHCWgwmxpCw=;XpV7wT+PAVoQQRCxpRzdhPs4zW5
 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
 A3PAU7UZMqAvQ=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 7 May 2025, Takashi Yano wrote:

> ... and restore it when app exits. The commit 0bfd91d57863 has a bug
> that the console mode is stored into the shared memory when both:
>   (1) cygwin process is started from non-cygwin process.
>   (2) cygwin process started from non-cygwin process exits.
> (1) is intended, but (2) is not. Due to (2), the stored console mode
> is unexpectedly broken when the cygwin process exits. Then the mode
> restored will be not as expected. This causes undesired console mode
> in the use case that cygwin and non-cygwin apps are mixed.
>=20
> With this patch, the console mode will stored only in the case (1).
> This is done by putting the code, which stores the console mode, into
> fhandler_console::open() rather than fhandler_console::set_input_mode()
> and fhandler_console::set_output_mode().
>=20
> Fixes: 0bfd91d57863 ("Cygwin: console: tty::restore really restores the =
previous mode")
> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>

Thank you! I can confirm that this re-fixes the problem fixed in
3312f2d21f (Cygwin: console: Redesign mode set strategy on close().,
2025-03-03), which was in response to a report I received in
https://github.com/microsoft/git/issues/730.

I also asked the reporter of the bug you fixed in 114cbda779 (Cygwin:
console: tty::restore really restores the previous mode, 2025-03-21)
(which was the cause for the regression I reported) to verify that _their_
bug did not reappear, see
https://github.com/msys2/msys2-runtime/issues/268#issuecomment-2858071841

Finally, I spent quite a few hours to write an automated test that
imitates my reproducer, and integrated it into Git for Windows' CI builds:
https://github.com/git-for-windows/msys2-runtime/pull/95/commits/7acbb0316=
54404c9fd711eee9974c88475de98fd

However, I still have concerns about the patch. It still lets the Cygwin
runtime operate under the assumption that it can control the console, even
though other process can interact with the same console in _overlapping_
lifecycles.

Keep in mind that the bug I reported twice involves a Cygwin process that
spawns a non-Cygwin process which writes to the console _after_ the Cygwin
process exited (and restored the console mode).

It looks plausible to me that this storing, setting, then re-setting of
the console mode by the Cygwin runtime will never cease to be fragile and
will always be prone to surface bugs that are similar, bug not identical
to the two bugs referenced above.

Therefore I fail to convince myself that the current design is okay, and
expect that, in the long run, the Cygwin runtime will stop to toggle the
console modes as if the console were not serving other, non-Cygwin
processes, too.

I do see that you changed some code so that it is only run when Cygwin is
the console owner. That triggers the following questions, answers to which
I could not find in the commit message (and neither in the diff):

- Now that the mode is left alone when the console is owned by a
  non-Cygwin process, which code is broken? There must have been a reason
  to change the console mode in the first place, after all.

- If it is okay to leave the console mode alone when Cygwin is _not_ the
  console owner, why bother changing the mode at all?

Ciao,
Johannes

> ---
>  winsup/cygwin/fhandler/console.cc | 33 ++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 2e19e0dd7..16352d04d 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -771,6 +771,8 @@ fhandler_console::setup ()
>        con.disable_master_thread =3D true;
>        con.master_thread_suspended =3D false;
>        con.num_processed =3D 0;
> +      con.curr_input_mode =3D tty::restore;
> +      con.curr_output_mode =3D tty::restore;
>      }
>  }
> =20
> @@ -849,11 +851,6 @@ fhandler_console::set_input_mode (tty::cons_mode m,=
 const termios *t,
>  	flags |=3D ENABLE_PROCESSED_INPUT;
>        break;
>      }
> -  if (con.curr_input_mode !=3D tty::cygwin && m =3D=3D tty::cygwin)
> -    {
> -      prev_input_mode_backup =3D con.prev_input_mode;
> -      con.prev_input_mode =3D oflags;
> -    }
>    con.curr_input_mode =3D m;
>    SetConsoleMode (p->input_handle, flags);
>    if (!(oflags & ENABLE_VIRTUAL_TERMINAL_INPUT)
> @@ -893,11 +890,6 @@ fhandler_console::set_output_mode (tty::cons_mode m=
, const termios *t,
>  	flags |=3D DISABLE_NEWLINE_AUTO_RETURN;
>        break;
>      }
> -  if (con.curr_output_mode !=3D tty::cygwin && m =3D=3D tty::cygwin)
> -    {
> -      prev_output_mode_backup =3D con.prev_output_mode;
> -      GetConsoleMode (p->output_handle, &con.prev_output_mode);
> -    }
>    con.curr_output_mode =3D m;
>    acquire_attach_mutex (mutex_timeout);
>    DWORD resume_pid =3D attach_console (con.owner);
> @@ -1845,6 +1837,12 @@ fhandler_console::open (int flags, mode_t)
>    handle_set.output_handle =3D h;
>    release_output_mutex ();
> =20
> +  if (con.owner =3D=3D GetCurrentProcessId ())
> +    {
> +      GetConsoleMode (get_handle (), &con.prev_input_mode);
> +      GetConsoleMode (get_output_handle (), &con.prev_output_mode);
> +    }
> +
>    wpbuf.init ();
> =20
>    handle_set.input_mutex =3D input_mutex;
> @@ -1890,6 +1888,19 @@ fhandler_console::open (int flags, mode_t)
>  	setenv ("TERM", "cygwin", 1);
>      }
> =20
> +  if (con.curr_input_mode !=3D tty::cygwin)
> +    {
> +      prev_input_mode_backup =3D con.prev_input_mode;
> +      GetConsoleMode (get_handle (), &con.prev_input_mode);
> +      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +    }
> +  if (con.curr_output_mode !=3D tty::cygwin)
> +    {
> +      prev_output_mode_backup =3D con.prev_output_mode;
> +      GetConsoleMode (get_output_handle (), &con.prev_output_mode);
> +      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +    }
> +
>    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
>  		get_output_handle ());
> =20
> @@ -4738,7 +4749,7 @@ fhandler_console::cons_mode_on_close (handle_set_t=
 *p)
>    NTSTATUS status =3D
>      NtQueryInformationProcess (GetCurrentProcess (), ProcessBasicInform=
ation,
>  			       &pbi, sizeof (pbi), NULL);
> -  if (NT_SUCCESS (status)
> +  if (NT_SUCCESS (status) && cygwin_pid (con.owner)
>        && !process_alive ((DWORD) pbi.InheritedFromUniqueProcessId))
>      /* Execed from normal cygwin process and the parent has been exited=
. */
>      return tty::cygwin;
> --=20
> 2.45.1
>=20
>=20
