Return-Path: <SRS0=Gzk2=FK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2a])
	by sourceware.org (Postfix) with ESMTPS id ED6A84BA2E37
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 07:47:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ED6A84BA2E37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ED6A84BA2E37
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784188031; cv=none;
	b=N+yne3ckJ86+XZxYLvpk7zdVcV/OHNOc7Mz2AAu5xmcvsUWyDGBMzEnk+GIF5QIHABjoXMz5XXhP41JSQQyqMSFklTM4RThTWcYMV8v6guyKUoh0WWvC8Yc/1IQ/oebTAzDJGWaF8/zEBzs1QYhL9JrnZC5e0qV/s7wfsOBuKkI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784188031; c=relaxed/simple;
	bh=tuOVNeNpSe0L3d4dj/pnv+THYfPfYB5jpwZMnkE0n2M=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=jfOd3mc66xsVcnl05KWGe4ey8JhpZ1x6HXHarWzARDc+C5qw3w0kQ64/bqbDkmEBJSIJ0kIp4jDx5z6tsb+NEbjprm1mdRF5uYol8UgXdPcZIiXM+ajt3a6Bt7ly9w7GZfw6Po9wOzH+U1XDh8e2unmkvJaemieWqrThpKcXy40=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YWb1aS2k
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ED6A84BA2E37
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YWb1aS2k
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260716074709001.FSXY.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 16:47:09 +0900
Date: Thu, 16 Jul 2026 16:47:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260716164707.e5e91fd1781108040f40adda@nifty.ne.jp>
In-Reply-To: <20260716073629.6082-1-takashi.yano@nifty.ne.jp>
References: <20260716073629.6082-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784188029;
 bh=eoP4l3XC1u/t2YZt70uCEHTx07ZTHQxDMGMzNK+L8dU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=YWb1aS2kqDjqrs/Ox13Z5vKz5WSRUWXgpje7xViyD5QCF7bHuYuoaLNpwOoUQrhR36pClwYL
 9zIQ6oeOR3MV/llw2XlvzYekDOllx9eDZEXrKdyngBRsnAVhxyD9/oELSRR90MB9t3W7y5AolM
 kTwvQhgwa4BO9kinPX93/uyHu7vLpYEP8cCdI33orwVJBVW5bB1gS4DbTjlUh7CvPAYvIPHACU
 NF93hbTbFGmI/4P8XzufAwt4kwj5NSy296JuUyb/V/gAmJcrCae9dgxiiwzEef1NDdiIOCSQbS
 lvRjSnMjPpo9LrxtdZ4W5H9a71YrQyk8RnU+reZCi5I4vxwg==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 16 Jul 2026 16:36:18 +0900
Takashi Yano wrote:
> Previously, if two non-cygwin apps are started and one of them
> exits first, the other one loosed appropriate console mode, since
> the first one restored it to tty::cygwin. This patch counts the
> active console process whose pgid is pgid of the tty and if the
> result is zero (means the last non-cygwin foreground process),
> restore console mode. To avoid race issue between apps modifying
> console mode simultaneously, this patch also introduce a mutex
> named `cons_mode_mutex`.
> 
> Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Stop counting up/down the counter by itself.
>     Use num_active_non_cygwin_apps() instead.
> v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
> v4: Guard all mode changes in console by cons_mode_mutex.
> 
>  winsup/cygwin/fhandler/console.cc       | 87 ++++++++++++++++++++++++-
>  winsup/cygwin/local_includes/fhandler.h |  2 +
>  2 files changed, 86 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index d4c87f29f..5b9a87ebd 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -977,15 +977,59 @@ fhandler_console::setup_for_non_cygwin_app ()
>       console mode. */
>    if (get_ttyp ()->getpgid () == myself->pgid)
>      {
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
>        set_disable_master_thread (true, this);
>        set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
>        set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
> +      ReleaseMutex (cons_mode_mutex);
>      }
>  }
>  
> +static int
> +num_active_non_cygwin_apps (pid_t pgid)
> +{
> +  tmp_pathbuf tp;
> +  DWORD *list = (DWORD *) tp.c_get ();
> +  const DWORD buf_size = NT_MAX_PATH / sizeof (DWORD);
> +
> +  DWORD buf_size1 = 1;
> +  DWORD num;
> +  /* The buffer of too large size does not seem to be expected by new condrv.
> +     https://github.com/microsoft/terminal/issues/18264#issuecomment-2515448548
> +     Use the minimum buffer size in the loop. */
> +  while ((num = GetConsoleProcessList (list, buf_size1)) > buf_size1)
> +    {
> +      if (num > buf_size)
> +	return 0;
> +      buf_size1 = num;
> +    }
> +  if (num == 0)
> +    return 0;
> +
> +  int cnt = 0;
> +  for (DWORD i = 0; i < num; i++)
> +    {
> +      pinfo p (cygwin_pid (list[i]));
> +      if (!!p && p->pgid == pgid && ISSTATE (p, PID_NOTCYGWIN))
> +	cnt++;
> +    }
> +  return cnt;
> +}
> +
>  void
>  fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
>  {
> +  if (cygheap->ctty->tc()->pgid != myself->pgid)
> +    return;
> +
> +  WaitForSingleObject (p->cons_mode_mutex, INFINITE);
> +  if (num_active_non_cygwin_apps (cygheap->ctty->tc()->pgid))
> +    {
> +      ReleaseMutex (p->cons_mode_mutex);
> +      CloseHandle (p->cons_mode_mutex);

Closing cons_mode_mutex here is incorrect. Sorry.

> +      return;
> +    }
> +
>    const _minor_t unit = p->unit;
>    termios dummy = {0, };
>    termios *ti = shared_console_info[unit] ?
[...]

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
