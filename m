Return-Path: <SRS0=4mOZ=BT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id D15864BBCDD1
	for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 10:50:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D15864BBCDD1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D15864BBCDD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773917439; cv=none;
	b=B/i51g+4CTHJ7BBB2ylbzorOsGxp5k9C9YxrBb/CRO5VnT1GKOBWYSxtuR9tSHJF7d+sCwGPlm0M3gtSsa11ixgXRuGHEYi2Aa+Yp/Cr1KRpZHfPf3QTe9Kx7NOV7kDehedreDo0tF8B0mwPxCCSlMbgQm7gDqRmRCtq/7ynoRk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773917439; c=relaxed/simple;
	bh=+DvAA2wa9+OskhNE3aFmTyL8gPs6eB3bdlWV2g/PALY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ghjKtdKceL9UwDFFB/bIhHxfrp5xGydmVjj4fPRXVJaE/PCl1JR2Gp/GJP+buHH+gLNlMDi8PX8ORSyNVui/ASpJskCAMLIWNcfRJ7TOmX8UiWPQySMTjUAP4Sh86xT8BiR0kLQ8lGEzWRb5dHG8CsM9dvxZFoXlM44sXOIgr/Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D15864BBCDD1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pTsBzZ6Y
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260319105036758.LONA.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 19:50:36 +0900
Date: Thu, 19 Mar 2026 19:50:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/4] Cygwin: pty: Prevent premature pseudo console
 teardown that amplifies oscillation
Message-Id: <20260319195034.3163d17156ea28240fb08034@nifty.ne.jp>
In-Reply-To: <62e2d1178e28aa525c73ce1fd8a5dd03c9931e9e.1772461480.git.gitgitgadget@gmail.com>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
	<62e2d1178e28aa525c73ce1fd8a5dd03c9931e9e.1772461480.git.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773917436;
 bh=BzsomY7v7N+ElnGQKnx1dg9xmPNo9jam3bSrlXxgU/k=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=pTsBzZ6YRS6ODE2P3AN50HTIMa672/ZmEprGdt3wNNt3P94FLY4jeMjOFLIQPM4994YoQ1Kz
 nCF7lPEiQ5z34n6hXTPmSYEXPycI190osZyW/dx0lO8PFNR/ecnH2sDBBKqxtcrJcrImLTFtNW
 9GY2C5yqIU17bXUUtAAFRvcWABnXYD2cCu3GH62oKpCVLmnJjSdvErLI8/vrYfv6CClI1CmNXT
 z+ThZezyineEBzzbKt8WCHtklvmIlEm0xmrjyDbOeal0nkQYJn/hnDyffLDdmXuQvePSIL9/1F
 EKoVq9mGTbLinRTGjzKgCJmXAMNNwEGiwzPLLgf4A/rl6n8A==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Mon, 02 Mar 2026 14:24:39 +0000
Johannes Schindelin wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The two preceding commits removed transfer code paths that stole
> readline's data during pseudo console oscillation.  This commit
> addresses the oscillation itself: a guard function that tears down
> active pseudo console sessions prematurely, causing more frequent
> oscillation cycles and thus more opportunities for the remaining
> (less harmful) timing issues to manifest.
> 
> The function reset_switch_to_nat_pipe() runs from bg_check() in the
> slave process.  Its purpose is to clean up the nat pipe state when
> no native process is using the pseudo console anymore.  Its guard
> logic was:
> 
>   if (!nat_pipe_owner_self(pid) && process_alive(pid))
>     return;   /* someone else owns it, don't reset */
>   /* fall through to destructive cleanup: clear pty_input_state,
>      nat_pipe_owner_pid, switch_to_nat_pipe, pcon_activated */
> 
> The nat_pipe_owner_pid is set to bash's own PID during
> setup_for_non_cygwin_app() (because bash is the process that calls
> exec() to launch the native program).  When bg_check() runs and
> calls reset_switch_to_nat_pipe(), nat_pipe_owner_self() returns
> true -- the first condition becomes false, the && short-circuits,
> and the function falls through to the destructive cleanup.  It
> clears pcon_activated, switch_to_nat_pipe, pty_input_state, and
> nat_pipe_owner_pid -- even though the native process is still
> alive and actively using the pseudo console.
> 
> This forced every subsequent code path to re-initialize the pseudo
> console from scratch, creating exactly the rapid oscillation
> described in the earlier commits.
> 
> Restructure the guard into two separate checks:
> 
>   if (process_alive(pid))
>     {
>       if (!nat_pipe_owner_self(pid))
>         return;   /* someone else owns it */
>       if (pcon_activated || switch_to_nat_pipe)
>         return;   /* we own it, but session is still active */
>     }
>   /* fall through: owner died or session ended */
> 
> When a different process owns the nat pipe, the behavior is
> unchanged.  When bash itself is the owner, the function now also
> returns early if pcon_activated or switch_to_nat_pipe is still set.
> Both flags are checked because during pseudo console handovers
> between parent and child native processes, pcon_activated is
> briefly false while switch_to_nat_pipe remains true.
> 
> The cleanup still runs when it should: when the owner process has
> exited or when both flags indicate the session has truly ended.
> 
> Regression note: this change is strictly more conservative -- it
> adds conditions that prevent cleanup, never removes them.  Every
> scenario where the original code returned early still returns early.
> 
> Addresses: https://github.com/git-for-windows/git/issues/5632
> Fixes: 919dea66d3ca ("Cygwin: pty: Fix a race issue in startup of pseudo console.")
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 2450057c1..dd7ea9038 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1171,12 +1171,23 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
>    DWORD wait_ret = WaitForSingleObject (pipe_sw_mutex, mutex_timeout);
>    if (wait_ret == WAIT_TIMEOUT)
>      return;
> -  if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid)
> -      && process_alive (get_ttyp ()->nat_pipe_owner_pid))
> +  if (process_alive (get_ttyp ()->nat_pipe_owner_pid))
>      {
> -      /* There is a process which owns nat pipe. */
> -      ReleaseMutex (pipe_sw_mutex);
> -      return;
> +      if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
> +	{
> +	  /* There is a process which owns nat pipe. */
> +	  ReleaseMutex (pipe_sw_mutex);
> +	  return;
> +	}
> +      /* We are the nat pipe owner.  Don't reset while a native process
> +	 is still using the nat pipe -- check both pcon_activated and
> +	 switch_to_nat_pipe since the latter stays true during pcon
> +	 handovers when pcon_activated is briefly false. */

In what situation does the code path reach here?
Normal cygwin process usually cannot be a nat_pipe_owner.
Two exceptions are:
 1. GDB with non-cygwin inferior
 2. stub process for non-cygwin app

The stub process never calls reset_switch_to_nat_pipe(), therefore
we should consider only of GDB. However, the code for GDB exists
at the begining of reset_switch_to_nat_pipe().
(See 'if (h_gdb_inferior)' block.)

So, simplly

  if (process_alive (get_ttyp ()->nat_pipe_owner_pid))
    {
      /* There is a process which still owns nat pipe. */
      ReleaseMutex (pipe_sw_mutex);
      return;
    }

might be enough. Am I overlooking something?

> +      if (get_ttyp ()->pcon_activated || get_ttyp ()->switch_to_nat_pipe)
> +	{
> +	  ReleaseMutex (pipe_sw_mutex);
> +	  return;
> +	}
>      }
>    /* Clean up nat pipe state */
>    get_ttyp ()->pty_input_state = tty::to_cyg;
> -- 
> cygwingitgadget
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
