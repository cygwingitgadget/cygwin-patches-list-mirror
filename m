Return-Path: <SRS0=6OSh=HO=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 225724BB1C14
	for <cygwin-patches@cygwin.com>; Tue, 22 Sep 2026 16:44:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 225724BB1C14
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 225724BB1C14
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790095456; cv=none;
	b=b6eXO4LesOQc3aUALzAYT5gWiaxmHTI5UTbZWTaTsmybQAq/KOj5lrYzV2KgBO972L5nqE8Ae388M6Acf6HKzwf6zpNCcZuko0JtJ+OcoedBceaTBwsKJnYQJe7PyJn+oJ3y2bYaLP28Z1C1QA/O5HQNXF5gsc8tIzVODBYKuog=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790095456; c=relaxed/simple;
	bh=BaRfdbdS1V91H725esSfgEf3w+BWoqiFsjhWxRG61PI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ad6ghqE/oQrjpCqeDo8XtfkPuGhjJwDQjz8PR20elxRXaQyW92b+pU29MDU+3/pspm8Irx/V6jTeFvk6clVglVmnWuHzU7z7ocIrU5kLRXW7FsYl3kRQzI5O41dYZ5hG9t6twKNbw1c/xBFzk2I6M3irFdSjmgv4XTMmb4ARyZs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=om8E9Jl6
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 225724BB1C14
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=om8E9Jl6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790095443; x=1790700243;
	i=johannes.schindelin@gmx.de;
	bh=XVBKQ2aQWU8pgnMrdElJZs8fZSP36FwBHWLuOzScubM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=om8E9Jl6CkJ3mu6abK0fb/D/zWH2+3qmV3mlsPu2q/k/R0w6028YrkgBXhvJwvNw
	 VF8LHJ/mZJ9si1ZFV9NEO1U4He2m1Bm385S96fpgO7QomTn45XBcSCD1YUtU7peEG
	 eeQz26osc24pQkYqTfXNAhQxfKNl4EM9u93MhYVDn/YeOV3/y5YMXyB3SyUx7AspO
	 iH+RYXmmUpWIAJbAE8LIuTNXndneh7v0m48ZdVhdl2Aut8D/hoeUYjrr5Ko0AcRJH
	 TobKnumFY+4h7NUvif7601Eq14bTY4PvAJtYeSWlsAOY05yjGNQwLhgjaGwX5LnsI
	 OHABggadQ5RuKxUGnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1wMTJ50cGu-00gALu; Tue, 22
 Sep 2026 18:44:03 +0200
Date: Tue, 22 Sep 2026 18:44:02 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Jay Libove Alzina <libove@felines.org>
Subject: Re: [PATCH v4] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
In-Reply-To: <20260919151641.57452-1-takashi.yano@nifty.ne.jp>
Message-ID: <cf05d989-d95b-4aff-b4d7-c9fbfcf8496b@gmx.de>
References: <20260919151641.57452-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:cKp5j9q76kL/qw/cu0bYLzQ9I6f3P0Jg57Bc49MxlUyDiCdHVym
 A5dXj3+zucaOToHuwwqyMsc53AY//dajsW5mLk4QFrmsNE1dwssna5p4956tPvS9HNmp8aa
 G7HenAmuJ5hBGwdi+L2S2AxbaMGj+m4qkmmAZrRC9S6H8epbRAYzefAMPPV+XU5CR72T3Lv
 Iz2iEGnH4kUzmPMFAByrQ==
UI-OutboundReport: notjunk:1;M01:P0:zmHjS55cEBE=;s8HfVdREerCri5/Je+SgqhN33Yg
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sun, 20 Sep 2026, Takashi Yano wrote:

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

Thank you!

About what you said in the v3 thread:

> If we mistakenly wait for an acknowledgement, it can cause a hang.

You were right to point out that continuing to wait can hang. My proposed
fixup does not solve that: if the process query keeps failing and no
worker acknowledgement arrives, it logs an inconclusive result and keeps
waiting, potentially indefinitely.

A failed query does not establish that the owner exited, though. If we
want to stop waiting in that situation, I think we should report an
explicit failure rather than silently treating the owner as dead. Since
set_disable_master_thread() currently returns void, that would require
changing both the function and its callers.

Could we discuss that choice separately from the fix for an observed owner
exit? I think we need to decide whether to keep waiting or report a
failure before changing that behavior. Avoiding the same diagnostic on
every retry is a smaller change that we can make independently.

