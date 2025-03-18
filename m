Return-Path: <SRS0=VJF9=WF=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 021413858D3C
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 08:04:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 021413858D3C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 021413858D3C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742285066; cv=none;
	b=U+TETjzjH8uLtLKU+ssMd3prQrP10FL49giJ4ot9VKZl+lNcY5KmU9VypC9bc7/lnLwFzdfi2/ZglgvbPmdm0INSTYs32jEfsQ8YGZHAZ54P/OZQyV5NROtHPQ3yZjBnOj40JV/ZU07ifCajRmp6S0dE+7r3S17RUI+MuiiAOuM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742285066; c=relaxed/simple;
	bh=8Vo1wAWgGaGXZup+2jwxj6DTX7KP4802tGdrK1VXZ9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=uMlj10AgtptBmxuXFDPZ7wvDDpN/lUVDA+3jQy8Gq0A0KREBcnJZLRTXBdLOy9Q7a+sqp8qtIACmNujL0UUOg8JtuqjbrVYrxmDcpSccIZOLrvsotFL6+/cLCzIjKaXOc7j+FCoPlhYefU6SioNJpWWWquwPgNLrbTfM0nVgXiU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 021413858D3C
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 52I89lx8048468
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 01:09:47 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdMOWrNB; Tue Mar 18 00:09:46 2025
Message-ID: <3d82539b-6de2-4c3d-ab40-2cccb0cafbb7@maxrnd.com>
Date: Tue, 18 Mar 2025 01:04:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Carry process affinity through to result
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin/2025-March/257628.html>
 <20250316092247.391-1-mark@maxrnd.com>
 <af93e922-7fb4-9479-60d6-88718925d149@t-online.de>
 <2ab6322a-6195-4144-8203-4cc1c30a181e@maxrnd.com>
 <Z9fo27vEcb39GWHc@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <Z9fo27vEcb39GWHc@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On 3/17/2025 2:18 AM, Corinna Vinschen wrote:
> On Mar 16 13:55, Mark Geisert wrote:
>> On 3/16/2025 7:09 AM, Christian Franke wrote:
>>> Mark Geisert wrote:
>> [...]
[..blah blah..]
>> So, v2 patch incoming shortly.  Comments from other folks welcome.
> 
> Only one: Thanks for looking into this stuff!

My pleasure.  Hopefully it'll be useful beyond stress testing :-).

> I wonder if, after your v2 patch, it's about time to release 3.6.0.

If you're asking me, I do think it's about time.  The feedback we got 
from the many release candidates seems to be settling down.  I believe 
(with Jeremy's recent message) we've taken care of all outstanding 
issues.  I vote for Takashi as MVP (Most Valuable Player) this release. 
Fingers crossed.
Thanks & Regards,

..mark
