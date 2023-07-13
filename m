Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-041.btinternet.com (mailomta17-sa.btinternet.com [213.120.69.23])
	by sourceware.org (Postfix) with ESMTPS id E44BF3858C74
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:43:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E44BF3858C74
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20230713114356.NQZX7232.sa-prd-fep-041.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 12:43:56 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64AECEEE0015022A
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhp
	rhguqdhrghhouhhtqddttddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64AECEEE0015022A for cygwin-patches@cygwin.com; Thu, 13 Jul 2023 12:43:56 +0100
Message-ID: <9452e007-75e6-8ecb-7e94-6d5ed208945a@dronecode.org.uk>
Date: Thu, 13 Jul 2023 12:43:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <20230713113904.1752-9-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/07/2023 12:39, Jon Turney wrote:
> These tests async thread cancellation of a thread that doesn't have any
> cancellation points.
> 
> Unfortunately, since 450f557f the async cancellation silently fails when
> the thread is inside the kernel function Sleep(), so it just exits
> normally after 10 seconds. (See the commentary in pthread::cancel() in
> thread.cc, where it checks if the target thread is inside the kernel,
> and silently converts the cancellation into a deferred one)
> 
> Work around this by busy-waiting rather than Sleep()ing for 10 seconds.
> 
> This is still somewhat fragile: the async cancel could still fail, if it
> happens to occur while we're inside the kernel function that time()
> calls.
> 
> v2:
> Do nothing more efficiently
> ---
>   winsup/testsuite/winsup.api/pthread/cancel3.c | 24 ++++++++++++++-----
>   winsup/testsuite/winsup.api/pthread/cancel5.c | 24 ++++++++++++++-----
>   2 files changed, 36 insertions(+), 12 deletions(-)
> 

This still seems a bit flaky, for the reasons identified. Perhaps 
there's a better way of doing a pause without a cancellation point or 
entering the kernel? Or a better way to test that async cancellation 
actually works?

