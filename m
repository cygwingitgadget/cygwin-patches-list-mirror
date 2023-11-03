Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6D0173858D28; Fri,  3 Nov 2023 09:55:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6D0173858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699005305;
	bh=A9jHKtmo3N4Q1WS8ofCUnJTM3C/oV/nSQ0CwSNaR3kE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=H8JNKvPF2E6hdIrCf3R9lU+tXzW9cvA6bOL8RiNhoD2+duPT4Xz8CCd1TQi8S1x5v
	 /DS2QmRgBi1KG/UtVuRezlKHB+hw489SgKOsgDLIEZKQBgGfLP2nN67joW5AWy3yJq
	 t4aSXPur1rDzQFJUrOWdMeH1FRxI1EGggnrYUvYs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3369CA80706; Fri,  3 Nov 2023 10:55:03 +0100 (CET)
Date: Fri, 3 Nov 2023 10:55:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUTDd9BH4iysokAl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <9cf93e3b-36c8-a50c-0154-85f06da29d61@t-online.de>
 <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Oct  3 14:39, Christian Franke wrote:
> Christian Franke wrote:
> > This is a first attempt to partly emulate the Linux directory
> > /dev/disk/by-id. Useful to make sure the correct device is accessed in
> > conjunction with dd, ddrescue, fdisk, ....
> 
> Attached is the second attempt.
> 
> 
> > The additional '*-partN' links to partitions are not yet included.
> 
> These are now included.
> 
> 
> > This only works properly if Win32 path '\\.\PhysicalDriveN' is always
> > trivially mapped to NT path '\Device\HarddiskN\Partition0'.
> > IOCTL_STORAGE_QUERY_PROPERTY with a handle from NtOpenFile(.,
> > READ_CONTROL,...) instead of CreateFile(., 0, ...) did not work with all
> > drivers. With stornvme.sys, it fails with permission denied. Perhaps
> > other permission bits are required for NtOpenFile(). Thanks for any info
> > regarding this.
> 
> According to NtQueryObject(., ObjectBasicInformation, ...), using
> NtOpenFile(., MAXIMUM_ALLOWED, ...) without admin rights sets GrantedAccess
> to 0x001200a0 (FILE_EXECUTE|FILE_READ_ATTRIBUTES|READ_CONTROL|SYNCHRONIZE).
> For some unknown reason, NVMe drives behind stornvme.sys additionally
> require SYNCHRONIZE to use IOCTL_STORAGE_QUERY_PROPERTY. Possibly a harmless
> bug in the access check somewhere in the NVMe stack.
> 
> The disk scanning from the first patch has been reworked based on code
> borrowed from proc.cc:format_proc_partitions(). For the longer term, it may
> make sense to provide one flexible scanning function for /dev/sdXN,
> /proc/partitions and /proc/disk/by-id.

I applied your patch locally (patch looks pretty well, btw) but found
that /dev/disk/by-id is empty, even when running with admin rights.

I ran this on Windows 11 and Windows 2K19 in a QEMU/KVM VM.  A
\Device\Harddisk0\Partition0 symlink pointing to \Device\Harddisk0\DR0
exists in both cases.  I straced it, and found the following debug
output:

  1015 1155432 [main] ls 361 stordesc_to_id_name: Harddisk0\Partition0: 'Red_Hat' 'VirtIO' '' (ignored)

Is that really desired?


Thanks,
Corinna
