Return-Path: <SRS0=CbdY=HD=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id 6058F3858CD1
	for <cygwin-patches@cygwin.com>; Wed, 22 Nov 2023 16:31:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6058F3858CD1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6058F3858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1700670687; cv=none;
	b=cdEcbsWefaHh9QgdjKo571sBX0tOh7a2mLTwVa8vsjpCMDojkhfoDmaUzPqer1Pea+TvvS+q3s2LwNFy0G9KxQmqgFSZFl9tY1Jv0m2ity0GdzNFkny7g/by+mrG1NruFaDE9IXZ2xw1SkjIVgs8CAbQcJFdwH1KCccsNEUHaok=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1700670687; c=relaxed/simple;
	bh=A6hYc9l3YW9FFfNvIz8lMo5m8OH4J8cxoaC26MtfJRk=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=dzGKB+3/yP2vs4qSUMFV14KqnXKxxctqoMAPEkpB+X7eddP4E804KoyfYLj7ZK9b8ES3wMeJ3xBu2P8gAAf9rbZZVZbtzx2sp+amBLRpI62d+ywYhtLZ/HhgrKcvOEU5mRFopHo3rAs4J0VGtXtLWqraBDdfrP9NrVNTZY0+hlI=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
	by mailout01.t-online.de (Postfix) with SMTP id 7E03D20A7B
	for <cygwin-patches@cygwin.com>; Wed, 22 Nov 2023 17:31:15 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd82.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r5q87-2IcbiK0; Wed, 22 Nov 2023 17:31:11 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
To: cygwin-patches@cygwin.com
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
 <ZV3HeSgKxh9MczqQ@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <6502e361-6b64-418e-d041-93cf4810f083@t-online.de>
Date: Wed, 22 Nov 2023 17:31:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZV3HeSgKxh9MczqQ@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1700670671-04981954-F742328B/0/0 CLEAN NORMAL
X-TOI-MSGID: 03ffaf05-7f51-4f34-9fba-14301fb68c73
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Corinna Vinschen wrote:
> Hi Christian,
>
>
> On second thought...
>
> I had a bad night tonight and was thinking a long time about this and
> that.  It suddenly occured to me that there might be another problem
> with this approach, attaching ordinals to the label name.
>
> Assuming you have a single filesystem labled "VOLUME" which is on a
> fixed disk.  So you get something like this:
>
>    $ ls -l /dev/disk/by-label
>    total 0
>    lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:09  VOLUME -> ../../sdb1
>    lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:10  root -> ../../sda3
>
> Now you insert an USB Stick with a FAT32 filesystem, also labeled
> "VOLUME".  Now you get something like this:
>
>    $ ls -l /dev/disk/by-label
>    total 0
>    lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:12 'VOLUME#0' -> ../../sdb1
>    lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:12 'VOLUME#1' -> ../../sdc1
>    lrwxrwxrwx 1 corinna vinschen 0 Nov 22 10:10  root -> ../../sda3
>
> So the label name changes, depending on inserting or removing another
> partition.

This is intentional. If the first duplicate appears, it is IMO better to 
also replace the original name to show that a duplicate exists.


>
> Not saying I have a good solution myself, so I wonder if we should just
> let it slip, but I thought we should at least talk about it...

Users should be aware that unspecific label names like VOLUME could not 
be used as a persistent link if drives are changed.

Same may apply to by-partuuid names as preformatted SD-cards and USB 
flash drives may have a null MBR serial number.

Regards,
Christian

