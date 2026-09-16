Return-Path: <SRS0=tD51=HI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.0])
	by sourceware.org (Postfix) with ESMTP id 397F14BA7991
	for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2026 19:05:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 397F14BA7991
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 397F14BA7991
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.0
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789585500; cv=none;
	b=IeAhzzfQjRo8RsLsoMWNoH9Hx+5s8edJmOF7VqC+XOulzoFrToQIdcDkZpkC9Cg2tKoR0Qk5w3tIWAI7Gm0Ear/FRy074GQ/Jtc2AqBxQGmu+V/gCy8x1kVKbtmpwroNhQ/oCV6L6pur7+xa4RNu9tgcx10xCN9HUBXfBaHgYzM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789585500; c=relaxed/simple;
	bh=Ev0U7c2DyYfb+7cPJ9XnfxTcTzQqKJYqnzOChU0p59k=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=J2o1Fxi0S8x6vj5EkOMk8d3HPbMw37RasqkcbyGqWh3JvTG8Xo7Z7EWus3IVptkQZuNx49vskd/eNV/vCaNrjQMq7YCllPOawgWpUr2yjBkbk7nq7bDpXMwoO34yWVbpquJDDIiSK9krv2V+cvyHuB9H7RzT1P87JIPPs0wimbY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 397F14BA7991
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715E20082F0B89
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFVYR/5HaJZOFSrYJmDRIzWdbbW9LxaBK0SjzBO7/MBGB4jrUspPDCx2+xGrbm8/CsxOAvm0ajZjLp2nZS/ko8IVBZX8Jz3YBeQPa1DcoxUr6mDc6z8agOADQbvdJ01TCI7mdUEAHD8JBBu5hV4+JX6cnqLBhvWofQC665LGDXrQJ7C14NWBfDCCdXnv3plaxipj13VhwQA6fFey/+a6Lqo7PYRnZNageCEtzNVpNCpVTYpjGC6tSV+qmboXtpKVpfcovhyL3ec8VsUTLlMlOMndxZ45/cjg+/4oQ6ueMoskcWdNKm4uEoupz01VCitm+Sscv2VYfudl3AiouRYYqP/SiTWttLUv/exrwBZ8cZdjvILPwKmBI/jouna3oYzN0V9ZeeCQjq6DMOuiM+xshVx8WK9Cd1tv2KniqEa1V4FanmJnqiWnSkaF7Lp9O6dGepqMEKG7aQ+jeeS+2B/Qa6fh59BwB/RNLi970Axsx4JvIqMUasAH2iSv0pZP/X22zXY8ucdEQyaZGlWILQmqNnaI+YrDS9Wc2/vH6sOc+tIWANKvDCyEbHWP4heGRhqAngW9HUc6NxApZCaRKitRcWDeE8S5SeEWLXI7jNDh7G4Xe/3pnhQlcvCdMzK00Dx0Vb5X7O+HdY2WAJ+/ixjlz30fnVAQ3rCYYbr0AlpZ6XEWQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.83.178) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715E20082F0B89; Wed, 16 Sep 2026 20:04:59 +0100
Message-ID: <0061b5fe-6f84-4843-968f-64a55084a130@dronecode.org.uk>
Date: Wed, 16 Sep 2026 20:04:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Cygwin: Fix compilation of c8rtomb with gcc 16
References: <20260601125055.1341979-1-jon.turney@dronecode.org.uk>
 <20260601125055.1341979-3-jon.turney@dronecode.org.uk>
 <20260916094143.4a692ca26a98c385910c30d4@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Takashi Yano <takashi.yano@nifty.ne.jp>
In-Reply-To: <20260916094143.4a692ca26a98c385910c30d4@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 16/09/2026 01:41, Takashi Yano wrote:
> Hi Jon,
> 
> On Mon,  1 Jun 2026 13:50:54 +0100
> Jon Turney wrote:
>> ../../../../src/winsup/cygwin/strfuncs.cc: In function ‘size_t c8rtomb(char*, char8_t, mbstate_t*)’:
>> ../../../../src/winsup/cygwin/strfuncs.cc:214:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
>> ../../../../src/winsup/cygwin/strfuncs.cc:215:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
>> ../../../../src/winsup/cygwin/strfuncs.cc:216:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
>> ---
>>   winsup/cygwin/strfuncs.cc | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/winsup/cygwin/strfuncs.cc b/winsup/cygwin/strfuncs.cc
>> index 0cf41cefc..85427a0d1 100644
>> --- a/winsup/cygwin/strfuncs.cc
>> +++ b/winsup/cygwin/strfuncs.cc
>> @@ -211,9 +211,9 @@ c8rtomb (char *s, char8_t c8, mbstate_t *ps)
>>       {
>>         /* We already collected something... */
>>         int idx = ps->__count & 0x3;
>> -      char8_t &c1 = ps->__value.__wchb[0];
>> -      char8_t &c2 = ps->__value.__wchb[1];
>> -      char8_t &c3 = ps->__value.__wchb[2];
>> +      unsigned char &c1 = ps->__value.__wchb[0];
>> +      unsigned char &c2 = ps->__value.__wchb[1];
>> +      unsigned char &c3 = ps->__value.__wchb[2];
>>   
>>         switch (idx)
>>   	{
> 
> _mbstate_t (*ps) is defined as follows in
> libc/include/sys/_types.h:
> 
> #ifndef __machine_mbstate_t_defined
> /* Conversion state information.  */
> typedef struct
> {
>    int __count;
>    union
>    {
>      wint_t __wch;
>      unsigned char __wchb[4];
>    } __value;        /* Value so far.  */
> } _mbstate_t;
> #endif
> 
> _wchb[] is `unsigned char`, therefore, c1, c2, c3 should be
> `unsigned char`.
> 
> That is, your patch LGTM.
OK, thanks for taking a look!

