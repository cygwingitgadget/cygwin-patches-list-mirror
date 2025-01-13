Return-Path: <SRS0=TxHU=UF=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id BB5CD3858D21
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 18:02:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BB5CD3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BB5CD3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736791321; cv=none;
	b=Qp73jubZznvIzo5ntr0FbTfvDnkhrVyafb0c6vhUuGh/5juQUfb1b7Z0RFPeoWJro3qEFz1+NLHijjAY2M9aoYuFeWUCPbxiLnu4iPf25kTLnBsIYTMqEc+OnocUUuuAkjtKsMD1eiI1raEei+M2Nclvv0bCNJA15dUtP30uImA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736791321; c=relaxed/simple;
	bh=361XYGTY0jpv03dL2z5mwsYuWoSQv2mjm3E1XrlA87M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=u2Ku/JirZylHnRBLq6o0Qs1t3BCoJ3dRCjqj88c0Syqlwyj6lGjEkaj/vxAdfE+07RMdCCzBayJWwltCB0LJtokcJt1E1Cx62EHx0sP7xkv9g8YxnyhJg0dGmPc8JOsnbzUuz0YUA55lS4sUkKAuxCcmpB1dyXNOgCioV9bPne4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BB5CD3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=CD1kqIDg
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 7199842B07
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 18:02:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf05.hostedemail.com (Postfix) with ESMTPA id F1DE22001B
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 18:01:59 +0000 (UTC)
Message-ID: <ba870968-a3ce-4732-8276-7dabd7a167b2@SystematicSW.ab.ca>
Date: Mon, 13 Jan 2025 11:01:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <b02f73ea85c1a9e6cd1a7ebc116fde12f5f6ccc4.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4UN78IouepuUwme@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z4UN78IouepuUwme@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1DE22001B
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: 3ftqog8eajdggmggoc4iqt3kfz4iftwr
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18D4Y3Fo8mwg/XYN9Wl6KmQwt68UTjkxo0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=qI8JQJRIdu7j6lNX1/e+pkBIxLK2ezFAyp8Aj5vxRdI=; b=CD1kqIDgS5XT9UMs9rOqdAoLvsacI82eWU3fvfjaaU2sVZinLUKV/25GrmSkcCQStc81x0thZEG/CSmencZILkGx0IcluyxCsesWL3MCTJvvAGdYCZqPrj9WdaeifecaM4dsL17ucnENpMZbIUdw+LSqSpEtJB+Qxx/GNJKpuKL/pAWm/Z92Y/JqP7ECda671u/9QFnWD4iQycbkJzh1evYy3EwdQ0u2VG20q/UKu91ClL9NXgfVLbnqPoIsLn6D6BjzSQ9Zk+rQmvjsGWJXs/87za6cbKSXs10S6Jby6fs7bblAEIk0mzv31qiUxYUEwkJj2gJXq/SMdYRvImxO2g==
X-HE-Tag: 1736791319-813274
X-HE-Meta: U2FsdGVkX18gaFRIM0YS3xUlfN42NgDnKJuBt2s5H5BY16t7JOrKgVK9uyCdJjRp64XbIfM6F7tGWqDZ2ZDy6Bv9CBbmwzAsZTu5QwY27t9ybapR0PozBuM3/ndigGj8Kdh3wNoZCD/gul7aF3wHvOodzxAMbScCZ2h0WJLx9wFHdtLYtIv/wX527sB/5zU0o5Pp/NrJ6ohe6TsOHmOa/lyDFinPCT+Ph108Rwjb4krf+mPwhkgvhfq3UOK1kfk3k4vh+MDPVsMBPISRJSr7h0D8y0DAAizrqAAh3LyA6z1bqvXlw0LMD/yLjf9wPKlh+YxojJZy+P0qLE9rPOrzP62gz8bGBO7uLAOIcQOQjYbLzZpZosE8BWc+IUqqZcq58NIDAgwUde0SyF+XRAGxYg+O9SlU7urCsxeYf+ivVPlNntLL+oaE7yQbTSwQpuMjk1YoH9YQJ/Z6elBNJBL+4NyUurW3bWR0mNv3yURB3vjOWpsWia+I/r+tyZKtl2ACk2pO4JvwF3siUdsKVgmwBQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-13 05:58, Corinna Vinschen wrote:
> On Jan 10 17:01, Brian Inglis wrote:
>> Add unavailable POSIX additions to Not Implemented section,
>> with mentions of headers and packages where they are expected.
>>
>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> ---
>>   winsup/doc/posix.xml | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
>> index 17c9ebf6f73f..2e14861802bf 100644
>> --- a/winsup/doc/posix.xml
>> +++ b/winsup/doc/posix.xml
>> @@ -1678,9 +1678,17 @@ ISO/IEC DIS 9945 Information technology
>>   
>>   </sect1>
>>   
>> -<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
>> +<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
>>   
>>   <screen>
>> +    CMPLX			(not available in "complex.h" header)
>> +    CMPLXF			(not available in "complex.h" header)
>> +    CMPLXL			(not available in "complex.h" header)
> 
> Erm... did you have a look into newlib/libc/include/complex.h?

