Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C12983858D28; Fri,  3 Nov 2023 11:11:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C12983858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699009901;
	bh=IJm39M9Hvl/wO4TpAhlMOrIwNMIaM9hy06r2x+i++H8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Vmbv3H2EwPp4wJX7b8JZ0vLtv4i+WDBlTLlbGQtjeTtYbFKvudEJi53GcA0bKdOq5
	 vulil85jCXfqJlx1g9hNeh126vCajeEJID+8aG+X+9U3BYQqC98phGdAbTh7LIakcl
	 iXnbnwWknjxSUKtvuC6THvMIoPH2a8yPf2+lnBG8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C53E5A80706; Fri,  3 Nov 2023 12:11:39 +0100 (CET)
Date: Fri, 3 Nov 2023 12:11:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUTVawTszyMlB4QZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <9cf93e3b-36c8-a50c-0154-85f06da29d61@t-online.de>
 <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
 <ZUTDd9BH4iysokAl@calimero.vinschen.de>
 <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
 <c1c6f1f9-82cf-d7c9-b04b-b533a3585238@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1c6f1f9-82cf-d7c9-b04b-b533a3585238@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 12:06, Christian Franke wrote:
> Corinna Vinschen wrote:
> > > I ran this on Windows 11 and Windows 2K19 in a QEMU/KVM VM.  A
> > > \Device\Harddisk0\Partition0 symlink pointing to \Device\Harddisk0\DR0
> > > exists in both cases.  I straced it, and found the following debug
> > > output:
> > > 
> > >    1015 1155432 [main] ls 361 stordesc_to_id_name: Harddisk0\Partition0: 'Red_Hat' 'VirtIO' '' (ignored)
> > > 
> > > Is that really desired?
> 
> Yes - if IOCTL_STORAGE_QUERY_PROPERTY{... PropertyStandardQuery} does not
> return a serial number (''), the device is intentionally ignored.

See my other mail I just sent.

> > Thread 1 "ls" hit Breakpoint 2, stordesc_to_id_name (upath=0x7ffffc500,
> >      ioctl_buf=0x10e0720 "(", name=...)
> >      at /home/corinna/src/cygwin/vanilla/winsup/cygwin/fhandler/dev_disk.cc:44
> > 44        const STORAGE_DEVICE_DESCRIPTOR *desc =
> > (gdb) n
> > 47        int vendor_len = 0, product_len = 0, serial_len = 0;
> > (gdb)
> > 48        if (desc->VendorIdOffset)
> > (gdb)
> > 49          vendor_len = sanitize_id_string (ioctl_buf + desc->VendorIdOffset);
> > (gdb)
> > 50        if (desc->ProductIdOffset)
> > (gdb)
> > 51          product_len = sanitize_id_string (ioctl_buf + desc->ProductIdOffset);
> > (gdb)
> > 52        if (desc->SerialNumberOffset)
> > (gdb)
> > 53          serial_len = sanitize_id_string (ioctl_buf + desc->SerialNumberOffset);
> 
> If possibly, please check whether (desc->SerialNumberOffset) is 0 or
> (ioctl_buf + desc->SerialNumberOffset) points to '\0' or a string of spaces.
> If no, there is possibly something wrong in sanitize_id_string().

desc->SerialNumberOffset is > 0, serial_len is 0, it points to an empty
string.


Corinna
