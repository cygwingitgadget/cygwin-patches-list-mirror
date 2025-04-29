Return-Path: <SRS0=Wv0b=XP=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 40FE33858431
	for <cygwin-patches@cygwin.com>; Tue, 29 Apr 2025 16:49:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 40FE33858431
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 40FE33858431
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745945395; cv=none;
	b=FUxzuE/m7c2EpjXmqUbd9Xew2lfwPqQCAjZzZxmON6kYtKz6ssj9DmOULznZRKEflQoBKE3jlkR5CWHXbnUIC878fsmaHyoMQ6FK76CYEeeAg+PKLBQMJE/n487rM36AInOzXyWqTeq67WEH69L2864ecUrCRgHcW/DIzhu2Bb0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745945395; c=relaxed/simple;
	bh=TWb8Cqg/5qbuQgbR79dTB91hQf8ROsnxPS6ypRL/MFA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=I4AgahxVbRejOmX53PsABKgTMZWVoGxtUtgaqbK9eLI3n4Gej2guVi2EjOtt2Mc2KK5liQZZmjgUDCiA1U/lKk3WAUej+uqAPNEnKK04qEa4Nv1SHcZCK+Phs8YlQLuRqzqHEJHIXx7ngVOfwVmZ7VYIC9p9eVbxIj8tOWobsPI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 40FE33858431
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=m31c/T2H
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id DCB0D120B7C
	for <cygwin-patches@cygwin.com>; Tue, 29 Apr 2025 16:49:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf19.hostedemail.com (Postfix) with ESMTPA id 6EB112002C
	for <cygwin-patches@cygwin.com>; Tue, 29 Apr 2025 16:49:53 +0000 (UTC)
Message-ID: <aeb1c1ab-befe-4e3f-a11e-fa4e5eb9840d@SystematicSW.ab.ca>
Date: Tue, 29 Apr 2025 10:49:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
 <20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
 <4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
 <ac9d481c-00f0-46fd-a28f-c6938418e5d1@dronecode.org.uk>
 <804e3202-54d4-4604-a962-0e15360e1a09@SystematicSW.ab.ca>
 <0ed53f3d-e08b-ae5f-1400-350c707f0191@t-online.de>
Organization: Systematic Software
In-Reply-To: <0ed53f3d-e08b-ae5f-1400-350c707f0191@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6EB112002C
X-Stat-Signature: wimqjdcffaeth3jjbabhbgnzrj86u3wn
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/h+x+6fZDIvV5GMPYHa/n9NJBs1cxdLh8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=Ooej50MvBj0Bujbe3SklVFRmeBJfqe87ybRwzz0cwdY=; b=m31c/T2H+Wbz8as7w5tm8bziFIYHeWFDrPC/91S+4UHYRqNw8BDHsg0KK4Nzn77b+l3WewQnA9OTG/TdXbi6VAe5CL1PFMfWfH6OuH6k5dHM4ULYcX6GGP61vlhv01zwXXdBVcWpeLTKaXVMiMV1OQjEDxZ7fCek1PFb2VZYqWR1kez4bmrXIvSAQoroVjBloMiqzn6yZU2l6Y3vaDeCOYzEt0yYErzz6vgRPSDE/3Wu6gnZ/2TDSM44HMX52taRgax+K9mL1vAIXuyvNOEf7wjSHoAcvWADPTJc87+YNbTk/jUubryOVHgmmq16FAaKwDL8r/sAKgzsaB5C7roEuQ==
X-HE-Tag: 1745945393-207930
X-HE-Meta: U2FsdGVkX19HSFPdRtDefqZAXilx4/j9sFt2OmyqKyQTSooXUqawaArx0++CqZ9SWduX9PsEOlxDizF+YvIO7Sdmq8KUP/N+9rrM8qdWMhbkg0FpZzsBc15N6u/3OhBpHdxtEQkLKxrOGb9KQxbLC0HDHr9LL2iEsFUKHcyDwD+Ii8pGK3F71UT2a0cCgIsDtEnffenu6mi6VBNlwMOWWve897bireCRYSPOAZNdcloGqxIdNkRkMcBR3IlpLpOI+3FO8vgLkTMB16IBPc4MB3V80TddA4zQz9HhNlSwpoIxTRmFeQPmGP/mwawNp67u1SKqGWdzhYHZpWm98jf3G7Qnm08Ifk+z
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-04-27 14:43, Christian Franke wrote:
> Brian Inglis wrote:
>> On 2025-04-27 12:22, Jon Turney wrote:
>>> On 15/04/2025 10:02, Christian Franke wrote:
>>>> Hi Takashi,
>>>>
>>>> Takashi Yano wrote:
>>>>> Hi Christian,
>>>>>
>>>>> On Fri, 11 Apr 2025 16:46:07 +0200
>>>>> Christian Franke wrote:
>>>>>> In rare cases, '/bin/kill -f PID' hangs because kill(2) is always tried
>>>>>> first. With this patch, this could be prevented with '/bin/kill -f -s -
>>>>>> PID'.
>>>
>>> As it currently stands, the -f flag to kill seems a bit misdesigned, i.e. if 
>>> the signal isn't SIGKILL, -f shouldn't be accepted?
>>
>> Docs say -f uses Win32 interface so SIG... is irrelevant?
>>
> 
> No, the current logic is:
> If -f is specified, Win32 TerminateProcess() is called after 'kill(pid, SIG...)' 
> failed or if the process does not terminate within 200ms after kill() succeeded.

That's okay, but the suggestion was to require some specific SIG... for -f to 
work: that changes the command spec: please don't do that; -f should be enough, 
same as now.
I shouldn't have to know to specify some specific SIG..., default to (or 
*force*) the required SIG... with -f!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
