Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta18-sa.btinternet.com
 [213.120.69.24])
 by sourceware.org (Postfix) with ESMTPS id E76C23861878
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 21:45:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E76C23861878
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20201123163643.FKWS15135.sa-prd-fep-042.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 16:36:43 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9B8A71BC61630
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudegiedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkeeirddufeelrdduheekrddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddufeelrdduheekrddugedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B8A71BC61630 for cygwin-patches@cygwin.com;
 Mon, 23 Nov 2020 16:36:43 +0000
Subject: Re: [PATCH] Use automake (v2)
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201120155955.48309-1-jon.turney@dronecode.org.uk>
 <20201123152705.GT303847@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <8a28f841-f9f5-d338-a364-19df75884193@dronecode.org.uk>
Date: Mon, 23 Nov 2020 16:36:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123152705.GT303847@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3570.1 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_LINKBAIT, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 30 Nov 2020 21:45:27 -0000

On 23/11/2020 15:27, Corinna Vinschen wrote:
> Hi Jon,
> 
> Do I have to run autogen.sh for testing?
> 

Yes.

This patch also has an issue where the cygwin per-file {C,CXX}FLAGS 
aren't set when make is invoked in the top-level.

A revised version to address that will be forthcoming.
