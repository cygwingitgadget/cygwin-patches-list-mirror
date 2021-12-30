Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta21-sa.btinternet.com
 [213.120.69.27])
 by sourceware.org (Postfix) with ESMTPS id 518B53858D28
 for <cygwin-patches@cygwin.com>; Thu, 30 Dec 2021 15:44:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 518B53858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-045.btinternet.com with ESMTP id
 <20211230154405.XJYI20692.sa-prd-fep-045.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Thu, 30 Dec 2021 15:44:05 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613943C60F937027
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddruddvfedgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeihfeghfdviedvjeevkeektdejuddvhedtveetgeevkefgtdeigeejvdeutefhvdenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgnecukfhppeekuddruddvledrudegiedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtfegnpdhinhgvthepkedurdduvdelrddugeeirddvtdelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (81.129.146.209) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613943C60F937027 for cygwin-patches@cygwin.com;
 Thu, 30 Dec 2021 15:44:05 +0000
Message-ID: <9796eaa8-07f1-0f14-3105-9ce482005b17@dronecode.org.uk>
Date: Thu, 30 Dec 2021 15:44:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <90dd8b13-8e7f-97b8-b480-299a9d64836e@dronecode.org.uk>
 <alpine.BSO.2.21.2112282143180.11760@resin.csoft.net>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <alpine.BSO.2.21.2112282143180.11760@resin.csoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1193.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 30 Dec 2021 15:44:07 -0000

On 29/12/2021 05:45, Jeremy Drake wrote:
> On Mon, 27 Dec 2021, Jon Turney wrote:
> 
>> On 24/12/2021 00:29, Jeremy Drake via Cygwin-patches wrote:
>>> again, so I can't confirm this.  I took a core with 'dumper' but gdb
>>> doesn't want to load it (it says Core file format not supported, maybe
>>> something with msys2's gdb?).
>>
>> I think you need gdb 11 (for this patch set [1], which is also in cygwin's
>> gdb 10 package) to read x86_64 cygwin core dumps.
>>
>> [1] https://sourceware.org/pipermail/gdb-patches/2020-August/171232.html
> 
> Thanks, this was the problem.  But the core dump wasn't much help anyway,
> the stuff I was interested in was pre-exception, and the backtrace
> seemed to stop at the exception handling (unlike when 'live' debugging
> when the stack trace continued).

Hmm..  That's probably a bug of some sort, since I think the two methods 
should produce the same results...
