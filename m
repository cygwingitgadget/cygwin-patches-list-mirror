Return-Path: <SRS0=AK3Y=E7=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 40D254BA2E05
	for <cygwin-patches@cygwin.com>; Sun,  5 Jul 2026 08:05:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 40D254BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 40D254BA2E05
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783238737; cv=none;
	b=Yt8TCJ6hZg72B8GM0M2YFwNADhtkj4AwbzK0ri3X1Mbb0LIdJSVCSORmNFIjUe3FISLBepOuPW9ZrQM893wD1Hh6Au73Wn7+60XbCEl6sfD5cqjxwzAyo4IzYfGKsGk//mZ9Qu9E95jAjJSRSGu9IxyJKiOXWIHFmMd7OuS10d4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783238737; c=relaxed/simple;
	bh=Z7vkvhE/L3UGv7BwF2keMyv99H4jSB8hAn3CbpuRtCE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=tjCFYADlKmU6lacK+W0l+W29HSgeaIqzB1lbLqb4hZIesv6uTiPWt9fJpXmfZrPKLW8VoIWZ8NOwhmEAyLMTULajhPtJYWopbgio7/zAZ/hiEns69GFNc+MrNNWaYfLYnLA+oOsIE9RSsb6ZzbJqZIAhRdKXW/upzX0rZhzo5NY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YE3DiNVQ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 40D254BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YE3DiNVQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783238730; x=1783843530;
	i=johannes.schindelin@gmx.de;
	bh=SRWZeFCM/nkk7WbgVi53p8F0XVNUxthKUgiLZ/76MN4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YE3DiNVQ79Xv9gNtWiF8XXbZEA/31TczuMqciv9CT6LFvXu4XXsc+0p/kyTasCu2
	 PVyuAJ5Tvr0tMa1YyCpsHpzwHJs7kLC9bRKKmT/263wdpMKduwroY5pv2ylYsB2uN
	 +cWJi9W+rpVPwTxjLJeJ9lSXHinISOHaZesBZWZjdhk31gbYxLSClQPgVb/US2YjU
	 B2ocmC8MniPgsC3Boyx0jl2rMyFmRsMn49z+rkN0jKgAritu/ZyprCgRokWrigOb1
	 inBT3C/FlOTdzMF94Sl7VgaGoEg2ks5XkgGk896yRv8mqldIGhUMZixKn+0HLUThT
	 PycFD9BAw8LDV2i6Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1wxHVP3I6f-00uhMk; Sun, 05
 Jul 2026 10:05:30 +0200
Date: Sun, 5 Jul 2026 10:05:31 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Correct previous NOFLSH fix
In-Reply-To: <20260630041017.1006-1-takashi.yano@nifty.ne.jp>
Message-ID: <8a82def9-2d48-2d9f-3a37-e9429a961945@gmx.de>
References: <20260630041017.1006-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:OclgOwHqOrZoinhTNc6l+/TtDbeCtyxgB8eOCNXrRXlxJo5iPLS
 c6WJOzHn3e19Eq2kaOCG5b/oburKp/Fpo5AwEXy2tvz+zIoz6yAjrM5zNvn2QhTwo6HqFtg
 7yu2hZcOVkZ/g6/8SLWPyoigQJ6u/3xUDX+24viAMp9zn8sodoRL0Pqh+2ZXFr/5ObvWVYY
 CnntsC6+F4+L0g60KvhRg==
UI-OutboundReport: notjunk:1;M01:P0:BId/F12C//0=;z0H1zpwtaKWG2JC2RdfmPi7+Vpa
 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
 Qu+hZz3xAyU7xE25M7Wf7gMrT3SnTBsVL+U+gBM
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for v2. It cleanly addresses the blocking `ReadConsoleInputW()`
in `sigflush()` and the underflow in `discard_key_events()`, and moving
the attach into the helper is the right cleanup. There is one concern I
would like to talk through, though: the new unconditional `tcflush
(TCIFLUSH)` in `process_sigs()`.

On Tue, 30 Jun 2026, Takashi Yano wrote:

