Return-Path: <SRS0=4nz8=GR=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id 9EA683858D32
	for <cygwin-patches@cygwin.com>; Sat,  4 Nov 2023 11:34:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9EA683858D32
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9EA683858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699097649; cv=none;
	b=omRdU8CTleMH6AetLZe4cvb8HGYD3x5fds405vbAT5z7jR6L/zirEC52Ah4tAY0enzSbcKiCW19zXQcIXpxuvpbSHxJrE3ORExbeE2mjx8Reie0G1Vog0cF+Ff0Tc+P35lcuVXePLiiQzEPJW37aBtw+bCBTgCLNv5bIm+RAHso=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699097649; c=relaxed/simple;
	bh=oStoXrkpxc/3ol0RQT63fZ4YHSVKtCqJZkn3yVLQTzo=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=pUkLGP0ZL0/smL7zgQVMHObT7QoYkCINAI9miKMRkRjt1nJhfxd6S70xJLBDw2C9LruaIuS+EtjArW4+Y13tF71mC6Ph22Iotfvza/4GsBI7GSkVAdWENB/A8wlRpo+pdSrUTNrPgab42kENzdWURpae0eF55m60P4gBHcbSOlY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd75.aul.t-online.de (fwd75.aul.t-online.de [10.223.144.101])
	by mailout10.t-online.de (Postfix) with SMTP id E5C5317355
	for <cygwin-patches@cygwin.com>; Sat,  4 Nov 2023 12:34:05 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd75.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1qzEui-1VO1nE0; Sat, 4 Nov 2023 12:34:04 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
To: cygwin-patches@cygwin.com
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
 <ZUYVeeYDcAKC74wg@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <84d2e9df-de38-5006-e9e5-a12da3cafe42@t-online.de>
Date: Sat, 4 Nov 2023 12:34:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZUYVeeYDcAKC74wg@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1699097644-A985E9D6-696387BF/0/0 CLEAN NORMAL
X-TOI-MSGID: 4123bb74-7e18-4cbc-8e9f-1dd0ed1fb578
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Nov  4 10:34, Corinna Vinschen wrote:
>> On Nov  3 18:54, Christian Franke wrote:
>>> ...
>>>> MSDN claims:
>>>>
>>>>     If the storage device is SCSI-compliant, the port driver attempts to
>>>>     extract the serial number from the optional Unit Serial Number page
>>>>     (page 0x80) of the VPD.
>>>>
>>>> Now I'm puzzled.
>>> A quick test with a Debian 12 VM in VirtualBox with many virtual
>>> controllers+drives shows the same problem:
>>> Entries in /dev/disk/by-id appear only for virtual disks behind emulated
>>> SATA and NVMe controllers, but not for SCSI and SAS controllers.
>>> A test with "smartctl -i ..." with SCSI/SAS devices doesn't print a serial
>>> number. In debug mode it prints "Vital Product Data (VPD) INQUIRY failed..."
>>> and other messages that suggest limited/buggy support of optional SCSI
>>> commands.
>>>
>>> If a Win11 PE (from install ISO) is run in same VM, the
>>> STORAGE_DEVICE_DESCRIPTOR only provides the serial number for SATA (NVMe
>>> drives not detected), but not for SCSI.
>>>
>>> Conclusion: The behavior of the current patch is compatible with Linux :-)
>> Ok, but with the DUID we have a workaround which makes it  work even
>> better than on Linux, so it would begreat if we used it, unless we find
>> out where the UUID in "\GLOBAL??\Disk{<UUID>} comes from...
>>
>> Given the size of the STORAGE_DEVICE_UNIQUE_IDENTIFIER struct, we could
>> even contemplate a 128 bit hash, just to be on the safe side.
> Kind of like this
>
> -  strcat (name, ioctl_buf + desc->SerialNumberOffset);
> +  /* Use SerialNumber in the first place, if available */
> +  if (desc->SerialNumberOffset && desc_buf[desc->SerialNumberOffset])
> +    strcat (name, desc_buf + desc->SerialNumberOffset);
> +  else /* Utilize the DUID as defined by MSDN to generate a hash */
> +    {
> +      union {
> +	unsigned __int128 all;
> +	struct {
> +	  unsigned long high;
> +	  unsigned long low;
> +	};
> +      } hash = { 0 };
> +
> +      for (ULONG i = 0; i < id->Size; ++i)
> +	hash.all = ioctl_buf[i] + (hash.all << 6) + (hash.all << 16) - hash.all;
> +      __small_sprintf (name + strlen (name), "%X%X", hash.high, hash.low);
> +    }
>

I agree and will provide a new patch soon.

Christian

