Return-Path: <SRS0=MpBi=KY=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id AE7413858C78
	for <cygwin-patches@cygwin.com>; Mon, 18 Mar 2024 17:21:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AE7413858C78
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AE7413858C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1710782521; cv=none;
	b=I7Hjh8dwycbZdA+lCc+zeC0ulL6ReEproxic3AED9qkPJD92WA1Rca3rFskJann/izV8WdQ/jUfnGVTUWnLpCpKVhgQaPRG6VLcvM62uuRiz87AD/Xp3PUTqGwDbAiLvTWR35svxiwQzFsvb3yY3V/9/bxVUtq3KEdEIXDXrYGw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1710782521; c=relaxed/simple;
	bh=ZBCJ/3MGIC9aOe1L649CHcvlr8OSAGAg8TuqWHP7Png=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=jgRJp0mGWGkxCEsbMDX/78pdLnRU9jHgiMh3c7hy+8yRW+f+uJFajd7kmFRKMAh3oLD9kQ50S6WlOcXrBGKGH20tbCwdduP7CSpvKVFuWgzWwfRBBjiyjKc85HSEJQPXPr1ezSX9M8joFVm3HE3csmnsuoJ/tNAYvEYiZRAwvN4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 28594160221
	for <cygwin-patches@cygwin.com>; Mon, 18 Mar 2024 17:21:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf20.hostedemail.com (Postfix) with ESMTPA id A383020030
	for <cygwin-patches@cygwin.com>; Mon, 18 Mar 2024 17:21:56 +0000 (UTC)
Message-ID: <c1f4fa14-09fe-4643-845f-fcb70af7054c@SystematicSW.ab.ca>
Date: Mon, 18 Mar 2024 11:21:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/cygwin/fhandler/proc.cc: format_proc_cpuinfo()
 Linux 6.8 cpuinfo flags
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <86a84fad25ec3b5c49e9b737dfccbdb2f510556e.1710519553.git.Brian.Inglis@SystematicSW.ab.ca>
 <ZfgKd7GX7o7gCoX7@calimero.vinschen.de>
 <1ebfb5dd-f5b8-4f6c-a6aa-e1b7873d7802@systematicsw.ab.ca>
 <ZfhhqUSzxS11qU3n@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <ZfhhqUSzxS11qU3n@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A383020030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout08
X-Stat-Signature: k5mhputu1hb75ipiodoqyoi684n1wiff
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/4eeKuIVaWHgNpWn7+FayPgWG2xctnu0s=
X-HE-Tag: 1710782516-730309
X-HE-Meta: U2FsdGVkX18UjvauawhwDQX4b3KqlIMHxd9HqYROBD/UJ9gyt9l+i+tNr8X8o7opq3m4Spenwt2OXR5b68Iq6CMMX0N1oibszQXTErkceU+4on2BqvSo8QYU4j/+5LdEI1waBMhJ6TMa9xDUejCBeyqHNC8MzS4T63mdXo0HrDN1BRWX9ryVZ+07SZZMPyDBBUq5HrCyqZ28zvDhVDAGXhGjJUUYsOk6NL04hhImsYNpO1bqWf/6zsEsrRacnBAQtTz/mNpTaghWEfAgFwcquUZvI41VZOiZs0fGJyTRpIf0S2kPDRcEPf9I8fR6M9E6cbpFEcYgX1GjLTHr3K90C8apyjVv7Gj2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2024-03-18 09:45, Corinna Vinschen wrote:
> On Mar 18 08:10, Brian Inglis wrote:
>> On 2024-03-18 03:33, Corinna Vinschen wrote:
>>> On Mar 16 10:44, Brian Inglis wrote:
>>>> add Linux 6.8 cpuinfo flags:
>>>> Intel 0x00000007:1 eax:17 fred		Flexible Return and Event Delivery;
>>>> AMD   0x8000001f   eax:4  sev_snp	SEV secure nested paging;
>>>> document unused and some unprinted bits that could look like omissions;
>>>> fix typos and misalignments;
>>>
>>> I'm a bit puzzled about the "unused" slots.  You're adding them
>>> only in some places.  What makes them "look like omissions"?
>>
>> Mainly because single bits are omitted, presumably because they do not want
>> to pollute the symbol space with as yet unused features, just as they do not
>> output all features as cpuinfo flags, until it indicates something about the
>> build and/or system.
>>
>> Compare the minimal common standard feature bits defined in the gcc lib
>> cpuid.h and gcc cpuinfo.h headers, with Linux cpuinfo cpufeatures.h, and the
>> output of the cpuid utility, where almost all bits in older cpuid entries
>> are defined.
> 
> I see.  I just don't understands the difference between, say,
> 
>    ftcprint (features1, 21, "avx512ifma");   /* vec int FMA */
> + /*  ftcprint (features1, 22, ""); */      /* unused */
>    ftcprint (features1, 23, "clflushopt");   /* cache line flush opt */
> 
> and
> 
>    ftcprint (features1,  3, "xsaves");       /* xsaves/xrstors */
> + /*  ftcprint (features1,  4, "xfd"); */   /* eXtended Feature Disabling */
> 
> The latter makes sense, of course, but why is the first comment "unused",
> rather than something like "PCOMMIT instruction" as in the cpuid output?
> 
> Note that I'm not saying that you have to change that, but I would like
> to understand it.

