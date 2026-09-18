Return-Path: <SRS0=MpZY=HK=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 596BD4BB1C2B
	for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2026 15:26:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 596BD4BB1C2B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 596BD4BB1C2B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789745207; cv=none;
	b=uXAfwWV/KyXkwnAlFq/F2CbbSlKAH5hMYN1dkO2ibRMpB8pN0feZsMeqB6bqkVEz3S0RYcPlsp2Reqd1nDHzzisKo/LhqAXFdOUmoapACjFoZCu1Z8ofnhJwl/eui1Ko8aPJGCkFWyd596/Ihmx5/ZQfm/NymS+xa5sPScGYpJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789745207; c=relaxed/simple;
	bh=NJ/IRKZVZi+3Fc3KB6HRQrRgUk2s5EOX9Q6PeGDdz5E=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=htG+7RGfgP9tN+cCAQBGxrkDzDJXsxKYGae/NCLljXPo3QXPJLPmFKdLIKVvyxqZHmknSkBluBAXzdho6xNrVPlmJvT2AnfxdjOCe9Y/r6cdhJYPUFfHnxgYOakr9h24z4ckzPFFwpO4+Ksur87pRBDAGCeY3OYRtk3ghQdIfmA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=AFHvl8NU
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 596BD4BB1C2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=AFHvl8NU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789745199; x=1790349999;
	i=johannes.schindelin@gmx.de;
	bh=dhoPyccgHLvkZbPNC7kcl7n85cbhKvTuR9Oy1DlYwSQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AFHvl8NUjbm6kqqXqR3IxrZy3P4UriZfpYjRUtYMUus5Pzea+UYlzluy3hMfF4pe
	 OV6FCFH3XCSLcOxuRlEtclpPcjo0IILovfrZqjUAMH1IwJbFOOOrOPdu+09SQYwn7
	 wnRxUvAxTbONIagRuV8kUVGHozjYwA1xRCoL4dzVBXD3ep1qxwvCkQ8lymn2ceDGb
	 HtvYFtfi4/yJGbsaq78r3odIqYA2L1iBGCB4203j84U+NTAY1PcuXiT2BJ8hOsPf4
	 jicYFdNT/RFSLJxcD8Le0gvIqtI1R/riRTK3P9zPycz8CWOQKM7e/Tl/qknjw9WWD
	 Slr0VjtsM3+pk24gmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1wmkoF2U1c-00s3yd; Fri, 18
 Sep 2026 17:26:39 +0200
Date: Fri, 18 Sep 2026 17:26:38 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v17] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
In-Reply-To: <20260917054034.7668-1-takashi.yano@nifty.ne.jp>
Message-ID: <19f79ca4-ff3b-6ac7-ceee-b93ff98ebb38@gmx.de>
References: <20260917054034.7668-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:o9GGarJ8svGhXO4AF/v6tJ3C8sSJ1nfpI00VOnfKZ546JRPG856
 FyS71r+/Sk9ZUKuMetjqw6Y7SUuuClX3mw3bbOUb9XBwffS1AN43A/tiqEOWwlElv/4bP1a
 awfqvte0Bk9SIyRNsszjJS+w9YRVOojgNs7o+MiHLpbuwUR+LNxG4Cs5PakSr9Kr6+ODP/+
 +HVCylebt/imguVHB2uCw==
UI-OutboundReport: notjunk:1;M01:P0:tOO4J25FR4Q=;FP/hTZ/3+kDY3SPNxDUEDjiakBs
 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
 cLYrTM97pIyZ5s7P9liykFGEHA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 17 Sep 2026, Takashi Yano wrote:

