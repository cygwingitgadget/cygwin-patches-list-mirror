Return-Path: <SRS0=Gzk2=FK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 041AA4BA5435
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 06:24:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 041AA4BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 041AA4BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784183044; cv=none;
	b=XG4MiKSJItp1HYX14SyjfY60k12lYP704VbslzY62LR2x46JoZcOXMm1Lgpm5Hbf2DhgOo7Wx+NaU0TKQppdpgU1s/MXzYxyugq8nh6l6TxOqWF2ZTBkk8mJ2gfiRIf8FA+N9OW3HXcxL5sCMDwePaC6WnEwGHM4oH3+fKk3hT4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784183044; c=relaxed/simple;
	bh=u/5qQNgCChdihB7N9qMLhAIPm5J5ntZjbf/AIgFzaDg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=WncKfFrxbIP6lWcCnYrigPAz7YLB5OVtya9h/9+b07FJ1UTf7FAnvw/oRKuxmNFb/OaaxJzQiblY5KuB3KpEULUqvbInK2qO1c1Q7I8lxAJ0zJIC9kPm4nosUZPeg/g3F7nlToUkBYgOio8DV4nlHuMLLsVVJPXLSpMdagY3Bmc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Uan+GL9u
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 041AA4BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Uan+GL9u
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260716062402155.MMVF.3198.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 15:24:02 +0900
Date: Thu, 16 Jul 2026 15:24:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix undesired mode change at exit of
 non-cygwin apps
Message-Id: <20260716152400.dd5330c9cf1f046044e000eb@nifty.ne.jp>
In-Reply-To: <377e7867-e31c-64b6-038f-76e84046e2e5@gmx.de>
References: <20260714055956.925-1-takashi.yano@nifty.ne.jp>
	<377e7867-e31c-64b6-038f-76e84046e2e5@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784183042;
 bh=vfgRe4bPdjrQWJ9J5Ca00dnGM13u507tLY/9aypKIZs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Uan+GL9ucRz2/0GmgJ7wDOGIM3+6gnlUh/acZJXLAHzJp/hmsUyWo0/Xd4jvnCN8/cpB/rYA
 MMmFfFd89DebvijGJpXTnynqxFDqp/jKylWB6obQ8XupUDR3KcI7rQOZCkFl8eKNuQfY/63BiT
 JoSSpKz7vXa/C7ihlRLMPR0t1lQZaNbRoUBIMJ5sQNCYTF8RUEWNhsbz7s3NBV2f/PzyMC/G16
 zbwud5Na9IICZXtGt3N10uhv3Ww2+UEKDWTRv/iiZMPBtjG2VP5URiyGJ829qQYD24M9ufUiHr
 +KCRV4hLSAjePjKeMCFwtQ2KvP2BZ4di/lGBuN42xT2yaKTw==
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing the patch thoroughly. I submitted v2 patch.

As for v2 patch, 

On Wed, 15 Jul 2026 16:03:13 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 14 Jul 2026, Takashi Yano wrote:
> 
> > Previously, if two non-cygwin apps are started and one of them
> > exits first, the other one loosed appropriate console mode, since
> > the first one restored it to tty::cygwin. This patch introduce a
> > counter `non_cygwin_cnt` that counts the number of non-cygwin apps
> > currently running, and restores console mode only when the last
> > non-cygwin app exits.
> 
> Thank you for chasing this down. The underlying diagnosis is correct:
> cleanup performed by one spawning Cygwin process must not restore console
> modes while another spawned native process still requires native modes.
> However, v1 is not yet safe to apply. What is missing here is explicit
> lifetime/ownership tracking of native-mode acquisition; I found three
> concrete correctness gaps and one historical nit.

OK. Based on the v2 patch, I will review the points you raised.

