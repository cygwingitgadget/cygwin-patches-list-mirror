Return-Path: <SRS0=WkfY=HQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id B35504BB3BAD
	for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 07:47:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B35504BB3BAD
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B35504BB3BAD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790236049; cv=none;
	b=YPwSfxA44dUxu6x1xcc9Ngc/lmcZTxDY5J9S8QPm9u8RZzKWyXwKAnazD81zicMdLDaDrk2gNvw1X5Gsyfgb4UyILyGpqy+gPmuaMmd8B9nylpR9RuDuRzOV5LOfx4Js8++4o3e2DNVLd1xWrKnB2QdKteFyIdYDUEE1uj+gqM0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790236049; c=relaxed/simple;
	bh=AfjN2IF4Fgnl375HqeVNl8/YwKn2WIiciPCdbP3/fCU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=s8nRsw93yTwxcv8a998ejk0pHdkd5xL5csXfHkpKW0w9DLCDksVd2jjkw/BALZRoGXe5c7wVkhSOYa3DdxUDohT6bmExcFTNdvHBBVCM0KlRePtapCaXJyc8o6cANXhFfiRkgc2P6z70K7b8+V8pJjHex+FlEUkC2GxD604stTY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dt0cY/Zl
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B35504BB3BAD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dt0cY/Zl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790236041; x=1790840841;
	i=johannes.schindelin@gmx.de;
	bh=yTy1waAghXh32iMvYA0l5VFO0ZRqmrp9Gkw6KjQhWdk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dt0cY/Zl9GdKnBZ0iblF0lM9TmQAh4vacfQ1XZOvtSmmx/GoDFdZ9aBsJs47FA8r
	 +urqQp/+YMhvXXCZq5VpsfCIYehcqCBigHb35tx4YNV0jHWq+qcMy7jVi0Ugg7oyg
	 NiSgWTBlf9RD7hFwcv5KLA7hWkYjKjffjD81rx3dmFcgTAwLKAjzVmrGDfBOlP/3F
	 9uZH7LwQgl7Qahzqx7NUMawRD5Dib/c4U4NvCLRlDqig8N2quvsHFSabnf/m550Hw
	 LFM6k7RiEIJ75788mxYPellkLVhXKAh5BKY+cQwM3hsg6NaizsYLco/X87sf2z3+f
	 C8njs86i+9xyGjzbcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1x4Oqq1WuD-002xCS; Thu, 24
 Sep 2026 09:47:21 +0200
Date: Thu, 24 Sep 2026 09:47:19 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Jay Libove Alzina <libove@felines.org>
Subject: Re: [PATCH v5] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
In-Reply-To: <20260923223230.3504-1-takashi.yano@nifty.ne.jp>
Message-ID: <4acddc15-292c-f7bd-10d2-ecc055176f23@gmx.de>
References: <20260923223230.3504-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:ht8jw1V4DiDeUqqo32vNrALcemJFyiIy8+Uyptfmnml1QU+VxgE
 JIV1q2UijOzevjZoEnvOVPFzINhIhMKBerO6LXMCGZT1yaQrCd3qFO1roRyK34+f8LQbmYT
 EqgG1+YrpsUxtJ+h4pKULEyWgPBF6AOJnfHswbo/oUdTrTOsEihCXik18rtf85Cq7GwUJly
 vLyEfJ2H659CR7D2PnK1w==
UI-OutboundReport: notjunk:1;M01:P0:bFlBUoAVqLU=;mcVRFc1P8P1bcVRsSSPdMXc9XxQ
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 24 Sep 2026, Takashi Yano wrote:

> With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
> thread runs only when it is supposed to"), the process which calls
> set_disable_master_thread() hangs if the con.owner already exited,
> because set_disable_master_thread() waits for cons_master_thread
> accepting the status change and reflecting the current status to
> master_thread_suspended. With this patch, set_disable_master_thread()
> is aborted if the owner process no longer exists to avoid this
> hang.
>=20
> Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.htm=
l
> Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs onl=
y when it is supposed to")
> Reported-by: Jay Libove Alzina <libove@felines.org>
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Treat the absence of the master thread the same as suspension.
> v3: Handle the crash of owner process.
> v4: Put my concept together based on Johannes's.
> v5: Abort waiting for master_thread when quering owner process fails.
>     need_console_handler() simply returns need_console_handler.
>     Rename master_thread_exited() to master_thread_unavailable().
>     Set con.is_processed_input before asserting ENABLE_PROCESS_INPUT,
>     and unset it after clearing ENABLE_PROCESS_INPUT.

Thank you for addressing all my concerns! From my point of view, this
patch is ready.

Ciao,
Johannes

