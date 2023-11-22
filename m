Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5EBA33858C36; Wed, 22 Nov 2023 09:18:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5EBA33858C36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700644732;
	bh=pmUmJkJpV0+8ZG/qgMGD8k5/7Nv85IWVz26VITpjWBE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=L+HPuQ7mMAQ7PTBSWeMU6FHWgvJydKuMiW6nwo2+93YArIQPCXU6RTxYZHPdIENns
	 LqK0oVJbv771CfINx7vvbZkcRRDoP6xSJybOJhMRf1sbrvJqmtpO/Z+BzcRbhxLPXt
	 GKX7UMycF2alQAkJxujumLLjXE7z7pCvMhr25qO4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 08444A8098C; Wed, 22 Nov 2023 10:18:50 +0100 (CET)
Date: Wed, 22 Nov 2023 10:18:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
Message-ID: <ZV3HeSgKxh9MczqQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
 <ZVfBmQiTGOjx14lW@calimero.vinschen.de>
 <b924c0f6-7ac1-9fa8-f828-0482f1ea5d36@t-online.de>
 <ZVsppVEdC+HW2NE5@calimero.vinschen.de>
 <ZVsrDfTnL6Fy3BfM@calimero.vinschen.de>
 <0f8c8b7e-8a67-bc0a-24c3-91d28e2f0972@t-online.de>
 <0ba1c78e-15e6-65a2-eb4d-16ac2495c356@t-online.de>
 <ZVzLnADL0i2X3orL@calimero.vinschen.de>
 <7d24b7f1-0dae-ad23-6bde-3502716edbad@t-online.de>
 <ZVz50yQyM0bHnbQc@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVz50yQyM0bHnbQc@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,


On second thought...

I had a bad night tonight and was thinking a long time about this and
that.  It suddenly occured to me that there might be another problem
with this approach, attaching ordinals to the label name.

Assuming you have a single filesystem labled "VOLUME" which is on a
fixed disk.  So you get something like this:

  $ ls -l /dev/disk/by-label
  total 0
  lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:09  VOLUME -> ../../sdb1
  lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:10  root -> ../../sda3

Now you insert an USB Stick with a FAT32 filesystem, also labeled
"VOLUME".  Now you get something like this:

  $ ls -l /dev/disk/by-label
  total 0
  lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:12 'VOLUME#0' -> ../../sdb1
  lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:12 'VOLUME#1' -> ../../sdc1
  lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:10  root -> ../../sda3

So the label name changes, depending on inserting or removing another
partition.

Not saying I have a good solution myself, so I wonder if we should just
let it slip, but I thought we should at least talk about it...


Thanks,
Corinna
