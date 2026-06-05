Return-Path: <SRS0=r81+=EB=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 511FD4BA5436
	for <cygwin-patches@cygwin.com>; Fri,  5 Jun 2026 11:54:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 511FD4BA5436
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 511FD4BA5436
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780660490; cv=none;
	b=QBgJPqf5BEbUKanT6LGELIkS46clWNtjWuqygsfgqWJyifKJR6YOzfD2AHuNDNj69uoxdpo0654cjuVINM8f5Aetcmq4b5OtF8doRlYAZ3sLGPTRFd+QrqThKmIvK8QmXR6P0RrGAlzcH3kf6+sbUlSINiklHn8AWgkqja+F8xw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780660490; c=relaxed/simple;
	bh=cpfK9IcbjJU9/291Bsr2ZpbhSzwbQ5AaSXWXjQanLBo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To; b=jLAGeE39X9g4ZMcJn33Aou+xelHVIx1lRnmUx8pdM+nqBSSGIVSaNIafQZqBzfXWUzyOTE+cmm1oJkQ+Jzw/TkPv8CnIlKCVgW6wVNDEKtrgWk6MoeXKgxpYaPFA2By1UKvUiaNPLb0JFacMqOVeWzMslUjTCfeIQdVEkcqbHlk=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 511FD4BA5436
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A0659D001BC4C16
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTF43zTI6DGube4NNV9KpTdOWhsv1ar75Kqo17HS+MSCd+D3RK1qQYJkrx6r6E66BkNgkdKnAji8eC7Di53lngxBFVVr4I48eeI/1tXoYmL2xFMd0F4LMpWZc18ukK/fQdTRMuWwJHT1tfnHEZnbeB6PBNJVjmQczP8zKJWct8VySXMKl/snbK1lmmnJk/ZaHMTYy9sXcdGTQQLdDsxBMNxzSxcb4hnmPmoP96KO8UAZQm+PLVOt13PcPt/M958APAjxN9WxAAWXtXztmlB2dLlLnOm8KvP5+7e4lBHAEvzUR4w3atREnLaqKsmIHBvvdb9xO5ul52DXOlyAZhsVvuTxJYMGCcewWkb8dHLCiKbHDBIpWBOG6bbN3LlRK+rIrq1F9XYRUNtiiLBPzUQsRU8LMvbkEGUrpnafBrWPY/uxxs02fgCY5y1an2p+O0b482X8s0NbnQAUy0IismGwlZz7+qNkcwcoItXLiRjlkhJDoEipl6x/9VITG/6XGyzWennVpPalgmZVl06y1MAhhXBRisQVeD+RbzYdP4rbQSPj2ZwIaoAA3SqvINytgO96IVB3119dR/rYn9C7tbOSZCRkccKl8MlRJq45Bxu4jk1OjUyQSukuo7/owcoQ/S/JroL4xBmYrr6ZTYLi1RIVzDEqh3h9KJ1PQukpWPNfFRu+zA
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A0659D001BC4C16 for cygwin-patches@cygwin.com; Fri, 5 Jun 2026 12:54:45 +0100
Message-ID: <3ce89718-882b-4c17-9793-c7e4626a5181@dronecode.org.uk>
Date: Fri, 5 Jun 2026 12:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Adapt math functions to use 64bit long double on
 aarch64
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
References: <PN0P287MB029594AE234FC6A4B7F6B23A92342@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <d86f951d-5bee-4c70-9180-54f3f47a2320@dronecode.org.uk>
Content-Language: en-GB
In-Reply-To: <d86f951d-5bee-4c70-9180-54f3f47a2320@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 30/05/2026 15:48, Jon Turney wrote:
> Fix a typo in the aarch64 preprocessor conditional used in remainderl.S.

Pushed.

