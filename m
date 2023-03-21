Return-Path: <SRS0=5TLb=7N=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0005-f.auone-net.jp (snd00005.auone-net.jp [111.86.247.5])
	by sourceware.org (Postfix) with ESMTPS id 7ABE43857C43
	for <cygwin-patches@cygwin.com>; Tue, 21 Mar 2023 15:32:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7ABE43857C43
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from [172.27.35.81] by dmta0008.auone-net.jp with ESMTP
          id <20230321153213820.IMCH.17985.[172.27.35.81]@dmta0008.auone-net.jp>
          for <cygwin-patches@cygwin.com>; Wed, 22 Mar 2023 00:32:13 +0900
Message-ID: <434bbf77-6a08-3be2-747f-13dfc4637275@ac.auone-net.jp>
Date: Wed, 22 Mar 2023 00:32:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] fix unlink/rename failure in hyper-v container
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
 <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <b5553609-8ce3-41fd-4215-2504a8491652@ac.auone-net.jp>
 <ZBWL85hJIlbZHc/D@calimero.vinschen.de>
 <608a78b6-f523-14f1-333d-f59e9f2bb8d5@ac.auone-net.jp>
 <ZBhy7E4vKHTRNW6k@calimero.vinschen.de>
 <ZBjD9exM9ZBGDzK3@calimero.vinschen.de>
From: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
In-Reply-To: <ZBjD9exM9ZBGDzK3@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

> Wait.  I might have misunderstood something.  This is about accessing a
> host NTFS from inside a Hyper-V isolated process, right?  So from the
> point of view of the Hyper-V isolated Cygwin process, the NTFS
> filesystem is a *local* filesystem?  Or is it mapped as a remote
> filesystem?
> 
> The difference is important, because my patch would only change the
> outcome if the Cygwin process in the Hyper-V container gets the
> NTFS filesystem presented as a remote filesystem.
> 
> I noticed this problem when I was looking into implementing the
> FILE_SUPPORTS_OPEN_BY_FILE_ID flag checking.  I have a different
> solution from the one I pushed today in the loop which probably
> makesmuch more sense and is independent of the subtil difference
> between loca and remote FS.

I don't understand the whole picture, so I may be missing the point.
So I will report only the points I am sure of.

The file system on the host side is the local disk.
In the container, it appears to be exposed as a ntfs local
file system because unlink_nt() tries to use posix unlink semantics.

-- 
Yoshinao Muramatsu <ysno@ac.auone-net.jp>

