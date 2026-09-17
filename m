Return-Path: <SRS0=k2H2=HJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id B47524B9DB56
	for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2026 11:19:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B47524B9DB56
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B47524B9DB56
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789643999; cv=none;
	b=VYVfjrG4Y6ML+CVlTPNswy9N443dxD2+KsSoAnSYv5frrFYztMmhyHI65/5V94S3i4g/VqH+PBgwKqeR0BQ9+bKov6LlQBK35ZrFCUAxNLTaLHWKLWewh8EqST37ObafYlz7nmn+d5iaYx2HNVDscxQsHWegumoMh3jILRAFEUg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789643999; c=relaxed/simple;
	bh=tF+E4yzFtR5IqYmA46AJwaUD+G1F1eFmowOQAt2TVvw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=BV0iEN/rGDg0It48Ru0lW0+2TozA0FNg/CShWhdMmmOsB77lq89hlyA+tOFXZmMBwwXZHH5K5+0AwXihgPS6sb+5ydUxkCFjpWQfQfaD0XKveIwWYESP8FfRDij6t+K07hew5rgh925sat9qt3G3A5YH1ODwJWGF4nkda2arbR0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gyTFSBGH
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B47524B9DB56
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gyTFSBGH
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260917111946172.XBPI.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2026 20:19:46 +0900
Date: Thu, 17 Sep 2026 20:19:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: preserve terminal replies after PTY
 adoption
Message-Id: <20260917201943.dbe64d19e53c7d18eafb31e3@nifty.ne.jp>
In-Reply-To: <20260915213259.fd24c38cac2c2adafdd2b097@nifty.ne.jp>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
	<20260915213259.fd24c38cac2c2adafdd2b097@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789643986;
 bh=2lJ3weRwN7sn89ivDk7tMnFlz9iYX9jy5rnPw7MgUCQ=;
 h=Date:From:To:Subject:In-Reply-To;
 b=gyTFSBGHTmc+glGkoqOdI1cjNqfDRKGrM96rxbgVwaA6eZO6F4jb0aA7l8JjG3UZRroCYIpV
 PbalMAvQvgnm9XHxOP6gxHVPOdWo4HHPRKKUr8eTR7rr6QWWGNLlpk2OFNObquK9gv35LYfsnb
 pulTV293GYxrvKLsmMpXaMNiXrwnEMPEfN6Pz1Iq5K3YvRcsFjBfCRLCVD/7GcJLOu8/x2dkkE
 8EEQEe9AKoWzC1Id6v6q6p/J7KBKPIuzFMhBJG139FYjpFxHP/+GI6UHQSJTiWqVX+/L7ch3qg
 w5nxs7bo/3nHrG6DGzgiUWys1Kb0layG12achQ23r+o5ReRg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 15 Sep 2026 21:32:59 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> Thanks for the patch.
