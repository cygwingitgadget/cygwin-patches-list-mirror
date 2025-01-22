Return-Path: <SRS0=bps0=UO=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.244])
	by sourceware.org (Postfix) with ESMTP id 9F51C3858C5F
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 17:37:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9F51C3858C5F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9F51C3858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.244
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737567467; cv=none;
	b=LeiM/C2dN9krEKZpob2NWI9uwk64aOvrp0Gf2quQhSCxNU93DALsywDOPPJnyp+HnDlf8bi6gBgRO0gpp6DNMLJkcnO2jUHBuDr4THnVqSFQ1hjQ24kf18+BKn+oNrLz/NzlXS3+5qTFRqziZH97QGow4Z3EjsgDha3G6p1Eqvg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737567467; c=relaxed/simple;
	bh=FMyqw0eJuc2cz1O4DRPwtjuQ077fvUzNVk2gLFaWw9s=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=qFVM1MPzxJRliKwqTF7fuuVZu0UQ5aiXUH4g4DO+Z8KFmyb+jobpG6u35YUQOoRkPgWGsS+l/y2AusRnUpGM/YFVNR7++IQl/LFStobMzhXks077GNgeh9Vn4QtqNrKwZYhcgM5sHT3WcQ68w8rutDM9YjkXkA16T6p2gbWmV2Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F51C3858C5F
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901ED05DD69D6
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhepkfffgggfufhfhfevjggtgfesthekredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueetjeekledvudeludffuedvleeutdefgeevveefheejvdelffevhfduudetuefhnecukfhppeekiedrudegtddrudelfedrfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelfedrfeegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqdefgedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddutddpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgih
	ghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901ED05DD69D6 for cygwin-patches@cygwin.com; Wed, 22 Jan 2025 17:37:46 +0000
Message-ID: <d0d4373e-9564-40b9-96f2-1bb908ea8875@dronecode.org.uk>
Date: Wed, 22 Jan 2025 17:37:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <7c1df0773801655e35abbfb28c4428df9b4854ee.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z5DVKOrVtnXunSvK@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Z5DVKOrVtnXunSvK@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/01/2025 11:23, Corinna Vinschen wrote:
> On Jan 17 10:01, Brian Inglis wrote:
>> Move entries no longer in POSIX from the SUS/POSIX section to
>> Deprecated Interfaces section and mark with (SUSv4).
>> Remove entries no longer in POSIX from the NOT Implemented section.
> 
> This looks good, but I just realized that a bunch of functions are
> missing.
> 
>> -<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
>> +<sect1 id="std-deprec"><title>Other UNIX® system interfaces, not in POSIX.1-2024, or deprecated:</title>
> 
> When I introduced the ACL functions from the abandoned POSIX.1e draft,
> I missed to add them to the docs.
> 
> Well, fortunately I'm now noticing this a mere 8 years later... *facepalm*
> 
> Sigh.  I'll create a patch to add them on top of your patches later on.
> 
I happen to notice the other day that we don't mention eaccess() (which 
the glibc extension euidaccess() is a synonym for) here, which I think 
belongs in this section.