> The previous fix for NOFLSH mode does not work as intended.
>=20
> discard_key_events(), added in "Cygwin: console: Fix NOFLSH behaviour a
> bit", loops on ReadConsoleInputW() until it has consumed the requested
> number of records, but ReadConsoleInputW() blocks while the console
> input buffer is empty. sigflush() calls it with a hard-coded count of
> one and no guarantee that a record is actually queued: in the
> master-thread path the signalling record has already been read out of
> the buffer before sigflush() runs, so the call blocks until, and then
> swallows, the user's next keystroke.
>=20
> To avoid this, this patch does not discard input when process_sigs()
> is called from cons_master_thread, where the value of `fh` is NULL,
> because discarding will be done in cons_master_thread.
>=20
> And because the ReadConsoleInputW() return value is unchecked, a failed
> read leaves the count indeterminate, so "n -=3D n1" can underflow and sp=
in.
> Check return value of ReadConsoleInputW() and abort if it fails.
>=20
> Moreover, discard_key_event(1) does not work as intended if the first
> key event is not a bKeyDown event correspoding to the signalling key.
> Use tcflush() instead(). Since the ey-strokes prior to the signalling
> key are already in the readahead buffer, so tcflush() discards only
> the signalling key.

Let's keep this sentence in mind, and continue the discussion below:

> The important point here is to discard input before
> releasing input_mutex by release_input_mutex_if_necessary(), because,
> if not, cons_master_thread starts to process key events before discardin=
g
> signalling key event because the thread can acquire input_mutex. This
> causes the signalling key is processed twice.
>=20
> One separate point: the `process_input_message()` caller wraps
> `discard_key_events()` in `acquire_attach_mutex()` + `attach_console
> (con.owner)`, but the `sigflush()` call site does not, so the
> `ReadConsoleInputW()` there runs against whatever console the calling
> process happens to be attached to. With the guard above the worst case
> is a no-op when the calling process happens not to be attached, so
> it would be more correct to move the attach into the helper itself.
>=20
> Fixes: 66324edf64a9 ("Cygwin: console: Fix NOFLSH behaviour a bit")
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc | 17 ++++++++---------
>  winsup/cygwin/fhandler/termios.cc | 21 +++++++++++----------
>  2 files changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 730bb0b45..925db828c 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1749,16 +1749,10 @@ out:
>    DWORD discard_len =3D min (total_read, i + 1);
>    /* If input is signalled, do not discard input here because
>       tcflush() is already called from line_edit(). */
> -  if (stat =3D=3D input_signalled && !(ti->c_lflag & NOFLSH))
> +  if (stat =3D=3D input_signalled)
>      discard_len =3D 0;
>    if (discard_len && (len || stat !=3D input_ok))
> -    {
> -      acquire_attach_mutex (mutex_timeout);
> -      DWORD resume_pid =3D attach_console (con.owner);
> -      discard_key_events (discard_len);
> -      detach_console (resume_pid, con.owner);
> -      release_attach_mutex ();
> -    }
> +    discard_key_events (discard_len);
>    return stat;
>  }
> =20
> @@ -1768,13 +1762,18 @@ fhandler_console::discard_key_events (size_t n)
>    DWORD discarded =3D 0;
>    INPUT_RECORD input_rec[INREC_SIZE];
>    DWORD n1 =3D min (INREC_SIZE, n);
> +  acquire_attach_mutex (mutex_timeout);
> +  DWORD resume_pid =3D attach_console (con.owner);
>    while (n)
>      {
> -      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
> +      if (!ReadConsoleInputW (get_handle (), input_rec, n1, &n1) || !n1=
)
> +	break;
>        n -=3D n1;
>        discarded +=3D n1;
>        n1 =3D min (INREC_SIZE, n);
>      }
> +  detach_console (resume_pid, con.owner);
> +  release_attach_mutex ();
>    con.num_processed -=3D min (con.num_processed, discarded);
>  }
> =20
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index 605258731..c59027093 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -444,10 +444,15 @@ fhandler_termios::process_sigs (char c, tty* ttyp,=
 fhandler_termios *fh)
