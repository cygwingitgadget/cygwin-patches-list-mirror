Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta8-sa.btinternet.com
 [213.120.69.14])
 by sourceware.org (Postfix) with ESMTPS id 8B98D3861002
 for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020 19:53:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8B98D3861002
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-044.btinternet.com with ESMTP id
 <20201023195324.PCNG11685.sa-prd-fep-044.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020 20:53:24 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9AFBE17756E2D
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgddugeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeejkeeiffevheeiieehveehlefgheethedtjeefgefhheevuddtvdevffehgeehjeenucffohhmrghinhepshhtrggtkhhovhgvrhhflhhofidrtghomhenucfkphepkeeirddugedtrdduleegrdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddugedtrdduleegrdeijedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.140.194.67) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE17756E2D for cygwin-patches@cygwin.com;
 Fri, 23 Oct 2020 20:53:24 +0100
Subject: Re: [PATCH 3/6] gendef generates sigfe.s and cygwin.def
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
 <20201020134304.11281-4-jon.turney@dronecode.org.uk>
 <fe4bf082-427b-9611-39a5-8d50a79ba9f1@dronecode.org.uk>
 <20201021150727.GQ5492@calimero.vinschen.de>
 <CAB8Xom-TYSsKCgSY6BEo-jj6p3wySbiyQdpkCajmzqoN9=8bXQ@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <298a72f3-b438-d1f1-3de4-6e950f81c152@dronecode.org.uk>
Date: Fri, 23 Oct 2020 20:53:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <CAB8Xom-TYSsKCgSY6BEo-jj6p3wySbiyQdpkCajmzqoN9=8bXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1190.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Fri, 23 Oct 2020 19:53:27 -0000

On 23/10/2020 09:16, marco atzeri via Cygwin-patches wrote:
> 
> in the past sigfe.s was missing from the debuginfo
> https://stackoverflow.com/questions/44770147/gdb-in-cygwin-is-missing-sigfe-s
> 
> and I assume it is still missing, can you double check ?

Yes, I vaguely remember this being discussed in the past.

There's some sort of interaction with how cygport identifies source 
files to include in the debuginfo package which ends up not working 
correctly for this file.

(I'm not sure if it's due to failure to propagate the -fdebug-prefix-map 
which cygport adds to the compiler flags, or if this file is missing 
some expected .debug section, or something else entirely)

Anyhow, an investigation should start with looking why cygport omits 
this file.

