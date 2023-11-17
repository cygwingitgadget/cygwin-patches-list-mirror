Return-Path: <SRS0=NTQ+=G6=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id C2FF73858D33
	for <cygwin-patches@cygwin.com>; Fri, 17 Nov 2023 16:45:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C2FF73858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C2FF73858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1700239508; cv=none;
	b=YmHGED/8Fe7eY/nYJmBduT7OSQnwNUk2Ep55ObVCI9iWB6IGO5i7oR/RnRuti0jLKl67MSp88IolSvRa2bn0UJkq2EJBQ2nR/AErsIhmUJrPPnNIN/y8Uf1+8QWh5gl30CLcQ4kUDOfwY2m63PJdzd2vhE4hTQ6xbFTf6qkBddM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1700239508; c=relaxed/simple;
	bh=sixZ72QWxG1pIe251TNOxV4znTks1Mg0mSKnYgahA9g=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=PON7a39yCE/XS/94Ngbyp1tsP4kCoxQ2yBAg+wsXBioKSobxnIH8i7XmhZiigKGUQfEmj+DhXntRKIRed9rJBuhOyL7z5+TrjuFge+SN+uBTKztdvuIggm+IpcaUF7f7xtbqf/of1WKaNJyfnxI1RbvjoggU3GiIH/g6BssMnR4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
	by mailout02.t-online.de (Postfix) with SMTP id 914BF5CDC
	for <cygwin-patches@cygwin.com>; Fri, 17 Nov 2023 17:45:05 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd85.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r41xn-0w2h3A0; Fri, 17 Nov 2023 17:45:03 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
To: cygwin-patches@cygwin.com
References: <9c82a61c-02f8-a679-90f2-90e853d47e53@t-online.de>
 <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <57fb24ee-cd4c-0b54-6613-40f817e12571@t-online.de>
Date: Fri, 17 Nov 2023 17:45:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1700239503-AB7FD9F9-2F8EDAC4/0/0 CLEAN NORMAL
X-TOI-MSGID: f1824fd4-45f9-4bfb-b5b1-52fb1878848f
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Nov 17 15:39, Christian Franke wrote:
>> The last two /dev/disk subdirectories :-)
>>
>> Note a minor difference: On Linux, empty /dev/disk subdirectories apparently
>> never appear. A subdirectory is not listed in /dev/disk if it would be
>> empty. Not worth the effort to emulate.
> Agreed.  This is really great.  I just pushed your patch.
>
> However, there's something strange in terms of by-label:
>
> I have two partitions with labels:
>
>    $ ls -l /dev/disk/by-label
>    total 0
>    lrwxrwxrwx 1 corinna vinschen 0 Nov 17 17:18 blub -> ../../sda3
>    lrwxrwxrwx 1 corinna vinschen 0 Nov 17 17:18 blub2 -> ../../sdb2
>    $
>
> Now I change the label of sdb2 to the same "blub" string as on sda3:
>
>    $ ls -l /dev/disk/by-label
>    total 0
>    $
>
> I'd expected to see only one, due to the name collision, but en empty
> dir is a bit surprising...  And it may occur more often than not, given
> that the default label "New_Volume" probably won't get changed very
> often.
>

This is intentional and inherited from the very first patch, see the 
loop behind qsort(). If a range of identical names appear, all these 
entries are removed. If some "random" entry would be kept, it might no 
longer be the persistent link the user expects. We could possibly add 
some hash like done for by-id or append a number in such cases later. 
Need some more time to thing about it....

I will sent a patch for the new-features doc soon.

Christian

