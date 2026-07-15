Return-Path: <SRS0=mCfc=FJ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 541BB4BA2E0C
	for <cygwin-patches@cygwin.com>; Wed, 15 Jul 2026 14:03:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 541BB4BA2E0C
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 541BB4BA2E0C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784124204; cv=none;
	b=MWXvm6pNNnMIM3ETLiSktlU43z4IO0MuMSUH+qaKrTF73SBGtz45xEDKzHEI8vFd0eu8wdLVIHvoH5gK/gQSuId8UHiou0p/3csttuonPq+UW8lBFEey5bOYY5aVL7oGLhPXBMytf0p8edG6Frl+DkydFPkWGz0ByifJpwFz+1k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784124204; c=relaxed/simple;
	bh=/D69t15sPnvNveUjsa5Aqg5iVkL2E10AhxK6WrQf2tU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ISYK01z3z/UiczMc/J50DtUxNyDE2WSVGvFQ6T89veZ6PNAVUBMbjlh78QV7GGzm5vsTgE3lxiibeKw/92f8S45a8kO2EVRZ0U9I3E5WHK0MYDaIIX5LwipwIXkNTPF8iO/CxjwmmDM5WGvNXYVIdbmuM44o1zK3/PQl8lisPy0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=mBQEuGVg
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 541BB4BA2E0C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=mBQEuGVg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784124195; x=1784728995;
	i=johannes.schindelin@gmx.de;
	bh=6saVq45lnu+WGe+2+0CrdhoxYMekM0m8ugoAel59Owk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mBQEuGVg3UqbizXvAHv6Zwg0OrrsW6Q96grdjUAQa8bGswe29mZrvujR60zlvSgj
	 r/rVsvlJWZrIMjU0Jxp2w+E9kCaq2ggtJimmqDUyOqw1yYSACBoY4SEd4GBjMB2dY
	 0Mr1dSHTLtKSMjfK+DCAbSQQm8fDwDMTmRKzPux/24C0S0ehijflP21FeVFSMrMVp
	 kO9lAzWf99jiBfrqRorhBCUC6YYmWjIyRGEJZOmPU81o+eEgO7aNceO9T5o+l5amn
	 i417LPXLj64ZPvetRh4pl1rWu5q8NZjEvuKctgWK9GjqeJUpHngiVJ99DM+ZY1wGZ
	 HG9uLlpHPiHjXhsZiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1xBkO81Wh9-018N8d; Wed, 15
 Jul 2026 16:03:15 +0200
Date: Wed, 15 Jul 2026 16:03:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix undesired mode change at exit of
 non-cygwin apps
In-Reply-To: <20260714055956.925-1-takashi.yano@nifty.ne.jp>
Message-ID: <377e7867-e31c-64b6-038f-76e84046e2e5@gmx.de>
References: <20260714055956.925-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:acET/8PRGrVavA7NlVfO0R0tw3oj7BKWgOkH3IibHMKlpU3RfO+
 e2Jhq76TiWaBFVSZ5slfLJxAMkL0jqnuQYUCxGXQcD8esBK2zksUNlTHR694gyMZ/rJHqWQ
 MLQI5hoPzpIg/4cqmLIQBuYAjRTpkdGnEaiteidA6YOVcMTTSXtORra6z6oTPSU9xvXngM5
 vJJWtUiR9ouwxeEG4UclQ==
UI-OutboundReport: notjunk:1;M01:P0:zXOAyswKWvk=;xKFmKyl1dAAify3a495wxNWAAQE
 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
 lDw91Ep7YI0pLLRbeU1P6
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 14 Jul 2026, Takashi Yano wrote:

> Previously, if two non-cygwin apps are started and one of them
> exits first, the other one loosed appropriate console mode, since
> the first one restored it to tty::cygwin. This patch introduce a
> counter `non_cygwin_cnt` that counts the number of non-cygwin apps
> currently running, and restores console mode only when the last
> non-cygwin app exits.

Thank you for chasing this down. The underlying diagnosis is correct:
cleanup performed by one spawning Cygwin process must not restore console
modes while another spawned native process still requires native modes.
However, v1 is not yet safe to apply. What is missing here is explicit
lifetime/ownership tracking of native-mode acquisition; I found three
concrete correctness gaps and one historical nit.

First, the counter's lifetime is unbalanced, and I can reproduce it in
isolation. `fhandler_termios::spawn_worker::setup()` calls
`setup_for_non_cygwin_app()`, which increments `con.non_cygwin_cnt` before
`CreateProcessW()` runs. But `spawn_worker::cleanup()`, which decrements
it, is never reached when `CreateProcessW()` fails, nor for `_P_NOWAIT`,
`_P_NOWAITO`, `_P_DETACH`, or `_P_VFORK` spawn modes; those paths only
close the duplicated handles. A failed or non-waiting `spawnl()`
invocation therefore leaves the count permanently positive, and every
later cleanup returns early.

