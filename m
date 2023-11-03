Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A68473858C74; Fri,  3 Nov 2023 16:30:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A68473858C74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699029034;
	bh=ngkLSX6LosPDO5xtMIHG9TqHJO/mcZZk6yIMaCXYsU0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=wwzxmyydpv8Hfz0+IHChsGziJAnSsXIht6F7Tf4mpTzPe6ol8okJDMOGY0U5xXt/9
	 EMrX21wU4gEuPImLbgXd0Mo29kuLvTQnQJU3W30+OnbU00NiebkXh3CCWgB3tK/2UA
	 vnOKdxwIHsyr97258UCnXWSfbGASYNwvgnWEa6lA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D1610A80795; Fri,  3 Nov 2023 17:30:32 +0100 (CET)
Date: Fri, 3 Nov 2023 17:30:32 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUUgKHqlCQRghuzy@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9cf93e3b-36c8-a50c-0154-85f06da29d61@t-online.de>
 <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
 <ZUTDd9BH4iysokAl@calimero.vinschen.de>
 <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
 <ZUTVDlCF4q0Qp3QX@calimero.vinschen.de>
 <ZUT1JUYoh+y3H2wk@calimero.vinschen.de>
 <8ceefddf-6f66-ab44-f2fc-48072a5c7207@t-online.de>
 <ZUUfit/OdR3G5G/H@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUUfit/OdR3G5G/H@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 17:27, Corinna Vinschen wrote:
> On Nov  3 17:09, Christian Franke wrote:
> > Unlike (S)ATA and NVMe, the serial number
> > is not available for free in the device identify data block but requires an
> > extra command (SCSI INQUIRY of VPD page 0x80). This might not be supported
> > by the emulated controller or Windows does not use this command.
> 
> AFAICS, only the data from STORAGE_DEVICE_ID_DESCRIPTOR is available
> which is equivalent to the data from VPD page 0x83.  As you can see,
> it's part of the STORAGE_DEVICE_UNIQUE_IDENTIFIER data.  The data
> returned for the VirtIo device is the identifier string "\x01\x00",
> which is a bit underwhelming.
> 
> Would be great if we would learn how to access page 0x80...

Uhm...

MSDN claims:

  If the storage device is SCSI-compliant, the port driver attempts to
  extract the serial number from the optional Unit Serial Number page
  (page 0x80) of the VPD.

Now I'm puzzled.


Corinna
