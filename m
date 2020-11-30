Return-Path: <Christian.Franke@t-online.de>
Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
 by sourceware.org (Postfix) with ESMTPS id 71E4F3887035
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 12:49:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 71E4F3887035
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=Christian.Franke@t-online.de
Received: from fwd20.aul.t-online.de (fwd20.aul.t-online.de [172.20.26.140])
 by mailout06.t-online.de (Postfix) with SMTP id 146D241303D8
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 13:49:58 +0100 (CET)
Received: from [192.168.2.101]
 (E4xW8uZdQhoFsDM2XP0pupNR5CylMnj-AEEZUMJSH51fojUDgvca2eRsAx7gtmJwUx@[79.230.165.86])
 by fwd20.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kjicv-4E3bk00; Mon, 30 Nov 2020 13:49:57 +0100
Subject: Re: [PATCH] Cygwin: Fix access to block devices below /proc/sys.
To: cygwin-patches@cygwin.com
References: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
 <20201130110344.GF303847@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <cd58c473-6aa4-b104-5909-5bd9ed6df1b1@t-online.de>
Date: Mon, 30 Nov 2020 13:49:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.4
MIME-Version: 1.0
In-Reply-To: <20201130110344.GF303847@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: E4xW8uZdQhoFsDM2XP0pupNR5CylMnj-AEEZUMJSH51fojUDgvca2eRsAx7gtmJwUx
X-TOI-EXPURGATEID: 150726::1606740597-000053CC-C1396EA1/0/0 CLEAN NORMAL
X-TOI-MSGID: c3c15ad4-eab6-48f2-aff6-95c4271fb089
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Mon, 30 Nov 2020 12:50:01 -0000

Corinna Vinschen wrote:
> On Nov 28 22:59, Christian Franke wrote:
>> ...
>> The attached experimental patch does not fix the lseek() (sorry), but
>> handles such block devices with fhandler_dev_floppy instead. Tested with
>> above use cases.
>>
>> I'm not sure whether this could break access to other /proc/sys block
>> devices. This would happen if fh->exists() returns virt_blk for devices
>> which do not support IOCTL_DISK_GET_DRIVE_GEOMETRY* or
>> IOCTL_DISK_GET_PARTITION_INFO*.
> Pushed, becasue it's a nice idea.  The above problem shouldn't happen,
> in theory, but I'm not sure.  virt_blk is generated for devices types
>
>    FILE_DEVICE_DISK
>    FILE_DEVICE_CD_ROM
>    FILE_DEVICE_VIRTUAL_DISK
>    FILE_DEVICE_DFS
>    FILE_DEVICE_NETWORK_FILE_SYSTEM
>
> FILE_DEVICE_DFS or FILE_DEVICE_NETWORK_FILE_SYSTEM might be a problem,
> but there should be a way to workaround that, if necessary, isn't it?
> Maybe it's a bad idea to treat those as blk devices at all?

Could anything be read from such a node? If yes, treat as character device?

If no and /proc/sys/foo/bar/some/path allows access to /some/path behind 
DFS/NFS node /proc/sys/foo/bar, then treat as directory?

This is already the case for SMB shares:

$ ls -ld /proc/sys/DosDevices/X:
lr-------- 1 ... 0 Nov 30 13:10 /proc/sys/DosDevices/X: ->
   /proc/sys/Device/LanmanRedirector/;X:..../127.0.0.1/Share

$ ls -lLd /proc/sys/DosDevices/X:
drwxr-xr-x 1 ... 0 Nov 14 09:06 /proc/sys/DosDevices/X:

$ ls -L /proc/sys/DosDevices/X:
... files on this share

Thanks,
Christian

