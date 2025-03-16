Return-Path: <SRS0=Wz8f=WD=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
	by sourceware.org (Postfix) with ESMTPS id 22B303858D20
	for <cygwin-patches@cygwin.com>; Sun, 16 Mar 2025 14:09:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 22B303858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 22B303858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742134175; cv=none;
	b=J+CWJcaVXqJpGTXyMEChAqIDmwAfmPhn9Kw93c3gsrpIVE95b5MGZdREor+KQ6zqtqbbn3aoydiGZHrA8+oUVQB6NhnzpViWUuLCrr9VYoKZy5XMHF8XYSJ4KNFZKLTQ7gL1SuMFLiGY7JMyzRzVCF8vD071m2ASvefMYRsnmXw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742134175; c=relaxed/simple;
	bh=RYPX0ezJjQnOY29qlx8+fDednZS31a90b2iaw808/W8=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=EpLv3ff7yLoyWPzqinf8ZBPsW3MnlGoFf4+FtenpMYxo+4s5Lsp7PyEtlQjGGFP3tXvqg862Goe+8LUdD0+xZURPkAyhAqb2d5Bz87qenpBWz7DZxKYi12dptRmdvlSOEfV/4Mw8gvyaBKM82BabgqW5ZRRyWWQ4JLn1and+cgo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 22B303858D20
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
	by mailout12.t-online.de (Postfix) with SMTP id 67C9D531
	for <cygwin-patches@cygwin.com>; Sun, 16 Mar 2025 15:09:32 +0100 (CET)
Received: from [192.168.2.101] ([87.187.37.162]) by fwd78.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1ttogC-0u6nj60; Sun, 16 Mar 2025 15:09:28 +0100
Subject: Re: [PATCH] Cygwin: Carry process affinity through to result
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin/2025-March/257628.html>
 <20250316092247.391-1-mark@maxrnd.com>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <af93e922-7fb4-9479-60d6-88718925d149@t-online.de>
Date: Sun, 16 Mar 2025 15:09:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <20250316092247.391-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1742134168-2D7F840E-F92F262E/0/0 CLEAN NORMAL
X-TOI-MSGID: cc350980-3b78-498c-b3a4-3dd8fe08e213
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mark Geisert wrote:
> Due to deficient testing, the current code doesn't return a valid result
> to users of sched_getaffinity().  Carry the result procmask through to
> the generation of result cpu mask.
>
> Recognize Windows' limitation that if the process is multi-group (i.e.,
> has threads in multiple cpu groups) there is no visibility to which
> processors in other groups are being used.  One could remedy this by
> looping through all the process' threads, but that could be expensive
> so is left for future contemplation.
>
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257616.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 641ecb07533e ("Cygwin: Implement sched_[gs]etaffinity()")

Could only test the single cpu group (aka single physical cpu) case 
which is the most common, I guess. Works as expected:

$ uname -r
3.6.0-dev-440-g5ec497dc80bc-dirty.x86_64

$ grep '^model name' /proc/cpuinfo | uniq -c
      28 model name      : Intel(R) Core(TM) i7-14700K

$ stress-ng --pthread 1 -v &
[1] 1323
...
stress-ng: debug: [1324] pthread: [1324] started (instance 0 on CPU 10)

$ taskset -c -p 1324
pid 1324's current affinity list: 0-27

$ taskset -p fff0000 1324 # All E-cores
pid 1324's current affinity mask: fffffff
pid 1324's new affinity mask: fff0000

$ taskset -p fff5555 1324 # All cores but no HT
pid 1324's current affinity mask: fff0000
pid 1324's new affinity mask: fff5555

$ taskset -c -p 8,9 1324 # P-core 4 with HT
pid 1324's current affinity list: 0,2,4,6,8,10,12,14,16-27
pid 1324's new affinity list: 8,9

$ taskset -p 1324
pid 1324's current affinity mask: 300

The settings have the desired effect on reported core usage.

-- 
Thanks,
Christian

