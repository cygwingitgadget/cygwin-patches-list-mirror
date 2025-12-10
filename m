Return-Path: <SRS0=BXtP=6Q=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 715824BA540C
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 21:16:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 715824BA540C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 715824BA540C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765401372; cv=none;
	b=tmLLNYxPCMxpmJM16y/6uWCMBAA/v3FVMSwi1qWEqudW3LeoXu2KmGEGDEfh+BCeULr9I2tBJV1FN9BlYHRsddqKLv5BKUm0ZnuiKcNSNSV/5vVrmohnKo0iBlVgg/xIcfZbs7D2Vr/u+Q76bceU2TmieyW5bu5Foq9hhd9b934=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765401372; c=relaxed/simple;
	bh=qs/mLr5RNUW97I27u+KNK1EJkm1wURQ0fuRWFn6oqzQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=f1UR6/uLtQRem7VBfP6GXjPe1Fm1zPEOa6A1PKNCGwv2IUTo4OzrXWXezXerJZ1NziuZB7ynQq9idyQm0093AiqUT/2SRzUSNV1P87eGuv3AufFOL0GMqpmDGSWvKAbbyGuIDs70xo8o3O6WdR7X4TaZpHqdmvVA/uZ6G/LgQ+8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 715824BA540C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=fBu1q2We
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 08677C0729
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 21:16:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id 891B82000F
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 21:16:10 +0000 (UTC)
Message-ID: <f3c3a2d2-2f0f-4d39-b30d-65647925987c@SystematicSW.ab.ca>
Date: Wed, 10 Dec 2025 14:16:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: newgrp(1): improve POSIX compatibility
To: cygwin-patches@cygwin.com
References: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
 <20251205194200.4011206-2-corinna-cygwin@cygwin.com>
 <9f4ccea4-95c9-481d-93ca-9d1e5ae31de3@dronecode.org.uk>
 <aTf3BPKzr6ChHpdA@calimero.vinschen.de>
 <ef167d04-7b37-4c89-b0d9-c0264d2a9295@dronecode.org.uk>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <ef167d04-7b37-4c89-b0d9-c0264d2a9295@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 891B82000F
X-Stat-Signature: psxnt7zissknppu6x4skyny1bw86dbat
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/7SrE1BUcOGIZzuf0WT1ae3MBwI9E7gLg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=/ee199AWr10lLTD8mkADPuwG5TRO7qz4aLEEjmnoTko=; b=fBu1q2WevkvVoiPsUUtCE8BJPZkI47LC9zKFK8Wd6zBgiaU82DXHGYUcu/3BVRs+oUpZtn0+lWtY87UonMkTbq4T7K6+iRLRg0F7idGtGW/xyP7wrvVaT47JgGetp4k3eurPxFOwLCyKXeQfodekP+lEtEafXFT+hUcWeXrC8BHOOXtBsBA/8QeEwNP8oynSpy/+md/3NJUBQfWPFHy+oiZ9D5UWKdbm2Jn1p23xSsh3qbXvffMoneLquu//ysRUT8MU7eAxcCUzGDLUehqhlySsMnN76xB5Fqxwi5aKiBbodkxLxUovLX0q60gqJQvP3aaExnF91kgQT7y7jPsfWA==
X-HE-Tag: 1765401370-563046
X-HE-Meta: U2FsdGVkX18YY5i/O7EvrRzW59kzmONsim1fWa2RedUoZuymFwA9XxfDeD8zZ4HayOGF8Jug+Bb8Jd0zbxP71ErA6SjdEyI24PholPVlK+xDOycwHRS4BuKmG3YDbLm+gU0lP9NRrRvv5h7U2mEcF9EyR+8fg5W+KG3ZqXOgjpY8xSCY03D/xHOBek1+edWDHZFHzqDGKyypZ3l6auHrfFKNBzjB1zFECh/uIV3TOIjY9t+zLBZ4ugs/alYo8rWUuj9qSxS+hsCBiirlxK1tNo5Qx2t7BTwRNw6d8lFtFnfQAOV0P3Fbn2YhS4EH6MNYeLqMZAEWwlVQ23zBdCKGpedJ1ErwMdkoYxM1tlhyNL4vi4nWi3I670X88ZSaR4e0XZ/DgQ6itdYiiJ9FGndwJOzspmriNbZzMYSB0IJiEyoCNIivT5/EIy3X+H2PI/OSVJ3R3LVeINw=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-12-10 09:33, Jon Turney wrote:
> On 09/12/2025 10:16, Corinna Vinschen wrote:
>> On Dec  6 11:56, Jon Turney wrote:
>>> On 05/12/2025 19:41, Corinna Vinschen wrote:
>>>> +      fprintf (stderr, "Usage: %s [-] [group]\n",
>>>
>>> Maybe '[-|-l]'?
>>
>> The usage message is the same as used by the shadow-utils newgrp
>> on Linux.  It supports -l, but doesn't print it for some reason.
>>
>> If you think we should do it better, I can change our usage output
>> and send a v2 patch, no worries.
> 
> I am ambivalent.
> 
> The most recent SUS text [1] actually redefines the behavior of '-' as 
> "unspecified" so '-l' seems preferred.
> 
> (This seems to revolve around standardizing '-' to refer to stdin)
> 
> [1] https://pubs.opengroup.org/onlinepubs/9799919799/utilities/newgrp.html

FYI had a look at:

https://pubs.opengroup.org/onlinepubs/9799919799/utilities/sh.html#tag_20_110_05

and it now says:

"OPERANDS

The following operands shall be supported:

-
	A single <hyphen-minus> shall be treated as the first operand and then ignored. 
If both '-' and "--" are given as arguments, or if other operands precede the 
single <hyphen-minus>, the results are undefined."

and see below that about sh STDIN usage.

>>>> +           program_invocation_short_name);
>>>> +      return 1;
>>>> +    }
>>>>          new_child_env = true;
>>>>          --argc;
>>>>          ++argv;
>>>> @@ -165,8 +165,16 @@ main (int argc, const char **argv)
>>>>        }
>>>>      else
>>>>        {
>>>> -      gr = getgrnam (argv[1]);
>>>> -      if (!gr)
>>>> +      char *eptr;
>>>> +
>>>> +      if ((gr = getgrnam (argv[1])) != NULL)
>>>> +    /*valid*/;
>>>> +      else if (isdigit ((int) argv[1][0])
>>>> +           && (gid = strtoul (argv[1], &eptr, 10)) != ULONG_MAX
>>>> +           && *eptr == '\0'
>>>> +           && (gr = getgrgid (gid)) != NULL)
>>>
>>> I spent a bit of time worrying how this handled edge cases like '' or '0',
>>> but I think it's all good!
>>
>> Thanks for checking!
> 
> No problem!
> 


-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