> Previously, if two non-cygwin apps are started and one of them
> exits first, the other one lost appropriate console mode, since
> the first one restored it to tty::cygwin. This patch counts the
> active console process whose pgid is pgid of the tty and if the
> result is zero (means the last non-cygwin foreground process),
> restore console mode. To avoid race issue between apps modifying
> console mode simultaneously, this patch also introduce a mutex
> named `cons_mode_mutex`.
>=20
> Known limitation:
> In the case of non-overlayed spawn, there still exists a small
> window in which another non-cygwin process may restore tty::cygwin
> mode even though new non-cygwin app is about to start.
>=20
> In addition:
> Avoid the cleanup/startup deadlock: cleanup can hold `cons_mode_mutex`
> while waiting for a console master that a new owner cannot start until
> acquiring that mutex. Startup must precede the mode-mutex wait without
> changing the handshake or mode serialization.
>=20
> Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Stop counting up/down the counter by itself.
>     Use num_active_non_cygwin_apps() instead.
> v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
> v4: Guard all mode changes in console by cons_mode_mutex.
> v5: Fix the issue of mutex acquisition order.
>     Fix the race window around the process creation.
>     Improve latency of checking existence of non-cygwin apps.
>     Handle errors in checking existence of non-cygwin apps.
> v6: Match the conditions for incrementing and decrementing the counter.
> v7: Decrement the counter only if it was incremented by myself.
> v8: Symlify the conditions for incrementing and decrementing the counter
>     a bit.
> v9: Minimize the argument of set_non_cygwin_app_setup_ongoing().
> v10: Set process_state before calling spawn_worker::setup() rather than
>      using the counter. In addition, resume non-cygwin app before
> 	 modifying process table. These make things much simpler.
>      Narrowing the period of acquiring input_mutex in peek_console()
>      in select.cc.
> v11: Release output_mutex before calling bg_check() in ioctl().
>      Suppress unecessary console-mode change attempts.
> v12: Change handling of disabling master thread in the case of win32
>      input mode.
>      Wait for console attaching only when the spawned app is a console
>      app. In addition, a timeout is introduced to this wait loop for
>      safety.
> v13: Do not perform cleanup for non-cygwin apps on the error in
>      active_non_cygwin_apps_exist().
>      Handle WAIT_ABANDONED in CSI?9001h/l handling.
>      Fix ABBA deadlock about echo code path.
>      Set need_win32_input_mode_fix before set_disable_master_thread()
>      in CSI?9001h/l handling.
>      Setting and checking for need_win32_input_mode_fix inside the
>      input_mutex.
>      Fix the problem that the flag need_win32_input_mode_fix is set,
>      but disable_master_thread does not set if another thread holds
>      cons_mode_mutex.
> v14: Re-design echo code path. (Introduce raw_write() for doecho())
>      Re-design the handling of need_win32_input_mode_fix from scratch.
> v15: Fix possible deadlock with input_mutex regarding doecho()
> v16: Avoid to overwrite ENABLE_PROCESS_INPUT in tty::native mode.
>      Call fix_input_mode_if_necessary in TIMEOUT case as well.
> v17: Three more fixes suggested by Johannes:
>        (1) Create master thread before the console mode change in
>            open().
>        (2) Call fix_input_mode_if_necessary() in the canonical mode
>            loop in read().
>        (3) Ack for disable_master_thread =3D false when
>            need_win32_input_mode_fix is true.

Thank you for those changes!

I still see one concern, though:

A resize can still bypass a mode change recorded during echo. In canonical
mode, echo can pass `ESC[?9001h` through `line_edit()`, `doecho()` and
`raw_write()` to the output parser, setting the protocol flag without
completing a line. If the same input batch then encounters a window-size
event, the processor reports `input_winch`, not `input_processing`. With a
`SIGWINCH` handler that returns without console I/O, `read()` releases
input protection and returns or retries without reconciliation.
`peek_console()` likewise has a handled-`SIGWINCH` return before its
fixup. The Windows input setting can remain unreconciled until another
console operation. This is an inherited signal-path gap, not the old
canonical retry defect or an observed v17 hang.

I'd like to suggest these two fixup! hunks to be squashed in:

=2D- snip --
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/co=
nsole.cc
index 9ebf65611c..16c3e5270a 100644
=2D-- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1369,6 +1369,7 @@ fhandler_console::read (void *pv, size_t& buflen)
 	case input_signalled: /* signalled */
 	case input_winch:
 	  release_input_mutex ();
+	  fix_input_mode_if_necessary (); /* for win32_input_mode */
 	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
 	    continue;
 	  goto sig_exit;
@@ -1390,14 +1391,14 @@ fhandler_console::read (void *pv, size_t& buflen)
     input_ready =3D false;
   release_input_mutex ();
=20
+  fix_input_mode_if_necessary (); /* for win32_input_mode */
+
   if (buflen > copied_chars && !(get_ttyp ()->ti.c_lflag & ICANON)
       && copied_chars < get_ttyp ()->ti.c_cc[VMIN])
     goto read_more;
=20
 #undef buf
=20
-  fix_input_mode_if_necessary (); /* for win32_input_mode */
-
   buflen =3D copied_chars;
   return;
=20
=2D- snap --

and

=2D- snip --
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 33417169b8..d47991f21c 100644
=2D-- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1172,17 +1172,17 @@ peek_console (select_record *me, bool)
 	      break;
 	    }
 	}
