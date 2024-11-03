Return-Path: <SRS0=2IHS=R6=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 39C303858D26
	for <cygwin-patches@cygwin.com>; Sun,  3 Nov 2024 08:44:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 39C303858D26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 39C303858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730623464; cv=none;
	b=M+FLoNr2/tzqHUGcxCsl1WRxNcVHyPTO30BUMrPN6X4Sk5FIrIvaUPSum1i85yNzwINKALB+AuTVPNjZNCfP/5ci0vVyXpBVfesrBKH4LNyOB8Jx4rA9ZweoNXkS2WEpzQz0qas07tgBXHNOkQ1zjkTk74yKiuhWJgKkOFCAWO0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730623464; c=relaxed/simple;
	bh=7mtUjCnVU6IY2ccQ3Mo6ERobR2jHb6akIZdabYYsS/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Y0Nv4Fh9J2zck1biexlYxBJOgCQgQHKZGnqAJBHtB72y3fOtGBAZdR8RxSHNMFVOxMKSZ6SPR6/hDiXikV3Ip+5gkl2Bcr608WkOj3Epn26rC1Ya+L2a/1iL0wJLn8LuX5YQL+zNSTP1CfGAZ/5lr3tU1kKq29B1yW2Hz0WAxB0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4A38lWMn060951
	for <cygwin-patches@cygwin.com>; Sun, 3 Nov 2024 01:47:32 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdewZF0F; Sun Nov  3 00:47:28 2024
Message-ID: <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
Date: Sun, 3 Nov 2024 01:44:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On 10/22/2024 7:45 AM, Corinna Vinschen wrote:
> Hi Mark,
> 
> Thanks for looking into this.
> 
> On Sep 19 02:13, Mark Geisert wrote:
>> Change the first parameter of pthread_sigqueue() to be a thread id rather
>> than a thread pointer. The change is to match the Linux implementation of
>> this function.
>>
>> The user-visible function prototype is changed. Simple list iteration is
>> added to the threadlist code. A lookup-by-id function is added to class
>> pthread. The pthread_sigqueue() function is modified to work with a
>> passed-in thread id rather than an indirect thread pointer as before.
>> (It was "pthread_t *thread", i.e., class pthread **.) The release note
>> for Cygwin 3.6.0 is updated.
> 
> Even if the old prototype was wrong, we probably have to keep it for
> backward compatibility.  As unlikely as it seems, but there may be
> binaries out there actually using the old prototype.
> 
> We can discuss this probability, but assuming we want to keep backward
> compat at all cost, we would have to

No need to discuss. I'm happy keeping backward compatibility.

> - create a new function like pthread_sigqueue_with_correct_prototype (heh)
> 
> - Add this function to cygwin.din as exported symbol
> 
> - Add a matching entry to NEW_FUNCTIONS in Makefile.am, e.g.,
> 
>      pthread_sigqueue=pthread_sigqueue_with_correct_prototype,
> 
> - Implement either pthread_sigqueue_with_correct_prototype calling
>    pthread_sigqueue or vice versa, whatever makese more sense.

I appreciate your redirecting me towards an acceptable solution. I've 
re-implemented the fix as you've indicated but there's one thing I 
cannot figure out. (BTW I implemented a new pthread_sigqueue_portable() 
calling existing pthread_sigqueue().)

In cygwin/include/pthread.h, should both function names appear or just 
pthread_sigqueue? If the latter, which version of prototype? It seems 
problematic: We want the include file to have the new, portable, 
prototype for pthread_sigqueue() don't we? Doesn't that require that the 
original pthread_sigqueue() be renamed to something else and have it 
call the new pthread_sigqueue()? Maybe that changes one or more of the 
steps you wrote above?
Thanks & Regards,

..mark
