Return-Path: <SRS0=K8Mg=EZ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id D89833858D35
	for <cygwin-patches@cygwin.com>; Sat,  9 Sep 2023 06:51:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D89833858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 3896pSBt091022
	for <cygwin-patches@cygwin.com>; Fri, 8 Sep 2023 23:51:28 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdtOXYO3; Fri Sep  8 23:51:20 2023
Subject: Re: [PATCH] Cygwin: Fix __cpuset_zero_s prototype
To: cygwin-patches@cygwin.com
References: <20230908053639.5689-1-mark@maxrnd.com>
 <ZPsqyAfQi1L7YSEn@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <066a36b0-a7cc-3f5f-3904-882fe9cc52e4@maxrnd.com>
Date: Fri, 8 Sep 2023 23:51:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <ZPsqyAfQi1L7YSEn@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Sep  7 22:36, Mark Geisert wrote:
>> Add a missing "void" to the prototype for __cpuset_zero_s().
>>
>> Reported-by: Marco Mason <marco.mason@gmail.com>
>> Addresses: https://cygwin.com/pipermail/cygwin/2023-September/254423.html
>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>> Fixes: c6cfc99648d6 (Cygwin: sys/cpuset.h: add cpuset-specific external functions)
> 
> Thanks, can you also add an entry to the 3.4.10 release file
> (which doesn't exist yet), please?

Done. Here's a link:
https://cygwin.com/pipermail/cygwin/2023-September/254423.html
Cheers,

..mark