>=20
>  winsup/cygwin/fhandler/console.cc       | 57 +++++++++++++++++++++----
>  winsup/cygwin/local_includes/fhandler.h |  3 +-
>  2 files changed, 51 insertions(+), 9 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 2d5382c0d..d72bb39e0 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -900,7 +900,7 @@ fhandler_console::fix_input_mode_if_necessary ()
>      }
>    bool need_processed_input =3D
>      con.master_thread_suspended || con.disable_master_thread
> -    || con.need_win32_input_mode_fix;
> +    || con.need_win32_input_mode_fix || master_thread_unavailable (unit=
);
>    if (need_processed_input =3D=3D con.is_processed_input)
>      {
>        ReleaseMutex (cons_mode_mutex);
> @@ -915,8 +915,11 @@ fhandler_console::fix_input_mode_if_necessary ()
>      flags |=3D ENABLE_PROCESSED_INPUT;
>    else
>      flags &=3D ~ENABLE_PROCESSED_INPUT;
> -  con.is_processed_input =3D need_processed_input;
> +  if (need_processed_input)
> +    con.is_processed_input =3D true;
>    SetConsoleMode (get_handle (), flags);
> +  if (!need_processed_input)
> +    con.is_processed_input =3D false;
>    detach_console (resume_pid, con.owner);
>    release_attach_mutex ();
>    ReleaseMutex (input_mutex);
> @@ -931,6 +934,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, =
const termios *t,
>  {
>    const _minor_t unit =3D p->unit;
>    DWORD oflags;
> +  bool need_processed_input =3D false;
>    WaitForSingleObject (p->input_mutex, mutex_timeout);
>    acquire_attach_mutex (mutex_timeout);
>    DWORD resume_pid =3D attach_console (con.owner);
> @@ -945,10 +949,10 @@ fhandler_console::set_input_mode (tty::cons_mode m=
, const termios *t,
>        break;
>      case tty::cygwin:
>        flags |=3D ENABLE_WINDOW_INPUT;
> -      con.is_processed_input =3D
> +      need_processed_input =3D
>  	con.master_thread_suspended || con.disable_master_thread
> -	|| con.need_win32_input_mode_fix;
> -      if (con.is_processed_input)
> +	|| con.need_win32_input_mode_fix || master_thread_unavailable (unit);
> +      if (need_processed_input)
>  	flags |=3D ENABLE_PROCESSED_INPUT;
>        if (wincap.has_con_24bit_colors () && !con_is_legacy)
>  	flags |=3D ENABLE_VIRTUAL_TERMINAL_INPUT;
> @@ -969,8 +973,11 @@ fhandler_console::set_input_mode (tty::cons_mode m,=
 const termios *t,
>        break;
>      }
>    con.curr_input_mode =3D m;
> +  if (flags & ENABLE_PROCESSED_INPUT)
> +    con.is_processed_input =3D true;
>    SetConsoleMode (p->input_handle, flags);
> -  con.is_processed_input =3D (flags & ENABLE_PROCESSED_INPUT) !=3D 0;
> +  if (!(flags & ENABLE_PROCESSED_INPUT))
> +    con.is_processed_input =3D false;
>    if (!(oflags & ENABLE_VIRTUAL_TERMINAL_INPUT)
>        && (flags & ENABLE_VIRTUAL_TERMINAL_INPUT)
>        && con.cursor_key_app_mode)
> @@ -5008,7 +5015,37 @@ fhandler_console::close_handle_set (handle_set_t =
*p)
>  bool
>  fhandler_console::need_console_handler ()
>  {
> -  return con.disable_master_thread || con.master_thread_suspended;
> +  return con.is_processed_input;
> +}
> +
> +bool
> +fhandler_console::master_thread_unavailable (_minor_t unit)
> +{
> +  DWORD owner =3D con.owner;
> +  if (owner =3D=3D (DWORD) -1) /* About to exit, however still alive */
> +    return false;
> +  if (owner =3D=3D 0)
> +    return true;
> +  bool exited =3D false;
> +  DWORD error =3D ERROR_SUCCESS;
> +  HANDLE process =3D OpenProcess (SYNCHRONIZE, FALSE, owner);
> +  if (process)
> +    {
> +      DWORD res =3D WaitForSingleObject (process, 0);
> +      if (res =3D=3D WAIT_FAILED)
> +	error =3D GetLastError ();
> +      exited =3D (res =3D=3D WAIT_OBJECT_0);
> +      CloseHandle (process);
> +    }
> +  else
> +    {
> +      error =3D GetLastError ();
> +      exited =3D (error =3D=3D ERROR_INVALID_PARAMETER);
> +    }
> +  if (error && !exited)
> +    system_printf ("Cannot query console owner %u, error %u", owner, er=
ror);
> +
> +  return (exited || error) && con.owner =3D=3D owner;
>  }
> =20
>  void
> @@ -5026,7 +5063,11 @@ fhandler_console::set_disable_master_thread (bool=
 x, fhandler_console *cons)
>    con.disable_master_thread =3D x;
>    cons->release_input_mutex ();
>    while (con.master_thread_suspended !=3D x)
> -    Sleep (1);
> +    { /* Wait for the responce from the cons_master_thread. */
> +      if (master_thread_unavailable (unit))
> +	return; /* Abort */
> +      Sleep (1);
> +    }
>  }
> =20
>  int
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index e00212f57..438b02bf0 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2160,7 +2160,7 @@ class dev_console
>    int num_processed; /* Number of input events in the current input buf=
fer
>  			already processed by cons_master_thread(). */
>    bool need_win32_input_mode_fix;
> -  bool is_processed_input;
> +  volatile bool is_processed_input;
> =20
>    inline UINT get_console_cp ();
>    DWORD con_to_str (char *d, int dlen, WCHAR w);
> @@ -2364,6 +2364,7 @@ private:
>    static void cleanup_for_non_cygwin_app (handle_set_t *p);
>    static void set_console_mode_to_native ();
>    bool need_console_handler ();
> +  static bool master_thread_unavailable (_minor_t unit);
>    static void set_disable_master_thread (bool x, fhandler_console *cons=
 =3D NULL);
>    static DWORD attach_console (DWORD, bool *err =3D NULL);
>    static void detach_console (DWORD, DWORD);
> --=20
> 2.51.0
>=20
>=20
