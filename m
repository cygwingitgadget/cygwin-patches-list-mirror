Return-Path: <SRS0=2QQm=HW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id D3CD54BA2E16
	for <cygwin-patches@cygwin.com>; Wed, 30 Sep 2026 10:33:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D3CD54BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D3CD54BA2E16
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790764404; cv=none;
	b=GFV+rmskrD/mqMi6JmZlZuoB2f6pQJRmKw3juHByTEwX1TbavlgBZEsyE2GsV8xPIpkDQQYINzN03L1LU2217C3RYTYXmTd++kHW/Rtj8RbPt1v0tPHnZ95ZHtulggEX5g4QZJMvFXG5sXOYt5vGH0uiOeDUfA2gat7gJorCsn4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790764404; c=relaxed/simple;
	bh=83zD6hxx1OtIdH+AkiFyEIvPIHofx+5X1lpt58CFzTE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LyAdDMoVjKCkqgg4Sgect/1PCElde25oa/f5rn83Ghh5NlHXs/PlRBrQq8+0o8h8EFYH4rShEU3b59pHbBFlHYLVw1yDREY37kgsRqKLQFkkzfOtmlxZAyrbZM0FlAGqCkhDGY8iUxlDasLCce1G90a4rlxnhKltjWOeOfHcMXs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=I3lcF0pt
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D3CD54BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=I3lcF0pt
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260930103317716.DWQE.102121.HP-Z230@nifty.com>;
          Wed, 30 Sep 2026 19:33:17 +0900
Date: Wed, 30 Sep 2026 19:33:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Christoph Reiter <reiter.christoph@gmail.com>, Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Cygwin: console: Avoid deadlock with app execution
 aliases
Message-Id: <20260930193316.db7fee17d3f5ac97ba4fee13@nifty.ne.jp>
In-Reply-To: <pull.11.cygwin.1790592366705.gitgitgadget@gmail.com>
References: <pull.11.cygwin.1790592366705.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790764397;
 bh=OdpOFDOCiNxnQnuReEdgSysI/C/t/DvZxGBie9as7QQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=I3lcF0ptT7BkYlIGVRs1M9wnQtQ/FPz+0I+Sl4U8QEE7IyurRF0EGBxybhFKtv3LdY1T9lHE
 z/15tSjeALiPJEBX1qoebl9t+ffDKanB59RhzvRFpLpIn7A7dvsS7gYM/D+nz6lpsnqNO9jqZZ
 udVCj1x7DIxjzE3l/APlbmJSaXBeDV0HIzIZ5W2bRezRoutHrHmdx/2W1u7v4QVPo8Pg5KC4an
 IAOrdn1w8Q3yM3QbdcP/Zp8SDeuRuB1ZoNqLDjVECwIUGsv51GE39MRPMM5UyW9cFqC79vktHO
 Yxel1jky9VFLec0PA4D5XryCWWEzSRrpaJknwKIEv03xGWWA==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Christoph, Johannes,

