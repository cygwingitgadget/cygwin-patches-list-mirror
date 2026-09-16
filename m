Return-Path: <SRS0=tD51=HI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.123])
	by sourceware.org (Postfix) with ESMTP id 4AB364BA2E1F
	for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2026 19:03:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4AB364BA2E1F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4AB364BA2E1F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.123
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789585437; cv=none;
	b=o/w1hbBOAQSrNUyyKGtkWDj7AWqmyFWpdcgkEjBpMCqTGlPiKsBHR+CSW3KGkg70IJbud2Y2Ue3D/9My9HNLONFcGGOfVGSxg6VTRZPB/Yz2FajHk2sS9Jop9F7Y8KDRnWcZhW3ESpjXS8d5m1fdoQFDLrMA+q/ZX0W6pT4lwxU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789585437; c=relaxed/simple;
	bh=Y3SE6kGsde1hc2W+b4Ddhz1iYOVtZav5btJ4nxFB/xQ=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=ks5YxZ1qdUljSdGqAAxX/lAB5BMh+eByAATkeLqBj8NQZlWhvVTV+w4HK5yJxQ+cNWoUljBAQEZeroFx4VN3cbNAaSeLkJ7y6w6bJImVL+tXmvTFtTzgWHJZP2vDUPM59AaCMzxU6EmBj2ACuWKF9MH9UreyvyF2PmW9Hg3/So4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4AB364BA2E1F
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715EB8082EBCD4
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEw2Ri60pZxHDB2dC015WOruNGDWElfJtmc7WEPI/A94H9iLIxDBdOf4m50VLejnfMY68Fr5J1ZECp10pFl/FxarMY8DSxdSpRjnKYYeAKM3O2p2CVfP7Oi9wia6juSsgMbu0DaeMJq07irify3g1rEk7ol6239IuZigZVDrrCdhvlFwuIxzY+9cLMZIpBhKnIMWwwOwqpljiG7/5pD2JCYCGbYnrzKFFiN8ORO6qOmUcpxLnCBcWj1e4Nehm4CmWrKmMcwogXKLgsnX9gofJC0Qqzarlk40beDVSJx07RzFBJo2tZczgFND9HFnZUsBqDr9UgQZOcMx4DBNZvi/a6MlwinK98t4B0Y/HFVMFOvntdRLBR0ikG49cj4TTUbAduWYMpWHT9vm1VqEWScSiPGK+Egx8ebPapjIXcfzEEQa3mxEbhUEjt8TDBX3/xxTlzNdWQuG5TnIv9/MkyGv6d/zf6zhwStxjgqOdn24LNwij7epgLiOUZHC5UTpqdam9Uyuzd+0cd0Ec2Qv663DRGFFiD5NurgVzutxUUDI8n/JCKYJXXRfY87FhKTdfXnGffp5kzpRb8OI/pXlwUzq2kEoq5j5eTOpzAf+i0wIgEWl+qGr4g8w3afIdcFqJDwDaVaRAKpSF/CHfFV1DJVv47TZnZ+96Qs6vZznN+Akp2xqw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.83.178) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715EB8082EBCD4; Wed, 16 Sep 2026 20:03:54 +0100
Message-ID: <6dc5f7a1-859a-4cdc-a7e0-f73fba804016@dronecode.org.uk>
Date: Wed, 16 Sep 2026 20:03:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: gendef: fixed AArch64 setjmp storing incorrect
 frame pointer in jmpbuf
References: <4635aed1-eceb-4540-9071-2a4cd257b27c@arm.com>
 <80308c9d-127d-4f12-bf91-aac8e3124cc7@arm.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Mate Dimand <Mate.Dimand@arm.com>
In-Reply-To: <80308c9d-127d-4f12-bf91-aac8e3124cc7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 14/09/2026 08:02, Máté Dimand wrote:
> Hi everyone,
> 
> Just a gentle ping on this patch, any thoughts or feedback would be 
> appreciated. Thanks!

Oops! Sorry about forgetting about this one.

Applied, thanks!

