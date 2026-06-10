Return-Path: <SRS0=Xo6a=EG=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.133])
	by sourceware.org (Postfix) with ESMTP id 8290B4BA5435
	for <cygwin-patches@cygwin.com>; Wed, 10 Jun 2026 15:06:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8290B4BA5435
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8290B4BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.133
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781103992; cv=none;
	b=fnhpgbkatjmlAgoF1MyBAncOKeKeQRdS+uXI+V9T9j34c5DdwX2J3JKVphU8ue8DggT0zWWmEbU1otn1a/OeEEkUHysW3sI2B4cBvtbBK8ZsBapSDXquuKzvcvsyVRZp2DM74d5YC4qCx0vJg5QBiwfVULWf2LKK7gSnY3hPNas=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781103992; c=relaxed/simple;
	bh=3eirrfdLruhNrcD3FFUCUbvHGs8z0ICSRpdRTIlcNBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=WcRK4JAnkkRwhEk/C+aa51eZuxL8vvYU/qfD/4UgN2ppTV1o0SfEnmvUNZLRaIj53Pn0Nm4MjEzaPZUaLRxeWNMACc7veyOjuI4BeSCKHtXmyxmtVB2TbrSTh6iWdzrfO9eRkdJoa9lZ3F8FI0Ktzj8DYCUqHoClhThl7mTDmNE=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8290B4BA5435
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69FE539D02A41BD9
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTF2KzAzZPY/rai1YbAT6+uLhCf1c0dA7ivlWl/Yi1qI7d48B/4Iii9R4RX+387n3k+PAOk1dEMvuPBjSaQZU05L+DPp9tUyVUYCBbZHgVsuQuYPhdwv3eFeesfUJ8qWwx1m6VpWOZHZkL6yommVuuYfJkL0UbrLQP1RG+bwwbgU407l0h+BH3Qe9fFBqMz6P8XGjVoG7nOlthdU7ROpTnzyh6EmDJldCst4PBuqoj/qeaVxt8mqk4JXBpsWaUR2t7YwnKrqfq/7wk+G6FB4IlDbfrFkq/ysAjhmv6z58Y9P66ne/yPari9qzMKQO+kayt8ndCqX6GurrNBcHnyMP3cdQf0RgCWx2RJ1qRWm7GqGOIWIXSAsD245kItFxbs0eFdAN0jYAdll++boaQlmOV0kKdpUPVe7DEJFirxXrvUJUfO3F6W/jeW2xbSAMYIQtgpGpA1nM21sKpuKKzS1FYbl1Ti1L0D3SPyvjpBl7Q6B/1nMGyPMd/LLtjc1yBsP7IDd3L29/wfB48XiTxsJ6BNxZSJZtDMa+2R2qfK5vOCTDzKOBDxOa+2EcwfSFqVpWj9hhlzBl7YScbwBrJ2dWwizDW9izLch9pN9i1fEo2lA9zrqSjnsk7Y64/q3fn95rUu4NgY/mXdqUM7jic9JdXrCONjI1caSWbLu88dMl7gK9A
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69FE539D02A41BD9; Wed, 10 Jun 2026 16:06:21 +0100
Message-ID: <7b47275c-3c41-4a90-8f24-c8bf2fb57769@dronecode.org.uk>
Date: Wed, 10 Jun 2026 16:06:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Fix chown commands in cygserver-config
To: Mark Geisert <mark@maxrnd.com>
References: <https://cygwin.com/pipermail/cygwin/2026-June/259787.html>
 <20260608221103.958-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260608221103.958-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 08/06/2026 23:10, Mark Geisert wrote:
> Change "chown 18.544" to "18:544" in two locations.
> 
> Reported-by: Lionel Cons <lionelcons1972@gmail.com>
> Addresses: <https://cygwin.com/pipermail/cygwin/2026-June/259786.html>
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: b5a7cb02cd9d (* cygserver-config: Use numeric id 18 instead of "system" in chown.)
This has got to due be a recent change in coreutils, right...
Later: finds [1]. 2022 is kind of recent, right? :)


Applied, thanks!

[1] 
https://cgit.git.savannah.gnu.org/cgit/coreutils.git/commit/?id=8f31074cb4c9b023ef0aa47a0ce34c92745169b6

