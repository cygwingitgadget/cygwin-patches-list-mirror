Return-Path: <SRS0=2g7I=4Q=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.159])
	by sourceware.org (Postfix) with ESMTP id A957F3858D39
	for <cygwin-patches@cygwin.com>; Tue,  7 Oct 2025 20:56:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A957F3858D39
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A957F3858D39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.159
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1759870606; cv=none;
	b=CXw8mSz3SZm2ZglOWm81iKegU1gskdegbRNVqkc7tqVOwA7iLsaclBVl/YbaaNksUAecm8DyyPEbw6OBj/7wA8Inb82QR74nfOQqUeNndDOLZNg8jWahg8R2pQU998VYDPthcbjhLsgxROiuDu0usxgiM8//sKefK5H44lRV/Hc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1759870606; c=relaxed/simple;
	bh=YA3lggyKG3T8fNfVahXT9ICIQ5O2sF/dOho2AsDNqFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=If3TGtHNRWfVvjXG+/BM2KFsNMqtV9T+2BW34/5U0PMVJdiil1m9roGJvKvw8gzA4W+0WFenKQ6F8YsI+qWoL6+gUvj/C4EA7we391K0Y5zHLeI60u/dZ8Ec6Yo/8xqTerNse4EA0/LYVpXS81Jr6gO0KlUl/DLf5t8wuCf1mLk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A957F3858D39
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1D480202EFAE
X-Originating-IP: [86.144.41.51]
X-OWM-Source-IP: 86.144.41.51
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddugeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddugeegrdeguddrhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeggedrgedurdehuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeggedqgeduqdehuddrrhgrnhhgvgekiedqudeggedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtkedpnhgspghrtghpthhtohepvddprhgtphhtthhopegt
	hihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepvghvghgvnhihsehkmhgrphhsrdgtoh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.41.51) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1D480202EFAE; Tue, 7 Oct 2025 21:56:44 +0100
Message-ID: <9ca46731-662a-4029-aecb-353b8d63d875@dronecode.org.uk>
Date: Tue, 7 Oct 2025 21:56:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING][PATCH] Check if gawk is available in gentls_offsets script
To: Evgeny Karpov <evgeny@kmaps.co>
References: <CABd5JDA8ftx5958KRzqGJH8yhO7bPU23RB5a10XqdJX4VWBgpg@mail.gmail.com>
 <CABd5JDD5zgqLG7yD6_gomaKKNABWEnh8pRjobPd43X4b=cz6bw@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <CABd5JDD5zgqLG7yD6_gomaKKNABWEnh8pRjobPd43X4b=cz6bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 06/10/2025 18:50, Evgeny Karpov wrote:
> A gentle reminder to review the patch.
> https://cygwin.com/pipermail/cygwin-patches/2025q3/014306.html

Sorry about the delay in looking at this.

This seems reasonable.

I wonder if it makes sense instead to check for this and other 
prerequisite tools (e.g. perl) up front in the configure script?


