Return-Path: <SRS0=tVpX=DE=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta30-sa.btinternet.com [213.120.69.36])
	by sourceware.org (Postfix) with ESMTPS id 39F85385773C
	for <cygwin-patches@cygwin.com>; Tue, 18 Jul 2023 15:52:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 39F85385773C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20230718155227.TMZB9056.sa-prd-fep-047.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Tue, 18 Jul 2023 16:52:27 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64AECEEE00A5EC7F
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhp
	rhguqdhrghhouhhtqddttddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64AECEEE00A5EC7F for cygwin-patches@cygwin.com; Tue, 18 Jul 2023 16:52:27 +0100
Message-ID: <242938af-a4a4-2c21-1f28-43d40f5f231f@dronecode.org.uk>
Date: Tue, 18 Jul 2023 16:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
 <ZLGaf8/nWphfbRI9@calimero.vinschen.de>
 <ZLUgZE5ECv+HaAGI@calimero.vinschen.de>
 <b132e96c-8767-e5b9-1152-c92cd5ad200e@dronecode.org.uk>
 <ZLVOhclITbZyDOhF@calimero.vinschen.de>
 <ZLVhNJE83tlKMTEi@calimero.vinschen.de>
 <a3513077-38c4-0839-1bfd-73f331069454@dronecode.org.uk>
 <ZLaA+toDV1ms4Ene@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZLaA+toDV1ms4Ene@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 18/07/2023 13:09, Corinna Vinschen wrote:
> On Jul 18 12:20, Jon Turney wrote:
>> On 17/07/2023 16:41, Corinna Vinschen wrote:
>>>> Looking into pthread::cancel we have this order of things:
>>>>
>>>>       // cancel deferred
>>>>       mutex.unlock ();
>>>>       canceled = true;
>>>>       SetEvent (cancel_event);
>>>>       return 0;
>>>>
>>>> The canceled var is set before the SetEvent call.
>>>> What if the thread is terminated after canceled is set to true but
>>>> before SetEvent is called?
>>>>
>>>> pthread::testcancel claims:
>>>>
>>>>     We check for the canceled flag first. [...]
>>>>     Only if the thread is marked as canceled, we wait for cancel_event
>>>>     being really set, on the off-chance that pthread_cancel gets
>>>>     interrupted before calling SetEvent.
>>>>
>>>> Neat idea to speed up the code, but doesn't that mean we have a
>>>> potential deadlock, especially given that pthread::testcancel calls WFSO
>>>> with an INFINITE timeout?
>>
>> I'm not sure I follow: another thread sets cancelled = true, just before we
>> hit pthread::testcancel(), so we go into the WFSO, but then the other thread
>> continues, signals cancel_event and everything's fine.
>>
>> What meaning are you assigning to "interrupted" here?
>>
>> Are we worried about the thread calling pthread_cancel being cancelled
>> itself?
> 
> Yes.  My concern is if the thread gets terminated between setting
> canceled and setting the event object.
> 
> Prior to commit 42faed412857, we didn't wait infinitely, just tested the
> event object.  Only with adding the canceled variable, we (better: I)
> added the the infinite timeout.
> 
> I don't see a real reason to do that.  I think this should be changed
> to just checking the event object, see the below patch.

I see now.  Yes, this makes perfect sense.

>>>> And if so, how do we fix this?  Theoretically, the most simple
>>>> solution might be to call SetEvent before setting the canceled
>>>> variable, but in fact we would have to make setting canceld
>>>> and cancel_event an atomic operation.
>>
>> Well, yeah, that is required for them to be coherent. But we have a mutex on
>> the thread object for that purpose, and I don't quite see why it's released
>> so early here.
> 
> The mutex is not guarding canceled or the event object.  Thus it's not
> used in testcancel either, otherwise introducing the canceled var to
> speed up stuff wouldn't have made any sense.
> 
> 
> Corinna
> 
> 
> commit 518e5e46f064de41d3ef6d6ef743e2e760a46282
> Author:     Corinna Vinschen <corinna@vinschen.de>
> AuthorDate: Mon Jul 17 18:02:04 2023 +0200
> Commit:     Corinna Vinschen <corinna@vinschen.de>
> CommitDate: Tue Jul 18 10:11:30 2023 +0200
> 
>      Cygwin: don't wait infinitely on a pthread cancel event
>      
>      Starting with commit 42faed412857 ("* thread.h (class pthread): Add bool
>      member canceled."), pthread::testcancel waits infinitely on cancel_event
>      after it checked if the canceled variable is set.  However, this might
>      introduce a deadlock, if the thread calling pthread_cancel is terminated
>      after setting canceled to true, but before calling SetEvent on cancel_event.
>      
>      In fact, it's not at all necessary to wait infinitely.  By definition,
>      the thread is only canceled if cancel_event is set.  The canceled
>      variable is just a helper to speed up code.  We can safely assume that
>      the thread hasn't been canceled yet, if canceled is set, but cancel_event
>      isn't.
>      
>      Fixes: 42faed412857 ("* thread.h (class pthread): Add bool member canceled.")
>      Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> 
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index f614e01c42f6..21e89e146e0a 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -961,12 +961,9 @@ pthread::testcancel ()
>        pthread_testcancel function a lot without adding the overhead of
>        an OS call.  Only if the thread is marked as canceled, we wait for
>        cancel_event being really set, on the off-chance that pthread_cancel
> -     gets interrupted before calling SetEvent. */
> -  if (canceled)
> -    {
> -      WaitForSingleObject (cancel_event, INFINITE);
> -      cancel_self ();
> -    }
> +     gets interrupted or terminated before calling SetEvent. */
> +  if (canceled && IsEventSignalled (cancel_event))
> +    cancel_self ();
>   }
>   
>   /* Return cancel event handle if it exists *and* cancel is not disabled.
> 


