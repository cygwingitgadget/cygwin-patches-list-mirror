Return-Path: <SRS0=n1w5=5R=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.80])
	by sourceware.org (Postfix) with ESMTP id 4BE203858D33
	for <cygwin-patches@cygwin.com>; Sun,  9 Nov 2025 15:52:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4BE203858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4BE203858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762703535; cv=none;
	b=X8KG937+xPGGOFfyhNch4ZkV51KAuHOWOz2C5grG/y6Jbu3Bqzl57WCkAZmD3iaCow7234dIYCMXw/nhGol/p6rvomkO+valsZBh+UOxi1lajsgSSIUvqvUWhLjI1N0jDetgpN3J2xe+fsMWax1mu71tdwAFxS7OM5Sa8c0d4hY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762703535; c=relaxed/simple;
	bh=iBmJgeJ4Yl3hRTzzfvk+R8yYK9mgbupgzL4o2McEDyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=dx0zqTQrGcdbfDfBc/dQrFx/MhbKE88MX0gdEcyZiSUBUeipFzLqVTcEz269E5kL8JmGZZldV+WV/k1NKBhhcDPZ6ybGh65YL0u4DeRbRyZgvcxaIME3LszTKEzpvsWQ8ARRgDA/R0VU8Uj8DWi5TCv/s8kGGIq0wlU74wImlLE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4BE203858D33
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1CA0053F35B5
X-Originating-IP: [81.158.20.254]
X-OWM-Source-IP: 81.158.20.254
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleehkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnheplefhjedvjeeltdekfeeiueefgeeviedtkeehgeefveeuhefhfeekjeellefgleeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkedurdduheekrddvtddrvdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduheekrddvtddrvdehgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehkedqvddtqddvheegrdhrrghnghgvkeduqdduheekrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdeipdhnsggprhgtphhtthhopedvpdhrtghpthht
	oheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopegvvhhgvghnhieskhhmrghpshdrtgho
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.158.20.254) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1CA0053F35B5; Sun, 9 Nov 2025 15:52:13 +0000
Message-ID: <a1c26e42-7417-4175-b81c-b0fdf6c92d3d@dronecode.org.uk>
Date: Sun, 9 Nov 2025 15:52:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: aarch64: Add runtime pseudo relocation
To: Evgeny Karpov <evgeny@kmaps.co>
References: <CABd5JDC_=LLjR8_nRHxBzLCxMgEqMwJP+jf-E_CPvFxOYWR2nw@mail.gmail.com>
 <CABd5JDDKBrF8teHM3OPvp733-okLrbakjTMurAvprhN5_iSq8g@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <CABd5JDDKBrF8teHM3OPvp733-okLrbakjTMurAvprhN5_iSq8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/11/2025 21:29, Evgeny Karpov wrote:
> Jon Turney <jon.turney@dronecode.org.uk> wrote:
>> Thanks! I applied this.
>>
>> I believe this file is also present in the MinGW-w64 runtime, so you
>> should submit this change to that project as well.
> 
> Thanks. Yes, there is a similar implementation in MinGW (not upstreamed
> yet).
> https://github.com/eukarpov/mingw-windows-arm64/commit/a7b86e4867d47434c00b1542a4219e8864acd71c
> 
> Unfortunately the previous patch was incorrectly encoded.
> Here is the correct version.

Oh wow! I haven't seen a patch mangled in that particular way before :)

I was kind of baffled how that ever managed to compile, but of course, 
all the damage is to __aarch64__-conditional code.

I have applied your correction.

