Return-Path: <SRS0=IiyM=5C=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.6])
	by sourceware.org (Postfix) with ESMTP id 2D2573857B84
	for <cygwin-patches@cygwin.com>; Sat, 25 Oct 2025 16:08:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2D2573857B84
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2D2573857B84
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.6
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761408498; cv=none;
	b=golq7yRj6smY6wfh5XnppZNz5alwFz/it2atH9cZj4kzR1Q72kO+Fgm8996DNXMCcVm03WYGfQSizO9E0QTbFu8ZKxgmG1Br00JX0BLN+Z+GRoOr0OdN/lncRHhWho6CcsuItEhe0W7SRPOW5npqR2fsw2gDtHXyZO7sr7EcW4U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761408498; c=relaxed/simple;
	bh=O27q9j1UnQHRRPZyCMCi+yiNDL1mqPJnMWKEKdU55bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=CGFwozwuOmKLELc4yOy1hM/hE+hXqG3+VP/hc4BPS3DyQr0SQqUGzGITN3AVmIp4lz0rBdQArhic0zMhMNGEVdS0Bs+Lpe8kCxB3Wx4328e78WJTnRypgXncXIugSHQ72Pc9kr9um1qmQRczRh0d6K06XNl1LsmhLhtKAiYyhsU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2D2573857B84
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68C798FD03FED309
X-Originating-IP: [86.140.112.39]
X-OWM-Source-IP: 86.140.112.39
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddugedtrdduuddvrdefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduuddvrdefledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudduvddqfeelrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttddupdhnsggprhgtphhtthhopedvpdhrtghpthht
	oheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehthhhirhhumhgrlhgrihdrnhgrghgrlhhinhhgrghmsehmuhhlthhitghorhgvfigrrhgvihhntgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.112.39) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68C798FD03FED309; Sat, 25 Oct 2025 17:08:11 +0100
Message-ID: <1a8dda5a-6d7f-4436-b944-2aecefa95191@dronecode.org.uk>
Date: Sat, 25 Oct 2025 17:08:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: update cygbench call to use getprogname()
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
References: <MA0P287MB30823105B0A67CBEC9EA8D679FF2A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <MA0P287MB30823105B0A67CBEC9EA8D679FF2A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/10/2025 20:16, Thirumalai Nagalingam wrote:
> Hi,
> 
> Please find below small patch that replaces __progname with getprogname() in winsup/cygwin/dcrt0.cc.

Thanks.

>    *   On AArch64 local builds of Cygwin, __progname is not defined in the startup objects which causes a build failure.

Hmm... I think I probably need to see the rest of the associated changes 
to properly evaluate this.

Can you share a link?

>    *   This symbol is legacy to be replaced with getprogname() API, which is implemented in "winsup/cygwin/libc/bsdlib.cc" and exported across all supported targets.

It seems like it's a shortcoming of doc/posix.xml (the source for [1]) 
that it doesn't list data exports, only API functions.

But I think that probably needs a definitive list of obsolete elements 
removed on arm64.

[1] https://cygwin.com/cygwin-api/

>    *   Using getprogname() aligns Cygwin's startup code with the current libc conventions, avoids reliance on globals, and ensures consistent builds on aarch64 platforms.
> 
> 
> Thanks & regards
> Thirumalai N
> 
> ============
> In-lined patch:
> 
> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index 69c233c24..0758ec735 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -964,7 +964,7 @@ dll_crt0_1 (void *)
>     /* Disable case-insensitive globbing */
>     ignore_case_with_glob = false;
> 
> -  cygbench (__progname);
> +  cygbench (getprogname());

Is it possible to write program_invocation_short_name here?

(I can't really work out what's going on internally and externally with 
__progname and program_invocation_short_name. It looks like since 
bded8091c438d18e1d259864d773891a747c7576 we're meant to be exclusively 
using the latter internally, so this could just be a mistake)

(I actually wonder if getprogname() actually returns the right value 
now, and if so, how...)

