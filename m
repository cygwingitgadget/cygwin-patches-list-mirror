Return-Path: <SRS0=tlHB=YY=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.0])
	by sourceware.org (Postfix) with ESMTP id 223933858D38
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 21:44:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 223933858D38
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 223933858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.0
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749505478; cv=none;
	b=xmYXzexB2DSmIYnNxBF09HKqLc3FNcTOKlAcle/ogJ9jcqEgBEYoJ5PDuJGtI0cwahEXgl2fYvPZ0peIpnzf63yG1YoOhTlPuySa1pgJmA5D8rCRGySW9mYt7e8dVmnY3orLw2WJqSqXWjtlvJEv6pRWEIZX4spiCk5SJc4z4ss=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749505478; c=relaxed/simple;
	bh=bdnzf9aWiR/dwYVs//xEYbpbharf8O6UI/rN+yBJhKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=GfA/TNDFkK6IdHB1Jtw/6/Y2uKt1xtJwTe4zlawwqFcCv3R0kUDyUzzJQM0LTd2DWoneJYsUBMzpfhAWJ8RPhx27Kgum7qh4PIIMttUBISdt+vHuN0X1FHDS8Yw822+/7HiulEfdmFNjPvXKFXshfnCU0F3Shy1KJqgOVXJyTsI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 223933858D38
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89D1C093FA76E
X-Originating-IP: [86.144.161.4]
X-OWM-Source-IP: 86.144.161.4
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugeegrdduiedurdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeggedrudeiuddrgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeggedqudeiuddqgedrrhgrnhhgvgekiedqudeggedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtiedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtoheptgihghifihhnsehj
	ughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.161.4) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89D1C093FA76E; Mon, 9 Jun 2025 22:44:34 +0100
Message-ID: <4fdd22a1-29c3-41a4-8d50-b3d83782a44c@dronecode.org.uk>
Date: Mon, 9 Jun 2025 22:44:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: CI: grant full control to Administrators on
 github workspace
To: Jeremy Drake <cygwin@jdrake.com>
References: <733a91af-f510-f2f8-4577-5354eed64941@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <733a91af-f510-f2f8-4577-5354eed64941@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 09/06/2025 21:28, Jeremy Drake via Cygwin-patches wrote:
> From: Jeremy Drake <cygwin@jdrake.com>
> 
> After inherited permissons were removed, apparently there were no
> permissions left allowing access, and GHA recently started failing on
> actions/checkout with EPERM.

I'm going to assume there's been a change in the VM image which has 
triggered this failure, since it was working before...

But thanks very much for digging into the root cause of this.

Please apply.

> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>   .github/workflows/cygwin.yml | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
> index 087a68a999..3c3cd93219 100644
> --- a/.github/workflows/cygwin.yml
> +++ b/.github/workflows/cygwin.yml
> @@ -107,7 +107,10 @@ jobs:
>       - run: git config --global core.autocrlf input
>       # remove inheritable permissions since they break assumptions testsuite
>       # makes about file modes
> -    - run: icacls . /inheritance:r
> +    - name: adjust permissions
> +      run: |
> +        icacls . /inheritance:r
> +        icacls . /grant Administrators:F
>       - uses: actions/checkout@v3
> 
>       # install cygwin and build tools

