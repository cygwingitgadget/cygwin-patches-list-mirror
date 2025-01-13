Return-Path: <SRS0=TxHU=UF=systematicsw.ab.ca=brian.inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id B3EAB3858D38
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 19:07:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B3EAB3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=systematicsw.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=systematicsw.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B3EAB3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736795258; cv=none;
	b=DhEaqt/qgXsE8Y9jC3Wi0TQtoJBUqnMTLlV3NeAQKiO5k1aCNTt+UrwnqmxCS8xyhVWYIz7w16eaDzp30BeRm2CLrDRQKtsZ2W4rYU7V5DfiIMf5vxOUPSmC753vI8pQ6SAG+gAste5kR/k04ruELe6EHAt2ZSdOQ9RKFfl0Jf8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736795258; c=relaxed/simple;
	bh=vxbnIgBkR5QPcQ+euvgwB7vOy234CeqyoQx6aA5GINc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=k5Vc3saY/1ocbHi1WRjJY6pIMnmFla2DV1PYUnl95x9TWXE59O8RWmXPBmlO+Zym1m987a71QmU5GQNkNMZFHmxQ4NfIEHQDmS486LF44ZHZJiHvmYDP23KR+yTJlXjofXqMOg3pQz2ojZUMMD7voO14OA1mw3B9zJJLeegQLFA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B3EAB3858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.a=rsa-sha256 header.s=he header.b=YSShSFhm
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 56E0FC02F2;
	Mon, 13 Jan 2025 19:07:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf08.hostedemail.com (Postfix) with ESMTPA id D172020027;
	Mon, 13 Jan 2025 19:07:36 +0000 (UTC)
Message-ID: <e4bb6f52-d246-40aa-a7e9-a173794c1376@systematicsw.ab.ca>
Date: Mon, 13 Jan 2025 12:07:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: brian.inglis@systematicsw.ab.ca
Reply-To: Brian.Inglis@SystematicSW.ab.ca
Subject: Re: [PATCH v5 7/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 merge function variants on one line
Content-Language: en-CA
To: cygwin-patches@cygwin.com, Jon Turney <jon.turney@dronecode.org.uk>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <39517f2a7fdd36a043c2029e0a24e16e8e7f3bee.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4UXaKQmj2s22H3B@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z4UXaKQmj2s22H3B@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D172020027
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout08
X-Stat-Signature: pxew9xyd84yyf97us7rt7hrwttzeegjx
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/BAvkhTrKr2D3mgquMun6hxojxDdxro54=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systematicsw.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=GDzTrIMqzZdULfuiG6+0pZ9k+0hPa37y/3qrwfIiv+E=; b=YSShSFhmx7sIuaSdS/KkWybHD5Ti/h0QkR8M0+r8cmJOQIjuPYzbqgc1ChY57NPJdLDJsvv0bcR2A6cxAXIKXsEahh1WgBYL9nIDBhygLP5+rhsrt7tldmMkMLrsllWbfbhP8zfrOE4aBvYzgxt9AnDtr/11pLk47bd/rXMmilist+Uvb3+NlToIuYsjJh6zqgM6J6BIHi/gRsrCDSbMwo+2t30vuskbcUlRCYUyEu9MZeheLkmEg6L7UwOSsI7bYG1xUGRHH76JEyO/s9Qk7ANbglyiK/a2ij1qtlrxjg02ZZSZ6xgf1TCKX/vz79nvRYXQKPYJknB27KDe/03M8g==
X-HE-Tag: 1736795256-614467
X-HE-Meta: U2FsdGVkX1/DWk07UGitsDApICnorrkt5gBY7heKWXXkjQTicDOYtrgpxkfczeoJKvENBep3UoB4gKh/q2pn8oCiKHW7lRbumDqVCvhP+DUFgRV+El+Xlmf33S7ig/FzwRXrZOXOuJrKSC/t7lOvyAZ/a3JDD0ffoPlQ2qIKAnBQRS+nomnGeAakYyChjUKk+T4H7TNFq7wknZ3FbLIoqqFTM6z993BOhMjFJqa4K0iSvXqUUOtbo36Dsf9WLPRK7BooR3FRjFFiigujGMTFTWfIt9qTakjkQ70ukh3REQUOzH/mQ3pybMZ8drlok7Os0jALQjwQbC1cTczTbhyQjASSEg9GaOWgs4wtHhMV1SKTsz9CWa2SxatkHP8GNrSM/hFywECUXlLNj5eKWrGn+Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-13 06:38, Corinna Vinschen wrote:
> On Jan 10 17:01, Brian Inglis wrote:
>> Move circular F/Ff/Fl and similar functions to put
>> base entries and -f -l variants on the same line.
>>
>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> ---
>>   winsup/doc/posix.xml | 336 +++++++++++--------------------------------
>>   1 file changed, 84 insertions(+), 252 deletions(-)
> 
> Hmm.  This makes more sense than the previous patch.

This is part 1/3 of order/combine/abbreviate, submitted separately to ignore or 
change.

> However, it doesn't make sense if only the math functions are affected
> If you want to do this systematically, you'd have to group them
> following the Open Group Base Spec Issue 8.
					or SUS V5 or POSIX 2024 or ... ;^>

> That would also imply merging stuff like
> 
>    iswalnum/iswalnum_l		-- page 1280
>    le16toh/le32toh/le64toh	-- page 1327
>    localtime/localtime_r		-- page 1354
>    mlock/munlock			-- pages 1433, 1488
>    sig2str/str2sig		-- page 2040
> 
> etc. etc.
> 
> Nevertheless, while this has a certain charm and I don't see
> a disadvantage, I'd like to get Jon's input to this as well.

Okay with other _l _r _s suffixes, not sure about bits, un, or <-> flips?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
