Return-Path: <SRS0=uTC2=ID=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id 7FD894BA23C1
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 18:32:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7FD894BA23C1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7FD894BA23C1
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791916364; cv=none;
	b=KIXkv+mFhpR37PqiX/NsVjXi5YMyCTXMQ5/CjQjsf7Hc3LfVpSVgmI+yfaUcE84HWpq8w0cUXng7f8iXqyzDzy/Bf+HQW5bFRTF7Qfyccn2XhoHQD3WqFb0jL+MQCVrWCtFEb15Xy5lcKS/sHDqE9aRU/tObqS+Cru67tslBtos=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791916364; c=relaxed/simple;
	bh=kO50VhxYnK5PwnAcIbpR+YEUF9U7YqlF9dz8e9jSyU8=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=ZcKbaR5qg8UQAd127DGbGmvcBpsQivZC3ljnYiIX9zbqDv9wirEJkIffPA3tN8S42wKLsH+uu+YTCCxT4kA6QofJfDOO2GRVz9nbkSZUrqkZqUcqW7LDFWI/viMOWhHm3Li5SHMNF00GGqkdh7Pur86w/qR5YVqGDJ1NOFOsDZI=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7FD894BA23C1
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6AB2D6E50450DE1C
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: dmFkZTE7PZzf7y4xfeRvNdDptUSNK9LiCF4aiMOpdJ6hrw/29rAuCSUeFpMydqqQsuJI1f2GV/kTdGfzYL6TcuRxNwESPFFeSNyOxRbzOEDOEbxIJLRPNaGlZSKMkhEF+ts81mHj7ZaMrvS7mIoMI/zhtLIp1Mlz7uYJVw/JcRifrYfCU5b989sDEghDl9mQa4thpaPKz+caoxt9ff03VFRn/fwoIHKUe/Ca6nr3xFxZGAgTppZIiVbvUF9YuQ2+1fom5S04jwGP/PyCpVAHoaGC1Uo2OnLMY4ZE7B/r9rFgwkYftV61eDs3mL4r0qR2wBTv9WvRt6DwCC/5I5LI4UxBOImxqVept460ctPsXmIaU7cPiHbWkX0pLko5SnKiJ8LKc9XQSLGmFP0HZ+EyVFtYcGvuTzjmTTTqTYcWG/CKgV1DZT1WDo4gPjLyChlL8YI0hbdRIyBJNe5Lndb+aHeGJc2PvkKso+pan85Iu560nwpyZRfOOA1gFDCNCkUieX0tjwxRFTAyQMK4SR3AteQceAhNpAv5UBSycHV5EHAr8NgggvKzNdtZy09X3U2cvmlEbeGiQA8bnO9XPJQP4zDCmlNEYcQWcgvSCGinwld/h9ewJQvyOqWHycoU/6BnTjFKYFlnYyYCkAWp4RnhQ45ymbFUPUjF7OA+D0pXl5pyBrKCCw
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6AB2D6E50450DE1C for cygwin-patches@cygwin.com; Tue, 13 Oct 2026 19:32:39 +0100
Message-ID: <260285b0-4a0b-43c3-aac8-f9c0720a4014@dronecode.org.uk>
Date: Tue, 13 Oct 2026 19:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Rename orphan __progname variable
References: <20261012090437.1672-1-mark@maxrnd.com>
 <8120d2e7-b3ef-4ca1-8b39-ee4cbe400945@dronecode.org.uk>
 <bb52ab6a-a3ad-45f9-a781-799bbbc227a1@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <bb52ab6a-a3ad-45f9-a781-799bbbc227a1@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/10/2026 08:18, Mark Geisert wrote:
> Hi Jon,
> 
> On 10/12/2026 12:55 PM, Jon Turney wrote:
>> On 12/10/2026 10:04, Mark Geisert wrote:
>>> The last remaining occurrence of '__progname' in dcrt0.cc was missed
>>> when they were being renamed to 'program_invocation_short_name'.  I
>>> discovered this when doing my first "#define DEBUGGING" Cygwin build.
>>>
>>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>>> Fixes: b2476bc (Cygwin: globals: make __progname an alias of
>>> program_invocation_short_name)
>>>
>>> ---
>>>   winsup/cygwin/dcrt0.cc | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
>>> index e7a837673..7fe8f26ac 100644
>>> --- a/winsup/cygwin/dcrt0.cc
>>> +++ b/winsup/cygwin/dcrt0.cc
>>> @@ -968,7 +968,7 @@ dll_crt0_1 (void *)
>>>     /* Disable case-insensitive globbing */
>>>     ignore_case_with_glob = false;
>>> -  cygbench (__progname);
>>> +  cygbench (program_invocation_short_name);
>>>     ld_preload ();
>>>     /* Per POSIX set the default application locale back to "C". */
>>
>> Thanks! Please apply.
>>
>> I noticed that __progname is also (still?) used in cygwin/libc/ 
>> bsdlib.cc. Is there something wrong there, or is that expected to be 
>> independent?
> 
> Thanks for the review; will apply shortly if no changes needed...
> 
> Also thanks for the follow-on question.  __progname is export-aliased to 
> program_invocation_short_name (in globals.cc).  So one could use either 
> name anywhere, really.  I prefer to leave __progname as-is in bsdlib.cc 
> because that recalls its BSD origin.  In dcrt0.cc for this patch we 
> could go either way, though for __progname we'd have to add an extern 
> reference.  I chose to use program_invocation_short_name as the 
> remainder of this file does already.  I'm open to keeping __progname.
> 
> The two names both refer to the same semantic object.  It is filled in 
> by Cygwin as the DLL starts up.  One can later use setprogname() to 
> change it.  But that can only occur after Cygwin is done initializing so 
> it doesn't matter if it's changed.

Ah, right.

I was assuming this was just an alias in the PE export table, but we're 
actually using __attribute__ ((alias)), so yeah, makes sense.

> Let me know what you think.
Anyhow, don't let this nit-picking discussion sidetrack you from 
applying this obviously correct change.
