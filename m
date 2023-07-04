Return-Path: <SRS0=ML/7=CW=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 945413858D35
	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2023 00:44:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 945413858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 3640kDcR082959
	for <cygwin-patches@cygwin.com>; Mon, 3 Jul 2023 17:46:13 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpdujkzIG; Mon Jul  3 17:46:05 2023
Subject: Re: [PATCH] Cygwin: Make <sys/cpuset.h> safe for c89 compilations
To: cygwin-patches@cygwin.com
References: <20230703061730.5147-1-mark@maxrnd.com>
 <b5d4a958-cab1-ab8f-d268-0be51e4ebf34@Shaw.ca>
 <ec36ad41-7a70-b0bb-83fe-12fb6e905b3c@maxrnd.com>
 <ZKKpRHhq1K27hnAh@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <9dad4215-bb55-858c-3b30-3e5a19d9dcf0@maxrnd.com>
Date: Mon, 3 Jul 2023 17:44:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <ZKKpRHhq1K27hnAh@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Corinna Vinschen wrote:
> On Jul  3 02:27, Mark Geisert wrote:
>> Brian Inglis wrote:
>>> On 2023-07-03 00:17, Mark Geisert wrote:
>>>> Three modifications to include/sys/cpuset.h:
>>>> * Change C++-style comments to C-style also supported by C++
>>>> * Change "inline" to "__inline" on code lines
>>>> * Don't declare loop variables on for-loop init clauses
>>>>
>>>> Tested by first reproducing the reported issue with home-grown test
>>>> programs by compiling with gcc option "-std=c89", then compiling again
>>>> using the modified <sys/cpuset.h>. Other "-std=" options tested too.
>>>>
>>>> Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
>>>> Fixes: 315e5fbd99ec ("Cygwin: Fix type mismatch on sys/cpuset.h")
> 
> Signed-off-by?

Eh, I was unsure if submitter or reviewer provides this.  Submitter it is.

>>> Does this patch need __inline defined e.g.
>>>
>>>     +#include <sys/cdefs.h>
>>>
>>> did you perhaps include this directly in your test cases?
>>>
>>>> -static inline size_t
>>>> +static __inline size_t
>>> ...
>>
>> No, not directly.  The test case with the shortest list of #includes has:
>> #define _GNU_SOURCE
>> #include <assert.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>> #include <sys/cpuset.h>
>> #include <sched.h>
>>
>> So it's apparently defined by one of those or some sub-include.  But indeed
>> it's not safe to depend on that so I will try harder to figure out what
>> other occurrences of __inline in the Cygwin source tree are depending on for
>> the definition.

In this specific case <stdio.h> includes <sys/cdefs.h>.  I figure one can't depend 
on what's included, or in what order.  So as Brian suggested, I've added an 
"#include <sys/cdefs.h>".  Not every site of __inline within the Cygwin source 
tree does this; I guess those will be fixed if/when reported as a problem.

v2 patch for 3.4.7 is on its way in.  If it's OK I'll then submit it for 3.3.6.
Thanks all for the review comments,

..mark



