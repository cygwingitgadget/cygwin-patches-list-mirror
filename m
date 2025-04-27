Return-Path: <SRS0=xsK9=XN=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.168])
	by sourceware.org (Postfix) with ESMTP id 279563858D1E
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 18:16:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 279563858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 279563858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.168
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745777787; cv=none;
	b=HnUrkRetavthRYHB3B0ModAxRG9enqnuL3IlZc+WAvJ+1JAev5XGqot+npyoupQ+Z8pTHlO/S9ATPaz5GaXp28WpmFz5qu+2JsV9/0Wpu1bmETh8CXRqxgstLImCz8iVFmQz7QEfgjzwD883R/ZW+fH7OIm8avmEOnABeOxeZdw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745777787; c=relaxed/simple;
	bh=WSlXVA6YI3wpos22++gJok+Vbe4D3toibY7DX2InbTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=APmRK+dUmG3qzP1MpjQqHKrG/p+/Cczo63z9T+qoRcM7DqlQe10rJ53KWNnriYPDD1OKUrmotMrAYAVsjT+1sApJwB1BIVTRsxPhp6AWJlo/ObIWoHOT12aiyJ8x6jYyYM6aQftQUVVdX7aPfiCdH0SuNeH8bLERDE3gWaKQ85Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 279563858D1E
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89D5C04D280D7
X-Originating-IP: [86.143.43.122]
X-OWM-Source-IP: 86.143.43.122
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudegfedrgeefrdduvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegfedrgeefrdduvddvpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugeefqdegfedquddvvddrrhgrnhhgvgekiedqudegfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtjedpnhgspghrtghpthhtohepvddprhgtphhtthhopeevhhhrihhsthhirghnrdfhrhgrnhhkvges
	thdqohhnlhhinhgvrdguvgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.143.43.122) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89D5C04D280D7; Sun, 27 Apr 2025 19:16:25 +0100
Message-ID: <42dbf82c-f7d5-446a-bd28-ecf44c3e814b@dronecode.org.uk>
Date: Sun, 27 Apr 2025 19:16:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add stress-ng to CI (v2)
To: Christian Franke <Christian.Franke@t-online.de>
References: <20250420192510.3483-1-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20250420192510.3483-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 20/04/2025 20:25, Jon Turney wrote:
> Jon Turney (4):
>    Cygwin: CI: Pass the just-built cygwin to a subsequent job
>    Cygwin: CI: Run stress-ng
>    Cygwin: CI: Make stress test terser
>    Cygwin: CI: Disable stress-ng clock test

OK, I pushed v2 of this.

Please feel free to suggest changes to turn on additional tests etc.

Any insight into what's going on with the 'clock' test?

