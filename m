Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DB76B3858D33; Tue,  7 Nov 2023 13:29:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DB76B3858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699363786;
	bh=HHrSVW3nduLvL61hc76MOsy39PUUt/V/b7lxlBj2wE8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZIGUMMYR1VufVqfWBm9tQcXBPSeEIWh22xlNjHkzX8tgzZqftzDE1dExdP0S0JBEg
	 1uhb8cS4sEloXpwIevphwL4x2pW3TD+drsidiL0R9cvscVIUmYWu9DjVvU/WcjcY3b
	 i6Xf0c4cS+8bozSs3yEolV6RNH4WREjKTs0yqNK4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 32E8BA807B8; Tue,  7 Nov 2023 14:29:45 +0100 (CET)
Date: Tue, 7 Nov 2023 14:29:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUo7ydnzBK8HM8FI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <ZUUfit/OdR3G5G/H@calimero.vinschen.de>
 <ZUUgKHqlCQRghuzy@calimero.vinschen.de>
 <1133d1d3-e6d9-4a52-a595-89ee338f8d2f@t-online.de>
 <ZUYQPPsrxf5yp1Ir@calimero.vinschen.de>
 <ZUYVeeYDcAKC74wg@calimero.vinschen.de>
 <c82507ab-193a-4a85-7ef0-64f7a7f30705@t-online.de>
 <ZUautCVKk4bXD4q4@calimero.vinschen.de>
 <eeee1473-7902-6ef7-9fab-cfc3f4eb2785@t-online.de>
 <ZUf0DwCsxbuPR3iL@calimero.vinschen.de>
 <3074268d-edb9-6eef-f486-c9caedb6d54c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3074268d-edb9-6eef-f486-c9caedb6d54c@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  7 11:10, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Hi Christian,
> > 
> > On Nov  5 16:45, Christian Franke wrote:
> > > ...
> > > Old IOCTL dropped and code simplified.
> > Great.  I pushed your patch.
> 
> Thanks.
> 
> 
> > ...
> > > > Last, but not least, do you see a chance to add any other /dev/disk
> > > > subdir?  by-partuuid, perhaps?
> > > Possibly, but not very soon. I'm not yet sure which API functions could be
> > > used.
> > > Some early draft ideas:
> > > 
> > > /dev/disk/by-partuid (Partition UUID -> device)
> > >    GPT_PART_UUID -> ../../sdXN (GPT partition UUID)
> > >    MBR_SERIAL-partN -> ../../sdYM (Fake UUID for MBR)
> > That should only require IOCTL_DISK_GET_PARTITION_INFO_EX, I think.
> 
> Easier than expected: DRIVE_LAYOUT_INFORMATION_EX already contains
> PARTITION_INFORMATION_EX so existing scanning function could be enhanced.
> Patch attached.

Nice, pushed!

> > > /dev/disk/by-uuid (Windows Volume UUID -> device)
> > >    Vol_UUID1 -> ../../sdXN  (disk volume)
> > >    Vol_UUID2 -> ../../scd0  (CD/DVD drive volume)
> > >    Vol_UUID3 -> /proc/sys/GLOBAL??/Volume{UUID}  (others, e.g. VeraCrypt
> > > volume)
> > Yeah, tricky. These are not the partition GUIDs but the filesystem
> > GUIDs or serial numbers.  AFAICS, Windows filesystems (FAT*, NTFS)
> > don't maintain a filesystem GUID, as, e. g., ext4 or xfs, but only
> > serial numbers you can fetch via NtQueryVolumeInformationFile.
> > A Linux example of that is the serial number from a FAT32 filesytem
> > as the EFI boot partition in by-uuid:
> > 
> >    lrwxrwxrwx 1 root root 10 Oct 30 10:20 DC38-0407 -> ../../sda1
> > 
> > On second thought, maybe that's sufficient for our by-uuid emulation.
> > 
> > > /dev/disk/by-drive (Cygwin specific: drive letter -> volume)
> > >    c -> ../by-uuid/UUID (if UUID available)
> > >    x -> /proc/sys/DosDevices/X: (others, e.g. Network, "mounted" Volume
> > > Shadow Copy)
> > Ah, good idea. That's what my extension in /proc/partition already
> > provides, but a /dev/disk/by-drive sounds like a great idea.
> 
> Left for later :-)

Looking forward to it. We'll just need an entry for the release text
in winsup/cygwin/release/3.5.0 and doc/new-features.xml in the end :)


Thanks,
Corinna
