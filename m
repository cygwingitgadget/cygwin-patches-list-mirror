Return-Path: <SRS0=DA1Y=IL=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 88A3B4BA23E3
	for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2026 08:42:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 88A3B4BA23E3
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 88A3B4BA23E3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792572135; cv=none;
	b=U4e0HQbqskP6fbvwqviQdhOwcQrzTY138cZApDjHANaEVgjtbTRhQHobBNu3nT7+D8GcYfO/WYHnUwmywsIsA4O1NkCAgRYDzh2zn4P63s953ytnusibxqYUxdxjrcvRR9Qbw15k1cz7PhTAdi4Sg4wWgaZYNKuYcv3W6IPUt/I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792572135; c=relaxed/simple;
	bh=0ToQNRx7p2uOdUEVvOd38wb9BLLKRzTUMcALyzxrl7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=LgHaBAWfTNP7jVMbvGEhpZZj4aUv4wpSp1uY8qBN5p84GLew8Af0SCskMiR2WAPXBs9bQcmWFLOG3Ka+G/0klmtTVcLkD0e2jHmYLFqAW9fHBj+nhmUI82wHQ7s64D0GNRLywNHUA+YlATm28wzNbcd9XkMGfatPrr0KZ7yc7Bg=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 88A3B4BA23E3
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 69L8tdCx077110
	for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2026 01:55:39 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-253-193.fiber.dynamic.sonic.net(50.1.253.193), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdfnik1T; Wed Oct 21 01:55:34 2026
Message-ID: <1da7909f-a11a-47bb-b61a-4f6a9d784840@maxrnd.com>
Date: Wed, 21 Oct 2026 01:42:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cygwin: define IPTOS_DSCP_VA in netinet/ip.h
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20260920043247.4589-1-omikorin@disroot.org>
 <c251f9bf-1881-47bd-a4a4-3a14b6f542f0@maxrnd.com>
 <389ae877-664f-407c-9a4a-540834fc3c66@dronecode.org.uk>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <389ae877-664f-407c-9a4a-540834fc3c66@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On 10/20/2026 12:10 PM, Jon Turney wrote:
> On 25/09/2026 01:29, Mark Geisert wrote:
>> Hello Michał,
>>
>> On 9/19/2026 9:32 PM, Michał Korczak via Cygwin-patches wrote:
>>> Define IPTOS_DSCP_VA (0xb0) according to RFC 5865 to complete the DSCP
>>> code point definitions in <netinet/ip.h>. This fixes compilation for
>>> utilities like openbsd-netcat.
>>>
>>> I provide this patch to the Cygwin sources under the 2-clause BSD 
>>> license.
>>>
>>> Signed-off-by: Michał Korczak <omikorin@disroot.org>
>>> ---
>>> v2: Fix whitespace formatting to match surrounding code style.
>>>
>>>   winsup/cygwin/include/netinet/ip.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>   winsup/cygwin/include/netinet/ip.h | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/winsup/cygwin/include/netinet/ip.h b/winsup/cygwin/ 
>>> include/netinet/ip.h
>>> index 5db1bd9ce..8b67a5c6e 100644
>>> --- a/winsup/cygwin/include/netinet/ip.h
>>> +++ b/winsup/cygwin/include/netinet/ip.h
> Mark,
> 
> I happened to notice that the "Author:" field for this commit got reset.
> 
> I'm not sure how you are applying patches. "git am" should set it to the 
> email sender, but seems like that's fallen victim to "From rewriting" by 
> the mailing list here?
> 
> If possible, use "git commit --amend --author="..." to correct it in 
> cases like this.
I did not use "git am" because I had forgotten Corinna's advice on-list 
to use it.  I just saved the patches to files and used 'patch' to apply 
them to my local repository, then pushed.

Since I've done that for a couple patches already, there are a couple of 
places where Author: remains incorrect.  Any way to fix those?

I can indeed use "git commit --amend" if I notice in time.  That, I've 
made use of before.
Thanks much,

..mark
