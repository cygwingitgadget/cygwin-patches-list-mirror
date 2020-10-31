Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta18-re.btinternet.com
 [213.120.69.111])
 by sourceware.org (Postfix) with ESMTPS id E124C3861038
 for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2020 15:08:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E124C3861038
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20201031150759.SPEI18340.re-prd-fep-041.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2020 15:07:59 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9BDD0183B8E8C
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrleejgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgeeuhfekvdefieeghfehtdejheeigedthefhhfehfffgheehgedtffeljeetueeunecukfhppeekiedrudegtddrudelgedrieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudegtddrudelgedrieejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.140.194.67) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD0183B8E8C for cygwin-patches@cygwin.com;
 Sat, 31 Oct 2020 15:07:59 +0000
Subject: Re: [PATCH 0/3] Remove recursive configure for Cygwin
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201021194705.19056-1-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <e1cfb70c-d9ee-5f05-d61f-07b7742d5ab3@dronecode.org.uk>
Date: Sat, 31 Oct 2020 15:07:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201021194705.19056-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KHOP_HELO_FCRDNS, NICE_REPLY_A,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Sat, 31 Oct 2020 15:08:02 -0000

On 21/10/2020 20:47, Jon Turney wrote:
> A couple more Makefile/configure cleanups, and remove recursive configure
> for Cygwin.
> 
> For ease of reviewing, this patch series doesn't contain changes to
> generated files which would be made by an autoreconf.
> 
> Jon Turney (3):
>    Remove intro2man.stamp on clean
>    Drop AC_SUBST(build_exeext)
>    Remove recursive configure for cygwin
> 

This patch set is superseded.

