Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by sourceware.org (Postfix) with ESMTPS id 987043858D35
 for <cygwin-patches@cygwin.com>; Fri, 25 Feb 2022 13:38:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 987043858D35
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1645796283;
 bh=8iOr8z3/KWJWkzU6uM9UfKjLR1xWvSu32FBrnNLspvk=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=O8eo5SgNWX3erXpzmLG0x8h9xoWoNV28gSq9O1f3xrKKfejgUhYzzHp1Ix+MuZBx4
 //SzzxKRpsZMVxkNBsuy0q1DkUn6fk+uaSYIXug1Fm1T1RtZeCeJS4F4ntZLFTnOda
 qs20vruj8w2jo5aYa7DlJjaT0hwyXRSRI6ZFcYM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1nii2B3429-00YUWW; Fri, 25
 Feb 2022 14:38:02 +0100
Date: Fri, 25 Feb 2022 14:37:59 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty, console: Refactor the code processing
 special keys.
In-Reply-To: <20220220111510.978-1-takashi.yano@nifty.ne.jp>
Message-ID: <nycvar.QRO.7.76.6.2202242023050.11118@tvgsbejvaqbjf.bet>
References: <20220220111510.978-1-takashi.yano@nifty.ne.jp>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uerkL0nuXnV4SiG9GRrPUszN3YyQTPzmJcCNl7/UHX7C0UzJ4NB
 NgWaP4n4SZghSAL56lk5Yvyf3MYG22b5faJQGgxzIZAT+O1ZRCLd4nKW+mEW7aSNveMX9bs
 Ap8hZ4DC6/svhI0QANst5JAEMFNJ1tvrVDFXbYRb3ZM4EhmC3XLvncm7fMu2XgeJi+KsnLA
 VhI9emxkY2oiznRdbUcMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6LeT0+lWwt0=:W6jfpl3mqFFcLrDHnMAr6/
 Z1NJyaUtWEajhAkWrYRlPq4sgF72KlsnNzr+fnVz3Tk/S69uOaE/hw/43n2AjYQZRA3nds51Y
 sVspPEPgigIrL+G6UUDuh9iyC8srHDbDEL+bVD3O8pFMy2doeuJz/9khnCQ62atD8TuCTF9Wv
 T7dB6RVrv/vesteqZ1CgxDrGr2NM5FPmIHzLi6BAeftfsACY8Kxqvi3eeosnnhmU+mEYqpKaG
 Gq3bDeZyjqhy3oDfYSsHmxIOk1zJy2lnox6bOguPvzqSdsqeqf/L4UHgUSeAhSe3Rds0fbtgr
 MgNwGbZBNFShXzVYlyXLTH1EmV6BRK/UDp4SP0goBvXG+wQihbfcgl4bHw9VidtDV+/MjHNE5
 lKdCS52rlCSd5+C8kfHrgYhtvp06iSPKq5SjG3RrpdR6ZQwo7YzmeZRKBdn6hwKU35eO1MVHh
 /qYaFxM8TW77ImDF+xVyhP+Ts0gJuesFeRlR4J4/En8Jlgavucj4iGcYMwuq9wNwsYPGuv1c1
 1zxblvf3rcvDlaAtV8kihUSL0itfhCHX0GrMAfFNWeyi3bu+kmL5e8GjPF9Px5/Aai6xLyp3F
 LbxCZCyLXiwisanO6TgPxdsEWiuu0lhPtzdZKx5JeIQKix2XwiIDoNwnHeSF43tPYlpunqb+l
 2ueuVId16SLcV6btV+/47nwX38/RtG34HCmaxfNvcUQLzk/7CE1SOw1ZC3WjZ/he7TLAUKS/s
 hXYFgyf/eSSUwYfQsJ/ySe2KUkoDT00A4ZxkXv+d9G6tIs46sXp5Xq90meo9UoMKcbayFILDy
 qoLLUXEwaz5rO/cS8x8+nTXHgftdf625VR0jbwsbvVRxPeCrHLggdlN6id5zD+W/n1gqcs6Mo
 YNg1t5aQeJVtwnyhJ19Ygbc5ENblH5gb6lR2243O7LOWpCduJKb+KMObk0J6bHWJdV9QuD32F
 3660nPC4jsUcatE8u0+ev0W76f5XF6Ym6GprXh73M1opgeIlaGBP3LU5nSlalZjj8oc4otLfV
 /lJzsnTv+jnoym84WGzorNKfZaT3GSNsobTH/EGRwSDUF68Chan8G1kaEGAxZ1CLz2s1cCFmu
 HaUJASJFeXV2I2nzSPFc6yB3Jcy9JsE7Eob
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 25 Feb 2022 13:38:13 -0000

