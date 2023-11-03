Return-Path: <SRS0=WW/1=GQ=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	by sourceware.org (Postfix) with ESMTPS id 9AB003858CD1
	for <cygwin-patches@cygwin.com>; Fri,  3 Nov 2023 17:54:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9AB003858CD1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9AB003858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699034075; cv=none;
	b=xya8uOI3dh0fdw5alfkVyepKVLJh5PGfArkSJPY6td2dPnu2Lzz+qd7Dskr/fU6BjtOTIPnltRaYxZLqUu71/0bT0UBEAI8su5WSkD4c2k8cRA4u8SyZDRZ9JWrklfeUd5ZKmMSGmUNknSu4OqeiXbm0V1t3AJJQFdJgWA4j8jI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699034075; c=relaxed/simple;
	bh=5U8/B2JUS0ZCd0rhL7mzFgC1uL8DG8yfKYYeiot4WTo=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=qB1aWwBW0NRldN23R0ff9ENm67oW9zEdJdV6Afb77h825Wabhmz6fVSqvZrL80jhUsYpfuhI3gMoBjyY8gF9GdKn3yifhjAYwA5tWljXsYjsZ5PeuBLi0NMVFhqewjV0hWel0fhtCb50DBf5dOqry72UitozjW//Z8pAj/ywo98=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd81.aul.t-online.de (fwd81.aul.t-online.de [10.223.144.107])
	by mailout04.t-online.de (Postfix) with SMTP id 598B71C0AB
	for <cygwin-patches@cygwin.com>; Fri,  3 Nov 2023 18:54:32 +0100 (CET)
Received: from [192.168.2.101] ([79.230.168.59]) by fwd81.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1qyyNL-1O4rC40; Fri, 3 Nov 2023 18:54:31 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
To: cygwin-patches@cygwin.com
References: <9cf93e3b-36c8-a50c-0154-85f06da29d61@t-online.de>
 <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
 <ZUTDd9BH4iysokAl@calimero.vinschen.de>
 <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
 <ZUTVDlCF4q0Qp3QX@calimero.vinschen.de>
 <ZUT1JUYoh+y3H2wk@calimero.vinschen.de>
 <8ceefddf-6f66-ab44-f2fc-48072a5c7207@t-online.de>
 <ZUUfit/OdR3G5G/H@calimero.vinschen.de>
 <ZUUgKHqlCQRghuzy@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <1133d1d3-e6d9-4a52-a595-89ee338f8d2f@t-online.de>
Date: Fri, 3 Nov 2023 18:54:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZUUgKHqlCQRghuzy@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1699034071-CCD6CE93-06C5CEDB/0/0 CLEAN NORMAL
X-TOI-MSGID: 5bdd632a-162e-4e52-9c76-7ee8c0578a1a
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Nov  3 17:27, Corinna Vinschen wrote:
>> On Nov  3 17:09, Christian Franke wrote:
>>> Unlike (S)ATA and NVMe, the serial number
>>> is not available for free in the device identify data block but requires an
>>> extra command (SCSI INQUIRY of VPD page 0x80). This might not be supported
>>> by the emulated controller or Windows does not use this command.
>> AFAICS, only the data from STORAGE_DEVICE_ID_DESCRIPTOR is available
>> which is equivalent to the data from VPD page 0x83.  As you can see,
>> it's part of the STORAGE_DEVICE_UNIQUE_IDENTIFIER data.  The data
>> returned for the VirtIo device is the identifier string "\x01\x00",
>> which is a bit underwhelming.
>>
>> Would be great if we would learn how to access page 0x80...
> Uhm...
>
> MSDN claims:
>
>    If the storage device is SCSI-compliant, the port driver attempts to
>    extract the serial number from the optional Unit Serial Number page
>    (page 0x80) of the VPD.
>
> Now I'm puzzled.

A quick test with a Debian 12 VM in VirtualBox with many virtual 
controllers+drives shows the same problem:
Entries in /dev/disk/by-id appear only for virtual disks behind emulated 
SATA and NVMe controllers, but not for SCSI and SAS controllers.
A test with "smartctl -i ..." with SCSI/SAS devices doesn't print a 
serial number. In debug mode it prints "Vital Product Data (VPD) INQUIRY 
failed..." and other messages that suggest limited/buggy support of 
optional SCSI commands.

If a Win11 PE (from install ISO) is run in same VM, the 
STORAGE_DEVICE_DESCRIPTOR only provides the serial number for SATA (NVMe 
drives not detected), but not for SCSI.

Conclusion: The behavior of the current patch is compatible with Linux :-)

Christian

