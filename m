Return-Path: <SRS0=fCNd=Z4=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id 53232385841D
	for <cygwin-patches@cygwin.com>; Tue, 15 Jul 2025 19:35:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 53232385841D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 53232385841D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752608133; cv=none;
	b=sZ5zCY0oEYNPjpU6L5gItYOwm27oghdfW5StPrZas3HUriR/dfKDQ9XPKbh72kYym1EgC2nnHdAEwzmhx15jxGT8IZhD2/9GcMrHWiRvMJpBcTSU4sx03auktu+yrBbFtP+OfJvXD44IsAEGG9wYw6srBENywnoN+tvmTJ4IVak=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752608133; c=relaxed/simple;
	bh=/ULwltKbNQQ6w5gM+WH/z717xhIzvadiKhup9kixDso=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=bWr8+g83E+Jl8v5uYeQq7IaWLwYhlsNZjXlNNQUv4rNf4R7fMhlM9lRbyBSsl/poriVozvHDii+8WkaqverarAsYX8mNDVqcgimYucpCXiVheyRhH0K43OCmM8fu3WP99yD0dWkIHGf/qTjrxq4x/fVpKo4TXsQFy7AZ+wfCiQ0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 53232385841D
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 686364F30175082D
X-Originating-IP: [86.139.156.85]
X-OWM-Source-IP: 86.139.156.85
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhepkfffgggfufhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvddtgfduudeuheevffdvjefgieeluefgieevvdfgheeuleffffegjeduudfhgedtnecukfhppeekiedrudefledrudehiedrkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudefledrudehiedrkeehpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheeiqdekhedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddthedpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgih
	ghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.139.156.85) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 686364F30175082D for cygwin-patches@cygwin.com; Tue, 15 Jul 2025 20:35:32 +0100
Message-ID: <3b42dc97-e61a-402a-8a9b-24eb47c17d22@dronecode.org.uk>
Date: Tue, 15 Jul 2025 20:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Cygwin: doc: Install FAQ as well
References: <20250626105925.29521-1-jon.turney@dronecode.org.uk>
 <20250626105925.29521-2-jon.turney@dronecode.org.uk>
 <aF0zEM9tqmEBnuaK@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <aF0zEM9tqmEBnuaK@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 26/06/2025 12:46, Corinna Vinschen wrote:
> On Jun 26 11:59, Jon Turney wrote:
>> Just install the FAQ, so we can deploy the FAQ with it's matching CSS from
>> the install directory.
>>
>> There will be a separate change to the cygwin packaging to avoid
>> including the FAQ in the cygwin-doc package. (I guess we'd rather people
>> go online for that, to ensure they have the latest version?)
> 
> We could just keep the faq.html file in the cygwin-doc package.
> It doesn't really hurt and it always matches the installed
> version. What could possibly be wrong? :)

That change is possibly a little more involved, as we'd maybe want to 
update the startmenu shortcuts to point to that, as well.

I'll look at that again when I've got the other pieces of this puzzle 
sorted out.

