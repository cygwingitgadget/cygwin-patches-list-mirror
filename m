Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-040.btinternet.com (mailomta1-re.btinternet.com
 [213.120.69.94])
 by sourceware.org (Postfix) with ESMTPS id 80976386F001
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 12:33:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 80976386F001
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-040.btinternet.com with ESMTP id
 <20200911123355.FBCH10362.re-prd-fep-040.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 13:33:55 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.141.128.138]
X-OWM-Source-IP: 86.141.128.138 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeetleffgeetieduueetheffveelvdfffeefkefghffhhedvhffghfetheetleetkeenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudeguddruddvkedrudefkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddugedurdduvdekrddufeekpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.141.128.138) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C2FD1068BFBB for cygwin-patches@cygwin.com;
 Fri, 11 Sep 2020 13:33:55 +0100
Subject: Re: [PATCH] Cygwin: ldd: Also look for not found DLLs when exit
 status is non-zero
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200910122740.8534-1-jon.turney@dronecode.org.uk>
 <20200910140455.GC4127@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <50e65d21-e501-99fe-80ef-e3b9c04bb4ed@dronecode.org.uk>
Date: Fri, 11 Sep 2020 13:33:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910140455.GC4127@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Fri, 11 Sep 2020 12:33:58 -0000

On 10/09/2020 15:04, Corinna Vinschen wrote:
> On Sep 10 13:27, Jon Turney wrote:
>> If the process exited with e.g. STATUS_DLL_NOT_FOUND, also process the
>> file to look for not found DLLs.
>>
>> (We currently only do this when a STATUS_DLL_NOT_FOUND exception occurs,
>> which I haven't managed to observe)
>>
>> This still isn't 100% correct, as it only examines the specified file
>> for missing DLLs, not recursively on the DLLs it depends upon.
> 
> Better than nothing?

Well, except when people are misled when investigating problems because 
they assume the output is accurate. (e.g. [1])

[1] https://cygwin.com/pipermail/cygwin/2020-September/246164.html

I guess what's maybe needed is some indication that an error occurred 
and the output may be incomplete if the inferior process exited with a 
non-zero status.  But not sure how we can do that while keeping the 
output compatible with linux ldd.

