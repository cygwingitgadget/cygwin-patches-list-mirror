Return-Path: <SRS0=tdPk=6Q=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 6067B4BA2E1C
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 10:51:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6067B4BA2E1C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6067B4BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765363864; cv=none;
	b=FLyFrez6EimMUR7WWbty2Mqj4hqlVdbKv+aWJ/qmBEUBRYsYOpfobKRcuu/mUA8kWybysmP9KntosYFClng/XxSdZzIt31+M295Mid5yqzt98X2FjE3XdIJvM9bW+bWbXkc1hMzWVN6ZSczCW4xEhNvBFE0rqu57iUjWq0xJHpc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765363864; c=relaxed/simple;
	bh=EW1r+ff56aG3BAgGzYA5HX8xIDnC7OLeOzmw5FloXec=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=FkvnWvtFdT5tZJMzrbIfbr4e9YQbDGkCzVawjF2VKk4Iu4fh0rm1E17foTLGRQ9BvMYNJmIcRk1L+LQ0c4wQa58YI64TMiUcfuP9I1yy3Z+0uqXrl6TEzc+X1wlcWIF7ZpdGsE+Ck5Bavw6ZBu+/burBAwwsUm0/1kpCqg2Xdc0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6067B4BA2E1C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1C950861BA01
X-Originating-IP: [81.158.20.216]
X-OWM-Source-IP: 81.158.20.216
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhepkfffgggfufhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvddtgfduudeuheevffdvjefgieeluefgieevvdfgheeuleffffegjeduudfhgedtnecukfhppeekuddrudehkedrvddtrddvudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekuddrudehkedrvddtrddvudeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduheekqddvtddqvdduiedrrhgrnhhgvgekuddqudehkedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddthedpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgih
	ghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (81.158.20.216) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1C950861BA01 for cygwin-patches@cygwin.com; Wed, 10 Dec 2025 10:51:02 +0000
Message-ID: <5a5dbe69-a66f-443f-b4ac-23c55ae20151@dronecode.org.uk>
Date: Wed, 10 Dec 2025 10:51:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Add a configure-time check for minimum w32api
 headers version
References: <20251121132455.8864-1-jon.turney@dronecode.org.uk>
 <aSC30HAFpdjJ0tFj@calimero.vinschen.de>
 <aThGo3gjqLPW7AD2@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <aThGo3gjqLPW7AD2@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 09/12/2025 15:56, Corinna Vinschen wrote:
> Jon? Ping?

Oops! Forgot about this, sorry. Now pushed.

I'll finish off my patch to remove now-unneeded conditionals from the code.

