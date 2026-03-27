Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 410EE4BA2E18
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 15:37:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 410EE4BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 410EE4BA2E18
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774625828; cv=none;
	b=c8VEkcERCwj5QX/9zkYv3BVmYjxsQQ0UoXE0QK5o6I9x+Mv2zKz89RTGHz+WG8+GbaRV0alrJi3PYKIYWd72FN0mKfz9KW38nlkJ+fVimB0owwirx9/8LCOLGn2MlL2urLCbpQeI1mmgy4hL2XSlXxpgSm4Nln0G5q5fc6Q67S8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774625828; c=relaxed/simple;
	bh=FPnYGkSEVG9cNigHa2u8d+c9+Dt6EEE/xYWScDdxeek=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=We3ldXEY/Aiv1Y1+D7oQp9hF9Gec6rKWsGL7HLXepDQCYzeeqxOlJplcs7nwcufWkvasD/1ddOAQ6VbktABxx6HeePGjkmb2h8xZ5YUlyoWkG5OSTkFvshBQLDgK+BVRAkPbjoF6vvCXKnQ1yF4xgcUi/l6EVcqpcrsml/0l7W4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 410EE4BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=NqCpHrEo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774625826; x=1775230626;
	i=johannes.schindelin@gmx.de;
	bh=8VYZpQOpX2AKsEC9DVKJ4jVGzwvlzjqpDpzS8Te7hNs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NqCpHrEoB+wSyjQjzZA9V6RYu6MeGna+V+vdYlPnQBcfLO+t42nsA3C/eYetHdyJ
	 8WRslWgxHwT6m1EJ0Xb7gtiCpgJROSv5zAIO9q4nlM8rVfWlrv3uYQ68ts97fgSSW
	 K7iCYX07lzqApHs1CZjC46IILhT07TXpBqopWmyIcAhCNtYUjcKxbXRCz7gAd65Mw
	 BhsqKx6BMjzKxV1B/DWIuGoABN7Gwph8ewCZhv716qV0Gagkv15lRP03iEINHBdlG
	 1paNz2TbfoHIXGFQ6yPXKMV+y78XJqJb059zwEz+JLVtAiyKYZp06/G5A99/+e1Ej
	 ExZsNhm5zHrcR97CmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1vfZv02uWG-00odP7; Fri, 27
 Mar 2026 16:37:06 +0100
Date: Fri, 27 Mar 2026 16:37:05 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 7/7] Cygwin: pty: Drop nat_fg() check from
 to_be_read_from_nat_pipe()
In-Reply-To: <20260325130453.62246-8-takashi.yano@nifty.ne.jp>
Message-ID: <e6bd57ce-1c1c-7969-aefe-43cb7c5362e3@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-8-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SSbC5xb1W7Xo3m+36lmzcig6LMFQLnKiK79cdc13jga5vzf6boF
 x6iAKCeGF60k7GQA5Mc6mGM0lzM0l5CU377WDtnth6QqDwQwSa4FsrUvz5GLnXtN+QkNp23
 yd8/ArDKrmOv0RusslD6mtVFZGe/C2no8z/HKQwjw8OIVhm0ZqaNnuGmvOaw0bFa+iyKbTY
 Kgr6fu0U86YPsQ6ichqKg==
UI-OutboundReport: notjunk:1;M01:P0:JRFzYQXRnF0=;nir6a4GoUCYrdnTzs21MPDT/vjh
 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
 R+/X2F57BztpIllTHEgYwx+D4NNchncTw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

The code change itself is clean, minimal, and correct. This is the most
important patch in the series: it eliminates the root cause of the
keystroke reordering bug.

On Wed, 25 Mar 2026, Takashi Yano wrote:

> While non-cygwin app exited but the stub process is not terminated
> yet, nat_fg() returns false because no non-cygwin app is running.
> In this duration, pty input goes cyg pipe. Due to this behaviour,
> the key stroke oder is swapped unexpectedly in the following steps.
>=20
> 1) start non-cygwin app
> 2) press 'a' ('a' goes to nat pipe)
> 3) non-cygwin app exited
> 4) press 'b' ('b' goes to cyg pipe)
> 5) the stub process for non-cygwin app transfers input in nat pipe
>    to cyg pipe ('a' goes to cyg pipe)
> 6) the result in the cyg pipe is "ba"
>
> To fix this issue, this patch drops nat_fg() check from
> to_be_read_from_nat_pipe(). With this patch, it retunrs true when
> (!pcon_start && switch_to_nat_pipe && !masked).

This numbered sequence is excellent and clearly demonstrates the
reordering mechanism. Exactly the right level of detail.

Two small typos: "oder" -> "order", "retunrs" -> "returns".

Apart from that, I think the commit message would benefit from explaining
three additional things:

(a) What each component of the new condition means.

- `!pcon_start` ensures keystrokes go through the CSI6n response handler
  during pseudo console initialization rather than the fast path.

- `switch_to_nat_pipe` is the session-level flag that stays true from
  `setup_for_non_cygwin_app()` through `cleanup_for_non_cygwin_app()`,
  spanning the entire native process lifetime _including_ the post-exit
  cleanup window. This is the key: it stays true even after the native
  process exits, until cleanup explicitly clears it.

