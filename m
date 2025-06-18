Return-Path: <SRS0=T05G=ZB=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 57BA8396F7E8
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 20:34:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 57BA8396F7E8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 57BA8396F7E8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750278865; cv=none;
	b=ZsaiE64M0pIsX3/tVCAapOLT8EuPWzCLwNTfoWkmE8e6MUPSUg6VrR01SA8J+ehAJWkP4VOOkAEYruCw/Dn56bGIpwFqBS3BjIvsR1AHsWiSoFB3Jk01lGSYB+ig8o5I53Db8vUJmsb81jtb0Zr+5sprdhNZzpv3h2ncPT03c/I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750278865; c=relaxed/simple;
	bh=r3Qmy/TXs1smXCkENxZ9qN2FnlHqH+ZuqX+D5Qwwt40=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=sk6Nco6/ZtcAluIESqGX1MGRSfqA22fNRe+H7OL/A413gpwDAzG/v6MxelK5oE5sb0QSgvGTGaOTrXRLPlT1v5XRP80uIIGsKRFrzlOPlCx3Y+WJ8agXhdqlqHOD0JXPQsR+sl5o0aKtbPXWWuTKRMZcNoXku4m4NqK+cJTHHe4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 57BA8396F7E8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=IUx+P0+E
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id D1246160CAD
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 20:34:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 6BAA320024
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 20:34:23 +0000 (UTC)
Message-ID: <8b8e6185-b155-41f6-b174-cd259e42e82f@SystematicSW.ab.ca>
Date: Wed, 18 Jun 2025 14:34:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Aarch64: Add inline assembly pthread wrapper
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM>
 <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
