Return-Path: <SRS0=n7Ra=JF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-042.btinternet.com (mailomta21-re.btinternet.com [213.120.69.114])
	by sourceware.org (Postfix) with ESMTPS id E77B33858C2D
	for <cygwin-patches@cygwin.com>; Sat, 27 Jan 2024 15:12:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E77B33858C2D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E77B33858C2D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.114
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706368380; cv=none;
	b=YreVUtB8FamTd7ker3FHer3a/qUwmeq7mgGXfx4F6jCYtM2E5FdHXQcyHXP+g5n1PuUmCLpOORZxXv+ezhJZKkabf2qZGNZlAUK6GgNO2KtnKBTXGYbh3EGgeWak94GipfXf7Wqf94eMvivT1WsNSitcbp//qFUOp7aUVwIHxwI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706368380; c=relaxed/simple;
	bh=WcNqBDbBtt38xzvB2ht/rpQkiSW1xrdZqW7Hg4wNegA=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=aGUGjE9yZiKwMMHtfTpxrio/NmSEa2q2mCbnMDR5gCgZmPglqs+VWd4UdqhAFDYFaX4SJsxnL4T1CAZzStM7y+9wqlmXkuCHCyplUBbcZpMV5CCxrweAq5fMNBf/Scm8qUG5u6aJPo9s/M955OvukQUcmeZCLZEN2TZ8kisxD9g=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20240127151258.TOQO4314.re-prd-fep-042.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Sat, 27 Jan 2024 15:12:58 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B4650586C91F
X-Originating-IP: [86.140.193.68]
X-OWM-Source-IP: 86.140.193.68
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddugedtrdduleefrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdeikedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqdeikedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhstheprhgvqdhp
	rhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.140.193.68) by re-prd-rgout-001.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B4650586C91F for cygwin-patches@cygwin.com; Sat, 27 Jan 2024 15:12:57 +0000
Message-ID: <d5fc9479-0882-417e-a047-752997eae0ad@dronecode.org.uk>
Date: Sat, 27 Jan 2024 15:12:57 +0000
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
 <0613f2c3-4e1f-452a-8055-59d34d16c821@dronecode.org.uk>
 <ZbOTpaBfEZwAkxcf@calimero.vinschen.de>
 <ZbOc7C_3qSfjlT6x@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <ZbOc7C_3qSfjlT6x@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 26/01/2024 11:52, Corinna Vinschen wrote:
> On Jan 26 12:12, Corinna Vinschen wrote:
>> On Jan 25 20:03, Jon Turney wrote:
>>> On 25/01/2024 18:21, Corinna Vinschen wrote:
>>>> On Jan 25 14:50, Jon Turney wrote:
>>>>> On 24/01/2024 14:39, Corinna Vinschen wrote:
>>>>>> On Jan 24 13:28, Jon Turney wrote:
>>>>>>> On 23/01/2024 14:29, Corinna Vinschen wrote:
>>>>>>>> On Jan 23 14:20, Jon Turney wrote:
>>> [...]
>>>>> So this situation with a JIT debugger is even stranger than my emendations
>>>>> to the documentation say.
>>>>>
>>>>> Because we're hitting try_to_debug() in exception::handle(), which has some
>>>>> code to replay the exception via ExceptionContinueExecution (which I guess
>>>>> the debugger will catch as a first-chance) (and goes into a mode where it
>>>>> ignores the next half-million exceptions... no idea what that's about!)
>>>>>
>>>>> That's not the same as signal_exit() with a coredumping signal (haven't
>>>>> checked if those are all generated from exceptions, but seems probable, so
>>>>> the try_to_debug() there maybe isn't doing anything?), where we're going to
>>>>> exit thereafter.
>>>>
>>>> try_to_debug() is only calling IsDebuggerPresent() as test, and that's
>>>> nothing but a flag in the PEB which is set by the OS after a debugger
>>>> attached to the process.  So the test is by definition extremely
>>>> flaky, if the debugger is connecting and disconnecting, as you
>>>> already pointed out.
>>>>
>>>> I'm wondering if we can't define our own way to attach to a process,
>>>> allowing to "WaitForDebugger" as long as the debugger is a Cygwin
>>>> debugger.  If we define a matching function (along the lines of
>>>> prctl(2) on Linux), we could change our debuggers, core dumpers
>>>> and stracers to call this attach function.
>>>>
>>>> The idea would be to define some shared mutex object, the inferior
>>>> waits for and the debugger releases after having attached.
>>>>
>>>> Is there really any need to support non-Cygwin debuggers?
>>>
>>> idk
>>>
>>> I think something like that used to exist a long time ago, see commit
>>> 8abeff1ead5f3824c70111bc0ff74ff835dafa55
>>
>> Yeah, just, as was the default at the time, without any trace of a
>> *rational* why it has been removed.  Also, it was too simple anyway.
>>
>> First, if we want to support WIndows debugger, the inferior has to check
>> if the debugger is a Cygwin or native debugger.  If a native debugger,
>> just stick to what we have today.  Otherwise:
>>
>> - Create a named mutex with a reproducible name (no need to use
>>    the name as parameter) and immediately grab it.
>> - Call CreateProcess to start the debugger with CREATE_SUSPENDED
>>    flag.
>> - Create a HANDLE array with the mutex and the process HANDLE.
> 
>      On second thought, it might be a good idea to make this
>      interruptible as well, but given this is called from the
>      exception handler this may have weird results...
>   
>> - Call ResumeThread on the primary debugger thread.
>> - Call WFMO with timeout.
>>
>> Later on, the debugger either fails and exits or it calls
>> ReleaseMutex after having attached to the process.
>>
>> - WFMO returns
>> - If the mutex has triggered, we're being debugged (but check
>>    IsDebuggerPresent() just to be sure)
>> - If the process has triggered, the debugger exited
>> - If the timeout triggers... oh well.

This seems like quite a lot of work, for very marginal benefit.

And doing lots of complex work inside the process when we're in the 
middle of handling a SEGV seems like asking for trouble.

I think I'll leave this alone for the moment, and we can see what (if 
any) problems surface.

