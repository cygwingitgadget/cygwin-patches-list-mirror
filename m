Return-Path: <Christian.Franke@t-online.de>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
 by sourceware.org (Postfix) with ESMTPS id AC643389203D
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 18:48:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AC643389203D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=Christian.Franke@t-online.de
Received: from fwd19.aul.t-online.de (fwd19.aul.t-online.de [172.20.27.65])
 by mailout05.t-online.de (Postfix) with SMTP id 5E63B425306D
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 19:48:14 +0100 (CET)
Received: from [192.168.2.101]
 (ZkRC-rZLghk0w-9HO5DRtv03egM9-MpN5AzZ88bBddcniGeibJpcw9KHTB6sHq2wb1@[79.230.165.86])
 by fwd19.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kkAhC-0tu9Tc0; Tue, 1 Dec 2020 19:48:14 +0100
Subject: Re: [PATCH] Cygwin: Fix access to block devices below /proc/sys.
To: cygwin-patches@cygwin.com
References: <9c5f23af-ac11-3856-7aab-88dd1c184429@t-online.de>
 <20201130110344.GF303847@calimero.vinschen.de>
 <cd58c473-6aa4-b104-5909-5bd9ed6df1b1@t-online.de>
 <20201130140435.GH303847@calimero.vinschen.de>
 <20201130142123.GI303847@calimero.vinschen.de>
 <c07b35fb-525f-0744-0297-af49aa219cdd@t-online.de>
 <20201201160455.GN303847@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <46d31f81-d077-b088-6e07-3684582f666d@t-online.de>
Date: Tue, 1 Dec 2020 19:48:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.4
MIME-Version: 1.0
In-Reply-To: <20201201160455.GN303847@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: ZkRC-rZLghk0w-9HO5DRtv03egM9-MpN5AzZ88bBddcniGeibJpcw9KHTB6sHq2wb1
X-TOI-EXPURGATEID: 150726::1606848494-00008954-2D053CEF/0/0 CLEAN NORMAL
X-TOI-MSGID: faa81660-fd8d-4853-b618-10d3d1852722
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00, BODY_8BITS,
 FREEMAIL_FROM, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 01 Dec 2020 18:48:18 -0000

Corinna Vinschen wrote:
> On Dec  1 16:59, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> \Device\Mup is a character device and thus the devices below are not
>>> accessible for directory enumeration.  I assume it's the same for DFS.
>> Here I see \Device\Mup as a block device on two systems (cygwin1.dll 3.1.7):
>>
>> $ ls -l /proc/sys/Device/Mup
>> brwxrwx--x 1 Administrators SYSTEM 0, 250 Dec  1 16:50 /proc/sys/Device/Mup
> Huh?
>
> $ ls -l /proc/sys/Device/Mup
> crwxrwx--x 1 Administrators SYSTEM 0, 250 Dec  1 17:04 /proc/sys/Device/Mup
>
> This is what I'd expect.  Can you debug why this is a block device
> on your systems?
>

NtQueryVolumeInformationFile() returns {DeviceType = 0x14, 
Characteristics = 0x20010}

fhandler_procsys::exists(...):
...
   status = NtOpenFile (&h, READ_CONTROL | FILE_READ_ATTRIBUTES, &attr, &io,
                   FILE_SHARE_VALID_FLAGS, FILE_OPEN_FOR_BACKUP_INTENT);
...
   if (NT_SUCCESS (status))
     {
       FILE_FS_DEVICE_INFORMATION ffdi;
...
       /* Check for the device type. */
       status = NtQueryVolumeInformationFile (h, &io, &ffdi, sizeof ffdi,
                          FileFsDeviceInformation);
...
       if (NT_SUCCESS (status))
       {
         if (ffdi.DeviceType == FILE_DEVICE_NETWORK_FILE_SYSTEM)
           file_type = virt_blk;  <<===============
        ...


Thanks,
Christian