I applied v1 to Git for Windows' fork of the MSYS2 runtime, built an
isolated DLL, and reproduced this in an isolated console created with
`CREATE_NEW_CONSOLE`: invoke a valid PE whose machine type is unsupported,
so non-Cygwin classification succeeds but `CreateProcessW()` fails, then
invoke a native zero-exit executable. After that second, successful
process-spawn attempt, with v1 applied the console modes stayed at input
`0x000000e7`, output `0x00000003`; the unpatched runtime correctly
restored input `0x000002e8`, output `0x00000007`.

Second, the counter transition and the console-mode transition are not one
cross-process transaction. `InterlockedIncrement`/`InterlockedDecrement`
only serialize the integer. The current locking permits this execution
order: the Cygwin process performing cleanup decrements 1 to 0 and is
about to restore Cygwin modes; concurrently, the Cygwin process performing
setup for a different spawned native process increments 0 to 1 and
completes native-mode setup; the Cygwin process performing cleanup then
restores Cygwin modes anyway. The counter records one outstanding
native-mode acquisition, yet the console is back in Cygwin mode.

The separate input/output mutexes do not close this gap, since they are
acquired after the counter operation, independently of it. This is the
same category of issue we ran into with the PTY start/exit race: the
decision to change state and the actual state change need one shared
synchronization boundary.

Third, background spawned native processes are counted even though they
never acquire native console modes: the increment in
`setup_for_non_cygwin_app()` happens before the `if (get_ttyp()->getpgid()
=3D=3D myself->pgid)` check. A background spawned native process which nev=
er
acquired native-mode ownership must not suppress restoration. Ownership
acquisition must be recorded explicitly for the matching setup/cleanup
lifetime; a process that did not change the console modes must not defer
restoration.

>=20
> Fixes: 29d8a8300812 ("Cygwin: console: Rearrange set_(in|out)put_mode() =
calls.")

Smaller point: `Fixes: 29d8a8300812` is not the introducing commit;
`29d8a8300812^` already has the setup/restoration for each process-spawn
operation inline in `spawn.cc`, and that commit mostly factors it into
helpers. The exact `tty::native`/`tty::cygwin` pairing traces back to
`48285aa36c2c` ("Cygwin: console: Fix handling of Ctrl-S in Win7."). Worth
pointing `Fixes:` there, or dropping the trailer if you find a more
appropriate boundary.

For v2, could you pair every native-mode acquisition with its release for
every process-spawn outcome, and fold the ownership/count decision into
the same synchronization boundary as the master-thread/input/output mode
transition? Whichever concrete scheme you settle on, it needs to recover
cleanly if the spawning Cygwin process exits unexpectedly or uses a
non-waiting spawn mode before releasing ownership.

Ciao,
Johannes

> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc       | 4 ++++
>  winsup/cygwin/local_includes/fhandler.h | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index d4c87f29f..474e169ea 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -841,6 +841,7 @@ fhandler_console::setup ()
>        con.num_processed =3D 0;
>        con.curr_input_mode =3D tty::restore;
>        con.curr_output_mode =3D tty::restore;
> +      con.non_cygwin_cnt =3D 0;
>      }
>  }
> =20
> @@ -975,6 +976,7 @@ fhandler_console::setup_for_non_cygwin_app ()
>       in background, tty settings of the shell is reflected
>       to the console mode of the app. So, do not change the
>       console mode. */
> +  InterlockedIncrement (&con.non_cygwin_cnt);
>    if (get_ttyp ()->getpgid () =3D=3D myself->pgid)
>      {
>        set_disable_master_thread (true, this);
> @@ -987,6 +989,8 @@ void
>  fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
>  {
>    const _minor_t unit =3D p->unit;
> +  if (InterlockedDecrement (&con.non_cygwin_cnt) !=3D 0)
> +    return;
>    termios dummy =3D {0, };
>    termios *ti =3D shared_console_info[unit] ?
>      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index d11b3ec4f..eafb7c581 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2082,6 +2082,7 @@ class dev_console
>    DWORD owner;
>    bool is_legacy;
>    bool orig_virtual_terminal_processing_mode;
> +  LONG non_cygwin_cnt;
> =20
>    WORD default_color, underline_color, dim_color;
> =20
> --=20
> 2.51.0
>=20
>=20
