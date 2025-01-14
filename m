Return-Path: <SRS0=sRnL=UG=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 0877C385C6C2
	for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2025 23:44:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0877C385C6C2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0877C385C6C2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736898263; cv=none;
	b=Z+NXpviTU6mmi4Ttb4G+wQZ0QUbiMTHaBMWxtm+rm1jTBgscTbmZFGR9l0fCcvWKRZHuDyRGujf02cVfKbCMKSwx+2H5OLh5AbcwSsPhpMhmrKEs57ZMnS9ZTeOVVofwq/hEpwqKepWIsAS3pG2dwZFO9tHLdpwlKzMltUorUXU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736898263; c=relaxed/simple;
	bh=24+u6X7vZRaE9lExsV5uUk0MnMG6LMXFG7YOzhDIUfA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:DKIM-Signature; b=SpRb7h0ejECGE9cmj4kdtGUIjEsbp0izPjXwP8U8+NisqCxPiYBVuj7NUCRpDLD0ULO3ET/2/7jAiTO5EYaZ51QOjN6dxd2bUnKrp0oONYygSzbO1TR5bN9sv1CNghgi5EzcMkiz+zB96G0J0wgu5IT8lLW+o+KtvfAMftYFbtk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0877C385C6C2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=dDrlQsnX
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 7F37943C57
	for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2025 23:44:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf04.hostedemail.com (Postfix) with ESMTPA id 0A35320027
	for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2025 23:44:20 +0000 (UTC)
