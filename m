Return-Path: <SRS0=16kU=SU=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.131])
	by sourceware.org (Postfix) with ESMTP id F3A0A3858420
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 22:38:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F3A0A3858420
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F3A0A3858420
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732574309; cv=none;
	b=RuXmlaqVRUmmZgo4je4qbQ7Sq/3Iyic78wi/aN+uR8mqucyWMkKJBm2bxAgfz+u46pjBLcEWynKQolNP+lpB7/2c5thi46geyzA9EqbCfHx4mueTHwfB/pRbfa5INvjC3G1Dx3KQDAaBsxOVAUfWjPVijx+ax6Y2Mq1iCZ6aNCo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732574309; c=relaxed/simple;
	bh=ksfOUwIqVm5c8hWXvkrs2fsi4ZHkDdcxTlS2azdqhnk=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=C2uCLRMUA9aAhEp2P8OZ6ThP5R1k2H+jJxSvcd8kg4gBAd2/Dfhl0YMHe2I2rspjOJOQPvGAO7LVnYI9faGFn/4UD5b5xM1S99sZzrxYsYRJPNJWr6O5wzfhrj8Sm5RzDPu7D4glt88LzI4bGZvF8uLuIWvq0vqOawOmAxGLu/I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F3A0A3858420
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67215E3C034FAF32
X-Originating-IP: [81.152.101.74]
X-OWM-Source-IP: 81.152.101.74
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgdduieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkedurdduhedvrddutddurdejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduhedvrddutddurdejgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehvddquddtuddqjeegrdhrrghnghgvkeduqdduhedvrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttddupdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihg
	fihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (81.152.101.74) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67215E3C034FAF32 for cygwin-patches@cygwin.com; Mon, 25 Nov 2024 22:38:27 +0000
Message-ID: <7e57bfc8-d81b-4017-9b94-5950c0cd96f1@dronecode.org.uk>
Date: Mon, 25 Nov 2024 22:38:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
 <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
 <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
 <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 25/11/2024 19:15, Corinna Vinschen wrote:
> Hi Christian,
> 
> On Nov 25 15:00, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> Fixes: ...?
>>
>> ... the very first commit (cgf 2001) of sched.cc :-)
>>
>> New patch attached.
>>
>>  From e95fc1aceb5287f9ad65c6c078125fecba6c6de9 Mon Sep 17 00:00:00 2001
>> From: Christian Franke <christian.franke@t-online.de>
>> Date: Mon, 25 Nov 2024 14:51:04 +0100
>> Subject: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
>>
>> Behave like sched_setparam() if the requested policy is identical
>> to the fixed value (SCHED_FIFO) returned by sched_getscheduler().
>>
>> Fixes: 6b2a2aa4af1e ("Add missing files.")
> 
> Huh, yeah, this is spot on.  I wonder if it would make sense to change
> that to 9a08b2c02eea ("* sched.cc: New file.  Implement sched*.")
> though, given that was the patch intended to add sched.cc :)))
> 
> Sorry, but I have to ask two more questions:
> 
> - Isn't returning SCHED_FIFO sched_getscheduler() just as wrong?
>    Shouldn't that be SCHED_OTHER, and sched_setscheduler() should check
>    for that instead?  Cygwin in a real-time scenario sounds a bit
>    far-fetched...

I believe if you look into the git history, we used return SCHED_OTHER 
and this was changed at some stage to SCHED_FIFO.

I don't know why.

(I came across this when fixing up some testsuite tests of this)

