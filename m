Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id C77F34BA23C6
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 14:50:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C77F34BA23C6
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C77F34BA23C6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774623017; cv=none;
	b=eqqB56YSqo53PnAIAThvBM4Gn37NuyoyEDB6h0Umvwt+5k2SEwJFA9JY/wVXG0+b4jAF2NgE0+bAkyYyHRt4EwP5A+Q33homWPp6Gv8TABWmHs0P3eo2jOa0fwohFifGi1fU0z4ldbFxWjQRg0VzvrJi1yJqtXBMt7wcx1Wgga0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774623017; c=relaxed/simple;
	bh=0euBUVcd65pPowuQCnF3SdouV6rdQeXgBGour/YpYOM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=RSy6SiF39g1xNSbmQ3a1pLaVtM9T/DOVEHMS2TBkgC20VAsjwavr00ubgRd4pM1lvY/RChCamfi7a/oj5/1nJZTqwUF5tFChAZkmo/CVqJT9Eqh7J1jBwPQ2Di3tAPCaQu8rfjZLvr8otqyQRumc1K0YlqCp8x5uuUPSQSq7SXU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C77F34BA23C6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=f4DlaDR9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774623008; x=1775227808;
	i=johannes.schindelin@gmx.de;
	bh=eRpVxtmqGXtiSXsiHJ22SZ471vXZzoiZYmrco05DQdo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f4DlaDR99+xx1pfQq9kIqjd/jfMr28v82TxdWpkLkNDvV90RJmECUUQo3hFBGD9R
	 fKJEshlf4Wigwf5SDOjtme8WBM+uDRmmaO+q8tSo5heqKWarFTjRkTyfBsWEV/q2F
	 y87NGSEvE0Z+WXPkpH+UDexaZWG+tfKkPHgob7FSFFIS1rrs1pXICK9WpBB4MvMEX
	 fYQeG/4jpZteYT7ZVuOA9T34hrelVkbac1A4h1LgXwgsmdE8/p822II5LZdsicuez
	 QD9Dx1tVi6G+ks6QP8gpqzOaxgjoc9W/4WiXrzUdxu5hPpQ80kYNk9ybBigkiAK69
	 HJlLEusB5KtGI4AYKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1veoVB1ao1-00ccR4; Fri, 27
 Mar 2026 15:50:08 +0100
Date: Fri, 27 Mar 2026 15:50:06 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 4/7] Cygwin: pty: Apply line_edit() for transferred
 input to to_cyg
In-Reply-To: <20260325130453.62246-5-takashi.yano@nifty.ne.jp>
Message-ID: <7735090b-32d2-66c3-e4f4-10b49641c020@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-5-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c7Ox5rSbgemM5CzVnwbIPvTrPW1JKEuw8caKMraCPTJ3vf/ozkA
 HPoOLd1iENFE8qO8Wj7lZX1M9G2icrQn1v1nKB2wQxbR9SAdUcR6Sy1K8jEIvOFCxXnjuIT
 zIFViXezfVG2G+XNoA3iMJcJEg1/AFowKPQ+o225/d2+jaq0kQcDwoDsIHybr3v1sf+37Ag
 BgIE0kcfDCluvc6BvytVg==
UI-OutboundReport: notjunk:1;M01:P0:6X1ojgA2dUM=;h26mJHL81wY6rMwpYeOlhXhCg4T
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

This is a nice fix for a subtle problem. I have a few observations,
mostly about the commit message and one edge case.

On Wed, 25 Mar 2026, Takashi Yano wrote:

> The typeahead input while non-cygwin app is running is put into
> the pipe directly by transfer_input(). So, if the shell sets the
> terminal canonical mode, erase char (such as backspace) fails to
> erase chars transferred by transfer_input(). With this patch,
> transferred input in the pipe is read and passed to line_edit()
> to handle erase chars such as VERASE, VKILL, etc.

The commit message is too terse for a change of this complexity. It
describes _what_ is broken but not _why_ the fix has to look the way
it does, nor the synchronization protocol you are introducing.

I think the message should cover at least these three things:

(a) Why the transferred bytes need `line_edit()` processing: when
keystrokes travel through the nat pipe (during a native process
session), they bypass POSIX line discipline entirely. When they are
transferred back to the cyg pipe at cleanup, they arrive as raw bytes.
If the terminal is in canonical mode at that point, VERASE/VKILL
characters in those raw bytes will not erase anything because
`line_edit()` was never applied to them.

(b) Why the forward thread is the right place to call `line_edit()`:
it runs in the master process alongside `master::write()`, sharing
access to the readahead buffer and `line_edit()` state. Calling
`line_edit()` from the slave side (where `transfer_input()` runs)
would not work because `line_edit()` state belongs to the master.

(c) The synchronization protocol: `transfer_input()` signals the
event, then spin-waits for the forward thread to clear it, then
proceeds.

Something like this might work:

    When keystrokes travel through the nat pipe during a native process
    session, they bypass POSIX line discipline entirely. When they are
    transferred back to the cyg pipe at cleanup (via
    `transfer_input(to_cyg)`), they arrive as raw bytes. If the
    terminal is in canonical mode at that point, VERASE and VKILL
    characters in those raw bytes have no effect because `line_edit()`
    was never applied to them. The result: backspace typed while a
    native process was running fails to erase the preceding character
    once the input reaches bash's readline.

    The fix applies `line_edit()` to the transferred bytes before they
    reach the reading process. The right place to do this is the
    master's forward thread (`pty_master_fwd_thread()`), because it
    runs in the master process alongside `fhandler_pty_master::write()`
    and shares access to the readahead buffer and `line_edit()` state.
    Calling `line_edit()` from the slave (where `transfer_input()` runs)
    would not work because that state belongs to the master.

    To coordinate: `transfer_input(to_cyg)` writes the raw bytes to
    the cyg pipe's slave end (`to_slave`), then signals a new
    cross-process event (`input_transferred_to_cyg`) and spin-waits
    for the forward thread to clear it. The forward thread is converted
    from synchronous to overlapped I/O so it can wait on both the
    `from_slave_nat` read completion and the transfer event
    simultaneously. When the event fires, it reads the transferred
    bytes from the cyg pipe's master end (`from_master`), processes
    them through `line_edit()`, and clears the event.

    The spin-wait in `transfer_input()` holds `input_mutex` (from its
    caller), which blocks `fhandler_pty_master::write()` from injecting
    new keystrokes until the forward thread has finished applying
    `line_edit()` to the transferred bytes.

Note: _You_ are the domain expert on this, and I am quite far, still from
understanding the ins and outs of your design, as demonstrated by my
original patch series that started this thread. So I can only depend on
you to fix any mistakes my lack of understanding introduced in that
suggested commit message.