Hi Takashi,

On Sun, 20 Feb 2022, Takashi Yano wrote:

> - This patch commonize the code which processes special keys in pty
>   and console to improve maintanancibility.

I very much welcome the direction. Thank you for working on this!

> As a result, some small bugs have been fixed.

Whenever I read something like this in commit messages, I wish for more
details. Could you describe those bugs, and how exactly they were fixed?

> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index a914110fe..356d69d6a 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -1147,6 +1147,19 @@ ctrl_c_handler (DWORD type)
>      return TRUE;
>
>    tty_min *t =3D cygwin_shared->tty.get_cttyp ();
> +
> +  /* If process group leader is non-cygwin process or not exist,
> +     send signal to myself. */
> +  pinfo pi (t->getpgid ());
> +  if ((!pi || (pi->process_state & PID_NOTCYGWIN))
> +      && (!have_execed || have_execed_cygwin)
> +      && t->getpgid () =3D=3D myself->pgid
> +      && type =3D=3D CTRL_C_EVENT)
> +    {
> +      t->output_stopped =3D false;
> +      sig_send(myself, SIGINT);
> +    }
> +

=46rom the commit message, I would have expected this patch to be
essentially a clean and obvious refactoring of the existing code.

However, I cannot find any removed code in the diff that would explain
this newly-added code.

When I see something like this in patches, I usually take to the commit
message to explain what is going on. But in this case, I am left even more
puzzled than before.

> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index 4e86ab58a..3e0d7d5a6 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -1901,6 +1902,13 @@ class fhandler_termios: public fhandler_base
>    virtual void release_input_mutex_if_necessary (void) {};
>    virtual void discard_input () {};
>
> +  enum process_sig_state {
> +    signalled,
> +    not_signalled,
> +    not_signalled_but_done,
> +    not_signalled_with_cyg_reader
> +  };
> +

My hope for this refactor is that it will get much easier to understand
for developers who are unfamiliar with the pseudo console code.

In this instance, I am wishing for a code comment above the `enum` that
explains its role, and the meaning of the four values. In particular the
difference of the last two compared to the second is quite lost on me.

> @@ -1943,6 +1954,8 @@ class fhandler_termios: public fhandler_base
>    }
>    static bool path_iscygexec_a (LPCSTR n, LPSTR c);
>    static bool path_iscygexec_w (LPCWSTR n, LPWSTR c);
> +  virtual bool is_pty_master_with_pcon () { return false; }

It would probably make sense to document the role of a pty master with
respect to pseudo consoles somewhere. If no better location can be found,
then it would probably make most sense to add a comment above this new
line.

