Return-Path: <SRS0=J/el=FK=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.244])
	by sourceware.org (Postfix) with ESMTP id D0F0D4BA2E23
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 15:56:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D0F0D4BA2E23
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D0F0D4BA2E23
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.244
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784217404; cv=none;
	b=bFjItl7u+A1QzBs3F/JAwffk8aMrSsjW03Fm7waV33bdbaL0lrviKMpx2m1g8+vPIrSYa4VbRzeHeKik1laQdR2uMMh7nkbrUDOsc10m2t8gZArxR3IHBaBsWJ2LuqzOSoV5xLdWu5zn5x1CeM/oJGZRnYQRtwEjngO6bCOsrk8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784217404; c=relaxed/simple;
	bh=mBHzWY6aAvu1F9qV59nxMBk66KOpfWFm1yPB+gzECeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=JwmfS+1mjTu47RTxEfz0kcRoC0rC7pTxioC3oYJ0Ug17Q5XGG0O+xgdoPD+DgpTkVGQqXpeTX2wVkJc/LSb2ftyO7BvTWEBB1+zuE7cW8huVt/7QIm2a6AZ1qp3fNEhKhZiLMjXaMR399/TPJJr3emfHPI+PPgNQfcf1kebcL6o=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D0F0D4BA2E23
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69FE539D05953D43
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEVIPRaNG3NG7r/SOYlZk2i81OmPtw56QorOw/HMUMVKIniEt3Sb29OJJAPlOUXkoAz6h3QzB3r29mzK6q621HJQQLPyflAv4+YNpxJMQuUPYW1HlR0iZtHoln568MQbjmPzKHgQL0Ae6RvXMcLmj73sYPtCayMhKgVnTLSGIkWZ9oxfQoHqd4lZLUDNlV3LR0r5mF1pgahdcBSQd5HqmbJWCigqZn6XOffgOCcDoUVk6xDeCy520vY5GYRdMMrlTU/l14+g/0G2OO1PzlaErCqEK5o60HpSTfDOF3mvyFwH7jztrYR322Wk1NCeE8hbgUHwatfEefl4F4OkR8Ks5yZNWeHTDyhFfqZ8vU+cG1IvYbWy6+faFQaHlvn5sPYQG+JVUR1iwG5Q1ViKIrU4LgryFk9ST55DmaBPuuxMu+Eb8JddRzAjHBbmd1c+7lRlCelN0naPVjU0XbcXHuw7QmJ5IdPkgv7W7wHx0jPBhW+vcMWEv+WT/1jUjeYmEMfXYHkkKF1qwtBPr6Acureyeb1rvt6/rsqbvJ5P7P1qZaqKcixuKZeYv3jqkHzSbIlV9E5Lu4S4dtnkiQoxw6SXoAskXt5Z3dH70swnwZ8bonK//326jVG7mEZJqtUy9+ckBGs4ovM6FNkFgBZ2gHpt3HVt6XyEiyMcdDurennV28CVw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69FE539D05953D43; Thu, 16 Jul 2026 16:56:39 +0100
Message-ID: <80e59c0e-3c08-4c36-8e54-93fd300316b2@dronecode.org.uk>
Date: Thu, 16 Jul 2026 16:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: cpuid: add AArch64 build stubs
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
References: <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <54c93ea8-3e7a-4045-b1d0-2671c8ebef2f@dronecode.org.uk>
 <f3d9fd85-7055-436e-b78f-12a925320043@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <f3d9fd85-7055-436e-b78f-12a925320043@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,BODY_8BITS,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 30/05/2026 17:03, Brian Inglis wrote:
> On 2026-05-28 06:33, Jon Turney wrote:
>> On 07/05/2026 11:45, Chandru Kumaresan wrote:
>>> Hi Corinna,
>>>
>>> This patch adds ARM64 support for CPU information and cache detection 
>>> used by /proc/cpuinfo and sysconf cache queries.
>>> Thanks & regards,
>>> K Chandru
>>> In-lined patch:
>>>
>>> ---
>>>   winsup/cygwin/fhandler/proc.cc       | 242 +++++++++++++++++++++++++++
>>>   winsup/cygwin/local_includes/cpuid.h |  21 ++-
>>>   winsup/cygwin/sysconf.cc             | 148 ++++++++++++++++
>>>   3 files changed, 408 insertions(+), 3 deletions(-)
>>
>> Thanks.
>>
>> I don't have any substantive comments (apart from "oh, you're supposed 
>> to grovel over a registry key to get the cpu information, nice :(").
>>
>> Brian,
>>
>> I think you're much more familiar with this area of the code than me. 
>> Please chime in if you have any comments!
> 
> Thanks Jon,
> 
> Never received the original patches in my email, so imported all from p- 
> i, and will have a look soon, comparing against x86_64 and Linux-next 
> x86 and arm64 cpufeature enumeration and cpuinfo output.
> 
> It would be easier if MS Windows also exposed elevated CPU and MSR info 
> to regular user space.

Brian,

Just a gentle ping to follow this up. Any comments or "looks good"?

