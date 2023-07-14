Return-Path: <SRS0=XN3w=DA=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-044.btinternet.com (mailomta22-re.btinternet.com [213.120.69.115])
	by sourceware.org (Postfix) with ESMTPS id 797623858CD1
	for <cygwin-patches@cygwin.com>; Fri, 14 Jul 2023 10:44:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 797623858CD1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20230714104454.DXAW24338.re-prd-fep-044.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Fri, 14 Jul 2023 11:44:54 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 63FE976D0F66D961
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhstheprhgvqdhp
	rhguqdhrghhouhhtqddttddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 63FE976D0F66D961 for cygwin-patches@cygwin.com; Fri, 14 Jul 2023 11:44:54 +0100
Message-ID: <149da0fa-1de0-bd27-ae5c-1e5f8f567583@dronecode.org.uk>
Date: Fri, 14 Jul 2023 11:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Cygwin: pthread: Take note of schedparam in
 pthread_create
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230713131414.3013-1-jon.turney@dronecode.org.uk>
 <ZLA7vxwYFR0st7Xo@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZLA7vxwYFR0st7Xo@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/07/2023 19:00, Corinna Vinschen wrote:
> On Jul 13 14:14, Jon Turney wrote:
>> Take note of schedparam in any pthread_attr_t passed to pthread_create.
>>
>> postcreate() (racily, after the thread is actually created), sets the
>> scheduling priority if it's inherited, but precreate() doesn't store any
>> scheduling priority explicitly set via a non-default attr to create, so
>> schedparam.sched_priority has the default value of 0.
>>
>> (I think this is another long-standing bug exposed by 4b51e4c1.  Now we
>> don't lie about the actual thread priority, it's apparent it's not
>> really being set in this case.)
>>
>> Fixes testcase priority2.
> 
> Fixes: tag?

I cannot give you a specific commit which introduces this bug.

It might have been there all a long, or introduced somewhere a long the 
way, but masked until 4b51e4c1, but on second thoughts I'm not so sure 
about my reasoning about that.

> Signed-off-by: tag?

Sure, I'll add it.

