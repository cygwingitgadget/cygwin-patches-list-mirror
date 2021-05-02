Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta13-sa.btinternet.com
 [213.120.69.19])
 by sourceware.org (Postfix) with ESMTPS id 4343E3894418
 for <cygwin-patches@cygwin.com>; Sun,  2 May 2021 15:30:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4343E3894418
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-045.btinternet.com with ESMTP id
 <20210502153003.NUKS17040.sa-prd-fep-045.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Sun, 2 May 2021 16:30:03 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6038717E092619A5
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdefuddgudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffuvfhfkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepkeeuffeuuedthefhjedtveehveeikeehteejkeejtdehhfetteehheekvdeguedunecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (81.153.98.246) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 6038717E092619A5 for cygwin-patches@cygwin.com;
 Sun, 2 May 2021 16:30:03 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Use automake (v5)
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
Message-ID: <d4964f52-518e-205b-c44f-02bea6a225d6@dronecode.org.uk>
Date: Sun, 2 May 2021 16:28:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3570.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Sun, 02 May 2021 15:30:05 -0000

On 20/04/2021 21:13, Jon Turney wrote:
> For ease of reviewing, this patch doesn't contain changes to generated
> files which would be made by running ./autogen.sh.

Some possible items of future work I noted:

* Documentation is now always built (rather than dangerously ignoring 
any errors)

Although this is half-arsed at the moment, as we don't require the 
documentation tools at configure time, we'll just fail when the rules 
are executed if they are missing.

Perhaps there should be explicit configuration to build documentation or 
not?

* Use AM_V_GEN to silence (most?) custom rules

* -Wimplicit-fallthrough, -Werror could (should?) be set in top-level 
Makefile.am.common, rather than individual subdirs

* Some custom rules have multiple outputs and workarounds to ensure the 
rule only runs once

Ideally these would be re-written using make 4.3 'grouped targets', but 
perhaps not yet...

* Some custom rules could be simplified

e.g. mkvers.sh generates version.cc and winver.rc, then runs windres on 
windver.rc

* 'make our include directories absolute so we don't have to worry about 
making them relative to the subdirectory we happen to be building in' is 
sufficiently obscure that it at least deserves a comment.

* Rather than a huge list of --replace options to mkimport inline in the 
Makefile, it might be more sensible to augment that tool the read a list 
of replacement names from a file, and put them there.
