Return-Path: <SRS0=+gxg=EX=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 124F94BA2E35
	for <cygwin-patches@cygwin.com>; Sat, 27 Jun 2026 07:27:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 124F94BA2E35
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 124F94BA2E35
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782545239; cv=none;
	b=OB5lcEd/8bBoi6V3REzroRNsCN6EuhlPqZihZVrVYDT8cgCwKe/gHGfDDU6eDUca8Dcn37K9U2SNbgxBfzl+EJnoK5HxVgtGKrttmsQ0Ni+g7rQfGBw8JS1i1Cg/CwIQweFAz/KFo81A0UMdkHllV4zvWbo83qOay53k/pekWq8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782545239; c=relaxed/simple;
	bh=H0CE+WemFWWfVvWm2pFMsBVtm2YbHl0jJFdIbnlpV8k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ogtOduHiaJ2tACNiwWfQ0N8uFWzMzzYJoakKy4BiZgp6H7tUTNUbo5XxNQw1UpYs5UrtewdDEKKYc6chyfyIAgSle/evYUVQSTMjpSkh554/QZMSuxqvKg3EcOUAypkbgSZcYYCfGMwHFGp8q3H5f1J7um8drPnopXtl+xqWNKM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FTlL4E3C
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 124F94BA2E35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FTlL4E3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782545237; x=1783150037;
	i=johannes.schindelin@gmx.de;
	bh=Q824VjwV48SYhfZcYIruhFdlpwv0SQp0ZtqEEkdhSPI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FTlL4E3CyZX92qsuZ9VTKj7YXzhBBWpqQeNzNpUzp10X2R0DkbD5cXsNSGQAnIH6
	 58LCCoY5woCpqSkj2Tz8FTp8rIwciFYUVznXd4oHPw5kQBehDWcqrhNV+MdCYAVR9
	 f2ePedjrHcLU2U5PafAfmf35E+zUelA7vYbiTaR+qjaI/028/OX9fyvrUCHw4SLiD
	 zaBIFYbXiNhva1tu2ICzPGv9vXhdlvN0yuV4xuqcg9YFVtg9sCxua2IOtUhxQe9UD
	 wNTXYsgNIMzn3+EielPqU8onTdGOsRemDQ+cycypjScw8CHGzVfLPbNxca3ua73Fa
	 BYFuPoDnOh6FbsYjQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1wydNO2nGV-00hrdh; Sat, 27
 Jun 2026 09:27:17 +0200
Date: Sat, 27 Jun 2026 09:27:12 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>, Mark Geisert <mark@maxrnd.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little
In-Reply-To: <20260610163533.10187-3-takashi.yano@nifty.ne.jp>
Message-ID: <d8dacefa-68a4-d6bd-e6c4-d6291bb02256@gmx.de>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp> <20260610163533.10187-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:QvJ1LJ9SYFNUc9EGawg7h4zqgYAiposTxjdd0uq11605Zql5MCj
 Z4KvbwG+BasNpP2XPy98ncpy8rw43L9XbR5vxIcVYnz56OotPiWPIhe6YhMqT1DmE6FSAIQ
 eCO/2YGItwS/NhQakciHKyysdSVPMgvXO1V7XuLy4YU8U9moWE2qH4l5p6n6/CEHiwrcLAl
 LZT+1f0Xt4DbHOyIXuiRg==
UI-OutboundReport: notjunk:1;M01:P0:gbqgSb8fugc=;cIhTQiRKcTiG/ysWOPXPD6JkM8N
 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
 n6KFDvRc4=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi, Mark,

I have a fix for the issue below sitting in
https://github.com/git-for-windows/msys2-runtime/pull/131/commits/0b0976a5=
e85de52312c17d21f1d3fc41dc572179
that I should have sent earlier, but I was struggling to find the time to
validate the fix via automated AutoHotKey-based tests. Sorry for the
delay.

On Thu, 11 Jun 2026, Takashi Yano wrote:

> If you run "stty noflsh; cat" in "bash", and stop "cat" by Ctrl-C,
> a stray ^C is passed to "bash". The current code calls tcflush() if
> NOFLSH is not set, however, tcflush() is not called when NOFLSH is
> set. So, Ctrl-C remains in console input buffer. This should be
> discarded even in NOFLSH mode. This patch introduces a helper
> function discard_key_events() and call it to erase Ctrl-C in the
> console input buffer.
>=20
> Note that even with this patch, NOFLSH is not fully functional in
> console because the readahead buffer is unique to process, so it
> cannot be inherited to other processes. However, it should work
> intra process.
>=20
> Fixes: 118e51be1d04 ("(tty_min::kill_pgrp): Handle tty flush when signal=
 detected.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc       | 20 +++++++++++++++++---
>  winsup/cygwin/fhandler/termios.cc       | 10 +++++++---
>  winsup/cygwin/local_includes/fhandler.h |  2 ++
>  3 files changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index a5e6cd89d..9ac492980 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1744,17 +1744,31 @@ out:
>      discard_len =3D 0;
>    if (discard_len)
>      {
> -      DWORD discarded;
>        acquire_attach_mutex (mutex_timeout);
>        DWORD resume_pid =3D attach_console (con.owner);
> -      ReadConsoleInputW (get_handle (), input_rec, discard_len, &discar=
ded);
> +      discard_key_events (discard_len);
>        detach_console (resume_pid, con.owner);
>        release_attach_mutex ();
> -      con.num_processed -=3D min (con.num_processed, discarded);
>      }
>    return stat;
>  }
> =20
> +void
> +fhandler_console::discard_key_events (size_t n)
> +{
> +  DWORD discarded =3D 0;
> +  INPUT_RECORD input_rec[INREC_SIZE];
> +  DWORD n1 =3D min (INREC_SIZE, n);
> +  while (n)
> +    {
> +      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
> +      n -=3D n1;
> +      discarded +=3D n1;
> +      n1 =3D min (INREC_SIZE, n);
> +    }
> +  con.num_processed -=3D min (con.num_processed, discarded);
> +}

