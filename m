Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 78D664BA2E1A
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 14:20:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 78D664BA2E1A
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 78D664BA2E1A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774621251; cv=none;
	b=lRxN6Kcm7SxFowMq+Stdj8iqOwP6tI+kg0XNWxR0ZfBc/ZBQTNpNaDXysru/DzWXYjukp6K9VljjudiTV/wvZAlS9USjxrm9ks6SVP3BM4MqgXU9iEOfd7HKXNxxnkXFI9DceljG8bi2JTCD5iGbRVE8pBRVwdKFNhT7jQh2YQA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774621251; c=relaxed/simple;
	bh=H7Ffw9DwTawa+21vbA+bZVB+DkTZjan7PViCRdchRT4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=h/sfobozcehKi5vyv5Djsv1OmL7l4KMvEPGuEM9tLCPh8MKx7TLJBQQ85lEFZ+DOMJRgw3FF0YULVo/KsY6zlwnHqj9zYdx8ALq07qImGH6G3qzdsS244goGdsnJhu8FELZnoh2W6+fq71Sjg2KQ5UwkoUzmuUWB5ZyP92yJxfI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 78D664BA2E1A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=n+NXNiJT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774621244; x=1775226044;
	i=johannes.schindelin@gmx.de;
	bh=M+DGrVoAN2xQYpL/EIQdSZW5v4aQuTJatommXv7/FQs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n+NXNiJT/znSp1NF3ecBm4Bl6cNqzZPltBoTqGfQyAyeTK+5qOv/JAXYXUT4eCC4
	 d+HV5++wmsZ72lOEQIIti0OM3z9Hlw7YknvIRsAWT/vWMirJkKqMWpn35XIeu3gL7
	 qZZ9NPb/t+BWzrGohN8hvTcxQcFvvDqB55d03ljbp09xeRwZK3iAT6KgQmX0G6cyM
	 dkvy72UGezkdPuhAIjyqRqdjapjVfntpdhYwERUpUmKREKV/msnJxDOrvTUGMG2xb
	 WGEagcJkYMkfWFJzDDZoV5x6qURPt0moU93vjwoYqbse32TodJIEwj7F90+0ITLne
	 kjyO7RVboPSHQtGL+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1vZWqw1gGM-00d4B1; Fri, 27
 Mar 2026 15:20:44 +0100
Date: Fri, 27 Mar 2026 15:20:42 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 3/7] Cygwin: console: Use input_mutex in the parent
 PTY in master thread
In-Reply-To: <20260325130453.62246-4-takashi.yano@nifty.ne.jp>
Message-ID: <28029d3e-e1fc-c57c-20a7-94fcc95a9112@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-4-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:S7K+rIeks5lFWdsCfaAzwJbdixBuvNVkIOIBkrttemlLO3yxFZj
 dgX2yvwkx9R8zdfhf19YN+ik/FVCwUlcPgkOcPcvd9WgeiRbmVBAQRsqAnsb2ds/vcNHCKi
 6yTUHLLW+3mN1RfDLxpkhCxizq7vFIx4mZngrvNEa71HA3l/zTw/I414jJXpePw0lQ0RIqn
 Q0vfe1qnW6s1hIMLGg2Tw==
UI-OutboundReport: notjunk:1;M01:P0:mLN7JojwpDI=;Y22FDUActzzk9fx1xeqBpOma2G5
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Mar 2026, Takashi Yano wrote:

> If the console is originating from pseudo console, the input into
> console is comming from PTY master. Therefore, input_mutex in PTY
> can be used to avoid conflicts between fhandler_pty_master::write()
> and cons_master_thread().

Nit: "comming" -> "coming".

More substantially, I think the commit message would benefit from
explaining _why_ `cons_master_thread()` and `fhandler_pty_master::write()`
can conflict. As I understand it, the mechanism is this:

When the pseudo console is active, `cons_master_thread()` runs inside
the Cygwin process that inherited the pseudo console from its parent
PTY. It reads all `INPUT_RECORD`s from the console input buffer via
`ReadConsoleInputW()`, processes signal-generating events (e.g. Ctrl+C),
and writes the remaining records back via `WriteConsoleInputW()`.
Meanwhile, the PTY master process (e.g. mintty) calls
`fhandler_pty_master::write()`, which writes keystrokes to `to_slave_nat`
(one end of the nat pipe). Conhost reads from the other end of that pipe,
parses the byte stream through its VT input path, and inserts the
resulting `INPUT_RECORD`s into the console input buffer.

