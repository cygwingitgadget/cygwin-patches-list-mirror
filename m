Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-049.btinternet.com (mailomta27-sa.btinternet.com
 [213.120.69.33])
 by sourceware.org (Postfix) with ESMTPS id 086F0385802A
 for <cygwin-patches@cygwin.com>; Wed,  2 Dec 2020 16:08:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 086F0385802A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
 by sa-prd-fep-049.btinternet.com with ESMTP id
 <20201202160858.FYBA8377.sa-prd-fep-049.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Wed, 2 Dec 2020 16:08:58 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9B8A71D1C34C8
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudeigedgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkeeirddufeelrdduheekrddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddufeelrdduheekrddugedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B8A71D1C34C8 for cygwin-patches@cygwin.com;
 Wed, 2 Dec 2020 16:08:58 +0000
Subject: Re: [PATCH] Use automake (v3)
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
 <20201130104718.GD303847@calimero.vinschen.de>
 <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
 <20201201091833.GJ303847@calimero.vinschen.de>
 <20201201100738.GL303847@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <2c351d5e-3c89-3335-9dc2-89a230b57209@dronecode.org.uk>
Date: Wed, 2 Dec 2020 16:08:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201100738.GL303847@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Wed, 02 Dec 2020 16:09:01 -0000

On 01/12/2020 10:07, Corinna Vinschen wrote:
> 
> I also don't like how test-driver is generated in the toplevel
> source dir.  It should either be generated in source level winsup,

I assume the placement of this file is controlled by AC_CONFIG_AUX_DIR.

> if it's a file to be added to the repo (like aclocal.m4, etc), or,
> if generated at runtime evey time, it should go into the build dir,
> me thinks.

I'm using automake 1.11.6, to match the version used by newlib, which 
doesn't seem to generate this file.
