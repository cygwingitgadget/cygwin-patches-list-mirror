Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 55C9C3858D34; Wed, 27 Nov 2024 17:00:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 55C9C3858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732726817;
	bh=dzxwnQIPbRU8d+S2xRDaYnXYEzz93U9flUty/07b/Fo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kD4+slVsnvUuzqTr95HsN6bZWqc3YrZAFOfACv+ya1uoCedzj2+P4NCNf0wuBF6tk
	 DhzfFNTqlAlOYuS4SlgBrxd32krAc3gfwqUhlrncipSjJkqZEHGcKBfvtbPURJtb3w
	 64CfVOvo9AHdz3jpAHwrOsglQf3YLHU4yUKeUg44=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4F005A80E4D; Wed, 27 Nov 2024 18:00:15 +0100 (CET)
Date: Wed, 27 Nov 2024 18:00:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 6/7] Cygwin: cygtls: Prompt system to switch tasks
 explicitly in lock()
Message-ID: <Z0dQH6Ur71VzX_7q@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
 <20241126085521.49604-7-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126085521.49604-7-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 26 17:55, Takashi Yano wrote:
> This patch calls Sleep() in lock() in order to increase the chance
> of being unlocked in other threads. The lock(), unlock() and locked()
> are moved from sigfe.s to cygtls.h so that allows inline expansion.

When doing the locking in C++, we should really make stacklock volatile.
That affects especially the unlock and locked methods, where you'll
never know how gcc optimizes away.

spinning should be volatile as well, but it's up to you if you already
add that, or if we only do this when we add the SIGKILL patches.


Thanks,
Corinna
