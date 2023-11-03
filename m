Return-Path: <SRS0=WW/1=GQ=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by sourceware.org (Postfix) with ESMTPS id D46E9385C6E0
	for <cygwin-patches@cygwin.com>; Fri,  3 Nov 2023 16:09:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D46E9385C6E0
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D46E9385C6E0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699027805; cv=none;
	b=YS5tvPm32hZfoxeAapxmreUmHKWewB3+w3xOyteSvKofYuH3MmuFGtqJKOP6JLlnE189SM+roQ+VtI/+g0mXSipCOA+b4YQWFtBDIxKPE+w/8seusHPRzBuZnSeGgMkxjbc/DehMmFp9djvY5Mpqe1zaivtUCkM8Y7CW1D2y9+U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699027805; c=relaxed/simple;
	bh=aWdydHg7qjiwqqWX8SP2SzJLzJu4ZYDBIw6LIPtd7P0=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=raLsTfsi32fxTU0gYhGtTiocoZ4dVuLZhGHlGhdJTZzdff5gK7iDGjjXWA66wL22XkBJroCqjNBG0IWJ5bQO0ygTyGJyEAr/rw+ffTNzYC5XqCXetjCSdqWTRA12tiYKLBkpWTIURkTwkeQEB57cmZ1/GN5xFbXhdGfhC9cRCTQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
	by mailout08.t-online.de (Postfix) with SMTP id 8BF183D5D
	for <cygwin-patches@cygwin.com>; Fri,  3 Nov 2023 17:09:53 +0100 (CET)
Received: from [192.168.2.101] ([79.230.168.59]) by fwd76.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1qywk1-2YN4Ns0; Fri, 3 Nov 2023 17:09:50 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
To: cygwin-patches@cygwin.com
References: <9cf93e3b-36c8-a50c-0154-85f06da29d61@t-online.de>
 <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
 <ZUTDd9BH4iysokAl@calimero.vinschen.de>
 <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
 <ZUTVDlCF4q0Qp3QX@calimero.vinschen.de>
 <ZUT1JUYoh+y3H2wk@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <8ceefddf-6f66-ab44-f2fc-48072a5c7207@t-online.de>
Date: Fri, 3 Nov 2023 17:09:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZUT1JUYoh+y3H2wk@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1699027790-C27FBE88-925C3100/0/0 CLEAN NORMAL
X-TOI-MSGID: 847b38fc-a1f0-43f9-ab90-5cdeb9e23590
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Nov  3 12:10, Corinna Vinschen wrote:
>> On Nov  3 11:09, Corinna Vinschen wrote:
>>> On Nov  3 10:55, Corinna Vinschen wrote:
>>>> On Oct  3 14:39, Christian Franke wrote:
>>>>> According to NtQueryObject(., ObjectBasicInformation, ...), using
>>>>> NtOpenFile(., MAXIMUM_ALLOWED, ...) without admin rights sets GrantedAccess
>>>>> to 0x001200a0 (FILE_EXECUTE|FILE_READ_ATTRIBUTES|READ_CONTROL|SYNCHRONIZE).
>>>>> For some unknown reason, NVMe drives behind stornvme.sys additionally
>>>>> require SYNCHRONIZE to use IOCTL_STORAGE_QUERY_PROPERTY. Possibly a harmless
>>>>> bug in the access check somewhere in the NVMe stack.
>>>>>
>>>>> The disk scanning from the first patch has been reworked based on code
>>>>> borrowed from proc.cc:format_proc_partitions(). For the longer term, it may
>>>>> make sense to provide one flexible scanning function for /dev/sdXN,
>>>>> /proc/partitions and /proc/disk/by-id.
>>>> I applied your patch locally (patch looks pretty well, btw) but found
>>>> that /dev/disk/by-id is empty, even when running with admin rights.
>>>>
>>>> I ran this on Windows 11 and Windows 2K19 in a QEMU/KVM VM.  A
>>>> \Device\Harddisk0\Partition0 symlink pointing to \Device\Harddisk0\DR0
>>>> exists in both cases.  I straced it, and found the following debug
>>>> output:
>>>>
>>>>    1015 1155432 [main] ls 361 stordesc_to_id_name: Harddisk0\Partition0: 'Red_Hat' 'VirtIO' '' (ignored)
>>>>
>>>> Is that really desired?
>> We could fake a serial number dependent on the path.  See
>> https://sourceware.org/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/mount.cc;hb=main#l253
>>
>> Alternatively, there's also a symlink in GLOBAL?? pointing
>> to the same target as \Device\Harddisk0\Partition0, i. e.:
>>
>>    \Device\Harddisk0\Partition0 -> \Device\Harddisk0\DR0
>>
>> and
>>
>>    \GLOBAL??\Disk{4c622943-27e4-e81d-3fc7-c43fc9c7e126} -> \Device\Harddisk0\DR0
>>
>> We could use that UUID from that path, but that's quite a hassle
>> to grab, because it requires to enumerate GLOBAL??.
>>
>> But then again, where does Windows get the UUID from?  Something to
>> find out...
> I haven't found out where the UUID is coming from, yet, but based on the
> description from
> https://learn.microsoft.com/en-us/windows-hardware/drivers/storage/device-unique-identifiers--duids--for-storage-devices
> I came up with this Q&D solution:
>
> =============== SNIP ================
> diff --git a/winsup/cygwin/fhandler/dev_disk.cc b/winsup/cygwin/fhandler/dev_disk.cc
> index caca57d63216..74abfb8a3288 100644
> --- a/winsup/cygwin/fhandler/dev_disk.cc
> +++ b/winsup/cygwin/fhandler/dev_disk.cc
> @@ -36,29 +36,51 @@ sanitize_id_string (char *s)
>     return i;
>   }
>   
> +typedef struct _STORAGE_DEVICE_UNIQUE_IDENTIFIER {
> +  ULONG Version;
> +  ULONG Size;
> +  ULONG StorageDeviceIdOffset;
> +  ULONG StorageDeviceOffset;
> +  ULONG DriveLayoutSignatureOffset;
> +} STORAGE_DEVICE_UNIQUE_IDENTIFIER, *PSTORAGE_DEVICE_UNIQUE_IDENTIFIER;
> +
> +typedef struct _STORAGE_DEVICE_LAYOUT_SIGNATURE {
> +  ULONG   Version;
> +  ULONG   Size;
> +  BOOLEAN Mbr;
> +  union {
> +    ULONG MbrSignature;
> +    GUID  GptDiskId;
> +  } DeviceSpecific;
> +} STORAGE_DEVICE_LAYOUT_SIGNATURE, *PSTORAGE_DEVICE_LAYOUT_SIGNATURE;
> +

