Return-Path: <SRS0=OYnK=DG=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-045.btinternet.com (mailomta19-sa.btinternet.com [213.120.69.25])
	by sourceware.org (Postfix) with ESMTPS id DDBE13858CDB
	for <cygwin-patches@cygwin.com>; Thu, 20 Jul 2023 12:55:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DDBE13858CDB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20230720125555.LJQX29451.sa-prd-fep-045.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Thu, 20 Jul 2023 13:55:55 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6406812D0FA472A3
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhp
	rhguqdhrghhouhhtqddttdeg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 6406812D0FA472A3 for cygwin-patches@cygwin.com; Thu, 20 Jul 2023 13:55:55 +0100
Message-ID: <0a200d0b-877e-48d5-7f20-c602b8d92de6@dronecode.org.uk>
Date: Thu, 20 Jul 2023 13:55:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Testsuite adjustment and relevant fix
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
 <ZLgCVymLYi9ZB0uZ@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZLgCVymLYi9ZB0uZ@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 19/07/2023 16:33, Corinna Vinschen wrote:
> On Jul 19 13:41, Jon Turney wrote:
>> [1/2] has the side effect of flipping test stat06 from working to failing.
>> [2/2] fixes that
>>
>> When run with TDIRECTORY set, libltp just uses that directory and assumes
>> something else will clean it up.
>>
>> When TDIRECTORY is not set, libltp creates a subdirectory under /tmp, and when
>> the test is completed, removes the expected files and verifies that the
>> directory is empty.
>>
>> stat06 fails that check, because it creates the a file named "file" there, and
>> tries stat("file", -1), testing that it returns the expected value EFAULT.
>>
>> "file" is removed, but lingers in the STATUS_DELETE_PENDING state until the
>> Windows handle which stat_worker() leaks when an exception occurs is closed
>> (when the processes exits).
> 
> Great find. Please push.

So, it seems this doesn't work in an optimized build, as fh is always 
NULL when we get around to deleting it after a fault.

I'm thinking that I've written this wrong somehow (horses), rather than 
it being some complex problem with how the optimizer interacts with all 
the memory and register barriers the exception handling uses (zebras)

>> Future work: It looks like similar problems might generically occur in similar
>> code througout syscalls.cc.
> 
> Uh oh...

I mean, I have no evidence that there are any problems.

If I had infinite time, maybe I'd review the source code to see if there 
are any other instances where we fail to properly dispose of objects 
created in a __try block...

