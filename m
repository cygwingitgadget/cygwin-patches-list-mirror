Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 364AD3858D3C; Sat,  4 Nov 2023 20:51:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 364AD3858D3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699131062;
	bh=zIZv6tOd/QcFninQMaacEpRZC66fC25HAArNQUSC/4Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=NN6xhlIH7Pzn+mB3oCsMelD3BfyI1GvnMpMitn4WvNONjJ8og2MlR9CZzIVOciqR9
	 Sl9dcWmKRhYv5KiUIYFUkaoQzpg0/OnaiCYfgeuOQ9suaOCH12RaXNtl1Zj734ects
	 5d2bcgJVg7MsrpQjE/PJjWsL+wMBV03Y0aX/tSSY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 59E24A80782; Sat,  4 Nov 2023 21:51:00 +0100 (CET)
Date: Sat, 4 Nov 2023 21:51:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUautCVKk4bXD4q4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
 <ZUTVDlCF4q0Qp3QX@calimero.vinschen.de>
 <ZUT1JUYoh+y3H2wk@calimero.vinschen.de>
 <8ceefddf-6f66-ab44-f2fc-48072a5c7207@t-online.de>
 <ZUUfit/OdR3G5G/H@calimero.vinschen.de>
 <ZUUgKHqlCQRghuzy@calimero.vinschen.de>
 <1133d1d3-e6d9-4a52-a595-89ee338f8d2f@t-online.de>
 <ZUYQPPsrxf5yp1Ir@calimero.vinschen.de>
 <ZUYVeeYDcAKC74wg@calimero.vinschen.de>
 <c82507ab-193a-4a85-7ef0-64f7a7f30705@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c82507ab-193a-4a85-7ef0-64f7a7f30705@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

patch looks pretty good to me.  Just two minor points:

> +  /* Traverse \Device directory ... */
> +  bool errno_set = false;
> +  HANDLE devhdl = INVALID_HANDLE_VALUE;

INVALID_HANDLE_VALUE is a Win32 API concept and is only returned by
CreateFile and friends.  The native NT API doesn't know
INVALID_HANDLE_VALUE and, fortunately, only uses NULL.  I think it's
puzzeling to use INVALID_HANDLE_VALUE in a native NT context. So, would
you mind to just use NULL (or nullptr) instead?  As in...

> +      if (devhdl != INVALID_HANDLE_VALUE)

         if (devhdl)

Sounds easier to me :)

> +	  /* Fetch drive layout info to get size of all partitions on disk. */
> +	  DWORD part_cnt = 0;
> +	  PARTITION_INFORMATION_EX *pix = nullptr;
> +	  PARTITION_INFORMATION *pi = nullptr;
> +	  DWORD bytes_read;
> +	  if (DeviceIoControl (devhdl, IOCTL_DISK_GET_DRIVE_LAYOUT_EX, nullptr, 0,
> +			       ioctl_buf, NT_MAX_PATH, &bytes_read, nullptr))
> +	    {
> +	      DRIVE_LAYOUT_INFORMATION_EX *pdlix =
> +		  reinterpret_cast<DRIVE_LAYOUT_INFORMATION_EX *>(ioctl_buf);
> +	      part_cnt = pdlix->PartitionCount;
> +	      pix = pdlix->PartitionEntry;
> +	    }
> +	  else if (DeviceIoControl (devhdl, IOCTL_DISK_GET_DRIVE_LAYOUT, nullptr,

Do we really still need IOCTL_DISK_GET_DRIVE_LAYOUT w/o _EX?

fhandler_proc still uses it, too, but the EX variation is available
since XP. I can't imagine that a fallback to the non-EX-version is still
necessary.  If you like you could drop it immediately, or we can drop
both usages as a followup patch.

Last, but not least, do you see a chance to add any other /dev/disk
subdir?  by-partuuid, perhaps?


Thanks,
Corinna

