Return-Path: <SRS0=a7JR=ZI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id 869FD3857830
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:24:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 869FD3857830
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 869FD3857830
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750854267; cv=none;
	b=xfuwy20kg2x7II567CAOF1jftgRGamvrOtOJoV4s24ANB3An51rQ8Y8wrzhfOdly1FsJIv2pXHr1dQ94PWj10V+tjQ0rnBFsPwDd60QsK/ZIEQCHu9OEc3V2PTnME/nq95utHD2Ls/CetKblxMzkDih4bnVnaz656zQTz8LXsd4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750854267; c=relaxed/simple;
	bh=VOarZNf1zQqo7Egf1xFobCVmb6XIXvKQDW9QeMhH2A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=UaAXB1VCt/UerdJR7zRTiQWrnNLvCxiMtz3EvBsZF270gPu3sj8zSkp+CQ4iVTeemBOaYVRmDRJmWy7hW5A1qq2s4QsSAQw9g0p+IUBs3mL//BBdXK3yzWBnNUBu+UAw9dzMOh33AUAdZepj1qum38O90rsDjialNNKNWAXfUlc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 869FD3857830
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CAE0AB3C514
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudefledrudeijedrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudefledrudeijedrieefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqdeifedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtgedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhohhhn
	hhgruhhgrggsohhokhesghhmrghilhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.139.167.63) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE0AB3C514; Wed, 25 Jun 2025 13:24:26 +0100
Message-ID: <77b5d5ea-5cea-4a7b-951f-17278f9411f6@dronecode.org.uk>
Date: Wed, 25 Jun 2025 13:24:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] install.html: add tip on using setup-x86_64.exe from
 bin
To: johnhaugabook@gmail.com
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
 <20250622083213.1871-4-johnhaugabook@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20250622083213.1871-4-johnhaugabook@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/06/2025 09:32, johnhaugabook@gmail.com wrote:
> From: jhauga <johnhaugabook@gmail.com>
> 
> ---
>   install.html | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/install.html b/install.html
> index 13acf430..c5c797f3 100755
> --- a/install.html
> +++ b/install.html
> @@ -85,6 +85,14 @@ Tip: if you have trouble with the <code>-P</code> option, try altering the synta
>   i.e. <code>-P <i>package1</i> -P <i>package2</i> -P <i>etc</i></code>.
>   </p>
>   
> +<p>
> +Tip: you can download <code>setup-x86_64.exe</code> in the <code>/bin</code> directory,
> +and use it from the command line to install packages (<i>ensure C:\cygwin64\bin is
> +in path</i>). Additionally, you can also change the name of <code>setup-x86_64.exe</code>
> +i.e. <code>pkg.exe</code>, and use that to install packages e.g.
> +<code>pkg -P <i>binutils</i></code>.

Uh, I don't think we want to encourage people to do that.

There were some plans to make a package of setup, so it would end up 
installed in /bin/ and be runnable like that, but it seems like we never 
got around to it...

