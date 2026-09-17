Return-Path: <SRS0=KPEJ=HJ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.62])
	by sourceware.org (Postfix) with ESMTP id C519B4BA798F
	for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2026 18:27:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C519B4BA798F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C519B4BA798F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789669623; cv=none;
	b=ny6JtMwk9NtJSTgVavy35ncIwAr94PuS9+eeE01IU6B4CiPM4Y1d2pv/S3BKsSkVtI9M3+tBQ7RrCeI0X8IaX0bSDMrhkQZW1r9F/fWYCIBF0UX4PO7o2KKp5CyD5CJG7vQCk7uesvwP49kuc3BGCYB+5LCsZContnadWpr8HZk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789669623; c=relaxed/simple;
	bh=ZCkGNzkQa7MTTl++nSLVfXwOonql5W1WyzfB8n1kFhk=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=jpqG92r2MZyCnEuly/n7ghGfMl8VcIJScUFYjj6yVoyaUAlwS0zdCTcDuuXNxJlpJW2Cw84n6xOuCCCIAuBSTFw7abqF0HEne5myzdqMc6auVFvSCpRAAWR8MFG2Uztcv8qfz52XRy6n2tycyEfRHtoT1Qia0QZXdwSPSLp6oog=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C519B4BA798F
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A716138086B8DDF
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGMOgZipu4Ct+9klFhQDpyoPCaCaSFMGBnRfQX9DBa5iuSjqaK9LrLJ9ghWMxj6gGHUojAMT0GO4TTX2EEq6W0RHNZDiugfbw/zFD7QrKcTmFQ1RW7dzwfRJ52YqjKUrkTAnbfaMAMTP9HwonVFP7R9LQtAlRWkthEYEDfRS3uC6UPcJRD+gr3Pj7O2MbDbnghnDsfOntulxifAd2/GmOeaUnRlBd7Ynw1xXkKsvVWmbkfxZMKVLwfx0GKAur0qDPFOmcJWsD2MGJKYCtI4STE1+LrwCZSeywt4h+Z4aSPsyAnmI07wCZRko5SDN9d7pPgDtJsxhy5fznRNg44xHCa4q8m//q8/YcwZP/ZD4elV83dpVYSTbUeDqZsAw0asIr+wu9BEtb9m0ONwmizsjV4i0MNT56XEd9rYcVx96YabATgpAek9QVujhpWcF7ECZxYtqCGEdrsW7Z/UXV527oSxGa5atsuTogZiFpJ8r2bB3AtCk4GW1VGZAuA8rPOor344Fgx/gyE5OQ5hx+Q2T1o4zMJ1lykrl9FuuHyzA1a0UJge6npOttlr5/tzMAWedvuivwgFOZJL/DQnhO6TxzKNMtLbZH+gMCklckr8gSo8VS754aeCbtScXohKhi1nMCPrfxn9ZtDH1am4zXJgyQhNxYy0UvuPkfCUs/1bpSFHkQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.83.178) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A716138086B8DDF; Thu, 17 Sep 2026 19:27:01 +0100
Message-ID: <1ffe50e1-0e56-483c-ace1-c5ef2bbcb98e@dronecode.org.uk>
Date: Thu, 17 Sep 2026 19:27:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: autoload: fix ws2_32 chained init on AArch64
References: <PN0P287MB0295C357517BE127B601D99092F02@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <aqpYA_4qPMpjT7b_@arm.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Evgeny Karpov <evgeny@kmaps.co>
In-Reply-To: <aqpYA_4qPMpjT7b_@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 16/09/2026 09:49, Evgeny Karpov wrote:
> On Tue, 07 Jul 2026, Chandru Kumaresan wrote:
>> On AArch64, the autoload INIT_WRAPPER passes func_info* via x30 ("mov
>> x0, x30").  This works for the first init stage (std_dll_init), reached
>> by the trampoline's "blr".  It breaks for a chained second init, because
>> dll_chain reaches it via "br x1" without updating x30.
> 
> A more general question, could the autoload implementation be replaced by delay loaded DLLs?

In theory, yes.

(autoload.cc dates back into the previous millennium, when hand-rolling 
your own solution to this problem was the only option)

In practice, I'm not sure what the state of the 'dlltool -y' 
implementation for aarch64 is, and I think there'd be some work involved 
in mapping all the various ways of handling a missing function we have 
onto __delayLoadHelper2().

Patches to that end are certainly welcome. :)

