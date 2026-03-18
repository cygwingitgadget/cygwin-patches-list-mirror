Return-Path: <SRS0=4rNz=BS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-w05.mail.nifty.com (mta-sp-w05.mail.nifty.com [106.153.228.37])
	by sourceware.org (Postfix) with ESMTPS id 48AE54B9DB70
	for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 07:15:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 48AE54B9DB70
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 48AE54B9DB70
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773818159; cv=none;
	b=rq4+0LRiyUYqfsl8hWtMRYifl0dJxfnh4eLKFmAY+uWCL34tGBuEQFBi3edOU+2ZiwYc0t85cbqu5R5H2za/Hs2CgUoCdXC1wodDIDxkQkAsCedP46QoX6+BmGdtx/7dkVaqu8yoZTi2TI69EMiVjZq0Bv8IT7N3dahsQYRajKY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773818159; c=relaxed/simple;
	bh=sNg3N3KOErUfSnaYRnD6mZ3eKFqqhgbSFsp0dniDA1A=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Ud1UoTx5CygDayUN9AksUJtm9qvZSGfLdD+Jr6kmQwQd+zciGRzBZlyjlUrY7FpRFQhbUIBuNwwx76nMGtmkpQVWrM9wo6OuDcQ12NA854wTKPX7/vCKtgpegQwfyPTAIp0fUYdFc7uWKRlNY5Sh64TvLDuPYn6CeotmDxebPko=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 48AE54B9DB70
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DirRp5ew
Received: from mta-snd-w05.mail.nifty.com by mta-sp-w05.mail.nifty.com
          with ESMTP
          id <20260318071556376.HVIW.3803.mta-snd-w05.mail.nifty.com@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 16:15:56 +0900
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260318071556283.OFJH.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 16:15:56 +0900
Date: Wed, 18 Mar 2026 16:15:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] Cygwin: pty: Fix jumbled keystrokes by removing the
 per-keystroke pipe transfer
