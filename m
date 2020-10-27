Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta30-sa.btinternet.com
 [213.120.69.36])
 by sourceware.org (Postfix) with ESMTPS id EBD4C3861925
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 16:07:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EBD4C3861925
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20201027160724.FJEA15135.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 16:07:24 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9AFBE17F87A13
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffhvfhfkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnheptdelheeutdevffevudffhfeiudekffdvkeekgfeuleetudeluddtueetgffhtdfgnecukfhppeekiedrudegtddrudelgedrieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudegtddrudelgedrieejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.140.194.67) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE17F87A13 for cygwin-patches@cygwin.com;
 Tue, 27 Oct 2020 16:07:24 +0000
Subject: Re: [PATCH 3/3] Remove recursive configure for cygwin
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201021194705.19056-1-jon.turney@dronecode.org.uk>
 <20201021194705.19056-4-jon.turney@dronecode.org.uk>
 <20201022172710.GS5492@calimero.vinschen.de>
 <fb4a8bf6-9b4a-3e77-cb32-bdd7fcce49fe@dronecode.org.uk>
Message-ID: <411456ea-6c59-67a2-3b72-893eaf2f706b@dronecode.org.uk>
Date: Tue, 27 Oct 2020 16:07:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <fb4a8bf6-9b4a-3e77-cb32-bdd7fcce49fe@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1192.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 27 Oct 2020 16:07:27 -0000

On 22/10/2020 19:57, Jon Turney wrote:
> 
> I actually skimped on writing the rules which reconfigure when needed 
> when make is run in a subdirectory, as working them out seemed complex 
> and a bit redundant, as when I convert to automake, it writes them for you.
> 
> I guess I should take another look at that.

Having taken another look, I can't see how to get the necessary 
machinery into config.status, without using automake already.
