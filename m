Return-Path: <SRS0=3OGZ=UE=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.48])
	by sourceware.org (Postfix) with ESMTP id 1D8F73857707
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 18:05:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D8F73857707
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D8F73857707
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.48
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736705103; cv=none;
	b=iEZ+0x/cmMuZjsW04GD0lhqNhDEjicc9/ufXGiRMsAmWHrxuqDqsZIY6d2PeH+DpICY++/rjh4M36Ipx/VAfipIq3J7WFAw2CgUlkk2eHeXGXC72o0Aqjl5Bfj+pO2R4tA2ik7cvNH1my+eiaYq0CE/6g5Tc/XTObiVX1EHoI0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736705103; c=relaxed/simple;
	bh=usSOSJ19GQEQQwF1MVtafhJtMbdnpnE5cPhUGkh5H+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=kddnYEiWrOoLVrZZKtw/oTh/XZ6SiqGjURkKMKQAGKqZWMuoXe7kpg+V2X9o6cJmkTMUEP22BDJoEf1LYOREA7A0fpMmNIkHNbT2ncgKn/bWswbN/Fdk7cqeE9Sr21XwQruptL5IdrCcSB3KRi01nIL1xxQ8EljcsWec5rJIDjM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D8F73857707
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901E804BF3B36
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleefrdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdefgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdefpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepuehrihgrnhdrkfhnghhlihhssefuhihsthgv
	mhgrthhitgfuhgdrrggsrdgtrgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901E804BF3B36; Sun, 12 Jan 2025 18:04:59 +0000
Message-ID: <598abc03-465e-4ed0-bd75-ba1fb59eca35@dronecode.org.uk>
Date: Sun, 12 Jan 2025 18:04:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 TOG Issue 8 ISO 9945 updates
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/01/2025 00:01, Brian Inglis wrote:
> Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 updates
> 
> Brian Inglis (8):
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 group variants with base
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 merge function variants on one line
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 abbrev variants of base function

Thanks very much for working on this!

