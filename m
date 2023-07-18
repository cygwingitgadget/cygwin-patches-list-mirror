Return-Path: <SRS0=tVpX=DE=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-044.btinternet.com (mailomta21-sa.btinternet.com [213.120.69.27])
	by sourceware.org (Postfix) with ESMTPS id BA73638582B0;
	Tue, 18 Jul 2023 11:20:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BA73638582B0
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20230718112020.OOWV11931.sa-prd-fep-044.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 18 Jul 2023 12:20:20 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64067FEB0F5BF811
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepkefgfeettdehieejteelveevgffhuedthfejkeelteevffehleeutdefgeduveetnecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegtohhrihhnnhgrqdgthihgfihinhestgihghifihhnrdgtohhmpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqddujeelrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgr
	uhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtfe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067FEB0F5BF811; Tue, 18 Jul 2023 12:20:20 +0100
Message-ID: <a3513077-38c4-0839-1bfd-73f331069454@dronecode.org.uk>
Date: Tue, 18 Jul 2023 12:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Content-Language: en-GB
To: Corinna Vinschen <corinna-cygwin@cygwin.com>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
 <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
 <ZLGaf8/nWphfbRI9@calimero.vinschen.de>
 <ZLUgZE5ECv+HaAGI@calimero.vinschen.de>
 <b132e96c-8767-e5b9-1152-c92cd5ad200e@dronecode.org.uk>
 <ZLVOhclITbZyDOhF@calimero.vinschen.de>
 <ZLVhNJE83tlKMTEi@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZLVhNJE83tlKMTEi@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 17/07/2023 16:41, Corinna Vinschen wrote:
> On Jul 17 16:21, Corinna Vinschen wrote:
>> On Jul 17 12:51, Jon Turney wrote:
>>> On 17/07/2023 12:05, Corinna Vinschen wrote:
>>>> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
>>>> index f614e01c42f6..fceb9bda1806 100644
>>>> --- a/winsup/cygwin/thread.cc
>>>> +++ b/winsup/cygwin/thread.cc
>>>> @@ -546,6 +546,13 @@ pthread::exit (void *value_ptr)
>>>>      class pthread *thread = this;
>>>>      _cygtls *tls = cygtls;	/* Save cygtls before deleting this. */
>>>> +  /* Deferred cancellation still pending? */
>>>> +  if (canceled)
>>>> +    {
>>>> +      WaitForSingleObject (cancel_event, INFINITE);
>>>> +      value_ptr = PTHREAD_CANCELED;
>>>> +    }
>>>> +
>>>>      // run cleanup handlers
>>>>      pop_all_cleanup_handlers ();
>>>> What do you think?
>>>
>>> I mean, by your own interpretation of the standard, this isn't required,
>>> because we're allowed to take arbitrarily long to deliver the async
>>> cancellation, and in this case, we took so long that the thread exited
>>> before it happened, too bad...
>>
>> True enough!
>>
>>> It doesn't seem a bad addition,
>>
> Actually, it seems we actually *have* to do this.  I just searched
> for more info on that problem and, to my surprise, I found this in the
> most obvious piece of documentation:
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_exit.html
> 
> Quote:
> 
>    As the meaning of the status is determined by the application (except
>    when the thread has been canceled, in which case it is
>    PTHREAD_CANCELED), [...]
> 
>> On second thought...
>>
>> One thing bugging me is this:
> 
> This is still a bit fuzzy, though.  I'd appreciate any input.
> 
>> Looking into pthread::cancel we have this order of things:
>>
>>      // cancel deferred
>>      mutex.unlock ();
>>      canceled = true;
>>      SetEvent (cancel_event);
>>      return 0;
>>
>> The canceled var is set before the SetEvent call.
>> What if the thread is terminated after canceled is set to true but
>> before SetEvent is called?
>>
>> pthread::testcancel claims:
>>
>>    We check for the canceled flag first. [...]
>>    Only if the thread is marked as canceled, we wait for cancel_event
>>    being really set, on the off-chance that pthread_cancel gets
>>    interrupted before calling SetEvent.
>>
>> Neat idea to speed up the code, but doesn't that mean we have a
>> potential deadlock, especially given that pthread::testcancel calls WFSO
>> with an INFINITE timeout?

I'm not sure I follow: another thread sets cancelled = true, just before 
we hit pthread::testcancel(), so we go into the WFSO, but then the other 
thread continues, signals cancel_event and everything's fine.

What meaning are you assigning to "interrupted" here?

Are we worried about the thread calling pthread_cancel being cancelled 
itself?

>> And if so, how do we fix this?  Theoretically, the most simple
>> solution might be to call SetEvent before setting the canceled
>> variable, but in fact we would have to make setting canceld
>> and cancel_event an atomic operation.

Well, yeah, that is required for them to be coherent. But we have a 
mutex on the thread object for that purpose, and I don't quite see why 
it's released so early here.

