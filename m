Return-Path: <SRS0=5eq4=54=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id 4A20E3858C24
	for <cygwin-patches@cygwin.com>; Thu, 20 Nov 2025 23:30:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A20E3858C24
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A20E3858C24
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763681400; cv=none;
	b=DgRTAjEji2EMDTkD+aQSzNeFzBj/9/EOedTrJ+5UnvBl94v9e5KNbLrHkFcP537NWacQTqhM+kRzvxLWMWgDTHO8xvSqUsDRFTgdCqMmBWz8bij9qVXuZtruz7GuWXCjnXtG5Vnw9l3JXAsjP2FCY8piBZTLlkJwshYsioE3ITQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763681400; c=relaxed/simple;
	bh=9PSz1IkDXihXdMPUoTkRKU5vMtpFCKB69KinjsVd4Dw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=sBegQRpn8ZGX6pJPIj2Mf7271wZzl9szFEwZNvZVuHYRx4jAkgEKHbzVtbnLm9iCK3gRCX2at3NkBoNVw+hgW0LvlenAv4EvR0JDTF+XDIY7z8WsQEK6jlvlHCvvD23w69iTaCeVf3oooyXvSVxSAXYI8o4bnlhwlZsS7W3v/jU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A20E3858C24
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=NM01z8g3
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B104DB947F
	for <cygwin-patches@cygwin.com>; Thu, 20 Nov 2025 23:29:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 493602002E
	for <cygwin-patches@cygwin.com>; Thu, 20 Nov 2025 23:29:55 +0000 (UTC)
Message-ID: <4b87cf9c-b9ad-428c-824f-425716a8a4ad@SystematicSW.ab.ca>
Date: Thu, 20 Nov 2025 16:29:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add a configure-time check for minimum w32api
 headers version
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20251120144715.4015-1-jon.turney@dronecode.org.uk>
 <aR8xbdiYGjTtY_e7@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <aR8xbdiYGjTtY_e7@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: q1qpxosdhhdk7rc7qch7jjbr687geqxg
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 493602002E
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18lO7oTli3MsVyNVuRQh8Mkd6/zmx6esGg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=hOR2MJL9ipC+wckeD9nMoxl3eIBoJKJmbTAjLw3DPFw=; b=NM01z8g34tpbgcexZXLcYzBSPgcJXpI1wPZIFVd36m4FC2f70KzT2dehW0+tUakgMuuIrP7xOWhz4aH3f8VaW0vAlL5hF/LTekX45fW2wUdgQ7ZPjVoXswqkQiNO/hgG2qw8HkKSrg4ZzSsmzNKAQ2akU4PC1du3BEuqNhMuSLCz4EmsLckqTZ3HkXkf4SJPMSZToj83a8uPS2U+C4UCFPX9RlaUX4uDyhfbp9m5gS8wKKqteSMty/L/uzyjkrV8pt09lqQ2j6ZDIO1VcdSzfNiN8TqrsrpDKHQET1udMAX7eIUMi8KkyRPfO6J2V1xR7vYrPPND6PLUlHivpkQuGw==
X-HE-Tag: 1763681395-641910
X-HE-Meta: U2FsdGVkX1+UK0n+WakXyppwzbuQAQzBIUXeRnxCzP3fgsc1K03p8cS1oVAnEYiCaMN4Xe4ftAuSLYf7n6FL1vurbjAWIzLJxs6zlh5eGUvq/ol7AJE9zgkWrg4qbQZK6r1OCEg/5alDFIIVOkob7Q26lax40gRj0Rj3UoLNEFlgUkYk6x4BKr0ek536blNvYBy3XHLpbMiy8ta3P1OSMhn3NAF98VPhQfJmrTHvmtBGCOtZh5WCLJPETofLmly5waD6+067QHMH8Rn1HVeVS25QMxru+adWL0EaW0qCZsrz8BN9nvjUWMHqtOMt7JwGoLXQXdde24Ztr5aBohaAllpOzUVhI7J9
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-11-20 08:19, Corinna Vinschen wrote:
> Hi Jon,
> 
> On Nov 20 14:47, Jon Turney wrote:
>> Since we now require w32api-headers >= 13 for the
>> AllocConsoleWithOptions() prototype, add a configure-time check for
>> that, as I've mused about a couple of times before.
>>
>> This maybe gives a more obvious diagnosis of the problem than 'not
>> declared' errors, and is perhaps more self-documenting about our
>> expectations here.
> 
> Good idea.
> 
>> After this, most of the other conditionals on __MINGW64_VERSION_MAJOR
>> can probably be removed.
> 
> Yup.
> 
>> ---
>>   winsup/configure.ac | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/winsup/configure.ac b/winsup/configure.ac
>> index e7ac814b1..4137f93eb 100644
>> --- a/winsup/configure.ac
>> +++ b/winsup/configure.ac
>> @@ -57,6 +57,21 @@ AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
>>   AC_CHECK_TOOL(STRIP, strip, strip)
>>   AC_CHECK_TOOL(WINDRES, windres, windres)
>>   
>> +AC_MSG_CHECKING([for required w32api-headers version])
>> +AC_COMPILE_IFELSE([
>> +  AC_LANG_SOURCE([[
>> +    #include <_mingw.h>
>> +
>> +    #if __MINGW64_VERSION_MAJOR < 13
>> +    #error "insufficient w32api-headers version"
>> +    #endif
>> + ]])
>> +],[
>> +  AC_MSG_RESULT([yes])
>> +],[
>> +  AC_MSG_ERROR([no])
>> +])
>> +
>>   AC_ARG_ENABLE(debugging,
>>   [AS_HELP_STRING([--enable-debugging],[Build a cygwin DLL which has more consistency checking for debugging])],
>>   [case "${enableval}" in
> 
> One problem here: The error message "no" isn't overly helpful to the
> unaware developer because it neglects to mention the version requirement.
> If you just run configure, what you get is this:
> 
>    checking for required w32api-headers version... configure: error: no
> 
> Given that this code is checking for the actual version number, to be
> bumped as we go along, it would be helpful to tell the dev which version
> is supposed to be installed, isn't it?

...in both messages:

 >> +    #error "w32api-headers version < 13"
...
 >> +  AC_MSG_ERROR([w32api-headers version < 13])

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
