Return-Path: <SRS0=A2sC=R6=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
	by sourceware.org (Postfix) with ESMTPS id A6BD73858C56
	for <cygwin-patches@cygwin.com>; Sun,  3 Nov 2024 11:15:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A6BD73858C56
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A6BD73858C56
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.84
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730632507; cv=none;
	b=ngWQaQBFhCcQ7il7/0Tvd6kkaH+s5C/OboqViLcKmiNf+BpiuIRWlOHBUdUJs/2T5TC1xaYkRPCNFCpB2APqO/+tlrfredyxDjS6wrVhVkobvCSfn8tVUM+sZvv1uj81/ughESnDx8Ye3PtwjrHhZ5M2eK66dXc7JOjAbK6MvPg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730632507; c=relaxed/simple;
	bh=PCOkZqdrSDUyzpGWaWGF+upGJjQjhRtSr3nF5QQSqcI=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=MNkhuNEuqx3CyyBipq7Em0xEcP7IHOwmbahrm6hXhCAJee4PBpSPXMAoCSbUJjI0hdkQva1doCtE6wMYFHXHfqgtsQBKw2B93LilPP4ja3VdYvhK8XrABjDKCkZVXpa3qh/EfyQScHUJDC9iE4mMZG8Mzny/qxw/9grGaR1+vnI=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd72.aul.t-online.de (fwd72.aul.t-online.de [10.223.144.98])
	by mailout09.t-online.de (Postfix) with SMTP id 0F412857
	for <cygwin-patches@cygwin.com>; Sun,  3 Nov 2024 12:15:03 +0100 (CET)
Received: from [192.168.2.101] ([79.230.171.165]) by fwd72.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1t7YZS-2ntEVk0; Sun, 3 Nov 2024 12:15:02 +0100
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
 <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
Date: Sun, 3 Nov 2024 12:15:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.18.2
MIME-Version: 1.0
In-Reply-To: <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1730632502-39FF95EF-29DA2AB5/0/0 CLEAN NORMAL
X-TOI-MSGID: b2f1f12d-e121-4c99-919a-366c7096f125
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mark Geisert wrote:
> Hi Corinna,
>
> On 10/22/2024 7:45 AM, Corinna Vinschen wrote:
>> Hi Mark,
>>
>> Thanks for looking into this.
>>
>> On Sep 19 02:13, Mark Geisert wrote:
>>> Change the first parameter of pthread_sigqueue() to be a thread id 
>>> rather
>>> than a thread pointer. The change is to match the Linux 
>>> implementation of
>>> this function.
>>>
>>> The user-visible function prototype is changed. Simple list 
>>> iteration is
>>> added to the threadlist code. A lookup-by-id function is added to class
>>> pthread. The pthread_sigqueue() function is modified to work with a
>>> passed-in thread id rather than an indirect thread pointer as before.
>>> (It was "pthread_t *thread", i.e., class pthread **.) The release note
>>> for Cygwin 3.6.0 is updated.
>>
>> Even if the old prototype was wrong, we probably have to keep it for
>> backward compatibility.  As unlikely as it seems, but there may be
>> binaries out there actually using the old prototype.
>>
>> We can discuss this probability, but assuming we want to keep backward
>> compat at all cost, we would have to
>
> No need to discuss. I'm happy keeping backward compatibility.
>
>> - create a new function like pthread_sigqueue_with_correct_prototype 
>> (heh)
>>
>> - Add this function to cygwin.din as exported symbol
>>
>> - Add a matching entry to NEW_FUNCTIONS in Makefile.am, e.g.,
>>
>>      pthread_sigqueue=pthread_sigqueue_with_correct_prototype,
>>
>> - Implement either pthread_sigqueue_with_correct_prototype calling
>>    pthread_sigqueue or vice versa, whatever makese more sense.
>
> I appreciate your redirecting me towards an acceptable solution. I've 
> re-implemented the fix as you've indicated but there's one thing I 
> cannot figure out. (BTW I implemented a new 
> pthread_sigqueue_portable() calling existing pthread_sigqueue().)
>
> In cygwin/include/pthread.h, should both function names appear or just 
> pthread_sigqueue? If the latter, which version of prototype? It seems 
> problematic: We want the include file to have the new, portable, 
> prototype for pthread_sigqueue() don't we? Doesn't that require that 
> the original pthread_sigqueue() be renamed to something else and have 
> it call the new pthread_sigqueue()? Maybe that changes one or more of 
> the steps you wrote above?

If backward compatibility with existing binaries using 
pthread_sigqueue() is desired, I would suggest:
- Keep functionality and export symbol of the existing pthread_sigqueue().
- Use a different export symbol for the new function.
- By default, map the pthread_sigqueue() call to the new symbol.
- Invent a #define that allows to use the old function.

pthread.h:
...
// TODO: Add some comment explaining this hack :-)
int _pthread_sigqueue_with_id(pthread_t, int, const union sigval);

#ifdef _CYGWIN_USE_OLD_PTHREAD_SIGQUEUE
int pthread_sigqueue (pthread_t *, int, const union sigval)
   __attribute__((__warning__("Using old version of pthread_sigqueue()")));
#else
int pthread_sigqueue (pthread_t, int, const union sigval)
   __asm__("_pthread_sigqueue_with_id");
#endif

-- 
Regards,
Christian

