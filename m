Return-Path: <SRS0=2JHq=TC=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 1D4EB3858416
	for <cygwin-patches@cygwin.com>; Mon,  9 Dec 2024 10:52:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D4EB3858416
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D4EB3858416
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733741529; cv=none;
	b=RKL4oeKpVrdhiGkjixnK2ELudHTMmBHbL0f4R7KWqTB2SZBaLP7btDVAlXDc4galNYnkpcVf4WzdiXaour6whRt38NV4f5B9uAYjz0OL6Eg3QI4eGKIR8q8IZ0jmgSvWYQlllsJavrOQphPG47S04yEV8HPhU39mrkD+WWsKTMg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733741529; c=relaxed/simple;
	bh=8yZaX3VQ/ib65h6GpQlP3uGeNw43Y4+m/DSQW3mvr3I=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=kRgLDfx32V+WgEw5tspnMwZoknz5w5iM2ojmU/XHrKMG8kzOO4dxErHCfnh7J3kTxPEAIWcfBOJumfBIZQ5NPWndCTERCaIFDXIsrCD4Numai9FXBeROA1GhpppF5yR/PefWoul/lGP7MEbFg6kC9+vakbrAt/MqOSJAs95FV3E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D4EB3858416
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
	by mailout05.t-online.de (Postfix) with SMTP id 2DDE1113A
	for <cygwin-patches@cygwin.com>; Mon,  9 Dec 2024 11:52:05 +0100 (CET)
Received: from [192.168.2.103] ([91.57.250.70]) by fwd78.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tKbMw-2KCmAq0; Mon, 9 Dec 2024 11:52:02 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
To: cygwin-patches@cygwin.com
References: <3a052da3-f60e-1d7a-f741-956926af23da@t-online.de>
 <Z1bEgYIYR43Jn45A@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <9362a9a5-2ec9-0c89-9d2a-5b5f357857ad@t-online.de>
Date: Mon, 9 Dec 2024 11:52:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Z1bEgYIYR43Jn45A@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1733741522-98FF686F-7E727F57/0/0 CLEAN NORMAL
X-TOI-MSGID: a910bf3b-e3fa-412f-9997-3059ee59fad1
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> Hi Christian,
>
> On Dec  6 17:52, Christian Franke wrote:
>> A first attempt to add SCHED_BATCH.
>>
>> Still TODO:
>> - Add SCHED_IDLE/BATCH to winsup/doc/posix.xml
>> - Provide correct values in (18) and (19) of /proc/PID/stat for SCHED_BATCH.
>> - Provide correct value in (18) of /proc/PID/stat for SCHED_FIFO/RR.
>>
>> -- 
>> Regards,
>> Christian
>>
>>  From 0822917252fdade3edc240b4fbfd3c0f47ef1deb Mon Sep 17 00:00:00 2001
>> From: Christian Franke <christian.franke@t-online.de>
>> Date: Fri, 6 Dec 2024 17:32:29 +0100
>> Subject: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
>>
>> Add SCHED_BATCH to <sys/sched.h>.  SCHED_BATCH is similar to SCHED_OTHER,
>> except that the nice value is mapped to a one step lower Windows priority.
>> Rework the mapping functions to ease the addition of this functionality.
>>
>> Signed-off-by: Christian Franke <christian.franke@t-online.de>
>> ---
>>   newlib/libc/include/sys/sched.h          |   8 ++
>>   winsup/cygwin/local_includes/miscfuncs.h |   4 +-
>>   winsup/cygwin/miscfuncs.cc               | 155 +++++++++++++----------
>>   winsup/cygwin/release/3.6.0              |  11 +-
>>   winsup/cygwin/sched.cc                   |  15 ++-
>>   winsup/cygwin/syscalls.cc                |  20 +--
>>   6 files changed, 129 insertions(+), 84 deletions(-)
>>
>> diff --git a/newlib/libc/include/sys/sched.h b/newlib/libc/include/sys/sched.h
>> index c96355c24..265215211 100644
>> --- a/newlib/libc/include/sys/sched.h
>> +++ b/newlib/libc/include/sys/sched.h
>> @@ -38,6 +38,14 @@ extern "C" {
>>   #define SCHED_FIFO     1
>>   #define SCHED_RR       2
>>   
>> +#if __GNU_VISIBLE
>> +#if defined(__CYGWIN__)
>> +#define SCHED_BATCH    0
>> +#else
>> +#define SCHED_BATCH    3
>> +#endif
>> +#endif
> I would prefer that SCHED_BATCH gets its own, single value.
> There's no good reason to add another ifdef for that.  Why
> not just #define SCHED_BATCH 6?

The idea was to keep the non-Cygwin value in sync with Linux.
https://github.com/torvalds/linux/blob/fac04ef/include/uapi/linux/sched.h#L111
Of course we could drop this idea and use 6.