> 
> On Sun, 13 Sep 2026 12:30:05 +0000
> "Johannes Schindelin wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > This fixes an issue reported about MSYS2/Win32 interaction, but applies
> > to regular Cygwin as well. In the following, the original scenario is
> > described.
> > 
> > MSYS Vim launched by native Git from Bash in MinTTY can delete the first
> > line, enter Insert mode or insert RGB text at startup. PTY adoption sends
> > Vim's output directly to MinTTY, but input stays with ConHost until the
> > first Cygwin read/select. Vim inherits Git's foreground process group, so
> > the process-group callback does not trigger an earlier handoff.
> > 
> > Vim sends terminal queries before reading. ConHost interprets cursor
> > position reports as function keys, which the later input transfer delivers
> > to Vim as keystrokes. A color reply split across the handoff reaches Vim
> > without its introducer. Fragmented writes are valid; inconsistent routing
> > corrupts their contents.
> > 
> > Requesting noncanonical input with tcsetattr() provides a control point
> > before these queries. Handing input to the Cygwin PTY there aligns both
> > directions before replies can be misdirected, rather than waiting for
> > consumption. Only the foreground process on an active pseudoconsole takes
> > this path; canonical, background and pcon-disabled calls are unaffected.
> > 
> > The existing synchronized transfer preserves queued input and line
> > discipline. Balancing the temporary reader registration without transferring
> > back keeps input on the Cygwin pipe without a permanent reader claim or
> > changes to native-owner cleanup. Releasing the output mutex first avoids
> > holding it across the input-transfer path.
> > 
> > Addresses: https://github.com/git-for-windows/git/issues/6403
> > Fixes: 6eed1ef74869 ("Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned children")
> > Assisted-by: GPT-6
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     Cygwin: pty: preserve terminal replies after PTY adoption
> >     
> >     I just merged this into Git for Windows' fork of the MSYS2 runtime, as
> >     it is a somewhat pressing problem due to Git for Windows v2.56.0-rc0
> >     already being overdue.
> >     
> >     This patch is based on cygwin-3_6-branch, but is easily cherry-picked
> >     onto master, too.
> > 
> > Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-10%2Fdscho%2Ffix-vim-terminal-replies-v1
> > Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-10/dscho/fix-vim-terminal-replies-v1
> > Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/10
> > 
> >  winsup/cygwin/fhandler/pty.cc | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index c5081bcaf..f6e051b9e 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -1637,6 +1637,15 @@ fhandler_pty_slave::tcsetattr (int, const struct termios *t)
> >    acquire_output_mutex (mutex_timeout);
> >    get_ttyp ()->ti = *t;
> >    release_output_mutex ();
> > +
> > +  /* Terminal queries can precede the first read/select after entering
> > +     noncanonical mode.  Their replies must bypass the native console. */
> > +  if (!(t->c_lflag & ICANON) && get_ttyp ()->pcon_activated
> > +      && get_ttyp ()->getpgid () == myself->pgid)
> > +    {
> > +      mask_switch_to_nat_pipe (true, true);
> > +      mask_switch_to_nat_pipe (false, false);
> > +    }
> >    return 0;
> >  }
> >  
> > 
> > base-commit: c19c1e6ad9d8abad640ffcb95996642cc35955ec
> > -- 
> > cygwingitgadget
> 
> To me, the root cause and the proposed fix seem out of alignment.
> If "input stays with ConHost until the first Cygwin read/select",
> the solution is calling transfer_input() in the slave::open(),
> say, around here:
> 
>   if (get_ttyp ()->pcon_activated)
>     {
>       HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
>                                        get_ttyp ()->nat_pipe_owner_pid);
>       if (pcon_owner)
>         {
>           HANDLE new_in = NULL, new_out = NULL;
>           bool ok_in = DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
>                                        GetCurrentProcess (), &new_in,
>                                        0, TRUE, DUPLICATE_SAME_ACCESS);
>           bool ok_out = DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
>                                         GetCurrentProcess (), &new_out,
>                                         0, TRUE, DUPLICATE_SAME_ACCESS);
>           if (ok_in && ok_out)
>             {
>               /* Replace these before open_with_arch() copies them into the
>                  archetype shared by all pty slave fhandlers. */
>               CloseHandle (get_handle_nat ());
>               CloseHandle (get_output_handle_nat ());
>               set_handle_nat (new_in);
>               set_output_handle_nat (new_out);
>             }
>           else
>             {
>               if (new_in)
>                 CloseHandle (new_in);
>               if (new_out)
>                 CloseHandle (new_out);
>             }
>           CloseHandle (pcon_owner);
>         }
>     }
> 
> What do you think?

No. Not here. Too early perhaps. May be in slave::init().

I also noticed that the same problem occurs if vim is
started with non-cygwin program running in background.
This also affects cygwin-3_6-brancy.

Therefore, I think we need transfer_input also in
slave::fixup_after_exec().

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
