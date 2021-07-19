Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta18-re.btinternet.com
 [213.120.69.111])
 by sourceware.org (Postfix) with ESMTPS id 6CACE3954084
 for <cygwin-patches@cygwin.com>; Mon, 19 Jul 2021 15:44:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6CACE3954084
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
 by re-prd-fep-049.btinternet.com with ESMTP id
 <20210719154419.OGPO8938.re-prd-fep-049.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
 Mon, 19 Jul 2021 16:44:19 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 60DCD71102BB8B7B
X-Originating-IP: [86.139.167.43]
X-OWM-Source-IP: 86.139.167.43 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffhvfhfkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnheptdelvdejvdfggfekieffhfefvdegjedtuddtuedvfeeffffhvdffieduieeiteelnecuffhomhgrihhnpegrphhpvhgvhihorhdrtghomhenucfkphepkeeirddufeelrdduieejrdegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddufeelrdduieejrdegfedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeomhgrrhhksehmrgigrhhnugdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.167.43) by
 re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 60DCD71102BB8B7B; Mon, 19 Jul 2021 16:44:19 +0100
Subject: Re: [PATCH 1/3] Cygwin: New tool: profiler
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210716044957.5298-1-mark@maxrnd.com>
 <YPVON/D5dvOYFwfU@calimero.vinschen.de>
 <616e4815-1b8b-8c3d-0dfc-ff6c6dc6fd85@dronecode.org.uk>
Message-ID: <5acddcda-7fa9-e854-911c-27af2f13a22c@dronecode.org.uk>
Date: Mon, 19 Jul 2021 16:43:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <616e4815-1b8b-8c3d-0dfc-ff6c6dc6fd85@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3571.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 19 Jul 2021 15:44:22 -0000

On 19/07/2021 15:23, Jon Turney wrote:
> On 19/07/2021 11:04, Corinna Vinschen wrote:
>> Hi Matt,
>>
>> On Jul 15 21:49, Mark Geisert wrote:
>>> The new tool formerly known as cygmon is renamed to 'profiler'.  For the
>>> name I considered 'ipsampler' and could not think of any others.  I'm 
>>> open
>>> to a different name if any is suggested.
>>>
>>> I decided that a discussion of the pros and cons of this profiler vs the
>>> existing ssp should probably be in the "Profiling Cygwin Programs" 
>>> section
>>> of the Cygwin User's Guide rather than in the help for either.  That
>>> material will be supplied at some point.
>>>
>>> CONTEXT buffers are made child-specific and thus thread-specific since
>>> there is one profiler thread for each child program being profiled.
>>>
>>> The SetThreadPriority() warning comment has been expanded.
>>>
>>> chmod() works on Cygwin so the "//XXX ineffective" comment is gone.
>>>
>>> I decided to make the "sample all executable sections" and "sample
>>> dynamically generated code" suggestions simply expanded comments for 
>>> now.
>>>
>>> The profiler program is now a Cygwin exe rather than a native exe.
>>
>> The patchset LGTM, but for the details I'd like jturney to have a look
>> and approve it eventually.
> 
> Thanks.  I applied these patches.
> 
> A few small issues you might consider addressing in follow-ups.

It also seems there are some format warnings on x86, see

https://ci.appveyor.com/project/cygwin/cygwin/builds/40046785/job/fie6x4ta11v5nrjo
