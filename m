Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta12-sa.btinternet.com
 [213.120.69.18])
 by sourceware.org (Postfix) with ESMTPS id CF8053857C61
 for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2020 13:41:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CF8053857C61
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-045.btinternet.com with ESMTP id
 <20201116134113.ZUZO32244.sa-prd-fep-045.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2020 13:41:13 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9B6611AB29684
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgeeuhfekvdefieeghfehtdejheeigedthefhhfehfffgheehgedtffeljeetueeunecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B6611AB29684 for cygwin-patches@cygwin.com;
 Mon, 16 Nov 2020 13:41:13 +0000
Subject: Re: proc(5) and xml version
To: cygwin-patches@cygwin.com
References: <072e5252-9056-2af8-bf62-caec89830d38@SystematicSw.ab.ca>
 <20201116120721.GA41926@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <96c4beb9-67a6-5f71-9d22-c7e5bbc6a0fc@dronecode.org.uk>
Date: Mon, 16 Nov 2020 13:41:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116120721.GA41926@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Mon, 16 Nov 2020 13:41:16 -0000

On 16/11/2020 12:07, Corinna Vinschen wrote:
> Hi Brain,
> 
> On Nov 13 07:25, Brian Inglis wrote:
>> Hacked a Cygwin proc.5 man page FMOI over time, by combing through
>> fhandler_proc..., converted to proc-5.xml using doclifter, back with xmlto
>> as in the build, man width 80 output from both, and diff (all attached).
> 
> Nice idea!
> 

Yes, nice work.

>> Unsure how this might best be fitted into the distro (cygwin, cygwin-doc,
>> ...?) and/or whether there may be xml remediation possible to generate
>> verbatim output left justified with zero margin, and character value
>> displays, the major output issues in the diff? Content feedback is also
>> welcome.
> 
> This could replace the pathnames-proc and pathnames-proc-registry
> sections in specialnames.xml.
> 
> I think by using the refentry markup the man page would be generated
> automagically, but Jon (CCed) is the definitiv source of wisdom here.

Yes, all refentries in the UG should have manpages generated from them 
(only cygwin utilities currently).

The install rule in the Makefile would probably need extending to 
install *.5 to man5dir.

These would then be included in the cygwin-doc package.
