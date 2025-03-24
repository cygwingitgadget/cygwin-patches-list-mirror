Return-Path: <SRS0=5r2v=WL=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id BF8C8385B52C
	for <cygwin-patches@cygwin.com>; Mon, 24 Mar 2025 11:00:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BF8C8385B52C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BF8C8385B52C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742814011; cv=none;
	b=fJtk7+HoaqBuomHi7tiQfFok0dyCod2qeDn2i7cEHhiJ4/rtSna+QHD7KW18Z4VraO2Q289CAdH9VPr4qP9xxbKMOfcKeZzhxuVHRXsenh5M+VrI0xP5tCMxvSNHiwJgVzn8H6PxZXebcL4YKced3TjWfTNWC240pnDdHC+ce7k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742814011; c=relaxed/simple;
	bh=Mj98bC9El3pZBGwejAPMdnN46/KVMtX13KzPYGVWEsw=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=LdZWnnMIn9Jd6gHq7opXK/NhBgEC9Nhzqd+UQpzh3cWJXonRWVN7ISfDy0EIiRstzy4RiLjETLCq9VlcRw8yFmsqTU8Y3lwdYFSPde3J+mLq3neEbQnkEVSfvbC+gT+Hk9xXdBu1NcHIiokUAyLGQhWiZmgnZPwAzQ1YlTAKhL4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BF8C8385B52C
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
	by mailout07.t-online.de (Postfix) with SMTP id A2FB2B3C
	for <cygwin-patches@cygwin.com>; Mon, 24 Mar 2025 12:00:00 +0100 (CET)
Received: from [192.168.2.101] ([87.187.37.162]) by fwd87.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1twfXC-2J0o1A0; Mon, 24 Mar 2025 11:59:58 +0100
Subject: Re: [PATCH] Cygwin: signal: Clear direction flag in sigdeleyed
To: cygwin-patches@cygwin.com
References: <20250324012833.518-1-takashi.yano@nifty.ne.jp>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <fd7be3fb-0f32-3653-def9-79402bba41c5@t-online.de>
Date: Mon, 24 Mar 2025 11:59:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <20250324012833.518-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1742813998-F6FECDA5-AAC74C00/0/0 CLEAN NORMAL
X-TOI-MSGID: 019e7a0f-7a6c-48e9-a23d-44bbcf54fed0
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano wrote:
> x86_64 ABI requires the direction flag in CPU flags register cleared.
> https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions
> However, currently that flag is not maintained in signal handler.
> Therefore, if the signal handler is called when that flag is set, it
> destroys the data and may crash if rep instruction is used in the
> signal handler. With this patch, the direction flag is cleared in
> sigdelayed() by adding cld instruction.
>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257704.html
> Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>   winsup/cygwin/scripts/gendef | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> index a2f0392bc..861a2405b 100755
> --- a/winsup/cygwin/scripts/gendef
> +++ b/winsup/cygwin/scripts/gendef
> @@ -179,6 +179,7 @@ sigdelayed:
>   	movq	%rsp,%rbp
>   	pushf
>   	.seh_pushreg %rax			# fake, there's no .seh_pushreg for the flags
> +	cld					# x86_64 ABI requires direction flag cleared
>   	# stack is aligned or unaligned on entry!
>   	# make sure it is aligned from here on
>   	# We could be called from an interrupted thread which doesn't know

Works as expected:
- the testcase no longer aborts.

- a version with modified main loop does not detect DF modification by 
the signal:

   while ((cnt = sigcnt) < 1000) {
     if (!(__builtin_ia32_readeflags_u64() & 0x0400) != !std)
       return 13;
     if ((cnt & 1) && !std) {
       asm volatile ("std");
       std = 1;
     }
     else if (!(cnt & 1) && std) {
       asm volatile ("cld");
       std = 0;
     }
   }

- The related stress-ng testcases no longer report segfaults:

$ n=0
$ while
   stress-ng --parallel 2 --with memcpy,tree --memcpy-method libc 
--tree-method btree -t 2;
do echo OK $((++n)); done
...
OK 500
...


-- 
Thanks,
Christian

