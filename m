Return-Path: <SRS0=TxHU=UF=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id D9EE33858D38
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 19:18:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D9EE33858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D9EE33858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736795907; cv=none;
	b=Wsk3I/4EoOMg6cRDulSW5k8gF9TVeicAGaFthWw9rH4LrMG7QOzSkw9dDGqoYDchGaCTpHQC8ZG7wfYRLWmPWs0kCY3cYcqGMpyEI1pK5us/ML2KjcqIHBwk8tNglPuJWGTYpvm0Jqq9PdpLBarqfAwvNjkmNf1aWrvFqaEk+LE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736795907; c=relaxed/simple;
	bh=S9YnPlYuVNCzuJ6KdzE2krddd0+l/1gdgZoOtISU34Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=PNpffMtd3jJbk0KUh43b5znZfYAw86kOAmnbW5stzvmdBV5OmfWmMhMgwawtz/IRCuOaG49K24kTqRkyndbKMtp6jD8BDnycjt52MUNG/eh8qPoPZYx+/hYkmXExRr7xvda1vg95OuJyc8F5hhX/fP3BdELgyt/0793YihRr878=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D9EE33858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=SulwYMk/
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 977051A02B2
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 19:18:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 2D1CF20032
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 19:18:25 +0000 (UTC)
Message-ID: <a9bb2751-cbce-4b66-aaad-c47b527687cb@SystematicSW.ab.ca>
Date: Mon, 13 Jan 2025 12:18:24 -0700
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
 <eca99827-0dd7-433d-8a9a-44df54049d20@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <eca99827-0dd7-433d-8a9a-44df54049d20@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D1CF20032
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: rsqcmx4bccm966u5onq1oj3c9pp8kq5n
X-Rspamd-Server: rspamout02
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX199ag3zjHcdW+ahd92TmHjHu0NmOpKzTKw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=gDs+jq7zbFeoaDuRuN49q9zynkWaGWSuoE60SbIO9ck=; b=SulwYMk/N9m2JAeGopSky9hdnpE7/kCoUfU6IgPaTbKOO1cqr8JtNQeYJUG1QxxQjTpZzAaBas9Vw8DNL7ovN4g2hvV0aWg/HhLglPJmDcS0lH4zmfZVeHsOUmfF7ASeXV+xCfqnNCemrlfTuXrOq6QCB88LWdoddTN/ew0AsJSPyN1ogDwAHtPb0M+haH0GcZhIV+bLWPmh/gnaNuS2/oSQ+hGkTTt1LyrSZxxaj43ulXt653H6WK/958JM4Fb01kKnITTDCrwd1uqaWb8ux5A20ZOWrExNq1YNLIIUsoVoxJyfGRSHCA68H8tZeKr/fqBSdm3FfcWmjYyKVvtnNQ==
X-HE-Tag: 1736795905-107888
X-HE-Meta: U2FsdGVkX1923P8MF0+Fgn1AzI6w2YyAQlKAq647eNPtKRuFCeHFGqUi+kjAlU+e6fDOyw8hAnXhdMCWoPacc4X9cXo+9GyS24lTG7XZMsPIbHu10LFEbUzjirTUttDrj5mnIt74+d5sfNN61DWRPIOO3yupL1GaBNe1kdhNtyeIuxYDHwINmeTcIpLwDglWiOLip+6i6GXeqJBF9UVFWH+g0ER7RLrVQf0/tcS7mGUN67w3t3YnmUgW2+GewjPg02IqNyDCuDW+CpFsl88pICCNA55yO54ORgE4XZtTSrk5rDBJhMA2e4L2WrNCfvVVb19G/VNOE3hlcL85WK34UjK5rbTi1WmS
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-13 10:21, Jon Turney wrote:
> On 12/01/2025 19:56, Brian Inglis wrote:
>> On 2025-01-12 10:58, Jon Turney wrote:
>>> On 11/01/2025 00:01, Brian Inglis wrote:
>>>> Add POSIX new additions available with din entries
>>>> or interfaces in headers and packages.
>>>
>>> What does 'din' mean in this context?
>>
>> POSIX entries which exist as exported symbols in cygwin.din but not mentioned 
>> elsewhere in posix.xml, so supported but not yet documented as any Unix 
>> interface.
> 
> Uh? what?
> 
> How are these different to any of the existing interfaces (which aren't 
> annotated in any way)?

Initially appeared to be Cygwin only, but getentropy_r and localename_l are in 
newlib and documented, but need fixed, so just the latter four now.

Please see response by Corinna and my reply for suggested changes.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