>=20
> Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two in=
put pipes.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc           | 135 +++++++++++++++++-------
>  winsup/cygwin/local_includes/fhandler.h |  10 +-
>  winsup/cygwin/local_includes/tty.h      |   1 +
>  3 files changed, 105 insertions(+), 41 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 72a8ba140..2a0e0d2f7 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -210,6 +210,7 @@ atexit_func (void)
>  	      {
>  		ptys->get_handle_nat (),
>  		ptys->get_input_available_event (),
> +		ptys->input_transferred_to_cyg,
>  		ptys->input_mutex,
>  		ptys->pipe_sw_mutex
>  	      };
> @@ -739,7 +740,7 @@ fhandler_pty_slave::open (int flags, mode_t)
>    {
>      &from_master_nat_local, &input_available_event, &input_mutex, &inus=
e,
>      &output_mutex, &to_master_nat_local, &pty_owner, &to_master_local,
> -    &from_master_local, &pipe_sw_mutex,
> +    &from_master_local, &pipe_sw_mutex, &input_transferred_to_cyg,
>      NULL
>    };
> =20
> @@ -779,6 +780,12 @@ fhandler_pty_slave::open (int flags, mode_t)
>        errmsg =3D "open input event failed, %E";
>        goto err;
>      }
> +  shared_name (buf, INPUT_TRANSFERRED_EVENT, get_minor ());
> +  if (!(input_transferred_to_cyg =3D OpenEvent (MAXIMUM_ALLOWED, TRUE, =
buf)))
> +    {
> +      errmsg =3D "open input transferred event failed, %E";
> +      goto err;
> +    }
> =20
>    /* FIXME: Needs a method to eliminate tty races */
>    {
> @@ -993,6 +1000,8 @@ fhandler_pty_slave::close (int flag)
>      termios_printf ("CloseHandle (inuse), %E");
>    if (!ForceCloseHandle (input_available_event))
>      termios_printf ("CloseHandle (input_available_event<%p>), %E", inpu=
t_available_event);
> +  if (!ForceCloseHandle (input_transferred_to_cyg))
> +    termios_printf ("CloseHandle (input_transferred_to_cyg<%p>), %E", i=
nput_transferred_to_cyg);
>    if (!ForceCloseHandle (get_output_handle_nat ()))
>      termios_printf ("CloseHandle (get_output_handle_nat ()<%p>), %E",
>  	get_output_handle_nat ());
> @@ -1101,7 +1110,8 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void=
)
>  		  WaitForSingleObject (input_mutex, mutex_timeout);
>  		  acquire_attach_mutex (mutex_timeout);
>  		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
> -				  input_available_event);
> +				  input_available_event,
> +				  input_transferred_to_cyg);
>  		  release_attach_mutex ();
>  		  ReleaseMutex (input_mutex);
>  		}
> @@ -1277,14 +1287,14 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (boo=
l mask, bool xfer)
>  	{
>  	  acquire_attach_mutex (mutex_timeout);
>  	  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
> -			  input_available_event);
> +			  input_available_event, input_transferred_to_cyg);
>  	  release_attach_mutex ();
>  	}
>        else if (!mask && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
>  	{
>  	  acquire_attach_mutex (mutex_timeout);
>  	  transfer_input (tty::to_nat, get_handle (), get_ttyp (),
> -			  input_available_event);
> +			  input_available_event, input_transferred_to_cyg);
>  	  release_attach_mutex ();
>  	}
>      }
> @@ -1862,11 +1872,15 @@ fhandler_pty_slave::fch_open_handles (bool chown=
)
>    shared_name (buf, INPUT_AVAILABLE_EVENT, get_minor ());
>    input_available_event =3D OpenEvent (READ_CONTROL | write_access,
>  				     TRUE, buf);
> +  shared_name (buf, INPUT_TRANSFERRED_EVENT, get_minor ());
> +  input_transferred_to_cyg =3D OpenEvent (READ_CONTROL | write_access,
> +					TRUE, buf);
>    output_mutex =3D get_ttyp ()->open_output_mutex (write_access);
>    input_mutex =3D get_ttyp ()->open_input_mutex (write_access);
>    pipe_sw_mutex =3D get_ttyp ()->open_mutex (PIPE_SW_MUTEX, write_acces=
s);
>    inuse =3D get_ttyp ()->open_inuse (write_access);
> -  if (!input_available_event || !output_mutex || !input_mutex || !inuse=
)
> +  if (!input_available_event || !output_mutex || !input_mutex || !inuse
> +      || !input_transferred_to_cyg)
>      {
>        __seterrno ();
>        return false;
> @@ -1883,11 +1897,13 @@ fhandler_pty_slave::fch_set_sd (security_descrip=
tor &sd, bool chown)
> =20
>    get_object_sd (input_available_event, sd_old);
>    if (!set_object_sd (input_available_event, sd, chown)
> +      && !set_object_sd (input_transferred_to_cyg, sd, chown)
>        && !set_object_sd (output_mutex, sd, chown)
>        && !set_object_sd (input_mutex, sd, chown)
>        && !set_object_sd (inuse, sd, chown))
>      return 0;
>    set_object_sd (input_available_event, sd_old, chown);
> +  set_object_sd (input_transferred_to_cyg, sd_old, chown);
>    set_object_sd (output_mutex, sd_old, chown);
>    set_object_sd (input_mutex, sd_old, chown);
>    set_object_sd (inuse, sd_old, chown);
> @@ -1900,6 +1916,7 @@ void
>  fhandler_pty_slave::fch_close_handles ()
>  {
>    close_maybe (input_available_event);
> +  close_maybe (input_transferred_to_cyg);
>    close_maybe (output_mutex);
>    close_maybe (input_mutex);
>    close_maybe (inuse);
> @@ -2151,6 +2168,9 @@ fhandler_pty_master::close (int flag)
>    if (!ForceCloseHandle (input_available_event))
>      termios_printf ("CloseHandle (input_available_event<%p>), %E",
>  		    input_available_event);
> +  if (!ForceCloseHandle (input_transferred_to_cyg))
> +    termios_printf ("CloseHandle (input_transferred_to_cyg<%p>), %E",
> +		    input_transferred_to_cyg);
> =20
>    /* The from_master must be closed last so that the same pty is not
>       allocated before cleaning up the other corresponding instances. */
> @@ -2248,7 +2268,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	      acquire_attach_mutex (mutex_timeout);
>  	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
>  						  get_ttyp (),
> -						  input_available_event);
> +						  input_available_event,
> +						  input_transferred_to_cyg);
>  	      release_attach_mutex ();
>  	      ReleaseMutex (input_mutex);
>  	    }
> @@ -2346,7 +2367,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>      {
>        acquire_attach_mutex (mutex_timeout);
>        fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> -					  get_ttyp (), input_available_event);
> +					  get_ttyp (), input_available_event,
> +					  input_transferred_to_cyg);
>        release_attach_mutex ();
>      }
> =20
> @@ -2707,6 +2729,24 @@ reply:
>    return 0;
>  }
> =20
> +void
> +fhandler_pty_master::apply_line_edit_to_transferred_input ()
> +{
> +  const size_t pipesize =3D fhandler_pty_common::pipesize;
> +  char buf[pipesize];
> +  DWORD n;
> +  ReadFile (from_master, buf, pipesize, &n, NULL);

One edge case: this reads up to `pipesize` bytes in a single
`ReadFile()`. If `transfer_input()` wrote more than that (unlikely
with typeahead, but possible in principle), the remaining bytes stay
in the pipe. The forward thread would pick them up on the next
iteration via the regular `ReadFile()` path, but _without_
`line_edit()` processing. In practice `pipesize` is 128 KB which is
large enough that this is unlikely to matter, but it might be worth a
comment explaining the assumption, or a loop to drain all pending
bytes through `line_edit()`.

Also, `char buf[pipesize]` puts 128 KB on the stack. That is quite
large for a stack allocation. A heap allocation (or a smaller
fixed-size buffer in a loop) would be safer.

> +  char *p =3D buf;
> +  while (n)
> +    {
> +      ssize_t ret;
> +      line_edit (p, n, get_ttyp ()->ti, &ret);
> +      n -=3D ret;
> +      p +=3D ret;
> +    }
> +  SetEvent (input_available_event);
> +}
> +
>  static DWORD
>  pty_master_thread (VOID *arg)
>  {
> @@ -2891,19 +2931,34 @@ fhandler_pty_master::pty_master_fwd_thread (cons=
t master_fwd_thread_param_t *p)
>    char *outbuf =3D tp.c_get ();
>    char *mbbuf =3D tp.c_get ();
>    static mbstate_t mbp;
> +  OVERLAPPED ov =3D {0, };
> +  ov.hEvent =3D CreateEvent(NULL, TRUE, FALSE, NULL);
> +  HANDLE w[2] =3D {ov.hEvent, p->input_transferred_to_cyg};
> =20
>    termios_printf ("Started.");
>    for (;;)
>      {
>        p->ttyp->fwd_last_time =3D GetTickCount64 ();
> -      DWORD n;
> -      p->ttyp->fwd_not_empty =3D
> -	::bytes_available (n, p->from_slave_nat) && n;
> -      if (!ReadFile (p->from_slave_nat, outbuf, NT_MAX_PATH, &rlen, NUL=
L))
> +      if (!ReadFile (p->from_slave_nat, outbuf, NT_MAX_PATH, NULL, &ov)
> +	  && GetLastError () !=3D ERROR_IO_PENDING)
>  	{
>  	  termios_printf ("ReadFile for forwarding failed, %E");
>  	  break;
>  	}
> +wait_event:
> +      switch (WaitForMultipleObjects (2, w, FALSE, INFINITE))
> +	{
> +	case WAIT_OBJECT_0:
> +	  GetOverlappedResult (p->from_slave_nat, &ov, &rlen, FALSE);
> +	  ResetEvent (ov.hEvent);
> +	  break;
> +	case WAIT_OBJECT_0 + 1:
> +	  p->master->apply_line_edit_to_transferred_input ();
> +	  ResetEvent (p->input_transferred_to_cyg);
> +	  goto wait_event;
> +	default:
> +	  goto wait_event;
> +	}

The overlapped I/O conversion looks correct: waiting on both
`ov.hEvent` and `input_transferred_to_cyg` is the right approach.

However, the `default:` case silently retries via `goto wait_event`.
If `WaitForMultipleObjects()` returns `WAIT_FAILED` due to a
persistent error (e.g. a bad handle), this becomes an infinite
spin-loop with no diagnostic. A `debug_printf()` before the `goto`
would make such a situation much easier to diagnose.

>        if (p->ttyp->stop_fwd_thread)
>  	break;
>        ssize_t wlen =3D rlen;
> @@ -3029,7 +3084,8 @@ fhandler_pty_master::setup ()
>    char pipename[sizeof ("ptyNNNN-from-master-nat")];
>    __small_sprintf (pipename, "pty%d-to-master-nat", unit);
>    res =3D fhandler_pipe::create (&sec_none, &from_slave_nat, &to_master=
_nat,
> -			       fhandler_pty_common::pipesize, pipename, 0);
> +			       fhandler_pty_common::pipesize, pipename,
> +			       FILE_FLAG_OVERLAPPED);
>    if (res)
>      {
>        errstr =3D "output pipe for non-cygwin apps";
> @@ -3090,6 +3146,10 @@ fhandler_pty_master::setup ()
>  					     &sa, TRUE))
>        || GetLastError () =3D=3D ERROR_ALREADY_EXISTS)
>      goto err;
> +  if (!(input_transferred_to_cyg =3D t.get_event (errstr =3D INPUT_TRAN=
SFERRED_EVENT,
> +						&sa, TRUE))
> +      || GetLastError () =3D=3D ERROR_ALREADY_EXISTS)
> +    goto err;
> =20
>    char buf[MAX_PATH];
>    errstr =3D shared_name (buf, OUTPUT_MUTEX, unit);
> @@ -3167,6 +3227,7 @@ err:
>    close_maybe (get_handle ());
>    close_maybe (get_output_handle ());
>    close_maybe (input_available_event);
> +  close_maybe (input_transferred_to_cyg);
>    close_maybe (output_mutex);
>    close_maybe (input_mutex);
>    close_maybe (from_master_nat);
> @@ -3978,6 +4039,8 @@ fhandler_pty_master::get_master_fwd_thread_param (=
master_fwd_thread_param_t *p)
>    p->from_slave_nat =3D from_slave_nat;
>    p->output_mutex =3D output_mutex;
>    p->ttyp =3D get_ttyp ();
> +  p->input_transferred_to_cyg =3D input_transferred_to_cyg;
> +  p->master =3D this;
>    SetEvent (thread_param_copied_event);
>  }
> =20
> @@ -3985,7 +4048,8 @@ fhandler_pty_master::get_master_fwd_thread_param (=
master_fwd_thread_param_t *p)
>  #define CTRL_PRESSED (LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED)
>  void
>  fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty=
 *ttyp,
