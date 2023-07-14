Return-Path: <SRS0=XN3w=DA=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-049.btinternet.com (mailomta2-sa.btinternet.com [213.120.69.8])
	by sourceware.org (Postfix) with ESMTPS id 1A9BB3858CDB
	for <cygwin-patches@cygwin.com>; Fri, 14 Jul 2023 13:04:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1A9BB3858CDB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20230714130405.MTYF27949.sa-prd-fep-049.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Fri, 14 Jul 2023 14:04:05 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64067FEB0EEEEFFE
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhp
	rhguqdhrghhouhhtqddttdef
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067FEB0EEEEFFE for cygwin-patches@cygwin.com; Fri, 14 Jul 2023 14:04:05 +0100
Message-ID: <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
Date: Fri, 14 Jul 2023 14:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
 <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/07/2023 19:53, Corinna Vinschen wrote:
> On Jul 13 20:37, Corinna Vinschen wrote:
>> On Jul 13 20:16, Corinna Vinschen wrote:
>>> On Jul 13 12:39, Jon Turney wrote:
>>>> These tests async thread cancellation of a thread that doesn't have any
>>>> cancellation points.
>>>>
>>>> Unfortunately, since 450f557f the async cancellation silently fails when
>>>> the thread is inside the kernel function Sleep(), so it just exits
>>>
>>> I'm not sure how this patch should be the actual culprit.  It only
>>> handles thread priorities, not thread cancellation.  Isn't this rather
>>> 2b165a453ea7b or some such?

Yeah, I messed up there somehow. I will fix the commit id.

>>>> normally after 10 seconds. (See the commentary in pthread::cancel() in
>>>> thread.cc, where it checks if the target thread is inside the kernel,
>>>> and silently converts the cancellation into a deferred one)
>>>
>>> Nevertheless, I think this is ok to do.  The description of pthread_cancel
>>> contains this:
>>>
>>>    Asynchronous cancelability means that the thread can be canceled at
>>>    any time (usually immediately, but the system does not guarantee this).
>>>
>>> And
>>>
>>>    The above steps happen asynchronously with respect to the
>>>    pthread_cancel() call; the return status of pthread_cancel() merely
>>>    informs the caller whether the cancellation request was successfully
>>>    queued.
>>>
>>> So any assumption *when* the cancallation takes place is may be wrong.

Yeah.

I think the flakiness is when we happen to try to async cancel while in 
the Windows kernel, which implicitly converts to a deferred 
cancellation, but there are no cancellation points in the the thread, so 
it arrives at pthread_exit() and returns a exit code other than 
PTHREAD_CANCELED.

I did consider making the test non-flaky by adding a final call to 
pthread_testcancel(), to notice any failed async cancellation which has 
been converted to a deferred one.

But then that is just the same as the deferred cancellation tests, and 
confirms the cancellation happens, but not that it's async, which is 
part of the point of the test.

I guess this could also check that not all of the threads ran for all 10 
seconds, which would indicate that at least some of them were cancelled 
asynchronously.

>> I wonder, though, if we can't come up with a better solution than just
>> waiting for the next cancellation point.
>>
>> No solution comes to mind if the user code calls a Win32 function, but
>> maybe _sigbe could check if the thread's cancel_event is set?  It's all
>> in assembler, that complicates it a bit, but that would make it at least
>> working for POSIX functions which are no cancellation points.

I think you'd need to record the "pending async cancellation" as 
different to "deferred cancellation" so this doesn't turn everything 
into a cancellation point.

> Alternatively, maybe we can utilize the existing signal handler and
> just send a Cygwin-only signal outside the maskable signal range.
> wait_sig calls sigpacket::process like for any other standard signal,
> The signal handler is basically pthread::static_cancel_self().
> Something like that.
I'm not sure this is worth lots of effort, as thread cancellation seems 
to be regarded as mis-specified in such as way as to make it unsafe for 
serious use.

