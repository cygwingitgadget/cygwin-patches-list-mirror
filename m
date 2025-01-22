Return-Path: <SRS0=bps0=UO=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo009.btinternet.com (btprdrgo009.btinternet.com [65.20.50.104])
	by sourceware.org (Postfix) with ESMTP id D2C1D3858D38
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 13:53:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D2C1D3858D38
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D2C1D3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.104
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737554005; cv=none;
	b=ssnM/pkjzZXQsB6VAwalIo5lMLoAiLihahsExKqWguNEnGftgPWQRmZNjTsCcGjbckDwu9AxjwU7+/v9Ozz6PYLCDJ88T/5ZlScAPZGnxL6CUH/DEsVGAun6l4hkuTyqOxiDPz5wT3rKT51zIrv8F2kz5ojjee+poBntnI7daZw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737554005; c=relaxed/simple;
	bh=E+D7BZHBFfM46+6CYtMusgU9UucfgTI+h7uwUeCBu1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=H9RiS4tdqYj5qmoA/NsyRG8ZjeoTKkvFUoRzdp0pCtLArYrMaLoeTgZFbLZ7QSI4mYBY0mHlIpR1sWCfwssKr+w/tNh2M7oINlLFCsXBeTVyU9KMtgYTDvuix2e/5IRgFfXNi4q2VeIxEUVnvXU9zX3MpKCU7mN3loipwSYYd+Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D2C1D3858D38
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6749020105D8DE68
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleefrdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdefgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdelpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihg
	fihinhdrtghomhdprhgtphhtthhopehmrghrkhesmhgrgihrnhgurdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo009.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6749020105D8DE68; Wed, 22 Jan 2025 13:53:21 +0000
Message-ID: <046616b0-e793-4057-9b4c-1bf340a9bdd1@dronecode.org.uk>
Date: Wed, 22 Jan 2025 13:53:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: Minor updates to load average calculations
To: Mark Geisert <mark@maxrnd.com>
References: <https://cygwin.com/pipermail/cygwin-patches/2024q4/012939.html>
 <20250120081914.1219-1-mark@maxrnd.com>
 <Z5DEs9hhMPmCMqqC@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Z5DEs9hhMPmCMqqC@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/01/2025 10:13, Corinna Vinschen wrote:
> Jon?  Are yuo going to review this one?

This looks fine to me. No notes. Please apply.

Thanks Mark!

(and a particular thank you for fixing the process vs. thread vagueness 
I'd made in the comments)

