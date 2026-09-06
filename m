Return-Path: <SRS0=Jx4T=G6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id 45D994BC7EEB
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 20:51:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 45D994BC7EEB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 45D994BC7EEB
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788727886; cv=none;
	b=Kxk6iHIlMyw9ZiunOBu3zaq6TDaMZ8PTzlIWtOoGzxPtbrkHF3LNq9aGauQR3uTEAt2bC55F8Nt8kRidmKrlU1vmUMZvKP8VZ6gPfscPwwQLHCqLNW3hKoTCWgnY9gU6yW60W6PMrqMFuHc1T+P7MNEHIZo6agW/KFXWmB7faPo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788727886; c=relaxed/simple;
	bh=nS3SVsl5n5vSk0o6fE01y68ZvyalYsWJNgHV8hcGIHw=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=Ly4t05Mvg6KnSHzZV0tcJ+o9DXaIB1UB+SlbqRqQGNB2/MNTgIc9eIeQwOcTHSAqbAy3Vfxda6PWUOd2RsiD1Q2ExJeTy3EaapohPdpxEIWq3lK7sefRibSm/Kvwn0AlIapzCfzk5nOi7o+nKOPS2k7qnh0ZKVI0//Fv43vRtv0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 45D994BC7EEB
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715CD60614D84D
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEJBYheMestGWxfuliYThlOJmOimxsPO7AeOv8DNHmN2DryWQb1OYP3r70TA5t9y6bfr8yq52S4GQr7I9WNLXaI4fm4vrvdUZeyTcQMO1uO9xtQbN8nRNqYPPBd8IBwdHHcArAyO5E6gkv/vrkEOMf4ctiYCOpsTVs3D9vGAtbbCEW2IPmU3Iff4AUj2d+skJGjCQp1VO9fScUIKcKUWBPCpl6gDxDH41a44+Y5DWvCI2/bknhFXdNqyA29pWQ0TjGuSXeHHPxtLF0WaAhsbzUCR8MYc+lgm1wKS50Z6M1P8F3CqFPhDQTyLC1qrDk1xIao9ixJnuebnI4I23wOGCzzTDggI6Fuy23trA2nCU/Auh/mYx54V+NnaV3+3B2kTZ7AQ2wyG44Y9ykYEsQtCfAXV4rvXjs97zbw//aCWJuYWQB4iqq7HXqDHJDCMD6CSBAQsSv3FPM4FA+vJLnwhUmiSjQnEC4VOCc7XcQ1k3nqGD8yMctd1VGmUwp4YqG/lsoVXKED2YhgXl1Vz97K1YCD3uTc8FlkzJWwWSyzRzoqqDSJ/wcqL8X8DYrtReyrMGJ72elokK5chVyzTCJK9TkUxBIXroi+wS609egIX+7/ApoF1w8jMwlvVWUR6GNkm4dPiqtvTlgh+e4YTnWFkARj6a/g8Ol1GGbpt5JjX8UH6g
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715CD60614D84D; Sun, 6 Sep 2026 21:51:24 +0100
Message-ID: <19b45471-6a57-4ee3-9438-0791e3ef1fa3@dronecode.org.uk>
Date: Sun, 6 Sep 2026 21:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: cpuid: add AArch64 build stubs
References: <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <54c93ea8-3e7a-4045-b1d0-2671c8ebef2f@dronecode.org.uk>
 <f3d9fd85-7055-436e-b78f-12a925320043@SystematicSW.ab.ca>
 <80e59c0e-3c08-4c36-8e54-93fd300316b2@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
In-Reply-To: <80e59c0e-3c08-4c36-8e54-93fd300316b2@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,BODY_8BITS,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 16/07/2026 16:56, Jon Turney wrote:
> On 30/05/2026 17:03, Brian Inglis wrote:
>> On 2026-05-28 06:33, Jon Turney wrote:
>>> On 07/05/2026 11:45, Chandru Kumaresan wrote:
>>>> Hi Corinna,
>>>>
>>>> This patch adds ARM64 support for CPU information and cache 
>>>> detection used by /proc/cpuinfo and sysconf cache queries.
>>>> Thanks & regards,
>>>> K Chandru
>>>> In-lined patch:
>>>>
>>>> ---
>>>>   winsup/cygwin/fhandler/proc.cc       | 242 +++++++++++++++++++++++ 
>>>> ++++
>>>>   winsup/cygwin/local_includes/cpuid.h |  21 ++-
>>>>   winsup/cygwin/sysconf.cc             | 148 ++++++++++++++++
>>>>   3 files changed, 408 insertions(+), 3 deletions(-)
>>>
>>> Thanks.
>>>
>>> I don't have any substantive comments (apart from "oh, you're 
>>> supposed to grovel over a registry key to get the cpu information, 
>>> nice :(").
>>>
>>> Brian,
>>>
>>> I think you're much more familiar with this area of the code than me. 
>>> Please chime in if you have any comments!
>>
>> Thanks Jon,
>>
>> Never received the original patches in my email, so imported all from 
>> p- i, and will have a look soon, comparing against x86_64 and Linux- 
>> next x86 and arm64 cpufeature enumeration and cpuinfo output.
>>
>> It would be easier if MS Windows also exposed elevated CPU and MSR 
>> info to regular user space.
> 
> Brian,
> 
> Just a gentle ping to follow this up. Any comments or "looks good"?

Ping^2?