> -				    HANDLE input_available_event)
> +				    HANDLE input_available_event,
> +				    HANDLE input_transferred_to_cyg)
>  {
>    HANDLE to;
>    if (dir =3D=3D tty::to_nat)
> @@ -4107,26 +4171,8 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir=
 dir, HANDLE from, tty *ttyp,
>  	      ptr =3D mbbuf;
>  	      len =3D nlen;
>  	    }
> -	  /* Call WriteFile() line by line */
> -	  char *p0 =3D ptr;
> -	  char *p_cr =3D (char *) memchr (p0, '\r', len - (p0 - ptr));
> -	  char *p_lf =3D (char *) memchr (p0, '\n', len - (p0 - ptr));
> -	  while (p_cr || p_lf)
> -	    {
> -	      char *p1 =3D
> -		p_cr ?  (p_lf ? ((p_cr + 1 =3D=3D p_lf)
> -				 ?  p_lf : min(p_cr, p_lf)) : p_cr) : p_lf;
> -	      *p1 =3D '\n';
> -	      n =3D p1 - p0 + 1;
> -	      if (n && WriteFile (to, p0, n, &n, NULL) && n)
> -		transfered =3D true;
> -	      p0 =3D p1 + 1;
> -	      p_cr =3D (char *) memchr (p0, '\r', len - (p0 - ptr));
> -	      p_lf =3D (char *) memchr (p0, '\n', len - (p0 - ptr));
> -	    }
> -	  n =3D len - (p0 - ptr);
> -	  if (n && WriteFile (to, p0, n, &n, NULL) && n)
> -	    transfered =3D true;
> +	  if (len && WriteFile (to, ptr, len, &n, NULL) && n)
> +	    transfered =3D true;;
>  	}
>      }
>    else
> @@ -4165,13 +4211,17 @@ fhandler_pty_slave::transfer_input (tty::xfer_di=
r dir, HANDLE from, tty *ttyp,
>      }
>    CloseHandle (to);
> =20
> +  ttyp->pty_input_state =3D dir;
>    /* Fix input_available_event which indicates availability in cyg pipe=
. */
>    if (dir =3D=3D tty::to_nat) /* all data is transfered to nat pipe,
>  			     so no data available in cyg pipe. */
>      ResetEvent (input_available_event);
>    else if (transfered) /* There is data transfered to cyg pipe. */
> -    SetEvent (input_available_event);
> -  ttyp->pty_input_state =3D dir;
> +    {
> +      SetEvent (input_transferred_to_cyg);
> +      while (IsEventSignalled (input_transferred_to_cyg))
> +	yield ();

This spin-wait runs while the slave holds `input_mutex` (acquired by
the caller of `transfer_input()`). During this spin, `master::write()`
cannot acquire `input_mutex`, so new keystrokes stall until the
forward thread finishes processing. I believe that is intentional (the
transfer must complete atomically before new input arrives), but it
would be good to document that deliberate blocking in the commit
message or in a comment next to the loop.

Ciao,
Johannes

> +    }
>    ttyp->discard_input =3D false;
>  }
> =20
> @@ -4191,6 +4241,9 @@ fhandler_pty_slave::get_duplicated_handle_set (han=
dle_set_t *p)
>    DuplicateHandle (GetCurrentProcess (), input_available_event,
>  		   GetCurrentProcess (), &p->input_available_event,
>  		   0, 0, DUPLICATE_SAME_ACCESS);
> +  DuplicateHandle (GetCurrentProcess (), input_transferred_to_cyg,
> +		   GetCurrentProcess (), &p->input_transferred_to_cyg,
> +		   0, 0, DUPLICATE_SAME_ACCESS);
>    DuplicateHandle (GetCurrentProcess (), input_mutex,
>  		   GetCurrentProcess (), &p->input_mutex,
>  		   0, 0, DUPLICATE_SAME_ACCESS);
> @@ -4206,6 +4259,8 @@ fhandler_pty_slave::close_handle_set (handle_set_t=
 *p)
