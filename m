Return-Path: <SRS0=uTC2=ID=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.123])
	by sourceware.org (Postfix) with ESMTP id A92E04BA2E3D
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 18:47:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A92E04BA2E3D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A92E04BA2E3D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.123
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791917265; cv=none;
	b=cGaMSw5i4SMStV/9OxwTFnZRnl12Pyqa1IaQJfwWCy5sWDFZiR5JsGpg3gRqk/6K8gOdcl8nxtfnwScGkRf8o5yF2W02rBt3MX3N71yEb8fO7HHw1uQ+Lz1r4231hFfGL+8XxmDKoeXEtzkU/EyIjGe/2La3Uk/AC8V7UgTpipg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791917265; c=relaxed/simple;
	bh=WIEo8emvA4kjQPK8HTnLocfeWsxYZRjr85+ZT27RNac=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=P+/EqgNLWxBGJ1S3LmBadXUb5Rp/uEK/gNxRRi0iBukzt0G3NeHo6rcMx2WhNhIDFx45JUYtud4yBTDqDDY2RggSxlfDjE0P7vqj4IPn3dhXFPhP8HUosSq03QV2/jFmnCW1UMlEbuh+8eYbe2y7Ip1SIwNKpyo2VQNWm/Ony+A=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A92E04BA2E3D
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715EB80DB7B329
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFHc4z66bCuwrLdYx4qgSsgGxjpH8AU6Uv4rABcbpqBv+kPfah/ljP2xTt3if7DVfqr0rXUsGbD67c+OQp6RvWwHhh3jXXQeWleheo0YsixavHlSdyvGdYwHb8CWUAdMyPsJUzbnRRa1ZcpMo0GR2g6SNb2fhrzs9rSivCku1A8RyHg8RkPgZ4/smcT5uPRMdPjGTJRmvlrK/q4qRU+9ifaVHb60XQeaHImmMDxKKcccB5XbBponQoG/ZaURXLSucUaQwkNq+6NifR6+IKQPCB2eV+cw9OVoo+yN7lr/VjHpdXqLTvAhmBMA2kwkT34NrZPGP0z6GSWYbthLc2DZ384q4wvc7ZtNaf2TZNh9/AsF7NzjgsgOa08yE7Ep0/qhYKhFhRJxCSijWuv2J90tuugUJFbssEHOEoxlnoyi/EjZiZq9/TvuFK0uyjsaRK8AO7lAhIHz4EIa9L3PVAjioVix0DIIiZ7QMwv7WIPK1wLHJutoGVZI2yiR9SkopgjzEPG/q7EWaR9lEwd0scSmeWRLJNCqmBb6MEs5Gx1bspUZrPYDtMZnzEXsci6qdsQGjYDZ2a/0ukVyMDrSKWfyqIbdxnTstvLgcTwBhg4ntBMFdmzXbcYmY4LY2DqdNaH/g03vdMQj3Kb98sAFXdkChtgcAn9VtNS8jhi6cvHUNj11w
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715EB80DB7B329; Tue, 13 Oct 2026 19:47:44 +0100
Message-ID: <40c7ebb4-ff69-45d1-9106-b62457477e04@dronecode.org.uk>
Date: Tue, 13 Oct 2026 19:47:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: signal: preserve runtime nesting across user
 handlers
References: <pull.12.cygwin.1791398786755.gitgitgadget@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <pull.12.cygwin.1791398786755.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/10/2026 19:46, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> CMake/libuv `posix_spawn` callers can hang waiting for `SIGCHLD` after
> nested signal delivery. Restoring `_cygtls::incyg` to `1` loses the
> concrete nesting level; subsequent balancing can leave it at zero,
> disabling the controlled signal-wakeup path.
> 
> Preserve the incoming count, including zero, to keep runtime nesting
> balanced. The public-API regression targets lost wakeups after nested
> delivery, including within `pthread_once`.
> 
> This was suggested by Takashi Yano on May 28th, 2025 in
> https://inbox.sourceware.org/cygwin-patches/20250528125311.2589-1-takashi.yano@nifty.ne.jp/,
> part of which was applied as 8201c57dd1 (Cygwin: signal: Revert
> _cygtls::inside_kernel() change, 2025-05-28). The remaining part is what
> is applied here, together with a regression test that exercises the code
> path that is fixed by it.

It seems like restoring the level was part of v1 of the patch, but 
dropped in v2, so maybe he has some context for this I'm missing.

But thank you so much for including a test!

> Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Fixes: b7097ab39ed0 ("Cygwin: signal: Revive toggling incyg flag in call_signal_handler()")
> Assisted-by: GPT-6.1
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>      Cygwin: signal: preserve runtime nesting across user handlers
>      
>      This patch addresses the hangs experienced in
>      https://github.com/msys2/msys2-runtime/pull/375#issuecomment-5967746825.
