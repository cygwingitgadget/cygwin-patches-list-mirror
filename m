Return-Path: <SRS0=MoZU=YQ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.62])
	by sourceware.org (Postfix) with ESMTP id 03A583858C53
	for <cygwin-patches@cygwin.com>; Sun,  1 Jun 2025 13:19:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 03A583858C53
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 03A583858C53
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748783948; cv=none;
	b=ZqoeoNKVUBNZqcgsTMW7xwkPFcQmSmuuNdp4CnXiBGX4EeaxYpuajN/k5O+IoMxuYhY8+FoMkuysWrsaiOtBfAz6rdpjs/VQZ1Mzyz8zMjWl2dFpZyvI/Ym0yEbry3wAS6yqXkMUzFxqo0e98ag+Hkt6r9gA3ZXFZm3LyW/rRYs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748783948; c=relaxed/simple;
	bh=pUe0wya/Frgh+mnz40cizZIeEvel8TBkiOTJj7uyZmk=;
	h=Message-ID:Date:MIME-Version:From:Subject; b=DLSPckcq+2gpvWaKhiaYo7BQe/a+KOgtb+hR+6aXprAs1waRHf7FLGx/NeDRuPp+jYLTQFhf3GkUjZOGq/EO97L4LauCkRQTpUfDiTJ1fl+kngneIpfdDNYD7MbYBBlEY7miZMM/qMaqUQ6PcWUEFcRjwohM+U7iZAKIAvjjPCo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03A583858C53
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E4E08572467
X-Originating-IP: [86.139.156.52]
X-OWM-Source-IP: 86.139.156.52
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefgeekkeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhepkfffgggfhffuvehfjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvdekjeetffeiuddvveekueevtdehleevheehjeeihfffjeetjeduhfetvdelhfeinecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddufeelrdduheeirdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddufeelrdduheeirdehvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudehiedqhedvrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddupdhnsggprhgt
	phhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.139.156.52) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E4E08572467 for cygwin-patches@cygwin.com; Sun, 1 Jun 2025 14:19:07 +0100
Message-ID: <e8e73b7b-0f78-4478-80fc-0575149dee61@dronecode.org.uk>
Date: Sun, 1 Jun 2025 14:19:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: doc: Update "building DLL"
Cc: cygwin-patches@cygwin.com
References: <20250523164102.16035-1-jon.turney@dronecode.org.uk>
Content-Language: en-US
In-Reply-To: <20250523164102.16035-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 23/05/2025 17:41, Jon Turney wrote:
> This hasn't substantially been revised since (at least) 2004, and
> doesn't really represent normal usage of modern gcc and binutils.

OTOH, the existence of this documentation at all is maybe a historical wart.

I knew this used to be really weird and complex, but I don't know just 
how weird and complex: read [1] and be shocked!

[1] 
https://cygwin.com/cgit/newlib-cygwin/diff/winsup/doc/dll.sgml?id=1fd5e000ace55b323124c7e556a7a864b972a5c4

