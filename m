Return-Path: <SRS0=X8J8=IH=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id E26024BA2E14
	for <cygwin-patches@cygwin.com>; Sat, 17 Oct 2026 13:35:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E26024BA2E14
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E26024BA2E14
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792244130; cv=none;
	b=N7KNEJCE8w6d417p7wHA7LyqpXkME7Ov64+muERxNnQvLkodbvLA6QNLYABlj6dkiyOf5oWFhsLp7x6YZhdpezbj4UIcSuF13TbKMFAkTDL0wzHN+W6zbX+A2WSEvinVV5mSSm20K2+Lv23/JdODyDF3AER/FDLmpxHOqtBdOrU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792244130; c=relaxed/simple;
	bh=LPQqO2DBY/7BgjVtUrmauPNhE2g3MgFDB4bApWdx9Vo=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=Yu1XFDRaC/Kw7xqI07rkU2mjTBetDBJAeBXsja9PctiURPeQqfCutNTr/h0XmNKiLomzeUTCM2EBgEnp35K6A64dgbKSRYus7Ivcvdszghlvbpf1ekIWcz4LedZjW4xn/tKRNOPO5ob55KTEoCHK6bQm1YF1Orx/RGZZ0YYTorg=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E26024BA2E14
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6A715CD60E8D2D50
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEnd4totH827zSfKrt1hB3NuDu+VfsQ/dZmuRGDtxuMW8hBQkYMMeo5vV1CgpI7Wf4S+NUSy9YBOvxEtWjkEHZyPHpQ8uCj9PWz8zLbRs1q9YxppGf5uAe/9hLmJHK3AGjWFrnaNh3JwyWJvR6/QU9b6htOWy2InznXd+cIIvc1d/z3xP5Wr7u9qE1WMOWX9jolxOCY5OL0UDaVDhB+gDmWkvhhtvvKKxueVILQI9r0GC39NWazgDHuMkSaWdincR7k7pxCklJKl1pQUq0KLoTBE+qI4sYzHt9y0BEVZHQ/of8JVwJZNmb8m+avq2dbpd7MKbgmewbTYwhXNqykNOnnFb19PeDzBO38DBJZba/Y+ba8kUfg5iKPFlXB8r+byKiRAIqs94s60P3ONo6YPJvirdZj1p8agSJrx0cGMi9ysmbjZ1Aq62ahKQ/esJzU/NptHIp0Yba6i4nbcCqX1wFx3LyDyDbEBuRPkip/MgZbWd71EOv3RXJDjVryMNvj2Ym4TMRVyJHjQ4xYeZbD6ZgCUXIVS80TI3HbwJCkihjYo3/7ksqCljGRkYPXRIcy4ONE6XKg/1iemPsOz+MVqziyRJxOerLsfdA4Wih2a9TOWiPcg4o6zQV6Ha46WSAUPCHNiLMaMeBcujEecuyhkNntk256juBYYSqMZb3uqmiHSA
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715CD60E8D2D50; Sat, 17 Oct 2026 14:35:28 +0100
Message-ID: <f2b1fddd-b867-4eb9-bc41-add80cce54f4@dronecode.org.uk>
Date: Sat, 17 Oct 2026 14:35:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
 <bd64e817-ffa8-4299-a3bc-6d1ff691ca9b@dronecode.org.uk>
 <aH5CvWENvjsmKbjJ@calimero.vinschen.de>
 <aH5EsVT1Hhe_7yHV@calimero.vinschen.de>
 <GV4PR83MB09410EFD509ABD23BDA49B18925DA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Radek Barton <radek.barton@microsoft.com>,
 Evgeny Karpov <evgeny@kmaps.co>
In-Reply-To: <GV4PR83MB09410EFD509ABD23BDA49B18925DA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/07/2025 16:53, Radek Barton via Cygwin-patches wrote:
> Hello.

Sorry to re-open this long-dormant discussion, but since we've actually 
reached the point where we might soon be able to start distributing 
binaries derived from this code, I think clarification is necessary.

> JFYI, my original thought was that the Signed-off-by header is serving for some sort of automation that will let maintainers create commit with that person as a committer. Other than that, I am not aware of the cases where it could be handy to have different person being a committer and different person being the one who is granting the authorship rights.

OK, that's fine.  It's on us to explain what we expect it to mean, and 
we haven't done that.

What we do need from both you, and Evgeny Karpov, is clear statement that:

1. To the extent that it is protectable, this (and all your other) patch 
submissions for Cygwin are licenced under the 2-clause BSD license.

2. If this material was produced under a "work-for-hire" contract, your 
employer has authorized that licencing.


Once again, I apologize for my extremely delayed response. I hope it is 
straightforward for you to provide those assurances.


