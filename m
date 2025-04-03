Return-Path: <SRS0=HLih=WV=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.146])
	by sourceware.org (Postfix) with ESMTP id CD02E384A890
	for <cygwin-patches@cygwin.com>; Thu,  3 Apr 2025 19:54:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CD02E384A890
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CD02E384A890
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.146
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743710068; cv=none;
	b=DPpTVKv/ASwkUkZHm1qur4DOhyqvZc9oB0puJrkukVakffDYqW4RMWNheyrjNNWpllDFydLYUhdmXYjTscYaX9e9FslzRvuvfyBs4zmVRQuNPHUgTAb5z2zFHxnLRrS2mdfkZhYwiSY/hS/gaYlTxx/xtkrI/fBv5Phzg7dKtA4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743710068; c=relaxed/simple;
	bh=LtGwU36TiGVsv7a8XSFY1h51IC832sfl0I10k/Mq5Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=OY2T2oTf1yAlRadS8kXl/fw9WbARN8D8d+K0uW0WMemibbzZ252YugjIeTu9uAvpJba7ca70NAjPWt6MMHVbeuclTu0qwHuOgLakY4Y6EpCBO+gXlbZyErej1IR08/F6CuhZLQYMVPKhybDr/1rwpOHmOrFga7JcEum7NM/SCYU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD02E384A890
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89C380219A717
X-Originating-IP: [81.129.146.194]
X-OWM-Source-IP: 81.129.146.194
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeelgeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekuddruddvledrudegiedrudelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduvdelrddugeeirdduleegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqdduleegrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttddvpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghs
	segthihgfihinhdrtghomhdprhgtphhtthhopehthhhirhhumhgrlhgrihdrnhgrghgrlhhinhhgrghmsehmuhhlthhitghorhgvfigrrhgvihhntgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.129.146.194) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89C380219A717; Thu, 3 Apr 2025 20:54:23 +0100
Message-ID: <abc8ffb4-9f97-4185-a54e-91b98a2db91f@dronecode.org.uk>
Date: Thu, 3 Apr 2025 20:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Fix compatibility with GCC 15
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
References: <MA0P287MB30822D5C378D6822F25ED7629FAF2@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <MA0P287MB30822D5C378D6822F25ED7629FAF2@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 02/04/2025 08:57, Thirumalai Nagalingam wrote:
> Hello,
> 
> Please find my patch attached for review.
> 
> Summary of Changes:
> 
> - GCC 15 defaults to `-std=gnu23`, causing build failures in `test suite`
>    due to outdated C function declarations.
> - This patch updates sbrk01.c and symlink01.c for GCC 15 compatibility.
> - These changes were not included in my previous patch.

Applied, thanks.

