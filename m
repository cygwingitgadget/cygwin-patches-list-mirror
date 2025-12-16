Return-Path: <SRS0=XNg2=6W=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 3FE8D4BA2E04
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 08:48:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3FE8D4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3FE8D4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765874891; cv=none;
	b=ticRv3gRyt1dVkj0HpkXfNtYkQVQiDBhc82hQizoHYN/ysx+cBqRZka3jgG1KpjPfi0jxpia0y0COhx+kRcgUaf3jU3xm5xwAcTVru2oLsruOQyMwEIh2S2rBb2Kj7f7c57G5xUSDZwtAshH1LfkBZu04kEJdohF/KgVVaZDUAs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765874891; c=relaxed/simple;
	bh=UTw8pvVCEEd1QeVP1EY0K83BUkc72xJL70gSzzOItUg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=KZAOsAkxyinFCr/GGXzlm5CG59eMFdZ+OcXszUk7witYacTd4CI8jS3BBsX9y76UqEcMtQVdxRI0xt2v89WwM7wggOV1khcq55Ie/S0NMrGBLMW21GKD3zjK8GdjSlKDms4+x1oZEoEBZWvZE8FWIzPhH1riAR4tHf2t2ckCaU4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3FE8D4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=P6ndk4+A
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20251216084808033.NCIV.84842.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 17:48:08 +0900
Date: Tue, 16 Dec 2025 17:48:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/3] Cygwin: is_console_app(): deal with the
 `.bat`/`.cmd` file extensions first
Message-Id: <20251216174805.e893be61cef816478ae3f2ff@nifty.ne.jp>
In-Reply-To: <8e9732407ff389b2bcf978b79d8308e0471980fe.1765818395.git.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
	<8e9732407ff389b2bcf978b79d8308e0471980fe.1765818395.git.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765874888;
 bh=RXI08k67Xyc/1HKMwyOmv17UR8AB/u88XWlrbitrR5Y=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=P6ndk4+AYFceUN48kqnWLIBpouA5CbFoteo4nRaXAMgdtuHkHtaeb2twgtFBFLQDC4NUYal8
 iOfCruOQikC0OWGMWY/c9GAxauY1z53rimt/fxUoOk70RKZ4PPX9wRkDKtvvOcoc7KFsc8V/pi
 rhg3imWFsD6JiNqPhPGOFqzwj3yj6Vf7CVvDLt8h2gGNzJchzFwolD6GAaC0KW+mqJhK9CqIIm
 snNJT63m9YY0M7785wGYFUaCQCkKXzb9+fcF2hUqX5DybEob97gYiadrpCHvrZKssu2NuPOjtB
 b7vn5herlsU328CfREtaB2SmJMMr4CoZvA/+yFPaqcwLhfcw==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Other than that, LGTM.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
