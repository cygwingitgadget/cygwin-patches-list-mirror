Return-Path: <SRS0=a7JR=ZI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.62])
	by sourceware.org (Postfix) with ESMTP id 5B0C03857BA0
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:24:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5B0C03857BA0
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5B0C03857BA0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750854250; cv=none;
	b=MquDCFmR2GCUYWpL8/QuFEmO/xWPX81u0PErVRGu35HrRx80nXeZRPHvY0besmqGb55cBac9CHLftCGuzelIsdfbENu5M4DWtwe146AF5DYrNdwZgJyhz9cTuv73qmsF9L0FOAmVloYaSbQPiV7KFYADlEN0XH7lgnS8OPlPIl4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750854250; c=relaxed/simple;
	bh=R+/aJnW8hoxwjuktwAUWg7g7c0BJRNeDmj+dEcAJepY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=LpE1Q4vA7Wpjxm2tOT52up6aL20KJNTNvdWltZdzq2liF8+WPePWG1XGI1WauBNFG4rbdHWMrDKfX2Jnc/hWK6vJR4KrK3hVn2xioNwncKBYqmQ2sIVZE6wNvn2z1KiQKsrqpCTIj2DdlMmS1rXj1tV8kV+X8p6uu8KnfCjUUdA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5B0C03857BA0
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6840B66701F9F544
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudefledrudeijedrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudefledrudeijedrieefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqdeifedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotdduuddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhohhhn
	hhgruhhgrggsohhokhesghhmrghilhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.139.167.63) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6840B66701F9F544; Wed, 25 Jun 2025 13:24:09 +0100
Message-ID: <6c283373-0457-4049-8246-19c81c5bf4a4@dronecode.org.uk>
Date: Wed, 25 Jun 2025 13:24:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] install.html: bold Tip: in q and a
To: johnhaugabook@gmail.com
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
 <20250622083213.1871-5-johnhaugabook@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20250622083213.1871-5-johnhaugabook@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/06/2025 09:32, johnhaugabook@gmail.com wrote:
> From: jhauga <johnhaugabook@gmail.com>
> 
> ---
>   install.html | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/install.html b/install.html
> index c5c797f3..4069df2d 100755
> --- a/install.html
> +++ b/install.html
> @@ -57,12 +57,12 @@ A: Run the setup program and select the package you want to add.
>   </p>
>   
>   <p>
> -Tip: if you don't want to also upgrade existing packages, select 'Keep' at the
> +<b>Tip:</b> if you don't want to also upgrade existing packages, select 'Keep' at the
>   top-right of the package chooser page.
>   </p>
Applied. Thanks!

