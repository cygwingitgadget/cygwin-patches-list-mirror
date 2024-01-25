Return-Path: <SRS0=BCcK=JD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-049.btinternet.com (mailomta13-sa.btinternet.com [213.120.69.19])
	by sourceware.org (Postfix) with ESMTPS id DCDAF3858D28
	for <cygwin-patches@cygwin.com>; Thu, 25 Jan 2024 14:50:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DCDAF3858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DCDAF3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706194211; cv=none;
	b=J6ASfvaczEl2pJ8qVQSndmBQexUVnvJwteEapu6bogx24A0a0yzzBWaQNAdw8lrWGeKgykmC6ngvTnk9/qFEBsMDRqZQjR7vy6+92ZZk/RiFEI9EZuQlrRuHUXVRlKtWYaPnK+XehjDw8hOkuUf4U/COLp+pq3mry61NNJVO8PU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706194211; c=relaxed/simple;
	bh=6vVMHYHWk/AMLdWE/TBaElPgrVXaDoOam7xc+7kNCXI=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=iEjKxCfsHGFYYm1aKMlek2zfaNHfy+OGpLKP0UzqId+7IHuXusp+tAko/zhmV6RVncp9Tdaro6kLPNkx+ZVc2O2FzH+tAS+ckUGS6D4dGO0Fcf1scFbIQzw+ATEwS22EzsBbO9oOsANWX01DUho/XLZk8XpucJDBAn9RZpQYsMg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20240125145008.WXIP27949.sa-prd-fep-049.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Thu, 25 Jan 2024 14:50:08 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 65A5682A011E3AD9
X-Originating-IP: [86.140.193.68]
X-OWM-Source-IP: 86.140.193.68
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgedggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddugedtrdduleefrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdeikedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqdeikedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhp
	rhguqdhrghhouhhtqddttdef
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.140.193.68) by sa-prd-rgout-003.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 65A5682A011E3AD9 for cygwin-patches@cygwin.com; Thu, 25 Jan 2024 14:50:08 +0000
Message-ID: <b140b902-8c5d-47f8-910e-f30d835bf185@dronecode.org.uk>
Date: Thu, 25 Jan 2024 14:50:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
 <Za_NQNPhRNU7fRv0@calimero.vinschen.de>
 <c4cde4ee-f908-4944-8a77-8b86f3e51e8f@dronecode.org.uk>
 <ZbEhEP-MI7oX_2px@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <ZbEhEP-MI7oX_2px@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 24/01/2024 14:39, Corinna Vinschen wrote:
> On Jan 24 13:28, Jon Turney wrote:
>> On 23/01/2024 14:29, Corinna Vinschen wrote:
>>> On Jan 23 14:20, Jon Turney wrote:
>>>
>>>> Even then this is clearly not totally bullet-proof. Maybe the right thing to
>>>> do is add a suitable timeout here, so even if we fail to notice the
>>>> DebugActiveProcess() (or there's a custom JIT debugger which just writes the
>>>> fact a process crashed to a logfile or something), we'll exit eventually?
>>>
>>> Timeouts are just that tiny little bit more bullet-proof, they still
>>> aren't totally bullet-proof.
>>>
>>> What timeout were you thinking of?  milliseconds?
>>
>> Oh no, tens of seconds or something, just as a fail-safe.
> 
> Uh, sounds a lot.  10 secs?  Not longer, I think.
> 
> If you want to do that for 3.5, please do it this week.  You can
> push the change without waiting for approval.

Thanks.

I pushed a small change adding this timeout.

>> (Ofc, all this is working around the fact that Win32 API doesn't have a
>> WaitForDebuggerPresent(timeout) function)
> 
> Yeah, and there's no alternative way using the native API afaics :(

So this situation with a JIT debugger is even stranger than my 
emendations to the documentation say.

Because we're hitting try_to_debug() in exception::handle(), which has 
some code to replay the exception via ExceptionContinueExecution (which 
I guess the debugger will catch as a first-chance) (and goes into a mode 
where it ignores the next half-million exceptions... no idea what that's 
about!)

That's not the same as signal_exit() with a coredumping signal (haven't 
checked if those are all generated from exceptions, but seemly probable, 
so the try_to_debug() there maybe isn't doing anything?), where we're 
going to exit thereafter.

The practical upshot of this is if the JIT debugger doesn't terminate or 
fix the erroring process, we'll just replay the faulting instruction and 
invoke the JIT debugger again.

