Return-Path: <SRS0=cvqp=EQ=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id ED56D3858D20
	for <cygwin-patches@cygwin.com>; Thu, 31 Aug 2023 20:12:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ED56D3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id bjrnqLMzZLAoIbo1MqLSwG; Thu, 31 Aug 2023 20:12:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1693512724; bh=60g+HhnC4jE2/9AT+7hmQIAZrvHyDkCLn9Y3oCFqOZ8=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=EZm1E0MSLp4WqZl0QS+UlWjz5cDG01gPwx+0BcR0A5r7pjYzA+00jpJ+L9VbPT3FL
	 h3ba1CbnyXNVflNwhGb7lOkX4zbcob+1BQH9tqpEt4XoGNsyk4L4XF+arOHHPAz9tg
	 BMLjGdG9aNmTlwnktRCI+EKzxGODyebSiC06OsWfKrhSoyelmN7XylQowJEj/PRfmu
	 oM/Sf+1hpTQC7LRsfggIL1Qi8Qzj8QNJnCDGZA6Fb5JI6RaW8hPVEub8jwZKVGyHFU
	 ycYsMWBJsNRZe/I2kRzyQ+aEyU3WuwN9P0H/HKsxUHRSmAhTiI4F7Gk8orAhqQ/9wN
	 49xTeA+mglPnA==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id bo1LqasE9cyvubo1Lqwlbr; Thu, 31 Aug 2023 20:12:04 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=64f0f414
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=C2vcOnqep9A0nJ0H8cMA:9 a=QEXdDO2ut3YA:10
Message-ID: <87307c9a-38af-9b6c-0b0f-0acd8e74d93e@Shaw.ca>
Date: Thu, 31 Aug 2023 14:12:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: cpuinfo: Linux 6.5: add AMD 0x8000001f EAX 14
 debug_swap SEV-ES full debug state swap
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <55a6a662221998fa93a01eeb0832e39e510b9cd2.1693454909.git.Brian.Inglis@Shaw.ca>
 <ZPBYc2ut2HAIWZCw@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <ZPBYc2ut2HAIWZCw@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHjHjiDeTN6CqiJiTI+vHMYZ5mM2rgKeIPFMMwpA9gZdupBCbku/j8vdtO2Rq/TrNb3ZZ8TZFwBiNpErVhOeHkG845NKBKy0yePkatlbHIuaX3OGQLrP
 iD+6BvMMfHelgPZXVRxW/fAFn5CZSCNrBkcIHB6HLJBZwbOWWCh2IzrrtSLvHNDdMyolcRnHUFvpVkUefq6YZTxNqHJkJ+joKn4=
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-08-31 03:08, Corinna Vinschen wrote:
> nothing against the patch as such, but your subject line is not so nice.
> As it becomes the commit message first line, it should be shorter. Add
> more descriptive text instead, please, and make sure that it tells the
> reader what you're really doing, i. e.:

Sorry - really jammed it up - only a single mod this release - normally would 
split into release and details - will redo and resubmit.

> You write "add <something>", but your patch is actually exchanging one
> <somthing> with another <something>.

Existing comments are for AMD SEV features originally defined, to be implemented 
and exposed in /proc/cpuinfo "soon" for use in KVM, Xen, and similar projects. 
But not as quickly as previously expected, with timing, speculative and 
transient execution, and side channel attacks, leaks, ucode and mitigation 
patches, not letting up - and now cpu bugs vector is an array! ;^>

> The reader of the commit message would probably like to know why you're
> doing that. Partially copying the original Linux kernel commit message
> should be ok.

Those are often more function specific and in patches to earlier releases e.g.

	KVM: SEV: Enable data breakpoints in SEV-ES
	...
	Make X86_FEATURE_DEBUG_SWAP appear in /proc/cpuinfo...

which then go through subsystem then kernel repo merges to finally hit

	arch/x86/include/asm/cpufeatures.h

and other feature code, where my weekly selective cpuid-related kernel 
downloads, run cpu features cpuinfo display names array gen Linux script, and 
diff features defined and displayed.

Also Intel now hides new features in MSRs, so these become Linux software 
defined features, which we can not display if visible in /proc/cpuinfo, as we 
seem to have no view of MSRs from Windows user space (no MSR driver).

> Also, given that changes a string, does it qualify for a "Fixes:" tag?

Sometimes another vendor or arch announces a similar feature, not always using 
the same terminology, cpuids, or bits, so common Linux terminology replaces 
vendor or arch feature names, for display, as in this case.

> On Aug 30 22:10, Brian Inglis wrote:
>> Signed-off-by: Brian Inglis 
>> ---
>>   winsup/cygwin/fhandler/proc.cc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
>> index cbc49a12a417..be107cb8eacc 100644
>> --- a/winsup/cygwin/fhandler/proc.cc
>> +++ b/winsup/cygwin/fhandler/proc.cc
>> @@ -1652,7 +1652,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>>   /*	  ftcprint (features2, 11, "sev_64b");*//* SEV 64 bit host guest only */
>>   /*	  ftcprint (features2, 12, "sev_rest_inj");   *//* SEV restricted injection */
>>   /*	  ftcprint (features2, 13, "sev_alt_inj");    *//* SEV alternate injection */
>> -/*	  ftcprint (features2, 14, "sev_es_dbg_swap");*//* SEV-ES debug state swap */
>> +	  ftcprint (features2, 14, "debug_swap");   /* SEV-ES full debug state swap */
>>   /*	  ftcprint (features2, 15, "no_host_ibs");    *//* host IBS unsupported */
>>   /*	  ftcprint (features2, 16, "vte");    *//* virtual transparent encryption */
>>   	}
>> -- 
>> 2.39.0

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

