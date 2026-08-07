Return-Path: <SRS0=Gg12=GA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id 73ABE4B9DB49
	for <cygwin-patches@cygwin.com>; Fri,  7 Aug 2026 10:47:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 73ABE4B9DB49
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 73ABE4B9DB49
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786099656; cv=none;
	b=xqhHHkkuekfCL48bxokdmxKws/iL4218EVoe6g1te43ETOsOsZOrjQrOReDxtWsodhpYiLtY91l87m5Lm9bNa8peJvMYSdTtOsfxMx9ExHuI50mi/BhI47Y6nuhM+si6SphEQIINI3F7OzDeIaUgB4WdyApkZ7IaDmdSn/WY/vA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786099656; c=relaxed/simple;
	bh=ImLmaym6ashgk5Aaf296g52CgY1cTBW7mPb+rp/wOdU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=WjQ2IwALS7Uu2DgvggfrbVl+erurF5K6CbW8l5GmQRE6uzOc7sAGz8aBtjoBcHlVI8Q4YU7fzANA+PqLm1OkRolW1hdiPvMTbnJRcqTOq8q+BZyGFsechNEBsmX1Ip9cxtLvcyFnC33xxthwnHcMvm9UTMVfmnwWMfJnhK8bM7s=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=iREbWhd2
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 73ABE4B9DB49
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=iREbWhd2
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260807104732552.ROVY.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 7 Aug 2026 19:47:32 +0900
Date: Fri, 7 Aug 2026 19:47:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: keep interactive console input for native
 programs via Cygwin
Message-Id: <20260807194730.736e6364077b65db9afe2daa@nifty.ne.jp>
In-Reply-To: <pull.8.cygwin.1784540598759.gitgitgadget@gmail.com>
References: <pull.8.cygwin.1784540598759.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1786099652;
 bh=iJv9+Lb4V/W+QrVQVEHh17Jg8ALnKy7tuOrMcf4SyPI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=iREbWhd20tOU9hM7U+frQ0WBgBsQVWnq7q4GCeyXxbyE7K5lYMgIeO8KTs2krXvejRueTmlb
 W2n5DZe5n7AtgfEwAFoAQhYAAQM61cKv6akjABNLCfk+OyyxULWIEcf3OLjdstsUq26jukVbyn
 Glh0dMBFx5aKxvt5U3j+VaBX/xgfkSkWOBcpYhJ6Ggvx1e59enjJrX82+o4Z/TxIsWSuZ0JV3R
 9rKmUzck2Jj6dJI5DDvvQHvwEMhh+zDE+VVQSOdNoXGYf+ATefw72JFo5TueWpAvjKrQzLGPIV
 9M9q0uBA63b9qZX0168b1pQPWyINtl5Xzrye2gw2130CHPKg==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Mon, 20 Jul 2026 09:43:18 +0000
