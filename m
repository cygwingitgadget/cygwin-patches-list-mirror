Return-Path: <SRS0=YtBF=Z2=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.62])
	by sourceware.org (Postfix) with ESMTP id 5F64C3858C42
	for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2025 12:43:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F64C3858C42
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F64C3858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752410615; cv=none;
	b=OdrZT9mOblO8jiaXlLDTl8BlUVyvo8HFMBhOYyuLkc3cCew7SNjZ2MoQahYmYAkZkvsW7s0vGzudRbSv7YdbIw44cm+J6zaFs5dTTAri4wua9Of+Af1VqjT/UgfTnrSP/cFXK1/Iy8fhIbPEeEDH8IfxGgUVEWdUXyxSfIJiDzA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752410615; c=relaxed/simple;
	bh=cFTU8eE6AHKyYPaKP4pE8anpO1/b8+o+qYaY6QFTJ58=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=c70Ryvhl+yrmxoaembWl5/KXkVBvMgyVXMx5HpfUnZ6YFQR1EbOQjdRYYz7MggLfByLiewDFWbahEZ7wvMNQ1hhmN1J7b+EQaftcwGNs/S8AuwDYaXx9i/L4tRZVEfIujHp5M5pTmtpq+1ZoJriS1dJsRaQKWV8Sa79X/BV9ZeA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F64C3858C42
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6864C026011914C6
X-Originating-IP: [86.140.193.33]
X-OWM-Source-IP: 86.140.193.33
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegledutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleefrdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrdeffedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqfeefrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddupdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihg
	fihinhdrtghomhdprhgtphhtthhopehrrgguvghkrdgsrghrthhonhesmhhitghrohhsohhfthdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.33) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6864C026011914C6; Sun, 13 Jul 2025 13:43:32 +0100
Message-ID: <52fd7877-6abc-4e01-8f3c-405cf075b1ff@dronecode.org.uk>
Date: Sun, 13 Jul 2025 13:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: cygserver: add possibility to skip cygserver
 build
To: Radek Barton <radek.barton@microsoft.com>
References: <DB9PR83MB09232A0A1E4EC3D43BBAFA089242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923C35FB2253C8C2A21927C9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <DB9PR83MB0923C35FB2253C8C2A21927C9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 10/07/2025 11:15, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Sending the same patch with more detailed commit message added.

Thanks.

This seems fine.

I think this new switch needs mentioning in doc/faq-programming.xml in 
the "building-cygwin" section (which is where we seem to have chosen to 
document these things).

Isn't a similar switch needed for the executables built in the utils 
directory?