> First, the counter's lifetime is unbalanced, and I can reproduce it in
> isolation. `fhandler_termios::spawn_worker::setup()` calls
> `setup_for_non_cygwin_app()`, which increments `con.non_cygwin_cnt` before
> `CreateProcessW()` runs. But `spawn_worker::cleanup()`, which decrements
> it, is never reached when `CreateProcessW()` fails, nor for `_P_NOWAIT`,
> `_P_NOWAITO`, `_P_DETACH`, or `_P_VFORK` spawn modes; those paths only
> close the duplicated handles. A failed or non-waiting `spawnl()`
> invocation therefore leaves the count permanently positive, and every
> later cleanup returns early.
> 
> I applied v1 to Git for Windows' fork of the MSYS2 runtime, built an
> isolated DLL, and reproduced this in an isolated console created with
> `CREATE_NEW_CONSOLE`: invoke a valid PE whose machine type is unsupported,
> so non-Cygwin classification succeeds but `CreateProcessW()` fails, then
> invoke a native zero-exit executable. After that second, successful
> process-spawn attempt, with v1 applied the console modes stayed at input
> `0x000000e7`, output `0x00000003`; the unpatched runtime correctly
> restored input `0x000002e8`, output `0x00000007`.

v2 patch stops counting up/down the counter by itself, but counts the
number of the foreground processes that attach to the console instead.
If one invalid non-cygwin app attempts to start, the console mode is
changed to tty::native, however, it can be restored to tty::cygwin in
bg_check().

No matter how hard we try, it is impossible to keep the count-up/count-
down consistent. This is because there is nothing we can do if a non-
cygwin app is terminated with taskkill.

> Second, the counter transition and the console-mode transition are not one
> cross-process transaction. `InterlockedIncrement`/`InterlockedDecrement`
> only serialize the integer. The current locking permits this execution
> order: the Cygwin process performing cleanup decrements 1 to 0 and is
> about to restore Cygwin modes; concurrently, the Cygwin process performing
> setup for a different spawned native process increments 0 to 1 and
> completes native-mode setup; the Cygwin process performing cleanup then
> restores Cygwin modes anyway. The counter records one outstanding
> native-mode acquisition, yet the console is back in Cygwin mode.
> 
> The separate input/output mutexes do not close this gap, since they are
> acquired after the counter operation, independently of it. This is the
> same category of issue we ran into with the PTY start/exit race: the
> decision to change state and the actual state change need one shared
> synchronization boundary.

v2 patch introduces cons_mode_mutex named "cygcons.cons_mode.mutex.0", etc.,
that protect the code block including non-cygwin process count and set_(in|
out)put_mode() calls. If two processes try to restore console mode at the
same time and both detect the process count is zero, the process which
acquires the mutex first restores the console mode, and the second one
do not restore because the following condition is not met. 
   if (con.curr_output_mode != conmode)
     set_output_mode (conmode, ti, p);
   if (con.curr_input_mode != conmode)
     set_input_mode (conmode, ti, p);

> Third, background spawned native processes are counted even though they
> never acquire native console modes: the increment in
> `setup_for_non_cygwin_app()` happens before the `if (get_ttyp()->getpgid()
> == myself->pgid)` check. A background spawned native process which never
> acquired native-mode ownership must not suppress restoration. Ownership
> acquisition must be recorded explicitly for the matching setup/cleanup
> lifetime; a process that did not change the console modes must not defer
> restoration.

In v2 patch, num_active_non_cygwin_apps() counts only the foreground
processes. So even if the background non-cygwin app exists, since it
is not counted, the console mode is closed when the last foreground
non-cygwin app is closed.

> > Fixes: 29d8a8300812 ("Cygwin: console: Rearrange set_(in|out)put_mode() calls.")
> 
> Smaller point: `Fixes: 29d8a8300812` is not the introducing commit;
> `29d8a8300812^` already has the setup/restoration for each process-spawn
> operation inline in `spawn.cc`, and that commit mostly factors it into
> helpers. The exact `tty::native`/`tty::cygwin` pairing traces back to
> `48285aa36c2c` ("Cygwin: console: Fix handling of Ctrl-S in Win7."). Worth
> pointing `Fixes:` there, or dropping the trailer if you find a more
> appropriate boundary.

Ah, you are right. Fixed in v2.

> For v2, could you pair every native-mode acquisition with its release for
> every process-spawn outcome, and fold the ownership/count decision into
> the same synchronization boundary as the master-thread/input/output mode
> transition? Whichever concrete scheme you settle on, it needs to recover
> cleanly if the spawning Cygwin process exits unexpectedly or uses a
> non-waiting spawn mode before releasing ownership.

I think, the console mode change is not necessary to be paired.
A start -> B start -> A exit -> B exit
In this case, the mode change to tty::native should be done in "A start"
and "B exit" should restore the mode. In addition, the owner (responsible 
process) is also not needed.

I expect the v2 patch will work as expected even without concepts such as
ownership or pairing.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
