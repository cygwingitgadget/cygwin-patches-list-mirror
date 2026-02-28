Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id E47944BA23C2
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 08:50:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E47944BA23C2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E47944BA23C2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772268606; cv=none;
	b=H7oeDKWGl0tO+fV7Fl6oBAjOTjy5pOhy7QL5FkhDj0n3J5uSWANzWiGTPTxGXi4ctIpQpZaPojV6pnTM2n3Mj8mf/hIzWiY+8HURZx5LeU1NkevTJTyBw2+bMbX2wWRTs1sX1U9ciG44qYXjOVNbtYfYH4p6Tn39zbebUXex0A8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772268606; c=relaxed/simple;
	bh=5s2pCKk76HuCH8oyreKrOviGHIM1a68xJ27lRW2mO9k=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=S2qasgyN15Cm0Y0aOD1x6ucGCqdeK4Xb5e+pj94B9UdexAPJtqe3axLf1pMMK1S5rqPtSB9Y+wRkMnfXDT3g5BYuajNzQtuAuXblxGE4E3Qr6bQE0THuYZ7JJxBBCJVhThQSspR+bKEgOhJu+tYwJxT/639drUxBsWfnjp65fGE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E47944BA23C2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GBFUq5Zf
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260228085003935.IPRX.34837.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 17:50:03 +0900
Date: Sat, 28 Feb 2026 17:50:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Discard remnants of win32-input-mode
Message-Id: <20260228175001.5502684844ce60f1b79165b6@nifty.ne.jp>
In-Reply-To: <57c90d88-a1a0-b484-807c-e4e673dbf68c@gmx.de>
References: <20260223080031.320-1-takashi.yano@nifty.ne.jp>
	<57c90d88-a1a0-b484-807c-e4e673dbf68c@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772268604;
 bh=gt3jHCs2ynTcyxADVFxlQTeuHKf2koY/DoxLGdd7/Oo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=GBFUq5ZffluRrmLXEnLl/fHlCYTlnvFAZDsOBlIlxKgC4QKKjP2aQJpqEseVShg/2nAScuoH
 kdfxJHePj83Tkm62wBccCc5ZPWEsG1p1dOUHXWaOeVg/RuGk6XpANqV18g/wNFY0oBgn3KKgDN
 FppLcZfkZ7Q2pXMHASEhlxfqyAE6L3BgD2hA5BUESPjTZnavFqeV75M6dgJzDeVSsNFgxqDs95
 2Nh7phKoHQEL7k6c74HjF7WRVNBHrbrEdUcx2iXoC+hiU7aVE1mFMmaipGMCK9PQCkGwaT0eLG
 XbBrBbUCEvXfkjAmIhCeQQYO+lStIle5qDe4BilnbBg2TfMA==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for the review!

On Fri, 27 Feb 2026 17:02:09 +0100 (CET)
Johannes Schindelin wrote:
> On Mon, 23 Feb 2026, Takashi Yano wrote:
> 
> > In Windoes 11, some remnants sequences of win32-input-mode used by
> > pseudo console occasionally sent to shell which start non-cygwin
> > apps. With this patch, the remnants sequneces just after closing
> > pseudo console will be discarded.
> 
> Could you kindly advise how to reproduce this?

In legacy command prompt (not windows terminal),
1. Run script command.
2. Run `chcp.com 437` and `chcp.com 932` alternately.

Then sometimes the win32-input-mode sequence appears in the shell.

> I have been investigating a related pcon transition issue (character
> reordering during pseudo console oscillation, see
> https://github.com/cygwingitgadget/cygwin/pull/6, which I plan on
> contributing in a bit) and initially suspected the same root cause. After
> analyzing your patch, I believe these are genuinely different bugs, but I
> think the time-based heuristic is the wrong approach for this one.
> 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index b30cb0128..b90b2b609 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2504,6 +2504,16 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >        return len;
> >      }
> >  
> > +  /* Remnants of win32-input-mode sequence in pcon_activated mode */
> > +  bool is_remnants_to_nat =
> > +    GetTickCount64 () - get_ttyp ()->pcon_close_time < 32
> 
> As you noted in your follow-up, 32ms is not enough, and even ~200ms may
> not suffice on a loaded system. Any fixed number will be too short for
> some users under some conditions.
> 
> I believe the underlying problem is that the pseudo console's conhost
> sends `\x1b[?9001h` (win32-input-mode enable) through the output pipe, and
> `pty_master_fwd_thread()` forwards it to the terminal emulator without
> filtering. Once the terminal enters win32-input-mode, it encodes
> keystrokes as `\x1b[Vk;Sc;Uc;Kd;Cs;Rk_` sequences. When the pcon closes,
> there is a propagation delay before the mode-disable (`\x1b[?9001l`)
> reaches the terminal, and keystrokes typed during that window arrive at
> `master::write()` in the wrong encoding.
> 
> Beyond the timeout fragility, the current approach also discards
> keystrokes rather than decoding them (the win32-input-mode format contains
> all the information needed to reconstruct the original keystroke), and the
> pattern match can false-positive on legitimate CSI sequences that happen
> to end with `_`.
> 
> I think the proper fix is to filter `\x1b[?9001h` (and the corresponding
> `\x1b[?9001l`) in `pty_master_fwd_thread()`, preventing the terminal from
> ever entering win32-input-mode. This is consistent with the existing
> architecture: that function already strips several categories of pcon
> output artifacts that should not leak to the terminal (window-title
> sequences containing "cygwin-console-helper.exe", `CSI > Pm m`, `OSC Ps ;
> ? BEL/ST`). Win32-input-mode enable falls in the same category.
> 
> The native app should not be affected because it talks to conhost via the
> Win32 console API (`ReadConsoleInput`), not via VT sequences.

I convinced.

Actually, I found another (more severe) problem with win32-input-mode.
If script command is executed in a console and run a non-cygwin app,
Ctrl-C terminates not only the non-cygwin app but also script command
without cleanung-up pseudo console.

I'll submit alternate patch which removes CSI?9001h/l.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
