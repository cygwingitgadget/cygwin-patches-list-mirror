Return-Path: <SRS0=aWaS=7M=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0004.auone-net.jp (snd00002.auone-net.jp [111.86.247.2])
	by sourceware.org (Postfix) with ESMTPS id 59CBC3858D32
	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 13:06:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 59CBC3858D32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from [192.168.1.101] by dmta0004.auone-net.jp with ESMTP
          id <20230320130650997.FIJB.58232.[192.168.1.101]@dmta0004.auone-net.jp>
          for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 22:06:50 +0900
Message-ID: <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
Date: Mon, 20 Mar 2023 22:06:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Content-Language: ja-JP
To: cygwin-patches@cygwin.com
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
From: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
In-Reply-To: <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023/03/18 19:01, Corinna Vinschen wrote:
>> In the logs, here we can find some differences.
>> But I believe it is unclear if it will always be so.
>> If additional inspections are done, they will be costly.
> 
> Assuming we can pull some information from the filesystem flags, the
> cost is negligible.  We just check bits in a filesystem bitmask.

I was expecting something like checking the file system driver
configuration as an additional test.
It would be ideal if the checks could be done at no additional cost.

> Assuming we can fetch useful info from the filesystem flags, we could
> basically do both, add your patch to have a workaround in case the
> Windows call returns INVALID_PARAMETER, and an early test for a FS
> flag which can be used down the road to avoid the workaround.

Adding workarounds can be done now and adding early testing
can be done once the judgment conditions are known. Great.

> This is disappointing.  One of the newer filesystem flags is
> 0x400, FILE_SUPPORTS_POSIX_UNLINK_RENAME.  As you can see,
> the flag is set.  But the POSIX functionality doesn't work
> here, right?

I was not aware that there was a FILE_SUPPORTS_POSIX_UNLINK_RENAME there.
I was only looking at the part where there was a difference.
Right, FILE_SUPPORTS_POSIX_UNLINK_RENAME doesn't work
on mounted volume with hyper-v isolation.

I additionally checked with the ltsc2016 version of the hyper-v container.
POSIX_UNLINK_RENAME should not be supported from the windows version,
but interesting results were obtained.
FILE_SUPPORTS_POSIX_UNLINK_RENAME is not considered to work,
but has not been tested.

> However, what's really curious here is the fact that the
> FILE_SUPPORTS_OPEN_BY_FILE_ID flag is missing.
> 
> NTFS always supports this since Windows 2003!  So we could
> use this flag as indicator that, probably, POSIX rename/unlink
> won't work.

I thought that if there was no FILE_SUPPORTS_OPEN_BY_FILE_ID
and OpenByFileId() worked, it would be a Signature,
but the result was different.

I tested OpenByFileID() on a bind-mounted directory, it was failed.
Maybe it's because of the path isolation.
ltsc2022 process isolation says "I support it" but it not works.
Okay, it's not a security issue. So now I'm writing this here.

Unfortunately, the state of the FILE_SUPPORTS_OPEN_BY_FILE_ID flag
does not match the actual behavior, so I fear it may be corrected.

FileSystemAttributes on containers
image   isolation mounted? FileSystemAttributes
ltsc2016 hyper-v  normal  0x1c700df        +OPEN_BYID
ltsc2022 hyper-v  normal  0x1c706df        +OPEN_BYID +POSIX +CLEANUP
ltsc2022 process  normal  0x1c706df        +OPEN_BYID +POSIX +CLEANUP
ltsc2016 hyper-v  binded  0x2c706ff +USN_J            +POSIX +CLEANUP +QUOTA
ltsc2022 hyper-v  binded  0x2c706ff +USN_J            +POSIX +CLEANUP +QUOTA
ltsc2022 process  binded  0x3e706ff +USN_J +OPEN_BYID +POSIX +CLEANUP +QUOTA

OpenByFileId and POSIX_UNLINK_RENAME test result
image    isolation mounted? OpenByFileId POSIX_UNLINK_RENAME
ltsc2016 hyper-v   normal   success      fail?(windows version)
ltsc2022 hyper-v   normal   success      success
ltsc2022 process   normal   success      success
ltsc2016 hyper-v   binded   fail         not tested
ltsc2022 hyper-v   binded   fail         fail
ltsc2022 process   binded   fail         success

ps
Corinna, I read the new email about fs_info::update patch
you posted while I was writing this.
I will report back when I test it, but it may take some time
as I usually use msys2 and don't have a cygwin development environment.

-- 
Yoshinao Muramatsu <ysno@ac.auone-net.jp>