"Johannes Schindelin wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Currently, when a native Windows program starts a Cygwin program while a
> pseudo console is active, and the Cygwin program then starts another
> native Windows program, the final program can lose access to console
> input. It then behaves as though its standard input were redirected
> instead of remaining interactive.
> 
> For example, a native `git.exe` may invoke shell aliases (i.e. execute a
> shell command) that would in turn call interactive Git commands who
> would no longer work because their standard input appeared to be
> redirected. This can be demonstrated as follows:
> 
>   git -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
>     Write-Output ([Console]::IsInputRedirected)
>     try {
>       [void][Console]::KeyAvailable
>       exit 0
>     } catch {
>       exit 1
>     }
>   "' console-probe
> 
> Running this command with a Win32 version of `git.exe` currently prints
> `True` and exits with exit code 1. In the latest official release, where
> this bug is not present, it prints `False` and results in exit code 0.
> 
> The reason is to be fonud in the archetype code. Reminder: For each
> pseudo terminal (pty), the archetype is the shared pty fhandler that
> owns the underlying native handles and supplies them to every
> per-file-descriptor fhandler for that pty.
> 
> `open_with_arch()` calls `open()`, copies the first pty fhandler's state
> into the archetype, and then calls `open_setup()`. At that stage, pcon
> handle adoption already took place in `open_setup()`. This was not
> anticipated by 60a88896dc (Cygwin: pty: do not leak nat handles when
> adopting the pcon's in open_setup(), 2026-06-25), which tried to fix a
> leak by closing the superseded native handles as they were replaced in
> `open_setup()`.  Because `open_with_arch()` had already copied those
> handle values into the archetype, closing them invalidated the
> archetype's copies.
> 
> The archetype therefore retained stale values for those closed handles,
> which later pty fd fhandlers would inherit. If Windows reuses one of
> those values for a newly duplicated pcon handle, closing the stale value
> closes the new handle instead. The nested native program then receives
> unusable console input.
> 
> Preserve usable console input by moving the unchanged transactional pcon
> handle adoption to `open()`, before the archetype snapshot. The archetype
> then receives valid pcon handles, all pty fd fhandlers inherit live
> handles, and the superseded raw pipe handles are closed exactly once.
> 
> This commit is best viewed with `--color-moved`.
> 
> Fixes: 60a88896dce0 ("Cygwin: pty: do not leak nat handles when
>  adopting the pcon's in open_setup()")
> Assisted-by: GPT-5.6 Sol
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Fix a regression on cygwin/master
>     
>     I noticed this regression in Git for Windows' fork, to which I had
>     backported the faulty commit from Cygwin's master branch.
> 
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-8%2Fdscho%2Ffix-nat-handle-leakfix-cygwin-v1
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-8/dscho/fix-nat-handle-leakfix-cygwin-v1
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/8
> 
>  winsup/cygwin/fhandler/pty.cc | 44 +++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index f3df55f34..37a480933 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1220,26 +1220,6 @@ fhandler_pty_slave::open (int flags, mode_t)
>        release_attach_mutex ();
>      }
>  
> -  set_open_status ();
> -  return 1;
> -
> -err:
> -  if (GetLastError () == ERROR_FILE_NOT_FOUND)
> -    set_errno (ENXIO);
> -  else
> -    __seterrno ();
> -err_no_errno:
> -  termios_printf (errmsg);
> -err_no_msg:
> -  for (HANDLE **h = handles; *h; h++)
> -    if (**h && **h != INVALID_HANDLE_VALUE)
> -      CloseHandle (**h);
> -  return 0;
> -}
> -
> -bool
> -fhandler_pty_slave::open_setup (int flags)
> -{
>    if (get_ttyp ()->pcon_activated)
>      {
>        HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> @@ -1255,8 +1235,8 @@ fhandler_pty_slave::open_setup (int flags)
>  				        0, TRUE, DUPLICATE_SAME_ACCESS);
>  	  if (ok_in && ok_out)
>  	    {
> -	      /* Close the cyg master-side handles open() installed before
> -		 replacing them, so they do not leak. */
> +	      /* Replace these before open_with_arch() copies them into the
> +		 archetype shared by all pty slave fhandlers. */
>  	      CloseHandle (get_handle_nat ());
>  	      CloseHandle (get_output_handle_nat ());
>  	      set_handle_nat (new_in);
> @@ -1273,6 +1253,26 @@ fhandler_pty_slave::open_setup (int flags)
>  	}
>      }
>  
> +  set_open_status ();
> +  return 1;
> +
> +err:
> +  if (GetLastError () == ERROR_FILE_NOT_FOUND)
> +    set_errno (ENXIO);
> +  else
> +    __seterrno ();
> +err_no_errno:
> +  termios_printf (errmsg);
> +err_no_msg:
> +  for (HANDLE **h = handles; *h; h++)
> +    if (**h && **h != INVALID_HANDLE_VALUE)
> +      CloseHandle (**h);
> +  return 0;
> +}
> +
> +bool
> +fhandler_pty_slave::open_setup (int flags)
> +{
>    set_flags ((flags & ~O_TEXT) | O_BINARY);
>    myself->set_ctty (this, flags);
>    report_tty_counts (this, "opened", "");
> 
> base-commit: 524d75ff73986b263161665af771cc90e55b5e01

At first glance, I thought this patch was incorrect, because open()
is only called in the process that initially opened the pty.
But that was a mistake on my part.

Since the commit 6eed1ef74869 ("Cygwin: pty: detect pcon-backed pty
for non-Cygwin-spawned children"), open() is also called when a cygwin
app is started from non-cygwin app. So open() is indeed the right
place to fix nat-handle, rather that open_setup().

In the first place, my patch b34394d456b6 ("Cygwin: pty: Fixup pty
state after a cygwin app exits") should place that logic in open().

Thanks for fixing that. Pushed to master branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
