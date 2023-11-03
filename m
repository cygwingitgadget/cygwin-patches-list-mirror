Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2CA073858D28; Fri,  3 Nov 2023 16:27:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2CA073858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699028877;
	bh=2TyzX4arT+SxLG7BW1La0AL4uJ32zFjc/s667WkOC0k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vO3ZIvwImbmOIEEQRy2ADtssFg1uTl/VoqG7Ydk6n9mLe0LBps+R3ybIG/v+EYrw/
	 unF83O87Xz0STYaG7IEKIupArQ7ppO9UKWYXkEk7e96WWh0ARvYCqRQKVwjVDzQpO0
	 vtaK1LTxNnMrGHho0abg7M21EEkvWI/yIcQ2qhAo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E2DBDA80795; Fri,  3 Nov 2023 17:27:54 +0100 (CET)
Date: Fri, 3 Nov 2023 17:27:54 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUUfit/OdR3G5G/H@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <9cf93e3b-36c8-a50c-0154-85f06da29d61@t-online.de>
 <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
 <ZUTDd9BH4iysokAl@calimero.vinschen.de>
 <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
 <ZUTVDlCF4q0Qp3QX@calimero.vinschen.de>
 <ZUT1JUYoh+y3H2wk@calimero.vinschen.de>
 <8ceefddf-6f66-ab44-f2fc-48072a5c7207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ceefddf-6f66-ab44-f2fc-48072a5c7207@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 17:09, Christian Franke wrote:
> Corinna Vinschen wrote:
> > I haven't found out where the UUID is coming from, yet, but based on the
> > description from
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/storage/device-unique-identifiers--duids--for-storage-devices
> > I came up with this Q&D solution:
> > 
> > =============== SNIP ================
> > diff --git a/winsup/cygwin/fhandler/dev_disk.cc b/winsup/cygwin/fhandler/dev_disk.cc
> > index caca57d63216..74abfb8a3288 100644
> > --- a/winsup/cygwin/fhandler/dev_disk.cc
> > +++ b/winsup/cygwin/fhandler/dev_disk.cc
> > @@ -36,29 +36,51 @@ sanitize_id_string (char *s)
> >     return i;
> >   }
> > +typedef struct _STORAGE_DEVICE_UNIQUE_IDENTIFIER {
> > +  ULONG Version;
> > +  ULONG Size;
> > +  ULONG StorageDeviceIdOffset;
> > +  ULONG StorageDeviceOffset;
> > +  ULONG DriveLayoutSignatureOffset;
> > +} STORAGE_DEVICE_UNIQUE_IDENTIFIER, *PSTORAGE_DEVICE_UNIQUE_IDENTIFIER;
> > +
> > +typedef struct _STORAGE_DEVICE_LAYOUT_SIGNATURE {
> > +  ULONG   Version;
> > +  ULONG   Size;
> > +  BOOLEAN Mbr;
> > +  union {
> > +    ULONG MbrSignature;
> > +    GUID  GptDiskId;
> > +  } DeviceSpecific;
> > +} STORAGE_DEVICE_LAYOUT_SIGNATURE, *PSTORAGE_DEVICE_LAYOUT_SIGNATURE;
> > +
> 
> These are available in storduid.h

Yeah, and defining STORAGE_DEVICE_LAYOUT_SIGNATURE is useless,
but it was just for PoC.

> Thanks. Using this makes plenty of sense as a fallback if the serial number
> is unavailable. But if available, the serial number should be in the
> generated name as on Linux. This would provide a persistent name which
> reflects the actual device without a number invented by MS.

ACK

> The serial number is usually available with (S)ATA and NVMe (namespace uuid
> in the latter case). I'm not familiar with QEMU/KVM details. The fact that
> both 'vendor' and 'product' are returned on your system suggests that a
> SCSI/SAS controller is emulated.

Yes.

> Unlike (S)ATA and NVMe, the serial number
> is not available for free in the device identify data block but requires an
> extra command (SCSI INQUIRY of VPD page 0x80). This might not be supported
> by the emulated controller or Windows does not use this command.

AFAICS, only the data from STORAGE_DEVICE_ID_DESCRIPTOR is available
which is equivalent to the data from VPD page 0x83.  As you can see,
it's part of the STORAGE_DEVICE_UNIQUE_IDENTIFIER data.  The data
returned for the VirtIo device is the identifier string "\x01\x00",
which is a bit underwhelming.

Would be great if we would learn how to access page 0x80...

> IIRC the serial number is sometimes available via WMI even if missing in
> IOCTL_STORAGE_QUERY_PROPERTY:
> 
>   wmic diskdrive get manufacturer,model,serialnumber

Nope, it returns an empty string, just as the date from
STORAGE_DEVICE_DESCRIPTOR.


Corinna
