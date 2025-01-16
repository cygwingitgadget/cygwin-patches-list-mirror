Return-Path: <SRS0=CW6W=UI=systematicsw.ab.ca=brian.inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id 5528A384AB77
	for <cygwin-patches@cygwin.com>; Thu, 16 Jan 2025 22:54:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5528A384AB77
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=systematicsw.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=systematicsw.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5528A384AB77
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737068080; cv=none;
	b=b/dj0Ci6ejzx4v4ZdR4HW8q2KTbyXDd8Whq882pd8UuerM1l/C6Mk9oijE4cHWVoWPUU9hgOo1pzRzM2FDH1jEFaNAP0cMOIdiCms16WQCm/t9djiW+FcExHPMSODNuCkBbgugkSoBt3+l+pkA7kd73abKCShEpr2B6wI83sQqU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737068080; c=relaxed/simple;
	bh=BFfZ5LdWfcvqa2SkkbVBK7b5KnJuL5LCM0tEJkAr/UU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=YUU4YhWvUsrh0ALfmktEiyQdu8Xv8CsKxVFlQqJH1Mc2CIMJbpVo1eiZxfeJX9DVyvbq/l3bUTVcvulC7xFMzRNF6qew7OrBN25rMn4VVQ12coNT+YTnf4LyK83fAXGD7zhbeA7nt4dEzu1oYDI0XgEODeMHhZ1OBlQtO2iDpF0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5528A384AB77
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.a=rsa-sha256 header.s=he header.b=pfLG82M2
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id E02ADC1368
	for <cygwin-patches@cygwin.com>; Thu, 16 Jan 2025 22:54:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf08.hostedemail.com (Postfix) with ESMTPA id 7F92F20025
	for <cygwin-patches@cygwin.com>; Thu, 16 Jan 2025 22:54:38 +0000 (UTC)
Message-ID: <ffca5f19-325a-4c83-bd41-1deb313c279e@systematicsw.ab.ca>
Date: Thu, 16 Jan 2025 15:54:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: brian.inglis@systematicsw.ab.ca
Reply-To: Brian.Inglis@SystematicSW.ab.ca
Subject: Re: [PATCH v6 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <a216df577267a5e8b61b220969da57691f6a341f.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4lS5SKVFB4FdcLq@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z4lS5SKVFB4FdcLq@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 7F92F20025
X-Stat-Signature: fqdbmfrnqmkg191bjd1uqj847pzhuj9g
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+q4LSZ4hWQkN43HcsZ5wCyljliVEfRAoE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systematicsw.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=6pwEacGD7tiYeOBuXEKiFVOekFr5GEWgTVjGLMjCsLE=; b=pfLG82M2393yRh37fCQ18HmVBmPeC2zZbUegrMcOEJTa++XEAta+Cpz51mxHdF4CfbN/KEAjs9Qyzo3KkGZGV+rXPhC7qGEbnw6tT5rANapeuLSu0Pzz/KQsVzX2agA6Tcs1G/VPcou35aSHHUyHp12jkrEpdfLPNdb9y1OWOG4+ijHO/q7ujg/QdW4qlee/+WCLG2cWLcye8jzGoj4SjpQCyj2L43Phc069gzCUID99x0H9jhGXSb3kiUFwjvXXTn2R8FMdQ7F7qE8BAiimMTiWPGU+/9VvaSEba/oGkGJ3A8WhJ5OeFhby0GGs0cA763kpjKYLqNR6IEcrtslqRg==
X-HE-Tag: 1737068078-160111
X-HE-Meta: U2FsdGVkX18nyMA7q8xu77qOJuykWk4fJuXuVFNuzwz/MEIgVZ1EJuy3eBzY9f3oWGrKXTUSNkGMmTh4ZhRI7iWuIUjaatAB6N2kpemGmBQxsi5bK+ecLnbYEnHp8hc2zvl76bJitB6d/ASnsisbS5e7SZTU0cGQ3LkZmV/EUS13dd/c3q2pxXy/mO5Nmt/+bYc4NN4OwQqadoF/1+pOZs0PChquElFmNkrRZWun9tprwfi7CON1xmGkecb8x5ROeLFmwgG3QpUaDUJNl1aX4/CwQIKs8kPchEKktJc2jh+nmVpJ9omTaKEhme6oV8cBj8vr/+qmVQ8UhTHO6PAFCW+iUpyRXLBv5Vx8dxoNWb8p66ECNqlSjQhZ7SEVYSQkqDqRqC7MnVMeRuUDsoDxug==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-16 11:41, Corinna Vinschen wrote:
> On Jan 15 12:39, Brian Inglis wrote:
>> Add unavailable POSIX additions to Not Implemented section,
>> with mentions of headers and packages where they are expected.
>>
>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> ---
>>   winsup/doc/posix.xml | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
>> index 0b23a2251028..89728e050bef 100644
>> --- a/winsup/doc/posix.xml
>> +++ b/winsup/doc/posix.xml
>> @@ -1681,9 +1681,14 @@ ISO/IEC DIS 9945 Information technology
>>   
>>   </sect1>
>>   
>> -<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
>> +<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
>>   
>>   <screen>
>> +    _Fork			(not available in "(sys/)unistd.h" header)
>> +    dcgettext_l			(not available in external gettext "libintl" library)
>> +    dcngettext_l		(not available in external gettext "libintl" library)
>> +    dgettext_l			(not available in external gettext "libintl" library)
>> +    dngettext_l			(not available in external gettext "libintl" library)
> 
> Sorry, but they are not available.  It doesn't matter *where* they are
> not available.  Please drop the hints.

Intended as reminders of work needed for support:

_Fork needs to be async safe and does not call pthread_atfork fork handlers: 
could it not be specialized from _fork?

Ask if gettext project is working on adding those.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