-      if (fhandler_console::input_winch =3D=3D fh->process_input_message =
(0)
+      int ret =3D fh->process_input_message (0);
+      fh->release_input_mutex ();
+      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
+
+      if (fhandler_console::input_winch =3D=3D ret
 	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
 	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
 	{
 	  set_sig_errno (EINTR);
-	  fh->release_input_mutex ();
 	  return -1;
 	}
-      fh->release_input_mutex ();
-
-      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
     }
   if (fh->input_ready || fh->get_cons_readahead_valid ())
     return me->read_ready =3D true;
=2D- snap --

What do you think?

Ciao,
Johannes

>=20
>  winsup/cygwin/fhandler/console.cc       | 244 ++++++++++++++++++++----
>  winsup/cygwin/fhandler/termios.cc       |  40 +++-
>  winsup/cygwin/local_includes/fhandler.h |  10 +-
>  winsup/cygwin/select.cc                 |  16 +-
>  winsup/cygwin/spawn.cc                  |  44 +++--
>  5 files changed, 278 insertions(+), 76 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index be41bf3a2..a877fce0b 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -443,6 +443,12 @@ fhandler_console::cons_master_thread (handle_set_t =
*p, tty *ttyp)
>  	  cygwait (40);
>  	  continue;
>  	}
> +      if (con.need_win32_input_mode_fix)
> +	{
> +	  con.master_thread_suspended =3D false;
> +	  cygwait (40);
> +	  continue;
> +	}
> =20
>        acquire_attach_mutex (mutex_timeout);
>        GetNumberOfConsoleInputEvents (p->input_handle, &total_read);
> @@ -841,6 +847,8 @@ fhandler_console::setup ()
>        con.num_processed =3D 0;
>        con.curr_input_mode =3D tty::restore;
>        con.curr_output_mode =3D tty::restore;
> +      con.need_win32_input_mode_fix =3D false;
> +      con.is_processed_input =3D false;
>      }
>  }
> =20
> @@ -877,6 +885,44 @@ fhandler_console::rabuflen ()
>  static DWORD prev_input_mode_backup;
>  static DWORD prev_output_mode_backup;
> =20
> +/* Even under cons_mode_mutex, only need_win32_input_mode_fix can be
> +   modified by another thread. This function sets or clears the
> +   ENABLE_PROCESSED_INPUT flag to reflect the current value of
> +   need_win32_input_mode_fix. */
> +void
> +fhandler_console::fix_input_mode_if_necessary ()
> +{
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> +  if (con.curr_input_mode !=3D tty::cygwin)
> +    {
> +      ReleaseMutex (cons_mode_mutex);
> +      return;
> +    }
> +  bool need_processed_input =3D
> +    con.master_thread_suspended || con.disable_master_thread
> +    || con.need_win32_input_mode_fix;
> +  if (need_processed_input =3D=3D con.is_processed_input)
> +    {
> +      ReleaseMutex (cons_mode_mutex);
> +      return;
> +    }
> +  WaitForSingleObject (input_mutex, mutex_timeout);
> +  acquire_attach_mutex (mutex_timeout);
> +  DWORD resume_pid =3D attach_console (con.owner);
> +  DWORD flags;
> +  GetConsoleMode (get_handle (), &flags);
> +  if (need_processed_input)
> +    flags |=3D ENABLE_PROCESSED_INPUT;
> +  else
> +    flags &=3D ~ENABLE_PROCESSED_INPUT;
> +  con.is_processed_input =3D need_processed_input;
> +  SetConsoleMode (get_handle (), flags);
> +  detach_console (resume_pid, con.owner);
> +  release_attach_mutex ();
> +  ReleaseMutex (input_mutex);
> +  ReleaseMutex (cons_mode_mutex);
> +}
> +
>  /* The function set_{in,out}put_mode() should be static so that they
>     can be called even after the fhandler_console instance is deleted. *=
/
>  void
> @@ -899,7 +945,10 @@ fhandler_console::set_input_mode (tty::cons_mode m,=
 const termios *t,
>        break;
>      case tty::cygwin:
>        flags |=3D ENABLE_WINDOW_INPUT;
> -      if (con.master_thread_suspended || con.disable_master_thread)
> +      con.is_processed_input =3D
> +	con.master_thread_suspended || con.disable_master_thread
> +	|| con.need_win32_input_mode_fix;
> +      if (con.is_processed_input)
>  	flags |=3D ENABLE_PROCESSED_INPUT;
>        if (wincap.has_con_24bit_colors () && !con_is_legacy)
>  	flags |=3D ENABLE_VIRTUAL_TERMINAL_INPUT;
> @@ -921,6 +970,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, =
const termios *t,
>      }
>    con.curr_input_mode =3D m;
>    SetConsoleMode (p->input_handle, flags);
> +  con.is_processed_input =3D (flags & ENABLE_PROCESSED_INPUT) !=3D 0;
>    if (!(oflags & ENABLE_VIRTUAL_TERMINAL_INPUT)
>        && (flags & ENABLE_VIRTUAL_TERMINAL_INPUT)
>        && con.cursor_key_app_mode)
> @@ -977,16 +1027,92 @@ fhandler_console::setup_for_non_cygwin_app ()
>       console mode. */
>    if (get_ttyp ()->getpgid () =3D=3D myself->pgid)
>      {
> +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>        set_disable_master_thread (true, this);
>        set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
>        set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
> +      ReleaseMutex (cons_mode_mutex);
> +    }
> +}
> +
> +/* Return values
> +   0: not exist
> +   1: exist
> +  -1: error */
> +int
> +fhandler_console::active_non_cygwin_apps_exist (pid_t pgid)
> +{
> +  tmp_pathbuf tp;
> +  DWORD *list =3D (DWORD *) tp.c_get ();
> +  const DWORD buf_size =3D NT_MAX_PATH / sizeof (DWORD);
> +
> +  DWORD buf_size1 =3D 1;
> +  DWORD num;
> +  /* The buffer of too large size does not seem to be expected by new c=
ondrv.
> +     https://github.com/microsoft/terminal/issues/18264#issuecomment-25=
15448548
> +     Use the minimum buffer size in the loop. */
> +  while ((num =3D GetConsoleProcessList (list, buf_size1)) > buf_size1)
> +    {
> +      if (num > buf_size)
> +	return -1;
> +      buf_size1 =3D num;
>      }
> +  if (num =3D=3D 0)
> +    return -1;
> +
> +  /* Last one is the oldest. */
> +  /* https://github.com/microsoft/terminal/issues/95 */
> +  /* Assuming that newer processes are more likely to be non-cygwin. */
> +  for (DWORD i =3D 0; i < num; i++)
> +    {
> +      DWORD my_pid =3D myself->exec_dwProcessId ? : myself->dwProcessId=
;
> +      if (list[i] =3D=3D my_pid)
> +	continue;
> +      pid_t pid =3D cygwin_pid (list[i]);
> +      if (pid =3D=3D 0)
> +	continue;
> +      pinfo p (pid);
> +      if (!!p && p->pgid =3D=3D pgid && ISSTATE (p, PID_NOTCYGWIN))
> +	return 1;
> +    }
> +  return 0;
>  }
> =20
>  void
>  fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
>  {
>    const _minor_t unit =3D p->unit;
> +  pid_t pgid =3D shared_console_info[unit] ?
> +    shared_console_info[unit]->tty_min_state.getpgid () : 0;
> +
> +  WaitForSingleObject (p->cons_mode_mutex, mutex_timeout);
> +  tty::cons_mode conmode =3D cons_mode_on_close (p);
> +  if (con.curr_input_mode =3D=3D conmode && con.curr_output_mode =3D=3D=
 conmode
> +      && con.disable_master_thread =3D=3D (con.owner =3D=3D GetCurrentP=
rocessId ()))
> +    {
> +      ReleaseMutex (p->cons_mode_mutex);
> +      return;
> +    }
> +  switch (active_non_cygwin_apps_exist (pgid))
> +    {
> +    case -1: /* Error */
> +      /* In case of an error, do not perform the cleanup, since the
> +	 cygwin app has a chnce to restore console mode in bg_check()
> +	 called from read()/write(). So give a priority to non-cygwin
> +	 apps here that may exist. */
> +      system_printf ("Checking for existence of non-cygwin app failed."=
);
> +      if (con.owner =3D=3D GetCurrentProcessId ())
> +	/* This process is supposed to be the last non-cygwin process */
> +	break;
> +      fallthrough;
> +    case 1: /* Exist */
> +      ReleaseMutex (p->cons_mode_mutex);
> +      return;
> +    case 0: /* Not exist */
> +    default:
> +      break;
> +    }
> +
>    termios dummy =3D {0, };
>    termios *ti =3D shared_console_info[unit] ?
>      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
> @@ -994,11 +1120,11 @@ fhandler_console::cleanup_for_non_cygwin_app (han=
dle_set_t *p)
>    set_disable_master_thread (con.owner =3D=3D GetCurrentProcessId ());
>    /* conmode can be tty::restore when non-cygwin app is
>       exec'ed from login shell. */
> -  tty::cons_mode conmode =3D cons_mode_on_close (p);
>    if (con.curr_output_mode !=3D conmode)
>      set_output_mode (conmode, ti, p);
>    if (con.curr_input_mode !=3D conmode)
>      set_input_mode (conmode, ti, p);
> +  ReleaseMutex (p->cons_mode_mutex);
>  }
> =20
>  /* Return the tty structure associated with a given tty number.  If the
> @@ -1055,6 +1181,10 @@ fhandler_console::setup_io_mutex (void)
>    if (res =3D=3D WAIT_OBJECT_0)
>      release_output_mutex ();
> =20
> +  shared_name (buf, "cygcons.cons_mode.mutex", get_minor ());
> +  if (!cons_mode_mutex)
> +    cons_mode_mutex =3D CreateMutex (&sec_none, FALSE, buf);
> +
>    extern HANDLE attach_mutex;
>    if (!attach_mutex)
>      attach_mutex =3D CreateMutex (&sec_none_nih, FALSE, NULL);
> @@ -1182,13 +1312,13 @@ fhandler_console::mouse_aware (MOUSE_EVENT_RECOR=
D& mouse_event)
>  		 || con.use_mouse >=3D 3));
>  }
> =20
> -
>  bg_check_types
>  fhandler_console::bg_check (int sig, bool dontsignal)
>  {
>    /* Setting-up console mode for cygwin app. This is necessary if the
>       cygwin app and other non-cygwin apps are started simultaneously
>       in the same process group. */
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>    if (sig =3D=3D SIGTTIN && con.curr_input_mode !=3D tty::cygwin)
>      {
>        set_disable_master_thread (false, this);
> @@ -1196,6 +1326,7 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>      }
>    if (sig =3D=3D SIGTTOU && con.curr_output_mode !=3D tty::cygwin)
>      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    return fhandler_termios::bg_check (sig, dontsignal);
>  }
> @@ -1248,6 +1379,7 @@ wait_retry:
>  	case WAIT_TIMEOUT:
>  	  if (copied_chars)
>  	    {
> +	      fix_input_mode_if_necessary (); /* for win32_input_mode */
>  	      buflen =3D copied_chars;
>  	      return;
>  	    }
> @@ -1281,6 +1413,7 @@ wait_retry:
>  	  goto err;
>  	case input_processing:
>  	  release_input_mutex ();
> +	  fix_input_mode_if_necessary (); /* for win32_input_mode */
>  	  continue;
>  	case input_ok: /* input ready */
>  	  break;
> @@ -1314,6 +1447,8 @@ wait_retry:
> =20
>  #undef buf
> =20
> +  fix_input_mode_if_necessary (); /* for win32_input_mode */
> +
>    buflen =3D copied_chars;
>    return;
> =20
> @@ -2011,22 +2146,8 @@ fhandler_console::open (int flags, mode_t)
>    if (in_is_console)
>      CloseHandle (h_in);
> =20
> -  if (in_is_console && con.curr_input_mode !=3D tty::cygwin)
> -    {
> -      prev_input_mode_backup =3D con.prev_input_mode;
> -      GetConsoleMode (get_handle (), &con.prev_input_mode);
> -      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> -    }
> -  if (out_is_console && con.curr_output_mode !=3D tty::cygwin)
> -    {
> -      prev_output_mode_backup =3D con.prev_output_mode;
> -      GetConsoleMode (get_output_handle (), &con.prev_output_mode);
> -      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> -    }
> -
> -  debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
> -		get_output_handle ());
> -
> +  /* Another process may hold cons_mode_mutex while waiting for the
> +     master thread to acknowledge a state change. */
>    if (GetCurrentProcessId () =3D=3D con.owner)
>      {
>        if (GetModuleHandle ("ConEmuHk64.dll"))
> @@ -2044,6 +2165,25 @@ fhandler_console::open (int flags, mode_t)
>  	debug_printf ("Failed to create thread_sync_event %08x",
>  		      GetLastError ());
>      }
> +
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> +  if (in_is_console && con.curr_input_mode !=3D tty::cygwin)
> +    {
> +      prev_input_mode_backup =3D con.prev_input_mode;
> +      GetConsoleMode (get_handle (), &con.prev_input_mode);
> +      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +    }
> +  if (out_is_console && con.curr_output_mode !=3D tty::cygwin)
> +    {
> +      prev_output_mode_backup =3D con.prev_output_mode;
> +      GetConsoleMode (get_output_handle (), &con.prev_output_mode);
> +      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +    }
> +  ReleaseMutex (cons_mode_mutex);
> +
> +  debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
> +		get_output_handle ());
> +
>    return 1;
>  }
> =20
> @@ -2106,6 +2246,7 @@ fhandler_console::open_setup (int flags)
>        handle_set.output_handle =3D get_output_handle ();
>        handle_set.input_mutex =3D input_mutex;
>        handle_set.output_mutex =3D output_mutex;
> +      handle_set.cons_mode_mutex =3D cons_mode_mutex;
>        handle_set.unit =3D unit;
>      }
>    return fhandler_base::open_setup (flags);
> @@ -2115,6 +2256,7 @@ void
>  fhandler_console::post_open_setup (int fd)
>  {
>    /* Setting-up console mode for cygwin app started from non-cygwin app=
. */
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>    if (fd =3D=3D 0)
>      {
>        set_disable_master_thread (false, this);
> @@ -2122,6 +2264,7 @@ fhandler_console::post_open_setup (int fd)
>      }
>    else if (fd =3D=3D 1 || fd =3D=3D 2)
>      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    fhandler_base::post_open_setup (fd);
>  }
> @@ -2131,18 +2274,20 @@ fhandler_console::close (int flag)
>  {
>    debug_printf ("closing: %p, %p", get_handle (), get_output_handle ())=
;
> =20
> -  acquire_output_mutex (mutex_timeout);
> -
>    if (shared_console_info[unit] && (dev_t) myself->ctty =3D=3D get_devi=
ce ()
>        && cons_mode_on_close (&handle_set) =3D=3D tty::restore)
>      {
> +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>        set_disable_master_thread (true, this);
>        if (con.curr_output_mode !=3D tty::restore)
>  	set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
>        if (con.curr_input_mode !=3D tty::restore)
>  	set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
> +      ReleaseMutex (cons_mode_mutex);
>      }
> =20
> +  acquire_output_mutex (mutex_timeout);
> +
>    if (shared_console_info[unit] && con.owner =3D=3D GetCurrentProcessId=
 ())
>      {
>        if (master_thread_started)
> @@ -2197,6 +2342,8 @@ fhandler_console::close (int flag)
>    input_mutex =3D NULL;
>    CloseHandle (output_mutex);
>    output_mutex =3D NULL;
> +  CloseHandle (cons_mode_mutex);
> +  cons_mode_mutex =3D NULL;
> =20
>    pcon_hand_over_proc ();
> =20
> @@ -2246,8 +2393,8 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
rg)
>  	release_output_mutex ();
>  	return 0;
>        case TIOCSWINSZ:
> -	bg_check (SIGTTOU);
>  	release_output_mutex ();
> +	bg_check (SIGTTOU);
>  	return 0;
>        case KDGKBMETA:
>  	*(int *) arg =3D (con.metabit) ? K_METABIT : K_ESCPREFIX;
> @@ -2370,10 +2517,12 @@ int
>  fhandler_console::tcsetattr (int a, struct termios const *t)
>  {
>    get_ttyp ()->ti =3D *t;
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>    if (con.curr_input_mode =3D=3D tty::cygwin)
>      set_input_mode (tty::cygwin, t, &handle_set);
>    if (con.curr_output_mode =3D=3D tty::cygwin)
>      set_output_mode (tty::cygwin, t, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
>    return 0;
>  }
> =20
> @@ -3140,12 +3289,7 @@ fhandler_console::char_command (char c)
>  		  if (con.args[i] =3D=3D 1) /* DECCKM */
>  		    con.cursor_key_app_mode =3D (c =3D=3D 'h');
>  		  if (con.args[i] =3D=3D 9001) /* win32-input-mode (https://github.co=
m/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard=
%20handling%20in%20Conpty.md) */
> -		    {
> -		      set_disable_master_thread (c =3D=3D 'h', this);
> -		      if (con.curr_input_mode =3D=3D tty::cygwin)
> -			set_input_mode (tty::cygwin,
> -					&tc ()->ti, get_handle_set ());
> -		    }
> +		    con.need_win32_input_mode_fix =3D (c =3D=3D 'h');
>  		}
>  	      /* Call fix_tab_position() if screen has been alternated. */
>  	      if (need_fix_tab_position)
> @@ -3994,6 +4138,18 @@ fhandler_console::write (const void *vsrc, size_t=
 len)
> =20
>    push_process_state process_state (PID_TTYOU);
> =20
> +  ssize_t ret =3D raw_write (vsrc, len);
> +
> +  fix_input_mode_if_necessary (); /* for win32_input_mode */
> +
> +  syscall_printf ("%ld =3D fhandler_console::write(...)", len);
> +
> +  return ret;
> +}
> +
> +ssize_t
> +fhandler_console::raw_write (const void *vsrc, size_t len)
> +{
>    acquire_output_mutex (mutex_timeout);
> =20
>    /* Run and check for ansi sequences */
> @@ -4327,18 +4483,13 @@ fhandler_console::write (const void *vsrc, size_=
t len)
>      }
>    release_output_mutex ();
> =20
> -  syscall_printf ("%ld =3D fhandler_console::write(...)", len);
> -
>    return len;
>  }
> =20
>  void
>  fhandler_console::doecho (const void *str, DWORD len)
>  {
> -  int stopped =3D get_ttyp ()->output_stopped;
> -  get_ttyp ()->output_stopped =3D 0;
> -  write (str, len);
> -  get_ttyp ()->output_stopped =3D stopped;
> +  raw_write (str, len);
>  }
> =20
>  static const struct {
> @@ -4476,10 +4627,13 @@ fhandler_console::set_console_mode_to_native ()
>  	fhandler_console *cons =3D (fhandler_console *) (fhandler_base *) cfd;
>  	if (cons->get_device () =3D=3D cons->tc ()->getntty ())
>  	  {
> +	    const fhandler_console::handle_set_t *p =3D cons->get_handle_set (=
);
> +	    WaitForSingleObject (p->cons_mode_mutex, mutex_timeout);
>  	    set_disable_master_thread (true, cons);
>  	    termios *cons_ti =3D &cons->tc ()->ti;
> -	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
> -	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
> +	    set_input_mode (tty::native, cons_ti, p);
> +	    set_output_mode (tty::native, cons_ti, p);
> +	    ReleaseMutex (p->cons_mode_mutex);
>  	    break;
>  	  }
>        }
> @@ -4536,8 +4690,17 @@ ContinueDebugEvent_Hooked
>  static FARPROC
>  GetProcAddress_Hooked (HMODULE h, LPCSTR n)
>  {
> -  if (strcmp(n, "RequestTermConnector") =3D=3D 0)
> -    fhandler_console::set_disable_master_thread (true);
> +  if (cygheap->ctty && strcmp (n, "RequestTermConnector") =3D=3D 0)
> +    {
> +      char buf[MAX_PATH];
> +      const _minor_t unit =3D cygheap->ctty->get_minor ();
> +      shared_name (buf, "cygcons.cons_mode.mutex", unit);
> +      HANDLE cons_mode_mutex =3D CreateMutex (&sec_none, FALSE, buf);
> +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> +      fhandler_console::set_disable_master_thread (true);
> +      ReleaseMutex (cons_mode_mutex);
> +      CloseHandle (cons_mode_mutex);
> +    }
>    return GetProcAddress_Orig (h, n);
>  }
> =20
> @@ -4818,6 +4981,9 @@ fhandler_console::get_duplicated_handle_set (handl=
e_set_t *p)
>    DuplicateHandle (GetCurrentProcess (), output_mutex,
>  		   GetCurrentProcess (), &p->output_mutex,
>  		   0, FALSE, DUPLICATE_SAME_ACCESS);
> +  DuplicateHandle (GetCurrentProcess (), cons_mode_mutex,
> +		   GetCurrentProcess (), &p->cons_mode_mutex,
> +		   0, FALSE, DUPLICATE_SAME_ACCESS);
>    p->unit =3D unit;
>  }
> =20
> @@ -4834,6 +5000,8 @@ fhandler_console::close_handle_set (handle_set_t *=
p)
>    p->input_mutex =3D NULL;
>    CloseHandle (p->output_mutex);
>    p->output_mutex =3D NULL;
> +  CloseHandle (p->cons_mode_mutex);
> +  p->cons_mode_mutex =3D NULL;
>  }
> =20
>  bool
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index ee576a0a8..0134ec8b8 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -830,20 +830,37 @@ void
>  fhandler_termios::spawn_worker::cleanup ()
>  {
>    if (ptys_need_cleanup)
> -    fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> -						    ptys_ttyp, stdin_is_ptys);
> +    {
> +      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> +						      ptys_ttyp, stdin_is_ptys);
> +      fhandler_pty_slave::close_handle_set (&ptys_handle_set);
> +      ptys_need_cleanup =3D false;
> +    }
>    if (cons_need_cleanup)
> -    fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
> -  close_handle_set ();
> +    {
> +      fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
> +      fhandler_console::close_handle_set (&cons_handle_set);
> +      cons_need_cleanup =3D false;
> +    }
> +}
> +
> +bool
> +fhandler_termios::spawn_worker::is_attaching (DWORD pid)
> +{
> +  return !!fhandler_termios::get_console_process_id (pid, true);
>  }
> =20
>  void
> -fhandler_termios::spawn_worker::close_handle_set ()
> +fhandler_termios::spawn_worker::wait_for_resume_if_necessary
> +			      (path_conv &pc, PROCESS_INFORMATION &pi)
>  {
> -  if (ptys_need_cleanup)
> -    fhandler_pty_slave::close_handle_set (&ptys_handle_set);
> -  if (cons_need_cleanup)
> -    fhandler_console::close_handle_set (&cons_handle_set);
> +  if (is_attaching (myself->dwProcessId) && is_console_app (pc))
> +    {
> +      DWORD t0 =3D GetTickCount ();
> +      while (GetTickCount () - t0 < 40 && !is_attaching (pi.dwProcessId=
)
> +	     && WaitForSingleObject (pi.hProcess, 0) =3D=3D WAIT_TIMEOUT)
> +	Sleep (1);
> +    }
>  }
> =20
>  void
> @@ -916,7 +933,10 @@ fhandler_termios::get_console_process_id (DWORD pid=
, bool match,
>  	  }
>  	else
>  	  {
> -	    pinfo p (cygwin_pid (list[i]));
> +	    pid_t cygpid =3D cygwin_pid (list[i]);
> +	    if (cygpid =3D=3D 0)
> +	      continue;
> +	    pinfo p (cygpid);
>  	    if (nat && !!p && !ISSTATE(p, PID_NOTCYGWIN))
>  	      continue;
>  	    if (!!p && p->exec_dwProcessId)
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index d11b3ec4f..e00212f57 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2023,6 +2023,7 @@ class fhandler_termios: public fhandler_base
>      HANDLE output_handle;
>      HANDLE input_mutex;
>      HANDLE output_mutex;
> +    HANDLE cons_mode_mutex;
>      _minor_t unit;
>    };
>    class spawn_worker
> @@ -2042,7 +2043,8 @@ class fhandler_termios: public fhandler_base
>  		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
>      bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanu=
p; }
>      void cleanup ();
> -    void close_handle_set ();
> +    bool is_attaching (DWORD pid);
> +    void wait_for_resume_if_necessary (path_conv &, PROCESS_INFORMATION=
 &);