If `cons_master_thread()` reads the buffer and removes a signal record
while conhost is simultaneously inserting new records from the PTY
master's write, the verify step (`inrec_eq()`) finds records in the
buffer that were not part of the original read, reports a mismatch, and
enters the fixup path. That fixup path itself can disturb the record
order, turning what was merely an interference into an actual problem.
Acquiring the PTY's `input_mutex` in `cons_master_thread()` prevents
`fhandler_pty_master::write()` from feeding new bytes into the pipe
while the read-process-writeback-verify cycle is in progress.

That reasoning is what makes this patch convincing, and I think it should
be in the commit message so that future readers do not have to
reconstruct it.

Note that the serialization is not fully airtight: even when
`cons_master_thread()` holds `input_mutex` and blocks
`fhandler_pty_master::write()` from feeding more bytes into the pipe,
conhost might still be processing bytes that are already buffered in the
pipe from a previous write. The mutex does not block conhost itself, only
the master's write end. So it reduces the window for interleaving rather
than eliminating it entirely. Is there a reason this is sufficient, or is
the remaining window small enough in practice that it does not matter?

> With this patch, use parent input_mutex
> as well as input_mutex in console device in cons_master_thread().
>=20
> Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from paren=
t pty")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 9678775d1..29cdba0d3 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -63,6 +63,7 @@ fhandler_console::console_state NO_COPY
>  static bool NO_COPY inside_pcon_checked =3D false;
>  static bool NO_COPY inside_pcon =3D false;
>  static int NO_COPY parent_pty;
> +static HANDLE NO_COPY parent_pty_input_mutex =3D NULL;
> =20
>  bool NO_COPY fhandler_console::invisible_console;
> =20
> @@ -464,6 +465,8 @@ fhandler_console::cons_master_thread (handle_set_t *=
p, tty *ttyp)
>  	  continue;
>  	}
>        total_read =3D 0;
> +      if (inside_pcon)
> +	WaitForSingleObject (parent_pty_input_mutex, mutex_timeout);



Two concerns here:

1. The mutex is acquired once but released via raw `ReleaseMutex()` at
   two separate points in `cons_master_thread()`. If any code path
   between acquisition and release exits the loop (via `break`, `goto`,
   early `return`, or a C++ exception), the mutex is left orphaned. A
   C++ destructor-based wrapper (like a scoped lock) would be safer,
   though I realize the existing codebase does not always do that.

2. If `open_input_mutex()` fails in `setup_pcon_hand_over()`,
   `parent_pty_input_mutex` is `NULL`. `WaitForSingleObject(NULL, ...)`
   returns `WAIT_FAILED`, which the code does not check, so it silently
   proceeds without holding the lock. This should at minimum be guarded
   by a `NULL` check before calling `WaitForSingleObject()`, or the
   `open_input_mutex()` failure should be handled during setup.

With the commit message expanded to explain the conflict mechanism,
and the `NULL` check added:

Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Thanks,
Johannes

>        switch (cygwait (p->input_handle, (DWORD) 0))
>  	{
>  	case WAIT_OBJECT_0:
> @@ -488,6 +491,8 @@ fhandler_console::cons_master_thread (handle_set_t *=
p, tty *ttyp)
>  	default: /* Error */
>  	  free (input_rec);
>  	  free (input_tmp);
> +	  if (inside_pcon)
> +	    ReleaseMutex (parent_pty_input_mutex);
>  	  ReleaseMutex (p->input_mutex);
>  	  return;
>  	}
> @@ -665,6 +670,8 @@ remove_record:
>  	  while (true);
>  	}
>  skip_writeback:
> +      if (inside_pcon)
> +	ReleaseMutex (parent_pty_input_mutex);
>        ReleaseMutex (p->input_mutex);
>        cygwait (40);
>      }
> @@ -1970,6 +1977,8 @@ fhandler_console::setup_pcon_hand_over ()
>  	    inside_pcon =3D true;
>  	    atexit (fhandler_console::pcon_hand_over_proc);
>  	    parent_pty =3D i;
> +	    parent_pty_input_mutex =3D
> +	      cygwin_shared->tty[i]->open_input_mutex (MAXIMUM_ALLOWED);
>  	    break;
>  	  }
>        }
> @@ -1997,6 +2006,7 @@ fhandler_console::pcon_hand_over_proc (void)
>      }
>    else
>      system_printf("Acquiring pcon_ho_mutex failed.");
> +  CloseHandle (parent_pty_input_mutex);
>    /* Do not release the mutex.
>       Hold onto the mutex until this process completes. */
>  }
> --=20
> 2.51.0
>=20
>=20
