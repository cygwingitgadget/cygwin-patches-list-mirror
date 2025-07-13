Return-Path: <SRS0=YtBF=Z2=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id 0504A3858C42
	for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2025 12:50:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0504A3858C42
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0504A3858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752411009; cv=none;
	b=L+ktkD6f2JrMCrZoiIrBgY5CH3twiR3TMaFK0/zoizjpD8mzxwYS0ofc/sZGXd50kDA4UaTryGGdMieCjeZwTxLVEV0v5+AZ/NsFPAz3uyYW1pcyL4tgqlZZX0m5377rHzabnQ42oOFngzQlr/hlbZknIBa6MzU0+dVN7NxSavg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752411009; c=relaxed/simple;
	bh=s+TVEIz1o01O6S+t5bV4TPtGzzt5xBxxWlSxb8Bh4Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=EH58nFP9iI5Qw6oheKysuqG7hVRMDs5yRy1TdClmBzSuvgSVXRVz1W7dd3wW6tzcYCaOJLoTZpagIgPoZ12dLZXdqc4YbLQ2qmn68qa7ryzXfAeVeQXbUB5cOGmjqjb82JFc4ma/hhZVN7K0uOSgAdiEGIbsK74xnlziGbDrf8I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0504A3858C42
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 686363D60132E093
X-Originating-IP: [86.140.193.33]
X-OWM-Source-IP: 86.140.193.33
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegleduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudegtddrudelfedrfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelfedrfeefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqdeffedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtgedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhohhhn
	hhgruhhgrggsohhokhesghhmrghilhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.33) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 686363D60132E093; Sun, 13 Jul 2025 13:50:07 +0100
Message-ID: <c8836ea2-2a1f-4225-8b79-bbe43bcc186b@dronecode.org.uk>
Date: Sun, 13 Jul 2025 13:50:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cygwin: faq-programming-6.21 ready-made download
 commands
To: johnhaugabook@gmail.com
References: <20250625013908.628-1-johnhaugabook@gmail.com>
 <20250625013908.628-3-johnhaugabook@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20250625013908.628-3-johnhaugabook@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 25/06/2025 02:39, johnhaugabook@gmail.com wrote:
> From: John Haugabook <johnhaugabook@gmail.com>
> Running setup-x86_64.exe and performing an individual search for
> each package, and/or toggling View to "Full" and going down the list
> to select each package is a pain in the neck. And running "setup-
> x86_64.exe -q -P packageName" is fickle, and fails more often than
> works.

> +$ setup-x86_64.exe -P autoconf,automake,cocom,gcc-g++,git,libtool,make,patch,perl                           # download build tool packages 
> +$ setup-x86_64.exe -P gettext-devel,libiconv,libiconv-devel,libiconv2,libzstd-devel,zlib-devel              # download dumper packages
> +$ setup-x86_64.exe -P mingw64-x86_64-gcc-g++,mingw64-x86_64-zlib                                            # download utility packages
> +$ setup-x86_64.exe -P dblatex,docbook-utils,docbook-xml45,docbook-xsl,docbook2X,perl-XML-SAX-Expat,xmlto    # download documentation packages

Thanks.

This is good as far as it goes, but it's kind of memorializing our 
terribleness.

We actually have the build-requires information available to setup these 
days, so I think what's really needed here is extending setup so it can 
do something useful with it, so one can just write e.g.:

setup -q --please-install-the-build-requirements-of-this-package cygwin