On Mon, 28 Sep 2026 10:46:06 +0000
"Johannes Schindelin wrote:
> From: Christoph Reiter <reiter.christoph@gmail.com>
> 
> Calling `winget.exe` through its app execution alias from an interactive
> MSYS2 shell can leave the shell hanging after `winget.exe` exits. This
> affects all app execution aliases, not only `winget.exe`.
> 
> App execution alias handling was introduced in 0631c6644e (Cygwin: Treat
> Windows Store's "app execution aliases" as symbolic links, 2021-03-22),
> and 6c3d26961d (Cygwin: termios: Handle app execution alias in
> is_console_app(), 2025-12-10) taught `is_console_app()` to follow
> aliases using another `path_conv`, which allocates cygheap memory.
> 
> 618eb90fc2 (Cygwin: console: Fix undesired mode change at exit of
> non-cygwin apps, 2026-09-19) added a second `is_console_app()` call from
> `wait_for_resume_if_necessary()`. Unfortunately, at that point,
> `child_info_spawn::worker()` already holds the non-recursive
> `cygheap_protect`, so following an alias tries to acquire the same lock
> recursively and deadlocks.
> 
> Let's avoid running `is_console_app()` under that lock by instead
> classifying the executable _once_, in `spawn_worker::setup()`, before
> acquiring the cygheap lock, then cache and reuse the result for both PTY
> setup and the post-resume wait.
> 
> Addresses: https://github.com/msys2/msys2-runtime/issues/372
> Fixes: 618eb90fc2 (Cygwin: console: Fix undesired mode change at exit
>  of non-cygwin apps, 2026-09-19)
> Signed-off-by: Christoph Reiter <reiter.christoph@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Cygwin: console: Avoid deadlock with app execution aliases
>     
>     This hang was discovered really quickly after integrating v18 of the
>     "Cygwin: console: Fix undesired mode change at exit of non-cygwin apps"
>     patch into the MSYS2 runtime. Happily, Christoph Reiter jumped at the
>     problem and came up with this patch.
>     
>     This is somewhat pressing for me, as I need to fast-track this patch
>     into Git for Windows' fork of the MSYS2 runtime because Git for Windows
>     v2.56.0 is due later today and I want to avoid shipping it with this
>     regression. This urgency does not apply to Cygwin, of course!
> 
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-11%2Fdscho%2Favoid-hang-with-app-execution-aliases-v1
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-11/dscho/avoid-hang-with-app-execution-aliases-v1
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/11
> 
>  winsup/cygwin/fhandler/termios.cc       | 10 +++++++---
>  winsup/cygwin/local_includes/fhandler.h |  5 +++--
>  winsup/cygwin/spawn.cc                  |  2 +-
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> index 423ca9ea1..8f01a8b5e 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -779,6 +779,10 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
>    fhandler_pty_slave *ptys_primary = NULL;
>    fhandler_console *cons_native = NULL;
>  
> +  /* This may resolve an app execution alias, which allocates cygheap memory.
> +     Do it before child_info_spawn::worker() acquires the cygheap lock. */
> +  console_app = !iscygwin && is_console_app (pc);
> +
>    for (int i = 0; i < 3; i ++)
>      {
>        const int chk_order[] = {1, 0, 2};
> @@ -811,7 +815,7 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
>  	    ptys->setup_locale ();
>  	  }
>      }
> -  if (!iscygwin && ptys_primary && is_console_app (pc))
> +  if (ptys_primary && console_app)
>      {
>        if (h_stdin == ptys_primary->get_handle_nat ())
>  	stdin_is_ptys = true;
> @@ -852,9 +856,9 @@ fhandler_termios::spawn_worker::is_attaching (DWORD pid)
>  
>  void
>  fhandler_termios::spawn_worker::wait_for_resume_if_necessary
> -			      (path_conv &pc, PROCESS_INFORMATION &pi)
> +			      (PROCESS_INFORMATION &pi)
>  {
> -  if (is_attaching (myself->dwProcessId) && is_console_app (pc))
> +  if (is_attaching (myself->dwProcessId) && console_app)
>      {
>        DWORD t0 = GetTickCount ();
>        while (GetTickCount () - t0 < 40 && !is_attaching (pi.dwProcessId)
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
> index 465ca2dc3..2f8049a7a 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2033,17 +2033,18 @@ class fhandler_termios: public fhandler_base
>      bool ptys_need_cleanup;
>      bool cons_need_cleanup;
>      bool stdin_is_ptys;
> +    bool console_app;
>      tty *ptys_ttyp;
>    public:
>      spawn_worker () :
>        ptys_need_cleanup (false), cons_need_cleanup (false),
> -      stdin_is_ptys (false), ptys_ttyp (NULL) {}
> +      stdin_is_ptys (false), console_app (false), ptys_ttyp (NULL) {}
>      void setup (bool iscygwin, HANDLE h_stdin, path_conv &pc,
>  		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
>      bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanup; }
>      void cleanup ();
>      bool is_attaching (DWORD pid);
> -    void wait_for_resume_if_necessary (path_conv &, PROCESS_INFORMATION &);
> +    void wait_for_resume_if_necessary (PROCESS_INFORMATION &);
>    };
>  };
>  
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 81be6e17c..37182ecb7 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -762,7 +762,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	  DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess,
>  			   NULL, 0, false, DUPLICATE_SAME_ACCESS);
>  	  ResumeThread (pi.hThread);
> -	  term_spawn_worker.wait_for_resume_if_necessary (real_path, pi);
> +	  term_spawn_worker.wait_for_resume_if_necessary (pi);
>  	}
>  
>        if (mode == _P_OVERLAY)
> 
> base-commit: 6bee3713a347ac9194f65a5c289f8f9cf2578a45
> -- 
> cygwingitgadget

Thanks for the investigation and the patch.
The patch makes perfect sense.

I'll push the patch as is.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
