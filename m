Return-Path: <SRS0=3OGZ=UE=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id 1D7CA3858C48
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 17:58:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D7CA3858C48
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D7CA3858C48
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736704698; cv=none;
	b=lxzRtJmCNCKiKU6oLutDscAvWr8Qoksnqp+H+ATco54zgh+vZnMG/3rf1ljbvjBdt+5UnAztZOlSOYxu8GzsdGuMlghgbmdOxYgeqfDrfrncPwUjhbE2tNDPcTTVgGnwvaxuGui9iLvI5q7SCKB60tbQ8laqPXqRq/Z2UBlHypg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736704698; c=relaxed/simple;
	bh=Zh74pXVIpEuRw+IK/xMt9O7MnHYUDFlfnGp+CB4h1To=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=wf0zSv8RLb3BeDvO0lTpY94DfkMoGHLT/H3QkfZbGgMtYZg10UJecurpxFDWRPKxitDP+0xeC0NZ8sAcoPe/HkSZCTKd8ZsVpz2ONWMK2ljcfwFEoSWiVPSQ5g2ckYINA4Cw9MYpLaVFcoA39n3f1fto7hQhk1TCzVf4N4chA44=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D7CA3858C48
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901FF04BA2841
X-Originating-IP: [86.140.193.34]
X-OWM-Source-IP: 86.140.193.34
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleefrdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdefgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdekpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepuehrihgrnhdrkfhnghhlihhssefuhihsthgv
	mhgrthhitgfuhgdrrggsrdgtrgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.34) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901FF04BA2841; Sun, 12 Jan 2025 17:58:13 +0000
Message-ID: <5bde1928-7d96-482e-88ac-0cbb081f5a54@dronecode.org.uk>
Date: Sun, 12 Jan 2025 17:58:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <1a354471c155501dd2d0abfbc195e8be3e9c0fa2.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <1a354471c155501dd2d0abfbc195e8be3e9c0fa2.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/01/2025 00:01, Brian Inglis wrote:
> Add POSIX new additions available with din entries
> or interfaces in headers and packages.

What does 'din' mean in this context?



