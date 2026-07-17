Return-Path: <SRS0=VPvL=FL=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id BEBA84BA5439
	for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2026 20:50:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BEBA84BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BEBA84BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784321421; cv=none;
	b=OlWQQUr2D2BqBQCch8oXH+3OAV1D+QDfiWnJes6IltlDLPicLs7hg9dn6y6UPh2NE0gCi+3NOJbwuNpI5cmPLFe06xcq1zQlHFBFLYnggf33MJYBVhDGfPhkoDgu6l8H36cgbNwQ9umvwnIPgM23YjGqWglWyHHCNeVDxOOVxFo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784321421; c=relaxed/simple;
	bh=0gZQ9d2f2cBcGLTYL73BlPb2Vrq7pTRk4WHfkt+/uPQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vcuk/M6eWMFPn1/YEZo+D4PWZqnEhrhxTtjUhcbacAqtmiXPgW9DNoXe6M2YnTkFamTT0yxhzWlo+Zo8naNbi4Om/vW1vq23V6/b1yb9mkNTfDY644tyu0xAFvT39xPqhy6N5wQ3QVMojyyiETT8/JacwS8iWQ/6McJr/eaHot4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=E3ptpIPr
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BEBA84BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=E3ptpIPr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784321413; x=1784926213;
	i=johannes.schindelin@gmx.de;
	bh=n7lAk/U7eRbYS7t05J+ncZ3IuMtIa11KzJnQO98yRYI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E3ptpIPra02jpBcvZ9q4nMX6Gv4cqs0JMdO9wmpMGgr7Ftum/S2HPvTxcHXWvOg3
	 SH0rZNgPq45JKHrcIznnDey9ZpS6ND7mYlAOVx09sKrTYzFbfxsid9XO81kJzWnFb
	 a/3CyyaB8vJ0WdoE+OHF6u0/vQmx9Id+IVIehZQmSXtrm/tfB7AGjAmhHeO7i4I0U
	 GfdAihDzdii3iytP8gm8/l5mRyXyh0x5MFfD4ZVvi3TlsX/3quTfBXyrAxuV+iVSO
	 sf3XZLehcV4KiPE5NfXwkW2GH+2whEdw0Mi617X6qi2tkSnj52zWw6u6lAw5pVrj8
	 VsNPist2pTD2flPd5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1xD0Ws0MLj-00dUM5; Fri, 17
 Jul 2026 22:50:13 +0200
Date: Fri, 17 Jul 2026 22:50:11 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
In-Reply-To: <20260716073629.6082-1-takashi.yano@nifty.ne.jp>
Message-ID: <43842666-74c7-623d-581c-3523f0283c01@gmx.de>
References: <20260716073629.6082-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:X5Smt+HhYaBjxFxfm/zqLG8BhCbpy0PcpgXBHmf1vVI3EIsdyqv
 e35SMUHx/X9WAWCFwHx0Ef24Mn/vy31N5qmNo4tYp2NBywIVoekzI2rToOeLGPUZELHQS/2
 lzxxBTJplN+uekkAgNOVxa8M6Q0tEJlgm/UG9JTbDj1tudZ77kwWKz8NWvY5ENx9pyuvaj1
 Uvh9e1DJgwJy7lzaM41Kw==
UI-OutboundReport: notjunk:1;M01:P0:ODa5Iz9JFKY=;4boJutYF4wgqC38ax2AxG9JSmt7
 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
 dJM7Y4RYTk0ym89Fa5l8bJLdae5scTn2rQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 16 Jul 2026, Takashi Yano wrote:

> Previously, if two non-cygwin apps are started and one of them
> exits first, the other one loosed appropriate console mode, since
> the first one restored it to tty::cygwin. This patch counts the
> active console process whose pgid is pgid of the tty and if the
> result is zero (means the last non-cygwin foreground process),
> restore console mode.

Thank you for v4 and for the follow-up correction. I verified that the
published v4 applies cleanly to 0d516c2b1f4d and compiles and links a
`new-cygwin1.dll`. I have not been able to establish the runtime behavior
yet, so the following is from reading the code.

