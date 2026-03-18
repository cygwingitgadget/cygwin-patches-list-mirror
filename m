Return-Path: <SRS0=4rNz=BS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-w02.mail.nifty.com (mta-sp-w02.mail.nifty.com [106.153.228.34])
	by sourceware.org (Postfix) with ESMTPS id 9C1DE4BB3BE2
	for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 07:16:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9C1DE4BB3BE2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9C1DE4BB3BE2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773818173; cv=none;
	b=sKFpC99YmL0LZbNSM61vBesYb270RfJIO4H4qoQKHIfL+l1HlfJtPYjuM8U6Mh2CIKKkkt3SSdpf+Fdu+9KCFUM/grWh1h13H2Mm8zL12ouEhaN7F2dYoMNaZ/dD9QikgJUW/oGns6W5dzJ2KLKviRbKpBj+AfFT1ZRZSHeU9dk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773818173; c=relaxed/simple;
	bh=8QecdI4tkpiYeqd60MI72Ai79qSRI4Q/E/1wG/vwFzQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=V+0lbU0DDPngwr0NJPIvjPbZGuXw1V5rbb91uonIkNBI7+goS3Ke2xgmktxIdijsL327gpWjjBVs59e2z/l+as4HNrsfl4/s/CFDZ5p8Gkom8LKxVQbxSg82tfKFyjAyMRm54j+RyAnBOsFOk3P8IxPxK2e24IY8whUA6BLbjBM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9C1DE4BB3BE2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=A/Te+M0K
Received: from mta-snd-w07.mail.nifty.com by mta-sp-w02.mail.nifty.com
          with ESMTP
          id <20260318071610716.IOTN.26854.mta-snd-w07.mail.nifty.com@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 16:16:10 +0900
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260318071610635.SEUP.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 16:16:10 +0900
Date: Wed, 18 Mar 2026 16:16:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/4] Cygwin: pty: Remove pcon_start readahead flush that
 displaces readline data
Message-Id: <20260318161609.5ce8dc5140d82f5f30c5815a@nifty.ne.jp>
In-Reply-To: <d0936448e07081445fb24b611654741bb6020709.1772461480.git.gitgitgadget@gmail.com>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
	<d0936448e07081445fb24b611654741bb6020709.1772461480.git.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773818170;
 bh=GG7QWdXl5SRoLi7m7uPWOwUAyxELSZZWs27UZ8pdlFU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=A/Te+M0KBqWmNRc3nUnqxI+3Ebr6nvKzb+OO2SEBPXbn52sU8HlW6APV4buOdeYxD96z9I0B
 CyLMlTP3Wyon7whdMhl4M96lFRZ4pIn9t2NqBjMVroCJnmk74G7BXBj/EuoFgHltpvPEh0VWuv
 rjvbNpzHk2Zsm6XpdcYuaZZrwaS1HH0ByNKCDYYBt3UXl9AMCWKzvjixWCZ/5+cgAbFjqKmXVv
 2vr9F7Z7qpDqaGRmhKFSlwMMzBSY5R2PsN5EvHvEioNPSTKUR75Zz3Eb6OoaYtxk1cOW8wnMnI
 vNdvgwYVYqvybr1byRLDJwaBAORtqFaeZgr4VmAdLgjim1BQ==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 02 Mar 2026 14:24:38 +0000
"Johannes Schindelin wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> After the previous commit addressed the worst data-stealing code
> path, roughly one in five test iterations still shows a stray
> character.  Another transfer code path in master::write() is
> responsible.
> 
> When a native process becomes the PTY foreground, the pseudo console
> must be initialized.  During this "pcon_start" phase, master::write()
> enters a polling loop that feeds keystrokes to the nascent pseudo
> console.  When the loop completes (pcon_start becomes false), there
> was a block of code that:
> 
>   1. Flushed the master's readahead buffer via accept_input()
>   2. Called transfer_input(to_nat) to move all cyg pipe data
>      to the nat pipe
> 
> The intent was to preserve typeahead: characters typed during pcon
> initialization should eventually reach the native process.  But
> during pseudo console oscillation (the rapid pcon on/off cycles
> described in the previous commit), this fires on every pcon
> re-initialization -- and the "typeahead" it transfers includes
> readline's entire editing buffer.
> 
> Worse, if the terminal emulator was mid-way through sending a rapid
> editing sequence like "XY<BS><BS>" (type two characters, then erase
> them with backspace), the readahead flush fires after buffering "X"
> but before the backspaces arrive.  The orphaned "X" gets pushed to
> the cyg pipe via accept_input(), where readline sees it as genuine
> input -- producing a stray character that the user never intended.
> 
> Remove the accept_input() and transfer_input() calls entirely.
> Keep `pcon_start_pid = 0`, which marks the end of initialization.
> The readahead data belongs to the Cygwin process (bash is in
> canonical mode during command entry) and will be delivered naturally
> when line_edit() encounters a newline or when readline switches the
> terminal to raw mode after the foreground command exits.  The
> setpgid_aux() code path in the slave process still handles the
> steady-state cyg-to-nat transfer at process-group boundaries.
> 
> Combined with the previous commit, Git for Windows' AutoHotKey-based
> UI tests now pass cleanly in the vast majority of iterations.
> 
> Regression note: the removed code was motivated by a 2020 bug report
> about lost typeahead with native processes:
> https://inbox.sourceware.org/cygwin/7e3d947e-b178-30a3-589f-b48e6003fbb3@googlemail.com/
> Since the pcon_start window is brief (a few milliseconds) and
> setpgid_aux() handles the steady-state transfer, the risk of
> typeahead loss is low.
> 
> Addresses: https://github.com/git-for-windows/git/issues/5632
> Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index f7db43b9d..2450057c1 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2186,21 +2186,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>        if (!get_ttyp ()->pcon_start)
>  	{ /* Pseudo console initialization has been done in above code. */
>  	  pinfo pp (get_ttyp ()->pcon_start_pid);
> -	  if (get_ttyp ()->switch_to_nat_pipe
> -	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
> -	    {
> -	      /* This accept_input() call is needed in order to transfer input
> -		 which is not accepted yet to non-cygwin pipe. */
> -	      WaitForSingleObject (input_mutex, mutex_timeout);
> -	      if (get_readahead_valid ())
> -		accept_input ();
> -	      acquire_attach_mutex (mutex_timeout);
> -	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> -						  get_ttyp (),
> -						  input_available_event);
> -	      release_attach_mutex ();
> -	      ReleaseMutex (input_mutex);
> -	    }
>  	  get_ttyp ()->pcon_start_pid = 0;
>  	}
>  
> -- 
> cygwingitgadget

This patch breaks the key input for non-cygwin app in the case
that pseudo console is enabled.

Please try just:

cmd.exe {Enter}

cmd.exe cannot read key input with this patch.


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