>    p->from_master_nat =3D NULL;
>    CloseHandle (p->input_available_event);
>    p->input_available_event =3D NULL;
> +  CloseHandle (p->input_transferred_to_cyg);
> +  p->input_transferred_to_cyg =3D NULL;
>    CloseHandle (p->input_mutex);
>    p->input_mutex =3D NULL;
>    CloseHandle (p->pipe_sw_mutex);
> @@ -4241,7 +4296,7 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool=
 nopcon,
>        WaitForSingleObject (input_mutex, mutex_timeout);
>        acquire_attach_mutex (mutex_timeout);
>        transfer_input (tty::to_nat, get_handle (), get_ttyp (),
> -		      input_available_event);
> +		      input_available_event, input_transferred_to_cyg);
>        release_attach_mutex ();
>        ReleaseMutex (input_mutex);
>      }
> @@ -4263,7 +4318,8 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (ha=
ndle_set_t *p, tty *ttyp,
>  	  WaitForSingleObject (p->input_mutex, mutex_timeout);
>  	  acquire_attach_mutex (mutex_timeout);
>  	  transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
> -			  p->input_available_event);
> +			  p->input_available_event,
> +			  p->input_transferred_to_cyg);
>  	  release_attach_mutex ();
>  	  ReleaseMutex (p->input_mutex);
>  	}
> @@ -4289,7 +4345,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
>        WaitForSingleObject (input_mutex, mutex_timeout);
>        acquire_attach_mutex (mutex_timeout);
>        transfer_input (tty::to_nat, get_handle (), get_ttyp (),
> -		      input_available_event);
> +		      input_available_event, input_transferred_to_cyg);
>        release_attach_mutex ();
>        ReleaseMutex (input_mutex);
>      }
> @@ -4315,7 +4371,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
>  	}
>        else
>  	acquire_attach_mutex (mutex_timeout);
> -      transfer_input (tty::to_cyg, from, get_ttyp (), input_available_e=
vent);
> +      transfer_input (tty::to_cyg, from, get_ttyp (), input_available_e=
vent,
> +		      input_transferred_to_cyg);
>        if (attach_restore)
>  	resume_from_temporarily_attach (resume_pid);
>        else
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 16f55b4f7..facc3c44c 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2012,6 +2012,7 @@ class fhandler_termios: public fhandler_base
>    {
>      HANDLE from_master_nat;
>      HANDLE input_available_event;
> +    HANDLE input_transferred_to_cyg;
>      HANDLE input_mutex;
>      HANDLE pipe_sw_mutex;
>    };
> @@ -2385,13 +2386,14 @@ class fhandler_pty_common: public fhandler_termi=
os
>    fhandler_pty_common ()
>      : fhandler_termios (),
>      output_mutex (NULL), input_mutex (NULL), pipe_sw_mutex (NULL),
> -    input_available_event (NULL)
> +    input_available_event (NULL), input_transferred_to_cyg (NULL)
>    {
>      pc.file_attributes (FILE_ATTRIBUTE_NORMAL);
>    }
>    static const unsigned pipesize =3D 128 * 1024;
>    HANDLE output_mutex, input_mutex, pipe_sw_mutex;
>    HANDLE input_available_event;
> +  HANDLE input_transferred_to_cyg;
> =20
>    bool use_archetype () const {return true;}
>    DWORD __acquire_output_mutex (const char *fn, int ln, DWORD ms);
> @@ -2514,7 +2516,8 @@ class fhandler_pty_slave: public fhandler_pty_comm=
on
>    void setup_locale (void);
>    void create_invisible_console (void);
>    static void transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp=
,
> -			      HANDLE input_available_event);
> +			      HANDLE input_available_event,
> +			      HANDLE input_transferred_to_cyg);
>    HANDLE get_input_available_event (void) { return input_available_even=
t; }
>    bool pcon_activated (void) { return get_ttyp ()->pcon_activated; }
>    void cleanup_before_exit ();
> @@ -2549,8 +2552,10 @@ public:
>    struct master_fwd_thread_param_t {
>      HANDLE to_master;
>      HANDLE from_slave_nat;
> +    HANDLE input_transferred_to_cyg;
>      HANDLE output_mutex;
>      tty *ttyp;
> +    fhandler_pty_master *master;
>    };
>  private:
>    int pktmode;			// non-zero if pty in a packet mode.
> @@ -2627,6 +2632,7 @@ public:
>    void get_master_thread_param (master_thread_param_t *p);
>    void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
>    bool need_send_ctrl_c_event ();
> +  void apply_line_edit_to_transferred_input ();
>  };
> =20
>  class fhandler_dev_null: public fhandler_base
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_in=
cludes/tty.h
> index 9485e24c5..cd1e202f1 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -18,6 +18,7 @@ details. */
>  /* Input/Output/ioctl events */
> =20
>  #define INPUT_AVAILABLE_EVENT	"cygtty.input.avail"
> +#define INPUT_TRANSFERRED_EVENT	"cygtty.input.xfer"
>  #define OUTPUT_MUTEX		"cygtty.output.mutex"
>  #define INPUT_MUTEX		"cygtty.input.mutex"
>  #define PIPE_SW_MUTEX		"cygtty.pipe_sw.mutex"
> --=20
> 2.51.0
>=20
>=20