About the follow-up, to remove that `CloseHandle ()` call: agreed. That
correction addresses the duplicate CloseHandle() only, though; the two
blocking issues below are independent of it.

> To avoid race issue between apps modifying
> console mode simultaneously, this patch also introduce a mutex
> named `cons_mode_mutex`.

Here is the first blocking problem, and it is a direct consequence of
"guard all mode changes". The new mutex is not acquired in a consistent
order with respect to `output_mutex`.

>=20
> Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Stop counting up/down the counter by itself.
>     Use num_active_non_cygwin_apps() instead.
> v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
> v4: Guard all mode changes in console by cons_mode_mutex.
>=20
>  winsup/cygwin/fhandler/console.cc       | 87 ++++++++++++++++++++++++-
>  winsup/cygwin/local_includes/fhandler.h |  2 +
>  2 files changed, 86 insertions(+), 3 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index d4c87f29f..5b9a87ebd 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -977,15 +977,59 @@ fhandler_console::setup_for_non_cygwin_app ()
>       console mode. */
>    if (get_ttyp ()->getpgid () =3D=3D myself->pgid)
>      {
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
>        set_disable_master_thread (true, this);
>        set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
>        set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
> +      ReleaseMutex (cons_mode_mutex);

In this path, `cons_mode_mutex` is taken first, and then
`set_output_mode()` acquires `output_mutex` underneath it. The same
nesting holds for `cleanup_for_non_cygwin_app()`, `bg_check()`, `open()`,
`post_open_setup()`, `tcsetattr()`, and `set_console_mode_to_native()`:
`cons_mode_mutex` first, `output_mutex` second.

>      }
>  }
> =20
> +static int
> +num_active_non_cygwin_apps (pid_t pgid)
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
> +	return 0;
> +      buf_size1 =3D num;
> +    }
> +  if (num =3D=3D 0)
> +    return 0;
> +
> +  int cnt =3D 0;
> +  for (DWORD i =3D 0; i < num; i++)
> +    {
> +      pinfo p (cygwin_pid (list[i]));
> +      if (!!p && p->pgid =3D=3D pgid && ISSTATE (p, PID_NOTCYGWIN))
> +	cnt++;
> +    }
> +  return cnt;
> +}
> +
>  void
>  fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
>  {
> +  if (cygheap->ctty->tc()->pgid !=3D myself->pgid)
> +    return;
> +
> +  WaitForSingleObject (p->cons_mode_mutex, INFINITE);
> +  if (num_active_non_cygwin_apps (cygheap->ctty->tc()->pgid))
> +    {
> +      ReleaseMutex (p->cons_mode_mutex);

The second blocking problem is a race window around process creation.
`setup_for_non_cygwin_app()` runs before `CreateProcessW()` and releases
`cons_mode_mutex` before the spawned process becomes visible: it is not
yet in `GetConsoleProcessList()`, and there is no `pinfo` with
`PID_NOTCYGWIN` and the matching `pgid` for it. During that interval a
concurrent `cleanup_for_non_cygwin_app()` can count zero non-Cygwin apps
and restore the Cygwin console mode, which is exactly the regression this
patch sets out to fix. Keep in mind that the count is only reliable once
the spawned process is both created and published. The pending native-mode
state needs to remain represented across process creation and publication,
with a rollback if `CreateProcessW()` fails.

Two non-blocking points on this `num_active_non_cygwin_apps()` helper.

First, latency. On each call this normally does two
`GetConsoleProcessList()` calls (more if the process count changes between
them) plus O(N) `cygwin_pid()` and `pinfo` construction, all under
`cons_mode_mutex`, and v4 broadens who has to wait for that mutex. I am
not claiming an observed slowdown; I have not measured it. Did you? If
not, a cheap fast path seems worthwhile: this loop counts every match but
only the question "is there at least one?" matters, so returning on the
first match, and skipping `pinfo` construction entirely when
`cygwin_pid()` returns 0, would bound the common case.

Second, error semantics. This returns 0 for three distinct situations: a
genuine "no matching process", an API failure (`num =3D=3D 0`), and output
exceeding `buf_size`. But 0 is precisely the value that authorizes the
caller to restore the Cygwin mode. Conflating "there are no non-Cygwin
apps" with "I could not find out" means an enumeration failure silently
triggers a mode restore. Please give the helper a distinct
"unavailable/error" result so the caller can decline to restore when the
count is not trustworthy.

Ciao,
Johannes

> +      CloseHandle (p->cons_mode_mutex);
> +      return;
> +    }
> +
>    const _minor_t unit =3D p->unit;
>    termios dummy =3D {0, };
>    termios *ti =3D shared_console_info[unit] ?
> @@ -999,6 +1043,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handl=
e_set_t *p)
>      set_output_mode (conmode, ti, p);
>    if (con.curr_input_mode !=3D conmode)
>      set_input_mode (conmode, ti, p);
> +  ReleaseMutex (p->cons_mode_mutex);
>  }
> =20
>  /* Return the tty structure associated with a given tty number.  If the
> @@ -1055,6 +1100,10 @@ fhandler_console::setup_io_mutex (void)
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
> @@ -1189,6 +1238,7 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>    /* Setting-up console mode for cygwin app. This is necessary if the
>       cygwin app and other non-cygwin apps are started simultaneously
>       in the same process group. */
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (sig =3D=3D SIGTTIN && con.curr_input_mode !=3D tty::cygwin)
>      {
>        set_disable_master_thread (false, this);
> @@ -1196,6 +1246,7 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>      }
>    if (sig =3D=3D SIGTTOU && con.curr_output_mode !=3D tty::cygwin)
>      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    return fhandler_termios::bg_check (sig, dontsignal);
>  }
> @@ -2010,6 +2061,7 @@ fhandler_console::open (int flags, mode_t)
>    if (in_is_console)
>      CloseHandle (h_in);
> =20
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (in_is_console && con.curr_input_mode !=3D tty::cygwin)
>      {
>        prev_input_mode_backup =3D con.prev_input_mode;
> @@ -2022,6 +2074,7 @@ fhandler_console::open (int flags, mode_t)
>        GetConsoleMode (get_output_handle (), &con.prev_output_mode);
>        set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
>      }
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
>  		get_output_handle ());
> @@ -2105,6 +2158,7 @@ fhandler_console::open_setup (int flags)
>        handle_set.output_handle =3D get_output_handle ();
>        handle_set.input_mutex =3D input_mutex;
>        handle_set.output_mutex =3D output_mutex;
> +      handle_set.cons_mode_mutex =3D cons_mode_mutex;
>        handle_set.unit =3D unit;
>      }
>    return fhandler_base::open_setup (flags);
> @@ -2114,6 +2168,7 @@ void
>  fhandler_console::post_open_setup (int fd)
>  {
>    /* Setting-up console mode for cygwin app started from non-cygwin app=
. */
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (fd =3D=3D 0)
>      {
>        set_disable_master_thread (false, this);
> @@ -2121,6 +2176,7 @@ fhandler_console::post_open_setup (int fd)
>      }
>    else if (fd =3D=3D 1 || fd =3D=3D 2)
>      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    fhandler_base::post_open_setup (fd);
>  }
> @@ -2135,11 +2191,13 @@ fhandler_console::close (int flag)
>    if (shared_console_info[unit] && (dev_t) myself->ctty =3D=3D get_devi=
ce ()
>        && cons_mode_on_close (&handle_set) =3D=3D tty::restore)
>      {
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
>        set_disable_master_thread (true, this);
>        if (con.curr_output_mode !=3D tty::restore)
>  	set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);

