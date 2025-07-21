Return-Path: <SRS0=3L1n=2C=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.48])
	by sourceware.org (Postfix) with ESMTP id CCE063858D29
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 13:03:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CCE063858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CCE063858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.48
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753102992; cv=none;
	b=C037PzCXmSApKUI3IHCQsy1GFKV+N8xUzBCcB1VvyU8GEN6qx6KpezxKfBIVtzS2jjo5WNiLqNYG1JOiy4Ey6ydpIXmiC2i/N7PL6+GZpKx5GoMe+OoyqXjYJIZF+JTvSc+NcFSyPzbXYrD64rn/omT4+6m8+IyOK3+Tg6a6Z1A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753102992; c=relaxed/simple;
	bh=9ZlmVVNjrWGiaBIFZKUW0r9Fxal5sYv56GEKWf4OLNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=N81hvMng/izu7T++ASKtReHAlgvsMDKsMolEn4Sg5Xksxv9NHziPJKDlU0Byh/+hAHjp02SoB153Sr/8Wy9of8QMuhPYL/4FSyFRufYbTZblJO5a5YFRg/+HQFpmew/abUpm2t/dx6Of/SI2+P1JlJfUCscGJCwaYNXCTtaMves=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CCE063858D29
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6878FB31008BD43E
X-Originating-IP: [86.139.156.85]
X-OWM-Source-IP: 86.139.156.85
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddufeelrdduheeirdekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddufeelrdduheeirdekhedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudehiedqkeehrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdefpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihg
	fihinhdrtghomhdprhgtphhtthhopehrrgguvghkrdgsrghrthhonhesmhhitghrohhsohhfthdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.139.156.85) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6878FB31008BD43E; Mon, 21 Jul 2025 14:03:07 +0100
Message-ID: <adcabbf3-12f9-4edd-92f4-e781cd0a044d@dronecode.org.uk>
Date: Mon, 21 Jul 2025 14:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Cygwin: configure: add possibility to skip build of
 cygserver and utils
To: Radek Barton <radek.barton@microsoft.com>
References: <DB9PR83MB09232A0A1E4EC3D43BBAFA089242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923C35FB2253C8C2A21927C9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <52fd7877-6abc-4e01-8f3c-405cf075b1ff@dronecode.org.uk>
 <DB9PR83MB09237AD6BA4BFE16B03AEBD99256A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923F0FF53C98FB27E03C376925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4M4bMkevolWp0N@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <aH4M4bMkevolWp0N@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/07/2025 10:48, Corinna Vinschen wrote:
> Jon?

All looks good to me, pushed.
