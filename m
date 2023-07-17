Return-Path: <SRS0=PxbH=DD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-046.btinternet.com (mailomta27-sa.btinternet.com [213.120.69.33])
	by sourceware.org (Postfix) with ESMTPS id 7657C3858D37
	for <cygwin-patches@cygwin.com>; Mon, 17 Jul 2023 11:51:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7657C3858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20230717115156.NGHK17034.sa-prd-fep-046.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Mon, 17 Jul 2023 12:51:56 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64067D310F3984DD
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrgedvgdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhp
	rhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310F3984DD for cygwin-patches@cygwin.com; Mon, 17 Jul 2023 12:51:56 +0100
Message-ID: <b132e96c-8767-e5b9-1152-c92cd5ad200e@dronecode.org.uk>
Date: Mon, 17 Jul 2023 12:51:54 +0100
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
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
 <ZLGaf8/nWphfbRI9@calimero.vinschen.de>
 <ZLUgZE5ECv+HaAGI@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZLUgZE5ECv+HaAGI@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 17/07/2023 12:05, Corinna Vinschen wrote:
> On Jul 14 20:57, Corinna Vinschen wrote:
>> On Jul 14 14:04, Jon Turney wrote:
>>> On 13/07/2023 19:53, Corinna Vinschen wrote:
>>>>>> Nevertheless, I think this is ok to do.  The description of pthread_cancel
>>>>>> contains this:
>>>>>>
>>>>>>     Asynchronous cancelability means that the thread can be canceled at
>>>>>>     any time (usually immediately, but the system does not guarantee this).
>>>>>>
>>>>>> And
>>>>>>
>>>>>>     The above steps happen asynchronously with respect to the
>>>>>>     pthread_cancel() call; the return status of pthread_cancel() merely
>>>>>>     informs the caller whether the cancellation request was successfully
>>>>>>     queued.
>>>>>>
>>>>>> So any assumption *when* the cancallation takes place is may be wrong.
>>>
>>> Yeah.
>>>
>>> I think the flakiness is when we happen to try to async cancel while in the
>>> Windows kernel, which implicitly converts to a deferred cancellation, but
>>> there are no cancellation points in the the thread, so it arrives at
>>> pthread_exit() and returns a exit code other than PTHREAD_CANCELED.
>>
>> In pthread_join(), right?
>>
>>> I did consider making the test non-flaky by adding a final call to
>>> pthread_testcancel(), to notice any failed async cancellation which has been
>>> converted to a deferred one.
>>>
>>> But then that is just the same as the deferred cancellation tests, and
>>> confirms the cancellation happens, but not that it's async, which is part of
>>> the point of the test.
>>
>> What if Cygwin checks for a deferred cancellation in pthread::exit,
>> too?  It needs to do this by its own, not calling pthread::testcancel,
>> otherwise we're in an infinite loop.  Since cancel is basically like
>> exit, just with a PTHREAD_CANCELED return value, the only additional
>> action would be to set retval to PTHREAD_CANCELED explicitely.
> 
> Kind of like this:
> 
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index f614e01c42f6..fceb9bda1806 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -546,6 +546,13 @@ pthread::exit (void *value_ptr)
>     class pthread *thread = this;
>     _cygtls *tls = cygtls;	/* Save cygtls before deleting this. */
>   
> +  /* Deferred cancellation still pending? */
> +  if (canceled)
> +    {
> +      WaitForSingleObject (cancel_event, INFINITE);
> +      value_ptr = PTHREAD_CANCELED;
> +    }
> +
>     // run cleanup handlers
>     pop_all_cleanup_handlers ();
>   
> What do you think?

I mean, by your own interpretation of the standard, this isn't required, 
because we're allowed to take arbitrarily long to deliver the async 
cancellation, and in this case, we took so long that the thread exited 
before it happened, too bad...

It doesn't seem a bad addition, but this turns pthread_exit() into a 
deferred cancellation point as well, so it should be added to the list 
of "an implementation may also mark other functions not specified in the 
standard as cancellation points" in our documentation^W the huge comment 
in threads.cc.

