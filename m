Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.114])
	by sourceware.org (Postfix) with ESMTPS id 1F5A24BA2E04
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 09:01:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1F5A24BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1F5A24BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.114
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765962116; cv=none;
	b=Vk+brJE3er4+Zo67aNboT7Aman01yDYvE/D1zqi1ZMe9dNe86qvGlz0QMP3j3Nyac/Q42guQtqO6V/SxTzOqKXjLTI/nJTtoXRlDOXSKeqa2Hvr+kM9TgiTQ656Q3GJrh8KCHooVXAl+Am7MGh8xtEUVV83iRijIETBrxfnZQZc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765962116; c=relaxed/simple;
	bh=XRIRdgQH5lW1omeKBorgYwFzhHy4XCC95iXvm+0mYtc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=i5vvl1wtivsoqIEOPYZ3XYsS/fhO8rEU61GJXZw20aX/1Gdg23oPPiMVst9It/N4NUuHEOfasIX/6tW5hIHOeqkvPgI6o7B6a+QvLrjaUjufRWy3zBQflC1kiGRCDFEq3mrCfgeEKEJkykhKsB842xmkYqShu5WSut7+AJeGtqc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1F5A24BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hgynLF8U
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20251217090153885.WWMP.45927.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 18:01:53 +0900
Date: Wed, 17 Dec 2025 18:01:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/3] Cygwin: is_console_app(): do handle errors
Message-Id: <20251217180152.25f1399bc0e021276d807818@nifty.ne.jp>
In-Reply-To: <af87bd1d47958a6d183dbfb56fb61462b4390ec1.1765818395.git.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
	<af87bd1d47958a6d183dbfb56fb61462b4390ec1.1765818395.git.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765962114;
 bh=zop0vHZKCtlKFdGwTMH7LxSd/4X9MQFRsp2zO1lb798=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=hgynLF8UoN6vi4XFEGn9wkqyr0ne5L7TIXhmPeFXdGrZNivi9wEi5woBPMV/P6WfUoOMY7ss
 64J/tH7Gr5QXXH81T4XxkSgIWlvPwzoUUu6xobgmZyoC/mrMw54pMpD8NEDAsYYiPfeWS+0pxF
 KZyk/1jWACLIwDz/MEY0u9tdMMsI1xO0d8kQfezGEX1F+05gu+qEdn6JFTNQ2d5ZBmIUfnB68z
 icQCC0+rAgl+q8cJ9diyUrukwr1DmB0atuGnx03iCiY4DMjrov7CPS5OnCalQQD9UGEseThy+2
 1WW8U0YRvNce4qf+NeY90ifF4qhM8OVuahFQT/RpSheY07Rg==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 15 Dec 2025 17:06:33 +0000
"Johannes Schindelin wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When that function was introduced in bb4285206207 (Cygwin: pty: Implement
> new pseudo console support., 2020-08-19) (back then, it was added to
> `spawn.cc`, later it was moved to `fhandler/termios.cc` in 32d6a6cb5f1e
> (Cygwin: pty, console: Encapsulate spawn.cc code related to
> pty/console., 2022-11-19)), it was implemented with strong assumptions
> that neither creating the file handle nor reading 1024 bytes from said
> handle could fail.
> 
> This assumption, however, is incorrect. Concretely, I encountered the
> case where `is_console_app()` needed to open an app execution alias,
> failed to do so, and still tried to read from the invalid handle.
> 
> Let's add some error handling to that function.
> 
> Fixed: bb4285206207 (Cygwin: pty: Implement new pseudo console support., 2020-08-19)

Fixes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/termios.cc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> index a3cecdb6f..808d0d435 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -707,10 +707,14 @@ is_console_app (const WCHAR *filename)
>    HANDLE h;
>    h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
>  		   NULL, OPEN_EXISTING, 0, NULL);
> +  if (h == INVALID_HANDLE_VALUE)
> +    return false;
>    char buf[1024];
>    DWORD n;
> -  ReadFile (h, buf, sizeof (buf), &n, 0);
> +  BOOL res = ReadFile (h, buf, sizeof (buf), &n, 0);
>    CloseHandle (h);
> +  if (!res)
> +    return false;
>    /* The offset of Subsystem is the same for both IMAGE_NT_HEADERS32 and
>       IMAGE_NT_HEADERS64, so only IMAGE_NT_HEADERS32 is used here. */
>    IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
> -- 
> cygwingitgadget

Other than that, LGTM.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
