Return-Path: <SRS0=3SWy=EU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 400924BA5434
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 13:13:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 400924BA5434
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 400924BA5434
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782306782; cv=none;
	b=NbRWJ81GVk6kDUCtD/6nNPey/uphAn+Mwq2RAfZTgtEqNA+Glk9jAzHJn2eNwK2xKDx9oh4R+IlbOOPAuHFnoAZYrRNSV3Wt5IFuysUIYW9Gk/qHJCs0JNOpkbiLtp6I5DhhNGdbcyXi1iAwQzbvZwPt7RwPwnMpsoYaQoDPu+s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782306782; c=relaxed/simple;
	bh=///gwYM3tXfZTlPGYUEheQJE7v671EHiHbpv7Stilh4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=vUWWK+MrJT/PoPdbXbNleqVnZidJbQFLd+lJKDpwN6nPffFHRRSR0Rh9XOj29Bz64Svk9NaqQyqiVCc6eWRp4QsxQZSFFNwWRWHhPJDQRCDjQCS/Qqf/Jn1cOBTOOvycsrGH4/yWBp8q9SpiLhhsWa2CX8GvdHvCLT1NmHYsSTM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gl6DO1Da
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 400924BA5434
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gl6DO1Da
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260624131259318.FMKN.17441.HP-Z230@nifty.com>;
          Wed, 24 Jun 2026 22:12:59 +0900
Date: Wed, 24 Jun 2026 22:12:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] Cygwin: pty: detect pcon-backed pty for
 non-Cygwin-spawned children
Message-Id: <20260624221256.e474f94cc223fcb13ab7db61@nifty.ne.jp>
In-Reply-To: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com>
References: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782306779;
 bh=zDVkbhS+GjjQw9w8UHf+iQZ1jjk7DNKpe+lBZN1U5oo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=gl6DO1DawVkb911AkF6S/WSaiQB1TDYSJ8fohkTjVPGGggAr3bZ7z3VpvplIWW4ZtwDd9BcB
 XAjYqWXK8rdl2AXFn75ew14EBAfWrfpwj9VC7JFuz0paxIH6u07DxXxGUHvmwdvMofB3sVSBQq
 s0mwcjCkZ8K9jV1FvgaVqg0ekxG6/01H0j7D4HtkvmSi0j+mVFXcKDiOnVZMomZKSE6RpGzcHd
 lbtbRmHa/nAUNJ1F3FVemezvDfjHbvmjyrefg0sXTOHQVb+nA/0ASlwi2kp0AjjgSEZ6PQa2Ut
 SV+5Il1Slk9l6Ctia3znjWVhXeUeKWwNEL2OGtohGFR5sLEA==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 30 Apr 2026 15:04:04 +0000
