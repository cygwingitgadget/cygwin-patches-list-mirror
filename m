Return-Path: <SRS0=r81+=EB=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id F166F4BA5439
	for <cygwin-patches@cygwin.com>; Fri,  5 Jun 2026 14:37:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F166F4BA5439
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F166F4BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780670274; cv=none;
	b=JMvzq6VFgHNB4+SzzxdO0Kgs2pyTp5yC2a7BAD6+PWr0nArRrTzClHGdN83mn9EAdAHDVvmL5Tk+HzM7bm6TX1mx1up4UzF4s1GhlYK1RF8QoK/d5EsUbZ2tWQ/4wWFAhoLbHFrnbjjnZPW1OAmsdgQftGeLqTTlAWNa8pmbmag=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780670274; c=relaxed/simple;
	bh=rwOTzAXxEHOuDld/EDi+Enz1Ti5xZNPUXSHfzqMgiV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=jfWf0EwjiUv9tBRxtOkeoEOcuOd3SQMHe49iEpRAwlDKnOA2eJwIOs1msgVxvsamZi5sTw+e5UYwkVgHJdZvh8No6DViDkWDMbftcWIXrnbHmQADAyCwiFvbpQ/pCPzajoAno7Ka0kDq798lYY6ijai1800LzP3cngjuJ13iawY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F166F4BA5439
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69E78B8003A943DC
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTFfb+GqkEtkodmZOf3Dc37Q7U2HcBn+YMo7nLLRgJTCRjQ0I8g3AqjeK1xWIUBUt/53u5Cp3mTgPwKKyhzrX3SL3AM55VZUGy+BD+76GCg4TXd6VJ4b2VSzfJdcWrWj+Nm7XQgqER5cg3w5Dhh483r24CZ3XyI6A6EdKBqPO4WJJHNjsiOOgko9Tzpwdopbzd5R/UbUrXSr8JMYzCj1xYwKO3+uADt7tiOhgnsrz9EDysfWrugjjw4BNqzGkaeaB8oveK1lw4m0QVXZhKZnQx8IwJ3D/7FBnrvqF+og7zjYqt2hDCx90QFi3jvdZOR/3uCNYzv3+jBsy46iyG3HXugnEzZWP68Q3mojMq6lFbw6eGlpi35Z0bR2Q8prc3yCMG6imVy2pZXUAihOB3M5TPzQkRgveri+ZTgOP4OsbMhdgNWzB1ZWxBw6ON2TGiU6BGvJYLfd4CJvSL3mZmUw8wm+70w8vrululDAxuZ+Cn7V8xt0I/IqLD394FQ8aKWjvEJbY+s/+puAsNQhvxlkWGtP9qc1f77kNeUkp8996UDiYjCidQUpXl4B4FLZfKk4uHSF9xLsM59v8eu0CV2sCd55S3whkTeQxj0oEBLvJkVfVF3Z8Qi3EJhgAu03ql9np1Orm0fRPeFJo/8xOsGnYqpRqfaOYZIckIS5DeyQ0pC0PQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E78B8003A943DC; Fri, 5 Jun 2026 15:37:48 +0100
Message-ID: <2549df98-c96f-48b7-9ddf-f1272ff505c2@dronecode.org.uk>
Date: Fri, 5 Jun 2026 15:37:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: resolve AArch64 linking by linking to onecore
 instead of kernel32
To: Radek Barton <radek.barton@microsoft.com>
Newsgroups: gmane.os.cygwin.patches
References: <DB9PR83MB09239F1F48DD7D215E1A0B6E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUCHQvK7UKMepvh@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <aHUCHQvK7UKMepvh@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 14/07/2025 14:11, Corinna Vinschen wrote:
> Hi Radek,
> 
> On Jul 10 19:14, Radek Barton via Cygwin-patches wrote:
>> Hello.
>>
>> As Windows Arm64 platform does not carry historical compatibility layers, the structure of Windows API DLLs is cleaner on Arm64 than on x64. For this reason, the x64 linking against `kernel32.dll` is not sufficient leading to undefined references to many Windows API symbols that are in different DLLs that would have to be added to the linking command explicitly.
>>
>> To address that, there is a concept of umbrella DLLs (https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-umbrella-libraries), that can be added instead. The recommended replacement for `kernel32.dll` is `onecore.dll` (https://learn.microsoft.com/en-us/windows-hardware/drivers/develop/building-for-onecore#building-for-onecore) that should be available since Windows 7.
>>
>> In case of Cygwin linking, there is one exception, `pdh.dll` (Performance Data Helper, https://learn.microsoft.com/en-us/windows/win32/perfctrs/performance-counters-functions), that is not included in the `onecore.dll`.
> 
> The pdh functions used by Cygwin are NOT linked against.  They are
> runtime loaded (see autoload.cc, right at the end), so it should not be
> necessary to link against libpdh.a.  Can you please check again?
  I assume that -lpdh has been added here because the autoload stubs 
used during aarch64 development translate into direct linkage.

Hopefully, it's not necessary with a full autoload implementation .

