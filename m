Return-Path: <SRS0=J/el=FK=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.244])
	by sourceware.org (Postfix) with ESMTP id 3C79A4BA2E3D
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 14:09:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3C79A4BA2E3D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3C79A4BA2E3D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.244
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784210987; cv=none;
	b=c73WSTpVTamMu8z980B/sf8iJmOjoPkpOTCWzXVT4UPAiC5OQ8YHvFtGsFihZvfonpjTH448aQndwlv9ccNXx3M6YgzVTrBTbEI4wsTkhF0UrjsMxg2FHDFBKwubCR1ZIfwMtPzqI9cRmhNdOqMJFwO9WitPairkucbeHFCzZ/w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784210987; c=relaxed/simple;
	bh=nb5VTcKjjuGn2sf811cjygUZAAZ47LU3CdFjBhdTUcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=VpP5fJ2mfSbRekDMfv8NUAiTOZ/AEaVt+wJhElc66ZgJAgOwj5g2lMnvQy0ZNIUrZEvqTybg/8tzuea4IQnXgloDBzlhIrTLPe66upMlzpfAjdd12TqRQZ9XtUb3Fge4nPOCSiWbmWBF3qwucsSdcMVSVcSs76caZMsAqrNZozI=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3C79A4BA2E3D
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69FE539D0592ED0A
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTG0vbyEt1zmnKDIIXz8x3mInyp46Gs7PeWc5JyBFeO9ThaSQir7qS3UVI1SZpeJeKEUXh3DIiEo49ehpf26nfojIMEDn35ilf1EGX88Q/e+fta4nRdyPnGQiQBQ0rUAhy7nOIwZAO4c0LyyHBFXdhXumWEDVqTW0n+RX5Z9rX/GsDtesQ0ubr6t2DlYR4KAK6a/lnumF7skvNzk3GvQMZQUdo6fdN2M4/u0wt+Hcz8BagzLgs9uNyngsxAylLm7IwEQxfqIPeCFPdaFo/ex4F+AbjHMGog8TIm6/pfDikeMUDUCC21vwGEGBxehmWeYizKdzLEYAXKz0nnOKgbnzFJRQZ6GmVJbH7Mdss/7n130LSz76It2ZRD2WlUfRCoYWgkKUYO5kbYX/JS8iQ+Ydk0UxQIZfrKaNMua7iEfsAP5+T1kfN/pJ9QAuNSMAWgTcbSD0uw/NFH3P4u0NuCAgucHejw1CP0NGjBViI4bqogS9lQ3/m7xp3E9QHox9bbi61K3/l4/1oV6/MzxKyUp9OouGwSBcJ4c2wDXPyQ4ECqunic4Z8DA1rIO/rGDxtIRNbi24y8j6vY2Nv5TmGcvo35jw32Kpb+hjvl9mJAKk/40KRVtX+PrhP4TqC3rbhJlbf2BxmvbCigC7E6lFNfLBYkwjomZ1oC4TPnZZ25xLvEwlQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69FE539D0592ED0A; Thu, 16 Jul 2026 15:09:45 +0100
Message-ID: <2f2badd7-3c04-44a2-8beb-52d7f198c5e1@dronecode.org.uk>
Date: Thu, 16 Jul 2026 15:09:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: CI: cygstress: update for stress-ng 0.21.04 and
 current Cygwin
To: Christian Franke <Christian.Franke@t-online.de>
References: <e5e2fff6-0629-54a7-ef24-4d7931a7e50a@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <e5e2fff6-0629-54a7-ef24-4d7931a7e50a@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 14/07/2026 14:35, Christian Franke wrote:
> Related: https://cygwin.com/pipermail/cygwin-announce/2026-July/013134.html


Both patches applied. Thanks!

