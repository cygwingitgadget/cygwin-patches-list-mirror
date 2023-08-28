Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DF2183858D28; Mon, 28 Aug 2023 10:58:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF2183858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1693220312;
	bh=8QU05jwClJoUIF3iw8W8HgK+2D5V35WoCWOD1G7pWvw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=EggMEPNIFVmMjoA8438l58Go7af0Pj3A1J+hkv5rEhEBs3Geh8URZo3IwdrIlwmG8
	 ubWbJk9EXAuX5M5W65muicqTBY7JdW9UJCP7g03J53FrojYFSOmkTsEaIEc5I3ZGd3
	 DOc3pF1Q0dcw/s0MNedAv8I1Fr4IgDcZMk2/r+1g=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 24A7BA80D4E; Mon, 28 Aug 2023 12:58:31 +0200 (CEST)
Date: Mon, 28 Aug 2023 12:58:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: termios: Refactor the function is_console_app().
Message-ID: <ZOx911vVsEZOgfgI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230828092129.770-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828092129.770-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Aug 28 18:21, Takashi Yano wrote:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/termios.cc | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> index 789ae0179..d106955dc 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -704,22 +704,20 @@ static bool
>  is_console_app (const WCHAR *filename)
>  {
>    HANDLE h;
> -  const int id_offset = 92;
>    h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
>  		   NULL, OPEN_EXISTING, 0, NULL);
>    char buf[1024];
>    DWORD n;
>    ReadFile (h, buf, sizeof (buf), &n, 0);
>    CloseHandle (h);
> -  char *p = (char *) memmem (buf, n, "PE\0\0", 4);
> -  if (p && p + id_offset < buf + n)
> -    return p[id_offset] == '\003'; /* 02: GUI, 03: console */
> -  else
> -    {
> -      wchar_t *e = wcsrchr (filename, L'.');
> -      if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
> -	return true;
> -    }
> +  /* The offset of Subsystem is the same for both IMAGE_NT_HEADERS32 and
> +     IMAGE_NT_HEADERS64, so only IMAGE_NT_HEADERS32 is used here. */
> +  IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);

Please use PIMAGE_NT_HEADERS instead and just drop the comment.
We don't support 32 bit anyway.


Thanks,
Corinna
