Return-Path: <SRS0=BuGu=7K=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0004.auone-net.jp (snd00014.auone-net.jp [111.86.247.14])
	by sourceware.org (Postfix) with ESMTPS id 6281D3858C50
	for <cygwin-patches@cygwin.com>; Sat, 18 Mar 2023 05:29:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6281D3858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from [192.168.1.101] by dmta0004.auone-net.jp with ESMTP
          id <20230318052903925.DBNS.58232.[192.168.1.101]@dmta0004.auone-net.jp>
          for <cygwin-patches@cygwin.com>; Sat, 18 Mar 2023 14:29:03 +0900
Message-ID: <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
Date: Sat, 18 Mar 2023 14:29:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Content-Language: ja-JP
To: cygwin-patches@cygwin.com
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
From: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
In-Reply-To: <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna.
I'm Yoshinao Muramatsu. Thank you for your thoughtful guidance.
I have not modified the patch yet,
but I have made some observations and post the results.

I forgot to mention in my first post that there is a workaround
for this issue, which is to use process isolation unless
hyper-v isolation is absolutely necessary
(mainly caused by build number difference between host and container).

In the logs, here we can find some differences.
But I believe it is unclear if it will always be so.
If additional inspections are done, they will be costly.
I would also like to see better support for POSIX unlink/rename
semantics in the container mechanism.

Therefore, I think it is not a bad idea to simply retry rather than spending
time every time to check the conditions to deal with rare situations.
However, in certain situations it happens all the time.
(So if we can cache it that would be great.)
But performance in the vast majority of other situations is more important.

In the following logs, c:\ is the normal ntfs volume in the container,
andc:\opt is the volume of the bind mounted host.
Where the differences are
- 0x00000020 Supports Disk Quotas
- 0x01000000 Supports Open By FileID
- 0x02000000 Supports USN Journal

== hyper-v container (has issue)
$ mount
C:/cygwin64/bin on /usr/bin type ntfs (binary,auto)
C:/cygwin64/lib on /usr/lib type ntfs (binary,auto)
C:/cygwin64 on / type ntfs (binary,auto)
C: on /cygdrive/c type ntfs (binary,posix=0,user,noumount,auto)

$ /usr/lib/csih/getVolInfo.exe /cygdrive/c/
Device Type        : 7
Characteristics    : 20020
Volume Name        : <>
Serial Number      : 3456656850
Max Filenamelength : 255
Filesystemname     : <NTFS>
Flags              : 1c706df
...snip...

$ /usr/lib/csih/getVolInfo.exe /cygdrive/c/opt/
Device Type        : 7
Characteristics    : 20020
Volume Name        : <>
Serial Number      : 955187689
Max Filenamelength : 255
Filesystemname     : <NTFS>
Flags              : 2c706ff
...snip...

=== process container (works fine)
$ /usr/lib/csih/getVolInfo.exe /cygdrive/c
Device Type        : 7
Characteristics    : 20
Volume Name        : <>
Serial Number      : 3456656850
Max Filenamelength : 255
Filesystemname     : <NTFS>
Flags              : 1c706df
...snip...

$ /usr/lib/csih/getVolInfo.exe /cygdrive/c/opt
Device Type        : 7
Characteristics    : 20
Volume Name        : <>
Serial Number      : 955187689
Max Filenamelength : 255
Filesystemname     : <NTFS>
Flags              : 3e706ff
...snip...

=== host
Microsoft Windows [Version 10.0.20348.1547]
(c) Microsoft Corporation. All rights reserved.

C:\Users\Administrator>\cygpkgs\getVolInfo.exe c:\
Device Type        : 7
Characteristics    : 20020
Volume Name        : <>
Serial Number      : 955187689
Max Filenamelength : 255
Filesystemname     : <NTFS>
Flags              : 3e706ff
   FILE_CASE_SENSITIVE_SEARCH  : TRUE
   FILE_CASE_PRESERVED_NAMES   : TRUE
   FILE_UNICODE_ON_DISK        : TRUE
   FILE_PERSISTENT_ACLS        : TRUE
   FILE_FILE_COMPRESSION       : TRUE
   FILE_VOLUME_QUOTAS          : TRUE
   FILE_SUPPORTS_SPARSE_FILES  : TRUE
   FILE_SUPPORTS_REPARSE_POINTS: TRUE
   FILE_SUPPORTS_REMOTE_STORAGE: FALSE
   FILE_VOLUME_IS_COMPRESSED   : FALSE
   FILE_SUPPORTS_OBJECT_IDS    : TRUE
   FILE_SUPPORTS_ENCRYPTION    : TRUE
   FILE_NAMED_STREAMS          : TRUE
   FILE_READ_ONLY_VOLUME       : FALSE
   FILE_SEQUENTIAL_WRITE_ONCE  : FALSE
   FILE_SUPPORTS_TRANSACTIONS  : TRUE

C:\Users\Administrator>fsutil fsinfo volumeinfo c:
Volume Name :
Volume Serial Number : 0x38ef01e9
Max Component Length : 255
File System Name : NTFS
Is ReadWrite
Not Thinly-Provisioned
Supports Case-sensitive filenames
Preserves Case of filenames
Supports Unicode in filenames
Preserves & Enforces ACL's
Supports file-based Compression
Supports Disk Quotas
Supports Sparse files
Supports Reparse Points
Returns Handle Close Result Information
Supports POSIX-style Unlink and Rename
Supports Object Identifiers
Supports Encrypted File System
Supports Named Streams
Supports Transactions
Supports Hard Links
Supports Extended Attributes
Supports Open By FileID
Supports USN Journal

-- 
Yoshinao Muramatsu <ysno@ac.auone-net.jp>