- `!masked` (the `TTY_SLAVE_READING` event does not exist) ensures that
  keystrokes go to the Cygwin pipe when a Cygwin process is actively
  reading from the slave, since that process expects POSIX-processed
  input.

(b) Why removing `nat_fg()` is safe. The `nat_fg()` check existed to
prevent keystrokes from going to the nat pipe when no native process was
in the foreground process group. Removing it means keystrokes go to the
nat pipe even after the native process has exited (as long as
`switch_to_nat_pipe` is set). This is safe because conhost's input
buffer accumulates the keystrokes as INPUT_RECORDs, and
`transfer_input(to_cyg)` in `cleanup_for_non_cygwin_app()` reads them
back via `ReadConsoleInputA()` and writes them to the cyg pipe. The
transferred bytes then go through `line_edit()` in the master's forward
thread (via `input_transferred_to_cyg` from the earlier patch in this
series), ensuring proper POSIX line discipline processing before bash's
readline sees them.

(c) Why the added `nat_fg()` check in the disable_pcon transfer path in
`master::write()` is needed. That transfer moves cyg pipe data to the
nat pipe when a Cygwin child exits and a native process regains the
foreground with pcon disabled. The `nat_fg()` check there prevents the
transfer from firing during the post-exit window (when `nat_fg()` is
false), which would steal readline's data. This is correct in the
disable_pcon case because there is no conhost buffer to accumulate
keystrokes; without pcon, the nat pipe is a raw pipe and keystrokes must
only go there when a native process is genuinely in the foreground and
ready to read them.

Here is a suggested commit message body incorporating the above:

    While a non-cygwin app has exited but the stub process has not yet
    terminated, `nat_fg()` returns false because no non-cygwin app is
    running. In this window, pty input goes to the cyg pipe. Due to
    this, the keystroke order is swapped unexpectedly:

    1) start non-cygwin app
    2) press 'a' ('a' goes to nat pipe)
    3) non-cygwin app exits
    4) press 'b' ('b' goes to cyg pipe)
    5) the stub process for non-cygwin app transfers input in nat pipe
       to cyg pipe ('a' goes to cyg pipe)
    6) the result in the cyg pipe is "ba"

    Fix this by dropping the `nat_fg()` check from
    `to_be_read_from_nat_pipe()`. The function now returns true when
    `!pcon_start && switch_to_nat_pipe && !masked`. Each component has
    a specific purpose:

    - `!pcon_start`: keystrokes go through the CSI6n response handler
      during pseudo console initialization rather than the fast path.
    - `switch_to_nat_pipe`: this session-level flag stays true from
      `setup_for_non_cygwin_app()` through
      `cleanup_for_non_cygwin_app()`, spanning the entire native
      process lifetime including the post-exit cleanup window.
    - `!masked` (`TTY_SLAVE_READING` event does not exist): keystrokes
      go to the Cygwin pipe when a Cygwin process is actively reading
      from the slave, since that process expects POSIX-processed input.

    Removing `nat_fg()` is safe because conhost's input buffer
    accumulates keystrokes as INPUT_RECORDs during the post-exit
    window, and `transfer_input(to_cyg)` in
    `cleanup_for_non_cygwin_app()` reads them back via
    `ReadConsoleInputA()` and writes them to the cyg pipe. Those
    transferred bytes then go through `line_edit()` in the master's
    forward thread (via `input_transferred_to_cyg` from an earlier
    patch in this series), ensuring proper POSIX line discipline
    processing.

    Additionally, add a `nat_fg()` check to the disable_pcon transfer
    path in `master::write()`. That transfer moves cyg pipe data to
    the nat pipe when a Cygwin child exits and a native process
    regains the foreground with pcon disabled. Without pcon, there is
    no conhost buffer to accumulate keystrokes (the nat pipe is a raw
    pipe), so keystrokes must only go there when a native process is
    genuinely in the foreground and ready to read them. The `nat_fg()`
    guard prevents the transfer from stealing readline's data during
    the post-exit window.

Thanks,
Johannes

>=20
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index c7e3ddf50..4187dafce 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1338,14 +1338,8 @@ fhandler_pty_common::to_be_read_from_nat_pipe (vo=
id)
>      }
>    while (false);
> =20
> -  if (!pinfo (get_ttyp ()->getpgid ()))
> -    /* GDB may set invalid process group for non-cygwin process. */
> -    {
> -      ret =3D true;
> -      goto out;
> -    }
> +  ret =3D true; /* !pcon_start && switch_to_nat_pipe && !masked */
> =20
> -  ret =3D get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
>  out:
>    ReleaseMutex (pipe_sw_mutex);
>    return ret;
> @@ -2391,6 +2385,7 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>    /* This input transfer is needed when cygwin-app which is started fro=
m
>       non-cygwin app is terminated if pseudo console is disabled. */
>    if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
> +      && get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
>        && get_ttyp ()->pty_input_state =3D=3D tty::to_cyg)
>      {
>        acquire_attach_mutex (mutex_timeout);
> --=20
> 2.51.0
>=20
>=20
