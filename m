Return-Path: <SRS0=e2Sx=HT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id C25354BA23FB
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 15:26:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C25354BA23FB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C25354BA23FB
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790522803; cv=none;
	b=BpIHuz9b0Xrg5cMgPH19HbWk222Oqa5cJ9xL2f6aBN3Bcb5DjyucfwBpS98uz5qLEcdVKTL0TVeaoKOxqlCMGJoiLaJ/9cfcAU9PE3uAfbE3uFptO1gHCYzfVNzOiyXT6lanQvfD7Dn4R27JUhQqYMRLMlXXoumCfWKYVzkMXHs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790522803; c=relaxed/simple;
	bh=uxLaQ1jVfZY5LGa+CNszks/IIWw+qHMpLlvxEBbLfIY=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=DVxZZaAdU+TSx2pkX3dn9YU4ZM0KO4y5komVXkW02Vxmv4jKhMe3dP/CdlIwQrc82V5/CVSUX6oo3H1Aas1y/4n6hCxjWq/rFGIiK0SgTe/F/fF2oo5yf06gsgfnQsRwBcuGYeDHnL38ao/baytGw4jZGyClpXkwq1Cwoh+iNdY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C25354BA23FB
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715CD60A6E2698
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTE9rn8A1dKNiJYQWq+hQVTKo/8K37z3af83wNegAt1jIVnYHOKp5ARJhAWh0fflSefGyvD56LN0Znd+U/jTWAFcRrKJH/jFZ1sFlQiqy1e5BjQhtPE8LTJQPNv9CgCJDk+Ftq31exiqLqeDu3/t87sIPfuK2a3vvqPsLswfFCBPnlFMKF8RBD5TXbzJrx5wykCr5GhqLYZhipPnsOVR7GvIR9qrKbl8dZy3Izt0DB9Cg+S6Vh80xF2ZsXpYGyzhxIT+pkXikr8Jv/4mkdf02c+OpNF+nEPftG6R75Lh/jIVHehEAJGhjKvAqqaSTPLsPbH11qyuRo4gXoPD4tZyYjxBatSnIU6ttgI7e4qRDb4mYxnqCZGzj8f7fWJGmgwBW1ZH6y4w+jWJyUQIx+r6r69lF+6R/wT4RaqqEN5Ed+bSJXi5jDzxk1ZHNi9M/xQyr3spieNallTSzUmXo5E0+keW2FhPxElSr1uDBjlF1l24JwVgkt6dSFMqQSL7kjqvU7Hglb0Ad840hwCt+N+HyiTQloYRcCkJt31U+2ZJYMma2RGfmb1vV5D529Kck95ZjytJaSRSIPM2y4iCD+7Zh7vllY5yh4BqVY5QpAUlX2Gc/UExXb+13zKMdo2QptWIAsFCOZ5HlEZ4dGLwXOLDJvC2rci2mz8jDYLrhxG0aBTx7w
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.83.178) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715CD60A6E2698; Sun, 27 Sep 2026 16:26:41 +0100
Message-ID: <8359eb58-e817-4601-a3a1-40de4a72b5dc@dronecode.org.uk>
Date: Sun, 27 Sep 2026 16:26:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: gendef: fix AArch64 _sigfe_maybe control flow
References: <MA0P287MB3082181CE402F12F043C3A0B9FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <6fd27001-6a1f-4d20-a621-e395b6b85762@dronecode.org.uk>
 <8ad1d40a-0842-47c4-bdb0-fa2278abcde1@dronecode.org.uk>
 <PN3P287MB13204A129D5E0E0B6AA29CFCF7842@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
In-Reply-To: <PN3P287MB13204A129D5E0E0B6AA29CFCF7842@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/09/2026 13:04, Aswin Kalies Ramkumar Mangayarkarasi wrote:
> Hi Jon,
> 
> This is a fix for the _sigfe_maybe stub you reviewed in
> https://cygwin.com/pipermail/cygwin-patches/2026q3/015305.html
> 
> You wrote:
> 
>>> Hmmm... while staring at this code, trying to refresh my memory
>>> of how this it all works... this seems wrong.
>>>
>>> Comparing this to the x86_64 version of sigfe_maybe, shouldn't
>>> the branch here be to forward to label 1? Otherwise this
>>> function effectively does nothing.
> 
> You are right, thank you for catching it.  The patch adds a
> .L_sigfe_entry label inside the AArch64 _sigfe at the position
> matching x86_64's label 1:, and branches to it with b.eq.
> 
> Fixing that turned up two more defects in the same stub.
> 
> The bypass path could not work either.  On x86_64 the generated
> wrapper pushes the address of the real function, so 'ret' pops it and
> jumps there.  AArch64 'ret' branches through x30, and the generated
> wrapper is
> 
>    sub sp, sp, 16
>    str x9, [sp, 0]     // x9 = &real_function
>    br  x9              // br, not bl: x30 still holds the original
>                        //   caller's return address
> 
> so 'ret' returned straight to that caller without calling the real
> function, leaving sp 16 bytes low on every call.  It is replaced with
> 'ldr x9, [sp], #16' and 'br x9', which is what _sigfe itself does on
> exit.
> 
> The magic value was also built with its halves reversed: movz #0xc763
> / movk #0x173f assembles 0x173fc763, not CYGTLS_INITIALIZED
> (0xc763173f).  The first defect masked this, since the comparison
> result was discarded.

Gosh! Good job someone took another look at it :)!

Thanks, and applied.

>>> (Of course, this isn't very important since sigfe_maybe is only
>>> used by cygwin_detach_dll())
> 
> Agreed, and that is why none of it was noticed.
> 
> Validation: the generated sigfe.s and the linked aarch64 cygwin1.dll
> were both checked to confirm the branch and the constant came out as
> intended.  At runtime on a Windows ARM64 host, a test program
> dlopen()/dlclose()d a Cygwin DLL 10000 times against the patched
> cygwin1.dll; all cycles completed without fault, and a marker byte
> written by the test DLL's destructor was counted 10000 times,
> confirming each dlclose really reached the detach path.
> 
> Two limitations: the loop was not run against a pre-fix build, so it
> has not been shown to fail on the original code; and it cannot tell
> which of the two _sigfe_maybe paths is taken, since a thread that
> wrongly took the bypass would still call cygwin_detach_dll and still
> return 0 from dlclose, losing only the signal-frame bookkeeping.
  As noted before, please consider submitting any small ad-hoc tests 
like this that you write either for the testsuite, or for the stc [1] repo.

[1] https://cygwin.com/cgit/cygwin-apps/stc/

