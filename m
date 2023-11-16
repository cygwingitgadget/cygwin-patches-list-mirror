Return-Path: <SRS0=otId=G5=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id B957C3858D33
	for <cygwin-patches@cygwin.com>; Thu, 16 Nov 2023 11:50:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B957C3858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B957C3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1700135456; cv=none;
	b=aBNxxVmCZgvHzQIrGGDuzHGgCnwLHzwQNgGwcI/RBGEYW7Mst1IElp/dXGijIWEBeddE3LikYYo/ID3+0vfxTRA/7e1bB0a++ImmW0OZjXpZWa6qcf155gT8uX1hUZRM91MmD7key6l36IKrjH0X/o+hjcaeqhwhdIalqS/Je2s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1700135456; c=relaxed/simple;
	bh=ipXW5FC419/g5+iAnFKhgcvI2XT2Ne/MPnAwKsOOa2g=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=opV9GAqIlNeBczyycpypwnZH0og2ijvFMjRmC0sL3t2QBZ+s9Vc201vceHeWUriZydzxGvd935yBjWjUkEcHMm/pnLtZrUUwu+zxSMUp6nyx+RF+YiA5VpKWRL2uXELjA7wWne3smHLrAHcNlwbdGwowGS4EsJnvwkOJ9DXALoE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
	by mailout01.t-online.de (Postfix) with SMTP id C26DC6E54
	for <cygwin-patches@cygwin.com>; Thu, 16 Nov 2023 12:50:52 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd73.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r3atV-46ZRBY0; Thu, 16 Nov 2023 12:50:50 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-drive and /dev/disk/by-uuid
 symlinks
To: cygwin-patches@cygwin.com
References: <5db42b33-ed93-2e7c-977a-89d407137d86@t-online.de>
 <ZVXwnUgd3UnIqBQf@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <d4cd305a-1a23-633b-3327-6ec01cf462b6@t-online.de>
Date: Thu, 16 Nov 2023 12:50:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZVXwnUgd3UnIqBQf@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1700135450-DC9C3917-8727D973/0/0 CLEAN NORMAL
X-TOI-MSGID: a9ef759e-e919-4def-9c43-80bd1ee9073a
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> Hi Christian,
>
> On Nov 15 18:23, Christian Franke wrote:
>> This is the next (and possibly last for now) extension to the /dev/disk
>> directory. Limited to disk related entries which allowed a straightforward
>> extension of the existing code.
>>
>> My original idea was to add also other drive letters and volume GUIDs. Too
>> complex for now.
>>
>> Interestingly the volume GUID (by-uuid) for partitions on MBR disks is
>> sometimes identical to the partition "GUID" (by-partuuid), sometimes (always
>> for C:?) not. With GPT disks, both GUIDs are possibly always identical.
> That looks great, but in terms of by-uuid, I'm not sure it's the
> right thing to do.  On Linux I have a vfat partition (/boot/efi).
> The uuid in /dev/disk/by-uuid is the volume serial number, just
> with an extra dash, i.e.
>
>    057A-B3A7 -> ../../sda1
>
> That's what you get for FAT/FAT32/exFAT.

What is the best way to retrieve a FAT* serial? There is 
GetVolumeInformation{ByHandleW}(), but this may not work with the NT 
Layer pathnames / handles used here. In Cygwin tree, 
GetVolumeInformation only appears in cygcheck.cc and very old ChangeLogs.


> I also tried an NTFS partition and the output looks like this:
>
>    0FD4F62866CFBF09 -> ../../sdc1
>
> This is the 64 bit volume serial number as returned by
> DeviceIoControl(FSCTL_GET_NTFS_VOLUME_DATA)(*).
>
> Wouldn't that be what we want to see, too?

Hmm...... yes. Should both information be provided in by-uuid or only 
the serial numbers? In the latter case, should we add e.g. by-voluuid 
for the volume GUIDs ?

Christian

