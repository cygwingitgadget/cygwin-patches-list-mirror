Return-Path: <SRS0=Czgb=EN=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.227])
	by sourceware.org (Postfix) with ESMTP id 01F2C4BB1C11
	for <cygwin-patches@cygwin.com>; Wed, 17 Jun 2026 11:07:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 01F2C4BB1C11
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 01F2C4BB1C11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.227
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781694469; cv=none;
	b=MfufnY9jdwk9c1jl2onbPnMKWnhmHsi/yaD+PouUzgSOZYJpGzYiOX11sFVXgsxvJHri8wTOESirdp/2GvyddiQPV6hIWMPgyzXVZCZ3R9ibSJloygXbDzBtrrcoZAjsVbdHoWh+NWri5jNud6itrM6QmifhpeROL9IQ+PdxhIQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781694469; c=relaxed/simple;
	bh=sEFnUKeTsXWRxKhJJp9ceXMesMfSqvGVTPeJ9ITvQZg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To; b=tBWSy9jE4JXxlrcxNxf80fEi9aGTC7InUsne6Dvd8yQDAb6MycrhJUOeDKfUxJbWQNmWxDN0g+FoJls0cdx3S0z4zHmX1b5Tn13OcCNV73FEv+vBnGBqEa2LwfDGTRVuPz1H9ePbNI8rZnGzT4JVUDeB5JI2cn60uBcj5ip6lBo=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 01F2C4BB1C11
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A02527902F28F29
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEDk3v2VtlieMkzMl135AFq59w1t2h0LKnDZiBhnlFv4chmMGr++8d6K6mhK2TNW4TwBLyoQonyy4fNhe/DIzV5PEc/3x9HMEAsPVdEnayBvZqFIyqZJUEk5kitgUWm1vqruZb0+aZP4ZhlrC89qyMXXX7tBl1z6zKUuMNNgYMvCyArqzoRgHUnHh4Uo1KhPkhbV5HWPUASQswvZ0mDevAykiWoXwss7iZNvz0hPsGK9AGE5nTogpkQ6Ep+1Vzx4YZl9bXXzxwDEFnKiXwvau9xN4FWeAweLycIl4RpP4S7//JsFgZjmbdpm95JckiLuhVX7pldibRrtVzv+70/R7vHVy/sq+4zkeEAbzDXfxpXUkFDhkIb76eExQHkVJ2T2u6qNEpCSD5xrNNZx4pTwie5luSpONmPPuG0zq56YmqTc9gmOCFz+QTaLFbnxWWABYyu5EaRyE39CLXh7n8xZR857lLCvMn1+kdCwAjh04TxEM4Gtz1aSX+K+aQBsBN+FpxVGUxnc7UK0COEQd7UxxstMTbUtIww1rwh10/G3PXolcEhkmavHTdgwQFuonqbxEfnDaqH9hO12xaPxdsv9lQwQtpXshppAQIvm/xYI4biLWkswiB7SDaFM2JCTGZo/hOFHOvZzcWzhg8TmRB0DQgTsKcNAdME6swhQeqf34YC/Q
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A02527902F28F29; Wed, 17 Jun 2026 12:07:44 +0100
Message-ID: <f09d13dd-49dc-440b-a818-819941010657@dronecode.org.uk>
Date: Wed, 17 Jun 2026 12:07:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: exceptions: Fix AArch64 non-incyg signal handling
To: =?UTF-8?Q?M=C3=A1te_Dimand?= <mate.dimand@arm.com>
Cc: cygwin-patches@cygwin.com
References: <d8339a03-a0d3-4b0c-bb10-f706fcc6da49@arm.com>
Content-Language: en-GB
In-Reply-To: <d8339a03-a0d3-4b0c-bb10-f706fcc6da49@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/06/2026 09:02, Máte Dimand wrote:
> This patch fixes crashes that occur when a signal interrupts sigfe or
> any non-cygwin function that does not preserve the LR register in its
> prologue/epilogue. This crash was discovered through the "run-heredoc"
> testcase in bash's testsuite, which caused bash to call "read"
> frequently, leading to a high chance of a signal interrupting sigfe.

Interesting.

It seems like it should be possible to construct a relatively simple 
test to demonstrate this.  Could you suggest what that test might look like?

> The "sigdelayed" function in gendef clobbers the LR register to return
> to the instruction where the thread was interrupted. Picking any other
> register for branching back would also clobber said register. Leaf
> functions are not guaranteed to be compiled with LR being preserved on
> the stack. The solution is to use RtlRestoreContext to restore all
> registers without needing to sacrifice any.
> 
> The patch includes a C++ version of sigdelayed, which calls
> RtlRestoreContext at the end. The non-incyg signal handling codepath
> will change the thread's IP register to this new function instead of
> the original sigdelayed function written in assembly. Cygwin functions
> interrupted by signals still use the original function.

Hmmm... it seems like this is functionally incremental to a patch which 
hasn't been applied yet, but I can't work out which one.

> Signed-off-by: Máté Dimand <mate.dimand@arm.com>

Thanks.

> | git am
> warning: Patch sent with format=flowed; space at the end of lines might be lost.
> Applying: Cygwin: exceptions: Fix AArch64 non-incyg signal handling
> error: corrupt patch at line 11
> Patch failed at 0001 Cygwin: exceptions: Fix AArch64 non-incyg signal handling

I spent about an hour trying to salvage this, without success. Could I 
possibly trouble you to resend it as an attachment?
