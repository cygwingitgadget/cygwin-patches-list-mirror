Return-Path: <SRS0=3baR=B5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id BA4B84BA901A
	for <cygwin-patches@cygwin.com>; Sun, 29 Mar 2026 00:53:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BA4B84BA901A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BA4B84BA901A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774745631; cv=none;
	b=knGfCMP9CQPtv5F9SjnEqIie5HHciZiqAZa3nX5bhOTnGYvnuYPZhuq1EH88MPKPSsa6I3qP89DutC/HlcbZbzJXdKT/2GPEqEgfyon3Js51vVGybjuor3yaplftoxKNL9McFA5DiOrSbkH4O+lAsHuvc6ZplrJbKtL4ifNtZIQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774745631; c=relaxed/simple;
	bh=lZX/HJYvxsO3RtvQ6qO5MVIZHLPQ9KBcHri7CG/H5uE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YcW5vzefi1wtONqe016jqwTG6HMn/jGHbSFM7QzLeWM1Cuxd0alXh/9jR2Uo0rjvMbGCC8vtJ0nF6fsK7FGmA5RMQMNK6baM5KV83chxRk2FBlfHnaAEIof8Q2lAlSkCZYnk/jwNJe9825kuW8cCRRLZNxGxz+7JTbvsGQLCoSE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA4B84BA901A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PV1BW6dW
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260329005348673.CIXU.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 29 Mar 2026 09:53:48 +0900
Date: Sun, 29 Mar 2026 09:53:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Status of pty and console pathces
Message-Id: <20260329095346.aece4ca9b5b9144dd87b45b8@nifty.ne.jp>
In-Reply-To: <20260325224343.5d92b9ee72ec70e0a09b133a@nifty.ne.jp>
References: <20260325224343.5d92b9ee72ec70e0a09b133a@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774745628;
 bh=o5PFhgn4qPAzH5ya3MIJeRz7IAUKxPPvF+SmaBcE3yY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=PV1BW6dWWKISAfG4XozZkjqg1sMEU1i1oBvRrWXPuavO6RPojwjHAAAZkPZDfF49HwSc4LMr
 8wSADpYZ6ghB3LXmuDCZDq90b5YD6+7Pi2biFxfxrgxcAD1B6xcw5OxnfiUJ5mzru6teMunt/7
 UFY3Tbf3YLlry55yirtWSV0n5LvhcLTz3qb6KhrZS3zKhp+g09dnjVRD3Qx0/4r6/f/N889kWf
 jpoO4YlCYf2YwjmLkGlZxc5BM81lS9fSLPuMA7WFJt5kp6nq/t401Z4rvWNi64NP/3dknEJg5S
 2otwJ1DIGMOA9NckU2dROnq06KXBGvMFIwNesRGod6qGnShQ==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

[New feature]
===== OpenConsole [v6] ====
Cygwin: console: Fix master thread for OpenConsole.exe
Cygwin: pty: Handle CSIc in pcon_start phase (*)
Cygwin: pty: Use OpenConsole.exe if available (*)
===========================

[Bug fixes]
Cygwin: pty: Make pcon_start handling more multi thread durable
Cygwin: pty: Fix write data handling in pcon_start phase

Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB  [v2] (*)
Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB [v2]

(*) means the patch reviewed once and revised.


On Wed, 25 Mar 2026 22:43:43 +0900
Takashi Yano wrote:
> I currently am proposing the following patches that is waiting for review.
> 
> Many of bugs are uncovered by Johannes's reproducer:
> https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
> I really appreciate for providing such a reproducer.
> 
> 
> [New feature]
> ===== OpenConsole (v6) ====
> Cygwin: console: Fix master thread for OpenConsole.exe
> Cygwin: pty: Handle CSIc in pcon_start phase (*)
> Cygwin: pty: Use OpenConsole.exe if available (*)
> ===========================
> 
> 
> [Bug fixes]
> Cygwin: pty: Make pcon_start handling more multi thread durable
> Cygwin: pty: Fix write data handling in pcon_start phase
> 
> Cygwin: pty: Clear discard_input flag on master write()
> Cygwin: console: Release pipe_sw_mutex in pcon_hand_over_proc()
> 
> ====== out-of-order patch (v7) ====
> Cygwin: pty: Drop nat_fg() check from to_be_read_from_nat_pipe()
> Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
> Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
> Cygwin: pty: Apply line_edit() for transferred input to to_cyg
> Cygwin: console: Use input_mutex in the parent PTY in master thread
> Cygwin: pty: Add workaround for handling of backspace when pcon enabled (*)
> Cygwin: console: Fix master thread
> ===================================
> 
> Cygwin: pty: Omit CSI?1004h/l from pseudo console output
> Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist
> 
> Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB (*)
> Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB
> 
> 
> (*) means the patch reviewed once and revised.
> 
> -- 
> Takashi Yano <takashi.yano@nifty.ne.jp>


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
