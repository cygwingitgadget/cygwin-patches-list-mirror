Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A43183858D37; Mon, 14 Jul 2025 11:41:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A43183858D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752493312;
	bh=kTPqwV9JYERKxL3y5R38MCUE015HoAyOgk7fzcFhqXg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ygRloiOF2H6mwKuERCf5XQxIShCc7sztpsWv6joNtf6hWu+uNgckUV+2YSLasXeub
	 1PDE2ZXWY8TcU9YDGZyETzKZXWN0sbAEWzQulF/AQ3XuXCmFjj/OHtoO/1ZWUu38ng
	 ozUDA14eyw0ub9gBwTS7jq2mIfDVHyAniC8oB01A=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DBB92A806FF; Mon, 14 Jul 2025 13:41:50 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:41:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: cygcheck: port to AArch64
Message-ID: <aHTs_sKuNZ1OkBvc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB09236B2289D6307E787D64FC9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB09232BEB586BCF0576FD69CD9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB09232BEB586BCF0576FD69CD9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Radek,

I'm not sure about one change here:

On Jul 10 10:10, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Sending the same patch with more detailed commit message added.
> 
> Radek
> ---
> >From ebec7171c9fdf162e0d193f7ba3468766191cc8d Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Mon, 9 Jun 2025 13:08:35 +0200
> Subject: [PATCH v2] Cygwin: cygcheck: port to AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch ports `winsup/utils/mingw/cygcheck.cc` to AArch64:
>  - Adds arch=aarch64 to packages API URL.
>  - Ports dll_info function.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/utils/mingw/cygcheck.cc | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.cc
> index 89a08e560..6ec7bcf03 100644
> --- a/winsup/utils/mingw/cygcheck.cc
> +++ b/winsup/utils/mingw/cygcheck.cc
> @@ -654,13 +654,20 @@ dll_info (const char *path, HANDLE fh, int lvl, int recurse)
>    WORD arch = get_word (fh, pe_header_offset + 4);
>    if (GetLastError () != NO_ERROR)
>      display_error ("get_word");
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>    if (arch != IMAGE_FILE_MACHINE_AMD64)
>      {
>        puts (verbose ? " (not x86_64 dll)" : "\n");
>        return;
>      }
>    int base_off = 108;
> +#elif defined (__aarch64__)
> +  if (arch != IMAGE_FILE_MACHINE_ARM64)
> +    {
> +      puts (verbose ? " (not aarch64 dll)" : "\n");
> +      return;
> +    }
> +  int base_off = 112;

base_off is the offset of the NumberOfRvaAndSizes field in the extended
COFF header.  This is documented(*) as being at offset 108 in the PE32+
format, independent of the targeted CPU.  112 is the offset of the
.edata section address and size info in the PE32+ data directory entries.

So I have a problem with changing the offest here.  Can you please check
again if that's really correct?  If so, the documentation(*) needs an
update.

(*) https://learn.microsoft.com/en-us/windows/win32/debug/pe-format


Thanks,
Corinna
