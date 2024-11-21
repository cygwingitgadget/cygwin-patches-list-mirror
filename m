Return-Path: <SRS0=Byep=SQ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 7F8BA3857B91
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 23:49:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7F8BA3857B91
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7F8BA3857B91
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732232947; cv=none;
	b=MDXJgITxR+9CqxMYfFzBpWR1/36hUPoBS1lotI30HuYABNF7BQc3+7NWPYl4gaZZDUkEGHS5flZjEP/9XuOlIdC3LH/zsujMBl/ojHbK6H0nNtSKg37J+5iFiPmY48L5gQNDvd694SMfcmxknX0g6UAXe2LhESZ2wVJ1H56vYm8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732232947; c=relaxed/simple;
	bh=oeIk9NGM6Hjynu5nJeLFwwBPAbVNoEBFeZXpg97q+vU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To; b=ldSJ9Rk5JlklWXdzQmjK22iG4wADLhOsPuCOmTbUnRJf1xhMQ9Wt3qoBpuBlZnRfmud3QioiZHRs0G29P/EtN4WklygabENxQKSuM/5Kp3HOl1HhIWasgS3RecvlTq9EoPt9DsWqO0Iv6XHlP56xVmf0/wLWe4TpScYiTpXb+GA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F8BA3857B91
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4ALNq3h6016719
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 15:52:03 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdINQjim; Thu Nov 21 15:52:02 2024
Message-ID: <96386d07-b8fe-4195-ade5-4b229d095156@maxrnd.com>
Date: Thu, 21 Nov 2024 15:49:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Minor updates to load average calculations
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
References: <20241113060354.2185-1-mark@maxrnd.com>
 <15e5a068-433b-4009-8cd2-e678a1249e9a@dronecode.org.uk>
 <0f3c12f6-0993-4d84-b7a9-b7919ba30a44@maxrnd.com>
Content-Language: en-US
In-Reply-To: <0f3c12f6-0993-4d84-b7a9-b7919ba30a44@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/21/2024 2:35 AM, Mark Geisert hallucinated:
>                                                       I used 
> SysInternals tool [I don't remember] to explore the namespace.

Turns out it was actually MSDN sample code under the topic "Browsing 
Performance Counters" at
https://learn.microsoft.com/en-us/windows/win32/perfctrs/browsing-performance-counters

..mark
