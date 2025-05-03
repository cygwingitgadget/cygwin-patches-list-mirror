Return-Path: <SRS0=mYwE=XT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.133])
	by sourceware.org (Postfix) with ESMTP id D16303858D21
	for <cygwin-patches@cygwin.com>; Sat,  3 May 2025 15:52:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D16303858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D16303858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.133
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746287550; cv=none;
	b=OZx5nolFJijriAsJ9JLHjXQn95K+Xz4DYog9BW+dwXipjopxahvGbKNjWEjm0rnrJcISTxrzP7ZDdBIkm24aijQWPzLkURd+q6LL3fAzEy26RNaTDYy5SsWvzWQoETGbiRd36kAU14P7S1HFUB0E+06KtxiILv+XwQ6iMkDMBKU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746287550; c=relaxed/simple;
	bh=9KDHReLtvlDr09ffs6g80Ob9egWewS+N6oFBNr5W/Os=;
	h=Message-ID:Date:MIME-Version:Subject:From:To; b=LLsvbgjEAiB7BCM4V7/ynNGxuwk/9PvpsrM6atGiavhRI1sv9bq6CefPf64ItHVp5MnIJj+FveBMFKbgyX3G/jaQNTuNDesQCYE3RlEp25aaNHTy2hfdxBA0gLFrKxP4ZwnYe7LYGNHb8VfpJiQ6YxFLqIsL+gyWmOWEtouq8B8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D16303858D21
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E0805662921
X-Originating-IP: [86.140.194.111]
X-OWM-Source-IP: 86.140.194.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeehjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffhvfhfvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeduiefgiefgueejhfetgeektdevveeigffhfeeukeefudfftdfgvddvfeduhfefteenucfkphepkeeirddugedtrdduleegrdduuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelgedrudduuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelgedqudduuddrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddutddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohep
	tgihghifihhnsehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.194.111) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E0805662921; Sat, 3 May 2025 16:52:26 +0100
Message-ID: <72c79648-ff1d-491c-9ca0-708de422eafd@dronecode.org.uk>
Date: Sat, 3 May 2025 16:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: CI: Add running on arm64 to stress test matrix
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Jeremy Drake <cygwin@jdrake.com>
References: <20250427210504.1962-1-jon.turney@dronecode.org.uk>
 <2fd01fbc-e56a-e01d-a93e-6872bbe4a9ea@jdrake.com>
 <132c2355-a302-45df-8b12-a6da8bb99b10@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <132c2355-a302-45df-8b12-a6da8bb99b10@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 03/05/2025 12:20, Jon Turney wrote:
> On 27/04/2025 22:20, Jeremy Drake via Cygwin-patches wrote:
>> On Sun, 27 Apr 2025, Jon Turney wrote:
>>
>>> Use an output variable from cygwin-install-action to inform where we
>>> unpack the just-built cygwin artifact, because apparently the Windows
>>> ARM64 runners have a different configuration (no D: drive).

I applied this, but there seems to be some flakiness in the stress-ng 
tests when run on arm64, so I then tweaked it to ignore failures on 
arm64, for the moment.

(not idea, but is probably what I should have done in the first place 
until I had a bit more of a baseline for how this test behaves).

I have seen the 'kill' and 'alarm' stress-ng tests sometimes fail on 
arm64.  I'm sure this is a bug in Cygwin somewhere, but investigating it 
isn't easy without the hardware...

