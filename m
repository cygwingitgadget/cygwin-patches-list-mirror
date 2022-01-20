Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-041.btinternet.com (mailomta22-sa.btinternet.com
 [213.120.69.28])
 by sourceware.org (Postfix) with ESMTPS id 9ADEE3858407
 for <cygwin-patches@cygwin.com>; Thu, 20 Jan 2022 14:58:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9ADEE3858407
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
 by sa-prd-fep-041.btinternet.com with ESMTP id
 <20220120145832.FWHD30965.sa-prd-fep-041.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Thu, 20 Jan 2022 14:58:32 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 6139452E11F27216
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudekgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueduheejledvleffkeelheevkeffvefhiedthfekjeeljeetvdegjefhvedvvefgnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppeekuddruddvledrudegiedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtfegnpdhinhgvthepkedurdduvdelrddugeeirddvtdelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (81.129.146.209) by
 sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139452E11F27216 for cygwin-patches@cygwin.com;
 Thu, 20 Jan 2022 14:58:32 +0000
Message-ID: <2ea2f6f7-a057-d2d5-4731-27f1b0f3eb72@dronecode.org.uk>
Date: Thu, 20 Jan 2022 14:58:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] Silence more build rules
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
 <YegioLvRwD4+T3PF@calimero.vinschen.de>
 <41c0e46f-bbd3-6e7a-e433-66fa94f95187@SystematicSw.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <41c0e46f-bbd3-6e7a-e433-66fa94f95187@SystematicSw.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3571.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 20 Jan 2022 14:58:35 -0000

On 19/01/2022 19:12, Brian Inglis wrote:
> On 2022-01-19 07:39, Corinna Vinschen wrote:
>> On Jan 19 13:15, Jon Turney wrote:
>>> Jon Turney (4):
>>>    Cygwin: silence most custom build rules
>>>    Cygwin: silence dblatex when building PDFs
>>>    Cygwin: silence xsltproc when writing chunked html
>>>    Cygwin: silence xsltproc when writing manpages
>>>
>>>   winsup/cygwin/Makefile.am | 38 ++++++++++++++++-----------------
>>>   winsup/doc/Makefile.am    | 45 ++++++++++++++++++++++-----------------
>>>   2 files changed, 45 insertions(+), 38 deletions(-)
> 
> Hopefully these are now changed to be the helpful type of build rules 
> that output only "CC foo" when commands work and show the complete 
> command line and diagnostics when commands err?
> 
> Or do we have to now have to rerun with V=1 to see error diagnostics?

This just uses automake's standard way of silencing make [1], so the 
latter is correct. You will need to run 'make V=1' to see the command.

Doing the former with full generality using make seems very challenging. 
Please submit patches to automake for that! :)

[1] 
https://www.gnu.org/software/automake/manual/html_node/Automake-Silent-Rules.html