Message-Id: <20260318161555.65856d3e2e50a91dcb22d236@nifty.ne.jp>
In-Reply-To: <c7b8058842d8228a4480236f36d8de11d50c5715.1772461480.git.gitgitgadget@gmail.com>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
	<c7b8058842d8228a4480236f36d8de11d50c5715.1772461480.git.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773818156;
 bh=xLH+6SSJS5pFMabbOZWJHBx/A/lIn5qjKfRJsgHCqhY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=DirRp5ew3HBRdS8rKCRP4AiU1DGaFDJ/mXFhmxDYJURknoE40QoHq3ThCizzUr5rzUYqSK/8
 xymsu4/G5NTySaMT5b1ON7GsM/Pi4FVVMdHrnJ0AcrFIhcZrv0IgF8dFa4YO3EjcEfPAbcBmuX
 1YtclZIoHQnwEs5xgKIePftFET8ZoSoKMEAkXsyg4ZUxscg8Z+6WKpSHupqDQJ2vapV8FWU5FO
 PL4oaAOL5gHVircdrUVCNHHajUISUKgfyxp1DuxmhDlvSCJ2T2LdvFCCu1mo0Nu95RjgE/kYq5
 dYi3Uc198Dr0B292x/sNq1st4yzg4T0maOPWOjzMF+JEPAzQ==
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_ASCII_DIVIDERS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Mon, 02 Mar 2026 14:24:37 +0000
"Johannes Schindelin wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When rapidly typing at a Cygwin terminal while a native Windows
> program runs and exits (e.g. typing while a short-lived git command
> prints output in a mintty terminal), keystrokes can arrive at bash in
> the wrong order: typing "git log" may display "igt olg" or similar
> scrambled output.
> 
> Background: the pseudo console's two-pipe architecture
> ------------------------------------------------------
> 
> The Cygwin PTY maintains two independent pairs of input pipes:
> 
>   "cyg" pipe (to_slave / from_master):
>     For Cygwin processes.  The master calls line_edit(), which
>     implements POSIX line discipline (handling backspace, Ctrl-C,
>     canonical-mode buffering, echo), then accept_input() writes
>     the processed bytes to this pipe.  The Cygwin slave (e.g.
>     bash) reads from the other end.
> 
>   "nat" pipe (to_slave_nat / from_master_nat):
>     For native Windows console programs.  When the "pseudo console"
>     (abbreviated "pcon" in the code) is active, Windows' conhost.exe
>     wraps this pipe and provides the Win32 Console API
>     (ReadConsoleInput, etc.) to the native app.  The master writes
>     raw bytes directly to this pipe.
> 
> Both pipes are needed because Cygwin processes and native Windows
> programs have incompatible expectations.  Cygwin processes read
> POSIX byte streams after line discipline processing.  Native
> programs call ReadConsoleInput() for structured key-down/key-up
> events -- something a plain pipe cannot provide.
> 
> A shared-memory variable `pty_input_state` (values: to_cyg or
> to_nat) tracks which pipe currently receives new input.  The
> function transfer_input() moves pending data between the two pipes
> when the state changes.  The flag `pcon_activated` indicates whether
> a Windows pseudo console is currently running.
> 
> The problem: oscillation
> ------------------------
> 
> Each time a native program starts or exits in a PTY, the pseudo
> console activates or deactivates.  Even a single such transition --
> running git.exe and then returning to the bash prompt -- can trigger
> the bug.  The effect is amplified when transitions happen in quick
> succession (e.g. a shell script calling several short-lived native
> commands), creating many oscillation cycles:
> 
>   (1) native program starts:     pcon_activated=true, state=to_nat
>   (2) native program exits:      pcon deactivated,    state=to_cyg
>   (3) next native program:       pcon reactivated,    state=to_nat
> 
> Git for Windows' AutoHotKey-based UI tests create this pattern
> deliberately by having PowerShell invoke Cygwin utilities in a tight
> loop to achieve near-100% reproduction.
> 
> During each transition, master::write() -- which routes every
> keystroke from the terminal emulator -- must decide which pipe to
> use.
> 
> How the transfer steals readline's data
> ---------------------------------------
> 
> In master::write(), after the pcon+nat fast code path and before
> calling line_edit(), there was a code block that runs when:
> 
>   to_be_read_from_nat_pipe() is true    (a native app is "in charge")
>   && pcon_activated is false            (pcon momentarily OFF)
>   && pty_input_state is to_cyg          (input going to cyg pipe)
> 
> When all three conditions hold, it calls transfer_input(to_nat) to
> move ALL pending data from the cyg pipe to the nat pipe.  The intent
> was to handle a specific scenario where, with pseudo console
> disabled, input lingered in the wrong pipe after a Cygwin child
> exited.
> 
> The problem is that during oscillation step (2), these conditions
> are also true -- and the cyg pipe contains bash's readline buffer
> with the partially-typed command line.  On every keystroke during
> the gap, this code reads ALL of readline's buffered input out of the
> cyg pipe and pushes it into the nat pipe:
> 
>   Keystroke 'g' arrives during oscillation gap (step 2):
>        |
>        v
>   transfer_input(to_nat)         <--- reads readline's prior "it"
>        |                              from cyg pipe, writes to nat
>        v
>   line_edit('g')
>        |
>        v
>   accept_input() ---> nat pipe   <--- 'g' also goes to nat pipe
>        |
>        v
>   pcon reactivates (step 3):
>        |
>        v
>   readline reads cyg pipe, but "it" is gone -- it was moved
>   to the nat pipe.  Later keystrokes that went correctly to
>   the cyg pipe appear before the stolen ones.
> 
>   Result: "git" arrives at bash as "tgi" or similar scramble.
> 
> The fix
> -------
> 
> Remove the transfer_input() call entirely.  The original commit's
> comment says it was needed "when cygwin-app which is started from
> non-cygwin app is terminated if pseudo console is disabled."  That
> scenario is already handled by setpgid_aux() in the slave process,
> which performs the transfer at the correct moment: the process-group
> change when the Cygwin child exits.  The per-keystroke transfer in
> master::write() was redundant for that use case and catastrophic
> during oscillation.
> 
> This single change addresses the majority of the reordering (from
> "virtually every character scrambled" to roughly one stray character
> per five iterations in testing).  Subsequent commits in this series
> address the remaining code paths that can still displace readline
> data during oscillation.
> 
> Regression note: the removed code was added in response to a
> ghost-typing report where vim's ANSI escape responses appeared at
> the bash prompt after exiting vim with MSYS=disable_pcon:
> https://inbox.sourceware.org/cygwin-patches/nycvar.QRO.7.76.6.2112092345060.90@tvgsbejvaqbjf.bet/
> Since setpgid_aux() still handles the pipe transfer at process-group
> boundaries, the disable_pcon scenario is covered.  Tested with
> MSYS=disable_pcon and Git for Windows' AutoHotKey-based UI tests
> without regressions.
> 
> Addresses: https://github.com/git-for-windows/git/issues/5632
> Fixes: acc44e09d1d0 ("Cygwin: pty: Add missing input transfer when switch_to_pcon_in state.")
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 90f58671c..f7db43b9d 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2250,17 +2250,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>       or cygwin process is foreground even though pseudo console is
>       activated. */
>  
> -  /* This input transfer is needed when cygwin-app which is started from
> -     non-cygwin app is terminated if pseudo console is disabled. */
> -  if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
> -      && get_ttyp ()->pty_input_state == tty::to_cyg)
> -    {
> -      acquire_attach_mutex (mutex_timeout);
> -      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> -					  get_ttyp (), input_available_event);
> -      release_attach_mutex ();
> -    }
> -
>    line_edit_status status = line_edit (p, len, ti, &ret);
>    ReleaseMutex (input_mutex);
>  
> -- 
> cygwingitgadget

I think the commit message is based on correct understanding
of the current pseudo console and pty implementation, and well
described.

However, with this patch, please try:

1) env CYGWIN=disable_pcon mintty
2) run cmd.exe in the new mintty window
3) run cat in cmd.exe
4) press Ctrl-C to terminate cat

After 4), cmd.exe cannot read the key input.
So, I don't think this is the right thing to do.

If we adopt this patch, we need another transfer_input() call
elsewhere.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
