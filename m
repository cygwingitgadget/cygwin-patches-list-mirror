Return-Path: <SRS0=Byep=SQ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 6FC7E385802C
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 09:17:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6FC7E385802C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6FC7E385802C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732180647; cv=none;
	b=gL9U6IdjBOTbrk6SzM8XNTxwmDeUed3Nl/nM5SQk+z1YNDzq1DsKCkuBJz6y2bydXKwi5WMEou2a/F7XRh0OZ5O7v9Qyo1BbogqENg0KTI9LrZ+kDNzpfkQGYBYaVkyXYlShoqmrn1U5bUZ0Htt5NT6Hm7yHSPKNo7mfyzInIuM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732180647; c=relaxed/simple;
	bh=QMp/hwEMSlH/oJpPcSPwlLZahbscHWN7zj4fIN5/3kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=LfRodzuy5zg9A0OtuCdluKY1PluYYPGYYNUSobJIwuQhDToykEfBD4HGWvKhnI8iYpTcAFPTotKRf70G3HT3k6gbIicNeh/jeneRZxFBfEMLS18GCZttILY7WQKcx86TX2JY1BO7xSti20uPnolpGME6fB0hYSIzpYneG46Rkqs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4AL9KKWT007629
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 01:20:20 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdsSDoPm; Thu Nov 21 01:20:15 2024
Message-ID: <ec3c1378-b49b-4bb8-9fcc-e36807a93d08@maxrnd.com>
Date: Thu, 21 Nov 2024 01:17:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: New tool loadavg to maintain load averages
To: cygwin-patches@cygwin.com
References: <20241113062152.2225-1-mark@maxrnd.com>
 <ZzsyaAObt_lYWKUD@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <ZzsyaAObt_lYWKUD@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/18/2024 4:26 AM, Corinna Vinschen wrote:
> Hi Mark,
> 
> Not being a bugfix, this patch should go into the main branch and only
> update release/3.6.0.

Right, OK.  v3 will have the correction.  I was erroneously considering 
all the load average mods to be one ball of wax, so to speak.
Thanks,

..mark
