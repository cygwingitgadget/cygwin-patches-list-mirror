Return-Path: <SRS0=D03U=55=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 22F1F3858D1E
	for <cygwin-patches@cygwin.com>; Fri, 21 Nov 2025 06:24:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 22F1F3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 22F1F3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763706268; cv=none;
	b=IPORIz4bg3Nbie5GYrHh6wkcvZiYUjuhnNkSo7GDLNXTdFWTFRTdbKpivtJ+b/YtkXH/pjK/as20LV1ldnudJ3RvKzXbigPMIrYdJfqHJOq8YdqzqfCF3LioNWmElfWEs65X9ZV5/2ztsEY86d3VblNk0qGF8deN5R1gYKQM43g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763706268; c=relaxed/simple;
	bh=fwnstfJ4Y43P/rvN4HdW40qq+sOv8oIL9d2QNQ5eaPw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:DKIM-Signature; b=LXR/dbn9OmFPQMSyCMYOUvvEWS80yZICNPeb809TGtIE+UXoVfsOmZgF6GwO1YuJ+/aK8hWvMYV5873tbbz9IoW/eZrk32rrpfvclbt/oy5DKowGtSj7ph0fgf4qnirhWXCXQQAk3ljUNdQudqNOQBGEDI54bod+NLlWNbyeORc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 22F1F3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=qXGUGSKP
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B12A089661
	for <cygwin-patches@cygwin.com>; Fri, 21 Nov 2025 06:24:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf19.hostedemail.com (Postfix) with ESMTPA id 4B6F420025
	for <cygwin-patches@cygwin.com>; Fri, 21 Nov 2025 06:24:26 +0000 (UTC)
Message-ID: <94bf51fa-5eb8-40a1-b688-89769ee4eef3@SystematicSW.ab.ca>
Date: Thu, 20 Nov 2025 23:24:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add a configure-time check for minimum w32api
 headers version
Content-Language: en-CA
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
References: <20251120144715.4015-1-jon.turney@dronecode.org.uk>
 <aR8xbdiYGjTtY_e7@calimero.vinschen.de>
 <4b87cf9c-b9ad-428c-824f-425716a8a4ad@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <4b87cf9c-b9ad-428c-824f-425716a8a4ad@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 4B6F420025
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 154mw7f5a1hq6un8ntemnepuez6cu9z5
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX190JALDK33JM9qrE67FkKZjhYrMRcWWQg8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:subject:from:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=wmQ8rgU/Xl1ysQ9VJPn7PLJdtiGEUspYufmOK4VSsoc=; b=qXGUGSKPB75CqtfwH9sXUmZIvlUHhcdilkXdDbabifIi6lGW/GJEG+wJCeAi/BiavyVFnuI6kMdZadEIt/6RifhvniqNUrmgSceTgo2vekWVIUuql+oZh4p/nbN/ar6lcOyrGhnNvjLwhA9rUza0VYFojSwH/fvoWxRhxCHZZfO+CGTnGMUFCP7Xaif8VI7QotntrkfSMmNDLmg57531nkK42puDm0OWevR7/rYH4ti5c4yCmqUg8xg1ZQvDOqw69Cl6D3pDnxwDxn1cbTE2yqkqiipT4h58AOZi0eNifAvbhPCZilsmd1AZmhG+Y3uWmct6G7KKWlmiE3Ew8iMQkg==
X-HE-Tag: 1763706266-862760
X-HE-Meta: U2FsdGVkX18+vq4niX5cVHYBXIPTcUuHt/Ta055hp0XrIt5k5MH9/uxAOqTkMOeoB+OA4TAdXEhav0Z7i2STsuG3t1S1LYIpqQGtVZQwyY+fjEoqcivIIAPIYdCCtRJ3Kze0v/CTBLwtMUDVHLECau3Xg2JeZ5VvhT9npxyPrJViA+Ub0Zc2/9qTkIA+bR/kOy0jqEN5bgqj/QIwlOGFKz1H9xWllt3zEjfMHHxIyZhmyZ3qjcSEmFZYAg7FOXKXQF7UxpMaGYR3Hgk/NFOtq58QxY5E8EjIcj9DIs3lUA+hbtsYrEXuhw/AQbdB5/b3Qvfe1lh/o2QflEGQoDieg5iQkptlHLGK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-11-20 16:29, Brian Inglis wrote:
> On 2025-11-20 08:19, Corinna Vinschen wrote:
>> Hi Jon,
>>
>> On Nov 20 14:47, Jon Turney wrote:
>>> Since we now require w32api-headers >= 13 for the
>>> AllocConsoleWithOptions() prototype, add a configure-time check for
>>> that, as I've mused about a couple of times before.
>>>
>>> This maybe gives a more obvious diagnosis of the problem than 'not
>>> declared' errors, and is perhaps more self-documenting about our
>>> expectations here.
>>
>> Good idea.
>>
>>> After this, most of the other conditionals on __MINGW64_VERSION_MAJOR
>>> can probably be removed.
>>
>> Yup.
>>
>>> ---
>>>   winsup/configure.ac | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/winsup/configure.ac b/winsup/configure.ac
>>> index e7ac814b1..4137f93eb 100644
>>> --- a/winsup/configure.ac
>>> +++ b/winsup/configure.ac
>>> @@ -57,6 +57,21 @@ AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
>>>   AC_CHECK_TOOL(STRIP, strip, strip)
>>>   AC_CHECK_TOOL(WINDRES, windres, windres)
>>> +AC_MSG_CHECKING([for required w32api-headers version])
>>> +AC_COMPILE_IFELSE([
>>> +  AC_LANG_SOURCE([[
>>> +    #include <_mingw.h>
>>> +
>>> +    #if __MINGW64_VERSION_MAJOR < 13
>>> +    #error "insufficient w32api-headers version"
>>> +    #endif
>>> + ]])
>>> +],[
>>> +  AC_MSG_RESULT([yes])
>>> +],[
>>> +  AC_MSG_ERROR([no])
>>> +])
>>> +
>>>   AC_ARG_ENABLE(debugging,
>>>   [AS_HELP_STRING([--enable-debugging],[Build a cygwin DLL which has more 
>>> consistency checking for debugging])],
>>>   [case "${enableval}" in
>>
>> One problem here: The error message "no" isn't overly helpful to the
>> unaware developer because it neglects to mention the version requirement.
>> If you just run configure, what you get is this:
>>
>>    checking for required w32api-headers version... configure: error: no
>>
>> Given that this code is checking for the actual version number, to be
>> bumped as we go along, it would be helpful to tell the dev which version
>> is supposed to be installed, isn't it?
> 
> ...in both messages:
> 
>  >> +    #error "w32api-headers version < 13"
> ...
>  >> +  AC_MSG_ERROR([w32api-headers version < 13])
> 

sorry...better in all messages:

 >>> +AC_MSG_CHECKING([for w32api-headers version >= 13])
...
 >>> +    #error "require w32api-headers version >= 13"
...
 >>> +  AC_MSG_ERROR([require w32api-headers version >= 13])
...

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

