Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2FEAD4B9DB42; Thu, 12 Feb 2026 20:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2FEAD4B9DB42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770928455;
	bh=BzoFQFqzVWeeCna9Tzc9+TbhzHl3HCEZGVmPoSKFjOo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fq2VgApix7izpu2Od8Todvxd3Qe9uOX8ydhtZXnJ9HXv2KBwM6QxhGc7TCl/ChKzS
	 hqqIy8EXWoccTyTGbvpfXQIVNM9Tq9QLRh67QzitTsBtocN6Uh4b0cQs9qh/xH/j6J
	 O6MYu1+e9Dbwzt2gPPfbdKAgmc+NUpO3oqIDrpmY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 47064A80982; Thu, 12 Feb 2026 21:34:13 +0100 (CET)
Date: Thu, 12 Feb 2026 21:34:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
Subject: Re: [PATCH] Cygwin: hookapi.cc: Fix some handles not being inherited
 when spawning
Message-ID: <aY45Re_bOuUxBUrz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
References: <aY4Gibum9Q1gj9lp@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aY4Gibum9Q1gj9lp@arm.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 12 16:57, Igor Podgainoi wrote:
> Under Windows on Arm (AArch64), the function hook_or_detect_cygwin will
> return NULL early, which will cause the call to real_path.set_cygexec
> in av::setup to accept false as a parameter instead of true.
> 
> Afterwards, in child_info_spawn::worker the call to
> child_info_spawn::set would eventually pass that false result of
> real_path.iscygexec() to the child_info constructor as the boolean
> variable need_subproc_ready, where the flag _CI_ISCYGWIN will be
> erroneously not set.
> 
> Later in child_info_spawn::worker the failed iscygwin() flag check will
> cause the "parent" process handle to become non-inheritable. This patch
> fixes the non-inheritability issue by introducing a new check for the
> IMAGE_FILE_MACHINE_ARM64 constant in the function PEHeaderFromHModule.
> 
> Tests fixed on AArch64:
> winsup.api/signal-into-win32-api.exe
> winsup.api/ltp/fcntl07.exe
> winsup.api/ltp/fcntl07B.exe
> winsup.api/posix_spawn/chdir.exe
> winsup.api/posix_spawn/fds.exe
> winsup.api/posix_spawn/signals.exe
> 
> Signed-off-by: Igor Podgainoi <igor.podgainoi@arm.com>
> ---
>  winsup/cygwin/hookapi.cc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/winsup/cygwin/hookapi.cc b/winsup/cygwin/hookapi.cc
> index ee2edbafe..b0126ac04 100644
> --- a/winsup/cygwin/hookapi.cc
> +++ b/winsup/cygwin/hookapi.cc
> @@ -45,6 +45,8 @@ PEHeaderFromHModule (HMODULE hModule)
>      {
>      case IMAGE_FILE_MACHINE_AMD64:
>        break;
> +    case IMAGE_FILE_MACHINE_ARM64:
> +      break;
>      default:
>        return NULL;
>      }
> -- 
> 2.43.0

Pushed.


Thanks,
Corinna
