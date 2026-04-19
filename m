Return-Path: <SRS0=7xjp=CS=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.146])
	by sourceware.org (Postfix) with ESMTP id 3FA164C900E9
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 15:46:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3FA164C900E9
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3FA164C900E9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.146
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776613598; cv=none;
	b=Hdzc8AiT/szB0wzVQJWIldqQvUYthzrS+5Wki+2by2NtA7m3qMal3CYRqxqfDzPp9lykBb86XFU+p/yArxw01HfMkEhjvtO2W5jmsN3tf9NTNTlxFM5QZvD7ONQic/9EaOKI7yThxbegHBnH6ndSVuDhnju1XXjf22axyN0fWVE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776613598; c=relaxed/simple;
	bh=1KHiDMQCk+F5OzjVVGqaJbo1KWkRlB0nB0qfl/7/ZKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=YPT2P3USB4ZdRjd6H8+Uojf9ByCuOpehYHJg/LmuqKqask7UB2Svt2q7cvVa2OkmhRkJbpfCF4w1VZkZNHD5yP22BJC+Rc1/pmgULjlqIUAYO0+7DVw87YYPvjrluXiRUiq3TiPMLMyz9GmodNNRPacdBaCIYMF5sMJIUaVP2No=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3FA164C900E9
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69D87AD800E7D31D
X-Originating-IP: [62.49.245.144]
X-OWM-Source-IP: 62.49.245.144
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEBUYll/Ty5udmspsrQrPs4/fyQXEmnida/AKbiQ1RExZ4WLaz3GE8wAUsJ52w5bRPs+H0WGu370WJtpN2LZWSIVD92UUlSmCmnn45gSb1JcbPdHTi70R5byiVkMFdL6v++MUkHZV69DWoBFuvKiMAGErMBdOoONU7GpsNisl5+vTFTL/jYsAiI663VZGrLsc9mvI/B4stCt9OLzv4BBET4bWahOii6fnF98Hq7oAKBUyW/D844G4BZIAFe1Xe6GtjsjlN7orupJY5ePJ6CLbN12cFvimu1H9sDhIlBrkrJAcm/1oErMhS3o2RLTj3rJogt4WNUhOg9W0hLeu6D1hO5gU01UfPEqeeuqNY9ikqa4vXKpQmZwUy3pSHv2nJDVRTnh+S1uQoceUFMxU2+wTAzVAoJ8KJNthRdQn8MsBnGYpOlbswzGIF2p0aJXxWJOkCjq0JAatV0c9shWZKTcQjcciSsfDctzGrebUnNx1imI87mfQbZ3wRIaYkCxEV6jLIbwa57/DMwlKz8asZkm60n+WT71xST2lPiGp6hje7+1geVmiGTLzOULa6S6Vc+TKnDWA537x2kM2I1I0SEsUnXXQFoLPdA8EvmyJWzlCvou7bYhwBvH02GpScmZ0O4HcQRRjknnrqOHUSDjtJI4HWpcIuNTn4+LZrCFOnJwPLEaw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.245.144) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69D87AD800E7D31D for cygwin-patches@cygwin.com; Sun, 19 Apr 2026 16:46:36 +0100
Message-ID: <ca240824-43d5-4fbe-b0bb-640d214aa3f6@dronecode.org.uk>
Date: Sun, 19 Apr 2026 16:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] cygwin-htdocs: website fresh coat of paint
To: cygwin-patches@cygwin.com
References: <20260419052701.513-1-johnhaugabook@gmail.com>
 <aeStmeiBYWp4iVKM@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
In-Reply-To: <aeStmeiBYWp4iVKM@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 19/04/2026 11:25, Corinna Vinschen wrote:
> Hi John,
> 
> Thanks for this!
> 
> I guess it really doesn't hurt to update the look of this site, which is
> kinda stuck in the early 2000s.
  Indeed, thanks!

> Jon, would you mind to review this patchset?

Yes, I'd noted this to take a look at.

Hopefully I'll get to it this week! :)

