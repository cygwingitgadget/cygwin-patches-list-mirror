Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 8C55D4BA2E1C
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 01:45:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C55D4BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C55D4BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766108723; cv=none;
	b=HdjgNzgbulvJXq6lqTcRcQwrzWFTStsPJcpE+cNVJ6/rBuBDsHZ4ivVDrLKIX5Shdhmpa+U0YseDwxpWWkdVDC1EF7HgdevQhyp16RymLoQxHk1Q65HxQ231wHnmp/tDq19zqUQRDM4Me9DPl+JKcEs3ZZUio/BY9VpiwBzBpXg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766108723; c=relaxed/simple;
	bh=NfvU32QdDkuHzkIHu0sukNM81dxNg9ffRX0kOGHM5m0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=wV7Iw8lT0PnPUQxw4Drp0WNlbRDUeXLejI6vpq1OyyRFcLOArL3DPOfQkTmXyeh26DLuvdvgJjOpdJr72IWwKmblyPX2dm2RD536tXedL+N9R2241juHZ2BxVs0OTcmP676xWovshOA+Cc9alb78zqifDbBVYUPVO0sUooKftzw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C55D4BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=W08487I/
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20251219014513484.EHXA.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 10:45:13 +0900
Date: Fri, 19 Dec 2025 10:45:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 5/5] Cygwin: termios: Handle app execution alias in
 is_console_app()
Message-Id: <20251219104512.0cba081c030bed339738f7fb@nifty.ne.jp>
In-Reply-To: <3f93cf29-ce67-b8f4-fb5a-c4f6bce50e4d@gmx.de>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
	<20251218072813.1644-6-takashi.yano@nifty.ne.jp>
	<3f93cf29-ce67-b8f4-fb5a-c4f6bce50e4d@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766108713;
 bh=wMA+or9GJauYk2c/ZXstIoiP6dK6wQoDccSv7wDOPNg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=W08487I/1afifBgSKaa0RQ8M93t4cFmQVZxM0vvMaTB3Kqs+6UF52pbsvLMMFD7ZKfXVqdZr
 l9is9KpGJNT33wjzDjmYGy1R3NYAmTvyhxPcOEVVFFrV6FMZvHERGs5n0pmPnNj44C+5kbBYlv
 tVV2+lUcJ6v1WETblKufb5w4f/+qx607Lel8m3ooBegNh6xTFsAE4STi3gjLtTD9PCTT/K0guA
 FRI10lzgtqtJxkeIINDxp9aXUXTNjoTv/4bc+MUKygdprjpQ18s36CGCZYIzB6eIb3GkNpEoS3
 Fck++0XTV+oU6l3UFAzEASdZVC26ypj6B/RoWK4TnV060zxg==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 18 Dec 2025 09:22:52 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 18 Dec 2025, Takashi Yano wrote:
> 
> > After the commit f74dc93c6359, WSL cannot start by distribution name
> > such as debian.exe, which has '.exe' extention but actually is an app
> > execution alias. This is because the commit f74dc93c6359 disabled to
> > follow windows reparse point by adding PC_SYM_NOFOLLOW_REP flag in
> > spawn.cc, that path is used for sapwning a process. As a result, the
> > path, that is_console_app () received, had been the reparse point of
> > app execution alias, then it returned false for the the path due to
> > open-failure because CreateFileW() cannot open an app execution alias,
> > while it can open normal reparse point.  If is_console_app() returns
> > false, standard handles for console app (such as WSL) would not be
> > setup. This causes that the console input cannot be transfered to the
> > non-cygwin app.
> 
> Just a suggestion: Start by describing the bug instead of leading with the
> commit that caused the bug. Something along the lines "Microsoft Store
> apps are run via 'app execution aliases', i.e. special reparse points.
> Cygwin usually treats those like symbolic links. However, unlike proper
> symbolic links, app execution aliases are not resolved when trying to read
> the file contents via `CreateFile()`/`ReadFile()` [...]".

Thanks for the advice. How about:

    Microsoft Store apps are run via app execution aliases, i.e. special
    reparse points. Currently, spawn.cc does not resolve a reparse point
    when retrieving the path of app after the commit f74dc93c6359, that
    disabled to follow windows reparse point by adding PC_SYM_NOFOLLOW_REP
    flag.

    However, unlike proper reparse point, app execution aliases are not
    resolved when trying to open the file via CreateFile(). As a result,
    if the path, that is_console_app() received, is the reparse point
    for an app execution alias, the func retuned false due to open-failure
    because CreateFile() cannot open an app execution alias, while it can
    open normal reparse point. If is_console_app() returns false, standard
    handles for console app (such as WSL) would not be setup. This causes
    that the console input cannot be transfered to the non-cygwin app.

    This patch fixes the issue by locally converting the path once again
    using option PC_SYM_FOLLOW (without PC_SYM_NOFOLLOW_REP), which is
    used inside is_console_app() to resolve the reparse point, if the path
    is an app execution alias.

> > This patch fixes the issue by locally converting the path, which is
> > a path to the app execution alias, once again using PC_SYM_FOLLOW
> > (without PC_SYM_NOFOLLOW_REP) option path_conv for using inside of
> > is_console_app() to resolve the reparse point here, if the path is
> > an app execution alias.
> > 
> > Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/termios.cc       | 23 ++++++++++++++++++-----
> >  winsup/cygwin/local_includes/fhandler.h |  2 +-
> >  winsup/cygwin/spawn.cc                  |  2 +-
> >  3 files changed, 20 insertions(+), 7 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> > index f99ae6c80..694a5c20f 100644
> > --- a/winsup/cygwin/fhandler/termios.cc
> > +++ b/winsup/cygwin/fhandler/termios.cc
> > @@ -702,13 +702,26 @@ fhandler_termios::fstat (struct stat *buf)
> >  }
> >  
> >  static bool
> > -is_console_app (const WCHAR *filename)
> > +is_console_app (path_conv &pc)
> >  {
> > -  wchar_t *e = wcsrchr (filename, L'.');
> > +  tmp_pathbuf tp;
> > +  WCHAR *native_path = tp.w_get ();
> > +  pc.get_wide_win32_path (native_path);
> > +
> > +  wchar_t *e = wcsrchr (native_path, L'.');
> >    if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
> >      return true;
> > +
> > +  if (pc.is_app_execution_alias ())
> > +    {
> > +      UNICODE_STRING upath;
> > +      RtlInitUnicodeString (&upath, native_path);
> > +      path_conv target (&upath, PC_SYM_FOLLOW);
> > +      target.get_wide_win32_path (native_path);
> > +    }
> > +
> 
> It might make sense to move this `is_app_execution_alias()` block before
> looking at the file extension, not that it will matter a lot in pratices
> because as far as I understand, app execution aliases are only ever
> created for `.exe` files, with the same base name as the target (or at
> least with the same file extension).

Both is OK, I think.

AFAIK, app execution alias never has extension: ".bat" or ".cmd" so, the
both 'if' blocks are exclusive.

So, only the question is: which is more natural for readers.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
