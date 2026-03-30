Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7B2424BA9001; Mon, 30 Mar 2026 08:39:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7B2424BA9001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774859970;
	bh=7mXHg3Ub6jefiQj8amWMCUuQvOtbrDvO25GI2uYZqxU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UGmp764OS6PeSndjgm0pzcskEN90QtFxORZDDMc6C+VzjT3hU+joJ+Ct0MynQj/R7
	 vnjs3/gDRD35OARJHJcdKfLAqjZS4WP7PlgJuugp5G8p96mNlTSk8OITXlPrb7HYl9
	 hekjDMAxdrPKWfSlgfVch3qZodnUus4RklONUOPA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9E116A80C43; Mon, 30 Mar 2026 10:39:28 +0200 (CEST)
Date: Mon, 30 Mar 2026 10:39:28 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: Status of pty and console pathces
Message-ID: <aco2wLRJMJO3_06T@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
References: <20260325224343.5d92b9ee72ec70e0a09b133a@nifty.ne.jp>
 <20260329095346.aece4ca9b5b9144dd87b45b8@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329095346.aece4ca9b5b9144dd87b45b8@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Johannes,

any chance you could review these patches as well?


Thanks,
Corinna


On Mar 29 09:53, Takashi Yano wrote:
> [New feature]
> ===== OpenConsole [v6] ====
> Cygwin: console: Fix master thread for OpenConsole.exe
> Cygwin: pty: Handle CSIc in pcon_start phase (*)
> Cygwin: pty: Use OpenConsole.exe if available (*)
> ===========================
> 
> [Bug fixes]
> Cygwin: pty: Make pcon_start handling more multi thread durable
> Cygwin: pty: Fix write data handling in pcon_start phase
> 
> Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB  [v2] (*)
> Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB [v2]
> 
> (*) means the patch reviewed once and revised.
> 
> 
> On Wed, 25 Mar 2026 22:43:43 +0900
> Takashi Yano wrote:
> > I currently am proposing the following patches that is waiting for review.
> > 
> > Many of bugs are uncovered by Johannes's reproducer:
> > https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
> > I really appreciate for providing such a reproducer.
> > 
> > 
> > [New feature]
> > ===== OpenConsole (v6) ====
> > Cygwin: console: Fix master thread for OpenConsole.exe
> > Cygwin: pty: Handle CSIc in pcon_start phase (*)
> > Cygwin: pty: Use OpenConsole.exe if available (*)
> > ===========================
> > 
> > 
> > [Bug fixes]
> > Cygwin: pty: Make pcon_start handling more multi thread durable
> > Cygwin: pty: Fix write data handling in pcon_start phase
> > 
> > Cygwin: pty: Clear discard_input flag on master write()
> > Cygwin: console: Release pipe_sw_mutex in pcon_hand_over_proc()
> > 
> > ====== out-of-order patch (v7) ====
> > Cygwin: pty: Drop nat_fg() check from to_be_read_from_nat_pipe()
> > Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
> > Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
> > Cygwin: pty: Apply line_edit() for transferred input to to_cyg
> > Cygwin: console: Use input_mutex in the parent PTY in master thread
> > Cygwin: pty: Add workaround for handling of backspace when pcon enabled (*)
> > Cygwin: console: Fix master thread
> > ===================================
> > 
> > Cygwin: pty: Omit CSI?1004h/l from pseudo console output
> > Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist
> > 
> > Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB (*)
> > Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB
> > 
> > 
> > (*) means the patch reviewed once and revised.
> > 
> > -- 
> > Takashi Yano <takashi.yano@nifty.ne.jp>
> 
> 
> -- 
> Takashi Yano <takashi.yano@nifty.ne.jp>
