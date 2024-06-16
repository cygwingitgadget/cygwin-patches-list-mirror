Return-Path: <SRS0=M+Nw=NS=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-043.btinternet.com (mailomta9-re.btinternet.com [213.120.69.102])
	by sourceware.org (Postfix) with ESMTPS id 8ACF63858D28
	for <cygwin-patches@cygwin.com>; Sun, 16 Jun 2024 15:46:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8ACF63858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8ACF63858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.102
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1718552779; cv=none;
	b=uDnU4yrMhU1sny4PV0xOpGj9u3QZROMLqE8B/9WBgt36nf18kmQV5foADP2zcLA1dqPjWnY31aY0MFbDtvLbsi0cZCUMC95KvW8gLQ55NUzZhnjFzQyydb8FKszrBnvGNRaDte4kNKv5onQLO1C3HOX970BYAYgGVNYk0pSojpg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1718552779; c=relaxed/simple;
	bh=eM56bOUGOvShKjiuiijpi+Qghu/jvtmUhE8nV9aLAqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=aC8BpxiGV8GT6iZzL5QuczgjxtiTp5VEPqYBzYWYDITvDpdorLjVUNQn5NQgCxOfNftfKE+U5Lqw2+WxKa+mCJbDer1wavkYOfIuFjY2bxB43bRJGHawxVCh13KtY7lALt/UEallU4qah9dTJDk0zXmxrpCe8IsOe/LesIbmKbk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20240616154616.PUTU18910.re-prd-fep-043.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Sun, 16 Jun 2024 16:46:16 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B5E31507B1F7
X-Originating-IP: [86.139.167.83]
X-OWM-Source-IP: 86.139.167.83
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrfedvfedgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthekredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepteegtefgheeiudekjeelkeegffejvdegvdduffdvfedtvdekhedtffevfeegkeehnecukfhppeekiedrudefledrudeijedrkeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudefledrudeijedrkeefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepthgrkhgrshhhihdrhigrnhhosehnihhfthihrdhnvgdrjhhppdhrvghvkffrpehhohhsthekiedqudefledqudeijedqkeefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhht
	vghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehrvgdqphhrugdqrhhgohhuthdqtddtvd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.139.167.83) by re-prd-rgout-002.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B5E31507B1F7; Sun, 16 Jun 2024 16:46:16 +0100
Message-ID: <4f393d0f-3a43-4273-91b0-56af407247da@dronecode.org.uk>
Date: Sun, 16 Jun 2024 16:46:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Suppress a warning generated with w32api >=
 12.0.0
To: Takashi Yano <takashi.yano@nifty.ne.jp>
References: <20240607163724.29390-1-jon.turney@dronecode.org.uk>
 <20240609014342.7d72fdc0b67b0f094963bf2a@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20240609014342.7d72fdc0b67b0f094963bf2a@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 08/06/2024 17:43, Takashi Yano wrote:
> On Fri,  7 Jun 2024 17:37:24 +0100
> Jon Turney wrote:
>> w32api 12.0.0 adds the returns_twice attribute to RtlCaptureContext().
>> There's some data-flow interaction with using it inside a while loop
>> which causes a maybe-uninitialized warning.
>>
>> ../../../../winsup/cygwin/exceptions.cc: In member function 'int _cygtls::call_signal_handler()':                                                                                                │
>> ../../../../winsup/cygwin/exceptions.cc:1720:33: error: '<anonymous>' may be used uninitialized in this function [-Werror=maybe-uninitialized]                                                   │
[...]
> 
> It seems that the commit message include non UTF-8 chars.

Thanks for pointing that out. Hopefully, I fixed it before applying.

