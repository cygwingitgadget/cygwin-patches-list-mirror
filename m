Return-Path: <SRS0=WipY=EU=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 9BF3E4BA2E04
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 08:05:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9BF3E4BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9BF3E4BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782288318; cv=none;
	b=Pyii5hB5b4NI1TCpGr1A1f4glgHyISVgbDlOXNdt/K8gCIixVh3SJLWHquiOWkPYvG76nO2e0mGLe1pKw5cianUEkRy97lse7wiISZ84gUSSZSH8vLoeAKgn5rWw3Uyym9Af8jS4I7/dBUkRJHnp4P10M3WedlJn2+xdpClaYfg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782288318; c=relaxed/simple;
	bh=wqPKyRpc2Tkg9frDb837ms9pXV1WtSTMqvmjTxu1X6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=gflH5e5pgFvm+P+Un9wI/DycKI8Uqu1VHc+/kkegwcBhvgbPUGz9r5V4hOz2b05eaKm62xWFAOjKGjicLAL9tg08nQf71JUdtSCNo3N9+j7cVO8sT5IIKLe1rlDzfqVL1aSL4IEyxhMqajS5+xUVQCd8zkGwvQt+FttQ0jnFwjI=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9BF3E4BA2E04
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65O8KJea042833
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 01:20:19 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdJgQ9g4; Wed Jun 24 01:20:17 2026
Message-ID: <bfbe7db3-dfb9-4a3e-a0bc-fe48c7235337@maxrnd.com>
Date: Wed, 24 Jun 2026 01:05:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Cygwin: console: Fix typeahead input for bash
To: cygwin-patches@cygwin.com
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
 <20260610163533.10187-4-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260610163533.10187-4-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

This patch LGTM.  OK to push.

..mark

On 6/10/2026 9:35 AM, Takashi Yano wrote:
> Currently, following misbehaviour occurs in bash.
>    1) Run "sleep 10".
>    2) Type "cmd<enter>ps<enter>" while "sleep is running".
>    3) After "sleep" ends, "ps" does not run in "cmd".
>    4) exit from "cmd". Then, "ps" is executed.
> This is because process_input_message() handles all the events in
> the console input buffer, and stores key input into readahead buffer.
> However, since the readahead buffer is unique to process, "cmd"
> cannot read it. Since "ps<enter>" is stored in bash's readahead
> buffer, it is executed by bash after "cmd" exits. With this patch,
> process_input_message() handles only the requested amount of events
> by read().
> 
> Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/console.cc       | 15 ++++++++++++---
>   winsup/cygwin/local_includes/fhandler.h |  2 +-
>   winsup/cygwin/select.cc                 |  2 +-
>   3 files changed, 14 insertions(+), 5 deletions(-)
[...]