>  	goto not_a_sig;
> =20
>        termios_printf ("got interrupt %d, sending signal %d", c, sig);
> -      if (!(ti.c_lflag & NOFLSH) && fh)
> +      if (fh)
>  	{
> -	  fh->eat_readahead (-1);
> -	  fh->discard_input ();
> +	  if (!(ti.c_lflag & NOFLSH))
> +	    {
> +	      fh->eat_readahead (-1);
> +	      fh->discard_input ();
> +	    }
> +	  if (fh->is_console ())
> +	    fh->tcflush (TCIFLUSH);

That invariant holds for records `line_edit()` has already consumed from
the console input buffer. It does not hold for records that were peeked
in the same `PeekConsoleInputW()` batch but sit at indices after the
signalling record, nor for records that arrive during the yield window
before `process_input_message()` drains the batch. Both of those cases
stay in the console input buffer and get dropped by the new `tcflush()`
along with the signalling record.

Concretely: `process_input_message()` obtains records via
`PeekConsoleInputW()` rather than consuming them, then walks
`0..total_read-1`. If a signalling character (say `^C`) sits at index
`i`, `line_edit()` has run for indices `0..i-1`, then `process_sigs()`
on the signalling byte returns `signalled`, control jumps to `out`, and
the new code sets `discard_len =3D 0`. All `total_read` records still sit
in the console input buffer at the moment `process_sigs()` runs, and
`fh->tcflush (TCIFLUSH)` (backed by `FlushConsoleInputBuffer()`) drops
all of them, regardless of `NOFLSH`.

The yield window that makes this a normal-load hazard, rather than a
corner case, is the backoff heuristic in `cons_master_thread()` with the
explicit comment "read() seems to be called. Process special keys in
`process_input_message ()`.". When it fires, `master_thread_suspended`
is set to `true` and the master thread yields; type-ahead then
accumulates in the console input buffer until `process_input_message()`
picks it up.

Compare with the master thread's own signal handling in
`cons_master_thread()` where `signalled` with `NOFLSH` set does
`goto remove_record` and writes the surviving records back, preserving
type-ahead. The new user-thread path, by contrast, flushes
unconditionally, so the two paths disagree on `NOFLSH` semantics.

For completeness, there is also a narrower reachable state where
`disable_master_thread=3Dtrue` coexists with `curr_input_mode=3Dcygwin`,
entered via the win32-input-mode DEC private mode 9001 handler which
flips `disable_master_thread` without touching `curr_input_mode`, so
the guard in `fhandler_console::bg_check()` does not fire. Narrower
than the type-ahead case, but worth flagging while we are here.

Two ways I could see to resolve it, and I have no strong preference:

(a) Gate the new `tcflush (TCIFLUSH)` on `!(ti.c_lflag & NOFLSH)`,
matching the `eat_readahead()` / `discard_input()` branch immediately
above and the reshaped `sigflush()`.

(b) Replace `tcflush (TCIFLUSH)` with a targeted single-record consume
via `ReadConsoleInputW()` (bounded and return-checked, in the shape of
the rewritten `discard_key_events()`), so only the signalling record is
dropped and `NOFLSH` type-ahead survives.

Does that reasoning make sense to you?

Ciao,
Johannes

>  	}
>        if (fh)
>  	fh->release_input_mutex_if_necessary ();
> @@ -666,13 +671,9 @@ fhandler_termios::sigflush ()
>       be NULL while this is alive.  However, we can conceivably close a
>       ctty while exiting and that will zero this. */
>    if ((!have_execed || have_execed_cygwin) && tc ()
> -      && (tc ()->getpgid () =3D=3D myself->pgid))
> -    {
> -      if (!(tc ()->ti.c_lflag & NOFLSH))
> -	tcflush (TCIFLUSH);
> -      else
> -	discard_key_events (1);
> -    }
> +      && (tc ()->getpgid () =3D=3D myself->pgid)
> +      && !(tc ()->ti.c_lflag & NOFLSH))
> +    tcflush (TCIFLUSH);
>  }
> =20
>  pid_t
> --=20
> 2.51.0
>=20
>=20
