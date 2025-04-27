Return-Path: <SRS0=xsK9=XN=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.240])
	by sourceware.org (Postfix) with ESMTP id F1C2D3858D1E
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 18:32:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F1C2D3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F1C2D3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.240
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745778776; cv=none;
	b=Tgi/S8B+F6SgAr+mzULPKV64b+NtQ2u8YSG/koxftLFtY61Ipg3O6c56d1bokTPMPYLytnYv0a9gPfyEPc25jIxlHV9AllVPnAsmr613NgIyJOp1tVATTqKPbrXLf9+zwNN98vAlQQV2puOY800GuKF5UDYnGCPRe8XjIlVUTv0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745778776; c=relaxed/simple;
	bh=JEwVJbYoVlwMh0WLyRyScPPdUzM5VXY7BGtiUNvq0x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=c+e5p/FJZgYXq9BjwCdyddxwMG9O3pFUE1XNlyOcHFyfK/hxMUj1e6yZtwgf6hpySklLMO8DVvJmew1SwVN+CAA1VNVz1+DHa5+en21TpTMqjua39XAX0ua5eZyS7uTmJneW22EST2gN+yZqZC1nAvWncXfPMX/4+pBypm1mpFU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F1C2D3858D1E
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89C7B04D7E079
X-Originating-IP: [86.143.43.122]
X-OWM-Source-IP: 86.143.43.122
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgeegueetieegieekgfehtefhteeuhfdtgeeiieekheetheeffedvuefftdevjeffnecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucfkphepkeeirddugeefrdegfedruddvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugeefrdegfedruddvvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegfedqgeefqdduvddvrdhrrghnghgvkeeiqddugeefrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdefpdhnsggprhgtphhtthhopedvpdhr
	tghpthhtohepvehhrhhishhtihgrnhdrhfhrrghnkhgvsehtqdhonhhlihhnvgdruggvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.143.43.122) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89C7B04D7E079; Sun, 27 Apr 2025 19:32:53 +0100
Message-ID: <88a458dc-0138-4212-9974-2bf21f07a016@dronecode.org.uk>
Date: Sun, 27 Apr 2025 19:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: kill(1): fix parsing of negative pid
To: Christian Franke <Christian.Franke@t-online.de>
References: <98fb7b3b-362e-4ccc-b25d-ab68e000627c@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <98fb7b3b-362e-4ccc-b25d-ab68e000627c@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/04/2025 15:03, Christian Franke wrote:
> Found during testing of:
> https://sourceware.org/pipermail/cygwin-patches/2025q2/013651.html
> 
> Examples using nonexistent PIDs:
> 
> $ /bin/kill -9 -8 # OK, same as /bin/kill -9 -- -8
> kill: -8: No such process
> 
> $ /bin/kill -SIGKILL -11 # bogus message
> kill: illegal pid: -SIGKILL
> kill: -11: No such process
> 
> $ /bin/kill -9 -11 # BAD, same as /bin/kill -9 -- -9 -11
> kill: -9: No such process
> kill: -11: No such process
> 
> The above works as expected with the bash builtin and with /usr/bin/kill 
> from Debian 12.

Seems like this needs a documentation change in our kill manpage as 
well, to say something like:

negative values are interpreted as per kill(3)
-f only accepts a process ID