`discard_key_events()` loops on `ReadConsoleInputW()` until it has
consumed the requested count, and `ReadConsoleInputW()` blocks while the
input buffer is empty. The `sigflush()` caller passes a hard-coded `1`
with no guarantee that a record is actually queued: in the master-thread
path the signalling record has already been read out of the buffer before
`sigflush()` runs, so the call blocks until the user's next keystroke
arrives, and then swallows it. And because `ReadConsoleInputW()`'s return
is unchecked, a failed read leaves `n1` indeterminate, so `n -=3D n1` can
underflow and spin.

The fix is to consume only what `GetNumberOfConsoleInputEvents()` reports
as currently queued (so the helper never waits for input that is not
there) and to bail on a failed or zero-length read (so it cannot
underflow).

One separate point worth flagging: the `process_input_message()` caller
wraps `discard_key_events()` in `acquire_attach_mutex()` + `attach_console
(con.owner)`, but the `sigflush()` call site does not, so the
`ReadConsoleInputW()` there runs against whatever console the calling
process happens to be attached to. With the guard above the worst case is
a no-op when the calling process happens not to be attached, but it would
be more correct to wrap the `sigflush()` discard the same way, or to move
the attach into the helper itself.

The fix I propose is:

=2D- snip --
=46rom 0b0976a5e85de52312c17d21f1d3fc41dc572179 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 25 Jun 2026 13:41:44 +0200
Subject: [PATCH] Cygwin: console: do not block or spin in discard_key_even=
ts()

discard_key_events(), added in "Cygwin: console: Fix NOFLSH behaviour a
bit", loops on ReadConsoleInputW() until it has consumed the requested
number of records, but ReadConsoleInputW() blocks while the console
input buffer is empty. sigflush() calls it with a hard-coded count of
one and no guarantee that a record is actually queued: in the
master-thread path the signalling record has already been read out of
the buffer before sigflush() runs, so the call blocks until, and then
swallows, the user's next keystroke. And because the ReadConsoleInputW()
return value is unchecked, a failed read leaves the count indeterminate,
so "n -=3D n1" can underflow and spin.

Consume only what GetNumberOfConsoleInputEvents() reports as queued, so
the helper never waits for input that is not there, and bail out on a
failed or zero-length read so it cannot underflow.

Fixes: 56dfa4db988c ("Cygwin: console: Fix NOFLSH behaviour a bit")
Assisted-by: Opus 4.8
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/fhandler/console.cc | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/co=
nsole.cc
index 685e99d62c..4949d0494c 100644
=2D-- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1702,13 +1702,18 @@ fhandler_console::discard_key_events (size_t n)
 {
   DWORD discarded =3D 0;
   INPUT_RECORD input_rec[INREC_SIZE];
-  DWORD n1 =3D min (INREC_SIZE, n);
   while (n)
     {
-      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
+      /* Only ever consume events that are actually queued, so this never
+	 blocks waiting for the user's next keystroke. */
+      DWORD avail =3D 0;
+      if (!GetNumberOfConsoleInputEvents (get_handle (), &avail) || !avai=
l)
+	break;
+      DWORD n1 =3D min (min ((DWORD) INREC_SIZE, (DWORD) n), avail);
+      if (!ReadConsoleInputW (get_handle (), input_rec, n1, &n1) || !n1)
+	break;
       n -=3D n1;
       discarded +=3D n1;
-      n1 =3D min (INREC_SIZE, n);
     }
   con.num_processed -=3D min (con.num_processed, discarded);
 }
=2D- snap --

Ciao,
Johannes

> +
>  bool
>  dev_console::fillin (HANDLE h)
>  {
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index ca5fa4b7e..605258731 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -666,9 +666,13 @@ fhandler_termios::sigflush ()
>       be NULL while this is alive.  However, we can conceivably close a
>       ctty while exiting and that will zero this. */
>    if ((!have_execed || have_execed_cygwin) && tc ()
> -      && (tc ()->getpgid () =3D=3D myself->pgid)
> -      && !(tc ()->ti.c_lflag & NOFLSH))
> -    tcflush (TCIFLUSH);
> +      && (tc ()->getpgid () =3D=3D myself->pgid))
> +    {
> +      if (!(tc ()->ti.c_lflag & NOFLSH))
> +	tcflush (TCIFLUSH);
> +      else
> +	discard_key_events (1);
> +    }
>  }
> =20
>  pid_t
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 4f5605524..49e0e7983 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -1983,6 +1983,7 @@ class fhandler_termios: public fhandler_base
>    pid_t tcgetsid ();
>    virtual int fstat (struct stat *buf);
>    int tcflow (int);
> +  virtual void discard_key_events (size_t n) {}
> =20
>    fhandler_termios (void *) {}
> =20
> @@ -2363,6 +2364,7 @@ private:
>    void wpbuf_put (char c);
>    void wpbuf_send ();
>    int fstat (struct stat *buf);
> +  void discard_key_events (size_t n);
> =20
>    class console_unit
>    {
> --=20
> 2.51.0
>=20
>=20
