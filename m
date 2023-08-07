Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 915793857034; Mon,  7 Aug 2023 11:17:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 915793857034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1691407076;
	bh=5BQIUzovX9xo6GdWjLteknMzNU+qXk70zCjWh8EiwkE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bNEoQv9SVhicUAarOwq6OK9A/o8gIOzXBffxTkwblI+6DhgPKll3N5ICYGp2PpscV
	 DjYx9h9sGokGf130vK/VOFU0aqN1RIYCG+98nU2D8KwDaQ6l7gNMlzE7bn6eu6RAio
	 OE11rMqvTm1yWDcEqwIidGZe+gwTHRWV1IBvGq50=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C0525A80BDA; Mon,  7 Aug 2023 13:17:54 +0200 (CEST)
Date: Mon, 7 Aug 2023 13:17:54 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Les De Ridder <les@lesderid.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Detect RAM disks as a separate filesystem type
Message-ID: <ZNDS4sMtodnAyOGZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Les De Ridder <les@lesderid.net>,
	cygwin-patches@cygwin.com
References: <cover.1690932049.git.les@lesderid.net>
 <9d1cbf57a0ff67bb9d7af619e24a86005cad1cbf.1690932049.git.les@lesderid.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d1cbf57a0ff67bb9d7af619e24a86005cad1cbf.1690932049.git.les@lesderid.net>
List-Id: <cygwin-patches.cygwin.com>

Hi Les,

your 2nd patch looks good to me, but this patch is a bit questionable.

On Aug  7 03:13, Les De Ridder wrote:
> diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
> index 36ab042a7..1950dadb0 100644
> --- a/winsup/cygwin/mount.cc
> +++ b/winsup/cygwin/mount.cc
> @@ -292,6 +292,17 @@ fs_info::update (PUNICODE_STRING upath, HANDLE in_vol)
>    if (!NT_SUCCESS (status))
>      ffdi.DeviceType = ffdi.Characteristics = 0;
>  
> +  if (upath->Buffer[5] == L':' && upath->Buffer[6] == L'\\')

If that's testing for a local drive path, it's probably wrong.  The
NtQueryVolumeInformationFile(FileFsDeviceInformation) call returns the
FILE_REMOTE_DEVICE flag and sets is_remote_drive() in line 298.  You
should use that flag.

This also means your code is called much too early in fs_info::update.
The preceeding code for file systems not providing valid serial numbers
is an exception from the rule because we need the serial number for
caching.  Generically checking for another local filesystem should be
performed after the  "if (is_remote_drive ())" expression, so starting
somewhere below line 495.

> +   {
> +     WCHAR dos[3] = {upath->Buffer[4], upath->Buffer[5], L'\0'};
> +     WCHAR dev[MAX_PATH];
> +     if (QueryDosDeviceW (dos, dev, MAX_PATH))
> +       {
> +          is_ramdisk (wcsncmp (dev, L"\\Device\\Ramdisk", 15));
> +          has_buggy_reopen (is_ramdisk ());
> +       }
> +   }
> +

This gives me headaches.  Did you check *all* the information returned
by the various NtQueryVolumeInformationFile calls?  I. e., what is
returned by all these calls?  What is the FS name set to?  Which flags
are set in FileSystemAttributes?  What is DeviceType and Characterisitics
set to?

We should really check all info already available from the
NtQueryVolumeInformationFile calls first, and please paste here the
information you get from these calls.

Also, even if all else fails, rather than calling QueryDosDeviceW we
should use NtQueryVolumeInformationFile(FileFsDriverPathInformation)
instead.


Thanks,
Corinna
