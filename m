Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1E9233858D20; Tue, 18 Feb 2025 20:13:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1E9233858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739909638;
	bh=nscMasHWMHwhm2HMRB/zNEIT1KAvfO3NYrFlV6QyxhQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=SBmBa5jS0GTCusPoC3DY+LogvrxnSBMdnoGdKjQAtoLhVZOytW5Mg9RNN+hDcRrz5
	 sU7/fdGZHxgyIJIec1Y8+dMD9ZEdA6M78/t3KIRL5ZG5ZJ4aJvQxrOWN3rl9M6rn5A
	 CbAR7ODugn+7iQHLD4uTY98o/oTParUFyFh44/HA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DE71DA817D2; Tue, 18 Feb 2025 21:13:22 +0100 (CET)
Date: Tue, 18 Feb 2025 21:13:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: skip floppy drives in cygdrive_getmntent.
Message-ID: <Z7Tp4rcELz6-hvGW@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <df854454-c96e-8fe0-ead7-c70c566ec1d3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df854454-c96e-8fe0-ead7-c70c566ec1d3@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Feb 18 10:38, Jeremy Drake via Cygwin-patches wrote:
> @@ -1742,17 +1742,19 @@ struct mntent *
>  mount_info::cygdrive_getmntent ()
>  {
>    tmp_pathbuf tp;
> -  const wchar_t *wide_path;
> +  dos_drive_mappings::dos_device_mountpoint dos_mount;
>    char *win32_path, *posix_path;
> 
>    if (!_my_tls.locals.drivemappings)
>      _my_tls.locals.drivemappings = new dos_drive_mappings ();
> 
> -  wide_path = _my_tls.locals.drivemappings->next_dos_mount ();
> -  if (wide_path)
> +  dos_mount = _my_tls.locals.drivemappings->next_dos_mount ();
> +  while (dos_mount.device && get_device_type (dos_mount.device) == DT_FLOPPY)
> +    dos_mount = _my_tls.locals.drivemappings->next_dos_mount ();

Actually, given that we can't do without GetLogicalDrives anyway,
this could be folded into the mapping list creation within
dos_drive_mappings::dos_drive_mappings.


Corinna
