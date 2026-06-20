Return-Path: <SRS0=JR7i=EQ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.159])
	by sourceware.org (Postfix) with ESMTP id 35B104B99F5A
	for <cygwin-patches@cygwin.com>; Sat, 20 Jun 2026 13:40:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 35B104B99F5A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 35B104B99F5A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.159
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781962856; cv=none;
	b=uKg+Bd5XwJjQIZXHMXwUbmqBzWLLGSxDPu8nTRVEg9rNcUuz3m2jOnVsH4MnyteBOvKTMtqZr/dDm6C0CHhMOYSxxVgQG4kOntKUnf7Y4vdjVGWLRmR+HptIsW5ZxNKWKDd7hPoSaS2QJumlizBcRYxlovV+xxZIwBC1XtfaW9g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781962856; c=relaxed/simple;
	bh=M0sgFf5uhXGE/q1cbYtwILLuKodWaRGicKsRBQxxlIQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To; b=R+z5i7MYkmMGx5PJoEBWOTxCU1wnaHEtjAFhk2qUDhvT3c8OvnRH2zEoM2TPs4VtqdsmopuEhYzGa+9iMFO66Wdj8Hc1i+P+ZwoIVZ7vnmpBS9AVru3bfdh4yMPGgmnjYOjnMkMCjj11wq7t9y0cV2T0hEeVce786IkI4CE3Uqk=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 35B104B99F5A
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69FAABE703AE61A6
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTFl5WE/mUIP3WJiU2CrqgSwDvxpbtcVo0fVsVDOKarUaxSR0UBG51CmRDNMV2hTdXYCzg4f0A+pyBZhKFeRmk9gK7JTFR1Ldbpe/PBcfgayRXTZ3DZZosYZ3WLexskVdVmoSsyOQvPa+BLccQK0mMmghxZdRSiRMDoL/dt8J9VVra8fFTEU5cux9ND3Rjjf33xWBdbkc56WZqdyp7ajG/PBHd0Zb9v/ae3w9IwjQWm/gnVv+VI4mz6GhOLy99SIi6XwCxLGsxdt8kmmdq1rQxqyzCbkZTTy7ooAdsOQZP9dxhb4tdVvRrVAAAJ61Zw27Ib/yrjWHOAdRsf4HDnrn5fOjaei4kYqPn04lEvpmRL6Xb/Aumlu5IxOJWB0AoyM08JaMZWTgnd+5zlseSlq1mGGwxlLKvj3FV7OsZOb3BCIyJSefyteUJ9Ag8DAmGcuNd5i5NRPtjKnBD4rTqVCDo0hMYV8B3+Hjc8KrdIxoaJnYogiu9plnqluKOi+iTfY5mDAocZ5gFSz43eXvDL1zPDkxi+N+FcJbda1nUef0LXkW1VviWbkA1O64j6MGY9BkmjIw7WEyUACuTyhznfWdGUAi6KxDwZD1OlIjAbCjw1NqsSD/DeuPRNqCyE4bgF/3il05SpDUkmcxsmyCmemNeRvxiE7/eaH4nGhcPvdj9ccNw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69FAABE703AE61A6; Sat, 20 Jun 2026 14:40:53 +0100
Message-ID: <bfc95c83-ecf9-44fa-8d5f-0b827feba26f@dronecode.org.uk>
Date: Sat, 20 Jun 2026 14:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: exceptions: Fix AArch64 non-incyg signal handling
To: =?UTF-8?Q?M=C3=A1te_Dimand?= <mate.dimand@arm.com>
Cc: cygwin-patches@cygwin.com
References: <d8339a03-a0d3-4b0c-bb10-f706fcc6da49@arm.com>
 <f09d13dd-49dc-440b-a818-819941010657@dronecode.org.uk>
 <b0cc315f-fd63-417c-9a2c-e7ea871847fd@arm.com>
Content-Language: en-GB
In-Reply-To: <b0cc315f-fd63-417c-9a2c-e7ea871847fd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 18/06/2026 15:05, Máte Dimand wrote:
> Thank you for the response!
> 
> On 6/17/2026 1:07 PM, Jon Turney wrote:
>> It seems like it should be possible to construct a relatively simple 
>> test to demonstrate this.  Could you suggest what that test might look 
>> like? 
> 
> I have attached the source code for a reproducer. It reproduces the 
> issue by forking the process and having the child process signal the 
> parent process while the parent process is in a leaf function (which 
> doesn't preserve the link register). The expected behavior is both begin 
> and end getting printed successfully and the process ending gracefully. 
> However, without the patch, only begin gets printed, the parent process 
> crashes inside the test function, and the child process will fail to 
> send SIGUSR1 to the dead parent process.

Ah, got it. So we don't even need to be interrupting read() for it to 
occur.  Even simpler.

I'll put this to one side to hopefully add to our testing when I can.

> Unfortunately, to my knowledge, the current upstream version of AArch64 
> Cygwin GCC is not yet suitable for compiling it.

I have built myself a cross-compiler with Evgeny Karpov's patch set from 
a few months ago. I don't know if there's something more recent I should 
be using.

But that's academic since I don't have any hardware to run it on :).

>> Hmmm... it seems like this is functionally incremental to a patch 
>> which hasn't been applied yet, but I can't work out which one. 
> Maybe you were thinking of this patch: https://cygwin.com/pipermail/ 
> cygwin-patches/2026q1/014641.html but as far as I can tell it has 
> already been applied, for example this is where the X30/LR register gets 
> set in sigdelayed: https://cygwin.com/cgit/newlib-cygwin/tree/winsup/ 
> cygwin/scripts/gendef#n558.

Ah, right. I'd got mixed up.

Anyhow, I'll take a more detailed look at the patch, but I need to 
refresh my memory of how all this stuff works first, which might take a 
little while.

>> I spent about an hour trying to salvage this, without success. Could I 
>> possibly trouble you to resend it as an attachment?
> I'm sorry for giving you trouble with the formatting of my patch yet 
> again, I have attached it in this message.

No problem.

Sending it as an attachment worked fine. Thanks.

