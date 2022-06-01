Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta4-re.btinternet.com
 [213.120.69.97])
 by sourceware.org (Postfix) with ESMTPS id D12A93856DF8
 for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2022 17:48:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D12A93856DF8
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20220601174826.ESOY3123.re-prd-fep-046.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Wed, 1 Jun 2022 18:48:26 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A9124265ECF1B
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeffkeeigfdujeehteduiefgjeeltdelgeelteekudetfedtffefhfeufefgueettdenucfkphepkeeirddufeelrdduieejrdegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddthegnpdhinhgvthepkeeirddufeelrdduieejrdeguddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.105] (86.139.167.41) by
 re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A9124265ECF1B for cygwin-patches@cygwin.com;
 Wed, 1 Jun 2022 18:48:26 +0100
Message-ID: <27cd7dab-733f-f670-71a0-8f5dfc430a7c@dronecode.org.uk>
Date: Wed, 1 Jun 2022 18:48:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Cygwin: Set threadnames with SetThreadDescription()
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220529140315.18306-1-jon.turney@dronecode.org.uk>
 <b0d41109-f306-f896-03bc-468e87982450@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <b0d41109-f306-f896-03bc-468e87982450@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1193.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Wed, 01 Jun 2022 17:48:30 -0000

On 30/05/2022 16:37, Ken Brown wrote:
> On 5/29/2022 10:03 AM, Jon Turney wrote:
>> gdb master recently learnt how to use GetThreadDescription() [1], so set
>> threadnames using SetThreadDescription() [available since Windows
>> 101607] as well.
>>
>> This is superior to using a special exception to indicate the thread
>> name to the debugger, because the thread name isn't missed if you don't
>> have a debugger attached at the time it's set.
>>
>> It's not clear what the encoding of a thread name string is, we assume
>> UTF8 for the moment.
>>
>> For the moment, continue to use the old method as well, for the benefit
>> of older gdb versions etc.
> 
> LGTM, except for a few missing spaces (see below), although maybe you 
> did that deliberately since the existing code was already like that.

Nope, that's just me messing up on the coding style conventions.
