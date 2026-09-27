Return-Path: <SRS0=e2Sx=HT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.159])
	by sourceware.org (Postfix) with ESMTP id DC66D4BA2E09
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 15:51:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DC66D4BA2E09
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DC66D4BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.159
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790524296; cv=none;
	b=sRR/jPpeJUiTm3d3yvfjCs252BUUP98qeLskUHOaAQwlHaXTl0XGZHFlGKSLf3qwxr3JWGJHrQNcJ7yShjJdXHnG/nHI08Wd+LTQKfN59PP+tPtRAV0WMhzNjSrtZjPz0E06RdnhcUeKUSwZzPV/E7qN+ygv36hpBnZ8wJtRUl4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790524296; c=relaxed/simple;
	bh=F2Xhuw8TRSVoGY3DKG7BeX872iPxOohM64z2e7iZ1/U=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=QARG4lEiXorFv7Qk0TEUPRmZYD4Hsy1IcE83OlaFu7IK/pk5fgshXnJXOZ6XRRDyqiB5XfPqr8KQ45REMtV3VRauGjTSTgA+kkLAFvKhLZKU1UwWUDOg42mFss+CIGluvxtwFQe2n5S6mogyVIbmncL92VJ+LugbMNvvFqZTbcs=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DC66D4BA2E09
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715F5F0A75DAC4
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTErnrvlobmV+Emypu19rK+FhExjneiWitfAtKBq77rnxf+K/+43D8N7W3wH0xEmyfjiC4HmISO1gKUvaQh5BDRXaiLkrBFqCPmkgQNFxnQKPW2q27RGYOMx9tbGPqvRWYN+fgunW+M8F34/wJLd/BrQNuBeDGiP1CI3p38ePdJd0qEK77hdLKYIMS8I/pGp5UPvrB7gAUH2JTPT7PrJQWyskErAzFMJhXdRvbGG7TxweoMkUfKwDrSxL64IKG9kMMnvq6DsL4J7oOxs2RLhjRClJrACZfma1nTUaxV4ULQ5QpF4tyL+iU4Wwqus2adh21hwG7qDYk7CH5efltE4ZMxmsknbIaqFYJxk0re/3mcpztPkRP7rmcgsNQLXeQLitQDQZzij+KkbUz/VYF7b2ioiFRLcfifxoFqq8m2LE15IX4ZRFjMoh8puM71Vhk5yC9IpHru5K6L0rQmqJbsI1NacCe/KgFeuKRvP+HBDcepPYWn4e2J5hvl3lcaE/cwzbJsBYeMHoQz9d2hBwxjDceFS6aK+xsTZC0lx4Q/tvzUbiCKfud/X6hGXVhboekeHBbzqJkD20eYjr+HIu341Y/NyCdB1TOpKHyBceWKSC/tOby/QcSGc0TckbymARY9yghrsoTQCoYXsUo+VZ9fNcz5TEWgaMe9EbMpfnRA3GmIWWA
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.83.178) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715F5F0A75DAC4; Sun, 27 Sep 2026 16:51:34 +0100
Message-ID: <80096c71-3a5e-41f3-bfc2-39468d112215@dronecode.org.uk>
Date: Sun, 27 Sep 2026 16:51:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: gendef: fix AArch64 _sigfe_maybe control flow
References: <MA0P287MB3082181CE402F12F043C3A0B9FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <6fd27001-6a1f-4d20-a621-e395b6b85762@dronecode.org.uk>
 <8ad1d40a-0842-47c4-bdb0-fa2278abcde1@dronecode.org.uk>
 <PN3P287MB13204A129D5E0E0B6AA29CFCF7842@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
 <8359eb58-e817-4601-a3a1-40de4a72b5dc@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Mayank Agrawal <mayagr@qti.qualcomm.com>,
 Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
In-Reply-To: <8359eb58-e817-4601-a3a1-40de4a72b5dc@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 27/09/2026 16:26, Jon Turney wrote:
> On 21/09/2026 13:04, Aswin Kalies Ramkumar Mangayarkarasi wrote:
>> Hi Jon,
>>
>> This is a fix for the _sigfe_maybe stub you reviewed in
>> https://cygwin.com/pipermail/cygwin-patches/2026q3/015305.html
>>
[...]
> 
> Gosh! Good job someone took another look at it :)!
> 
> Thanks, and applied.
Oh.

I should have also asked for a public statement about the licensing of 
this patch from the original author, as per [1].

[1] https://cygwin.com/contrib/dll.html#before_starting

