Return-Path: <SRS0=WkqS=WD=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id DAF5A3858C2A
	for <cygwin-patches@cygwin.com>; Sun, 16 Mar 2025 20:55:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DAF5A3858C2A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DAF5A3858C2A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742158536; cv=none;
	b=JnY4D2WhWP2r3JSInTwQjwU6bpqnhdSPgZW/ksZDPD7k0gA5qhsVGh6oTbbnMjbzJ1TGP5PYalxXnZCHWE9XqqLpt0OcHs4+EOWHnke/IlBsGqzNmmqXphteNhcHUTUbeD5e1i1ChPJ4Pn6EKjoiwfvaO0dSfUBLkZs4ksETPMg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742158536; c=relaxed/simple;
	bh=l0TlMqh6yBtU51ylG4z9p1XQvV2M1hIaAwrxSFHNs/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=uMIE/rPNA3TrGMef2rnnbcZ4AZngHepsFH3gN02C17vMzvFdaZHUdSFpH0dKOp5cNi5E36tRpA5CbcKfeewe17B9K8+nDJeq8cfhASNa03cDgpGmQ2ze+htKwREu4ITwZTZBVKbLARTXoGnksaSGcUiOpK775lR3KamlSaMmKqE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DAF5A3858C2A
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 52GL0wJd018688
	for <cygwin-patches@cygwin.com>; Sun, 16 Mar 2025 14:00:58 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdzyveTY; Sun Mar 16 13:00:52 2025
Message-ID: <2ab6322a-6195-4144-8203-4cc1c30a181e@maxrnd.com>
Date: Sun, 16 Mar 2025 13:55:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Carry process affinity through to result
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin/2025-March/257628.html>
 <20250316092247.391-1-mark@maxrnd.com>
 <af93e922-7fb4-9479-60d6-88718925d149@t-online.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <af93e922-7fb4-9479-60d6-88718925d149@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 3/16/2025 7:09 AM, Christian Franke wrote:
> Mark Geisert wrote:
[...]
> 
> Could only test the single cpu group (aka single physical cpu) case 
> which is the most common, I guess. Works as expected:
> 
> $ uname -r
> 3.6.0-dev-440-g5ec497dc80bc-dirty.x86_64
> 
> $ grep '^model name' /proc/cpuinfo | uniq -c
>       28 model name      : Intel(R) Core(TM) i7-14700K
> 
> $ stress-ng --pthread 1 -v &
> [1] 1323
> ...
> stress-ng: debug: [1324] pthread: [1324] started (instance 0 on CPU 10)
> 
> $ taskset -c -p 1324
> pid 1324's current affinity list: 0-27
> 
> $ taskset -p fff0000 1324 # All E-cores
> pid 1324's current affinity mask: fffffff
> pid 1324's new affinity mask: fff0000
> 
> $ taskset -p fff5555 1324 # All cores but no HT
> pid 1324's current affinity mask: fff0000
> pid 1324's new affinity mask: fff5555
> 
> $ taskset -c -p 8,9 1324 # P-core 4 with HT
> pid 1324's current affinity list: 0,2,4,6,8,10,12,14,16-27
> pid 1324's new affinity list: 8,9
> 
> $ taskset -p 1324
> pid 1324's current affinity mask: 300
> 
> The settings have the desired effect on reported core usage.

Thanks very much Christian for testing.  I want to make a minor change 
to the patch:
     if (procmask == 0)
will be changed to
     if (groupcount > 1)
to make it clearer what's going on.  I will also add a few words to both 
code comments and the patch description saying what will happen on 
systems with more than one cpu group.

It sure would be nice to test on a system with more than 64 h/w threads 
but I don't have that kind of budget ;-).

So, v2 patch incoming shortly.  Comments from other folks welcome.

..mark
