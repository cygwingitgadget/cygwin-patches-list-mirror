Return-Path: <SRS0=BCcK=JD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-042.btinternet.com (mailomta12-re.btinternet.com [213.120.69.105])
	by sourceware.org (Postfix) with ESMTPS id 5155F3858C2C
	for <cygwin-patches@cygwin.com>; Thu, 25 Jan 2024 20:03:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5155F3858C2C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5155F3858C2C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.105
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706213002; cv=none;
	b=ZANgRSea5bVc7QWgse5RUDT8LLdplE0+jNsYmknxWKh+xYKlCMm/uf8kAPM5FS1lhWtNAAGcrUFbi2hi81pBwVdqRAQa1qZ9PdtYR6IxWk92PoRW8HN3fg2urPkeqwWHap/aynSaNVSNnuwV2AV9NqWRG49AxcEiYax5zJpcNbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706213002; c=relaxed/simple;
	bh=QmrV7fkxqD6P0MwdGLRtGNYeGQySDFuY+Wf1zO8ZKdw=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=U5uNiP3EHCslW8bzROkKCLFKufkyePprDSQDCFvgVXjA0KjDxSy9vhqMbmXgMRLWWOBxFjs2E3Tstb23mBtKNg5JytkHlMNl7Jv4M/yN+tjXi/YpB6GKG5YSN6EdDz2ZRJSpmy5Eo2IJZvhNWTgusspLkFFDeGc2UG6y5kwL9eA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20240125200319.MJGK4314.re-prd-fep-042.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Thu, 25 Jan 2024 20:03:19 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B5E305504749
X-Originating-IP: [86.140.193.68]
X-OWM-Source-IP: 86.140.193.68
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelhedggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddugedtrdduleefrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdeikedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqdeikedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhstheprhgvqdhp
	rhguqdhrghhouhhtqddttddv
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.140.193.68) by re-prd-rgout-002.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B5E305504749 for cygwin-patches@cygwin.com; Thu, 25 Jan 2024 20:03:19 +0000
Message-ID: <0613f2c3-4e1f-452a-8055-59d34d16c821@dronecode.org.uk>
Date: Thu, 25 Jan 2024 20:03:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
Content-Language: en-GB
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
 <Za_NQNPhRNU7fRv0@calimero.vinschen.de>
 <c4cde4ee-f908-4944-8a77-8b86f3e51e8f@dronecode.org.uk>
 <ZbEhEP-MI7oX_2px@calimero.vinschen.de>
 <b140b902-8c5d-47f8-910e-f30d835bf185@dronecode.org.uk>
 <ZbKmwy7wKjAJvF1u@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <ZbKmwy7wKjAJvF1u@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 25/01/2024 18:21, Corinna Vinschen wrote:
> On Jan 25 14:50, Jon Turney wrote:
>> On 24/01/2024 14:39, Corinna Vinschen wrote:
>>> On Jan 24 13:28, Jon Turney wrote:
>>>> On 23/01/2024 14:29, Corinna Vinschen wrote:
>>>>> On Jan 23 14:20, Jon Turney wrote:
[...]
>> So this situation with a JIT debugger is even stranger than my emendations
>> to the documentation say.
>>
>> Because we're hitting try_to_debug() in exception::handle(), which has some
>> code to replay the exception via ExceptionContinueExecution (which I guess
>> the debugger will catch as a first-chance) (and goes into a mode where it
>> ignores the next half-million exceptions... no idea what that's about!)
>>
>> That's not the same as signal_exit() with a coredumping signal (haven't
>> checked if those are all generated from exceptions, but seems probable, so
>> the try_to_debug() there maybe isn't doing anything?), where we're going to
>> exit thereafter.
> 
> try_to_debug() is only calling IsDebuggerPresent() as test, and that's
> nothing but a flag in the PEB which is set by the OS after a debugger
> attached to the process.  So the test is by definition extremely
> flaky, if the debugger is connecting and disconnecting, as you
> already pointed out.
> 
> I'm wondering if we can't define our own way to attach to a process,
> allowing to "WaitForDebugger" as long as the debugger is a Cygwin
> debugger.  If we define a matching function (along the lines of
> prctl(2) on Linux), we could change our debuggers, core dumpers
> and stracers to call this attach function.
> 
> The idea would be to define some shared mutex object, the inferior
> waits for and the debugger releases after having attached.
> 
> Is there really any need to support non-Cygwin debuggers?

idk

I think something like that used to exist a long time ago, see commit 
8abeff1ead5f3824c70111bc0ff74ff835dafa55

That long predates my involvement with cygwin so I've no idea why that 
was removed.

>> The practical upshot of this is if the JIT debugger doesn't terminate or fix
>> the erroring process, we'll just replay the faulting instruction and invoke
>> the JIT debugger again.
> 
> Hmm, ok.  This signal stuff *is* complicated and I'd be happy
> if anybody finds out how to fix that...

To be clear, not a problem with "core dumping signals", as the process 
now always end up exiting, one way or another.

It's only a problem when someone has set "CYGWIN=error_start:true" or 
something equally dumb.

