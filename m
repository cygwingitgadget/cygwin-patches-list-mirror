Return-Path: <SRS0=bCgQ=I3=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.62])
	by sourceware.org (Postfix) with ESMTP id 9AFA14BA2E0B
	for <cygwin-patches@cygwin.com>; Fri,  6 Nov 2026 11:01:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9AFA14BA2E0B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9AFA14BA2E0B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793962862; cv=none;
	b=FhSWD3DZ96RFloYMPcqzI1eaMRkVZK+qgV+C5KL9zRQudf99UZQfhUfP3m4gSbdtu1D1FzcRfSCmWtGU6X1fHWkmRN6FH9BCnBB3TyLeV6FOABNxYf0pczZStaYSe07+JiUdXQpsAYGZ8Fy1dRSKhg5Yaj+NG9ZUQK4L5TDcKEU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793962862; c=relaxed/simple;
	bh=pM1GVqrsffU9F6KAbmiABPoU5sBR7AMc5Hv+xCL+nBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=DwhnWnvC4W9+ewKt951gY3Xi6PmYG2/5hkGy9/KzTeJ5ijrOjBVnGI4Rii02VKnfmlO+YjBYvGu6+9BHW6ZL4eMLcLce4ag0pI615JOsFRASiMloIHQKbg+w850cf2IharFRc6Fiax3oh8sY6LBGE/9QN+feiq3iB3xDgO17g5A=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9AFA14BA2E0B
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161381400A521
X-Originating-IP: [80.176.81.8]
X-OWM-Source-IP: 80.176.81.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTGmAh+d5cgMuE36xr0K0Qz/pSFlN2XSQi2FoZtE2x/XcyFuWd3XQPLXHO4PwLKwyfW3ZV2Eahq50G+nuADIt/tbHDArMt+2MprVQbhgYJvSHHwhDjHqGqyGaG1UNjSqDVuN7W/hVYj3e7ntAISvpPdM4PqmjPDhpTdXYPZiFEkLs4tDsgtB4/IfC/Ve/TPiyYm8UKkj+O+dK6OY0Cvv+KuLYICivLohEr/zXe46pk4jTVJYqJaGv8SJE1I1oYDjwmzdc6BjTvciKyNqRcCBqLVQR38/emOJnmd502Zo+kMpmCeUWH1RR90tBLbFm1EM0maN/9xRq77P+QhSBcF6D6EyshSAVXV5GbfKNs2ARPw3BVHkbzX4h6GhWwNHfrCO7QVAcj9ZQz5/+spN6Ta93LlwJEOrBF5bOFOY5e11ccpeCb0ogYKeqp/cOZZMrdBdUaolBbYVMg+9itP6AIkGeqsfESGfEiX02cNQplTL+ePAj56FtjWwNrlNM+VM/MACbYiTHbsONTYymjbyxct0hjqFTeZFNuDxUV519X0xBM5j4ll9poFkOD5TNiXadaOYoF8ODy3V4L9ghvtx+doK/a+H5r0oBqa7gJE0hjXLiSt0XfxUVoAH9XfMlhUpUMOAbo1gDv5q6JiAOji+dFwzZe9wOy5/HZPmrrLdCsXfC0N5Nw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (80.176.81.8) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161381400A521; Fri, 6 Nov 2026 11:00:01 +0000
Message-ID: <467663c7-d1c1-40b2-999a-b7e6b829bb6c@dronecode.org.uk>
Date: Fri, 6 Nov 2026 10:59:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stdatomic.h: fix the type used for atomic_wchar_t
To: ASSI <Stromeko@nexgo.de>
References: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com>
 <87a4nrm8x9.fsf@Gerda.invalid>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <87a4nrm8x9.fsf@Gerda.invalid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 02/11/2026 17:37, ASSI via Cygwin-patches wrote:
> Johannes Schindelin via GitGitGadget writes:
> […]
> 
> That fix should be done in newlib, not Cygwin (and then not in the way
> shown here).
> 

Yes, this patch should be sent to the newlib list.

But maybe you could explain a bit what's wrong with it?
