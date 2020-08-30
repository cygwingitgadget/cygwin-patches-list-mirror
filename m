Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta9-sa.btinternet.com
 [213.120.69.15])
 by sourceware.org (Postfix) with ESMTPS id B0AC63857C4E
 for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020 15:00:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B0AC63857C4E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20200830150020.IEEA26396.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020 16:00:20 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.212]
X-OWM-Source-IP: 31.51.206.212 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudeffedgkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefufhfhvffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehgfehledvleegtdefvdeggfettddtheehiedtkeettedvkefhvddvvdevffdvgeenucfkphepfedurdehuddrvddtiedrvdduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepfedurdehuddrvddtiedrvdduvddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (31.51.206.212) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE0E74EF23 for cygwin-patches@cygwin.com;
 Sun, 30 Aug 2020 16:00:20 +0100
Subject: Re: [PATCH] Cygwin: Remove waitloop argument from try_to_debug()
References: <20200829144332.9065-1-jon.turney@dronecode.org.uk>
 <20200830124700.GP3272@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Message-ID: <c177f5c6-4fc3-cb98-5c35-2644ffa24ef3@dronecode.org.uk>
Date: Sun, 30 Aug 2020 16:00:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830124700.GP3272@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 30 Aug 2020 15:00:23 -0000

On 30/08/2020 13:47, Corinna Vinschen wrote:
> On Aug 29 15:43, Jon Turney wrote:
>> Currently, when using CYGWIN='error_start=dumper', the core dump written
>> in response to an exception is non-deterministic, as the faulting
>> process isn't stopped while the dumper is started (it even seems
>> possible in theory that the faulting process could have exited before
>> the dumper process attaches).
>>
>> Remove the waitloop argument, only used in this case, so the faulting
>> process busy-waits until the dump starts.
>>
>> Code archaeology to determine why the code is this way didn't really turn
>> up any answers, but this seems a low-risk change, as this only changes
>> the behaviour when:
>>
>>   - a debugger isn't already attached
>>   - an error_start is specified in CYGWIN env var
>>   - an exception has occurred which will be translated to a signal
>>
>> Future work: This probably can be further simplified to make it
>> completely synchronous by waiting for the dumper process to exit. This
>> would avoid the race condition of the dumper attaching and detaching
>> before we get around to checking for that (which we try to work around
>> by juggling thread priorities), and the failure state where the dumper
>> doesn't attach and we spin indefinitely.

So, on reflection, this idea is wrong, and it currently is the way it 
has to be.

If we use CYGWIN='error_start=gdb', we should be able to continue the 
thread which encountered an exception, which we can't do if it's blocked 
waiting for the error_start process to exit.

So I'll tweak the patch commentary before pushing.
