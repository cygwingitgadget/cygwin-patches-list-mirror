Return-Path: <SRS0=WW/1=GQ=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id 2C2973858D28
	for <cygwin-patches@cygwin.com>; Fri,  3 Nov 2023 11:06:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2C2973858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2C2973858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699009611; cv=none;
	b=xAbai/BDk1PBD1a3qs5hks45NXuCR3efAvps726uHFWMnSDeloEV0qFx8oPN9Ld2ciDF7H/C4GVsLk3OGnwxJS+HgUYxfhbMBI3WPKswiTZtexWSyoCuFTnbmS/rMPdMMeIpSSwWGezWYtlrihsm1w6ElIk7tALJpyJ21PZw60E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699009611; c=relaxed/simple;
	bh=nYh2uu3cvZzSUWf8t2G0vUeCUsCu/4ZKPE2JsgO60Sk=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=MGAJxGd6nRxT1q+oPYhNly+lrtZ5fhqI8cPzTMYb9Sw0s23wT6vWayNVsEIAtza78x53zqoBn0MuAunybnaR262MOiB6JvZID5rZD7bX4s9pJ0NaWxr0NFqPvlZMHhIMYN3hJ9wqvsvmYQEOaqWL72Tlq+zryCa1+44UTcharMs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
	by mailout07.t-online.de (Postfix) with SMTP id C8BC126B57
	for <cygwin-patches@cygwin.com>; Fri,  3 Nov 2023 12:06:47 +0100 (CET)
Received: from [192.168.2.101] ([79.230.168.59]) by fwd83.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1qys0i-18fZI00; Fri, 3 Nov 2023 12:06:44 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
To: cygwin-patches@cygwin.com
References: <9cf93e3b-36c8-a50c-0154-85f06da29d61@t-online.de>
 <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
 <ZUTDd9BH4iysokAl@calimero.vinschen.de>
 <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <c1c6f1f9-82cf-d7c9-b04b-b533a3585238@t-online.de>
Date: Fri, 3 Nov 2023 12:06:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1699009604-BDFF8DE8-88F1FE28/0/0 CLEAN NORMAL
X-TOI-MSGID: 58f32956-897b-4b27-b439-21d99f0bc8f9
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Nov  3 10:55, Corinna Vinschen wrote:
>> Hi Christian,
>>
>> On Oct  3 14:39, Christian Franke wrote:
>>> Christian Franke wrote:
>>>> This is a first attempt to partly emulate the Linux directory
>>>> /dev/disk/by-id. Useful to make sure the correct device is accessed in
>>>> conjunction with dd, ddrescue, fdisk, ....
>>> Attached is the second attempt.
>>>
>>>
>>>> The additional '*-partN' links to partitions are not yet included.
>>> These are now included.
>>>
>>>
>>>> This only works properly if Win32 path '\\.\PhysicalDriveN' is always
>>>> trivially mapped to NT path '\Device\HarddiskN\Partition0'.
>>>> IOCTL_STORAGE_QUERY_PROPERTY with a handle from NtOpenFile(.,
>>>> READ_CONTROL,...) instead of CreateFile(., 0, ...) did not work with all
>>>> drivers. With stornvme.sys, it fails with permission denied. Perhaps
>>>> other permission bits are required for NtOpenFile(). Thanks for any info
>>>> regarding this.
>>> According to NtQueryObject(., ObjectBasicInformation, ...), using
>>> NtOpenFile(., MAXIMUM_ALLOWED, ...) without admin rights sets GrantedAccess
>>> to 0x001200a0 (FILE_EXECUTE|FILE_READ_ATTRIBUTES|READ_CONTROL|SYNCHRONIZE).
>>> For some unknown reason, NVMe drives behind stornvme.sys additionally
>>> require SYNCHRONIZE to use IOCTL_STORAGE_QUERY_PROPERTY. Possibly a harmless
>>> bug in the access check somewhere in the NVMe stack.
>>>
>>> The disk scanning from the first patch has been reworked based on code
>>> borrowed from proc.cc:format_proc_partitions(). For the longer term, it may
>>> make sense to provide one flexible scanning function for /dev/sdXN,
>>> /proc/partitions and /proc/disk/by-id.
>> I applied your patch locally (patch looks pretty well, btw) but found

Thanks!
Meantime I found 4 missing NtClose() in the main loop of 
get_by_id_table(). Will be fixed in the next version of the patch.


>> that /dev/disk/by-id is empty, even when running with admin rights.

Admin rights should not be necessary for IOCTL_STORAGE_QUERY_PROPERTY.


>>
>> I ran this on Windows 11 and Windows 2K19 in a QEMU/KVM VM.  A
>> \Device\Harddisk0\Partition0 symlink pointing to \Device\Harddisk0\DR0
>> exists in both cases.  I straced it, and found the following debug
>> output:
>>
>>    1015 1155432 [main] ls 361 stordesc_to_id_name: Harddisk0\Partition0: 'Red_Hat' 'VirtIO' '' (ignored)
>>
>> Is that really desired?

Yes - if IOCTL_STORAGE_QUERY_PROPERTY{... PropertyStandardQuery} does 
not return a serial number (''), the device is intentionally ignored.


> Thread 1 "ls" hit Breakpoint 2, stordesc_to_id_name (upath=0x7ffffc500,
>      ioctl_buf=0x10e0720 "(", name=...)
>      at /home/corinna/src/cygwin/vanilla/winsup/cygwin/fhandler/dev_disk.cc:44
> 44        const STORAGE_DEVICE_DESCRIPTOR *desc =
> (gdb) n
> 47        int vendor_len = 0, product_len = 0, serial_len = 0;
> (gdb)
> 48        if (desc->VendorIdOffset)
> (gdb)
> 49          vendor_len = sanitize_id_string (ioctl_buf + desc->VendorIdOffset);
> (gdb)
> 50        if (desc->ProductIdOffset)
> (gdb)
> 51          product_len = sanitize_id_string (ioctl_buf + desc->ProductIdOffset);
> (gdb)
> 52        if (desc->SerialNumberOffset)
> (gdb)
> 53          serial_len = sanitize_id_string (ioctl_buf + desc->SerialNumberOffset);

If possibly, please check whether (desc->SerialNumberOffset) is 0 or 
(ioctl_buf + desc->SerialNumberOffset) points to '\0' or a string of 
spaces. If no, there is possibly something wrong in sanitize_id_string().


> (gdb)
> 55        bool valid = (4 <= vendor_len + product_len && 4 <= serial_len
> (gdb) p vendor_len
> $1 = 7
> (gdb) p product_len
> $2 = 6
> (gdb) p serial_len
> $3 = 0
> (gdb) n
> [New Thread 3944.0x1958]
> 56                      && (20 + vendor_len + 1 + product_len + 1 + serial_len + 10)
> (gdb) n
> 55        bool valid = (4 <= vendor_len + product_len && 4 <= serial_len
> (gdb)
> 55        bool valid = (4 <= vendor_len + product_len && 4 <= serial_len
> (gdb)
> 58        debug_printf ("%S: '%s' '%s' '%s'%s", upath,
> (gdb) p valid
> $4 = false

-- 
Regards,
Christian

