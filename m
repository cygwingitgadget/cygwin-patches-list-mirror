Return-Path: <SRS0=4rNz=BS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 87BD74BB58A3
	for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 07:16:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 87BD74BB58A3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 87BD74BB58A3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773818188; cv=none;
	b=P2LOquTQV+Z7/cJht6G/IAlRFKCBCG2YATD7dS4k2s+IbwXC1iF6UdRJ2MMcGajdtB/Ovf79kYjXVvnUpN50HnGhMAjeGzoN3chl+IBQCxA/a5PSB1WzD4yo7CGwrQQ+mdwP3D78kYK+7U7qw1pm+OL6Y/I0LegM/+rnrD4sXFA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773818188; c=relaxed/simple;
	bh=D7ZFRkwiUs7+JHvtWlyLUq3hsqKdE9PPqliJnSwOHUI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EVPIxNkiywxhQN7VB8/wW44Gr7ycGwc4b24+e4QroJjrEO35vBfZ4nLOlh+LfJLH6lqOhDqVucjKcuyD0bbTY6xxOMq1S3PUmAk595tH72QkId2KGCFK/81R+t5fmnBDCCWykeLRyHATYIe3T/k/s1JwQyjZrlJ8WeKCxbDqOfY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 87BD74BB58A3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=sDAVTs3u
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260318071625613.SEWZ.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 16:16:25 +0900
Date: Wed, 18 Mar 2026 16:16:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/4] Cygwin: pty: Guard accept_input routing and flush
 stale readahead in fast path
Message-Id: <20260318161624.6ecfa0e53714a8c9704ae4c7@nifty.ne.jp>
In-Reply-To: <eba6e857a65bfab4e51a37b88d84829d8e65d5c7.1772461480.git.gitgitgadget@gmail.com>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
	<eba6e857a65bfab4e51a37b88d84829d8e65d5c7.1772461480.git.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773818185;
 bh=lsKiOh01VJfN+zDvtiaQ7bQ+8s+6FaaoDwBBmyKV6Sk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=sDAVTs3uQTZOMYDQLGMhiH0DOEj05+u3WB+NXBkeoz31Z85i8K60PBcKGNHFSJYLahyOAAuu
 MAa/o4jjzN60Xcw6FLVKzxQPEaLUl+2ycGh6gmGbBmJFwFjixmMkLEUzUcG0HOVzLCwZnQ/PsV
 igEbt47EolVVZsvg9yEmtVBSZyb/ipFGKNzC7sXlNPDTTedDeI+/55Bfus80cJ7eTwo22lUbWt
 lZcCp2kFKPJ1jwVtOh4jocrVBT5FsaZ1FG9Weoh9IROzVYpFo/LNSGIMyoLo8UtW6yw6g/+4Wg
 ArBi8cb7Ezbjsf7JSJh2T811G+8oscEUETxWnsobWd9oUy9A==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 02 Mar 2026 14:24:40 +0000
