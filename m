Return-Path: <SRS0=giei=CZ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-042.btinternet.com (mailomta1-sa.btinternet.com [213.120.69.7])
	by sourceware.org (Postfix) with ESMTPS id 406E7384F4A3
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 15:46:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 406E7384F4A3
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20230707154626.DDPD20040.sa-prd-fep-042.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Fri, 7 Jul 2023 16:46:26 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 640682870E40B473
X-Originating-IP: [86.140.69.67]
X-OWM-Source-IP: 86.140.69.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrvddugdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekiedrudegtddrieelrdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkeeirddugedtrdeiledrieejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekiedqudegtddqieelqdeijedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghho
	uhhtqddttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (86.140.69.67) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 640682870E40B473 for cygwin-patches@cygwin.com; Fri, 7 Jul 2023 16:46:26 +0100
Message-ID: <8bc70b04-7c0b-15de-b090-e2f38c424dd9@dronecode.org.uk>
Date: Fri, 7 Jul 2023 16:46:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230707074121.7880-1-mark@maxrnd.com>
 <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/07/2023 10:44, Corinna Vinschen wrote:
> Hi Mark,
> 
> On Jul  7 00:41, Mark Geisert wrote:
>> The current version of <sys/cpuset.h> cannot be compiled by Clang due to
>> the use of __builtin* functions.  Their presence here was a dubious
>> optimization anyway, so their usage has been converted to standard
>> library functions.  A popcnt (population count of 1 bits in a word)
>> function is provided here because there isn't one in the standard library
>> or elsewhere in the Cygwin DLL.
> 
> And clang really doesn't provide it?  That's unfortunate.

I suspect if we had a current clang this would not be a problem.

There's probably something to be said for solving this problem by 
removing our old and unmaintained clang packages...

