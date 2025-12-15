Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A11914BA2E04; Mon, 15 Dec 2025 15:20:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A11914BA2E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765812035;
	bh=aoc9WpORp/mY8kOkqc7Ctd6+7cn/SzXGff4yhSb80KQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=tab0YzdkUdNojywO8+k2Tw0eIQWrTg/JR7aRyBWnBJTOuAOQgaHtNAPXNfpUcy+BN
	 Pa2Gs7lU/okd0FGCd/Lyye1kgvcwEF+kJ0oshaYXS0Smd/xl+rIJNetcJ27IMnuGsm
	 s8gXYwniRhafKfg+rrIo4mbD86L7J0Bs727T3rRY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 980DDA80CA4; Mon, 15 Dec 2025 16:20:33 +0100 (CET)
Date: Mon, 15 Dec 2025 16:20:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: is_console_app(): do handle errors
Message-ID: <aUAnQaqWJdcbR0fo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
 <7edad15ac37571d0ddb2bd4716625feb03875e5a.1765809440.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7edad15ac37571d0ddb2bd4716625feb03875e5a.1765809440.git.gitgitgadget@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Dec 15 14:37, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When that function was introduced in bb42852062 (Cygwin: pty: Implement
> new pseudo console support., 2020-08-19) (back then, it was added to
> `spawn.cc`, later it was moved to `fhandler/termios.cc` in 32d6a6cb5f
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
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

  Fixes: <12-digit-SHA1> ("commit messaage headline")

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