"Johannes Schindelin wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This final commit in the series addresses two remaining edge cases
> where characters can escape through unintended routing during pseudo
> console oscillation.
> 
> Part 1: accept_input() routing guard
> -------------------------------------
> 
> accept_input() writes data from the readahead buffer to one of the
> two PTY input pipes.  Its routing condition was:
> 
>   if (to_be_read_from_nat_pipe()
>       && pty_input_state == to_nat)
>     write_to = to_slave_nat;   /* nat pipe */
>   else
>     write_to = to_slave;       /* cyg pipe */
> 
> A comment in the code documents the intention: "This code is reached
> if non-cygwin app is foreground and pseudo console is NOT enabled."
> 
> But the condition does not actually check pcon_activated.  During
> pseudo console oscillation, accept_input() can route data to the
> nat pipe even while the pseudo console IS active.  When pcon is
> active, input for native processes flows through conhost.exe, not
> through direct pipe writes.  Routing data to the nat pipe via
> accept_input() during pcon activation either duplicates what
> conhost already delivers or displaces data that should have stayed
> in the cyg pipe.
> 
> Add `&& !pcon_activated` to make the code match its own documented
> invariant.
> 
> Part 2: readahead flush in the pcon+nat fast code path
> ------------------------------------------------------
> 
> The pcon+nat fast code path in master::write() handles the common
> case where a native app is in the foreground with pcon active.  It
> writes keystrokes directly to the nat pipe via WriteFile(), bypassing
> line_edit() entirely.
> 
> If a previous call to master::write() went through line_edit()
> (because pcon was momentarily inactive during oscillation),
> line_edit() may have left data in the readahead buffer via
> unget_readahead().  Without flushing this stale readahead, it
> persists until the next line_edit() call, at which point
> accept_input() emits it -- potentially after newer characters that
> went through the fast code path, breaking chronological order.
> 
> Add an accept_input() call at the top of the pcon+nat fast code path
> to flush any stale readahead before the current keystroke is written
> via WriteFile().
> 
> Together with the three preceding commits, this eliminates the
> character reordering reported in git-for-windows/git#5632.
> 
> Addresses: https://github.com/git-for-windows/git/issues/5632
> Fixes: 3d46583d4fa8 ("Cygwin: pty: Update some comments in pty code.")
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index dd7ea9038..fcff53d88 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -489,6 +489,7 @@ fhandler_pty_master::accept_input ()
>    HANDLE write_to = get_output_handle ();
>    tmp_pathbuf tp;
>    if (to_be_read_from_nat_pipe ()
> +      && !get_ttyp ()->pcon_activated
>        && get_ttyp ()->pty_input_state == tty::to_nat)
>      {
>        /* This code is reached if non-cygwin app is foreground and
> @@ -2208,8 +2209,18 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>    WaitForSingleObject (input_mutex, mutex_timeout);
>    if (to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
>        && get_ttyp ()->pty_input_state == tty::to_nat)
> -    { /* Reaches here when non-cygwin app is foreground and pseudo console
> -	 is activated. */
> +    {
> +      /* Flush any stale readahead data from a prior line_edit call that
> +	 ran while pty_input_state was temporarily to_cyg (e.g. during a
> +	 setpgid_aux transition when a cygwin child of the native process
> +	 started or exited).  Without this, the readahead contents would
> +	 be stranded and emitted after the direct WriteFile below,
> +	 breaking chronological order. */
> +      if (get_readahead_valid ())
> +	{
> +	  accept_input ();

Does the code path really reach here?
At the end of pcon_start phase, accept_input() is already called as
shown below. After that, transfer_input (tty::to_nat, ...) is called.
Therefore, in the pcon_activated state, all key input will go to nat-
pipe, not to readahead-buffer/cyg-pipe.

      if (!get_ttyp ()->pcon_start)
        { /* Pseudo console initialization has been done in above code. */
          pinfo pp (get_ttyp ()->pcon_start_pid);
          if (get_ttyp ()->switch_to_nat_pipe
              && pp && pp->pgid == get_ttyp ()->getpgid ()
              && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
            {
              /* This accept_input() call is needed in order to transfer input
                 which is not accepted yet to non-cygwin pipe. */
              WaitForSingleObject (input_mutex, mutex_timeout);
              if (get_readahead_valid ())
                accept_input ();                   // <========== This
              acquire_attach_mutex (mutex_timeout);
              fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
                                                  get_ttyp (),
                                                  input_available_event);
              release_attach_mutex ();
              ReleaseMutex (input_mutex);
            }
          get_ttyp ()->pcon_start_pid = 0;
        }

What situation do you assume? Is there any case that the key input goes
into cyg-pipe during pcon_activated other than mask_switch_to_nat_pipe()
case?

> +	}
> +
>        tmp_pathbuf tp;
>        char *buf = (char *) ptr;
>        size_t nlen = len;
> -- 
> cygwingitgadget


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
