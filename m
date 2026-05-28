Return-Path: <SRS0=rdKM=DZ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id 36A7F4BA543C
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 12:33:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 36A7F4BA543C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 36A7F4BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779971625; cv=none;
	b=YxBbZ5ayqYleGz8vdH2fGCJCnY5P9ONJIb+gYJ2OpiB5tHQDl5iVfq3ETVNDpkAnJ8xZzeYDKPe0XyvblNzoXDma9SEVozstWCZJ79wTT3e8yR/vpXgPl3U5AK2xwELAAwRUyoRgUd1buHFrollcmRGYsTb4M94JymII5g645aw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779971625; c=relaxed/simple;
	bh=8/4GYjI/KhJLSbciU22gSoay7Cu5gc/LpQO5CCaPIrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=WEsWUdr0DdwJfx0hVvKpta8nlPWDACV+8NtgRWVVe4l6upRdEIEfHcKWrgVtwYCrbznQ6TKVz633bQtq8qPQhzbDeKMRAbiW7EOsQ9Q2zth54SAznDrNF7Di5YVl4nGXEGKaHAr757d+pnqXgUksoYfCLcEQebigQvOAgdy1tSs=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 36A7F4BA543C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A08C1FD00F86FBE
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTFSkwhLStTr06uHFjOFhENB0kCv4GTpmdKnZynryBKuuT8CT11bxQyG0G2oHXLDstyjXPC/xceketbkCnB+rOz1LreJBl1RI4QMHtVMN7shwv2R0oJkP6xIw9tQBR/SMV46/E3hbXgaWRiCPDLP1Ymbz+PAcUOsJ9+bANEir5g6P0vMhLj0sHVCfAf2Lh28ypO5o8wWj4ooSqqZiTmiuhbe+fB0rCO7j48vg2/p9/0bNcHgawzyPBEqP5FaO+qtHog1iW9wNCQne/1bujwsz7DnwSUIa8I69YOrok5fwnaafmUfuqOYSrZOaCFQoL6tYVWqcqIllgIvATmsMKE5O2BbQTFyeGIfjOOgGcv65T8uoXAN8azUPFuj4yJoQLIyM1l/czpSSaAnv2uWg08U+FhpeWSM255rfbuivu3XIuxmUVxBNkhNmYuCSJZax8YTzG0YC/97guCORxqDpRXdfmxMV5rJefL29blWJOp4cjWv1n11pUuMZUo3AKADAZgxdAXer2Ptwn11uCGhTnCKDdi4c47bMRUQfMa1kEiE0X1O04ddAHPxHXumnW+OWL3RG0WDWa8+02e+TteG+3GAz8vretrZZ1+SlIK0SaPJTR5cHibDdAEYuTmzxf6MO3NHb9Bv9oct+RXlWuWOxZ4NM96aoLeDhXZ0qm3TBkQemjWBzw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A08C1FD00F86FBE; Thu, 28 May 2026 13:33:36 +0100
Message-ID: <54c93ea8-3e7a-4045-b1d0-2671c8ebef2f@dronecode.org.uk>
Date: Thu, 28 May 2026 13:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: cpuid: add AArch64 build stubs
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>,
 Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Newsgroups: gmane.os.cygwin.patches
References: <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>
Message-ID: <20260528123334.7f5ZcxwArIxGVJZq4rPBjYRvW7F1pyHyWdU4kwsST0o@z>

On 07/05/2026 11:45, Chandru Kumaresan wrote:
> Hi Corinna,
> 
> This patch adds ARM64 support for CPU information and cache detection used by /proc/cpuinfo and sysconf cache queries.
> Thanks & regards,
> K Chandru
> In-lined patch:
> 
> ---
>   winsup/cygwin/fhandler/proc.cc       | 242 +++++++++++++++++++++++++++
>   winsup/cygwin/local_includes/cpuid.h |  21 ++-
>   winsup/cygwin/sysconf.cc             | 148 ++++++++++++++++
>   3 files changed, 408 insertions(+), 3 deletions(-)

Thanks.

I don't have any substantive comments (apart from "oh, you're supposed 
to grovel over a registry key to get the cpu information, nice :(").

Brian,

I think you're much more familiar with this area of the code than me. 
Please chime in if you have any comments!


