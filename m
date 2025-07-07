Return-Path: <SRS0=vEO+=ZU=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo009.btinternet.com (btprdrgo009.btinternet.com [65.20.50.104])
	by sourceware.org (Postfix) with ESMTP id 1DFF33857823
	for <cygwin-patches@cygwin.com>; Mon,  7 Jul 2025 20:00:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1DFF33857823
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1DFF33857823
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.104
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751918458; cv=none;
	b=lUda5Ee2GWRFWeDAtw805SDQARmY4dvwZRYxM2I9fIOXBtagOrQc6dj0rBMLZXiOjfhKznmp5NvpLQJu2FG5/mKO12vZOio8oHcOyQ8zpXgSGaoSMPKf8PBH5C27FVBvGrsvnnGv946SuiQD7AClca4riChJ9PWJwDkY8lgZx0c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751918458; c=relaxed/simple;
	bh=3G4D6d7wwWdRrLwjq8kcBgXUZDTcA3XOaKBrtZIcTEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=aMm6oUssdli7pZfCWkjAM/ijd53kbgV3kcT7FKpyAPlmnUF4+pDHLo4Wx7AGy7dCgmD845gQ7UVqpo6dszKx7b/b/lPzD27fIjwtTnQrs/fEjiYuzb2zaksH4qnh/AXC3v0ejyc6iMXO4ydMJIYl0HnTc0uJfQdoaUFZ3MHIjZM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1DFF33857823
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6864BD5E00910E27
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehgeejkedtuddtledvgeejteefgfeuteffgfekgfegjeffjeetgeeujeeivdehudenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgnecukfhppeekiedrudefledrudeijedrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudefledrudeijedrieefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqdeifedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtledpnhgspghrtghpthhtohepvddprhgt
	phhtthhopeevhhhrihhsthhirghnrdfhrhgrnhhkvgesthdqohhnlhhinhgvrdguvgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.139.167.63) by btprdrgo009.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6864BD5E00910E27; Mon, 7 Jul 2025 21:00:56 +0100
Message-ID: <77c8f91a-c51c-4d3f-9faf-e5d9d1430542@dronecode.org.uk>
Date: Mon, 7 Jul 2025 21:00:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: CI: cygstress: update for stress-ng 0.19.02 and
 current Cygwin
To: Christian Franke <Christian.Franke@t-online.de>
References: <b5fae801-1732-99ac-1fe1-6c2552407055@t-online.de>
 <8941f3e9-16ae-7130-0215-3c65dc3f9aaf@jdrake.com>
 <8e61bc54-b80f-cc69-6a54-4640cceff5cc@t-online.de>
 <0f17f3d0-94c9-febe-ac77-0c9e28ba1c2c@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <0f17f3d0-94c9-febe-ac77-0c9e28ba1c2c@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,BODY_8BITS,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 05/07/2025 18:37, Christian Franke wrote:
> Christian Franke wrote:
>> Jeremy Drake via Cygwin-patches wrote:
>>> On Tue, 1 Jul 2025, Christian Franke wrote:
>>> -  fp            # WORKS,CI
>>> +  fp            # FAILS     # TODO Cygwin: "terminated on signal: 
>>> 11" (x86_64 on arm64 only), please see:
>>> +                            # https://sourceware.org/pipermail/ 
>>> cygwin/2025-June/258332.html
>>>
>>> -  memcpy        # WORKS,CI  # (fixed in Cygwin 3.6.1: crash due to 
>>> set DF
>>> in signal handler)
>>> +  memcpy        # FAILS     # TODO Cygwin: "terminated on signal: 
>>> 11" (x86_64 on arm64 only), please see:
>>> +                            # https://sourceware.org/pipermail/ 
>>> cygwin/2025-June/258332.html
>>> +                            # (fixed in Cygwin 3.6.1: crash due to 
>>> set DF in signal handler)
>>>
>>> These should be fixed now, by
>>> b0a9b628aad8dd35892b9da3511c434d9a61d37f (or
>>> cygwin-3.7.0-dev-161-gb0a9b628aad8)
>>>
>>
>> Thanks for the positive feedback. Revised patch attached.
>>
> 
> Pushed with another modification because procfs test works now.

Thanks for updating this.

It seems that the 'filerace' test (new?) doesn't work reliably in the CI 
environment.

Would it be possible for you to take a look?

(As a aside, these CI failures are bridged to the #cygwin-developers 
IRC. If there's somewhere else you'd like to see them reported that's 
more convenient for you, let me know and I'll see what's possible...)

