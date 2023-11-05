Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7DC073857838; Sun,  5 Nov 2023 19:59:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7DC073857838
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699214353;
	bh=WKT/TO7KBQD46Xhc+2bc6XslpEe1UgzFHPfAImaCeIA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=phpPGzd9bi+t/Zk5eSCDH3WmxOQGtiqJ0YB0ClgZ/UrcGMfzqwqmundqNa0K7aPQK
	 IhZBAPZu5QQU5rKXjD9i2aDj9cvj3IX8BILWmz9XmQR9tyuZE7ZWshlSC0I7sJwD+Y
	 1jrc8H5ja+uQ3YR8eeCyw2I0UiN7/tUOADElGRBI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D703DA80B99; Sun,  5 Nov 2023 20:59:11 +0100 (CET)
Date: Sun, 5 Nov 2023 20:59:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUf0DwCsxbuPR3iL@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <ZUT1JUYoh+y3H2wk@calimero.vinschen.de>
 <8ceefddf-6f66-ab44-f2fc-48072a5c7207@t-online.de>
 <ZUUfit/OdR3G5G/H@calimero.vinschen.de>
 <ZUUgKHqlCQRghuzy@calimero.vinschen.de>
 <1133d1d3-e6d9-4a52-a595-89ee338f8d2f@t-online.de>
 <ZUYQPPsrxf5yp1Ir@calimero.vinschen.de>
 <ZUYVeeYDcAKC74wg@calimero.vinschen.de>
 <c82507ab-193a-4a85-7ef0-64f7a7f30705@t-online.de>
 <ZUautCVKk4bXD4q4@calimero.vinschen.de>
 <eeee1473-7902-6ef7-9fab-cfc3f4eb2785@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eeee1473-7902-6ef7-9fab-cfc3f4eb2785@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Nov  5 16:45, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Do we really still need IOCTL_DISK_GET_DRIVE_LAYOUT w/o _EX?
> 
> Possibly not. I borrowed this code from code behind /proc/partitions.
> 
> > fhandler_proc still uses it, too, but the EX variation is available
> > since XP. I can't imagine that a fallback to the non-EX-version is still
> > necessary.  If you like you could drop it immediately, or we can drop
> > both usages as a followup patch.
> 
> Old IOCTL dropped and code simplified.

Great.  I pushed your patch.

However, while I was just happily removing the non-EX ioctl's from
fhandler/proc.cc I found that this isn't feasible:

The EX calls are not supported by the floppy driver.  D'uh.

So for /proc/partitions emulation we still need them.

> > Last, but not least, do you see a chance to add any other /dev/disk
> > subdir?  by-partuuid, perhaps?
> 
> Possibly, but not very soon. I'm not yet sure which API functions could be
> used.
> Some early draft ideas:
> 
> /dev/disk/by-partuid (Partition UUID -> device)
>   GPT_PART_UUID -> ../../sdXN (GPT partition UUID)
>   MBR_SERIAL-partN -> ../../sdYM (Fake UUID for MBR)

That should only require IOCTL_DISK_GET_PARTITION_INFO_EX, I think.

> /dev/disk/by-uuid (Windows Volume UUID -> device)
>   Vol_UUID1 -> ../../sdXN  (disk volume)
>   Vol_UUID2 -> ../../scd0  (CD/DVD drive volume)
>   Vol_UUID3 -> /proc/sys/GLOBAL??/Volume{UUID}  (others, e.g. VeraCrypt
> volume)

Yeah, tricky. These are not the partition GUIDs but the filesystem
GUIDs or serial numbers.  AFAICS, Windows filesystems (FAT*, NTFS)
don't maintain a filesystem GUID, as, e. g., ext4 or xfs, but only
serial numbers you can fetch via NtQueryVolumeInformationFile.
A Linux example of that is the serial number from a FAT32 filesytem
as the EFI boot partition in by-uuid:

  lrwxrwxrwx 1 root root 10 Oct 30 10:20 DC38-0407 -> ../../sda1

On second thought, maybe that's sufficient for our by-uuid emulation.

> /dev/disk/by-drive (Cygwin specific: drive letter -> volume)
>   c -> ../by-uuid/UUID (if UUID available)
>   x -> /proc/sys/DosDevices/X: (others, e.g. Network, "mounted" Volume
> Shadow Copy)

Ah, good idea. That's what my extension in /proc/partition already
provides, but a /dev/disk/by-drive sounds like a great idea.


Thanks,
Corinna
