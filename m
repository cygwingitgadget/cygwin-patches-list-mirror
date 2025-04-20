Return-Path: <SRS0=ZSvf=XG=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.244])
	by sourceware.org (Postfix) with ESMTP id E5E963858CDA
	for <cygwin-patches@cygwin.com>; Sun, 20 Apr 2025 19:28:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E5E963858CDA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E5E963858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.244
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745177319; cv=none;
	b=FEA1eMIMiQG+1BzPl4b+MdGw/y3SZoPb0qyV40zkGEFYxA95EngBCKNocPU67X2Nb7L2HFbhYw/bC7tfWFKlBjL1nngccg5hKx7aTPXxc8Uli/3LyNgCxShyAea2CVwdu6XFWU+TS2g48iypcV8czvgK8sb2PZehvZAep3ju4Mc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745177319; c=relaxed/simple;
	bh=OBn0XyUv1PhZJXKffSCzTfnZtNTJP2L3SjyW+9DJhNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=JRvUj6Xsfv+/eAIQa+cLa3JH73EMyAoDtIzoQxggLe2hugtFQbIQCPSPu+6Yb5lCzKODSDM4lfNHaaNW+TTX9U8ThwKRS+qsAvpOUrpmQHIE79Q6GhbKrkTDTND4rVtDy9UGImmtvklHvBSA++X5KlsQU9SvNDnRP5It1tQC0EQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E5E963858CDA
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E080419DB8E
X-Originating-IP: [86.140.112.112]
X-OWM-Source-IP: 86.140.112.112
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduuddvrdduuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudduvddrudduvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudduvddqudduvddrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddutddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohep
	tgihghifihhnsehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.112.112) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E080419DB8E; Sun, 20 Apr 2025 20:28:35 +0100
Message-ID: <88f9fc41-2d4a-4bd4-8bce-82a7e7bb2a08@dronecode.org.uk>
Date: Sun, 20 Apr 2025 20:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add stress-ng to CI
To: Jeremy Drake <cygwin@jdrake.com>
References: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
 <ad15ee78-e913-de03-ea90-cddf5ecdb62d@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <ad15ee78-e913-de03-ea90-cddf5ecdb62d@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 15/04/2025 18:50, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 11 Apr 2025, Jon Turney wrote:
> 
>>
>> Jon Turney (4):
>>    Cygwin: CI: Pass the just-built cygwin to a subsequent job
>>    Cygwin: CI: Run stress-ng
>>    Cygwin: CI: Make stress test terser
>>    Cygwin: CI: Disable stress-ng clock test
> 
> 
> FYI, as of 4/14, GitHub has *finally* put a Windows ARM64 runner in public
> preview.  It might be nice to run some tests on that "windows-11-arm"
> runner, in addition to "windows-latest".  I could prepare a patch but it
> would likely conflict with this series, so I'd wait until this is pushed
> or else leave it to you to add to this series.

Oh, finally! :)

Yeah, it would obviously be a good idea to make use of that here, if we can.

Thanks for letting me know.