Hi Corinna,

The cpuid output is not always up to date with the kernel, and there are a lot 
of bits defined, so if Linux does not use the bit I will not mention it, except 
where uses and visibility may vary because of merge/patch revisions, as happened 
recently with shstk and lam handling changes.

The cpuinfo capflags are generated by running the Linux build script 
mkcapflags.sh, from the feature symbol suffix, unless overriden by a quoted 
string at the start of the comment, and "" suppresses cpuinfo flag output.

In my weekly pulls of relevant rc sources, I generate a couple of summary logs 
to merge the cpuinfo capflags with the comments and feature bits, and diff 
everything relevant vs the previous tagged release.

I keep an eye on those diffs, and when the next release is no longer a 
candidate, I pull up the Linux changes and look at how they can be added to Cygwin.

I sometimes add features commented out to document bits used in a feature word, 
but not yet displayed on cpuinfo, just to make it easier to compare with Linux, 
or more obvious that an unused bit has not been missed.
The latest additions are the result of uncertainties raised during my last cross 
check.

Below is a sample of the info used to display Linux cpuinfo flags, which I use 
to support Cygwin's, relevant to those you mentioned.
Linux feature word 9 bit 22 is unused, and word 10 bit 4 is not displayed.

$ grep -iC1 'avx512ifma\|clflushopt\|xsaves\|xfd' *
capflags.h-     [X86_FEATURE_SMAP]               = "smap",
capflags.h:     [X86_FEATURE_AVX512IFMA]         = "avx512ifma",
capflags.h:     [X86_FEATURE_CLFLUSHOPT]         = "clflushopt",
capflags.h-     [X86_FEATURE_CLWB]               = "clwb",
--
capflags.h-     [X86_FEATURE_XGETBV1]            = "xgetbv1",
capflags.h:     [X86_FEATURE_XSAVES]             = "xsaves",
capflags.h-     [X86_FEATURE_CQM_LLC]            = "cqm_llc",
--
cpufeatures.h-#define X86_FEATURE_SMAP          ( 9*32+20) /* Supervisor Mode 
Access Prevention */
cpufeatures.h:#define X86_FEATURE_AVX512IFMA    ( 9*32+21) /* AVX-512 Integer 
Fused Multiply-Add instructions */
cpufeatures.h:#define X86_FEATURE_CLFLUSHOPT    ( 9*32+23) /* CLFLUSHOPT 
instruction */
cpufeatures.h-#define X86_FEATURE_CLWB          ( 9*32+24) /* CLWB instruction */
--
cpufeatures.h-#define X86_FEATURE_XGETBV1       (10*32+ 2) /* XGETBV with ECX = 
1 instruction */
cpufeatures.h:#define X86_FEATURE_XSAVES        (10*32+ 3) /* XSAVES/XRSTORS 
instructions */
cpufeatures.h:#define X86_FEATURE_XFD           (10*32+ 4) /* "" eXtended 
Feature Disabling */
cpufeatures.h-
--
cpufeatures.log-Intel   0x00000007      0       EBX     20      "smap" 
        Supervisor Mode Access Prevention
cpufeatures.log:Intel   0x00000007      0       EBX     21      "avx512ifma" 
        AVX-512 Integer Fused Multiply-Add instructions
cpufeatures.log:Intel   0x00000007      0       EBX     23      "clflushopt" 
        CLFLUSHOPT instruction
cpufeatures.log-Intel   0x00000007      0       EBX     24      "clwb" 
        CLWB instruction
--
cpufeatures.log-        0x0000000d      1       EAX      2      "xgetbv1" 
        XGETBV with ECX = 1 instruction
cpufeatures.log:        0x0000000d      1       EAX      3      "xsaves" 
        XSAVES/XRSTORS instructions
cpufeatures.log:        0x0000000d      1       EAX      4      "" 
        xfd eXtended Feature Disabling

[TL:DR

Many of the synthetic Linux features and flags are derived from hw boot or MSR 
info, which we can not yet access from Cygwin, so I ignore those changes, unless 
the feature can be derived from information readily available as a user in the 
cpu, Windows, or Cygwin.

I cross check the Linux and Cygwin sources occasionally to ensure I have not 
missed anything added or removed, spelling changes, Linux tweaks, or readability.

I have so far ignored feature disabling depending on conditions, and cpu errata 
checks and output, as some of that requires MSR info or low level access.

I have looked at trying to extract or generate tables from the Linux sources to 
drive our cpuinfo, use gcc cpuid and cpuinfo headers, automate or at least 
simplify maintenance, but there are many exceptions which we can not determine 
to output, and Intel's practices are not as architecturally structured as AMD's, 
so require code to decide.]

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