These are available in storduid.h


>   /* Get ID string from STORAGE_DEVICE_DESCRIPTIOR. */
>   static bool
>   stordesc_to_id_name (const UNICODE_STRING *upath, char *ioctl_buf,
>   		    char (& name)[NAME_MAX + 1])
>   {
> +  const STORAGE_DEVICE_UNIQUE_IDENTIFIER *id =
> +    reinterpret_cast<const STORAGE_DEVICE_UNIQUE_IDENTIFIER *>(ioctl_buf);
> +  char *desc_buf = ioctl_buf + id->StorageDeviceOffset;
>     const STORAGE_DEVICE_DESCRIPTOR *desc =
> [...]
>     strcat (name, "_");
> -  strcat (name, ioctl_buf + desc->SerialNumberOffset);
> +  if (1) /* Utilize the DUID as defined by MSDN */
> +    {
> +      unsigned long hash = 0;
> +
> +      for (ULONG i = 0; i < id->Size; ++i)
> +	hash = ioctl_buf[i] + (hash << 6) + (hash << 16) - hash;
> +      __small_sprintf (name + strlen (name), "%X", hash);
> +    }
> +  else
> +    strcat (name, desc_buf + desc->SerialNumberOffset);
>     return true;
>   }
>   
> @@ -212,7 +243,7 @@ get_by_id_table (by_id_entry * &table)
>   	  /* Fetch vendor, product and serial number. */
>   	  DWORD bytes_read;
>   	  STORAGE_PROPERTY_QUERY query =
> -	    { StorageDeviceProperty, PropertyStandardQuery, { 0 } };
> +	    { StorageDeviceUniqueIdProperty, PropertyStandardQuery, { 0 } };
>   	  if (!DeviceIoControl (devhdl, IOCTL_STORAGE_QUERY_PROPERTY,
>   				&query, sizeof (query),
>   				ioctl_buf, NT_MAX_PATH,
> =============== SNAP ================

Thanks. Using this makes plenty of sense as a fallback if the serial 
number is unavailable. But if available, the serial number should be in 
the generated name as on Linux. This would provide a persistent name 
which reflects the actual device without a number invented by MS.

The serial number is usually available with (S)ATA and NVMe (namespace 
uuid in the latter case). I'm not familiar with QEMU/KVM details. The 
fact that both 'vendor' and 'product' are returned on your system 
suggests that a SCSI/SAS controller is emulated. Unlike (S)ATA and NVMe, 
the serial number is not available for free in the device identify data 
block but requires an extra command (SCSI INQUIRY of VPD page 0x80). 
This might not be supported by the emulated controller or Windows does 
not use this command.

IIRC the serial number is sometimes available via WMI even if missing in 
IOCTL_STORAGE_QUERY_PROPERTY:

   wmic diskdrive get manufacturer,model,serialnumber


> And, btw, rather than using strcpy/strcat, can you please utilize
> stpcpy?  You just have to keep the pointer around and you can
> concat w/o always having to go over the full length of the string.

Of course.

Christian

