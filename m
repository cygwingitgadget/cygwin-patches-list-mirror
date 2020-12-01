Return-Path: <Christian.Franke@t-online.de>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
 by sourceware.org (Postfix) with ESMTPS id EB6153857C4F
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 15:59:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EB6153857C4F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=Christian.Franke@t-online.de
Received: from fwd04.aul.t-online.de (fwd04.aul.t-online.de [172.20.26.149])
 by mailout04.t-online.de (Postfix) with SMTP id 9EE3F41B726E
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 16:59:06 +0100 (CET)
Received: from [192.168.2.101]
 (GvpfV+ZeZh0d3pxYUfb8uslo6FHbeRA48qDUDNu4vBfQ+Mid43A5cjAOvhenG-XZDc@[79.230.165.86])
 by fwd04.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kk83V-1lGBpg0; Tue, 1 Dec 2020 16:59:05 +0100
Subject: Re: [PATCH] Cygwin: Fix access to block devices below /proc/sys.
To: cygwin-patches@cygwin.com
References: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
 <20201130110344.GF303847@calimero.vinschen.de>
 <cd58c473-6aa4-b104-5909-5bd9ed6df1b1@t-online.de>
 <20201130140435.GH303847@calimero.vinschen.de>
 <20201130142123.GI303847@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <c07b35fb-525f-0744-0297-af49aa219cdd@t-online.de>
Date: Tue, 1 Dec 2020 16:59:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.4
MIME-Version: 1.0
In-Reply-To: <20201130142123.GI303847@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: GvpfV+ZeZh0d3pxYUfb8uslo6FHbeRA48qDUDNu4vBfQ+Mid43A5cjAOvhenG-XZDc
X-TOI-EXPURGATEID: 150726::1606838345-00004F6D-4D455B78/0/0 CLEAN NORMAL
X-TOI-MSGID: 1ab8601a-876a-4786-8b49-021c6cc0ed61
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 01 Dec 2020 15:59:09 -0000

Corinna Vinschen wrote:
> On Nov 30 15:04, Corinna Vinschen wrote:
>> On Nov 30 13:49, Christian Franke wrote:
>>> Corinna Vinschen wrote:
>>>> On Nov 28 22:59, Christian Franke wrote:
>>>>> ...
>>>>> The attached experimental patch does not fix the lseek() (sorry), but
>>>>> handles such block devices with fhandler_dev_floppy instead. Tested with
>>>>> above use cases.
>>>>>
>>>>> I'm not sure whether this could break access to other /proc/sys block
>>>>> devices. This would happen if fh->exists() returns virt_blk for devices
>>>>> which do not support IOCTL_DISK_GET_DRIVE_GEOMETRY* or
>>>>> IOCTL_DISK_GET_PARTITION_INFO*.
>>>> Pushed, becasue it's a nice idea.  The above problem shouldn't happen,
>>>> in theory, but I'm not sure.  virt_blk is generated for devices types
>>>>
>>>>     FILE_DEVICE_DISK
>>>>     FILE_DEVICE_CD_ROM
>>>>     FILE_DEVICE_VIRTUAL_DISK
>>>>     FILE_DEVICE_DFS
>>>>     FILE_DEVICE_NETWORK_FILE_SYSTEM
>>>>
>>>> FILE_DEVICE_DFS or FILE_DEVICE_NETWORK_FILE_SYSTEM might be a problem,
>>>> but there should be a way to workaround that, if necessary, isn't it?
>>>> Maybe it's a bad idea to treat those as blk devices at all?
>>> Could anything be read from such a node? If yes, treat as character device?
>>>
>>> If no and /proc/sys/foo/bar/some/path allows access to /some/path behind
>>> DFS/NFS node /proc/sys/foo/bar, then treat as directory?
>>>
>>> This is already the case for SMB shares:
>>>
>>> $ ls -ld /proc/sys/DosDevices/X:
>>> lr-------- 1 ... 0 Nov 30 13:10 /proc/sys/DosDevices/X: ->
>>>    /proc/sys/Device/LanmanRedirector/;X:..../127.0.0.1/Share
>>>
>>> $ ls -lLd /proc/sys/DosDevices/X:
>>> drwxr-xr-x 1 ... 0 Nov 14 09:06 /proc/sys/DosDevices/X:
>>>
>>> $ ls -L /proc/sys/DosDevices/X:
>>> ... files on this share
>> ...and it's already the case for NFS shares, too:
>>
>> $ ls -ld /proc/sys/DosDevices/Y:
>> lr-------- 1 corinna vinschen 0 Nov 30 14:59 /proc/sys/DosDevices/Y: -> /proc/sys/Device/MRxNfs/;Y:00000000001cb27f/...
>>
>> $ ls -lLd /proc/sys/DosDevices/Y:
>> drwxr-xr-x 5 corinna vinschen 41 May 19  2016 /proc/sys/DosDevices/Y:
>>
>> That means we don't have to handle FILE_DEVICE_NETWORK_FILE_SYSTEM in
>> the code creating the virt_blk device type at all.  I have high hopes
>> this is the same for DFS, albeit I can't test it...
> Oh, right, I just realized that \Device\MRxNfs, as well as
> \Device\LanmanRedirector are symlinks pointing below \Device\Mup:
>
> $ ls -l /proc/sys/Device/LanmanRedirector
> lr--r--r-- 1 Administrators SYSTEM 0 Nov 30 15:20 /proc/sys/Device/LanmanRedirector -> /proc/sys/Device/Mup/;LanmanRedirector
>
> $ ls -l /proc/sys/Device/MRxNfs
> lr--r--r-- 1 Administrators SYSTEM 0 Nov 30 15:20 /proc/sys/Device/MRxNfs -> /proc/sys/Device/Mup/;MRxNfs
>
> \Device\Mup is a character device and thus the devices below are not
> accessible for directory enumeration.  I assume it's the same for DFS.


Here I see \Device\Mup as a block device on two systems (cygwin1.dll 3.1.7):

$ ls -l /proc/sys/Device/Mup
brwxrwx--x 1 Administrators SYSTEM 0, 250 Dec  1 16:50 /proc/sys/Device/Mup

Device could be opened for reading, but actual read fails with NTSTATUS 
STATUS_INVALID_DEVICE_REQUEST.

Any path which do not exist produce misleading results:

$ ls -l /proc/sys/Device/Mup/no.such.file
crw-rw---- 1 Administrators SYSTEM 0, 250 Dec  1 16:52 
/proc/sys/Device/Mup/no.such.file


Thanks,
Christian

