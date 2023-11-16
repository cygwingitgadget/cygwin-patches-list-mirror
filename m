Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B85E23858D33; Thu, 16 Nov 2023 12:19:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B85E23858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700137195;
	bh=/9/FCDZqH1CIv2Sr1d9rP3qeAnuBcbBJpiVWqjuYbrE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=EB/d+fskXnlL/mIIJ1v791tJSGCPOlv8D4sa37yHiUsvwCKHdjBTq+8TgDqgURcDT
	 D5do/yoHSv1RRbl3NDECFsDB26TSMsHqNtA6HmnVf4zbhoU5g/uSdQQ33+K68cBshX
	 6IPQWb69HVvsYUmVE6LnKdscOwHooFqcQk0/2aDU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 06FBFA80C84; Thu, 16 Nov 2023 13:19:54 +0100 (CET)
Date: Thu, 16 Nov 2023 13:19:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-drive and /dev/disk/by-uuid
 symlinks
Message-ID: <ZVYI6QQ+zOB2KCPy@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5db42b33-ed93-2e7c-977a-89d407137d86@t-online.de>
 <ZVXwnUgd3UnIqBQf@calimero.vinschen.de>
 <d4cd305a-1a23-633b-3327-6ec01cf462b6@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4cd305a-1a23-633b-3327-6ec01cf462b6@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 16 12:50, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Hi Christian,
> > 
> > On Nov 15 18:23, Christian Franke wrote:
> > > This is the next (and possibly last for now) extension to the /dev/disk
> > > directory. Limited to disk related entries which allowed a straightforward
> > > extension of the existing code.
> > > 
> > > My original idea was to add also other drive letters and volume GUIDs. Too
> > > complex for now.
> > > 
> > > Interestingly the volume GUID (by-uuid) for partitions on MBR disks is
> > > sometimes identical to the partition "GUID" (by-partuuid), sometimes (always
> > > for C:?) not. With GPT disks, both GUIDs are possibly always identical.
> > That looks great, but in terms of by-uuid, I'm not sure it's the
> > right thing to do.  On Linux I have a vfat partition (/boot/efi).
> > The uuid in /dev/disk/by-uuid is the volume serial number, just
> > with an extra dash, i.e.
> > 
> >    057A-B3A7 -> ../../sda1
> > 
> > That's what you get for FAT/FAT32/exFAT.
> 
> What is the best way to retrieve a FAT* serial? There is
> GetVolumeInformation{ByHandleW}(), but this may not work with the NT Layer
> pathnames / handles used here.

It will work, because Windows and NT handles are the same thing as long
as you created the handle using an operation opening kernel objects, as,
for instance, files or volumes.

Actually, GetVolumeInformation() is the combination of multiple
NtQueryVolumeInformationFile calls.  The call retrieving the
serial number is NtQueryVolumeInformationFile(..., FileFsVolumeInformation),
as is used in fs_info::update, mount.cc, line 250 ATM.

> > I also tried an NTFS partition and the output looks like this:
> > 
> >    0FD4F62866CFBF09 -> ../../sdc1
> > 
> > This is the 64 bit volume serial number as returned by
> > DeviceIoControl(FSCTL_GET_NTFS_VOLUME_DATA)(*).
> > 
> > Wouldn't that be what we want to see, too?
> 
> Hmm...... yes. Should both information be provided in by-uuid or only the
> serial numbers? In the latter case, should we add e.g. by-voluuid for the
> volume GUIDs ?

Good question... by-voluuid sounds like a nice idea.  It's a Windows-only
concept anyway, so it might make sense to present it in its own directory.


Corinna
