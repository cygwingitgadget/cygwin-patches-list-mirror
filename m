Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B7F953858D20; Thu, 16 Nov 2023 10:36:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B7F953858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700130975;
	bh=G7fXgSIziftSe2buFY0esztpEGfxHoSj+Fn2zwzapPk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=gI1z1yHH7G3ewZai5Z7BFX3xIuGm3xBNt7pGvQkT0zRRlDCFe2VuohNvp3C7RN+jd
	 Vtw464pyVggT1VXvMpyMb2iZ2E18oOZ3LU0AwlNr8KDkXaRKB276QBnRtn457uLaPk
	 u6KLSQvM9b/1Zyu4fICVhZOUgRHRv7JdzPR53dWg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E265EA80C84; Thu, 16 Nov 2023 11:36:13 +0100 (CET)
Date: Thu, 16 Nov 2023 11:36:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-drive and /dev/disk/by-uuid
 symlinks
Message-ID: <ZVXwnUgd3UnIqBQf@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5db42b33-ed93-2e7c-977a-89d407137d86@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5db42b33-ed93-2e7c-977a-89d407137d86@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Nov 15 18:23, Christian Franke wrote:
> This is the next (and possibly last for now) extension to the /dev/disk
> directory. Limited to disk related entries which allowed a straightforward
> extension of the existing code.
> 
> My original idea was to add also other drive letters and volume GUIDs. Too
> complex for now.
> 
> Interestingly the volume GUID (by-uuid) for partitions on MBR disks is
> sometimes identical to the partition "GUID" (by-partuuid), sometimes (always
> for C:?) not. With GPT disks, both GUIDs are possibly always identical.

That looks great, but in terms of by-uuid, I'm not sure it's the
right thing to do.  On Linux I have a vfat partition (/boot/efi).
The uuid in /dev/disk/by-uuid is the volume serial number, just
with an extra dash, i.e.

  057A-B3A7 -> ../../sda1

That's what you get for FAT/FAT32/exFAT.

I also tried an NTFS partition and the output looks like this:

  0FD4F62866CFBF09 -> ../../sdc1

This is the 64 bit volume serial number as returned by
DeviceIoControl(FSCTL_GET_NTFS_VOLUME_DATA)(*).

Wouldn't that be what we want to see, too?


Thanks,
Corinna


(*) Incidentally the last 8 digits represent the crippled 4 byte
    serial number returned by
    NtQueryVolumeInformationFile(..., FileFsVolumeInformation).
