Return-Path: <SRS0=9CMs=XO=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.62])
	by sourceware.org (Postfix) with ESMTP id 7FC4F3858D3C
	for <cygwin-patches@cygwin.com>; Mon, 28 Apr 2025 21:22:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7FC4F3858D3C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7FC4F3858D3C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745875358; cv=none;
	b=kqrTS16xXHjnNQliEBAqMogxMss95EdCeJ0lxvm/zEnbZmDNnrOof7Hf5Wrh6nYI2VD+AsFDAv+MQN5twDTZnmtMJ+G5RJOQnyCD0Kx04ZZLCzXIwrdFEZSO9IUBqKcnzfEyjQbT8HREi7kisuOU4s+CFNkhYWGTaIjdA4v2elg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745875358; c=relaxed/simple;
	bh=4Nc4PS7cmJihbMtBr74mTMCoAcSZ9RlTcXZucF5LW8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=elIX0fJaDuLqeFeqdrOv+68yI7ccx9+0qVXQ/09z5Kx9T4zuiBZJVdikJJY6F30m41XIpyVWYPuIguAp3l2vyYrRSccZmN47I135RDt/vueDA6FyXyKpJ5sppvJse3UazcI9Pyd1ha3fMSCQ9s3mw5NEnq7NHCIdnewNIapiGYw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7FC4F3858D3C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E4E04F81E96
X-Originating-IP: [86.143.43.122]
X-OWM-Source-IP: 86.143.43.122
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgeegueetieegieekgfehtefhteeuhfdtgeeiieekheetheeffedvuefftdevjeffnecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucfkphepkeeirddugeefrdegfedruddvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugeefrdegfedruddvvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegfedqgeefqdduvddvrdhrrghnghgvkeeiqddugeefrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddupdhnsggprhgtphhtthhopedvpdhr
	tghpthhtohepvehhrhhishhtihgrnhdrhfhrrghnkhgvsehtqdhonhhlihhnvgdruggvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.143.43.122) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E4E04F81E96; Mon, 28 Apr 2025 22:22:36 +0100
Message-ID: <274da5b5-b94c-4ccc-8b58-713965a62e93@dronecode.org.uk>
Date: Mon, 28 Apr 2025 22:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: clock_settime: fail with EINVAL if tv_nsec is
 negative
To: Christian Franke <Christian.Franke@t-online.de>
References: <f21927b5-defe-529d-3095-0c1f51e23eb7@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <f21927b5-defe-529d-3095-0c1f51e23eb7@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 28/04/2025 16:43, Christian Franke wrote:
> A followup to:
> https://sourceware.org/pipermail/cygwin-patches/2025q2/013678.html

Thanks!

The SUS page for clock_settime() contains the following text:

> [EINVAL]
>     The tp argument specified a nanosecond value less than zero or greater than or equal to 1000 million. 

... so if we're going to validate tv_nsec, it seems that's the range to use

