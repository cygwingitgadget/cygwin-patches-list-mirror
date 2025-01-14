Return-Path: <SRS0=sRnL=UG=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 6D0DF385C6C6
	for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2025 23:48:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6D0DF385C6C6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6D0DF385C6C6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736898502; cv=none;
	b=FsYfdxrldihFBRFT0BVPbfOWiovG2Ez+o+6vZhyezYcthyrtWSBciF9Abjmd1MGfA1N0UvspFuwCMyzIBpSbpPvK9SUKdRwkxERVe/i6v9mfkxG280Kq9+ZmICcxGqG6EtJMOqy4r19ugLml7FcsVwz7thQeGw8E4FMdZOo3MfA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736898502; c=relaxed/simple;
	bh=l7d3x8JFg3dRxAVEphRttJ7e1cVKoqpc5adNUJ8rfzk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:DKIM-Signature; b=Dt/dQKPZeZmqIXrERThvREaan39TvcJdJhUi8oH8gphPAmrt9pBXfJSvdUCLku28WcoKe8JEjeTE5pi6rZ0LvcOrp9jhM8tWw0fbvF1g1nQAKbK/OYlEKNEa39ewMDz/39kQOrq5ZiznQSrBAE0lG+ckBO/Psd1XAW6vsCfysAo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6D0DF385C6C6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=TkO7r5Lb
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 12775AF704
	for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2025 23:48:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf02.hostedemail.com (Postfix) with ESMTPA id 9CAF88000E
	for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2025 23:48:20 +0000 (UTC)
Message-ID: <83e51bbf-51b0-4baa-bf6b-d2ae1a0edfaa@SystematicSW.ab.ca>
Date: Tue, 14 Jan 2025 16:48:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 7/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 merge function variants on one line
Content-Language: en-CA
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <39517f2a7fdd36a043c2029e0a24e16e8e7f3bee.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4UXaKQmj2s22H3B@calimero.vinschen.de>
 <e4bb6f52-d246-40aa-a7e9-a173794c1376@systematicsw.ab.ca>
Organization: Systematic Software
In-Reply-To: <e4bb6f52-d246-40aa-a7e9-a173794c1376@systematicsw.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: p4q6uhzf9zqhidnr6qsmj3r7wst1m5mr
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 9CAF88000E
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19YHDh/x4VENe7je/ZcBfIshGfsYcZ6rgg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:subject:from:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=u2limKfqk8ygMeI0qhH4MkBtHXrVmmkJp7BoRVbppsQ=; b=TkO7r5LbJ6LPuBWPnAzctF5HoLzPOASl/JT19ltvyWIdmeJkgRd1yRhlB2XSGy1cQOB5mpK8JZoqNTbE4B0eoNnfGPmwxEfa0ulpgx47ll82KmZCjtEaBcli/Nct5ZG19PSXlsnA9oZFH70m5XqzbWpiTDGSbDV0KhRoX0fp1ft45RnTeaTLzW42iZTTFcqqX/pgVVxFce//q2fxptfLv6sZoI9F1a192rrb0EpAv5QqdhOqNYwGcRwizaIMxzaI/VRXLFiyHys/8t3Ks33IDMkNTv9cXkpyZ0P7+i8VEwRtQa0FeUoEpkOok37m3JlBmO0KKLf5Fy+86WBEVY61Ew==
X-HE-Tag: 1736898500-414292
X-HE-Meta: U2FsdGVkX1/vRf8BeppkmaKwAplU8173+GBSzJE0skRb4rlCsS+FSND+8qtGvjjpD6BGOmhcgSKxLPj8XUHABuCgjKI14IqaGAdzpKcLGkNQOwRL4yIm4+SXdSBlboLJojnySvuYFVBgdAavO6qrk/mozCVOHGEthr0rxOeOZhV5V7aOrsOsLvan/Fm5mMFSknV3yxCid/yCVe2ZFLjGTbf3a1/xK/iRnE9Rd2hiMS7NJTWY1Oa7o4RHENO022H5/pDikEB9v5jl+IuomtW+gSNdTjX8yxPrDt7smivFDDwDIYBt9Mkh06l4sjA9khD4AyoDDXTgvQqimEUzAsydRpZklKN7U5ZtnFpYOlq8sbp1LumLmskwH4c1vAPIQ8BOONCQ2oPsx4iq0inI8RXBUA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-13 12:07, brian.inglis@systematicsw.ab.ca wrote:
> On 2025-01-13 06:38, Corinna Vinschen wrote:
>> On Jan 10 17:01, Brian Inglis wrote:
>>> Move circular F/Ff/Fl and similar functions to put
>>> base entries and -f -l variants on the same line.
>>>
>>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>>> ---
>>>   winsup/doc/posix.xml | 336 +++++++++++--------------------------------
>>>   1 file changed, 84 insertions(+), 252 deletions(-)
>>
>> Hmm.  This makes more sense than the previous patch.
> 
> This is part 1/3 of order/combine/abbreviate, submitted separately to ignore or 
> change.
> 
>> However, it doesn't make sense if only the math functions are affected
>> If you want to do this systematically, you'd have to group them
>> following the Open Group Base Spec Issue 8.
>                      or SUS V5 or POSIX 2024 or ... ;^>
> 
>> That would also imply merging stuff like
>>
>>    iswalnum/iswalnum_l        -- page 1280
>>    le16toh/le32toh/le64toh    -- page 1327
>>    localtime/localtime_r        -- page 1354
>>    mlock/munlock            -- pages 1433, 1488
>>    sig2str/str2sig        -- page 2040
>>
>> etc. etc.
>>
>> Nevertheless, while this has a certain charm and I don't see
>> a disadvantage, I'd like to get Jon's input to this as well.
> 
> Okay with other _l _r _s suffixes, not sure about bits, un, or <-> flips?

Looked at the Refer to entries in some man pages for groups, and looked at the 
functions in the referred to man pages, and grouped by those criteria.

Looking at the end/get/set...ent groups, endhostent/sethostent are implemented 
and gethostent is not implemented - should we keep them separate or combine in 
one section or the other?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
