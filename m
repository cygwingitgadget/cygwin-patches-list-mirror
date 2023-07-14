Return-Path: <SRS0=XN3w=DA=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-041.btinternet.com (mailomta6-sa.btinternet.com [213.120.69.12])
	by sourceware.org (Postfix) with ESMTPS id AD3313857B98
	for <cygwin-patches@cygwin.com>; Fri, 14 Jul 2023 13:04:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AD3313857B98
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20230714130414.THTW7232.sa-prd-fep-041.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Fri, 14 Jul 2023 14:04:14 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64AECDCC00313B60
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhp
	rhguqdhrghhouhhtqddttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64AECDCC00313B60 for cygwin-patches@cygwin.com; Fri, 14 Jul 2023 14:04:14 +0100
Message-ID: <13b3ff8d-5829-4b9c-8995-35be2f24c0da@dronecode.org.uk>
Date: Fri, 14 Jul 2023 14:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/11] Cygwin: testsuite: Fix a buffer overflow in
 symlink01
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-10-jon.turney@dronecode.org.uk>
 <ZLA/ywCZHkougQ5F@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZLA/ywCZHkougQ5F@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/07/2023 19:17, Corinna Vinschen wrote:
> On Jul 13 12:39, Jon Turney wrote:
>> See ltp commit 44d51c3f
> 
> Can you please add some text which helps the reader to understand the
> issue without having to refer to the ltp repo?

Sure, I added that.