Message-ID: <6e984ebd-7f38-4a44-bf2f-0986d5a49ef7@SystematicSW.ab.ca>
Date: Tue, 14 Jan 2025 16:44:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <b02f73ea85c1a9e6cd1a7ebc116fde12f5f6ccc4.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4UN78IouepuUwme@calimero.vinschen.de>
 <ba870968-a3ce-4732-8276-7dabd7a167b2@SystematicSW.ab.ca>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <ba870968-a3ce-4732-8276-7dabd7a167b2@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A35320027
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: kbxeg7bxx6m6cggbmipzu8h5am41x1cx
X-Rspamd-Server: rspamout02
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX184NOBWUZGWpJwYfWSsEd4t5xRsTZTqyK0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:subject:from:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=+PtzHxr/7keub7iYrqUQNIGS+Sz4LKH9sZODJlZ7p88=; b=dDrlQsnXmwxz3D7X6GMeFG9eo0SbQljzJzrA7F44d3qPohSb9occjEzSTDbuJW4coqL8ZjLljOmdTDQT/r5GHN5i91Wbd82FLHa2QAACZ0G3bxxM2yv+evpGbCYeJPJijJTztLz0ol1ldc9xp7Sf2YfsOWwIrQskHNxSdxIYK1c4ofVjCh7g+L11va+RHF9RUWTNjZRkWQ8Bpw4AfmLJuRN28HF4cH8mdQZgewUIDQMRxYmKcANBt6V61ck3CdJ+HyspLlaoO9rAbEnEi0QkK+TibQLqKUNxdWdM3Q68daP7RDwIONZ2qgdl4Ura3/U7Yp7/8+62SuAS2gfF1FgiJQ==
X-HE-Tag: 1736898260-231896
X-HE-Meta: U2FsdGVkX1+CiEaQCz1Y9is2cKrEvcvRx0hibQZ0NCsvK1XWO8dK4MJVocuuuIY5TJnso+KCDvQUy3bsHuGRusQnJoGqa5Yd9WTDa/48o10bucvgViGXGPowtgQ5utTj6L0t+gDZRq7Xv9cdMOcDGuOxDMelfnzJ87wy6iIR5BZUEq0xJFKBbEil46YkVqwJ5gyrLsz/kQs40LOKlZ5dNBi3Tr3yoB7/eOWxEq6A8qs60wZbxHMOU+waIvyhpsV7H7PvlqBrR4CPmdEy381uyvs5pyAuY6SLRUmK2bk6OcnnDVOCSvmF2UeO/C9EIGJW5NDvYohBYFwSYF9dRMPoaUdl7IURe/FvONJdBqSf+9ADUM3czgng4d9HSoipZtSvGB3lxzJcMDymulwjHcLC5pPhegp88MwBIcEYq2hrOKhocDcCT73vwJ4v4RaftBwciehB5cfBJwiHAgvreNsGh/DAjy55B85FObXYJTN1y0DSXJts/BsG1ZpwpTBlcMH0U2HLySo9QePIrOSHhD5Ozg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-13 11:01, Brian Inglis wrote:
> On 2025-01-13 05:58, Corinna Vinschen wrote:
>> On Jan 10 17:01, Brian Inglis wrote:
>>> Add unavailable POSIX additions to Not Implemented section,
>>> with mentions of headers and packages where they are expected.
>>>
>>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>>> ---
>>>   winsup/doc/posix.xml | 24 ++++++++++++++++++++++--
>>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
>>> index 17c9ebf6f73f..2e14861802bf 100644
>>> --- a/winsup/doc/posix.xml
>>> +++ b/winsup/doc/posix.xml
>>> @@ -1678,9 +1678,17 @@ ISO/IEC DIS 9945 Information technology
>>>   </sect1>
>>> -<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the 
>>> Single Unix Specification, Volume 7:</title>
>>> +<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the 
>>> Single UNIX® Specification Version 5:</title>
>>>   <screen>
>>> +    CMPLX            (not available in "complex.h" header)
>>> +    CMPLXF            (not available in "complex.h" header)
>>> +    CMPLXL            (not available in "complex.h" header)
>>
>> Erm... did you have a look into newlib/libc/include/complex.h?
> 
> I only looked at build include definition dump from Cygwin gcc 12,
> which does not include this, only:
> 
> . /usr/include/complex.h
> .. /usr/include/sys/cdefs.h
> ... /usr/include/machine/_default_types.h
> .... /usr/include/sys/features.h
> ..... /usr/include/_newlib_version.h
> ... /usr/lib/gcc/x86_64-pc-cygwin/12/include/stddef.h
> 
> That file was updated last July and in August cygwin-devel 3.5.4 should have 
> included it, but that commit is not in that log, nor 3.5.5, or cygwin-3_5- 
> branch, but is under main and in 3.6.0 tars:
> 
> https://cygwin.com/git?p=newlib-cygwin.git;a=commit;f=newlib/libc/include/ 
> complex.h;h=a5ffae14
> 
> $ curl https://mirror.cpsc.ucalgary.ca/mirror/cygwin.com/x86_64/release/cygwin/ 
> cygwin-devel/cygwin-devel-3.5.5-1.tar.xz | tar -xJOf - usr/include/complex.h | 
> grep CMPLX; echo $?
> 1
> 
> $ curl https://mirror.cpsc.ucalgary.ca/mirror/cygwin.com/x86_64/release/cygwin/ 
> cygwin-devel/cygwin-devel-3.6.0-0.278.g376fe1dab177.tar.xz | tar -xJOf - usr/ 
> include/complex.h | grep CMPLX ; echo $?
> #define    CMPLX(x, y)    ((double complex){ x, y })
> #define    CMPLXF(x, y)    ((float complex){ x, y })
> #define    CMPLXL(x, y)    ((long double complex){ x, y })
> #define    CMPLX(x, y)    __builtin_complex((double)(x), (double)(y))
> #define    CMPLXF(x, y)    __builtin_complex((float)(x), (float)(y))
> #define    CMPLXL(x, y)    __builtin_complex((long double)(x), (long double)(y))
> 0
> 
>> Also, don't add the "(not available ..." stuff if the API is supposed to
>> be implemented and exported by newlib/Cygwin.
>>
>>> +    dcgettext_l            (not available in external gettext "libintl" 
>>> library)
>>> +    dcngettext_l        (not available in external gettext "libintl" library)
>>> +    dgettext_l            (not available in external gettext "libintl" library)
>>> +    dngettext_l            (not available in external gettext "libintl" 
>>> library)
>>
>> ...so in case of these libintl functions, it's ok, of course.
>>
>>> +    kill_dependency        (not available in "stdatomic.h" header)
>>
>> This is in /usr/lib/gcc/x86_64-pc-cygwin/12/include/c++/bits/atomic_base.h
> 
> But not in a standard Cygwin gcc 12 build which uses:
> 
> $ grep -A2 kill_ /usr/lib/gcc/x86_64-pc-cygwin/12/include/stdatomic.h
> #define kill_dependency(Y)            \
>    __extension__                    \
>    ({                        \
>      __auto_type __kill_dependency_tmp = (Y);    \
>      __kill_dependency_tmp;            \
>    })
> 
> and I missed checking earlier and qualifies? :^<
> 
> Should I change those comments to "available in" and qualify stdatomic.h with 
> GCC or lib/gcc?

Looking at the end/get/set...ent groups, endhostent and sethostent are 
implemented and gethostent is not implemented - should we keep them separate or 
combine in one section?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

