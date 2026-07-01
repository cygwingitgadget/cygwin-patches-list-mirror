Return-Path: <SRS0=gQMU=E3=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.48])
	by sourceware.org (Postfix) with ESMTP id 6A37E4BA2E08
	for <cygwin-patches@cygwin.com>; Wed,  1 Jul 2026 23:14:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6A37E4BA2E08
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6A37E4BA2E08
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.48
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782947650; cv=none;
	b=gsjUbZ/FB+LPs/pVpYh9WeBzH14pMse1b+0pkBSRqA3Ov3Ynt5gMPOTmwx65yAN6+i3WlTouS77Hywkt5urvWJ/TlxSz43cm4YutlNGk+LENUsG96Mfv85CzMansRZ6GVgcCUfRKeN6zoL8qUioIaZB74/SqlS6w0P3D/oYZGio=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782947650; c=relaxed/simple;
	bh=NXA1mHzluM0ByGtvV4tyPDbXNMbtZSJQzWj9z6+6Y7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=iN6UHGT33nOhFf8nNsvuNa2NZ1rg6qNDpIkygr/LLKjdLfuD1/YlwkXS3J2g6Hkr8ATnQ23iFJ610KeUitC1aqMnZO+KUYdf8nab3ug4AFLixk4KCyOt20DAZaa+CiNSy3mgkZUGotS09qJjhzf/Mk/uEnutDTV/YB41AYk1Dbo=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6A37E4BA2E08
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A025278041CCD3B
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEmFMdoirVp6cczSNoVVRgbmnPhLriaVxk9IdnH0L49qYdSp1cC+PRyofsMRDl9n/3bNG7rdevemUGpeIaLizU8ksZFdCwpLjtQ6fkHNXrYNwC4b31QW2EQyGy03tsSMjCsPet3hAT7pTOdVB3wmltF2DtU+6uAE6kTvMn5gWgKtyhfnFIe/G1rjhaRkq8UUmsq31zL05NpPnttmNzThGVv6mvEf0MoM8QMjPbBa+CGsQysnmAD/7/6gqVTZwhDzfu6IGqXY52TlUSiSzSyBCq8EdXyFJU7ivrQ1cvajr89UxdeE/7laf8XQYBPcmtazvhqJrC9dMbzcl8JXWZrZSQrIati+6cOXQ9gMAK3SPmljd3rj/hvSBfyGZ7tUvxs74Mt5E3ik1TPdBBmZzWkQzy0iVeJ00MIvPdjfuVBpV1v7XOg3SlmvXoo7n//ZzN4vMuaMzq+gyPreR0N6C7rTW1lmI8WDb6zZ0OEqn/4HGk1Rjw01eDKktrOvHQptob07Dtj2rGvGlGjEBFoPZExiP3n8XT45M9i7/XgvcsZMr1WzVndKjRcX8uBIjjhgMqCr0MBuI3JEtDfz6MTtgwO9v6hpXsTKTmI4Ts64sKQRPvQL//k7IobhdN0T3yGH/ZbPdaM4OhRFoQdJwcRJJQDgcMEp22iiAPS59oIGqo8/5jjpg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A025278041CCD3B; Thu, 2 Jul 2026 00:14:03 +0100
Message-ID: <054a3964-a4db-4add-9531-4b899e356f4b@dronecode.org.uk>
Date: Thu, 2 Jul 2026 00:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: exceptions: Fix AArch64 non-incyg signal handling
To: =?UTF-8?Q?M=C3=A1te_Dimand?= <mate.dimand@arm.com>
References: <d8339a03-a0d3-4b0c-bb10-f706fcc6da49@arm.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <d8339a03-a0d3-4b0c-bb10-f706fcc6da49@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/06/2026 09:02, Máte Dimand wrote:
> This patch fixes crashes that occur when a signal interrupts sigfe or
> any non-cygwin function that does not preserve the LR register in its

Right. So I think I understand how this problem manifests when 
interrupting a leaf function, but I wonder if you could go into a bit 
more detail about how it occurs inside sigfe?

> prologue/epilogue. This crash was discovered through the "run-heredoc"
> testcase in bash's testsuite, which caused bash to call "read"
> frequently, leading to a high chance of a signal interrupting sigfe.
> 
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

Hmm... so, this looks like a reasonable implementation of the change 
described to address the problem identified, but...

One concern I have is that this adds a single CONTEXT.

I'm not entirely sure about the situations in which nested signal 
interrupts can occur. Is that something you considered? Is there reason 
to believe that can't happen in these circumstances?

I wonder if there's a possible implementation where we maintain a stack 
of (lr, pc) tuples, and then exit by rotating those onto the top of the 
stack frame and popping them both?

(It might also be worthwhile looking at the aarch64 implementation of 
RtlRestoreContext - since it must know how to restore all registers 
without clobbering any of them - which is exactly what we want to do in 
sigdelayed?)

> 
> Signed-off-by: Máté Dimand <mate.dimand@arm.com>
> ---
>   winsup/cygwin/exceptions.cc           | 87 ++++++++++++++++++++++++++-
>   winsup/cygwin/local_includes/cygtls.h | 13 ++++
>   2 files changed, 98 insertions(+), 2 deletions(-)
> 


