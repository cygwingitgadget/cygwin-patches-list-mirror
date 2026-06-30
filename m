Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 43C394BA2E28
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 08:26:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 43C394BA2E28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 43C394BA2E28
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782807981; cv=none;
	b=Y6UEljAPrYRlurKjmK6ADUD+U0mPu6BDvBsW+ck0wUBEQpkwbPqVY5h5GShwojFcfUOqz9lQEwfJKqNOfIBsnJriLp69saPOMxiogmRw+n8BhH7LrbP2wp/whBSH6CwDEd/bJtodFO6cRf1TpaP4M0Ros7j9tmCv16XwKS+yTEk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782807981; c=relaxed/simple;
	bh=/lzm4dqDVvZu7WWlTCPCy7zpDZFtXGW3JaRSAWWN8aU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=exLqfnYQHpwVS/MT3RvkX/4HCSWRCxq9+ZMBIVse9uOvZuB1CbVS5+qDEfOwt+SV28XWNUZlJaZiEAibRcdbRNyjMnVz8yjjmltXewf5RHKYsNCN7rhjFcGahmqMU79d+/XsbPCZO4fXp/+0mDcbFwoay4OzniPRtc2ZLrnVLeQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TTI3ISMZ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 43C394BA2E28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TTI3ISMZ
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260630082619264.SPTV.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 17:26:19 +0900
Date: Tue, 30 Jun 2026 17:26:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: detect pcon-backed pty for
 non-Cygwin-spawned children
Message-Id: <20260630172617.f483a3a853b9f071dfe618a7@nifty.ne.jp>
In-Reply-To: <2b226810-4032-9933-51cc-e4251d8c32a6@gmx.de>
References: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com>
	<20260624221256.e474f94cc223fcb13ab7db61@nifty.ne.jp>
	<2b226810-4032-9933-51cc-e4251d8c32a6@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782807979;
 bh=LkZBM87mesQmv/REydKFAHbHyW6C9TGQoyZUNzUohEI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=TTI3ISMZIUuf9g5RNttK/C+b9w1t6F8oC54pm1xTCk2be0Wb95znor00G5A6HVHBWFqOK+uM
 gE4MQtSNM7zqNvM/CE38KkjjcDFuYvVhlk4ut8YBkOQkPgFvKbHKUai4TleOtD7ewJfb9hmjuh
 zhPBZtjtt2h3aU2R15Oo5VTugSwsmOCMOa0E8ZYkzeUQKfdeCTop5rHJS48XA6kOctDidDw1Cn
 d89/fpAIhG4EVX6ny+FbUrNCX/P8jot+1mOZ0gZkSVLQjXG06P3/ipZC4tuuPxXjyZZFj6gw/C
 lvDV5y6VdjtbfRGkUzhUDXaUu01YyQXk309M9FTR4n2vVe6g==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 27 Jun 2026 10:18:27 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi & Mark,
> 
> On Wed, 24 Jun 2026, Takashi Yano wrote:
> 
> > On Thu, 30 Apr 2026 15:04:04 +0000
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > 
> > > When a Cygwin process (e.g. `bash` under MinTTY) spawns a native
> > > Win32 child (e.g. `git.exe`) with pseudo console support enabled,
> > > the child gets a pseudo console that bridges the pty. If that native
> > > child then spawns a Cygwin grandchild (e.g. `vim`, `less`), the
> > > grandchild inherits the pseudo console's console handles. In
> > > `init_std_file_from_handle()`, the grandchild's msys2-runtime sees
> > > `GetConsoleScreenBufferInfo()` succeed on those handles and, with
> > > no valid `ctty` set, falls back to `FH_CONSOLE` and gives the
> > > process `cons0` instead of connecting to the pty.
> > > 
> > [...]
> > 
> > Pushed to master branch with my fixup patches.
> 
> I had a buffer-grow follow-up to this patch sitting in
> https://github.com/git-for-windows/msys2-runtime/pull/131/commits/77e01abd83836b4b7488328ca899aea3a8e4ffbe
> that I should have sent before you picked up the original and pushed it to
> master; sorry for the delay.
> 
> -- snip --
> From 77e01abd83836b4b7488328ca899aea3a8e4ffbe Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Fri, 29 May 2026 19:07:26 +0200
> Subject: [PATCH] Cygwin: pty: grow GetConsoleProcessList buffer in
>  find_pcon_pty()
> 
> find_pcon_pty() was passing a fixed 128-DWORD stack array to
> GetConsoleProcessList(). If the calling Cygwin process happens to be
> attached to a console with more than 128 processes, the Win32
> function returns the required size and the buffer contents are
> undefined; the existing if-zero check did not catch that case, so
> the subsequent loop walked uninitialised data and could either miss
> the candidate pty or, worse, match against junk PIDs and return the
> wrong tty index.
> 
> Adopt the buffer-too-small dance from
> fhandler_termios::get_console_process_id() in
> winsup/cygwin/fhandler/termios.cc, which already had to solve this
> problem and which also notes that the new condrv does not accept
> oversized first-call buffers
> (https://github.com/microsoft/terminal/issues/18264#issuecomment-2515448548).
> The buffer comes from tmp_pathbuf so the same NT_MAX_PATH cap
> (currently 1024 DWORDs, i.e. 4096 processes) applies; we bail out
> with -1 if even that is not enough rather than allocate unbounded
> memory or guess. Bumping the start-with size from 1 would defeat the
> condrv work-around mentioned above, so we keep the same one-element
> initial probe as termios.cc and let the loop grow.
> 
> Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Assisted-by: Opus 4.7
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> (cherry picked from commit b65e1544d45567f0033c57a0aa1543c5e654950a)
> ---
>  winsup/cygwin/tty.cc | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> index 5cce05de34..9bc2a084fb 100644
> --- a/winsup/cygwin/tty.cc
> +++ b/winsup/cygwin/tty.cc
> @@ -19,6 +19,7 @@ details. */
>  #include "cygheap.h"
>  #include "pinfo.h"
>  #include "shared_info.h"
> +#include "tls_pbuf.h"
>  
>  HANDLE NO_COPY tty_list::mutex = NULL;
>  
> @@ -135,7 +136,9 @@ tty_list::init ()
>  int
>  tty_list::find_pcon_pty ()
>  {
> -  DWORD pids[128];
> +  tmp_pathbuf tp;
> +  DWORD *pids = (DWORD *) tp.c_get ();
> +  const DWORD buf_size = NT_MAX_PATH / sizeof (DWORD);
>    DWORD count = 0;
>    bool got_pids = false;
>  
> @@ -144,10 +147,20 @@ tty_list::find_pcon_pty ()
>        if (!ttys[i].has_active_pcon ())
>  	continue;
>  
> -      /* Fetch the console process list lazily, only on first candidate. */
> +      /* Fetch the console process list lazily, only on first candidate.
> +	 The buffer-too-large dance mirrors the one in termios.cc's
> +	 get_console_process_id() and works around new condrv's dislike
> +	 of oversized first-call buffers, see
> +	 https://github.com/microsoft/terminal/issues/18264#issuecomment-2515448548 */
>        if (!got_pids)
>  	{
> -	  count = GetConsoleProcessList (pids, 128);
> +	  DWORD buf_size1 = 1;
> +	  while ((count = GetConsoleProcessList (pids, buf_size1)) > buf_size1)
> +	    {
> +	      if (count > buf_size)
> +		return -1;
> +	      buf_size1 = count;
> +	    }
>  	  if (!count)
>  	    return -1;
>  	  got_pids = true;
> -- snap --
> 
> Ciao,
> Johannes
> 

LGTM. Thanks! Pushed to master.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