"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When a Cygwin process (e.g. `bash` under MinTTY) spawns a native
> Win32 child (e.g. `git.exe`) with pseudo console support enabled,
> the child gets a pseudo console that bridges the pty. If that native
> child then spawns a Cygwin grandchild (e.g. `vim`, `less`), the
> grandchild inherits the pseudo console's console handles. In
> `init_std_file_from_handle()`, the grandchild's msys2-runtime sees
> `GetConsoleScreenBufferInfo()` succeed on those handles and, with
> no valid `ctty` set, falls back to `FH_CONSOLE` and gives the
> process `cons0` instead of connecting to the pty.
> 
> This causes scrollback clobbering in MinTTY because alternate screen
> sequences (`ESC[?1049h` / `ESC[?1049l`) are handled by
> `fhandler_console`'s `save_restore()` against the pseudo
> console's buffer, which has no correspondence to MinTTY's scrollback.
> 
> Fix this in the existing console branch of
> `init_std_file_from_handle()`: when there is no valid `ctty` and
> we are about to fall back to `FH_CONSOLE`, first scan the shared
> tty table for an entry whose `pcon_activated` is set and whose
> `nat_pipe_owner_pid` is in our console's process list (via
> `GetConsoleProcessList`). If found, parse the device as that pty
> slave instead of as a real console. The handle is closed in either
> fallback path, matching the existing `FH_CONSOLE` behavior.
> `myself->ctty` is left untouched; the regular
> `fhandler_pty_slave::open_setup()` path will set it via
> `myself->set_ctty()` when the pty slave is opened.
> 
> The structure of `find_pcon_pty()` matters and is easy to get
> wrong in case a keen developer would like to refactor this code in
> the future. This code runs on every Cygwin process startup whose
> parent is non-Cygwin, so the common path (no pty with an active
> pseudo console) must remain free of expensive operations. Two
> pitfalls to avoid: filtering tty entries with `tty::exists()`
> looks correct but creates and destroys a named pipe per entry
> (128 entries on every call), and hoisting the
> `GetConsoleProcessList()` call out of the loop pays the
> cross-process cost even when no candidate exists. The current
> shape, a cheap shared-memory boolean check first and a lazily
> fetched process list only on the first candidate, keeps the
> common case at a handful of pointer reads.
> 
> Reported downstream at https://github.com/git-for-windows/git/issues/5303
> and bisected to a Git for Windows release that upgraded the bundled
> msys2-runtime from 3.3.6 (no pseudo console code) to 3.4.6 (the new
> pseudo console architecture).
> 
> Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
> Assisted-by: Claude Opus 4.7 (1M context)
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Detect pcon-backed pty for non-Cygwin-spawned children
>     
>     A Git for Windows user reported that vim (or less, when paging git
>     output) clobbers the visible scrollback in MinTTY when invoked through
>     git.exe: https://github.com/git-for-windows/git/issues/5303
>     
>     Their bisect, with great patience across 60+ Git for Windows installer
>     reinstalls, narrowed the regression to the v2.40.1 -> v2.41.0
>     transition, which corresponds to the msys2-runtime upgrade from 3.3.6 to
>     3.4.6, i.e. the introduction of Takashi's pseudo console architecture
>     (bb4285206207). The user's diagnostic ps -f from inside vim showed the
>     editor on cons0 rather than pty0.
>     
>     I confirmed the root cause locally: with CYGWIN=disable_pcon the editor
>     lands on pty0 and the scrollback survives, with the default (pcon
>     enabled) it lands on cons0 and the alternate screen save/restore happens
>     against the pseudo console buffer, which has no relationship to MinTTY's
>     scrollback. The issue is reproducible without vim using a tiny
>     diagnostic GIT_EDITOR:
>     
>     GIT_EDITOR='sh -c "ps -f >&2; cat \"\\"" _' \
>         git commit --allow-empty --amend --allow-empty
>     
>     
>     The sh and ps show up on cons0; with disable_pcon, on pty0. The same
>     symptom occurs whenever any native console application spawns Cygwin
>     children, git.exe is just by far the most common case in practice.
>     
>     The patch teaches init_std_file_from_handle() that an inherited console
>     handle from a non-Cygwin parent might actually be a pseudo console
>     bridging a pty, and to connect to the pty slave in that case rather than
>     falling back to cons0. The mechanism, the alternative I considered, and
>     the performance considerations for the new shared-memory scan are all in
>     the commit message.
>     
>     The same patch is also applied downstream at
>     https://github.com/git-for-windows/msys2-runtime/pull/131 so Git for
>     Windows users can get the fix ahead of the next Cygwin release, but this
>     PR is the authoritative version intended for cygwin-3_6-branch.
> 
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-7%2Fdscho%2Fpcon-fix-cygwin-v1
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-7/dscho/pcon-fix-cygwin-v1
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/7
> 
>  winsup/cygwin/dtable.cc            | 12 +++++++++-
>  winsup/cygwin/local_includes/tty.h |  5 ++++
>  winsup/cygwin/tty.cc               | 37 ++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
[...]

Pushed to master branch with my fixup patches.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
