Return-Path: <SRS0=IiyM=5C=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.123])
	by sourceware.org (Postfix) with ESMTP id EDCF23857BA0
	for <cygwin-patches@cygwin.com>; Sat, 25 Oct 2025 15:05:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EDCF23857BA0
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EDCF23857BA0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.123
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761404734; cv=none;
	b=vSdMp1uFvdXT2aylAcCBBeIoWu6SRvrFvNWBykkaRzczPE1v+LJC2xUdCxXieiTDIxwOuEwEsgrCu07GiiscCjvCBvUuysJ1gfEBIGnDwilc8cEiCTa/bJAJ+687CIHDmNJ/UMbF2AyGurB+wsbGzh+6MzkrT34aGd6zhOKQuMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761404734; c=relaxed/simple;
	bh=pBdA1MDw/BcWs/1S6qltMsQNyjgQdYWz8Qw8Pn8Cxmk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To; b=KyKDO/OANdKIBz+uMMHTP10GcIVjIYUMuwCdT9czBNuv+bEYTaVl6mV5gN2/Ng6NLQ5HyHBSlEPCyemJV42xwRvPVWCP9la0EcX+W/Vs5IOEbYo2wGhAZPs6eEXL3zjjSWfDsa6LQmS2ZS4rQ1h/bDhlwSY4v3tozX3sG6nDd0w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EDCF23857BA0
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68E889BE01867E76
X-Originating-IP: [86.140.112.39]
X-OWM-Source-IP: 86.140.112.39
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffvfhevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfefueduveefueeigfejgeduhffhtdfgheeivdefkeehkefhleevffeguddukeegnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddugedtrdduuddvrdefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduuddvrdefledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudduvddqfeelrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdejpdhnsggprhgtphhtthhopedvpdhrtghpthht
	oheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopegvvhhgvghnhieskhhmrghpshdrtgho
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.112.39) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68E889BE01867E76; Sat, 25 Oct 2025 16:05:31 +0100
Message-ID: <9bff6f17-4f06-497c-9c5d-11103cccb867@dronecode.org.uk>
Date: Sat, 25 Oct 2025 16:05:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING][PATCH] Check if gawk is available in gentls_offsets script
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Evgeny Karpov <evgeny@kmaps.co>
References: <CABd5JDA8ftx5958KRzqGJH8yhO7bPU23RB5a10XqdJX4VWBgpg@mail.gmail.com>
 <CABd5JDD5zgqLG7yD6_gomaKKNABWEnh8pRjobPd43X4b=cz6bw@mail.gmail.com>
 <9ca46731-662a-4029-aecb-353b8d63d875@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <9ca46731-662a-4029-aecb-353b8d63d875@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/10/2025 21:56, Jon Turney wrote:
> On 06/10/2025 18:50, Evgeny Karpov wrote:
>> A gentle reminder to review the patch.
>> https://cygwin.com/pipermail/cygwin-patches/2025q3/014306.html
> 
> Sorry about the delay in looking at this.
> 
> This seems reasonable.
> 
> I wonder if it makes sense instead to check for this and other 
> prerequisite tools (e.g. perl) up front in the configure script?
> 

On second thoughts, I think we'd still want this even in that case.

I tweaked the error message a bit (so it reports where it's coming from 
and is less prescriptive about the cause of the problem) and applied this.

Thanks!

