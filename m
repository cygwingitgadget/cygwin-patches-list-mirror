Return-Path: <SRS0=Bd9A=WP=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.237])
	by sourceware.org (Postfix) with ESMTP id 699793857BA5
	for <cygwin-patches@cygwin.com>; Fri, 28 Mar 2025 19:11:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 699793857BA5
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 699793857BA5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.237
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743189093; cv=none;
	b=hzk2iDSOhF6hLk07hcXjOcGbpYI0M1zzq4uqdxb+Zr6Bsqc/OhtiYtrmzWkG+dQjDbY0GT/Cn+hayjAgbREJiu8/KnrvJlckGvACWviboI/fwqP/S5I3FD6kw/K66M58Q2lrxHrPuEbVn5fK0giywMRXYVhX+Xn63RIKkkE96Rk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743189093; c=relaxed/simple;
	bh=t+rQzYMEXiOK2qIvMFdcqWLkTB85oSH8uJtwyr9jD04=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=QKqk6j7EuTFmkVYyT+/ii3HYXrGHHGXsyRehHgCFnbxvvr1zLrBMoZT7fNFZgU8RtqIF7LGzYgJbYX7JM3oqJvb2JixEXaYIOmtc720nfXB2tcDf7AzlWpmi44kPTHgscz4KKCAACz5ZLIsUnNhvXXp/Pbawfwae7fEez+VRxl8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 699793857BA5
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E7C015D3344
X-Originating-IP: [81.129.146.194]
X-OWM-Source-IP: 81.129.146.194
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekuddruddvledrudegiedrudelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduvdelrddugeeirdduleegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqdduleegrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddvpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghs
	segthihgfihinhdrtghomhdprhgtphhtthhopehthhhirhhumhgrlhgrihdrnhgrghgrlhhinhhgrghmsehmuhhlthhitghorhgvfigrrhgvihhntgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.129.146.194) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E7C015D3344; Fri, 28 Mar 2025 19:11:28 +0000
Message-ID: <c7de95ce-0195-4d8e-a38c-1d1fe76630f3@dronecode.org.uk>
Date: Fri, 28 Mar 2025 19:11:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Fix compatibility with GCC 15
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
References: <MA0P287MB3082D068B740A322C4A238229FA12@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <MA0P287MB3082D068B740A322C4A238229FA12@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_BL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 27/03/2025 12:41, Thirumalai Nagalingam wrote:
> Hello,
> 
> Please find my patch attached for review.
> 
> Summary of Changes:
> 
> - GCC 15 defaults to `-std=gnu23`, causing build failures in `testsuite`
>    due to outdated C function declarations. This patch updates the function
>    declarations to align with modern standards.
> - Introduced `cpu_relax.h` to support `cancel3` and `cancel5` tests by
>    providing architecture-specific instructions.

Applied, many thanks!

I tweaked the whitespace a bit and split the fix ARM64 processor idling 
during the cancellation tests into a separate patch.

