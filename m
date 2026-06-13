Return-Path: <SRS0=PY97=EJ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.6])
	by sourceware.org (Postfix) with ESMTP id 2258A4BAD17F
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 20:03:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2258A4BAD17F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2258A4BAD17F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.6
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781380992; cv=none;
	b=pHhhCK0Vxs84+LhDcWWTEN2CbYkzE0223mSa8HeqjXhZocs9LKUGubWFEwrtggb1kplGsS26HuM+zQFniR1C+h35Q3wecEtEvpLyc09qy5aGweeB5YuT14ncCDkzxU+3c9eTX59Zg3lCn8hVA4WLyjkCOzUokGw+Et2SoupT0s0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781380992; c=relaxed/simple;
	bh=HMM6zrSbxaxeUMLWTIyXOh7jThLnFq4q/x81g//vUYo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To; b=I9BB64X6o/MFNB61OVw/wSoy1ESk5CXsW3NPb7gm/7n4QZEff8ngAw9DAgxBFz34I8nM4GomFUzf9iufQ+slOlduL1AMpc3Imvw7KzWtdBDq1WDHRAs4SAdsozCfiz6VacWGGXPF1kDAsOkTxA2kN8vYqZuBcFo/iEe3F8/9WkM=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2258A4BAD17F
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69E784C5046083C4
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEHJvGBD2s2b8yH+IvRdBQtYfsfhEYCC7U6rwl/7Q89UAwZgIXTJd7c5LmkjRILYfKJzAGpsBSDkM2YX4JvkNL4SINsAEv6Q9ceznfc8XnMdlOlTvrk9T9SbZcwQZTsDf3mdRfGjZAaL/beIrkU9EbXxa5yP16oNoTZb5kE4CbGM/o0oCdPaJgnNBy+yIUe+HGR6ggXKmzbBMvY/oqBqjNx5liIgfethyLtF3dmywl+7TaDCuTsoJVUfSdwu6urE6p5wD2ZZQfI3oxRoQvzwl1KSAu6pSQT0ftZa22xZp+1yqyFWujCEB0XI3bJU+0iEW57BbOSyob5cOTLiNldIZr4UZO0awodtu80mH7cMjJjGqpHgiPQEe1Gxky3hg5jmExghj6YSt/viqqNBHdaSpEqnfFfTgp9friLB2fFUuTPNAvzpsR6XkMGFuwAzyhfF5ScucmjAySBf5vlKEYDG5XRXoR642QUg+1LFqXI5GtlZuEQq+hC8nu/hC2PZFhkuyFFSHmF14I9K3PIDtJzfW+oMjMzE+yHk1RcN6JQ5RVeDLZjy9wGVBMQROX1eUwN8a9GHTUhKeGynNyn6hB7SztKiL9Ii6VNFifBzb0MGYhDyQ/Te96y7wU1a7TxQKJr9Q/PQl0tuwR+FFN88sE7VAr7/voljQh4E6TQqATQ/fEXcw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E784C5046083C4; Sat, 13 Jun 2026 21:03:06 +0100
Message-ID: <ecebaf4b-7558-41b1-ad80-a7fe52995673@dronecode.org.uk>
Date: Sat, 13 Jun 2026 21:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: resolve AArch64 linking by linking to onecore
 instead of kernel32
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Radek Barton <radek.barton@microsoft.com>
References: <DB9PR83MB09239F1F48DD7D215E1A0B6E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUCHQvK7UKMepvh@calimero.vinschen.de>
 <2549df98-c96f-48b7-9ddf-f1272ff505c2@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <2549df98-c96f-48b7-9ddf-f1272ff505c2@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 05/06/2026 15:37, Jon Turney wrote:
> On 14/07/2025 14:11, Corinna Vinschen wrote:
>> Hi Radek,
>>
>> On Jul 10 19:14, Radek Barton via Cygwin-patches wrote:
>>> Hello.
>>>
>>> As Windows Arm64 platform does not carry historical compatibility 
>>> layers, the structure of Windows API DLLs is cleaner on Arm64 than on 
>>> x64. For this reason, the x64 linking against `kernel32.dll` is not 
>>> sufficient leading to undefined references to many Windows API 
>>> symbols that are in different DLLs that would have to be added to the 
>>> linking command explicitly.
>>>
>>> To address that, there is a concept of umbrella DLLs (https:// 
>>> learn.microsoft.com/en-us/windows/win32/apiindex/windows-umbrella- 
>>> libraries), that can be added instead. The recommended replacement 
>>> for `kernel32.dll` is `onecore.dll` (https://learn.microsoft.com/en- 
>>> us/windows-hardware/drivers/develop/building-for-onecore#building- 
>>> for-onecore) that should be available since Windows 7.
>>>
>>> In case of Cygwin linking, there is one exception, `pdh.dll` 
>>> (Performance Data Helper, https://learn.microsoft.com/en-us/windows/ 
>>> win32/perfctrs/performance-counters-functions), that is not included 
>>> in the `onecore.dll`.
>>
>> The pdh functions used by Cygwin are NOT linked against.  They are
>> runtime loaded (see autoload.cc, right at the end), so it should not be
>> necessary to link against libpdh.a.  Can you please check again?

>   I assume that -lpdh has been added here because the autoload stubs 
> used during aarch64 development translate into direct linkage.
> 
> Hopefully, it's not necessary with a full autoload implementation .

So, my speculation seems to be correct.

The other issue here is that we can't link against non-well-known DLLs 
here without making ourselves vulnerable to DLL hijacking attacks. (This 
detail probably needs to be noted in a comment here).

It's unclear that to me that the onecore umbrella import library makes 
that guarantee? (So we could accidentally introduce the use of an API 
from a non-well-known DLLs without noticing)

So maybe this needs to be conditional on the arch? Or perhaps the 
solution is to autoload the problematic APIs here?

