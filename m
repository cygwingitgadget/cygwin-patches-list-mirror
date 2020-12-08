Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-048.btinternet.com (mailomta1-re.btinternet.com
 [213.120.69.94])
 by sourceware.org (Postfix) with ESMTPS id 5C865396EC63
 for <cygwin-patches@cygwin.com>; Tue,  8 Dec 2020 14:43:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5C865396EC63
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-048.btinternet.com with ESMTP id
 <20201208144356.CGEF19284.re-prd-fep-048.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 8 Dec 2020 14:43:56 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9BDD01DA513B9
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnheptdevveffteelgfekieevieekleevvdehtddvgfdvgefgjedujedviedugeeghfefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddufeelrdduheekrddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddufeelrdduheekrddugedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD01DA513B9 for cygwin-patches@cygwin.com;
 Tue, 8 Dec 2020 14:43:56 +0000
Subject: Re: [PATCH 1/1] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn
To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2012031317260.9707@resin.csoft.net>
 <20201204121043.GB5295@calimero.vinschen.de>
 <alpine.BSO.2.21.2012041028060.9707@resin.csoft.net>
 <20201207094317.GI5295@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <26ef013a-d3ff-7389-c022-1b10568faf79@dronecode.org.uk>
Date: Tue, 8 Dec 2020 14:43:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207094317.GI5295@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Tue, 08 Dec 2020 14:43:59 -0000

On 07/12/2020 09:43, Corinna Vinschen wrote:
> On Dec  4 10:35, Jeremy Drake via Cygwin-patches wrote:
>> On Fri, 4 Dec 2020, Corinna Vinschen via Cygwin-patches wrote:
>>
>>> I'm not happy about a new CYGWIN option.
>>>
>>> Wouldn't it make sense, perhaps, to switch to CREATE_DEFAULT_ERROR_MODE
>>> for all non-Cygwin processes by default instead?

I agree.

Cygwin calls SetErrorMode(), so we need to use this flag to prevent that 
non-default behaviour being inherited by processes started with 
CreateProcess().

>> In fact, my first iteration was to set that flag unconditionally (relying
>> on the fact that SetErrorMode is called extremely early in Cygwin process
>> startup rather than only setting it for non-Cygwin processes), but I
>> received feedback that it would be better to put it behind an option:
>>
>> https://github.com/msys2/msys2-runtime/pull/18#issuecomment-723683606

I don't really understand what that comment is saying.  If Git for 
Windows doesn't want the default SetErrorMode(), it should change it itself.

(The same executable not started by Cygwin will get the default error 
mode in any case).

> Jon, thoughts on that as GDB maintainer?

I don't think this actually interacts with gdb.

gdb either CreateProcess() with DEBUG_PROCESS (which presumably 
overrides that flag) or attaches to an existing process (possibly due to 
being configured as a JIT debugger).
