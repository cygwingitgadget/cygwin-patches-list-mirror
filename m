Return-Path: <SRS0=pVIE=IM=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.92])
	by sourceware.org (Postfix) with ESMTP id ED69F4BA23E4
	for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2026 16:22:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ED69F4BA23E4
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ED69F4BA23E4
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.92
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792686150; cv=none;
	b=gp750xVAs/h1pFtGZV26/JKeRtbLri7maXFxi2Tw7hU8N6ozTWal0pd0DhW0SR/eqmupssS3yA5N9Bo5wuDFCxJjQWQro4WlG7DYO316Zduoi3wPBN5Qh87LKKyuhEmk7pXk8OuYwG0laj64k1/O3z1rVY0WyMjZFolJ8/k5DnY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792686150; c=relaxed/simple;
	bh=vSbRhs28cUD76OEHS0K9z9vN7RCOTNw2XTO1/StRDIg=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=q40Th79w7TzdLvE6zj7s5EaPIMuYGMEMk7oasSX2dsKMhzTA9axZhlfUMhZRAUilOWNwncm5C3a4NBmWC2k349fyRb9hdPfZmbfHz+VHbcWLTbVSU2ZRs7GhNUMhSxAbWkLWJCWKB7ZIn/DMmYjdmZfipRjwV6dj6T4Su2stDFo=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ED69F4BA23E4
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161380FD806D3
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGHKhOB+ar97S9vsqmsxHHrwErm3IfiNe3NXedhpwqpE35uPGFwko7mqG0ZkOhYc20f8KS7ptEu7hFCSrEnFHumYwCqOQ8fiDuH8gj1nPjh4dzhvXizM7s+og0kXLpG7fcq3ftg+y0BbrAZIaGe8Onbus/6Szt5fxVc8Ii1VtwMqntUUts+lLpleXyRTKL8SeEwGxhZJcqDfNIIso0R7a9BLAyap2GMDLyxS8CNQf2JxHNCADEA/slsSYo6PFtg/4bhcCjHJVOybrCBaMyNcVFA4K7qEIp/WDTjvYO1M5yj5owt7KN/fn2XmKC6RuIYofyQwOPdQYCHzPXFnWUzGRlEDQBhE/qk7gaWoLZF8HNCSEWs6TCElOgztjODo9myfAJRELwfjcjezDw0hgLgrIljfvKwgfwn/gJkBkoivQGy0fPegbyf7lb9K0YfUYUcO8awgsKNqCXqJuwvPtorPuY9BCMCGuwg3O3GeZeV2XVy/KL5+xbStVeQcL0lUUJeP6quQimUJhMILYu3gOp9Yy8zuDHxa4Iu9P1UyzxbhTqyZgpPga2CzUnM/LXO+bWJOwyTQXI+h/FHic0DStCEk0LTI77RUkFzqzaeLZsp/dWtB9ZVXlC1ygCVHHlSRMytcXTgd7OC35hTaVzdmSAqHwQY/kniQ65vyusBjE1XfZChqQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161380FD806D3; Thu, 22 Oct 2026 17:22:26 +0100
Message-ID: <e9b5add5-05f6-4911-95fc-eca7384aa195@dronecode.org.uk>
Date: Thu, 22 Oct 2026 17:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The meaning of "Signed-off-by:" in patches
References: <636bc5ac-7500-4d18-966d-ffb73d87da3c@dronecode.org.uk>
 <96aba361-6358-403e-b2e8-a9f39000f4a4@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
In-Reply-To: <96aba361-6358-403e-b2e8-a9f39000f4a4@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 18/10/2026 18:53, Brian Inglis wrote:
> On 2026-10-18 04:56, Jon Turney wrote:
>>
>> I've made a (long overdue) revision to the "Contributing the the 
>> Cygwin DLL" page [1], to state what we think "Signed-off-by:" in a 
>> patch means (going forward), by reference to the DCO [2].
>>
>> Hopefully, this is uncontroversial and unproblematic, but please let 
>> me know if you think otherwise...
>>
>> [1] https://cygwin.com/contrib/dll.html#before_starting_legal
>> [2] https://developercertificate.org/
> 
> Ignoring the DCO Copyright which does not imply it applies there, but it

I don't understand what you are trying to say here.

> would be worth while stating something like where the DCO is applied to 
> the Cygwin project, authors, and contributors; also newlib licence is

Sorry. Rather than being explicit, I assumed that it was clear from 
context that I am only talking about changes to the winsup/ subdirectory 
of the newlib-cygwin repository.

Yes, as previously discussed ([1]), we should do something about 
packages and ancillary programs in cygwin-apps and everything else, but 
that is a task for another day, and preferably for someone who is not me.

[1] https://cygwin.com/pipermail/cygwin-apps/2024-November/043939.html

> BSD, but Cygwin is LGPL3+?

And?

> What should we be doing about GnuPG2 signed -S commits?
> I could easily add that, but unsure what the infra and tooling is like 
> for repo writers?
I don't think there is any reason not to use signed commits.

