Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B430B3858D34; Mon,  9 Dec 2024 12:13:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B430B3858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733746382;
	bh=I8iGf1wNyLfCH5mCyzL5fpKvxtPvZlrSt6B+Yo85Yrw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=FrTLI0N3bsJtJ/etve+5O1VHOz5uNIkP6sk8IblCUyLDqds40nTY4C206GzGe3T0L
	 21JgBeBTtXhOlOD3XQuGsXVKJHdILmstxuGGxW/vtv1xGhHC1P9SCF2NSWyFTwiVaV
	 OeGZcs0NO7715kRdIi0sBEksUt1vBKgm5Ht+0JH0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AEC22A8093F; Mon,  9 Dec 2024 13:13:00 +0100 (CET)
Date: Mon, 9 Dec 2024 13:13:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: disk_file: Add error handling to
 fhandler_base::fstat_helper
Message-ID: <Z1bezEg87t-BRgHU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241208074410.1772-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241208074410.1772-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Dec  8 16:43, Takashi Yano wrote:
> Previous fhandler_base::fstat_helper() does not assume get_stat_handle()
> returns NULL. Due to this, access() for network share which has not been
> authenticated returns 0 (success). This patch add error handling to
> fhandler_base::fstat_helper() for get_stat_handle() failure.
> 
> Fixed: 5a0d1edba4b3 [...]
  ^^^^^
  Fixes

> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/disk_file.cc | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/disk_file.cc b/winsup/cygwin/fhandler/disk_file.cc
> index 2008fb61b..7c3c805fd 100644
> --- a/winsup/cygwin/fhandler/disk_file.cc
> +++ b/winsup/cygwin/fhandler/disk_file.cc
> @@ -400,6 +400,11 @@ fhandler_base::fstat_helper (struct stat *buf)
>    IO_STATUS_BLOCK st;
>    FILE_COMPRESSION_INFORMATION fci;
>    HANDLE h = get_stat_handle ();
> +  if (h == NULL)
> +    {
> +      __seterrno ();
> +      return -1;
> +    }
>    PFILE_ALL_INFORMATION pfai = pc.fai ();
>    ULONG attributes = pc.file_attributes ();

This introduces a regression from the user perspective.

The underlying fstat functions were meant to return *something*, no
matter how few information we got, as long as the file exists.

The reason is, for example, that Windows disallows to fetch stat(2)
information on files you don't have permissions on. For instance,
pagefile.sys.  On POSIX, you don't expect that stat(2) fails for these
files, even if you can't access them in any other way.

So prior to your patch, ls doesn't fail on pagefile.sys:

  $ ls -l /cygdrive/c/pagefile.sys
  -rw-r----- 1 Unknown+User Unknown+Group 2550136832 Dec  1 11:45 /cygdrive/c/pagefile.sys

The file exists, the stat(2) info is partially available.

After your patch:

  $ ls -l /cygdrive/c/pagefile.sys
  ls: cannot access '/cygdrive/c/pagefile.sys': Device or resource busy

Along these lines, if a share exists and is visible, stat(2) info should
be available just the same as for pagefile.sys, even if you can't access
the share otherwise.


Corinna
