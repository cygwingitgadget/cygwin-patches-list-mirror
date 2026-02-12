Return-Path: <SRS0=xiqo=AQ=systematicsw.ab.ca=brian.inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id 17AF54BA23D6
	for <cygwin-patches@cygwin.com>; Thu, 12 Feb 2026 23:15:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 17AF54BA23D6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=systematicsw.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=systematicsw.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 17AF54BA23D6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1770938125; cv=none;
	b=Ob29e9gicEA/ieMHpIfTPmL5RRnpifFAiiBKKwFFgLTzP0phHK/uTQno14P2AeC8Earz4p7uqXwgejN8lTF338qA7wFA18w6Hvw2c7ts4BAq4Ju9ygEaSWnFjZyT4u/49byGqUfgoUVCVgAooaVOWDG7WJMUkWu6u7ick90k/2E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770938125; c=relaxed/simple;
	bh=guJfJ12m/eTyLQEL3TIxO3EO2wVnAvHTOs3YYjlYYE4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=HfocohycLkq7OqNRZ5k1EglIsCiUz9zXzBWlZ3q+EvYjZ0eJi6ri6TD+cE9Vuw5Kfor36A4BH/xzpgrDTWGvCX12DTwz6WKdOXnQTs0meGHFTTiSYcpgfjlV8/PVHA8e7Yt6k2IbyGBavxgGnQW+osjipboKhh5U2H8s9mkk9n8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 17AF54BA23D6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.a=rsa-sha256 header.s=he header.b=nASk0cFP
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 94503B80B0
	for <cygwin-patches@cygwin.com>; Thu, 12 Feb 2026 23:15:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf02.hostedemail.com (Postfix) with ESMTPA id 0A66380011
	for <cygwin-patches@cygwin.com>; Thu, 12 Feb 2026 23:15:22 +0000 (UTC)
Message-ID: <f00e706c-ddbb-4a7b-b6f9-b8caa24e59f9@systematicsw.ab.ca>
Date: Thu, 12 Feb 2026 16:15:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: brian.inglis@systematicsw.ab.ca
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: cpuid: add AArch64 build stubs
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <MA0P287MB30827D0112702D609C0D688A9F64A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aY45yWYgGCvq5fhg@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <aY45yWYgGCvq5fhg@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: m7u9w7ywpirkr8mn8hdmepe11qrfp14a
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0A66380011
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX183exLRrPG8FNGLyk9YPU2P31qLa+lTBRI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systematicsw.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=cf778xyxISVAtMJr34zJrG64UZhAiF0JQLEOKj2wJlQ=; b=nASk0cFPc6B73jzS7fKzlisdt4yV5K7AluS/gBevCjQGdVFMVqwneiBIurgau9ENF6QWvZVbNpm1LI7nCAeuLnc/dycCO59lMhzceGumw2/qgfhy5wIJFkOi5itf/zwA/IOGTUEcbhiKyL+0knpKbGMb2ZNxsBywseN0GDmqvd/EWx6RbwaPRJJ8VZyh0zOBw8JrovJ+aaPFmipfTN47Xhuaf+UXxaYwoax8cFolZQmL8fwbCdKQhaTnkFIuh2Z9VcyVaZ1zjBWivfpWT0ZHlX4vVolufnf4RvWU6xRBxnDn1VlW5aZ5YCjqmVt6cgGPVjsgOWwKAlQn/aFw7QR/3A==
X-HE-Tag: 1770938122-196198
X-HE-Meta: U2FsdGVkX19ZKKbEXZrA9MxUb09Xt8Mvcuj7tJgZmVFVU3TWKILvFVQLx070xSD+ItZqjJRQnzVG0uZsDPy6tiCdMvk1C4XF92/AnS0Aa7X7oNEtyNYaJQMbXgaK6/ehYzEN9nJSgGaKiWthNwPzfsynvwweZrhv0j4szKo7ymu63enW/adpVIzGHN7DeV9U9MJAjA0Jf6EXuNg4TpIsosECZcKB/jtUkJwRqQDNzejnDO64fCK1whdhFWBR/1vXHMYQjkGdkY9w37u/41EEYwRPVfN/j/Txm5aeTXTOdHBmk4ot1FbsYvZboQY8rWJigLul6VyYnH3B36lngdEpST76oE9fkTtOe/RYXF6wrcUDpspI0q6ivlAi+rUMoVUNMPRRw3kQK7cjUsnwmVW0HXqF4/WecsKFvz4m5qplf6GLFC/NK+DTiNeT52OAeNSvQD/gJjvKMcyIgaQ+3seS9lkiVD5cOZmGVPZmRStXSkg8LREsou0vBh0TqVUDjIqD
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi folks,

