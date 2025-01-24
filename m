Return-Path: <SRS0=IqST=UQ=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id CB0953858D1E
	for <cygwin-patches@cygwin.com>; Fri, 24 Jan 2025 03:04:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB0953858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB0953858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737687869; cv=none;
	b=b8wvfMU17TC/t/akKbkUHQ1v41T7XV3QitjJGxAnNNXOrEU5zGln3QltGxuj2ImRAeg9+exSoHiisBSEm/xyrzs+HRjOP3EbJ/4WeAvi6pPm38YNd94N0W7QnATLmc0PWyPrIto7MITB79tuMyUMSffQnRO9emPlkogAYnfPXP8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737687869; c=relaxed/simple;
	bh=IMCSnJTzFwA2aUh6LEOcw2ac81OgkcrrSre0JJ7BmM0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=iH4prBngRpH9QXSVxRtsOgoiTwK/ScUUIkoO3GIUV5sE7Sjz2hUzmxnuBmCm6A8nMMswmbSh+/agVL3jykDZdnTYU5cjdvBzf8tXeuo8aM29MiGHUtqaQVK1z/afrPG1a9FK6wnij4EunzTQa4QBIl294gqamCc+7kQJSoYiyCk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB0953858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=rdm7r3Gd
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 5D7C747A4F
	for <cygwin-patches@cygwin.com>; Fri, 24 Jan 2025 03:04:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf19.hostedemail.com (Postfix) with ESMTPA id F165220026
	for <cygwin-patches@cygwin.com>; Fri, 24 Jan 2025 03:04:26 +0000 (UTC)
Message-ID: <31d21c4d-62f6-44e3-aaa8-9ad4317212fa@SystematicSW.ab.ca>
Date: Thu, 23 Jan 2025 20:04:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 4/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <7c1df0773801655e35abbfb28c4428df9b4854ee.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z5DVKOrVtnXunSvK@calimero.vinschen.de>
 <d0d4373e-9564-40b9-96f2-1bb908ea8875@dronecode.org.uk>
 <Z5ITE54yxFUAJK9l@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z5ITE54yxFUAJK9l@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F165220026
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: de96jtruzpne91gyuhrczk74h5xm37ur
X-Rspamd-Server: rspamout03
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18HLZ3cVSjCE6yqV274xqx/1IlcguncZME=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=RRL3EP3nLnmphKHVyupQwyOwRGxvWkwQ9lRBJFy2iNQ=; b=rdm7r3GdK1Xw1JZL+TQltxhDDns+7TRT7lB95Mm9sP5txOp7oJDN74rijTrxu9m+jaju7TxfMw3hXHSSM1uUyfWYK0FZGlMd+D1pllV17RAHIbkQ3N83KQ5JDai28xiRCpACHGdEUkClZR8vmbu4/mD/exaiFODqhP4gVt9EBPg21MHrSFwdGxN/SNuJWbkANK/Itn1NEu+HgfIqojN7zSx+1n+34Qz+kyAmAGR7IXXC/ZbcG/bZd8JoA5l9n0GUVGKBIp8jhR7SpL7jUnddCZNqHIXQqT2HcpIoDkWCUFkwHWV8HUu4svNIoI5WG1DPyKagmeoU9d8iWBT/5Sl/Jw==
X-HE-Tag: 1737687866-178423
X-HE-Meta: U2FsdGVkX1/WZK4LCZ3lkuwW8AN3w0tNibcE75ua6hBA0F9rnDDcIlvEQMeYdMAxuYVvFdstq9Sa9XnG7p13MS+N5xhwSczryMKW/mUYeYCW+u55l3dqgb4xR7w9jiZ+Pg1KRu7TSTxtNQooRAmlCTlBLsI5pV8cy5ZkFJSgZ45GCDLj/RopnGWFVau6TmDErKKTax0qYwAJhar2kukkhh6ijGIDCaOCwldzY932eJ7sQkA5rvVjgGWeOfVShjx0xRic8dRNtsKA+RacYFHoLSmdhp1PYmxvM165dbQeiiWXftsuVmQyMsxq4WhANZ3FfJIbAmYwzdqRDCsl60xbTn84M/w337eY
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-23 02:59, Corinna Vinschen wrote:
> On Jan 22 17:37, Jon Turney wrote:
>> On 22/01/2025 11:23, Corinna Vinschen wrote:
>>> On Jan 17 10:01, Brian Inglis wrote:
>>>> Move entries no longer in POSIX from the SUS/POSIX section to
>>>> Deprecated Interfaces section and mark with (SUSv4).
>>>> Remove entries no longer in POSIX from the NOT Implemented section.
>>>
>>> This looks good, but I just realized that a bunch of functions are
>>> missing.
>>>
>>>> -<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
>>>> +<sect1 id="std-deprec"><title>Other UNIX® system interfaces, not in POSIX.1-2024, or deprecated:</title>
>>>
>>> When I introduced the ACL functions from the abandoned POSIX.1e draft,
>>> I missed to add them to the docs.
>>>
>>> Well, fortunately I'm now noticing this a mere 8 years later... *facepalm*
>>>
>>> Sigh.  I'll create a patch to add them on top of your patches later on.
>>>
>> I happen to notice the other day that we don't mention eaccess() (which the
>> glibc extension euidaccess() is a synonym for) here, which I think belongs
>> in this section.
> 
> Yay!  I'll add it later together with the POSIX.1e functions.

Hi Corinna,

Do you think it worth checking against symbols found by say:

$ awk '/^\s*#\s*if.*__POSIX_VISIBLE/,/^\s*#\s*endif\s*/' /usr/include/{,*/}*.h | 
wc -lwmcL
     992    4348   34846   34846     113

or a more functional variant to scan the ~164 instances in ~36 files?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
