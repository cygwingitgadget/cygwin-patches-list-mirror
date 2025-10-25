Return-Path: <SRS0=IiyM=5C=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.0])
	by sourceware.org (Postfix) with ESMTP id 90AFC3857B84
	for <cygwin-patches@cygwin.com>; Sat, 25 Oct 2025 15:09:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 90AFC3857B84
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 90AFC3857B84
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.0
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761404980; cv=none;
	b=bsXRmgRyeWSlpekB07XLAXsusBidd3781w0NpU8g5CCPZBIZ/Jh/dP1/DhNf2hStfTtUmnUaQR40OqvmjE8KE8tEFNNRhZ9wDXiE9kYpWQ/97kutAIBTfqSFAQlmL83JYEiME8enc/cSMNeBJkVKGDF9ItCXRcrWxhUB+T8M3xQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761404980; c=relaxed/simple;
	bh=gXV1Oi7SCJgmeYHYAWcKcqvphkXu7sCdpoUgCB6A04Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=RjcZ6ULzCde9AVVv28o8KXG4zN8+9G1d9EBRCZkXkYZ+p044O4g5YElwN4zv+w6R694gjLG92D6b0f4RUN6pdrPbeCbEwJDPGxfPtJU2s8SXepe8SHqiSOyg1zB3m8xlUa/wsELv78hqqQyMXpJGy+kh/vTiwdM712GaYGX2voM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 90AFC3857B84
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1CA003C1C10B
X-Originating-IP: [86.140.112.39]
X-OWM-Source-IP: 86.140.112.39
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudegtddrudduvddrfeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudduvddrfeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduuddvqdefledrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtiedpnhgspghrtghpthhtohepvddprhgtphhtthhopeflohhhrghnnhgvshdrufgthhhinhguvghl
	ihhnsehgmhigrdguvgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.112.39) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1CA003C1C10B; Sat, 25 Oct 2025 16:09:38 +0100
Message-ID: <ad9aeeef-1c23-447a-93f0-26d88d9ab7dc@dronecode.org.uk>
Date: Sat, 25 Oct 2025 16:09:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Mention the extremely useful small_printf() function
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.4.cygwin.1760433371125.gitgitgadget@gmail.com>
 <pull.4.v2.cygwin.1760466678223.gitgitgadget@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <pull.4.v2.cygwin.1760466678223.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 14/10/2025 19:31, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This function came in real handy many, many times over the year whenever
> I needed to debug any issues with the MSYS2/Cygwin runtime, first
> instance was while debugging an issue that strace 'fixed'.
> 
> However, this function was not mentioned anywhere I looked, so it took
> me a good while to find out about it. Let's improve on that situation by
> mentioning it explicitly in the documentation about debugging the
> runtime.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>      Mention the extremely useful small_printf() function
>      
>      I have been using this function many times for debugging over the years,
>      and found that it was too hard to find originally.
>      
>      Changes since v1 (which did not make it to the list for technical
>      reasons that should be resolved by now):
>      
>       * Extend the comment about to talk about slight deviations from the
>         POSIX printf() function family.
>       * Improve on the commit message which previously was too terse.
Applied, thanks!
