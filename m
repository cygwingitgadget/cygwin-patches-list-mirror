Return-Path: <SRS0=tudX=BM=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 23AFF4BAD171
	for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2026 14:45:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23AFF4BAD171
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23AFF4BAD171
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773326746; cv=none;
	b=WpYBGI1EaREdnDO8n4J6RM37CUK5PSBAlyi4g19BfryaqfO3nvlLvS0CpPsWDVX+8o+XaqeyMQKrr+SDXGEOM+5nZTSLKhiM6vIj1YTa8y9hAsG7ZaBnMpgfabOyI5IKAPN1kjxhOPuejFzVHZlk5xKX75PDhNi+4TQyd5hA9y0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773326746; c=relaxed/simple;
	bh=ghok0N5RZl/IZrgp2FVLowbIBGacy6GLokcDBfvv1zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=gyO+h9jNuGjVuhomf+hZMcjKzE2LxvsnnggMqQAQ9zUlWlZA3P594hSQK6I0Vyom4JWL9huK5slFYfwkb+baRGY13bs7DDCLgbJlDS8tAhXoJLiS/FlIM4kR3jj/wVYX477/RJJbF9dTbWODNRUfQqgt9mvXvZchaQpAEDCymao=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23AFF4BAD171
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69AF67E4004064D1
X-Originating-IP: [62.49.245.144]
X-OWM-Source-IP: 62.49.245.144
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTF1lJbiAGS09jjYDbVGMKF5zfgBMGqwBZQq95EjOx7vf3e0yorwCRlDl3pNq8FVfqrmTHO56XtWiobNTFilXJ8zOVTxoYDWn75zjmKci1n2w9GB3CK92TlSfc17/OxiOnh7RTmbSswHYxaExJdBioF1NHv70TaMNI2WEWxJ8SQnNDN4PEbLUYg3GcSffEPhz1LvMEHZxzY/QQF39T4KiR0NuegkwwYH95IoYbnfvIW9sRkyjNE8TCFH44560sNuPAT87WzGYBXxyGRIRqMvQ8GsPCzObCaZ0tXCBrge9XLcQ/QCHLN/P5CWSvQQ5aCqNvP04L9DgBaJUGqOhExKFScWENFrIAb/OBRnBPXWjOICs2aHmxNpRV/WQfUImlQ6DoWOApszTeL53taIMhQ5GvgMQ+rgwK4lQ3Ya+i2IhbtdhhiRXqQ+6TvxLMSPyL/QiiRsgmjNUYo9EFEKMcHfijAiUs+RPYJzvSiIG8uNKENNMo6rJpFbgTQI8uhmcxgOc2kPz9NPcnPLHSdp/494yTvnAxNMxA6Q93S0WNUh+D79w9tVogOx4hsOoU5bZ/H/A2YXFGTD4P80wfu3FvCWd2bRHRR3SUWGB4xOZIYvwe9iN3DBmqNC5TzYF8BwqYNzuLEEniG/TiLqVLEPcurf0lF6rhWkwkz/DkMp25pMXfWw+w
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.49.245.144) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69AF67E4004064D1; Thu, 12 Mar 2026 14:45:40 +0000
Message-ID: <8fadabda-8d77-4751-86a2-c9741624b648@dronecode.org.uk>
Date: Thu, 12 Mar 2026 14:45:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
To: Sebastian Feld <sebastian.n.feld@gmail.com>
References: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de>
 <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
 <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com>
 <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de>
 <aIJ2kbx6UOK6mAnG@calimero.vinschen.de>
 <b05a2798-ce6a-28cf-f8e2-3f0cd7bf165b@jdrake.com>
 <CAHnbEGJT8vKZjR8aXqB+aANZ8J9P8G5bnLO6gf860FzAeCCXMA@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <CAHnbEGJT8vKZjR8aXqB+aANZ8J9P8G5bnLO6gf860FzAeCCXMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 09/03/2026 09:54, Sebastian Feld wrote:
> Was this work ever merged into Cygwin1.dll?

Unfortunately, not.  And Jeremy seems to have moved on to other ways to 
apply his talents.

It would be ideal if someone else would pick up that work and get it 
finished off.

> 
> Sebi
> 
> On Thu, Jul 24, 2025 at 8:44 PM Jeremy Drake via Cygwin-patches
> <cygwin-patches@cygwin.com> wrote:
>>
>> On Thu, 24 Jul 2025, Corinna Vinschen wrote:
>>
[...]
>>
>> Great!  I rebased the topic/posix_spawn branch yesterday to use a local
>> child_info_spawn instance, but otherwise haven't really been looking at it
>> lately (I decided to test packinging the release candidate of llvm 21 and
>> found a fun new bug that only shows up when binaries are stripped).
>>
>> I'm trying to remember where things were at, and what I'm coming up with
>> was that I was going to revamp the struct with parameters to
>> child_info_spawn::worker.  I think having int mode and then the const
>> struct reference with all the other parameters makes sense.
