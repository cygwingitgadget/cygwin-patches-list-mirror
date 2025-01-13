Return-Path: <SRS0=TxHU=UF=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by sourceware.org (Postfix) with ESMTPS id 3899D3858D21
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 16:05:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3899D3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3899D3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736784333; cv=none;
	b=G2XRlK2PGLiS9y/56/LUX9s2JDJuauowmLGRPxYOpvWJuFQ3cSydqDpn8kqLfS0Qwj+gfPtd2uZGxqnaIZmvzra4UbOm8zsR1RkIyfMQ5QJIDW6Yg8vMD0pWGsrZfiD+GbZygw6VFdMZS0kTO6Vmp5cGF2w+8YwP4Z2IUNwbBR8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736784333; c=relaxed/simple;
	bh=abeJUiVY6bhU7uBeqoBs25IHfYbdAuwxQbjnDPJj+Lw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=p/NTf7xiS5SUWZ7nOhR19YDg2om4VMpl5XeNFXRQKJJ73S2jHObM4MF8V1ldgibp4hIEiCogEh6w6llqDys75Zu911ICd59IOuyJOUIAfmHqVTjMRj1NJxXpjRxK7w+7wIE4Gu87QjON1DF3EiXoKNa/fUNolvgUmJr0PIU4pnc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3899D3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=N8UHd7Yw
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 966CD14052F
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 16:05:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf06.hostedemail.com (Postfix) with ESMTPA id 13DFF20011
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 16:05:30 +0000 (UTC)
Message-ID: <83ae2fcf-74dc-4ab7-8537-fe8c4a5cbf53@SystematicSW.ab.ca>
Date: Mon, 13 Jan 2025 09:05:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 1/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 TOG Issue 8 ISO 9945 move new
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <ce4fb1f0bb4390758b48d56bf635de71b5809b42.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4T1-rjrkks8j57g@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z4T1-rjrkks8j57g@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 13DFF20011
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout08
X-Stat-Signature: 89nfcio8cqeqrsjtdew65o1di63he8bx
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19fLGeXXD/3mbCCTdE+LGNwlWhO9kY/roU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=1ZHKgrGWnGaepbJWHLz/+6sdtDTCYCPl9rRA6PeqgwM=; b=N8UHd7YwfZ9KQqFRgNFLxEm7A7CVGA11tCqZPk1gOfThdRDqt0QycojK767sLAAue8leiC2VPneHmx53s8O0+14+Jpst+apOBM/yknXDgKHcQsklaPNBXAt8nDXfoIVjshUnP8qk2DDo6w/SB2RmQ0rFR4brxAnojgf+n6+xzmwmzAv78k9s0Blefha/lgZ64+wiTZw2mMAnRbD6jVoSO4qhXKBmMsFWmODxpwVNGJjRlImwUwpnob48AItUOrf9TyLzeI1qAatalNSe1JZjBRm5xDcEQC3uFHVmTh7r3aZbYC4do5GnazZ/4LhbCg4COQouKRS/p5Ce1SYvYCHs8Q==
X-HE-Tag: 1736784330-210690
X-HE-Meta: U2FsdGVkX1/uMkTt5mGoRDb30r1PNtbEXTaK6UlifepyuqEg8uzeRGPQIVRxoP6ftNa53Ju588nel1EmInanZ7AiMK5tGiFcSKBh4zA21Hz942H2DxjtRM3GHqlTL4+Qi+zqQwKboXqBxTmryrnJfLvosfchlkeAYJZf9blax0ZDJljmEgrGB+wyoVZrwKP2R/yZTYuPB9ug9h42EcA0j0oOOsmZ+ILNVn+xdVrt16Fk8pw9tWGvCf8uwfWpN2aO8OIsqyszLSls9wiE2sbvOb0ChM45k+jmde6sCUXYwnYmqquzNIYHnlilpDG0zDo0zRUr00QFl2+XghmQQm4pYU8k8eOUEnFbydVGU0HLudzID5HDuuHVNxnoNsGUGW3E5lSClfHq7k/Acp9mOVfKQFH/nR/8sJEusAaegLWvQIBaxzAl/w5awh06/6AfcwaUrDtLMbPE33vi4IAFgXsawUGt7XpIljmp1q0byOPsxOE=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-13 04:16, Corinna Vinschen wrote:
> Hi Brian,
> 
> On Jan 10 17:01, Brian Inglis wrote:
>> Update anchor id and description to current version, year, issue, etc.
>> Move new POSIX entries in other sections to the SUS/POSIX section.
>>
>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> ---
>>   winsup/doc/posix.xml | 140 ++++++++++++++++++++++---------------------
>>   1 file changed, 73 insertions(+), 67 deletions(-)
>>
>> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
>> index 2782beb86547..1b893e9e19ae 100644
>> --- a/winsup/doc/posix.xml
>> +++ b/winsup/doc/posix.xml
>> @@ -5,10 +5,16 @@
>>   <chapter id="compatibility" xmlns:xi="http://www.w3.org/2001/XInclude">
>>   <title>Compatibility</title>
>>   
>> -<sect1 id="std-susv4"><title>System interfaces compatible with the Single Unix Specification, Version 7:</title>
>> +<sect1 id="std-susv5"><title>System interfaces compatible with the Single UNIX® Specification Version 5:</title>
>>   
>> -<para>Note that the core of the Single Unix Specification, Version 7 is
>> -also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>> +<para>Note that the core of the Single UNIX® Specification Version 5 is
>> +POSIX®.1-2024 also simultaneously IEEE Std 1003.1™-2024 Edition,
>> +The Open Group Base Specifications Issue 8
>> +(see https://pubs.opengroup.org/onlinepubs/9799919799/), and
>> +ISO/IEC DIS 9945 Information technology
>> +- Portable Operating System Interface (POSIX®) base specifications
>> +- Issue 8 (expected to replace ISO/IEC/IEEE 9945:2009 - Issue 7 in the coming months
> 
> This hint is outdating itself.  It might be a good idea to
> phrase it time-independent...

That is a direct quote from ISO and will continue to be true until it is not:
Status Proceed 40.99 Full report circulated: DIS approved for registration as 
FDIS - awaiting Approval Registration 50.00 Final text received or FDIS 
registered for formal approval - expected to take about 6 more months perhaps, 
based on 9899 C timeline 2024-05-05..2024-10-31?

I await making the change final (or dropping it), without holding my breath:
I see Austin Group Bugs & ML & JTC 1/SC 22 feeds.
Even IEEE got on board with minimal editorializing.
ISO has a lot of editorial rules to meet - they seem to have standardized the 
requirements for standards committees - I wonder if that has an ISO number ;^>

>>   <sect1 id="std-iso"><title>System interfaces not in POSIX but compatible with ISO C requirements:</title>
>>   
>>   <screen>
>> -    aligned_alloc		(ISO C11)
>> -    at_quick_exit		(ISO C11)
>> -    c16rtomb		(ISO C11)
>> -    c32rtomb		(ISO C11)
>>      c8rtomb			(ISO C23)
> 
> Did they really miss to standarize c8rtomb/mbrtoc8 as well? I guess C23 was too fresh... ;)

Not really, so I too was disappointed, but they want to see widespread support 
before committing, and perhaps some were not likely to agree?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
