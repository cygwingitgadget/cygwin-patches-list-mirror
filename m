Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8DD433858D28; Fri,  3 Nov 2023 11:10:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8DD433858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699009808;
	bh=chjDBZsE9C19jofG97pTBqv6LVe3Yd7z6dk4+lrES6k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=n3IzhjEiTAJTnEdiLKBhfZGF4XYXU8cc7dS6zICGTTKXIPjDEnKqAafj+lNXebluK
	 RgdU/3htk/ORT8GcU7eTymcqKJGrAGZoTYtkKqrBFNe/SB+4AGnPP696XIl8vjl8vf
	 TdRUxQJIdP4doHw0govAMWxNLvIKJNBjYkmBfJzI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C5590A80716; Fri,  3 Nov 2023 12:10:06 +0100 (CET)
Date: Fri, 3 Nov 2023 12:10:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUTVDlCF4q0Qp3QX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <9cf93e3b-36c8-a50c-0154-85f06da29d61@t-online.de>
 <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
 <ZUTDd9BH4iysokAl@calimero.vinschen.de>
 <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 11:09, Corinna Vinschen wrote:
> On Nov  3 10:55, Corinna Vinschen wrote:
> > On Oct  3 14:39, Christian Franke wrote:
> > > According to NtQueryObject(., ObjectBasicInformation, ...), using
> > > NtOpenFile(., MAXIMUM_ALLOWED, ...) without admin rights sets GrantedAccess
> > > to 0x001200a0 (FILE_EXECUTE|FILE_READ_ATTRIBUTES|READ_CONTROL|SYNCHRONIZE).
> > > For some unknown reason, NVMe drives behind stornvme.sys additionally
> > > require SYNCHRONIZE to use IOCTL_STORAGE_QUERY_PROPERTY. Possibly a harmless
> > > bug in the access check somewhere in the NVMe stack.
> > > 
> > > The disk scanning from the first patch has been reworked based on code
> > > borrowed from proc.cc:format_proc_partitions(). For the longer term, it may
> > > make sense to provide one flexible scanning function for /dev/sdXN,
> > > /proc/partitions and /proc/disk/by-id.
> > 
> > I applied your patch locally (patch looks pretty well, btw) but found
> > that /dev/disk/by-id is empty, even when running with admin rights.
> > 
> > I ran this on Windows 11 and Windows 2K19 in a QEMU/KVM VM.  A
> > \Device\Harddisk0\Partition0 symlink pointing to \Device\Harddisk0\DR0
> > exists in both cases.  I straced it, and found the following debug
> > output:
> > 
> >   1015 1155432 [main] ls 361 stordesc_to_id_name: Harddisk0\Partition0: 'Red_Hat' 'VirtIO' '' (ignored)
> > 
> > Is that really desired?

We could fake a serial number dependent on the path.  See
https://sourceware.org/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/mount.cc;hb=main#l253

Alternatively, there's also a symlink in GLOBAL?? pointing
to the same target as \Device\Harddisk0\Partition0, i. e.:

  \Device\Harddisk0\Partition0 -> \Device\Harddisk0\DR0

and

  \GLOBAL??\Disk{4c622943-27e4-e81d-3fc7-c43fc9c7e126} -> \Device\Harddisk0\DR0

We could use that UUID from that path, but that's quite a hassle
to grab, because it requires to enumerate GLOBAL??.

But then again, where does Windows get the UUID from?  Something to
find out...


Corinna
