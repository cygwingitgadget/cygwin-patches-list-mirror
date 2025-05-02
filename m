Return-Path: <SRS0=OYBk=XS=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id 35AD73858280
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 14:09:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 35AD73858280
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 35AD73858280
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746194992; cv=none;
	b=GjFIUDWel6/ATAhF64IWVct/69T/3dTQKDseozDwMOUygbDdO2B6Ukb66Zz8FIHZ2wbl9zeGPETVcMxn98U+MOZ6INiEXRlMsyrHGoTLfXMpx8K/0+uf896MjX3D5t8ooxvdrBbwxLMpintn2AIM4tvXhn4lky+35ECDWXPo41E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746194992; c=relaxed/simple;
	bh=H6Hjf9XnWIvWJuT0m6pe7q3jjGOa87pFmmrOdwDwfZo=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=wwCbYn7qsmy7+sBYNtY2Syl7uXCQNDM70cfC1ZpMocIvY8ox8uezbC8sjR/UMr2WWkmBJngmD2n0r6oYmT3yvRGrA5+S6kSLGkikIiSQHifTpa2MHR5o3FKZ6b4gPFTJkWeAAh9aIBr4eQ3oK9fWP54YHVcSmBusiRrk5G0gISQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 35AD73858280
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
	by mailout10.t-online.de (Postfix) with SMTP id F38AB12F3
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 16:09:50 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd77.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uAr5K-44lFEO0; Fri, 2 May 2025 16:09:50 +0200
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
To: cygwin-patches@cygwin.com
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
 <20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
 <4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
 <20250502203144.ca3ba0953ce5bb9f97267920@nifty.ne.jp>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <1c5aa56e-63e0-c989-4f67-cd77f0c769d1@t-online.de>
Date: Fri, 2 May 2025 16:09:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <20250502203144.ca3ba0953ce5bb9f97267920@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1746194990-4CFF6CC6-62B332EC/0/0 CLEAN NORMAL
X-TOI-MSGID: 87b2bdb9-1d73-48f5-b10a-26f2b6ea3d7b
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano wrote:
> On Tue, 15 Apr 2025 11:02:37 +0200
> Christian Franke wrote:
>> Hi Takashi,
>>
>> Takashi Yano wrote:
>>> Hi Christian,
>>>
>>> On Fri, 11 Apr 2025 16:46:07 +0200
>>> Christian Franke wrote:
>>>> In rare cases, '/bin/kill -f PID' hangs because kill(2) is always tried
>>>> first. With this patch, this could be prevented with '/bin/kill -f -s -
>>>> PID'.
>>> I wonder why kill(2) hangs. Do you have any idea?
>> Sorry no. I observed this in early (Cygwin 3.5.4) testing of stress-ng
>> for ITP, but could no longer reproduce it.
>>
>> Here are tests which currently (3.7.0-0.51.gd35cc82b5ec1) ignore but not
>> hang kill(pid, SIGKILL):
>>
>> stress-ng --mprotect 1 -t 5 -v
>> stress-ng --priv-instr 1 -t 5 -v
>> stress-ng --sigchld 1 -t 5 -v
>> stress-ng --sigsegv 1 -t 5 -v
>>
>> Run this in another window to see that child processes are left behind:
>>
>> killall -v -9 stress-ng; sleep 4; taskkill /F /T /IM stress-ng.exe
>>
>> For a minimal testcase regarding --priv-instr, see:
>> https://sourceware.org/pipermail/cygwin/2025-March/257726.html
> I could finally fix this issue. See:
> https://cygwin.com/pipermail/cygwin-patches/2025q2/013696.html

Thanks - I will test it soon.


>
>>> If kill(2) hangs in some cases, shouldn't we fix that
>>> rather than patching to kill(1)?
>> Of course. This feature was intended as a first step for an 'onboard'
>> tool for the CI tests suggested by Jon Turney. A second step could be an
>> --all option to replace 'taskill' or 'pskill'.
> Do you think we still need this patch even though the issue
> above has been fixed?

Possibly not. Let's forget the patch for now.

-- 
Thanks,
Christian