About v4, I have a couple more things:

>=20
>  winsup/cygwin/fhandler/console.cc       | 40 +++++++++++++++++++++++--
>  winsup/cygwin/local_includes/fhandler.h |  1 +
>  2 files changed, 38 insertions(+), 3 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 2d5382c0d..140837add 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -900,7 +900,7 @@ fhandler_console::fix_input_mode_if_necessary ()
>      }
>    bool need_processed_input =3D
>      con.master_thread_suspended || con.disable_master_thread
> -    || con.need_win32_input_mode_fix;
> +    || con.need_win32_input_mode_fix || master_thread_exited (unit);
>    if (need_processed_input =3D=3D con.is_processed_input)
>      {
>        ReleaseMutex (cons_mode_mutex);
> @@ -947,7 +947,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, =
const termios *t,
>        flags |=3D ENABLE_WINDOW_INPUT;
>        con.is_processed_input =3D
>  	con.master_thread_suspended || con.disable_master_thread
> -	|| con.need_win32_input_mode_fix;
> +	|| con.need_win32_input_mode_fix || master_thread_exited (unit);
>        if (con.is_processed_input)
>  	flags |=3D ENABLE_PROCESSED_INPUT;
>        if (wincap.has_con_24bit_colors () && !con_is_legacy)
> @@ -5011,6 +5011,36 @@ fhandler_console::need_console_handler ()
>    return con.disable_master_thread || con.master_thread_suspended;

I am concerned that the Ctrl+C fallback might not reach signal delivery:
When the owner dies with both request and acknowledgment false, v4 can
enable `ENABLE_PROCESSED_INPUT`. Windows then delivers Ctrl+C as a control
event rather than queued input. But `need_console_handler()` still checks
only those two flags, so `ctrl_c_handler()` ignores the event, assuming
the missing worker will handle it.

How about extending the condition like this:

    return con.disable_master_thread || con.master_thread_suspended
	|| (con.curr_input_mode =3D=3D tty::cygwin
	    && con.is_processed_input);

This would basically handle the case where we asked Windows to handle
Ctrl+C, i.e. we want to accept Windows' notifications.

>  }
> =20
> +bool
> +fhandler_console::master_thread_exited (_minor_t unit)
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
> +      exited =3D (error =3D ERROR_INVALID_PARAMETER);

The first `=3D` is correct, but the second `=3D` needs to be a comparator:

	exited =3D (error =3D=3D ERROR_INVALID_PARAMETER);

> +    }
> +  if (error && !exited)
> +    system_printf ("Cannot query console owner %u, error %u", owner, er=
ror);
> +
> +  return exited;

Could we double-check that the owner hasn't changed here, via

	return exited && con.owner =3D=3D owner;

That way, we reject a stale result if `con.owner` no longer matches the
PID we queried. The owner can still change after the recheck, though, so
this alone does not guarantee mode changes to be serialized.

I think with these changes, my concerns would be addressed. I'd leave the
policy discussion for inconclusive queries to be continued independently
instead of trying to settle it in this patch.

Ciao,
Johannes

> +}
> +
>  void
>  fhandler_console::set_disable_master_thread (bool x, fhandler_console *=
cons)
>  {
> @@ -5026,7 +5056,11 @@ fhandler_console::set_disable_master_thread (bool=
 x, fhandler_console *cons)
>    con.disable_master_thread =3D x;
>    cons->release_input_mutex ();
>    while (con.master_thread_suspended !=3D x)
> -    Sleep (1);
> +    { /* Wait for the responce from the cons_master_thread. */
> +      if (master_thread_exited (unit))
> +	return; /* Abort */
> +      Sleep (1);
> +    }
>  }
> =20
>  int
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index e00212f57..e05156737 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2364,6 +2364,7 @@ private:
>    static void cleanup_for_non_cygwin_app (handle_set_t *p);
>    static void set_console_mode_to_native ();
>    bool need_console_handler ();
> +  static bool master_thread_exited (_minor_t unit);
>    static void set_disable_master_thread (bool x, fhandler_console *cons=
 =3D NULL);
>    static DWORD attach_console (DWORD, bool *err =3D NULL);
>    static void detach_console (DWORD, DWORD);
> --=20
> 2.51.0
>=20
>=20