> +  virtual void cleanup_before_exit () {}
>  };
>
>  enum ansi_intensity
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_=
console.cc
> index 50f350c49..475c1acdb 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -188,13 +188,28 @@ cons_master_thread (VOID *arg)
>  void
>  fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
>  {
> +  termios &ti =3D ttyp->ti;
>    DWORD output_stopped_at =3D 0;
>    while (con.owner =3D=3D myself->pid)
>      {
>        DWORD total_read, n, i;
>        INPUT_RECORD input_rec[INREC_SIZE];
>
> -      if (con.disable_master_thread)
> +      bool nat_fg =3D false;
> +      bool nat_child_fg =3D false;
> +      winpids pids ((DWORD) 0);
> +      for (unsigned i =3D 0; i < pids.npids; i++)
> +	{
> +	  _pinfo *pi =3D pids[i];
> +	  if (pi && pi->ctty =3D=3D ttyp->ntty && pi->pgid =3D=3D ttyp->getpgi=
d ()
> +	      && (pi->process_state & PID_NOTCYGWIN)
> +	      && !(pi->process_state & PID_NEW_PG))
> +	    nat_fg =3D true;
> +	  if (pi && pi->ctty =3D=3D ttyp->ntty && pi->pgid =3D=3D ttyp->getpgi=
d ()
> +	      && !(pi->process_state & PID_CYGPARENT))
> +	    nat_child_fg =3D true;
> +	}
> +      if (nat_fg && !nat_child_fg)

It is unclear to me whether this code fixes a bug, or refactors other
code, or both. Not to forget: it is still unclear to be what `nat` should
mean, which suggests to me that either the name could be improved or a
code comment would be in order.

Since it is already unclear to me what fundamental goal this part has (as
well as much of the remainder of this quite large patch), I fear that even
for a motivated reviewer like myself, it is rather difficult to provide
any useful review.

Therefore I think I need to stop here, as much as I want to help.

Maybe this code could be augmented with more comments? And maybe the patch
could be split up further for clarity? I have a sense that much of it is
actually refactoring that could be done incrementally, with an explanation
in the commit message that makes things utterly clear, and other parts are
bug fixes where the bug in question could be described, and the approach
taken to fix it (as well as other approaches that were considered and a
discussion why those approaches were rejected).

Thank you for working on this, I appreciate it a lot,
Johannes

>  	{
>  	  cygwait (40);
>  	  continue;
> @@ -233,90 +248,35 @@ fhandler_console::cons_master_thread (handle_set_t=
 *p, tty *ttyp)
>  	}
>        for (i =3D 0; i < total_read; i++)
>  	{
> -	  const wchar_t wc =3D input_rec[i].Event.KeyEvent.uChar.UnicodeChar;
> -	  if ((wint_t) wc >=3D 0x80)
> -	    continue;
> -	  char c =3D (char) wc;
> +	  wchar_t wc;
> +	  char c;
> +	  bool was_output_stopped;
>  	  bool processed =3D false;
> -	  termios &ti =3D ttyp->ti;
> -	  pinfo pi (ttyp->getpgid ());
> -	  if (pi && pi->ctty =3D=3D ttyp->ntty
> -	      && (pi->process_state & PID_NOTCYGWIN)
> -	      && input_rec[i].EventType =3D=3D KEY_EVENT && c =3D=3D '\003')
> -	    {
> -	      bool not_a_sig =3D false;
> -	      if (!CCEQ (ti.c_cc[VINTR], c)
> -		  && !CCEQ (ti.c_cc[VQUIT], c)
> -		  && !CCEQ (ti.c_cc[VSUSP], c))
> -		not_a_sig =3D true;
> -	      if (input_rec[i].Event.KeyEvent.bKeyDown)
> -		{
> -		  /* CTRL_C_EVENT does not work for the process started with
> -		     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
> -		     instead. */
> -		  if (pi->process_state & PID_NEW_PG)
> -		    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
> -					      pi->dwProcessId);
> -		  else
> -		    GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
> -		  if (not_a_sig)
> -		    goto skip_writeback;
> -		}
> -	      processed =3D true;
> -	      if (not_a_sig)
> -		goto remove_record;
> -	    }
>  	  switch (input_rec[i].EventType)
>  	    {
>  	    case KEY_EVENT:
> -	      if (ti.c_lflag & ISIG)
> -		{
> -		  int sig =3D 0;
> -		  if (CCEQ (ti.c_cc[VINTR], c))
> -		    sig =3D SIGINT;
> -		  else if (CCEQ (ti.c_cc[VQUIT], c))
> -		    sig =3D SIGQUIT;
> -		  else if (CCEQ (ti.c_cc[VSUSP], c))
> -		    sig =3D SIGTSTP;
> -		  if (sig && input_rec[i].Event.KeyEvent.bKeyDown)
> -		    {
> -		      ttyp->kill_pgrp (sig);
> -		      ttyp->output_stopped =3D false;
> -		      ti.c_lflag &=3D ~FLUSHO;
> -		      /* Discard type ahead input */
> -		      goto skip_writeback;
> -		    }
> -		}
> -	      if (ti.c_iflag & IXON)
> -		{
> -		  if (CCEQ (ti.c_cc[VSTOP], c))
> -		    {
> -		      if (!ttyp->output_stopped
> -			  && input_rec[i].Event.KeyEvent.bKeyDown)
> -			{
> -			  ttyp->output_stopped =3D true;
> -			  output_stopped_at =3D i;
> -			}
> -		      processed =3D true;
> -		    }
> -		  else if (CCEQ (ti.c_cc[VSTART], c))
> -		    {
> -		restart_output:
> -		      if (input_rec[i].Event.KeyEvent.bKeyDown)
> -			ttyp->output_stopped =3D false;
> -		      processed =3D true;
> -		    }
> -		  else if ((ti.c_iflag & IXANY) && ttyp->output_stopped
> -			   && c && i >=3D output_stopped_at)
> -		    goto restart_output;
> -		}
> -	      if ((ti.c_lflag & ICANON) && (ti.c_lflag & IEXTEN)
> -		  && CCEQ (ti.c_cc[VDISCARD], c))
> +	      if (!input_rec[i].Event.KeyEvent.bKeyDown)
> +		continue;
> +	      wc =3D input_rec[i].Event.KeyEvent.uChar.UnicodeChar;
> +	      if (!wc || (wint_t) wc >=3D 0x80)
> +		continue;
> +	      c =3D (char) wc;
> +	      switch (process_sigs (c, ttyp, NULL))
>  		{
> -		  if (input_rec[i].Event.KeyEvent.bKeyDown)
> -		    ti.c_lflag ^=3D FLUSHO;
> +		case signalled:
> +		case not_signalled_but_done:
>  		  processed =3D true;
> +		  ttyp->output_stopped =3D false;
> +		  if (ti.c_lflag & NOFLSH)
> +		    goto remove_record;
> +		  goto skip_writeback;
> +		default: /* not signalled */
> +		  break;
>  		}
> +	      was_output_stopped =3D ttyp->output_stopped;
> +	      processed =3D process_stop_start (c, ttyp, i > output_stopped_at=
);
> +	      if (!was_output_stopped && ttyp->output_stopped)
> +		output_stopped_at =3D i;
>  	      break;
>  	    case WINDOW_BUFFER_SIZE_EVENT:
>  	      SHORT y =3D con.dwWinSize.Y;
> @@ -447,7 +407,6 @@ fhandler_console::setup ()
>        con.cons_rapoi =3D NULL;
>        shared_console_info->tty_min_state.is_console =3D true;
>        con.cursor_key_app_mode =3D false;
> -      con.disable_master_thread =3D false;
>      }
>  }
>
> @@ -503,8 +462,6 @@ fhandler_console::set_input_mode (tty::cons_mode m, =
const termios *t,
>  	flags |=3D ENABLE_VIRTUAL_TERMINAL_INPUT;
>        else
>  	flags |=3D ENABLE_MOUSE_INPUT;
> -      if (shared_console_info)
> -	con.disable_master_thread =3D false;
>        break;
>      case tty::native:
>        if (t->c_lflag & ECHO)
> @@ -517,8 +474,6 @@ fhandler_console::set_input_mode (tty::cons_mode m, =
const termios *t,
>  	flags &=3D ~ENABLE_ECHO_INPUT;
>        if (t->c_lflag & ISIG)
>  	flags |=3D ENABLE_PROCESSED_INPUT;
> -      if (shared_console_info)
> -	con.disable_master_thread =3D true;
>        break;
>      }
>    SetConsoleMode (p->input_handle, flags);
> @@ -1394,9 +1349,6 @@ fhandler_console::open (int flags, mode_t)
>  	setenv ("TERM", "cygwin", 1);
>      }
>
> -  set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> -  set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> -
>    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
>  		get_output_handle ());
>
> @@ -1421,6 +1373,17 @@ fhandler_console::open_setup (int flags)
>    return fhandler_base::open_setup (flags);
>  }
>
> +void
> +fhandler_console::post_open_setup (int fd)
> +{
> +  if (fd =3D=3D 0)
> +    set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +  else if (fd =3D=3D 1 || fd =3D=3D 2)
> +    set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +
> +  fhandler_base::post_open_setup (fd);
> +}
> +
>  int
>  fhandler_console::close ()
>  {
> diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_=
termios.cc
> index b935a70bc..477d75b96 100644
> --- a/winsup/cygwin/fhandler_termios.cc
> +++ b/winsup/cygwin/fhandler_termios.cc
> @@ -130,8 +130,9 @@ is_flush_sig (int sig)
>  }
>
>  void
> -tty_min::kill_pgrp (int sig)
> +tty_min::kill_pgrp (int sig, pid_t target_pgid)
>  {
> +  target_pgid =3D target_pgid ?: pgid;
>    bool killself =3D false;
>    if (is_flush_sig (sig) && cygheap->ctty)
>      cygheap->ctty->sigflush ();
> @@ -145,7 +146,7 @@ tty_min::kill_pgrp (int sig)
>    for (unsigned i =3D 0; i < pids.npids; i++)
>      {
>        _pinfo *p =3D pids[i];
> -      if (!p || !p->exists () || p->ctty !=3D ntty || p->pgid !=3D pgid=
)
> +      if (!p || !p->exists () || p->ctty !=3D ntty || p->pgid !=3D targ=
et_pgid)
>  	continue;
>        if (p->process_state & PID_NOTCYGWIN)
>  	continue;
> @@ -308,6 +309,156 @@ fhandler_termios::echo_erase (int force)
>      doecho ("\b \b", 3);
>  }
>
> +fhandler_termios::process_sig_state
> +fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh=
)
> +{
> +  termios &ti =3D ttyp->ti;
> +  pid_t pgid =3D ttyp->pgid;
> +
> +  pinfo leader (pgid);
> +  bool cyg_leader =3D leader && !(leader->process_state & PID_NOTCYGWIN=
);
> +  bool ctrl_c_event_sent =3D false;
> +  bool need_discard_input =3D false;
> +  bool pg_with_nat =3D false;
> +  bool need_send_sig =3D false;
> +  bool nat_shell =3D false;
> +  bool cyg_reader =3D false;
> +
> +  winpids pids ((DWORD) 0);
> +  for (unsigned i =3D 0; i < pids.npids; i++)
> +    {
> +      _pinfo *p =3D pids[i];
> +      if (c =3D=3D '\003' && p && p->ctty =3D=3D ttyp->ntty && p->pgid =
=3D=3D pgid
> +	  && ((p->process_state & PID_NOTCYGWIN)
> +	      || !(p->process_state & PID_CYGPARENT)))
> +	{
> +	  pinfo pinfo_resume =3D pinfo (myself->ppid);
> +	  DWORD resume_pid =3D 0;
> +	  if (pinfo_resume)
> +	    resume_pid =3D pinfo_resume->dwProcessId;
> +	  else
> +	    resume_pid =3D fhandler_pty_common::get_console_process_id
> +	      (myself->dwProcessId, false);
> +	  if (resume_pid && fh && !fh->is_console ())
> +	    {
> +	      FreeConsole ();
> +	      AttachConsole (p->dwProcessId);
> +	    }
> +	  /* CTRL_C_EVENT does not work for the process started with
> +	     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
> +	     instead. */
> +	  if (p->process_state & PID_NEW_PG)
> +	    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
> +				      p->dwProcessId);
> +	  else if ((!fh || !fh->is_pty_master_with_pcon () || cyg_leader)
> +		   && !ctrl_c_event_sent)
> +	    {
> +	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
> +	      ctrl_c_event_sent =3D true;
> +	    }
> +	  if (resume_pid && fh && !fh->is_console ())
> +	    {
> +	      FreeConsole ();
> +	      AttachConsole (resume_pid);
> +	    }
> +	  need_discard_input =3D true;
> +	}
> +      if (p && p->ctty =3D=3D ttyp->ntty && p->pgid =3D=3D pgid)
> +	{
> +	  if (p->process_state & PID_NOTCYGWIN)
> +	    pg_with_nat =3D true;
> +	  if (!(p->process_state & PID_NOTCYGWIN))
> +	    need_send_sig =3D true;
> +	  if (!p->cygstarted)
> +	    nat_shell =3D true;
> +	  if (p->process_state & PID_TTYIN)
> +	    cyg_reader =3D true;
> +	}
> +    }
> +  /* Send SIGQUIT to non-cygwin process. */
> +  if ((ti.c_lflag & ISIG) && CCEQ (ti.c_cc[VQUIT], c)
> +      && pg_with_nat && need_send_sig && !nat_shell)
> +    {
> +      for (unsigned i =3D 0; i < pids.npids; i++)
> +	{
> +	  _pinfo *p =3D pids[i];
> +	  if (p && p->ctty =3D=3D ttyp->ntty && p->pgid =3D=3D pgid
> +	      && (p->process_state & PID_NOTCYGWIN))
> +	    sig_send (p, SIGQUIT);
> +	}
> +    }
> +  if ((ti.c_lflag & ISIG) && need_send_sig)
> +    {
> +      int sig;
> +      if (CCEQ (ti.c_cc[VINTR], c))
> +	sig =3D SIGINT;
> +      else if (CCEQ (ti.c_cc[VQUIT], c))
> +	sig =3D SIGQUIT;
> +      else if (pg_with_nat)
> +	goto not_a_sig;
> +      else if (CCEQ (ti.c_cc[VSUSP], c))
> +	sig =3D SIGTSTP;
> +      else
> +	goto not_a_sig;
> +
> +      termios_printf ("got interrupt %d, sending signal %d", c, sig);
> +      if (!(ti.c_lflag & NOFLSH) && fh)
> +	{
> +	  fh->eat_readahead (-1);
> +	  fh->discard_input ();
> +	}
> +      if (fh)
> +	fh->release_input_mutex_if_necessary ();
> +      ttyp->kill_pgrp (sig, pgid);
> +      if (fh)
> +	fh->acquire_input_mutex_if_necessary (mutex_timeout);
> +      ti.c_lflag &=3D ~FLUSHO;
> +      return signalled;
> +    }
> +not_a_sig:
> +  if (need_discard_input)
> +    {
> +      if (!(ti.c_lflag & NOFLSH) && fh)
> +	{
> +	  fh->eat_readahead (-1);
> +	  fh->discard_input ();
> +	}
> +      ti.c_lflag &=3D ~FLUSHO;
> +      return not_signalled_but_done;
> +    }
> +  bool to_cyg =3D cyg_reader || !pg_with_nat;
> +  return to_cyg ? not_signalled_with_cyg_reader : not_signalled;
> +}
> +
> +bool
> +fhandler_termios::process_stop_start (char c, tty *ttyp, bool on_ixany)
> +{
> +  termios &ti =3D ttyp->ti;
> +  if (ti.c_iflag & IXON)
> +    {
> +      if (CCEQ (ti.c_cc[VSTOP], c))
> +	{
> +	  ttyp->output_stopped =3D true;
> +	  return true;
> +	}
> +      else if (CCEQ (ti.c_cc[VSTART], c))
> +	{
> +restart_output:
> +	  ttyp->output_stopped =3D false;
> +	  return true;
> +	}
> +      else if ((ti.c_iflag & IXANY) && ttyp->output_stopped && on_ixany=
)
> +	goto restart_output;
> +    }
> +  if ((ti.c_lflag & ICANON) && (ti.c_lflag & IEXTEN)
> +      && CCEQ (ti.c_cc[VDISCARD], c))
> +    {
> +      ti.c_lflag ^=3D FLUSHO;
> +      return true;
> +    }
> +  return false;
> +}
> +
>  line_edit_status
>  fhandler_termios::line_edit (const char *rptr, size_t nread, termios& t=
i,
>  			     ssize_t *bytes_read)
> @@ -328,92 +479,24 @@ fhandler_termios::line_edit (const char *rptr, siz=
e_t nread, termios& ti,
>
>        if (ti.c_iflag & ISTRIP)
>  	c &=3D 0x7f;
> -      winpids pids ((DWORD) 0);
> -      bool need_check_sigs =3D get_ttyp ()->pcon_input_state_eq (tty::t=
o_cyg);
> -      if (get_ttyp ()->pcon_input_state_eq (tty::to_nat))
> +      bool disable_eof_key =3D true;
> +      switch (process_sigs (c, get_ttyp (), this))
>  	{
> -	  bool need_discard_input =3D false;
> -	  for (unsigned i =3D 0; i < pids.npids; i++)
> -	    {
> -	      _pinfo *p =3D pids[i];
> -	      if (c =3D=3D '\003' && p && p->ctty =3D=3D tc ()->ntty
> -		  && p->pgid =3D=3D tc ()->getpgid ()
> -		  && (p->process_state & PID_NOTCYGWIN))
> -		{
> -		  /* CTRL_C_EVENT does not work for the process started with
> -		     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
> -		     instead. */
> -		  if (p->process_state & PID_NEW_PG)
> -		    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
> -					      p->dwProcessId);
> -		  else
> -		    GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
> -		  need_discard_input =3D true;
> -		}
> -	      if (p->ctty =3D=3D get_ttyp ()->ntty
> -		  && p->pgid =3D=3D get_ttyp ()->getpgid () && !p->cygstarted)
> -		need_check_sigs =3D true;
> -	    }
> -	  if (!CCEQ (ti.c_cc[VINTR], c)
> -	      && !CCEQ (ti.c_cc[VQUIT], c)
> -	      && !CCEQ (ti.c_cc[VSUSP], c))
> -	    need_check_sigs =3D false;
> -	  if (need_discard_input && !need_check_sigs)
> -	    {
> -	      if (!(ti.c_lflag & NOFLSH))
> -		{
> -		  eat_readahead (-1);
> -		  discard_input ();
> -		}
> -	      ti.c_lflag &=3D ~FLUSHO;
> -	      continue;
> -	    }
> -	}
> -      if ((ti.c_lflag & ISIG) && need_check_sigs)
> -	{
> -	  int sig;
> -	  if (CCEQ (ti.c_cc[VINTR], c))
> -	    sig =3D SIGINT;
> -	  else if (CCEQ (ti.c_cc[VQUIT], c))
> -	    sig =3D SIGQUIT;
> -	  else if (CCEQ (ti.c_cc[VSUSP], c))
> -	    sig =3D SIGTSTP;
> -	  else
> -	    goto not_a_sig;
> -
> -	  termios_printf ("got interrupt %d, sending signal %d", c, sig);
> -	  if (!(ti.c_lflag & NOFLSH))
> -	    {
> -	      eat_readahead (-1);
> -	      discard_input ();
> -	    }
> -	  release_input_mutex_if_necessary ();
> -	  tc ()->kill_pgrp (sig);
> -	  acquire_input_mutex_if_necessary (mutex_timeout);
> -	  ti.c_lflag &=3D ~FLUSHO;
> +	case signalled:
>  	  sawsig =3D true;
> -	  goto restart_output;
> -	}
> -    not_a_sig:
> -      if (ti.c_iflag & IXON)
> -	{
> -	  if (CCEQ (ti.c_cc[VSTOP], c))
> -	    {
> -	      if (!tc ()->output_stopped)
> -		tc ()->output_stopped =3D true;
> -	      continue;
> -	    }
> -	  else if (CCEQ (ti.c_cc[VSTART], c))
> -	    {
> -    restart_output:
> -	      tc ()->output_stopped =3D false;
> -	      continue;
> -	    }
> -	  else if ((ti.c_iflag & IXANY) && tc ()->output_stopped)
> -	    goto restart_output;
> +	  fallthrough;
> +	case not_signalled_but_done:
> +	  get_ttyp ()->output_stopped =3D false;
> +	  continue;
> +	case not_signalled_with_cyg_reader:
> +	  disable_eof_key =3D false;
> +	  break;
> +	default: /* Not signalled */
> +	  break;
>  	}
> +      if (process_stop_start (c, get_ttyp (), true))
> +	continue;
>        /* Check for special chars */
> -
>        if (c =3D=3D '\r')
>  	{
>  	  if (ti.c_iflag & IGNCR)
> @@ -432,12 +515,6 @@ fhandler_termios::line_edit (const char *rptr, size=
_t nread, termios& ti,
>  	    set_input_done (iscanon);
>  	}
>
> -      if (iscanon && ti.c_lflag & IEXTEN && CCEQ (ti.c_cc[VDISCARD], c)=
)
> -	{
> -	  ti.c_lflag ^=3D FLUSHO;
> -	  continue;
> -	}
> -
>        if (!iscanon)
>  	/* nothing */;
>        else if (CCEQ (ti.c_cc[VERASE], c))
> @@ -474,7 +551,7 @@ fhandler_termios::line_edit (const char *rptr, size_=
t nread, termios& ti,
>  	    }
>  	  continue;
>  	}
> -      else if (CCEQ (ti.c_cc[VEOF], c) && need_check_sigs)
> +      else if (CCEQ (ti.c_cc[VEOF], c) && !disable_eof_key)
>  	{
>  	  termios_printf ("EOF");
>  	  accept_input ();
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.=
cc
> index 5ba50cc73..a25690a0e 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2291,47 +2291,12 @@ fhandler_pty_master::write (const void *ptr, siz=
e_t len)
>  			  &mbp);
>  	}
>
> -      if ((ti.c_lflag & ISIG) && memchr (buf, '\003', nlen))
> -	{
> -	  /* If the process is started with CREATE_NEW_PROCESS_GROUP
> -	     flag, Ctrl-C will not be sent to that process. Therefore,
> -	     send Ctrl-break event to that process here. */
> -	  DWORD wpid =3D 0;
> -	  winpids pids ((DWORD) 0);
> -	  for (unsigned i =3D 0; i < pids.npids; i++)
> -	    {
> -	      _pinfo *p =3D pids[i];
> -	      if (p->ctty =3D=3D get_ttyp ()->ntty
> -		  && p->pgid =3D=3D get_ttyp ()->getpgid ()
> -		  && (p->process_state & PID_NOTCYGWIN)
> -		  && (p->process_state & PID_NEW_PG))
> -		{
> -		  wpid =3D p->dwProcessId;
> -		  break;
> -		}
> -	    }
> -	  pinfo pinfo_resume =3D pinfo (myself->ppid);
> -	  DWORD resume_pid;
> -	  if (pinfo_resume)
> -	    resume_pid =3D pinfo_resume->dwProcessId;
> -	  else
> -	    resume_pid =3D get_console_process_id (myself->dwProcessId, false)=
;
> -	  if (wpid && resume_pid)
> -	    {
> -	      WaitForSingleObject (pcon_mutex, INFINITE);
> -	      FreeConsole ();
> -	      AttachConsole (wpid);
> -	      /* CTRL_C_EVENT does not work for the process started with
> -		 CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
> -		 instead. */
> -	      GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT, wpid);
> -	      FreeConsole ();
> -	      AttachConsole (resume_pid);
> -	      ReleaseMutex (pcon_mutex);
> -	    }
> -	  if (!(ti.c_lflag & NOFLSH))
> -	    get_ttyp ()->discard_input =3D true;
> +      for (size_t i =3D 0; i < nlen; i++)
> +	{
> +	  fhandler_termios::process_sigs (buf[i], get_ttyp (), this);
> +	  process_stop_start (buf[i], get_ttyp (), true);
>  	}
> +
>        DWORD n;
>        WriteFile (to_slave_nat, buf, nlen, &n, NULL);
>        ReleaseMutex (input_mutex);
> @@ -2885,7 +2850,8 @@ fhandler_pty_master::pty_master_fwd_thread (const =
master_fwd_thread_param_t *p)
>        WaitForSingleObject (p->output_mutex, mutex_timeout);
>        while (rlen>0)
>  	{
> -	  if (!process_opost_output (p->to_master, ptr, wlen, false,
> +	  if (!process_opost_output (p->to_master, ptr, wlen,
> +				     true /* disable output_stopped */,
>  				     p->ttyp, false))
>  	    {
>  	      termios_printf ("WriteFile for forwarding failed, %E");
> @@ -4006,3 +3972,10 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir=
 dir, HANDLE from, tty *ttyp,
>    ttyp->pcon_input_state =3D dir;
>    ttyp->discard_input =3D false;
>  }
> +
> +void
> +fhandler_pty_slave::cleanup_before_exit ()
> +{
> +  if (myself->process_state & PID_NOTCYGWIN)
> +    get_ttyp ()->wait_pcon_fwd ();
> +}
> diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
> index 2cd12a665..87ff43ea2 100644
> --- a/winsup/cygwin/tty.h
> +++ b/winsup/cygwin/tty.h
> @@ -75,7 +75,7 @@ public:
>    void setpgid (int pid);
>    int getsid () const {return sid;}
>    void setsid (pid_t tsid) {sid =3D tsid;}
> -  void kill_pgrp (int);
> +  void kill_pgrp (int, pid_t target_pgid =3D 0);
>    int is_orphaned_process_group (int);
>    const __reg1 char *ttyname () __attribute (());
>  };
> --
> 2.35.1
>
>
