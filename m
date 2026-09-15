Return-Path: <SRS0=CxYQ=HH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id B28444BA79BA
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 12:33:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B28444BA79BA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B28444BA79BA
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789475583; cv=none;
	b=cypcwzJvhONpJOj4Lde6CQjIz6qzlJNTW/fOq623kgPJQhQRpSwzUw96HhGO3x2KHfBgYpbninlSrQheJauPSLe4dmGnEeLBzWijhakv7VnoypSW21H9FaYMYHKR+UVp5dHW9xkx1cN5YjRr8lQ8VLhL+Jw7mv8LSTcou5l5ndE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789475583; c=relaxed/simple;
	bh=nP/DBgf68qXwEXzwt0+rz2qJXKUSOJ7uDkt47Hn0FSo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=B/Qinr7Fskv8LV+VhuoheWB0AvpjbJsujsUr3TRMZTQJBIZEnXOcaU+Mf9kqzVeKbpuiF8fFw6WFJJ6N2LPSgq7SqxqDC4evR/BMVueGmvP3NhZ3TAekg6oq2g1MzBthh6lgA7wCdRGgUDY4VyCJBv+s39G7qvDnYcBMGOnNOZw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OYirnNhg
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B28444BA79BA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OYirnNhg
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260915123259426.MUXG.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 21:32:59 +0900
Date: Tue, 15 Sep 2026 21:32:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: preserve terminal replies after PTY
 adoption
Message-Id: <20260915213259.fd24c38cac2c2adafdd2b097@nifty.ne.jp>
In-Reply-To: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789475579;
 bh=cCcgLvAug74AAE6Ucj5cgt80ruYgNy5lo8oRuMBrE9M=;
 h=Date:From:To:Subject:In-Reply-To;
 b=OYirnNhgNjNBRUhRkwJlJRmYDj8maAXVfCh7QNnE/JUoCw/7e8vez8GMAePBdQRIjIkIh4TQ
 yf38p5kZYfGL7SRYIEhFJ2+7PTCnhK73ldbhTMbJ2Od90oP40CGEg4BIqGkse+QACjD42vH5J7
 Kp2lMg1ukqcq/Ijlc+avrirMRpQiP4zkr3lDzHJKqaX0UZEM2r5nyrmTed5V4Mn4tviGo1u+st
 qGW3u76NauId8iPIgw383VaxUJvA8JTVmCk4i2gUVUxr70IaMXyONu5k1KLsnJzE4igfUcxtss
 6/h0HH/1jfsoCFGJAj7EZOrePXJ2w7BDNHXrZbr3zstuhNtQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for the patch.

On Sun, 13 Sep 2026 12:30:05 +0000
"Johannes Schindelin wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This fixes an issue reported about MSYS2/Win32 interaction, but applies
> to regular Cygwin as well. In the following, the original scenario is
> described.
> 
> MSYS Vim launched by native Git from Bash in MinTTY can delete the first
> line, enter Insert mode or insert RGB text at startup. PTY adoption sends
> Vim's output directly to MinTTY, but input stays with ConHost until the
> first Cygwin read/select. Vim inherits Git's foreground process group, so
> the process-group callback does not trigger an earlier handoff.
> 
> Vim sends terminal queries before reading. ConHost interprets cursor
> position reports as function keys, which the later input transfer delivers
> to Vim as keystrokes. A color reply split across the handoff reaches Vim
> without its introducer. Fragmented writes are valid; inconsistent routing
> corrupts their contents.
> 
> Requesting noncanonical input with tcsetattr() provides a control point
> before these queries. Handing input to the Cygwin PTY there aligns both
> directions before replies can be misdirected, rather than waiting for
> consumption. Only the foreground process on an active pseudoconsole takes
> this path; canonical, background and pcon-disabled calls are unaffected.
> 
> The existing synchronized transfer preserves queued input and line
> discipline. Balancing the temporary reader registration without transferring
> back keeps input on the Cygwin pipe without a permanent reader claim or
> changes to native-owner cleanup. Releasing the output mutex first avoids
> holding it across the input-transfer path.
> 
> Addresses: https://github.com/git-for-windows/git/issues/6403
> Fixes: 6eed1ef74869 ("Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned children")
> Assisted-by: GPT-6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Cygwin: pty: preserve terminal replies after PTY adoption
>     
>     I just merged this into Git for Windows' fork of the MSYS2 runtime, as
>     it is a somewhat pressing problem due to Git for Windows v2.56.0-rc0
>     already being overdue.
>     
>     This patch is based on cygwin-3_6-branch, but is easily cherry-picked
>     onto master, too.
> 
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-10%2Fdscho%2Ffix-vim-terminal-replies-v1
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-10/dscho/fix-vim-terminal-replies-v1
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/10
> 
>  winsup/cygwin/fhandler/pty.cc | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index c5081bcaf..f6e051b9e 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1637,6 +1637,15 @@ fhandler_pty_slave::tcsetattr (int, const struct termios *t)
>    acquire_output_mutex (mutex_timeout);
>    get_ttyp ()->ti = *t;
>    release_output_mutex ();
> +
> +  /* Terminal queries can precede the first read/select after entering
> +     noncanonical mode.  Their replies must bypass the native console. */
> +  if (!(t->c_lflag & ICANON) && get_ttyp ()->pcon_activated
> +      && get_ttyp ()->getpgid () == myself->pgid)
> +    {
> +      mask_switch_to_nat_pipe (true, true);
> +      mask_switch_to_nat_pipe (false, false);
> +    }
>    return 0;
>  }
>  
> 
> base-commit: c19c1e6ad9d8abad640ffcb95996642cc35955ec
> -- 
> cygwingitgadget

To me, the root cause and the proposed fix seem out of alignment.
If "input stays with ConHost until the first Cygwin read/select",
the solution is calling transfer_input() in the slave::open(),
say, around here:

  if (get_ttyp ()->pcon_activated)
    {
      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
                                       get_ttyp ()->nat_pipe_owner_pid);
      if (pcon_owner)
        {
          HANDLE new_in = NULL, new_out = NULL;
          bool ok_in = DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
                                       GetCurrentProcess (), &new_in,
                                       0, TRUE, DUPLICATE_SAME_ACCESS);
          bool ok_out = DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
                                        GetCurrentProcess (), &new_out,
                                        0, TRUE, DUPLICATE_SAME_ACCESS);
          if (ok_in && ok_out)
            {
              /* Replace these before open_with_arch() copies them into the
                 archetype shared by all pty slave fhandlers. */
              CloseHandle (get_handle_nat ());
              CloseHandle (get_output_handle_nat ());
              set_handle_nat (new_in);
              set_output_handle_nat (new_out);
            }
          else
            {
              if (new_in)
                CloseHandle (new_in);
              if (new_out)
                CloseHandle (new_out);
            }
          CloseHandle (pcon_owner);
        }
    }

What do you think?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
