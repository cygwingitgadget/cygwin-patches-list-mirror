Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 648203858D33; Mon, 20 Nov 2023 20:02:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 648203858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700510554;
	bh=y+y3p0a6rTz/ac0hcYEsTHIoeliucxAcfD4J1hTVEN0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=uEQaWfjhlgSkJKBd3n0a0JCJVy6R6xOKNnonCV3fSzOaye17jg8B52R3CzYb82nG+
	 ao3JJ7hMALMaelasep4ZboP0/aEnkVT4NtUYUzwVglB+mZRbTiw+qvKrairzqFsUNj
	 vfYOogjuiSkpJ66rqw/xdu8x2mMP87LkrLIQXlnc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A636CA809BE; Mon, 20 Nov 2023 21:02:32 +0100 (CET)
Date: Mon, 20 Nov 2023 21:02:32 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
Message-ID: <ZVu7WIleLhcAx9KQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9c82a61c-02f8-a679-90f2-90e853d47e53@t-online.de>
 <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
 <57fb24ee-cd4c-0b54-6613-40f817e12571@t-online.de>
 <ZVeZhRmrMlbK7qkz@calimero.vinschen.de>
 <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
 <ZVfBmQiTGOjx14lW@calimero.vinschen.de>
 <b924c0f6-7ac1-9fa8-f828-0482f1ea5d36@t-online.de>
 <ZVsppVEdC+HW2NE5@calimero.vinschen.de>
 <ZVsrDfTnL6Fy3BfM@calimero.vinschen.de>
 <0f8c8b7e-8a67-bc0a-24c3-91d28e2f0972@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f8c8b7e-8a67-bc0a-24c3-91d28e2f0972@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 20 15:54, Christian Franke wrote:
> From: Christian Franke <christian.franke@t-online.de>
> Date: Mon, 20 Nov 2023 15:40:42 +0100
> Subject: [PATCH] Cygwin: /dev/disk/by-uuid: Fix NTFS serial number print
>  format
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/fhandler/dev_disk.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/dev_disk.cc b/winsup/cygwin/fhandler/dev_disk.cc
> index 016b4c7bc..c5d72816f 100644
> --- a/winsup/cygwin/fhandler/dev_disk.cc
> +++ b/winsup/cygwin/fhandler/dev_disk.cc
> @@ -308,7 +308,7 @@ partition_to_label_or_uuid(bool uuid, const UNICODE_STRING *drive_uname,
>        && nvdb->VolumeSerialNumber.QuadPart)
>      {
>        /* Print without any separator as on Linux. */
> -      __small_sprintf (name, "%16X", nvdb->VolumeSerialNumber.QuadPart);
> +      __small_sprintf (name, "%016X", nvdb->VolumeSerialNumber.QuadPart);
>        NtClose(volhdl);
>        return true;
>      }
> -- 
> 2.42.1
> 

Pushed.

Thanks,
Corinna
