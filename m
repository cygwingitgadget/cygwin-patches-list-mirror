Return-Path: <SRS0=pVIE=IM=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.146])
	by sourceware.org (Postfix) with ESMTP id CB90E4BA2E18
	for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2026 16:07:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB90E4BA2E18
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB90E4BA2E18
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.146
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792685229; cv=none;
	b=ZQT6ADfZQ5kn+SyvtSVxXUk71JSh+WISc04gjcLI66TRQT5JWpTaAt8rL9QEWPGJ+VFYbHn+E/zDttq+KWT1zSkedXLEdZWHG3o+resiATNRBkXBp8++2zM2FzAWE0DLUm6Mbfclrj/YyG8RN0BIrbKA0lU+gf6wrep9drL3JUg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792685229; c=relaxed/simple;
	bh=NliViQqNJt+A8aH6T7RjsxbFwdtmyclQ30zb8GjjGf8=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=LmqaHsIsi9cAQxk8IpllU98jAISTwJmAw4zBw+1kF7THFtQ56QzrO/lr/tgOEcecohwPPxCZIhzYpiI47esyLOYIYsoTxHCORZ8VZtiOs6ot1ImDTkkwVfr13Y/y7+Cuyk408kKDMULFFc0r8qO3wo3jS1LulOvaD1tGSalzwNY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB90E4BA2E18
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6AB2D6E50661482E
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGm894hwJDv9Ew+AqqdnNevPXZhGkw+fdi0YqWgCU/mgAmAfItAZSfzGIRhh/lrrqgMY2H4NB3nQOUL8+s+hWZ35S/Ecmii0iLTsfhLhL8ZNF4iOG2BGKibnM2e6djn6VrYudYdsTwwyOAJ59+A+JOartOKcFiKpuihdF68k7SNsx/pVy6wvv9KCaFtKbavemN4FAv1b2Jknu0gVqy/mv3AAsB72J67kpikxS4YBDqEfTBAaBXiC6yRUuX6/SI8SFrs5iMV/b4/b0qHo1gzV4mE3cv1kzyqFr8GyGZpPJHkmyCkbvvv3t/VCaZxJGpww55xOEx1N2g1+ds/xurEKdZlZgWCfzLt+n4zj0lRUjRRbO2YyzUAqoIs0RZd5dL7sla8/cYmdbFa5iBUu0aO1NoqqHewd90DHUZww5rmfmnLD0apXj85lPf/L7IdOZgpygzXT3FtT82pK8Rqx6PUjcApEa5c1HHMMQjLw0J1QvE1EQOFjgXH1ArqnWZxyu5cQRWDOAq1WyKaWwKWFq+olc1FMSAb2JVTdK/orjcReq61aPN1X7HUVEpYepMXL5HoXLz4q+8LsA1aPf83wAN4SBM7Ookdo1wdojh2pUEGVk0dNh8rqOTTQ/vJUrjw3hBZ/r+kISoNN0t2Qftnln7d4pbvJWPG901Bu3HttI1OsMzCnw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6AB2D6E50661482E; Thu, 22 Oct 2026 17:07:07 +0100
Message-ID: <69b4b5f5-3064-4343-9323-fa0120b52fc1@dronecode.org.uk>
Date: Thu, 22 Oct 2026 17:07:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cygwin: define IPTOS_DSCP_VA in netinet/ip.h
References: <20260920043247.4589-1-omikorin@disroot.org>
 <c251f9bf-1881-47bd-a4a4-3a14b6f542f0@maxrnd.com>
 <389ae877-664f-407c-9a4a-540834fc3c66@dronecode.org.uk>
 <1da7909f-a11a-47bb-b61a-4f6a9d784840@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Mark Geisert <mark@maxrnd.com>
In-Reply-To: <1da7909f-a11a-47bb-b61a-4f6a9d784840@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/10/2026 09:42, Mark Geisert wrote:
> Hi Jon,
> 
> On 10/20/2026 12:10 PM, Jon Turney wrote:
>> On 25/09/2026 01:29, Mark Geisert wrote:
>>> Hello Michał,
>>>
>>> On 9/19/2026 9:32 PM, Michał Korczak via Cygwin-patches wrote:
>>>> Define IPTOS_DSCP_VA (0xb0) according to RFC 5865 to complete the DSCP
>>>> code point definitions in <netinet/ip.h>. This fixes compilation for
>>>> utilities like openbsd-netcat.
>>>>
>>>> I provide this patch to the Cygwin sources under the 2-clause BSD 
>>>> license.
>>>>
>>>> Signed-off-by: Michał Korczak <omikorin@disroot.org>
>>>> ---
>>>> v2: Fix whitespace formatting to match surrounding code style.
>>>>
>>>>   winsup/cygwin/include/netinet/ip.h | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>   winsup/cygwin/include/netinet/ip.h | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/winsup/cygwin/include/netinet/ip.h b/winsup/cygwin/ 
>>>> include/netinet/ip.h
>>>> index 5db1bd9ce..8b67a5c6e 100644
>>>> --- a/winsup/cygwin/include/netinet/ip.h
>>>> +++ b/winsup/cygwin/include/netinet/ip.h
>> Mark,
>>
>> I happened to notice that the "Author:" field for this commit got reset.
>>
>> I'm not sure how you are applying patches. "git am" should set it to 
>> the email sender, but seems like that's fallen victim to "From 
>> rewriting" by the mailing list here?
>>
>> If possible, use "git commit --amend --author="..." to correct it in 
>> cases like this.
> I did not use "git am" because I had forgotten Corinna's advice on-list 
> to use it.  I just saved the patches to files and used 'patch' to apply 
> them to my local repository, then pushed.

There is more than one right way to do it. I encourage you to use 
whatever works for you.
> Since I've done that for a couple patches already, there are a couple of 
> places where Author: remains incorrect.  Any way to fix those?

Unfortunately, not without rewriting the history in a way which 
invalidates the current tip of the main branch, which is not something 
we'd do lightly!

> I can indeed use "git commit --amend" if I notice in time.  That, I've 
> made use of before.

Thanks!

The only reason I mention it is that I was tinkering with the idea of an 
update hook which checks that (for commits touching winsup/) the Author: 
is listed in winsup/CONTRIBUTORS, since I'm clearly incapable of 
remembering to check.

(But that's all moot in this particular case since Michał very 
graciously explicitly mentioned that the BSD-2-Clause license applies.)

