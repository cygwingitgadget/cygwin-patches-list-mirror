Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 881754BA2E25; Mon, 15 Dec 2025 15:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 881754BA2E25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765812423;
	bh=4DDp9HgYxEZ6CErt4eNrfhRmUNN74fHI/Qw1FdUpdxA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A7kCUnNZ6QuO++SISfJLWJPBi25kv2zAISWlh06/8H/l8BKTFBB62PQqgs5EqYX3F
	 Ri3o1CQNIQbS3nYOLLG3TsZjLSjyL81ov5nYc7MQCv2/jk5k4V9PfRyP53b/B35zv+
	 blm1MmCZ/DaVJVpMJEVV2h1U+ZouPpVeuvh8k41o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B4B6EA80CA4; Mon, 15 Dec 2025 16:27:01 +0100 (CET)
Date: Mon, 15 Dec 2025 16:27:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com, Cody Tapscott <cody@tapscott.me>
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
Message-ID: <aUAoxVEKMpj6xNjM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com,
	Cody Tapscott <cody@tapscott.me>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
 <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Johannes, Takashi,

On Dec 15 14:37, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 0a9ee3ea23 (Allow executing Windows Store's "app execution aliases",
> 2021-03-12), I introduced support for calling Microsoft Store
> applications.
> 
> However, it was reported several times (first in
> https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=jUHL_pShff+aRv9P1Eiug@mail.gmail.com
> and then also in
> https://github.com/msys2/MSYS2-packages/issues/1943#issuecomment-3467583078)
> that there is something amiss: The standard handles are not working as
> expected, as they are not connected to the terminal at all (and hence
> the application seems to "hang").
> 
> The culprit is the `is_console_app()` function which assumes that it can
> simply open the first few bytes of the `.exe` file to read the PE header
> in order to determine whether it is a console application or not.
> 
> For app execution aliases, already creating a regular file handle for
> reading will fail. Let's introduce some special handling for the exact
> error code returned in those instances, and try to read the symlink
> target instead (taking advantage of the code I introduced in 0631c6644e
> (Cygwin: Treat Windows Store's "app execution aliases" as symbolic
> links, 2021-03-22) to treat app execution aliases like symbolic links).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/termios.cc | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> index 5505bf416..6edd5be9b 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -710,6 +710,19 @@ is_console_app (const WCHAR *filename)
>    HANDLE h;
>    h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
>  		   NULL, OPEN_EXISTING, 0, NULL);
> +  if (h == INVALID_HANDLE_VALUE && GetLastError () == ERROR_CANT_ACCESS_FILE)
> +    {
> +      UNICODE_STRING ustr;
> +      RtlInitUnicodeString (&ustr, filename);
> +      path_conv pc (&ustr, PC_SYM_FOLLOW);
> +      if (!pc.error && pc.exists ())
> +	{
> +	  tmp_pathbuf tp;
> +	  PWCHAR path = tp.w_get ();
> +	  h = CreateFileW (pc.get_wide_win32_path (path), GENERIC_READ,
> +		           FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
> +	}
> +    }
>    if (h == INVALID_HANDLE_VALUE)
>      return false;
>    char buf[1024];

Erm... does this patch collide with
https://sourceware.org/pipermail/cygwin-patches/2025q4/014421.html
by any chance?  Are you both trying to fix the same problem somehow?


Thanks,
Corinna
