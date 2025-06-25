Return-Path: <SRS0=a7JR=ZI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.48])
	by sourceware.org (Postfix) with ESMTP id 379EE3857732
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:00:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 379EE3857732
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 379EE3857732
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.48
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750852821; cv=none;
	b=dbITWDYsE7zyGO5UYCuAOLa8rOG06N+m3ros13AVxY7oMjODjXQq1s79Q+qvJv1r6jfRu1qIp++/vgEahJLT/LC2jhDTVqtNjDS+kQyBNwvcl/PGIY0mF8faVcdIiz10QEWKDJl9O00gN+gOce+7xpZlxBwZgNzObevqdmNKaTo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750852821; c=relaxed/simple;
	bh=hn8K7B0DTKN/yCY6HSF7trje5My0N91qlPO0HgjW4I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=mymLSqWNXvAIleX4hzBDBrm1Ox+hLex5xNnDBpLuUmJN9zr7Mc49WgNHaQfPtk3Az4ysVdj/iFeImE6mj9U+LZI0HdtbF+qpb++zRz1MsnGSlfSExkgPnMgceQBFZ1+Tadx26Aajh6stueJMrMlt8iCe9fXhsobETJpUfVpoDPc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 379EE3857732
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89C7B0ABE93AC
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvedvkefgffetteeuhefgudeggfekveeljeduudehveeutdevjeefvedvvedvgfdvnecukfhppeekiedrudefledrudeijedrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudefledrudeijedrieefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqdeifedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtfedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhohhhn
	hhgruhhgrggsohhokhesghhmrghilhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.139.167.63) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89C7B0ABE93AC; Wed, 25 Jun 2025 13:00:19 +0100
Message-ID: <7b04ae6a-836a-4c77-85de-7dd288331b3b@dronecode.org.uk>
Date: Wed, 25 Jun 2025 13:00:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] install.html: add -P option tip
To: johnhaugabook@gmail.com
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
 <20250622083213.1871-2-johnhaugabook@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20250622083213.1871-2-johnhaugabook@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/06/2025 09:32, johnhaugabook@gmail.com wrote:
> From: jhauga <johnhaugabook@gmail.com>
> 
> ---
>   install.html | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/install.html b/install.html
> index 16206a06..4a9e54ff 100755
> --- a/install.html
> +++ b/install.html
> @@ -72,7 +72,12 @@ full-featured as those package managers.</p>
>   
>   <p>
>   Performing an automated installation can be done using the <code>-q</code> and
> -<code>-P package1,package2,...</code> options.
> +<code>-P <i>package1</i>,<i>package2</i>,<i>etc.</i></code> options.
> +</p>
> +
> +<p>
> +Tip: if you have trouble with the <code>-P</code> option, try altering the syntax
> +i.e. <code>-P <i>package1</i> -P <i>package2</i> -P <i>etc</i></code>.
>   </p>

I'm not sure about this.

Firstly: This seems kind of like a bug report.

I know that the option parsing in setup can be picky and janky, but if 
there are some situations where it doesn't work as expected, I need to 
know about them before they can be fixed.

Secondly: We should document for setup generally that repeated options 
are aggregated, but I'm not sure this is the place to do it.

Since this is a "question and answer"-style page, going into every 
variation and detail needs to be balanced against providing the 
information needed with the minimum cognitive load to the reader?


