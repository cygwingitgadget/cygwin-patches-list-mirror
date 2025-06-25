Return-Path: <SRS0=a7JR=ZI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id 502D63858039
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 11:15:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 502D63858039
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 502D63858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750850130; cv=none;
	b=vssxusCHNEgkUXKA+qIzZP5VoM/DBHMfpMUFx/7MEnokp9/jSFWQKJIwax3h2pxjTROB8QJ8l7hRMnCy7JW9+o/sBfpVyjyUS44Et2VXpXCV4HzDHh4fFr66Ij2A9dI/Xs0QbgzkSdPETt1wtQs3tlr4m3RnU+X4daFHd3uOpHs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750850130; c=relaxed/simple;
	bh=9wwkQK8TCWTa4dphEDi+jmnECckLxPpNncqs8benirY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=XVCk530MNXiuB4lPHZuMnmAy4iHkk96yPeKsPbrgJFV+BrOBOfCzs0yFPRnigJwWedu/uhReYuIoS1SNd9WKNZw6YbPxwG0BNsfjqY2UCe4/FmiYDDnRdFUU5ZZG/XpYJhF7T9OMyUm6jDqLjTu4BcklGOFl0EKhCagBp7Y4iUs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 502D63858039
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CAE0AB22C7E
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvvdeuheffuedvtdfhveekieefvdfhfeetffdvudehkeeigeetvdetjeetieeileenucfkphepkeeirddufeelrdduieejrdeifeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddufeelrdduieejrdeifedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudeijedqieefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdegpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.139.167.63) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE0AB22C7E for cygwin-patches@cygwin.com; Wed, 25 Jun 2025 12:15:29 +0100
Message-ID: <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
Date: Wed, 25 Jun 2025 12:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
In-Reply-To: <aFupr2xZJQY28zEQ@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 25/06/2025 08:47, Corinna Vinschen wrote:
[...]
>> diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
>> index 5007a3694..3322810cc 100644
>> --- a/winsup/cygwin/cygwin.sc.in
>> +++ b/winsup/cygwin/cygwin.sc.in
>> @@ -1,6 +1,9 @@
>>   #ifdef __x86_64__
>>   OUTPUT_FORMAT(pei-x86-64)
>>   SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
>> +#elif __aarch64__
>> +OUTPUT_FORMAT(pei-aarch64-little)
>> +SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
> 
> Given that /usr/lib/w32api is arch independent, maybe we should
> take out that SEARCH_DIR from the arch dependent code, i.e.
> 
> if x86_64
> SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api");
> elif aarch
> SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api");
> else
> error
> endif
> SEARCH_DIR("=/usr/lib/w32api");
> 
> What do you think?
> 

Maybe even a pair of comments, to identify that the first search path in 
the sys-root when cross-compiling, the second is for when building natively?

(I'm guessing that's what's going on?)

(Hmm... in which case, couldn't the first one be written as just 
"=/lib/w32api"? (since the '=' stands for $SYSROOT?). But maybe there's 
some wrinkle which prevents that from working?)


