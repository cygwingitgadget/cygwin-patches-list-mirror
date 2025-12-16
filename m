Return-Path: <SRS0=XNg2=6W=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id EEFB44BA2E05
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 08:46:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EEFB44BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EEFB44BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765874818; cv=none;
	b=dpkMqroThIpPoBiC2YV/1mgZ8LQN7h/4TUWEs6p/SPz/v6LVe/5V2PoHkd9wzNBsve01dy2o7rjLFTNV4eogbySmuDQ460zQ6xcE6i3WPbD1prLpMmNvAII6ax2XN/NWhFy1MHB+6FoN0Y50sYIu5ehdXfrnJ/ht9M6ejtw0Mko=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765874818; c=relaxed/simple;
	bh=Ef0DLQplseSH8h75jul/9Vr1PUhAz5/oi20ygz8ZcVc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Nx07TbNjOQyz8C/sEq8ss2JDHKQvWfey3oJZg23pO27BSxvUQvT/qr8Sb6HSdof6+aK99bvjPtvtC0/Gx7oU3T7luCtKyBqcEEoNsHekAeX+Nk7MQ5qDbE+zzNWQ4nME+BvDZo1Fe9glcbUA74/KQYpQGhgNQbqaMzATUSuYIko=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EEFB44BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZZd9xWYL
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251216084655805.GCBC.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 17:46:55 +0900
Date: Tue, 16 Dec 2025 17:46:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/3] Cygwin: is_console_app(): deal with the
 `.bat`/`.cmd` file extensions first
Message-Id: <20251216174653.e58778698c1e981dc36a9982@nifty.ne.jp>
In-Reply-To: <8e9732407ff389b2bcf978b79d8308e0471980fe.1765818395.git.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
	<8e9732407ff389b2bcf978b79d8308e0471980fe.1765818395.git.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765874815;
 bh=pPU0F7GABG/EyTFBAG0+y9FLHf8pDpzXYBGkTNK3zJA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ZZd9xWYLBMR8RgZ8pcY6b5tmuJoSmX7Ve78Dgwlf6HtQBK0ZP1wQMD8la3FDOS15iYvhCbQj
 OgmHxXvpQRjznGZYkpul/WSgfcnZtRh4ISdv+HNMhZIe+GYL9ye/Da2DpAqw323AiPU/K7Vfuc
 4b8WFtSzTFWolW0ucG2bwAeGEDR1jDaCE0OC/SPgxQrNTFriF6sqSUteaFMeDgPOMqu5LPV8B3
 7ooggy3+ex6fl7qVVhGqZFwv0r0sVbMNCOnN89GmRuKy4rJKDa860BcyO8kYHjwsB5qGfLDqe1
 icLikVEYkRMJM4k4FrtBYhbhR+9x+SP/lQ7RudIKjtMaDesg==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 15 Dec 2025 17:06:34 +0000
"Johannes Schindelin wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This function contains special handling of these file extensions,
> treating them as console applications always, even if the first 1024
> bytes do not contain a PE header with the console bits set.
> 
> However, Batch and Command files are never expected to have such a
> header, therefore opening them and reading their first bytes is a waste
> of time.
> 
> Let's honor the best practice to deal with easy conditions that allow
> early returns first.
> 
> Fixed: bb4285206207 (Cygwin: pty: Implement new pseudo console suppot., 2020-08-19)
  ~~~~~
Fixes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/termios.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> index 808d0d435..5505bf416 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -704,6 +704,9 @@ fhandler_termios::fstat (struct stat *buf)
>  static bool
>  is_console_app (const WCHAR *filename)
>  {
> +  wchar_t *e = wcsrchr (filename, L'.');
> +  if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
> +    return true;
>    HANDLE h;
>    h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
>  		   NULL, OPEN_EXISTING, 0, NULL);
> @@ -720,9 +723,6 @@ is_console_app (const WCHAR *filename)
>    IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
>    if (p && (char *) &p->OptionalHeader.DllCharacteristics <= buf + n)
>      return p->OptionalHeader.Subsystem == IMAGE_SUBSYSTEM_WINDOWS_CUI;
> -  wchar_t *e = wcsrchr (filename, L'.');
> -  if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
> -    return true;
>    return false;
>  }
>  
> -- 
> cygwingitgadget
> 

Ohter than above, LGTM. Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
