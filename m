Return-Path: <SRS0=K2UI=55=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id 6D47A385DC05;
	Fri, 21 Nov 2025 13:26:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6D47A385DC05
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6D47A385DC05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763731571; cv=none;
	b=CPAm6652CbZ+kTtAK/QJWytBuuD0O4AIF+jNBsC4uiDJph4nBG71Z57NnbNioRHKOGnJxnyHpVwY1iEQnTS8xf1DZnDBOAp0aA2M/cmcHXXRTnMDNPVa7b0z0q8QDv1rQis++8u/iWOx1e6F09ZcQNRBBsRO4a+G8DXxshycl8g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763731571; c=relaxed/simple;
	bh=XtQDRE4rMCT5hr80nNeLhATYoidnPjznJ8uQ9U4nSkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Sg3zJkUy1TVsdxr7oWFu4v/FrR0ltjtvP3ev2HKtbcNHl454YvgYvEPGfibbmGaSOiTiWl6XnXo2KzbNtYy7UvW5XGP4TPam/8h1MQ0wpIcHiGHrMzihspIfWUK9xJnI7tMVtX1LAK/DTUFy3e7U38iotIkQGw3nql/aDrTwCo0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6D47A385DC05
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1C9506745DB6
X-Originating-IP: [81.158.20.254]
X-OWM-Source-IP: 81.158.20.254
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedttdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkedurdduheekrddvtddrvdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduheekrddvtddrvdehgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehkedqvddtqddvheegrdhrrghnghgvkeduqdduheekrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdehpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptghorhhinhhnrgdqtgihghifihhnsegthihgfihinhdrtghomhdprhgtphhtthhopegthihg
	fihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (81.158.20.254) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1C9506745DB6; Fri, 21 Nov 2025 13:26:10 +0000
Message-ID: <50f03441-b847-41cd-b35c-e5b5d224eb3e@dronecode.org.uk>
Date: Fri, 21 Nov 2025 13:26:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Add a configure-time check for minimum w32api
 headers version
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
References: <20251120144715.4015-1-jon.turney@dronecode.org.uk>
 <aR8xbdiYGjTtY_e7@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <aR8xbdiYGjTtY_e7@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 20/11/2025 15:19, Corinna Vinschen wrote:
[...]
> One problem here: The error message "no" isn't overly helpful to the
> unaware developer because it neglects to mention the version requirement.
> If you just run configure, what you get is this:
> 
>    checking for required w32api-headers version... configure: error: no


Excellent point.  This should definitely be better than "computer says 
no". :)

> Given that this code is checking for the actual version number, to be
> bumped as we go along, it would be helpful to tell the dev which version
> is supposed to be installed, isn't it?


