Return-Path: <SRS0=3OGZ=UE=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id 4275C3858C48
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 18:04:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4275C3858C48
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4275C3858C48
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736705083; cv=none;
	b=frhQjy1oa/9ORlv/QVvx1Hnt3KSW7H6c6EhDCWOFdiTLNCkxLv4k/29BOQebUbToPTZP820rxBg4nFXaCHjDr4kKzIZFyJlznDPtAm4mp1RRSPcg941omo8vIxTTiTGa42Qhd/GEID/S75oJmo57FOFOEyuWtDMCxJJfaQ4O+mo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736705083; c=relaxed/simple;
	bh=MzQPGMGe4cwVvhdL8ci8GX4KC9QvDCTN/CkdxU8nD0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=dviJVHk02izHV5EMk5EmbAaf4YHc1fl2N/m0ayatBn+KHl+VnksWum1M5OLgId1O4kb7Ylpoes16zYsi7z0dp8emL3fjZtClf455GCM2CE68MNKMnzoo4JDmR2vuMKZd5UEw1kohtoN4/bLPmC8QRfn0s8lqFracyOD01di8z7c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4275C3858C48
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901EE04BABB70
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeetgeetgfehiedukeejleekgeffjedvgedvudffvdeftddvkeehtdffveefgeekheenucfkphepkeeirddugedtrdduleefrdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdefgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdehpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepuehrihgrnhdrkfhnghhlihhssefuhihsthgv
	mhgrthhitgfuhgdrrggsrdgtrgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901EE04BABB70; Sun, 12 Jan 2025 18:04:37 +0000
Message-ID: <32ee8a55-416f-407f-8c33-655718b667bc@dronecode.org.uk>
Date: Sun, 12 Jan 2025 18:04:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <5888275d7f48a4418cded1b292b8951506240073.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <5888275d7f48a4418cded1b292b8951506240073.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/01/2025 00:01, Brian Inglis wrote:
> Move entries no longer in POSIX from the SUS/POSIX section to
> Deprecated Interfaces section and mark with (SUSv4).
> Remove entries no longer in POSIX from the NOT Implemented section.
>
[...]
>   
> -<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
> +<sect1 id="std-deprec"><title>Other UNIX® system interfaces, not in POSIX.1-2024, or deprecated:</title>
>   

Maybe we've reached the point where this could be split into "System 
interfaces deprecated in POSIX.1-2024" and "Other UNIX system 
interfaces, not in POSIX.1-2024"?