Totally agree this adds little to the distro, other than dummy stubs.

Should we be adding arch ifdefs in existing stable files, or should we instead 
add arch directories to the tree to handle completely different approaches in 
RISC ISAs?

Were this newlib, we may be able to rely on EL1 access to feature instructions 
and registers, but it appears Linux exposes them via HWCAPs, ELF getauxval 
AT_HWCAP/2 and sysfs, so on Windows, we may have to rely on possibly different 
APIs and registry entries.

Some Windows porting issues:

	https://www.janeasystems.com/blog/porting-software-arm64

and some internals info:

	https://connormcgarr.github.io/arm64-windows-internals-basics/

Some arch info is documented in:

	$ info gcc aarch64

WoA dev info is not easily discoverable on the web flooded with marketing bumph!


On 2026-02-12 13:36, Corinna Vinschen wrote:
> Hi Thirumalai,
> 
> in terms of all three patches you sent on Feb 8, I wonder if this is
> the right thing to do.  I know you just want to get it built, but
> doesn't this open up a can of worms?  How easy will it be to miss
> one of these places where the compiler warning doesn't occur anymore.
> 
> Wouldn't it be better to wait until you can fill these places with
> actual code, even if it's a bit harder in the interim?
> 
> 
> Thanks,
> Corinna
> 
> 
> On Feb  8 19:30, Thirumalai Nagalingam wrote:
>> Hi,
>>
>> This patch adds minimal AArch64 stubs to winsup/cygwin/local_includes/cpuid.h
>> to allow the header to compile for the Cygwin AArch64 target.
>>
>>
>>    *
>> Conditional handling for aarch64 is added alongside the existing x86_64 code.
>>    *
>> The cpuid() helper returns zeroed values, and can_set_flag()
>> is stubbed out for AArch64.
>>    *
>> No functional CPU feature detection is implemented.
>>    *
>> The change is intended solely to unblock the AArch64 build and will require
>> proper architecture-specific implementations in a follow-up patch.
>>
>> Thanks & regards
>> Thirumalai Nagalingam
>>
>> In-lined patch:
>>
>> diff --git a/winsup/cygwin/local_includes/cpuid.h b/winsup/cygwin/local_includes/cpuid.h
>> index 6dbb1bddf..238c88777 100644
>> --- a/winsup/cygwin/local_includes/cpuid.h
>> +++ b/winsup/cygwin/local_includes/cpuid.h
>> @@ -13,17 +13,23 @@ static inline void __attribute ((always_inline))
>>   cpuid (uint32_t *a, uint32_t *b, uint32_t *c, uint32_t *d, uint32_t ain,
>>          uint32_t cin = 0)
>>   {
>> +#if defined(__x86_64__)
>>     asm volatile ("cpuid"
>>                  : "=a" (*a), "=b" (*b), "=c" (*c), "=d" (*d)
>>                  : "a" (ain), "c" (cin));
>> +#elif defined(__aarch64__)
>> +  // TODO
>> +  *a = *b = *c = *d = 0;
>> +#endif
>>   }
>>
>> -#ifdef __x86_64__
>> +#if defined(__x86_64__) || defined(__aarch64__)
>>   static inline bool __attribute ((always_inline))
>>   can_set_flag (uint32_t long flag)
>>   {
>>     uint32_t long r1, r2;
>>
>> +#if defined(__x86_64__)
>>     asm volatile ("pushfq\n"
>>                  "popq %0\n"
>>                  "movq %0, %1\n"
>> @@ -37,6 +43,9 @@ can_set_flag (uint32_t long flag)
>>                  : "=&r" (r1), "=&r" (r2)
>>                  : "ir" (flag)
>>     );
>> +#elif defined(__aarch64__)
>> +  // TODO
>> +#endif
>>     return ((r1 ^ r2) & flag) != 0;
>>   }
>>   #else
>> --
-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
