Return-Path: <SRS0=GGDi=SR=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.92])
	by sourceware.org (Postfix) with ESMTP id 5548B3858416
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 16:32:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5548B3858416
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5548B3858416
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.92
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732293134; cv=none;
	b=QdXE4ZrY3yVFkVieqmgjJSZl4/wXr5uTjy5yqK48Fjob1AIQuPhkXQlN7d23LXLGhgBxqeWNNHtSvycRFXpKln4HQKKPhTDwcGaK8LekskHZ49PeZUoaxbooK8bfgc4zPFZWC/UJBBtY0oFtt1vCqW5hi4lOgSDu9T9onDw6Jxo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732293134; c=relaxed/simple;
	bh=xavcOPkAVnLmcOlgCs4j6VvTpsXOA5Iv4XDAyLl9HDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=pl6ydwAo+d2qD4tjyWAEO4I3SIo5WrShk3XztbBSdW5xtsRN1FAvG5FtXGuSoKU1v7QZtqrOXSbRJK+vJM/AvcoutBTapFb9jUudAgzx3Iu1uPxQToVBRmdHPntFEFF4z6E2FvC7hAddnh9J5PNJODIijyb76PIG/NUjkzByGBc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5548B3858416
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6722B46402C194DA
X-Originating-IP: [81.152.101.74]
X-OWM-Source-IP: 81.152.101.74
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrfeelgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeegleejjeehtdevffelleevudduteefgfdtvefhleehleegjeeguedvgeffhfeugeenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhenucfkphepkedurdduhedvrddutddurdejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduhedvrddutddurdejgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehvddquddtuddqjeegrdhrrghnghgvkeduqdduhedvrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddupdhnsggprhgtphhtthhopedvpdhrtghpthht
	oheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehmrghrkhesmhgrgihrnhgurdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.152.101.74) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6722B46402C194DA; Fri, 22 Nov 2024 16:32:11 +0000
Message-ID: <2680e1de-4282-4ad8-8efe-4de29a78036e@dronecode.org.uk>
Date: Fri, 22 Nov 2024 16:32:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Minor updates to load average calculations
To: Mark Geisert <mark@maxrnd.com>
References: <20241113060354.2185-1-mark@maxrnd.com>
 <15e5a068-433b-4009-8cd2-e678a1249e9a@dronecode.org.uk>
 <0f3c12f6-0993-4d84-b7a9-b7919ba30a44@maxrnd.com>
 <96386d07-b8fe-4195-ade5-4b229d095156@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <96386d07-b8fe-4195-ade5-4b229d095156@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,BODY_8BITS,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/11/2024 23:49, Mark Geisert wrote:
> On 11/21/2024 2:35 AM, Mark Geisert hallucinated:
>>                                                       I used 
>> SysInternals tool [I don't remember] to explore the namespace.
> 
> Turns out it was actually MSDN sample code under the topic "Browsing 
> Performance Counters" at
> https://learn.microsoft.com/en-us/windows/win32/perfctrs/browsing- 
> performance-counters

Oh, well. That's particularly hilarious because I'm sure I started from 
some MS sample code as well.

It feels like there should be some trace of "we rename this counter 
(sometimes)" somewhere on the internet, if they are in fact measuring 
the same thing...

