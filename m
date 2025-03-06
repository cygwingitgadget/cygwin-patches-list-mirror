Return-Path: <SRS0=rrHt=VZ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo009.btinternet.com (btprdrgo009.btinternet.com [65.20.50.104])
	by sourceware.org (Postfix) with ESMTP id 4E5723858D28
	for <cygwin-patches@cygwin.com>; Thu,  6 Mar 2025 14:55:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4E5723858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4E5723858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.104
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741272909; cv=none;
	b=iHxwE5OBCpB1ZgxKddh6ILFWEeomKGho1pAEnigKvnlGH3rrSjdoGZLmzqG1B9SkkGmaL/7PwwH8IKVXd/1l6EcSbtAbBHKYXKfWpl+j1RStQdS3nAG/lKWXJLQmPr/5z9UJrQLqKRVAv1WNsps6OXY8PJosNdxCjOjxIQcUcQA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741272909; c=relaxed/simple;
	bh=gxjk+niUenApyTMOKmAdrwDA1s3dKSaurwyal7NQWew=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=lrRwPpSSqiA/rtkwNvM/xpJP0eK8LFNdlW0S+SdjVYVMHy9NSVah6ddcLKG1PoApvjtK/8FlTkc8zRTdJXXlD+6Edr4Xhvi/To2uPkLh2inbdQ50w/CKHD08lJuzgFIUJsjojZELmrIEDrQUIqMw/lqgCoCYQvR0Mtih65Nk0uQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4E5723858D28
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674902010B3CF2E5
X-Originating-IP: [86.133.181.121]
X-OWM-Source-IP: 86.133.181.121
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddufeefrddukedurdduvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeffedrudekuddruddvuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeffedqudekuddquddvuddrrhgrnhhgvgekiedqudeffedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtledpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgv
	shestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.133.181.121) by btprdrgo009.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674902010B3CF2E5 for cygwin-patches@cygwin.com; Thu, 6 Mar 2025 14:55:08 +0000
Message-ID: <74c86bc5-ba6c-4ea2-b39f-d41ef538c5f9@dronecode.org.uk>
Date: Thu, 6 Mar 2025 14:55:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] Cygwin: signal: Fix a race issue on modifying
 _pinfo::process_state
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
 <20250228233406.950-3-takashi.yano@nifty.ne.jp>
 <Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
 <20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp>
 <Z8WoFOXWxwC8AJNx@calimero.vinschen.de>
 <20250303233919.4f463d642c88623f9c520f74@nifty.ne.jp>
 <Z8X6uJJwhVA7i7lk@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Z8X6uJJwhVA7i7lk@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 03/03/2025 18:53, Corinna Vinschen wrote:
> On Mar  3 23:39, Takashi Yano wrote:
>> On Mon, 3 Mar 2025 14:01:08 +0100
>> Corinna Vinschen wrote:
>>> but now that I'm writing it I'm even more unsure this is necessary.
>>> The only two places doing an And and an Or are doing it with the
>>> exact same flags.  And the combination of PID_ACTIVE and the other
>>> three flags is never tested together.
>>>
>>> What do you think?
>>
>> No other code touches these flags except for:
>>
>> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
>> index 1ffe00a94..8739f18f5 100644
>> --- a/winsup/cygwin/sigproc.cc
>> +++ b/winsup/cygwin/sigproc.cc
>> @@ -252,7 +252,7 @@ proc_subproc (DWORD what, uintptr_t val)
>>   	  vchild->sid = myself->sid;
>>   	  vchild->ctty = myself->ctty;
>>   	  vchild->cygstarted = true;
>> -	  vchild->process_state |= PID_INITIALIZING;
>> +	  InterlockedOr ((LONG *)&vchild->process_state, PID_INITIALIZING);
>>   	  vchild->ppid = myself->pid;	/* always set last */
>>   	}
>>         break;
>>
>> Moreover, using InterlockedOr()/InterlockedAnd() can ensure that
>> the other flags than the current code is modifying will be kept
>> during modification. So using InterlockedCompareExchange() might
>> be over the top.
> 
> Okidoki!
> 
>>> Either way, I would add a volatile to _pinfo::process_state.
>>
>> Thanks. I will.
> 
> Great.  Feel free to push the patch without sending another patch
> submission to cygwin-patches.

I think Takashi-san must be about due another gold star, as he's been 
doing some sterling work recently, fixing complex and difficult to 
reproduce bugs!