>    };
>  };
> =20
> @@ -2157,6 +2159,8 @@ class dev_console
>    volatile bool master_thread_suspended;
>    int num_processed; /* Number of input events in the current input buf=
fer
>  			already processed by cons_master_thread(). */
> +  bool need_win32_input_mode_fix;
> +  bool is_processed_input;
> =20
>    inline UINT get_console_cp ();
>    DWORD con_to_str (char *d, int dlen, WCHAR w);
> @@ -2199,6 +2203,7 @@ private:
>    static console_state *shared_console_info[MAX_CONS_DEV + 1];
>    static bool invisible_console;
>    HANDLE input_mutex, output_mutex;
> +  HANDLE cons_mode_mutex;
>    handle_set_t handle_set;
>    _minor_t unit;
>    size_t num_input_events_processed;
> @@ -2268,6 +2273,7 @@ private:
> =20
>    void read (void *ptr, size_t& len);
>    ssize_t write (const void *ptr, size_t len);
> +  ssize_t raw_write (const void *ptr, size_t len);
>    void doecho (const void *str, DWORD len);
>    int close (int flag =3D -1);
>    static bool exists ()
> @@ -2366,6 +2372,7 @@ private:
>    void wpbuf_send ();
>    int fstat (struct stat *buf);
>    void discard_key_events (size_t n);
> +  void fix_input_mode_if_necessary ();
> =20
>    class console_unit
>    {
> @@ -2379,6 +2386,7 @@ private:
>    void setup_pcon_hand_over ();
>    static void pcon_hand_over_proc ();
>    static tty::cons_mode cons_mode_on_close (handle_set_t *);
> +  static int active_non_cygwin_apps_exist (pid_t pgid);
> =20
>    friend tty_min * tty_list::get_cttyp ();
>  };
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index b72083447..33417169b 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1154,23 +1154,23 @@ peek_console (select_record *me, bool)
>    HANDLE h;
>    set_handle_or_return_if_not_open (h, me);
> =20
> -  fh->acquire_input_mutex (mutex_timeout);
>    while (!fh->input_ready && !fh->get_cons_readahead_valid ())
>      {
>        if (fh->bg_check (SIGTTIN, true) <=3D bg_eof)
> -	{
> -	  fh->release_input_mutex ();
> -	  return me->read_ready =3D true;
> -	}
> +	return me->read_ready =3D true;
>        else
>  	{
> +	  fh->acquire_input_mutex (mutex_timeout);
>  	  acquire_attach_mutex (mutex_timeout);
>  	  DWORD resume_pid =3D fh->attach_console (fh->get_owner ());
>  	  BOOL r =3D PeekConsoleInputW (h, &irec, 1, &events_read);
>  	  fh->detach_console (resume_pid, fh->get_owner ());
>  	  release_attach_mutex ();
>  	  if (!r || !events_read)
> -	    break;
> +	    {
> +	      fh->release_input_mutex ();
> +	      break;
> +	    }
>  	}
>        if (fhandler_console::input_winch =3D=3D fh->process_input_messag=
e (0)
>  	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> @@ -1180,8 +1180,10 @@ peek_console (select_record *me, bool)
>  	  fh->release_input_mutex ();
>  	  return -1;
>  	}
> +      fh->release_input_mutex ();
> +
> +      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
>      }
> -  fh->release_input_mutex ();
>    if (fh->input_ready || fh->get_cons_readahead_valid ())
>      return me->read_ready =3D true;
> =20
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 8f976b9a0..abaa34d32 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -559,6 +559,14 @@ child_info_spawn::worker (const char *prog_arg, con=
st char *const *argv,
>  			 PROCESS_QUERY_LIMITED_INFORMATION))
>  	sa =3D &sec_none_nih;
> =20
> +      if (!real_path.iscygexec () && mode =3D=3D _P_OVERLAY)
> +	{
> +	  LONG pidflags =3D PID_NOTCYGWIN;
> +	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
> +	    pidflags |=3D PID_NEW_PG;
> +	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
> +	}
> +
>        int fileno_stdin =3D in__stdin < 0 ? 0 : in__stdin;
>        int fileno_stdout =3D in__stdout < 0 ? 1 : in__stdout;
>        int fileno_stderr =3D 2;
> @@ -586,14 +594,6 @@ child_info_spawn::worker (const char *prog_arg, con=
st char *const *argv,
>  	 up on ruid. The new process will have ruid =3D=3D euid. */
>        ::cygheap->user.deimpersonate ();
> =20
> -      if (!real_path.iscygexec () && mode =3D=3D _P_OVERLAY)
> -	{
> -	  LONG pidflags =3D PID_NOTCYGWIN;
> -	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
> -	    pidflags |=3D PID_NEW_PG;
> -	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
> -	}
> -
>        cygpid =3D (mode !=3D _P_OVERLAY) ? create_cygwin_pid () : myself=
->pid;
> =20
>        cygheap->lock ();
> @@ -737,6 +737,18 @@ child_info_spawn::worker (const char *prog_arg, con=
st char *const *argv,
>        /* Name the handle similarly to proc_subproc. */
>        ProtectHandle1 (pi.hProcess, childhProc);
> =20
> +      /* Start the child running for non-cygwin process*/
> +      if (!iscygwin () && (c_flags & CREATE_SUSPENDED))
> +	{
> +	  /* Inject a non-inheritable wr_proc_pipe handle into child so that w=
e
> +	     can accurately track when the child exits without keeping this
> +	     process waiting around for it to exit.  */
> +	  DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess,
> +			   NULL, 0, false, DUPLICATE_SAME_ACCESS);
> +	  ResumeThread (pi.hThread);
> +	  term_spawn_worker.wait_for_resume_if_necessary (real_path, pi);
> +	}
> +
>        if (mode =3D=3D _P_OVERLAY)
>  	{
>  	  myself->dwProcessId =3D pi.dwProcessId;
> @@ -810,18 +822,11 @@ child_info_spawn::worker (const char *prog_arg, co=
nst char *const *argv,
>  	    }
>  	}
> =20
> -      /* Start the child running */
> -      if (c_flags & CREATE_SUSPENDED)
> +      /* Start the child running for cygwin process*/
> +      if (iscygwin () && (c_flags & CREATE_SUSPENDED))
>  	{
> -	  /* Inject a non-inheritable wr_proc_pipe handle into child so that w=
e
> -	     can accurately track when the child exits without keeping this
> -	     process waiting around for it to exit.  */
> -	  if (!iscygwin ())
> -	    DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess, =
NULL,
> -			     0, false, DUPLICATE_SAME_ACCESS);
>  	  ResumeThread (pi.hThread);
> -	  if (iscygwin ())
> -	    strace.write_childpid (pi.dwProcessId);
> +	  strace.write_childpid (pi.dwProcessId);
>  	}
>        ForceCloseHandle (pi.hThread);
> =20
> @@ -868,7 +873,6 @@ child_info_spawn::worker (const char *prog_arg, cons=
t char *const *argv,
>  		prev_sigExeced =3D
>  		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
>  	      term_spawn_worker.cleanup ();
> -	      term_spawn_worker.close_handle_set ();
>  	    }
>  	  /* Make sure that ctrl_c_handler() is not on going. Calling
>  	     init_console_handler(false) locks until returning from
> @@ -906,7 +910,7 @@ child_info_spawn::worker (const char *prog_arg, cons=
t char *const *argv,
>        res =3D -1;
>      }
>    __endtry
> -  term_spawn_worker.close_handle_set ();
> +  term_spawn_worker.cleanup ();
>    this->cleanup ();
>    if (envblock)
>      free (envblock);
> --=20
> 2.51.0
>=20
>=20
