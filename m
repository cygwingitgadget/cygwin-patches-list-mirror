Return-Path: <SRS0=pVJi=5R=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id C3DB63858D26
	for <cygwin-patches@cygwin.com>; Sun,  9 Nov 2025 08:09:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C3DB63858D26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C3DB63858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762675753; cv=none;
	b=Hxbu5tERgSAIy4PA6WkN6dxKeet0z0m6agzoOKGoNslKy6ZjxhGzpT21MjPs9+LAT2HZbudk9E7RrIkBkuJMTbfYvZy8W1UyV55v5t/meZPjeAMhXNR0NaTpz2LKhBn1RP1YAjrcHYyxaDw6KScH/hPuHwfFVZFpFstjMJ+bZkk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762675753; c=relaxed/simple;
	bh=EYyaR/+4Srn1PW8X32O/MjzA+qPuyZWUEyb1wHczd+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=gk4LSg5W6CgxQAVfJ9/0/KB4Lgi1E/wpYspe3Rg2eXG5OWHsCyHppxyttkbeeGIYeP2p+hGyHKvxFxqjderH2qsVQu/Vpz2wjvkBSP+i6oiBa0ZtlZpuLwahzpyyUQd8Kt2kaXDpT9Xi0Uxq/dPlnyOC4Kfrhk6yPTth1gyeDJs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C3DB63858D26
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 5A98Jifl080677
	for <cygwin-patches@cygwin.com>; Sun, 9 Nov 2025 00:19:44 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdRhxOmq; Sun Nov  9 00:19:39 2025
Message-ID: <1034b8d0-4de7-407c-a9f1-6c2ba7744380@maxrnd.com>
Date: Sun, 9 Nov 2025 00:09:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fixes for dll_init.cc
To: cygwin-patches@cygwin.com
References: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
 <20251105135842.e9c501e7cce6ec6603acc124@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20251105135842.e9c501e7cce6ec6603acc124@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 11/4/2025 8:58 PM, Takashi Yano wrote:
> On Tue, 28 Oct 2025 20:48:40 +0900
> Takashi Yano wrote:
>> Takashi Yano (2):
>>    Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD even in
>>      exit_state
>>    Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.
>>
>>   winsup/cygwin/dll_init.cc | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> -- 
>> 2.51.0
>>
> 
> Could anyone please review if these patches make sense?

The patches look fine to me.  Do you happen to have an STC that 
demonstrates to you the issue is fixed with your patch?

I do not have commit permissions but I believe you do :-).
Regards,

..mark
