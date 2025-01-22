Return-Path: <SRS0=2YaE=UO=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by sourceware.org (Postfix) with ESMTPS id CEF303858C5F
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 17:36:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CEF303858C5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CEF303858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737567392; cv=none;
	b=sZAGQ1fkiUnZtjgKSN+OV2PdIS3aMlIWMuu8twAqHbbz3F9bx1rzV/ayNtR62LxJsnSnzh3T9Nini5J4xvIMi2zrnrCjV+TKKC3BLscQzgi3hc/boqJSAW88idPaZU6bCqYB2tT2l5IEFNREHsvVdXkbuj2E6x/aOTXM7WAoZCc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737567392; c=relaxed/simple;
	bh=wEXI5pdAv4TLfkpPppcO/J28G0o86xHGaAX+FHjdoDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=NnYaXEpCLRmnibpcMXXXXXSuW4PZsZeIxKeEpcO9AVfZrM1sCPYnReUyNJToOg3LPKdu9DAm6eZTBqSIA8xX3vOpdPuAILkPWckyxuh8JNriaTXkO82vaBplMhTJSf9l/dLu4VnQEIqbOtqsI8SxHp/c+FlD0I3V5GBab+7eYcI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CEF303858C5F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=K4XU4e+C
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 2C7F71A0464
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 17:36:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf12.hostedemail.com (Postfix) with ESMTPA id 5D01A19
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 17:36:29 +0000 (UTC)
Message-ID: <d4249a94-5efa-43c0-92f3-4586b8cff507@SystematicSW.ab.ca>
Date: Wed, 22 Jan 2025 10:36:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 3/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <342fdec23f175f816177ac73945ed7fbf5538b90.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z5DQzmtsrcGeFPxx@calimero.vinschen.de>
 <Z5DRovbwX9QpofDO@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z5DRovbwX9QpofDO@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: xp1a5jn9oj6yah9xzjth5fhy6rkhb63z
X-Rspamd-Server: rspamout02
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 5D01A19
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/LdajDhZPEJZ0ZTWLxcCkD3ks+H5+6kMM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=fmV68X9KojkV1tZg4dv83qy2QJ4+sKpa3VqlAg/2qfg=; b=K4XU4e+Cir3/VICMCE91IsuTOjDoeo3vXsJ6G4n6tHYgxI06SmMbrOPAmloWvbDplOMs9XVrRaBi7siC2EYvCHkFurtrTofJqFduJl++5VczV9+ZDulqypLJcB2GpofF2UUUBiyX4w59HTPKOikmL8iQhRAzKRg06Da5zG6+tY0Fc+7AVLBBQ+9NPza/AfbUHgOZ9fNvbQ4bgq2h6JTIXhBk4cIZvX2Vnlv1O2SN309yzaCUU1kQsLEjWwGVLSAWbmf0BSf1Rqy1aQy9M9msiTRo48KtwP7rLlSbRm9YzyeQrx9m5vCXezSVVyfhPkaSPImK1uVPJ2TlHIacVTJPWA==
X-HE-Tag: 1737567389-40629
X-HE-Meta: U2FsdGVkX18vfOM7B9aeRvhJLj+Jl/8BBvLuy8L0gAlnLxtfUIW6sPlRBMA11pX7nUxaV/ltUtoJA2ikN3QOzPLG7mmeuDj7A4t1Me65Sak8hB7qKhk48dq55/8+gWEUJJss25NB5mSQsJ9ZifOQCnriPweI6Uxmzg4hHGAh4xfC4OH5ggcPC9GNo3c4mcv3TvbkJkZFv45ET912L2YFj60p+v+yb0Fxh9+77vk/GrmaLTs1GQzeCbGwPwL/Y1iCukf+065NqS+2xBOEnRBoZ3bd2UnynUcjxbez0drTE+On9FPv98JGzqzUK9VKPdJGLwaQNCkNwYElV2KQPMfHXQNy4rXUFOt67QGeBTDZLdB1j6bx3XMDnLJA7p7EBELYwjHDd9NhL6eLIEQH+JdiFw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-22 04:08, Corinna Vinschen wrote:
> On Jan 22 12:04, Corinna Vinschen wrote:
>> On Jan 17 10:01, Brian Inglis wrote:
>>> Add unavailable POSIX additions to Not Implemented section.
>>>
>>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>>> ---
>>>   winsup/doc/posix.xml | 26 ++++++++++++++++++++++++--
>>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
>>> index ac05657d2246..7e66cb8fc1c0 100644
>>> --- a/winsup/doc/posix.xml
>>> +++ b/winsup/doc/posix.xml
>>> @@ -16,6 +16,9 @@ ISO/IEC DIS 9945 Information technology
>>>   - Issue 8.</para>
>>>   
>>>   <screen>
>>> +    CMPLX			
>>> +    CMPLXF			
>>> +    CMPLXL			
>>>       FD_CLR
>>>       FD_ISSET
>>>       FD_SET
>>> @@ -554,6 +557,7 @@ ISO/IEC DIS 9945 Information technology
>>>       jn
>>>       jrand48
>>>       kill
>>> +    kill_dependency		
>>>       killpg
>>>       l64a
>>>       labs
>>> @@ -1466,6 +1470,8 @@ ISO/IEC DIS 9945 Information technology
>>>       mempcpy
>>>       memrchr
>>>       mkostemps
>>> +    posix_spawn_file_actions_addchdir_np
>>> +    posix_spawn_file_actions_addfchdir_np
>>>       pow10
>>>       pow10f
>>>       pow10l
>>
>> These first three hunks belong into patch #1 of the set, don't they?
> 
> No, sorry, into patch #2, of course.

Hi Corinna,

Re previous comment: I thought I was to apply those lib+crypt changes!

As I said in 0/5:

"Please note some changes are displaced due to rebase conflicts."

which only appear after commit --amend/rebase --continue!

As I said before, I am now noticing the limitations of interactive rebasing and 
cherry-picking, sometimes skipping patches or hunks, especially after conflicts!

If you have any advice for avoiding those conflicts, please hit me with your 
clue stick! ;^>

I will return with v8 - caffeine+sugar-powered rather than veggie-powered!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
