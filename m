Return-Path: <SRS0=WipY=EU=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 8DE7B4BA543C
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 08:04:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8DE7B4BA543C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8DE7B4BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782288258; cv=none;
	b=laTPnHTwoUsrEuB9a4BJgYuqvVoiHKUNzJb56J/eQrak9fuhjayMEQXlz3a8QAfPIHHH9l3GkS+4c7B3q77jYssTnsbNwplvAz6DQPd33SZKRP8klK9TlFdgl5kaBNk20Oq/4zd0zTj6rHC7UMt/cMo4PlOUkKLA2NevTCsG9xg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782288258; c=relaxed/simple;
	bh=3ye5q3wDb+10N68eShM3hp+/el+OXsUcOWIXQNOC37U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=pWO85uUjjouf+xxTGZ9rtoo/F8dFu3sWgKc/t8aRDM2nbdDpwoccURWXI7zeKuO2Z0Q1YRrVtVWAupv5ZfsBeB+8y6cNDoxp9lKOSWn3PXyFW6WA/XI7r4tCl0pCLgtp1vqyMUUek0CR3A9wUTdw5MwPfpIJ0xqFBTfsZtwy4oM=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8DE7B4BA543C
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65O8JJPH042799
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 01:19:19 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdspR5WT; Wed Jun 24 01:19:15 2026
Message-ID: <08ed3ccc-2594-49c9-9393-f7527f5bf16a@maxrnd.com>
Date: Wed, 24 Jun 2026 01:04:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little
To: cygwin-patches@cygwin.com
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
 <20260610163533.10187-3-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260610163533.10187-3-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

This patch LGTM.  OK to push.

..mark

On 6/10/2026 9:35 AM, Takashi Yano wrote:
> If you run "stty noflsh; cat" in "bash", and stop "cat" by Ctrl-C,
> a stray ^C is passed to "bash". The current code calls tcflush() if
> NOFLSH is not set, however, tcflush() is not called when NOFLSH is
> set. So, Ctrl-C remains in console input buffer. This should be
> discarded even in NOFLSH mode. This patch introduces a helper
> function discard_key_events() and call it to erase Ctrl-C in the
> console input buffer.
> 
> Note that even with this patch, NOFLSH is not fully functional in
> console because the readahead buffer is unique to process, so it
> cannot be inherited to other processes. However, it should work
> intra process.
> 
> Fixes: 118e51be1d04 ("(tty_min::kill_pgrp): Handle tty flush when signal detected.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/console.cc       | 20 +++++++++++++++++---
>   winsup/cygwin/fhandler/termios.cc       | 10 +++++++---
>   winsup/cygwin/local_includes/fhandler.h |  2 ++
>   3 files changed, 26 insertions(+), 6 deletions(-)
[...]
