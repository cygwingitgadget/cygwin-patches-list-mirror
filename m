Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AACF83858D39; Sat,  4 Nov 2023 09:57:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AACF83858D39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699091835;
	bh=OJezt9hZZSJp0XR3PAkwASVMtJNI2CvcuNXZzEvgZIU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LlAGyXldypeQahQ2ImbL5Lix8tL6CALeuRri6QWTNUsyi1HQXlQPwX5S1QOYlZVnu
	 6dnawH2kRTAoe7PVaqQSG6oQuTP5raP2wRjSwWgzShWMdnCMJzeYYgDoHmggvQMJmP
	 bfdvKihlDswppf0SEhyBz89QXm/60RPnJUTBvy0Q=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D0E56A807AC; Sat,  4 Nov 2023 10:57:13 +0100 (CET)
Date: Sat, 4 Nov 2023 10:57:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUYVeeYDcAKC74wg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
 <ZUTDd9BH4iysokAl@calimero.vinschen.de>
 <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
 <ZUTVDlCF4q0Qp3QX@calimero.vinschen.de>
 <ZUT1JUYoh+y3H2wk@calimero.vinschen.de>
 <8ceefddf-6f66-ab44-f2fc-48072a5c7207@t-online.de>
 <ZUUfit/OdR3G5G/H@calimero.vinschen.de>
 <ZUUgKHqlCQRghuzy@calimero.vinschen.de>
 <1133d1d3-e6d9-4a52-a595-89ee338f8d2f@t-online.de>
 <ZUYQPPsrxf5yp1Ir@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUYQPPsrxf5yp1Ir@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  4 10:34, Corinna Vinschen wrote:
> On Nov  3 18:54, Christian Franke wrote:
> > Corinna Vinschen wrote:
> > > On Nov  3 17:27, Corinna Vinschen wrote:
> > > > On Nov  3 17:09, Christian Franke wrote:
> > > > > Unlike (S)ATA and NVMe, the serial number
> > > > > is not available for free in the device identify data block but requires an
> > > > > extra command (SCSI INQUIRY of VPD page 0x80). This might not be supported
> > > > > by the emulated controller or Windows does not use this command.
> > > > AFAICS, only the data from STORAGE_DEVICE_ID_DESCRIPTOR is available
> > > > which is equivalent to the data from VPD page 0x83.  As you can see,
> > > > it's part of the STORAGE_DEVICE_UNIQUE_IDENTIFIER data.  The data
> > > > returned for the VirtIo device is the identifier string "\x01\x00",
> > > > which is a bit underwhelming.
> > > > 
> > > > Would be great if we would learn how to access page 0x80...
> > > Uhm...
> > > 
> > > MSDN claims:
> > > 
> > >    If the storage device is SCSI-compliant, the port driver attempts to
> > >    extract the serial number from the optional Unit Serial Number page
> > >    (page 0x80) of the VPD.
> > > 
> > > Now I'm puzzled.
> > 
> > A quick test with a Debian 12 VM in VirtualBox with many virtual
> > controllers+drives shows the same problem:
> > Entries in /dev/disk/by-id appear only for virtual disks behind emulated
> > SATA and NVMe controllers, but not for SCSI and SAS controllers.
> > A test with "smartctl -i ..." with SCSI/SAS devices doesn't print a serial
> > number. In debug mode it prints "Vital Product Data (VPD) INQUIRY failed..."
> > and other messages that suggest limited/buggy support of optional SCSI
> > commands.
> > 
> > If a Win11 PE (from install ISO) is run in same VM, the
> > STORAGE_DEVICE_DESCRIPTOR only provides the serial number for SATA (NVMe
> > drives not detected), but not for SCSI.
> > 
> > Conclusion: The behavior of the current patch is compatible with Linux :-)
> 
> Ok, but with the DUID we have a workaround which makes it  work even
> better than on Linux, so it would begreat if we used it, unless we find
> out where the UUID in "\GLOBAL??\Disk{<UUID>} comes from...
> 
> Given the size of the STORAGE_DEVICE_UNIQUE_IDENTIFIER struct, we could
> even contemplate a 128 bit hash, just to be on the safe side.

Kind of like this

-  strcat (name, ioctl_buf + desc->SerialNumberOffset);
+  /* Use SerialNumber in the first place, if available */
+  if (desc->SerialNumberOffset && desc_buf[desc->SerialNumberOffset])
+    strcat (name, desc_buf + desc->SerialNumberOffset);
+  else /* Utilize the DUID as defined by MSDN to generate a hash */
+    {
+      union {
+	unsigned __int128 all;
+	struct {
+	  unsigned long high;
+	  unsigned long low;
+	};
+      } hash = { 0 };
+
+      for (ULONG i = 0; i < id->Size; ++i)
+	hash.all = ioctl_buf[i] + (hash.all << 6) + (hash.all << 16) - hash.all;
+      __small_sprintf (name + strlen (name), "%X%X", hash.high, hash.low);
+    }


Corinna
