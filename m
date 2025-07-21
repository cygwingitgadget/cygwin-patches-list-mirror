Return-Path: <SRS0=3L1n=2C=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id 14FF73858D1E
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 13:15:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 14FF73858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 14FF73858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753103733; cv=none;
	b=QS+7h7oQgdXPUIAuHAhlT04qQQA+MF2DiwnEbzZtw4+qHZZF/rNfGTbO8sLnhSeXabRcFGZyLia0PGWXGyzBOoBfG8qtt64JwgEShm5ZF0hob7qwEKjsKBZlnro25p/aJLV0oZYMOpaIXNHoMv0wvvAVBS2Q7klKcs1/DZviiFM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753103733; c=relaxed/simple;
	bh=4GVtkbv7UOqNyTzKm01f4bWJh+T61OmC8Zk5mxHy4ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=EpiOAWtf38rQLGbE3ycCNJDqcIyITIHGAno6Xs1Lv0EUzCABjNPYTovKsvgfo3SmzqTxrWNFlmlOnT3V+zklj4S0S5bJF3y8YJW1HhdKz6a2J5bjpzWfA4eAksmVSKceDkXZ/yMk6tjo4sbBOMDVpJq0bMtGAmrCpwfKv24xo+M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 14FF73858D1E
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6864BBE2022D0615
X-Originating-IP: [86.139.156.85]
X-OWM-Source-IP: 86.139.156.85
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefggefhvddvieejtedtgfelteffteeftdeugfefveehtdehgfffleeftefhvdelffenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudefledrudehiedrkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudefledrudehiedrkeehpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheeiqdekhedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtkedpnhgspghrtghpthhtohepvddprhgtphhtthho
	pegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtoheprhgruggvkhdrsggrrhhtohhnsehmihgtrhhoshhofhhtrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.139.156.85) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6864BBE2022D0615; Mon, 21 Jul 2025 14:15:29 +0100
Message-ID: <bd64e817-ffa8-4299-a3bc-6d1ff691ca9b@dronecode.org.uk>
Date: Mon, 21 Jul 2025 14:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
To: Radek Barton <radek.barton@microsoft.com>
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <aHUFzEEGq448gvZ0@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 14/07/2025 14:27, Corinna Vinschen wrote:
> On Jul 14 15:22, Corinna Vinschen wrote:
>> On Jul 10 19:21, Radek Barton via Cygwin-patches wrote:
>>>  From 8bfc01898261e341bbc8abb437e159b6b33a9312 Mon Sep 17 00:00:00 2001
>>> From: Evgeny Karpov <evgeny.karpov@microsoft.com>
>>> Date: Fri, 4 Jul 2025 20:20:37 +0200
>>> Subject: [PATCH] Cygwin: malloc_wrapper: port to AArch64
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset=UTF-8
>>> Content-Transfer-Encoding: 8bit
>>>
>>> Implements import_address function by decoding adr AArch64 instructions to get
>>> target address.
>>>
>>> Signed-off-by: Evgeny Karpov <evgeny.karpov@microsoft.com>
>>> [...]
>>
>> Pushed.
>>
>>
>> Thanks,
>> Corinna
> 
> Sigh.  Actually I shouldn't have done that.  While Evgeny is the patch
> author, the *attached* patch has you, Radek, in the Signed-off-by, and
> that's what I now pushed.
> 
> Please make sure that Signed-off-by sticks to the author in the attached
> patch as well, not to the person sending the patches to the list, please.

If Radek is going to be adding Signed-off: lines of behalf of his 
colleagues, maybe this is an appropriate place to ask what he thinks 
he's attesting to with it?


Corinna,

Maybe the "Before you get started" section in [1] should mention 
Signed-off: and what we think it means?

If we really want it to be mandatory, I guess I could explore the 
possibility of a push hook to enforce that?

[1] https://cygwin.com/contrib/dll.html