I only looked at build include definition dump from Cygwin gcc 12,
which does not include this, only:

. /usr/include/complex.h
.. /usr/include/sys/cdefs.h
... /usr/include/machine/_default_types.h
.... /usr/include/sys/features.h
..... /usr/include/_newlib_version.h
... /usr/lib/gcc/x86_64-pc-cygwin/12/include/stddef.h

That file was updated last July and in August cygwin-devel 3.5.4 should have 
included it, but that commit is not in that log, nor 3.5.5, or 
cygwin-3_5-branch, but is under main and in 3.6.0 tars:

https://cygwin.com/git?p=newlib-cygwin.git;a=commit;f=newlib/libc/include/complex.h;h=a5ffae14

$ curl 
https://mirror.cpsc.ucalgary.ca/mirror/cygwin.com/x86_64/release/cygwin/cygwin-devel/cygwin-devel-3.5.5-1.tar.xz 
| tar -xJOf - usr/include/complex.h | grep CMPLX; echo $?
1

$ curl 
https://mirror.cpsc.ucalgary.ca/mirror/cygwin.com/x86_64/release/cygwin/cygwin-devel/cygwin-devel-3.6.0-0.278.g376fe1dab177.tar.xz 
| tar -xJOf - usr/include/complex.h | grep CMPLX ; echo $?
#define	CMPLX(x, y)	((double complex){ x, y })
#define	CMPLXF(x, y)	((float complex){ x, y })
#define	CMPLXL(x, y)	((long double complex){ x, y })
#define	CMPLX(x, y)	__builtin_complex((double)(x), (double)(y))
#define	CMPLXF(x, y)	__builtin_complex((float)(x), (float)(y))
#define	CMPLXL(x, y)	__builtin_complex((long double)(x), (long double)(y))
0

> Also, don't add the "(not available ..." stuff if the API is supposed to
> be implemented and exported by newlib/Cygwin.
> 
>> +    dcgettext_l			(not available in external gettext "libintl" library)
>> +    dcngettext_l		(not available in external gettext "libintl" library)
>> +    dgettext_l			(not available in external gettext "libintl" library)
>> +    dngettext_l			(not available in external gettext "libintl" library)
> 
> ...so in case of these libintl functions, it's ok, of course.
> 
>> +    kill_dependency		(not available in "stdatomic.h" header)
> 
> This is in /usr/lib/gcc/x86_64-pc-cygwin/12/include/c++/bits/atomic_base.h

But not in a standard Cygwin gcc 12 build which uses:

$ grep -A2 kill_ /usr/lib/gcc/x86_64-pc-cygwin/12/include/stdatomic.h
#define kill_dependency(Y)			\
   __extension__					\
   ({						\
     __auto_type __kill_dependency_tmp = (Y);	\
     __kill_dependency_tmp;			\
   })

and I missed checking earlier and qualifies? :^<

Should I change those comments to "available in" and qualify stdatomic.h with 
GCC or lib/gcc?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