But `close()` here, and `char_command()` below, are already holding
`output_mutex` at the point they reach this code, and only then acquire
`cons_mode_mutex`. That is the opposite order.

>        if (con.curr_input_mode !=3D tty::restore)
>  	set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
> +      ReleaseMutex (cons_mode_mutex);
>      }
> =20
>    if (shared_console_info[unit] && con.owner =3D=3D GetCurrentProcessId=
 ())
> @@ -2196,6 +2254,8 @@ fhandler_console::close (int flag)
>    input_mutex =3D NULL;
>    CloseHandle (output_mutex);
>    output_mutex =3D NULL;
> +  CloseHandle (cons_mode_mutex);
> +  cons_mode_mutex =3D NULL;
> =20
>    pcon_hand_over_proc ();
> =20
> @@ -2369,10 +2429,12 @@ int
>  fhandler_console::tcsetattr (int a, struct termios const *t)
>  {
>    get_ttyp ()->ti =3D *t;
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (con.curr_input_mode =3D=3D tty::cygwin)
>      set_input_mode (tty::cygwin, t, &handle_set);
>    if (con.curr_output_mode =3D=3D tty::cygwin)

Two processes can therefore wait on each other indefinitely: one holding
`output_mutex` and waiting for `cons_mode_mutex`, the other holding
`cons_mode_mutex` and waiting for `output_mutex`. We need one consistent
lock order across all of these sites. I do not want to prescribe a
specific redesign as unquestionably correct; whether that means taking
`output_mutex` before `cons_mode_mutex` everywhere, or narrowing
`cons_mode_mutex` so it never nests over `output_mutex`, is your call. But
the current mixed order is a showstopper.

>      set_output_mode (tty::cygwin, t, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
>    return 0;
>  }
> =20
> @@ -3140,10 +3202,12 @@ fhandler_console::char_command (char c)
>  		    con.cursor_key_app_mode =3D (c =3D=3D 'h');
>  		  if (con.args[i] =3D=3D 9001) /* win32-input-mode (https://github.co=
m/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard=
%20handling%20in%20Conpty.md) */
>  		    {
> +		      WaitForSingleObject (cons_mode_mutex, INFINITE);
>  		      set_disable_master_thread (c =3D=3D 'h', this);
>  		      if (con.curr_input_mode =3D=3D tty::cygwin)
>  			set_input_mode (tty::cygwin,
>  					&tc ()->ti, get_handle_set ());
> +		      ReleaseMutex (cons_mode_mutex);
>  		    }
>  		}
>  	      /* Call fix_tab_position() if screen has been alternated. */
> @@ -4475,10 +4539,13 @@ fhandler_console::set_console_mode_to_native ()
>  	fhandler_console *cons =3D (fhandler_console *) (fhandler_base *) cfd;
>  	if (cons->get_device () =3D=3D cons->tc ()->getntty ())
>  	  {
> +	    const fhandler_console::handle_set_t *p =3D cons->get_handle_set (=
);
> +	    WaitForSingleObject (p->cons_mode_mutex, INFINITE);
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
> @@ -4536,7 +4603,16 @@ static FARPROC
>  GetProcAddress_Hooked (HMODULE h, LPCSTR n)
>  {
>    if (strcmp(n, "RequestTermConnector") =3D=3D 0)
> -    fhandler_console::set_disable_master_thread (true);
> +    {
> +      char buf[MAX_PATH];
> +      const _minor_t unit =3D cygheap->ctty->get_minor ();
> +      shared_name (buf, "cygcons.cons_mode.mutex", unit);
> +      HANDLE cons_mode_mutex =3D CreateMutex (&sec_none, FALSE, buf);
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
> +      fhandler_console::set_disable_master_thread (true);
> +      ReleaseMutex (cons_mode_mutex);
> +      CloseHandle (cons_mode_mutex);
> +    }
>    return GetProcAddress_Orig (h, n);
>  }
> =20
> @@ -4817,6 +4893,9 @@ fhandler_console::get_duplicated_handle_set (handl=
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
> @@ -4833,6 +4912,8 @@ fhandler_console::close_handle_set (handle_set_t *=
p)
>    p->input_mutex =3D NULL;
>    CloseHandle (p->output_mutex);
>    p->output_mutex =3D NULL;
> +  CloseHandle (p->cons_mode_mutex);
> +  p->cons_mode_mutex =3D NULL;
>  }
> =20
>  bool
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index d11b3ec4f..9c891863f 100644
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
> @@ -2199,6 +2200,7 @@ private:
>    static console_state *shared_console_info[MAX_CONS_DEV + 1];
>    static bool invisible_console;
>    HANDLE input_mutex, output_mutex;
> +  HANDLE cons_mode_mutex;
>    handle_set_t handle_set;
>    _minor_t unit;
>    size_t num_input_events_processed;
> --=20
> 2.51.0
>=20
>=20
