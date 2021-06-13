Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta6-sa.btinternet.com
 [213.120.69.12])
 by sourceware.org (Postfix) with ESMTPS id 89474386180A
 for <cygwin-patches@cygwin.com>; Sun, 13 Jun 2021 14:41:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 89474386180A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20210613144117.YJLX7927.sa-prd-fep-042.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sun, 13 Jun 2021 15:41:17 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6038717E0F3AB587
X-Originating-IP: [86.139.156.26]
X-OWM-Source-IP: 86.139.156.26 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrfedvfedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedtveevffetlefgkeeiveeikeelvedvhedtvdfgvdeggfejudejvdeiudeggefhfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeekiedrudefledrudehiedrvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudefledrudehiedrvdeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehmrghrkhesmhgrgihrnhgurdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.156.26) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 6038717E0F3AB587; Sun, 13 Jun 2021 15:41:17 +0100
Subject: Re: [PATCH] Cygwin: New tool: cygmon
To: Mark Geisert <mark@maxrnd.com>, Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210612064639.2107-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <6c87c0bd-bc3c-f2b0-f318-26afadfebf1f@dronecode.org.uk>
Date: Sun, 13 Jun 2021 15:40:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210612064639.2107-1-mark@maxrnd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1198.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Sun, 13 Jun 2021 14:41:20 -0000

On 12/06/2021 07:46, Mark Geisert wrote:
> This tool is a sampling profiler of Cygwin programs with their DLLs.
> Presently its development is managed at https://github.com/mgeisert/cygmon.
> Documentation of cygmon has been added to the usual doc/utils.xml file.

Nice!

How attached are you to the name?

There's nothing cygwin specific about this (you could profile any 
Windows executable), so does it really need 'cyg' in the name?

It's a profiler, so what is 'mon' short for?

A more detailed review to follow.

> There are a couple of one-line fixes to unrelated files for minor issues
> noticed while implementing cygmon.  The files involved are gmon.c and
> doc/utils.xml (one line not part of the cygmon updates to that file).

Please submit the gmon fix as a separate patch, ideally with some 
commentary about what it fixes.

> diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
> index 22bd86904..2f256d602 100644
> --- a/winsup/doc/utils.xml
> +++ b/winsup/doc/utils.xml
[...]
> +
> +    <refsect1 id="cygmon-desc">
> +      <title>Description</title>
> +    <para>The <command>cygmon</command> utility executes a given program, and
> +      optionally the children of that program, collecting the location of the
> +      CPU instruction pointer (IP) many times per second. This gives a profile
> +      of the program's execution, showing where the most time is being spent.
> +      This profiling technique is called "IP sampling".</para>

Contrasting this with how 'ssp' profiles (and vice versa there) would be 
nice.

> +
> +    <para>A novel feature of <command>cygmon</command> is that time spent in
> +      DLLs loaded with or by your program is profiled too. You use
> +      <command>gprof</command> to process and display the resulting profile
> +      information. In this fashion you can determine whether your own code,
> +      the Cygwin DLL, or another DLL has "hot spots" that might benefit from
> +      tuning.</para>
> +
> +    <para> Note that <command>cygmon</command> is a native Windows program
> +      and so does not rely on the Cygwin DLL itself (you can verify this with
> +      <command>cygcheck</command>). As a result it does not understand
> +      symlinks in its command line.</para>
> +    </refsect1>

