Return-Path: <SRS0=pVIE=IM=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id DF9AF4BA2E18
	for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2026 16:05:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF9AF4BA2E18
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DF9AF4BA2E18
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792685153; cv=none;
	b=rNONhzVpfo1SgOoAs7uVIBbkv17H5fBjPYsLvOfVUSt54xGS9ODd+pjmZOrMDcVzlGbh9i/R49+4rKL3VvO4SNeKGUpMhlEpwgawBshU3PBliGwE7jykUmkJ75BIlw7eJp9QBWVLh0f0qgnFfrNUUdEwuk4qw6C8a+bHBTeRok4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792685153; c=relaxed/simple;
	bh=FiqVIJ5d4VkhXl65GKh00QRG6XKOGjNSWrRk+PupcMw=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=K1h/qLZGg6GpPlHwAn6az1E4neGgjVPoHZk1VPn2l5ZVfK0IKi+gdxc/YE2Syt+/RgvilO5KPOVdlbGKvERB5SguH9lhBCqwl0NBeOo3rLM58eVWMTsTBjuW4wHxFPcjuJq3HFWXAmHcDj1oRJnKRfJzRDeKvZ3VEdfAieQPh3k=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF9AF4BA2E18
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6AB2D6E506612FD4
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTE9b/b8T4qHOPzo7pIZxiuHR9s7CjLya6j8RP6cDM2yuIuN0kuepULGBesQbkzbTTEaXiPbXRf+3JkFW+cllY4ZCCfesQ5VaD8Tm7PydCPhcpIGoRwPS46NniDF75y7joCD4Na/0o4Q4FXZnffvnAtz2RSiTSM5GT4wte80ZlZFS5M9TJX4WlDkJK8GZe4T67FcBVHzunLwAUKF1E/RsFreNVqF/UAWVKnkCOK4DG0GzDtzbvHoOdbUvjM9/3o6oTbSwl0HE8tP4uqSqsJRV66JH3AkVSWzD/A+PD1Vnv1rI3JESPyPwUfsg18CetkdEmuRfRpN/OhDPOxyQun2c+j6mAgoB2yeqiF/XijZUdtZFj+2xH278SJx2d/Mpf/eLVE4b6uMnDTwaC22ci+4N2pSoEFhVoKsV/k+707AquOItTGYwsm5jKIT9GzzxU2viezeoeMX8+mrV+psbU1UZPD0OS9cmK3BZVJcttDcS8UkgOnKI8ewpEkmMcZG4e1VCDfKngclL5fXfAJ5XOvJucf2JkS4e0N7baOPssS41/JvPnnWbCU1aun7bf7mhwmP3hZa7lnLGNKpqOWmbAMOdy0su4X4tdlYCqUNSxuAfjQglb+3K/MCf2mekg0KyAVqSJxMhKeoiaxHobJ1YHIbwlemdjdZeRvx20Ow4PTVjsvuAg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6AB2D6E506612FD4; Thu, 22 Oct 2026 17:05:51 +0100
Message-ID: <6033c72f-2f19-46c9-aa4c-dbd722cca82a@dronecode.org.uk>
Date: Thu, 22 Oct 2026 17:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: autoload: fix ws2_32 chained init on AArch64
References: <PN3P287MB1320160668DF2DD69F936579F7662@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
In-Reply-To: <PN3P287MB1320160668DF2DD69F936579F7662@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/10/2026 11:43, Aswin Kalies Ramkumar Mangayarkarasi wrote:
> 
> Hi Jon,
> Apologies for the delay.
> Following confirmation with MulticoreWare management, I can confirm that all Cygwin patches contributed by MulticoreWare employees — Aswin Kalies, Chandru Kumaresan, and Thirumalai Nagalingam — both past and future, follows the 2-clause BSD license (BSD-2-Clause).
> Regards,
> Aswin Kalies
> MulticoreWare Inc.
Thanks very much for confirming this!

I understand that dealing with this kind of nonsense is no-one's idea of 
fun, so thanks for taking the time to do it!

