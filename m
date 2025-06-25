Return-Path: <SRS0=a7JR=ZI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id 3BCAD3857C67;
	Wed, 25 Jun 2025 15:42:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3BCAD3857C67
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3BCAD3857C67
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750866179; cv=none;
	b=IZrTn1EBKoPFTq8uxSo3AwTn/U0755uXEPpaji7At6qu5vbe6mTMevT5/ZAmJ5U13VArw8C7dFUAbaUw68alwZvg95XqZKLMI43RK2ftAWrpvefpm2Gta0dRtYvg4piKRRtEgXVbmg/0x+0ZErhs4vVwkAtiW7dbAhmgFvcjmcw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750866179; c=relaxed/simple;
	bh=ALJ8qpC3OY1KsWxiSYc+PS6LzU7Gc1KRGqaWRm278Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=OlF5CAH7cbcsoCcR/npddkmMQJvPRvXfR8mkTya03vsT3KI27+rKwYq1LeiDgKgnuJcBjcOLYr4QyT0KAErreNri0BnW4HPcnrzMAfPkQbbCjFK5mvpnbeWU1qXlGdEj+vgTzJ2NnIJOkS/JqsLQ7BgYRYA8hvcmQ92SxK1LI9U=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3BCAD3857C67
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CDB0AB90497
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudefledrudeijedrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudefledrudeijedrieefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqdeifedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddthedpnhgspghrtghpthhtohepvddprhgtphhtthhopegtohhrihhnnhgrqdgthihgfihinhestgihghifihhnrdgtohhmpdhrtghpthhtoheptgihghif
	ihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.139.167.63) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CDB0AB90497; Wed, 25 Jun 2025 16:42:58 +0100
Message-ID: <81096ca9-9542-4818-b363-f3856915050f@dronecode.org.uk>
Date: Wed, 25 Jun 2025 16:42:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
References: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
 <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
 <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 25/06/2025 12:39, Corinna Vinschen wrote:
> On Jun 25 12:15, Jon Turney wrote:
>> On 25/06/2025 08:47, Corinna Vinschen wrote:
>> [...]
>>>> diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
>>>> index 5007a3694..3322810cc 100644
>>>> --- a/winsup/cygwin/cygwin.sc.in
>>>> +++ b/winsup/cygwin/cygwin.sc.in
>>>> @@ -1,6 +1,9 @@
>>>>    #ifdef __x86_64__
>>>>    OUTPUT_FORMAT(pei-x86-64)
>>>>    SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
>>>> +#elif __aarch64__
>>>> +OUTPUT_FORMAT(pei-aarch64-little)
>>>> +SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
>>>
>>> Given that /usr/lib/w32api is arch independent, maybe we should
>>> take out that SEARCH_DIR from the arch dependent code, i.e.
>>>
>>> if x86_64
>>> SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api");
>>> elif aarch
>>> SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api");
>>> else
>>> error
>>> endif
>>> SEARCH_DIR("=/usr/lib/w32api");
>>>
>>> What do you think?
>>>
>>
>> Maybe even a pair of comments, to identify that the first search path in the
>> sys-root when cross-compiling, the second is for when building natively?
>>
>> (I'm guessing that's what's going on?)
>>
>> (Hmm... in which case, couldn't the first one be written as just
>> "=/lib/w32api"? (since the '=' stands for $SYSROOT?). But maybe there's some
>> wrinkle which prevents that from working?)
> 
> It might work, but it would also enable the /lib/w32api search path
> on a native install.

Which is what /usr/lib/w32api is bound to, anyhow, so uh?