Organization: Systematic Software
In-Reply-To: <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6BAA320024
X-Stat-Signature: mfnqt7f7j8gx768xn43zhnx6fuymmb1p
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19HxHOVnBnhBJq8XGXSEnKxMOzQPcO2OQs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=PGqnNEDNj7V7wlwV+eZ/TBsWcVwA9CX88BHn/ayIQfM=; b=IUx+P0+E2140b3p0IJQkBJa7VsdxceTgNYl3+zy9BzlXh5+lVcQOKqx9506Jf4lJKRGxAlyvhnEgi0F9cWElQcumttGsLZMuB4e+EMyPQw5p2ScHM4JrO0OI5sHjJV1t9cVj9HhFMLUnswnuSIa4L5/qzQH+TeR3k0n2NKdJudzWdFRHgrkdcXXn2Ijc38xx1/Ig22FosY4Uc9v/B1tU3H2dVzpq39kheNlSTDsIpNdU16Ls09PWA51WZWHrSD0xPTWNlxboV2gR84ZE8RW/yV6qch8xCD+qS7K4fov80B1vLz0Q8FXrX9uDcEdnpuNTmuhn81+kgGke8A/xIdKlsg==
X-HE-Tag: 1750278863-253122
X-HE-Meta: U2FsdGVkX1+YVoBw3L/Zc4XJbjc7uqFFCANcy/1nZ5fjjJfoXAhwx5UcxI43uyyc32h9PnIDLoQDk39AH4f0lamaHr9CPkOkl4zCjwlYtZci5Pv0NEzMZ4VfDwonckRmo5u56iUDFiDSJN2vDQ5c/iJyQsbabhqDi5c5U7dnPlkEn0bmASldJRuuYQDcat1xbnX1Jgp1lONdL8dYZ3oELNGKbOK76YJb2VYF3NeProMfI5yrA8J6JWWusHiDLYWEJVVH/+xBZ8CzekOnUeYms89lexbufkKM/5bj4bNJmDgd9m+1dXYnNrxTDBSQZ1Zz09RWgjoVgi3ZuT0mrkpHnXNwcKqCpxjt6UBeCrh7LVEUBf5yIvb3hf3tjF/K4iXnpXIij7237dm95CEg/YSsaSNJKkD1Gc2RNiOhwVaYqu5/2GCrejh7Cw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-06-18 11:52, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 5 Jun 2025, Thirumalai Nagalingam wrote:
> 
>> Hello,
>>
>> Please find my patch attached for review.
> 
> Please either send patches via something like git send-email that puts the
> patch in the body, or if you can't send patches in that way without some
> mail software mangling them, please include the patch in the body of the
> email in addition to attaching it, for easier review.
> 
>>
>> This patch adds AArch64-specific inline assembly block for the pthread
>> wrapper used to bootstrap new threads. It sets up the thread stack,
>> adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original
>> stack via VirtualFree, and invokes the target thread function.
>>
>> Thanks & regards
>> Thirumalai Nagalingam
>>
> 
> 
>>  From c897d7361356c73b5837afa466f78a58520c1e9e Mon Sep 17 00:00:00 2001
>> From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
>> Date: Thu, 5 Jun 2025 00:30:48 -0700
>> Subject: [PATCH] Aarch64: Add inline assembly pthread wrapper
>>
>> This patch adds AArch64-specific inline assembly block for the pthread
>> wrapper used to bootstrap new threads. It sets up the thread stack,
>> adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original
>> stack via VirtualFree, and invokes the target thread function.
>> ---
>>   winsup/cygwin/create_posix_thread.cc | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_posix_thread.cc
>> index 8e06099e4..b1d0cbb43 100644
>> --- a/winsup/cygwin/create_posix_thread.cc
>> +++ b/winsup/cygwin/create_posix_thread.cc
>> @@ -75,7 +75,7 @@ pthread_wrapper (PVOID arg)
>>     /* Initialize new _cygtls. */
>>     _my_tls.init_thread (wrapper_arg.stackbase - __CYGTLS_PADSIZE__,
>>   		       (DWORD (*)(void*, void*)) wrapper_arg.func);
>> -#ifdef __x86_64__
>> +#if defined(__x86_64__)
>>     __asm__ ("\n\
>>   	   leaq  %[WRAPPER_ARG], %%rbx	# Load &wrapper_arg into rbx	\n\
>>   	   movq  (%%rbx), %%r12		# Load thread func into r12	\n\
>> @@ -99,6 +99,23 @@ pthread_wrapper (PVOID arg)
>>   	   call  *%%r12			# Call thread func		\n"
>>   	   : : [WRAPPER_ARG] "o" (wrapper_arg),
>>   	       [CYGTLS] "i" (__CYGTLS_PADSIZE__));
>> +#elif defined(__aarch64__)
>> +  /* Sets up a new thread stack, frees the original OS stack,
>> +   * and calls the thread function with its arg using AArch64 ABI. */
>> +  __asm__ __volatile__ ("\n\
>> +	   mov     x19, %[WRAPPER_ARG]           // x19 = &wrapper_arg            \n\
>> +	   ldr     x10, [x19, #24]               // x10 = wrapper_arg.stackbase   \n\
>> +	   sub     sp, x10, %[CYGTLS]            // sp = stackbase - (CYGTLS + 32)\n\
>> +	   mov     fp, xzr                       // clear frame pointer (x29)     \n\
>> +	   mov     x0, sp                        // x0 = new stack pointer        \n\
> 
> This seems wrong.  Shouldn't it be
>             mov     x0, [x19, #16]                // x0 = wrapper_arg.stackaddr
> 
>> +	   mov     x1, xzr                       // x1 = 0 (dwSize)               \n\
>> +	   mov     x2, #0x8000                   // x2 = MEM_RELEASE              \n\
>> +	   bl      VirtualFree                   // free original stack           \n\
>> +	   ldp     x19, x0, [x19]                // x19 = func, x0 = arg          \n\
>> +	   blr     x19                           // call thread function          \n"
>> +	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
>> +	       [CYGTLS] "r" (__CYGTLS_PADSIZE__ + 32) // add 32 bytes shadow space
> 
> I asked this on another patch, but is the 32-byte shadow area actually
> part of the aarch64 calling convention, or is this just following what x64
> was doing (where it is part of the calling convention)

Just looked that up for interest, and it lools like 16 byte stack alignment is 
enforced, and a 16 byte red zone is used, unless you also support Win11 x64 
Emulation Compatibility, which requires you to also follow the x64 conventions 
so the emulator can handle both ISAs:

https://learn.microsoft.com/en-us/cpp/build/configuring-programs-for-arm-processors-visual-cpp?view=msvc-170

links to articles about all the conventions.

>> +	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
>>   #else
>>   #error unimplemented for this target
>>   #endif
>> --
>> 2.34.1
-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
