Return-Path: <SRS0=yzP8=EB=m.gmane-mx.org=gocp-cygwin-patches@sourceware.org>
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	by sourceware.org (Postfix) with ESMTPS id 23B1A4BA2E06
	for <cygwin-patches@cygwin.com>; Fri,  5 Jun 2026 14:37:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23B1A4BA2E06
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=m.gmane-mx.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23B1A4BA2E06
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=116.202.254.214
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780670275; cv=none;
	b=aFGeBx/bNer5yi+UvyfUnK0FgLJnl4NkfRcTjEVC9f5fmgDWxXCryIFFpiNHWSay1BJxigAbJaKHagnpqvO8nQfI2dMwnNoYjjn0k3RW+nCC7z1bc6vk9t6WWrqBItFNLQM//jFTpLR8slfoiezdeVjyPlneb2h6eXLQx8U4dZY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780670275; c=relaxed/simple;
	bh=rwOTzAXxEHOuDld/EDi+Enz1Ti5xZNPUXSHfzqMgiV0=;
	h=To:From:Subject:Date:Message-ID:Mime-Version; b=hUMZzUM9SYDkQ4owyiDc5Ew/3474nm7lJ750CfBMUhL6P3L20YorZWGStHA2SFjyPPLPSLIAP3Q+gd5y1M9Ite5H3zhZWSmVCQwac1gcJH5zN/a3fNhUHOi/yXUrKnOwT2A2MKL0BRWUKSLKLCDh/95zsstnZI/kaV/7cIm0HVk=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23B1A4BA2E06
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gocp-cygwin-patches@m.gmane-mx.org>)
	id 1wVVgH-000ATg-PZ
	for cygwin-patches@cygwin.com; Fri, 05 Jun 2026 16:37:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: cygwin-patches@cygwin.com
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: resolve AArch64 linking by linking to onecore
 instead of kernel32
Date: Fri, 5 Jun 2026 15:37:47 +0100
Message-ID: <2549df98-c96f-48b7-9ddf-f1272ff505c2@dronecode.org.uk>
References: <DB9PR83MB09239F1F48DD7D215E1A0B6E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUCHQvK7UKMepvh@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Cc: cygwin-patches@cygwin.com
Content-Language: en-GB
In-Reply-To: <aHUCHQvK7UKMepvh@calimero.vinschen.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>
Message-ID: <20260605143747.8EvTPVeGX4VEbI7WgTAsCALofJJ-0lPM8-Bj-QMUgXA@z>

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


