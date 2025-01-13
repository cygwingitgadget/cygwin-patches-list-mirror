Return-Path: <SRS0=TxHU=UF=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id 16D713858D21
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 18:57:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 16D713858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 16D713858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736794650; cv=none;
	b=IBfEvL1qh6G+wwDIw2lO6YYbHDZSwoCs0ajJaIYAPfsANUWCXfV2DUF0Q9KD3n7O8MQ2hoGcYPP5cVtEvjasRbXLrCgEg5iI7d63++NyS+VvG8J94WuPJ/ps8I+zkaz908QWZr5TErYQwwl0clbJEkR1AIYJjaQwsVgNxTJ0svo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736794650; c=relaxed/simple;
	bh=qMDPENUjx6qDtp2+A9kfQPX8D7kksT/8Ts5MtgtrbAM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=d6zjKWRWmRwfIWQbg63jpUQGkzzKArleAqt3KQIIXFZLSnWVNx4gFE/mlRGmICSCV7VjCY+ysBXAYjCETkIV4SjfDp6Lj69hSmeubM8/vYZf1GCzdVsZURgXJG2juXlmn9APrtbU9WiKbrK9bYLUHcrPW5XQNcatUcR3ok1Ntvs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 16D713858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=YXRHGQw7
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 876C3120273
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 18:57:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf14.hostedemail.com (Postfix) with ESMTPA id 1E0802F
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 18:57:28 +0000 (UTC)
Message-ID: <4ad1d807-42a9-4506-9588-bc843f655df9@SystematicSW.ab.ca>
Date: Mon, 13 Jan 2025 11:57:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <1a354471c155501dd2d0abfbc195e8be3e9c0fa2.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <5bde1928-7d96-482e-88ac-0cbb081f5a54@dronecode.org.uk>
 <e75a46b8-3f7e-4049-83c1-89a21b00fef1@SystematicSW.ab.ca>
 <Z4UJVxBngAvsxXwX@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z4UJVxBngAvsxXwX@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E0802F
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Stat-Signature: bggixq8xwcoa95ucot9wf84xs4ekn7j5
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19+SLJn2lBe55AOMjGdN5t0pHkqJyCDTwA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=oBwu4eLU8cOc4PWI61v7f7Gz2HrNMe0PP3PwueMSu2A=; b=YXRHGQw70PUV38c5xnVNES0Kb40GmSQghgnUoZOAvWLbMUO++Tw+BA2q61Rv/aVxM1HRWMSBPkDrqlZiDAg6iKBKyICccWQFOml1K5uZU9Dkn67nX0AeEBhX07R5CqDSdfgmHw7jmHlFWkM6eG7ZWH4IeCLo43SSBiiVqI9dwNMxDHcMdTkLFStjE8FLGAfL1Ma+3nFEOyekslh6ZSsU1A4Pm70y6MHsrO/zu6poIhP6JK35bcCgojg3qKBbZCaBE8e5U7SVI2zjLY4//1Go6cUFrGUDGvOGnYDCvnwH4eC63rstHpUXk9YUJdLKVB6bbxjtkk+wergNYXaU/o5e3w==
X-HE-Tag: 1736794648-107142
X-HE-Meta: U2FsdGVkX1+P9oVMOXwC7cfwWdzjeCrRicWac25Ubd5waHMryVlpPV68mzY3LgY1Hi+lZw05JmttUV29hbxEqHPWD3oBWaG9JEsRGauhbn5AQjVujxyzoGXAfBbYoV6dvKHUok91b47OEdUwiIWd4mcvm7HOujlGEebYtW1YMoOLGrR7t2ov7b3O5IKpspjWaKW2nVen2NVg56ZnrtIPL9R/yCz0f0ImyQgDy53dzXAUp+YPO1XhUi66+ol+gXssClTJmRpox1A5z4CG4X1+3Uy/D5xWPfOvtZ22v0jFIv9jds9HzavYuLIugvgf6toNpPgLYBcME8K/y1HvjlZ2tJewre19k6F5AGfEzVRNTn6OU2MMdmQkOcJV/RyRa4War7sx2eVcWEIfyufl880Btg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-13 05:38, Corinna Vinschen wrote:
> On Jan 12 12:56, Brian Inglis wrote:
>> On 2025-01-12 10:58, Jon Turney wrote:
>>> On 11/01/2025 00:01, Brian Inglis wrote:
>>>> Add POSIX new additions available with din entries
>>>> or interfaces in headers and packages.
>>>
>>> What does 'din' mean in this context?
>>
>> POSIX entries which exist as exported symbols in cygwin.din but not
>> mentioned elsewhere in posix.xml, so supported but not yet documented as any
>> Unix interface.
>>
>> Suggestions for better phrasings of these welcome.
> 
> "Add POSIX new additions available as symbols exported from the Cygwin
>   DLL, as header macros and inline functions, or exported from external
>   Cygwin distro libs."

Forgot about making distinction between newlib and Cygwin functions:

Add POSIX new additions available as header macros and inline functions,
or exported by Cygwin distro DLL or library packages?

Mark din entries as Cygwin DLL and others as Cygwin PKG...?

>> getentropy (3)       - fill a buffer with random bytes
>> getlocalename_l:	nothing appropriate.
>> in6addr_any:		nothing appropriate.
>> in6addr_loopback:    nothing appropriate.
>> posix_getdents:	nothing appropriate.
>> timespec_get:	nothing appropriate.
>>
>> Also is anyone aware of a good html to man page converter to generate Cygwin
>> or POSIX man pages from HTML sources available, and are cpp-reference GPL-3
>> allowed, or should we prefix the function source with the man doc and
>> generate it in newlib?
> 
> What man pages are you looking for?  We have the man-pages-posix package
> and we only have it because we have the official permission to do so.
> Keep in mind that all man pages not part of the newlib-cygwin dir are
> potentially copyrighted.

Latter four above - Cygwin only: very aware of sources and permissions.

Also aware that Austin Group want to keep nroff sources from being distributed 
and linux-man maintainer is inactive but participating.

Only getentropy_r is documented in:

	/usr/src/newlib-cygwin/newlib/libc/reent/getentropyr.c

and it is in CHEW files in:

	/usr/src/newlib-cygwin/newlib/libc/reent/Makefile.inc

but not included in list of functions in:

	/usr/src/newlib-cygwin/newlib/libc/reent/reent.tex

and nor are any of the CHEW outputs in libc.info?

>> Looks like getlocalename_l doc needs updated to POSIX.1-2024, added to
>> locale/Makefile.inc LIBC_CHEWOUT_FILES
> 
> Thanks, done.
> 
>> and locale.h feature test to
>> 202405L?
> 
> That's already fixed since ca31784fef301 ("Fix POSIX guards for
> POSIX.1-2024 extensions")
> 
>> Could CHEW doc be added to cygwin/**/*.cc or elsewhere?
> 
> Elsewhere, yes.  Inline might be a problem.  Newlib has only very few
> exported symbols per file, so a single file usually matches with a
> single doc.  I don't want to imagine adding docs inline to syscalls.cc :}

The latter are only relevant to Cygwin and could be added to each .cc file if 
they could be CHEWed and combined, or in doc only CHEW inputs elsewhere?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
