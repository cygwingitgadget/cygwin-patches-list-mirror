Return-Path: <SRS0=CW6W=UI=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 34D3E384BC2B
	for <cygwin-patches@cygwin.com>; Thu, 16 Jan 2025 22:18:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 34D3E384BC2B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 34D3E384BC2B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737065905; cv=none;
	b=rB1GWncpLPzcEa0GxzC4VDwrfsYzHTPD9wwdiGZZJqgo+SnaHTxa+Xddk44LKZZxXWi/dtFprPDXdJm5ii6gXg4EOIz/5wiN16hEDUhkJ6a37jKT0G6k9jvPqiqU376Q+QkpMCRyTQv8ANunRkP5lNdOWLmxWjzdWzkTtMZEHcw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737065905; c=relaxed/simple;
	bh=vEZrmj+hwJ/oSMdwkJTGN9wJ9TpXuRn1e3r3oH5QT10=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=DPmm8Ezg7bix4pJ/F+WLRVgKh+UYpoAEjmzggy2270omuF9qAUO102ZvUrfSB4OlkN0tcsTNnZZaCLDW/cerAaMXrXwuZ5RqWTSl+AHNPE5C5OO5ACkV85GbKyFZ9JbfubfHmcqyQoWPu6ArxkHu334TsBREDEoTYIzQwwdV/vo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 34D3E384BC2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=BddUfvek
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 7E66EACCBE
	for <cygwin-patches@cygwin.com>; Thu, 16 Jan 2025 22:18:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf03.hostedemail.com (Postfix) with ESMTPA id 2260D60013
	for <cygwin-patches@cygwin.com>; Thu, 16 Jan 2025 22:18:22 +0000 (UTC)
Message-ID: <1b84ba0d-4cdb-4752-886d-2e34a11fd16d@SystematicSW.ab.ca>
Date: Thu, 16 Jan 2025 15:18:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <8351d131d2aae253f9172f723484f6f6ffa564d9.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4lSkZYfY83rpCCv@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z4lSkZYfY83rpCCv@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2260D60013
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: c5qjqap8qtkjuqz1nycwk3aob513w3d6
X-Rspamd-Server: rspamout03
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19QHAoefO1fZOhOHqEXaUQBMPLckRGXGPY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=tMBiCniq0zGugt2o8Qqo2FtwwkUtiXORHfgC3zp54+I=; b=BddUfveky+vAB/bps3axOWCTa0G2h8OlGuaBGXswl//xoZorccLXOhwOoeQJoDeERD2WU60m3iQgqu46tWM7x3vajLK8IVGAmJCh6wnarGTTMYnbZb4PtdvtSM+RKrmm6sbsGUKaJOPGZY2C/ynwM4CW0lbQQGR57Zfe1iDBenzuUfDLheMFimTLNdJ+Cd4WYQkJFK8mLSPZZmKw62PcfGVi+s0Ar6bzRYOVUj2dsJ7g7ePEIsgmNkgbThnIcYlCxODiZ2UChJVUdIVcVBSSDdkqMRkkw0AT6LHQD764nZYQKE75m3yyeKrOVNMEhWMPKELCMEFLlcKxYdZcAQjsIA==
X-HE-Tag: 1737065902-923467
X-HE-Meta: U2FsdGVkX1+8uG2mQMjC0xqEgDsaqOieu0iUWJSNqYKwvuYZYVsdDyzsWZcPT1c3yRzIteuVT3/WQeP5V/zCaqO7SLpfHUMqC5ye5MVPY2IWj34v6zVeQAaDtL95q4YSIdopjIEa0GeQOc7LNfdoQzl17HVCexldWCqE+PrkVkl4sw2c+6GMKOs36ffPsEX/TIa362FpCsRv2J5g+TNfVUKOmOdMfLokpxEi8v1kG72PODtZ1M2w7auBJtZXpzuP+pmgZydNt0Vykh+kHJOOO8jJmn05We354n56KWoXNF7AXX5Y8Du1k3iCSUM+JA8vc79y8A6hqD5bS7PS3UwQtTxceI/M1XPY
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-16 11:40, Corinna Vinschen wrote:
> On Jan 15 12:39, Brian Inglis wrote:
>> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
>> index 949333b0c36c..0b23a2251028 100644
>> --- a/winsup/doc/posix.xml
>> +++ b/winsup/doc/posix.xml
>> @@ -16,6 +16,9 @@ ISO/IEC DIS 9945 Information technology
>>   - Issue 8.</para>
>>   
>>   <screen>
>> +    CMPLX			(available in "complex.h" header)
>> +    CMPLXF			(available in "complex.h" header)
>> +    CMPLXL			(available in "complex.h" header)

Missing from 3.5 - only available with 3.6 - and no docs, info, man.

>> +    bind_textdomain_codeset	(available in external gettext "libintl" library)
>> +    bindtextdomain		(available in external gettext "libintl" library)
>> [...]
> 
> Either "gettext" or "libintl", not both.

Which do you think most useful?

>> +    getentropy		(Cygwin DLL)
>> +    getlocalename_l		(Cygwin DLL)
>> +    in6addr_any		(Cygwin DLL)
>> +    in6addr_loopback	(Cygwin DLL)
>> +    posix_getdents		(Cygwin DLL)
>> +    timespec_get		(Cygwin DLL)

Lack of docs, info, man - except getentropy_r is in libc/reent/, should be 
included with others from reent.tex, added to CHEW doc, and getentropy 
implementation and doc could be added?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
