Return-Path: <SRS0=Ek/d=GJ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.48])
	by sourceware.org (Postfix) with ESMTP id EEF104BA2E1D
	for <cygwin-patches@cygwin.com>; Sun, 16 Aug 2026 14:32:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EEF104BA2E1D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EEF104BA2E1D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.48
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786890731; cv=none;
	b=o0NMtAZRIGEGixP15QzZ3KTFTlPEhX6/7eaZkaa2ogxdIN+uUtiuZ4LKKKLg5dvM2qr4UUgBzKyKb/QBEwGMJpoiPfP+SPZvX6XGl2GUSLu8B8YZEJBc1Kfl0EChAEEjzuVzM3FpOXHnxdZdAuX2zBgmC/Uy+NnvfpMzxNoPLlc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786890731; c=relaxed/simple;
	bh=9tfkAEM9v+idXQn2CW2ONHc/CAsjy1ckcqQUZjZPGDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=qvnwf4CMi3A4T/YfdHVtQFkJpO/vKbP8C4JsyYrxgWTaZF8PNsEv2kH1tq5ppUZRLuW0i8DI/V4+TgxBNA5q3QBv5vOTgtkLos/UANbmwzKxqD1w2q1OsRoiCn6pnSkQLZIk++AyCkS/whLKWts+hos/yjk3QzXHzAhxc/SkVY0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EEF104BA2E1D
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7159F4022AFA59
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTFVRj/FKzObSIdpa1M0ninYpXYUDCk/pLmwaeqbPIxtp6TWUUgBjpteRw4Hk//6If3nju+xSfd38y7PTjXL484oRzRD6KjPTvWUWeYZrtN7Qz5jaeggr81t1dxbDZ4MPXQkMVbwEqnCWjqqGcUUdLSZFn2x0WiGuK+4rYcG/VVyamwTTu2hF/tAh6d2oWxMrom8uF7XbCJu9CXJtavhpYIoP3C2MOthWxO9P2yW2I2/Yk5ggcpoho6D/GzFpDZhoMwCo6gw+huMth3PPdSSqK0g1Hm6VYUWYObGv+7NxAVl+XYs7zR/bVQEtd0EQVBpEI/qsbEgZyIo1XM+U33YUYLNS118IqT9pfsRH1CzgxUsvoWl2PoPksj0ajTwBSUK7DI61YhEVRorspTmEZaaZWzdsdUX1wW46MgL4ukbm9M5fEYta8dMa7f2+PFKneS8rOqf/wK9VPH6o4ZbqG5t/5DyK4ZgW2JrL7TKIpVZayxM5cVxahEB5RGtqsLCpgbLN17M9TWB9MeYbrw3lXhRhXSfxDXP0qvM7FmxkFe/zLqSk8wzxuhFCa/Y8QI8Vso70qTXajmyuj440VWZdoLK2KX8qIZ4tlo0aXuTyrd1dTA7UjVvSa+59r+xCeSB66ldpIO3cOlTRYp0Y8xJAkT1o/q2iSzNJ+63b5pvPiPDIxPwDw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7159F4022AFA59; Sun, 16 Aug 2026 15:32:05 +0100
Message-ID: <55736009-9eb1-4cae-82d2-518644b206d2@dronecode.org.uk>
Date: Sun, 16 Aug 2026 15:32:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: Add AArch64 support for signal handling and
 ucontext
To: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
References: <PN3P287MB132037F714481EAD3C475C65F7C12@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN3P287MB132037F714481EAD3C475C65F7C12@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/07/2026 13:51, Aswin Kalies Ramkumar Mangayarkarasi wrote:
> Hi Jon,
> Thanks for the review.
No problem.

Thanks very much for revising your patch.

I've very sorry, but I'm struggling to find the time to look at this and 
the other outstanding aarch64 patches.

I haven't forgotten about this, and it's still on my list of things to 
do. I'll get to it as soon as I am able!

Thanks once again for working on this.

