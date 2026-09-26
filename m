Return-Path: <SRS0=TlxR=HS=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 6A9444BA23DC
	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2026 19:08:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6A9444BA23DC
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6A9444BA23DC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790449734; cv=none;
	b=xZknKzqjDN8UngJBLdIYg4tyHhSru/O5T64NswwRzRCqVMga/HXR8MHrw8MZXt+ssifHoWU8yRv7vfBdY2Y36Xa7SQo97c7F3zfk/Fgbu/PzIuBLxnclT3tHZVHottHeFk84ebPi+6CkfbCnDZ4IfQoskQvrtG8i+3813QROte8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790449734; c=relaxed/simple;
	bh=SKhsFiXwhels8YAE051fasQkOOlmFQaxON0L3KlKZwU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=p0VedniCdStVwBy/hFJYnygm0j2C9KOQ5Gqfe67HSt8Aw0aNenxMGO7annXvVvW1gYjRTXHqHz+FijuKCJgWN4qdb0548t6M4aOl4zaSt9L4Tk0YZXN1KXwdm8qBT4qFiKzckvPt4Ozwvs15+lQ5/HbCaYMZUgCCDn0tvqZ1/Xk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bHkB9Na5
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6A9444BA23DC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bHkB9Na5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790449726; x=1791054526;
	i=johannes.schindelin@gmx.de;
	bh=CdyNqPYm74JnfBVTTXAqg2MoPX0AAGjm3UthDprZjUg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bHkB9Na5N/THsPx3usxaGX8LhEkASHJUV6ACXbwR6qD/O/boUHGpfYmm4iGTqjHM
	 RfqcZhgexaUqnYeOxu7KGJA2tPRzULqWz8vHEUTqiDQvd9fWuY+xmBrNY2okUJRiM
	 uPlZTYwLD6iXA8Oht9NQC0BvxbFcw907/ebiwpT0osqhEZW/3NZidvkPaZsf4//M7
	 a/uwmQpdYbxFty20XT7q5PMqGLsF8RjwJ0j+30Ol3qdxpEzEyhTDVpd3ZhZXNIM3j
	 lJ855jBD/AZVo5Kxmbe8fnRnCAE+Gw7adpKFXSG8Hkbac7uJvTdw23T1SF0Il2Vcc
	 SvaZvuefQexsw/pStw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1x0wyJ1WZx-00DtI0; Sat, 26
 Sep 2026 21:08:46 +0200
Date: Sat, 26 Sep 2026 21:08:45 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <20260926165326.16789-1-takashi.yano@nifty.ne.jp>
Message-ID: <f280b842-7618-c159-5288-52a4fad8dfd1@gmx.de>
References: <20260926165326.16789-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:HBP535PyXBL3IZ0GQmqaTNTlMtH+q6+VhjdX88vcGqjSoAJAtOO
 5vdaGOPY10OaByzTaKOxhXRVcIeaFRBPkV896PL+rr/Raq2VBYE0R2FoWvIdJiJJv0hGsdx
 4vTAQKTR1Z1xdJ7a41EcAriCpp/4nW5OvC60d0wMmTY1SzfA1d64rdYq4spSth/ScCeTB3O
 RGgEfUch4jyZXzpbLTLtw==
UI-OutboundReport: notjunk:1;M01:P0:npVYvkPSBQc=;wAEO3I/S7yjmKM0P6FPDVRhPxtd
 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
 HIIeqdNMGUKg0RlLayCqc9yn9Ow5AYVEVpaPdQ=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

Thank you! Just one more thing:

> [...]
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index e0bd1726f..d899dcd65 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> [...]
> @@ -1176,14 +1169,30 @@ peek_console (select_record *me, bool)
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
> +	  __seterrno ();
> +	  return -1;

The caller of this function, `select_stuff::poll()` reacts to that -1 by
`set_errno (s->thread_errno)`, but `thread_errno` is not set by
`__seterrno ()`; In fact, it is not set anywhere in the call path,
remaining at value 0.

To set it properly, I think that the `process_input_message()` function
should record `GetLastError ()` when `PeekConsoleInputW ()` failed. Maybe
something like this?

=2D- snip --
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/co=
nsole.cc
index 77786a1a60..859b56c687 100644
=2D-- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1437,10 +1437,12 @@ fhandler_console::process_input_message (size_t le=
n)
   DWORD resume_pid =3D attach_console (con.owner);
   BOOL r =3D
     PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read)=
;
+  DWORD error =3D r ? ERROR_SUCCESS : GetLastError ();
   detach_console (resume_pid, con.owner);
   release_attach_mutex ();
   if (!r)
     {
+      __seterrno_from_win_error (error);
       termios_printf ("PeekConsoleInput failed, %E");
       return input_error;
     }
=2D- snap --

Ciao,
Johannes

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
