Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta22-sa.btinternet.com
 [213.120.69.28])
 by sourceware.org (Postfix) with ESMTPS id 36985385C406
 for <cygwin-patches@cygwin.com>; Sat, 26 Jun 2021 14:29:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 36985385C406
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20210626142907.WPUI7927.sa-prd-fep-042.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Sat, 26 Jun 2021 15:29:07 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 60D1576E00D11A6E
X-Originating-IP: [86.139.156.26]
X-OWM-Source-IP: 86.139.156.26 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrfeehtddgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkeeirddufeelrdduheeirddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddufeelrdduheeirddviedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.156.26) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 60D1576E00D11A6E for cygwin-patches@cygwin.com;
 Sat, 26 Jun 2021 15:29:07 +0100
Subject: Re: [PATCH] Cygwin: Zero out gmon header before use
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210623085614.1697-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <c2f3ddd1-d605-3dbc-6461-86026f9f0176@dronecode.org.uk>
Date: Sat, 26 Jun 2021 15:28:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623085614.1697-1-mark@maxrnd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3569.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
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
X-List-Received-Date: Sat, 26 Jun 2021 14:29:09 -0000

On 23/06/2021 09:56, Mark Geisert wrote:
> Tools that process gmon.out files can be confused by gmon header fields
> with garbage in them due to lack of initialization.  Repair that.

Applied. Thanks.
