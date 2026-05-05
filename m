Return-Path: <SRS0=NTPj=DC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id D4EE14BA902F
	for <cygwin-patches@cygwin.com>; Tue,  5 May 2026 12:25:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D4EE14BA902F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D4EE14BA902F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1777983910; cv=none;
	b=XAocUoDe0WaWOQluMPeBNp0BfUUvdR3uHNJsFGJIPEowz+cAcbyBcS9G6UGzT3HeKkuFRTWRwt10UDzQ32UX34a9hu74XFmKH5BlYQn8mf/1LyCa186p0owQ5i4smoDECZbrchO5SI+/INs+2GczIJ706InlS1yCMhx13Qs8HsA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1777983910; c=relaxed/simple;
	bh=Lkjh2R0Sd80eNQwtoHytki80QSIG2hPLFm6oTR48378=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Tjm0M47fgzYs0RkC13c6ds/3sIcCHfr3RpuepFMK3TwrJBG21CB49HgIgCOJR6laP/PpyGFchob+gPnjOscLAsEeYTbBD8Pr4q2PCBQVhsrAJtVSUZqCx1ar+WNRlr0IT32cj47Tp60w7D5ZARNhFBU9wf/zrKBiDiRNDw0tpbg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D4EE14BA902F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pxXV9z2b
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260505122505897.GPZV.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 5 May 2026 21:25:05 +0900
Date: Tue, 5 May 2026 21:25:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: detect pcon-backed pty for
 non-Cygwin-spawned children
Message-Id: <20260505212503.fdf6b912b76c5cae97a1372c@nifty.ne.jp>
In-Reply-To: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com>
References: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1777983905;
 bh=EP+VBT/8OXRuJCV+Fppbkskpphq5zuxI8rq5EsSKAzo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=pxXV9z2bxEEFRJnmkHODH0FkGtXvWLDM2z4CWmNVnrNM25oObva3DdnlhY/4D/e3thRVG4B3
 AR+dgXuwV//vgkJ0j/XeyzJd/0Pyn104+0ls2i1B7xLfRQ2zKDHnaK9kJz/dv9G4z8WbKgBXLG
 XXtyCPQsQJpYqxbYV1KFqjtk0Wex8XaTLgL1En4KPfEJV4nBTQENiv65Q9s2TO00LhVU6ncJy1
 xE7LHIylJCGAvxtXMP3SyVbyrR7OvpC/gKV6klfbHV6Eedl/dmYgxOUkKHG3sjWDGTHsxD9OFA
 dVcscdA+SWDUKj9OuZVq9cRRAmJRpNG8alBUp88e8mXj0Ocw==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for the patch.

On Thu, 30 Apr 2026 15:04:04 +0000
"Johannes Schindelin via GitGitGadget" wrote:
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

This looks great! Let me review it.

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
> 
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index 7303f7eac..ce29f4608 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -327,7 +327,17 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
>  	dev.parse (myself->ctty);
>        else
>  	{
> -	  dev.parse (FH_CONSOLE);
> +	  /* Check whether the inherited console is actually a pseudo
> +	     console bridging a pty.  This happens when our non-Cygwin
> +	     parent was itself spawned by a Cygwin process from a pty
> +	     (e.g. bash spawning git.exe which then spawns vim).  In
> +	     that case, connect to the pty slave instead of treating
> +	     the handle as a real console. */
> +	  int pcon_minor = cygwin_shared->tty.find_pcon_pty ();
> +	  if (pcon_minor >= 0)
> +	    dev.parse (FHDEV (DEV_PTYS_MAJOR, pcon_minor));
> +	  else
> +	    dev.parse (FH_CONSOLE);
>  	  CloseHandle (handle);
>  	  handle = INVALID_HANDLE_VALUE;

The lines:
CloseHandle (handle);
handle = INVALID_HANDLE_VALUE;
are dropped in master branch. Do you think that these two lines
are necessary for this patch when applying this patch to cygwin
master branch?

>  	}
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
> index 6e70a74cd..f98059942 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -175,6 +175,10 @@ public:
>    void wait_fwd ();
>    bool pty_input_state_eq (xfer_dir x) { return pty_input_state == x; }
>    bool nat_fg (pid_t pgid);
> +  bool has_active_pcon () const
> +    { return pcon_activated && switch_to_nat_pipe; }
> +  bool has_pcon_and_owner (DWORD pid) const
> +    { return pcon_activated && switch_to_nat_pipe && nat_pipe_owner_pid == pid; }
>    friend class fhandler_pty_common;
>    friend class fhandler_pty_master;
>    friend class fhandler_pty_slave;
> @@ -193,6 +197,7 @@ public:
>    int connect (int);
>    void init ();
>    tty_min *get_cttyp ();
> +  int find_pcon_pty ();
>    int attach (int n);
>    static void init_session ();
>    friend class lock_ttys;
> diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> index c8730e81c..5cce05de3 100644
> --- a/winsup/cygwin/tty.cc
> +++ b/winsup/cygwin/tty.cc
> @@ -123,6 +123,43 @@ tty_list::init ()
>      }
>  }
>  
> +/* Search for a pty whose pseudo console owns our console.
> +   Return tty minor number or -1 if not found.
> +   Called from init_std_file_from_handle() for processes started by
> +   non-Cygwin parents to detect that inherited console handles are
> +   from a pcon-backed pty.
> +
> +   The cheap precondition (any tty with pcon active in shared memory)
> +   short-circuits the common case where no pty has a pseudo console
> +   active, avoiding the GetConsoleProcessList() LPC call entirely. */
> +int
> +tty_list::find_pcon_pty ()
> +{
> +  DWORD pids[128];
> +  DWORD count = 0;
> +  bool got_pids = false;
> +
> +  for (int i = 0; i < NTTYS; i++)
> +    {
> +      if (!ttys[i].has_active_pcon ())
> +	continue;
> +
> +      /* Fetch the console process list lazily, only on first candidate. */
> +      if (!got_pids)
> +	{
> +	  count = GetConsoleProcessList (pids, 128);
> +	  if (!count)
> +	    return -1;
> +	  got_pids = true;
> +	}
> +
> +      for (DWORD j = 0; j < count; j++)
> +	if (ttys[i].has_pcon_and_owner (pids[j]))
> +	  return i;
> +    }
> +  return -1;
> +}
> +
>  /* Search for a free tty and allocate it.
>     Return tty number or -1 if error.
>   */
> 
> base-commit: daabea98682f3f4bef0044829a8d24226135bb71
> -- 
> cygwingitgadget


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
