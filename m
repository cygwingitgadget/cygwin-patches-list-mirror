Return-Path: <SRS0=tD51=HI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.0])
	by sourceware.org (Postfix) with ESMTP id D85B84BA2E1F
	for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2026 19:02:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D85B84BA2E1F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D85B84BA2E1F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.0
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789585374; cv=none;
	b=NkVLdlccEKPtDhpORmWLwyXN8ONvZhF3w9q3fav/eqeFJXtVInB2XqvS3hEAbgb+Mxwq2BM+v014Mkdp35OqoHL3MJKIZKoabpNu/LK9umdzsVTwTo/ZkcipTriCTf1yHPe0NolYbTr2eehU6iiuDs6Yo09deIBcISExbglrlac=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789585374; c=relaxed/simple;
	bh=Fb3fIh33mizkSN7qy42G5pitFX1M0mXH71+WWuca3AM=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=cEVH6ktv5UrUCPy/3dU83xK02fQT3R3gN+xh/boDakapf6r+jvLvXZaOHXRrrmf6AKZ+qstcfOnaJ7vo0BfFk69aexgWQNfe4JWEv988ACIDYPwm/6wIGiNL+bHu/1Njt+qv/8bsRsfsdR/ygT3LjRcqfomuhvts+c9C6UpBnWk=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D85B84BA2E1F
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715E20082EEBED
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGPGp4Opsavjg23t5JmXrl1gC+5h7qoEtPDy0xc0cUOsm+LfjvzGQ6ic995RQy/u8WjmzWBbKpnV4mVzH0dy0sTc3UQIkHamCG536o+KRtvdvGzL+IB/rS0Watd/Cv6maHCa6PnUz9zo9eLvn05qQdz9ubMfzhNSbNxMQq0hHtE/BKserMmjeQ1MtLzi/fXfNsmIAGeUi3c8rTjzDjQGyD6sx/G2iVC+KmMY3aFzOTZEl4K1p3QYt2k8X4et8TVMhiV5UmCj6aZa2W1vk2ATjqrRmRoB54qq5Mz5SZoZ9wbcOVYclRWVX/OE5dIg0iB34zyQBFroitnGv+4tCi+a/8HAqMvAfKgAf7Qr1VKg0NNY56EASwSDkoutRXic6WrQ1swqf5yypAV9K6vsVgyIFEnOdCq2muQI37/JhSb2nTvDq3w/b43q0ewdH+VEJOaFTcC+dZWSQGkFAV7c0YLVgFfMpoEDtRvwCqljBy41Q8qABQeDvobB2vjr76YPawNlUMW9YLS7lMPcFIGnUe7BQWX93B0hvtqgAE0fXyn/U/Z50yGYaCh2ITiSrFzyj142S0/aTxP/0N4QnOhajjV/DtjmegQCFXl/9wkfefuhaRlWz8raS2vFBTHbuyrG63albXn34h8kvkBQ8X6XrFPASfMvu8loJxCGFuXg4rNN+HM4Q
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.83.178) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715E20082EEBED; Wed, 16 Sep 2026 20:02:48 +0100
Message-ID: <8b4eb6a2-3f69-456f-b8da-d0af80d9b40f@dronecode.org.uk>
Date: Wed, 16 Sep 2026 20:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: cpuid: add AArch64 build stubs
References: <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
In-Reply-To: <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/05/2026 11:45, Chandru Kumaresan wrote:
> Hi Corinna,
> 
> This patch adds ARM64 support for CPU information and cache detection used by /proc/cpuinfo and sysconf cache queries.
> Thanks & regards,

Applied (with 'stubs' removed from the description, becuase this an 
actual implementation).

Thanks!
