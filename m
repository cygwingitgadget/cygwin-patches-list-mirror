Return-Path: <SRS0=LDpO=F4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id A83924BA9019
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 02:41:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A83924BA9019
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A83924BA9019
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785724862; cv=none;
	b=BptuvbGvTR8dSZSbhBN3jYjekkjJUSA7Y+OR4u2GVmG4MVOn0YL8UiUJrgP39TG+jkhdyDpsQRHsVFQo8+PS/38/11EEQ6SL7zF8pdwRnB/xDPUe9TyXATCBupBaYO/Hb0UAwF7EnkJGjqyDZ5XXbk+8VIkFg1R9+MOTIOnrn9A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785724862; c=relaxed/simple;
	bh=NEc7Ae1CGKuNzIW2svqfdJdt3gRoKwhLghPfhJEOfFI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=q2Aqul96T5PxWrue3ODGD8OcOzmQr7E0PYE9zEHZXd4FmomBB2r3dlv/57s+ThYJQe6LlfQHUGcutjvJeMjRC7M252hApgFnCtnBGtWhKjpn1m+tig0WHJZNL6xgTnzgMdLolnyOs/zd4XrEdFmcdg+M160PSWM1GzeE7g2k3gs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=eNYtk+Ka
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A83924BA9019
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=eNYtk+Ka
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260803024057104.CSRI.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 3 Aug 2026 11:40:57 +0900
Date: Mon, 3 Aug 2026 11:40:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix cursor position on new nat app in
 existing pcon
Message-Id: <20260803114055.bf569b322f12ac1e6d6fd3d2@nifty.ne.jp>
In-Reply-To: <9bdf8a92-bc23-109c-0905-78139f0bfe54@gmx.de>
References: <20260720200802.436-1-takashi.yano@nifty.ne.jp>
	<9bdf8a92-bc23-109c-0905-78139f0bfe54@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1785724857;
 bh=aa+sEGpfkvStFOoUAAst1NB6K3VsTPbgqJ2J1W5r8mM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=eNYtk+KaCniTEtRf99WybSg4ugD4RMWSdCb+YOPVJXb+ATGRXYVuNG+gfF2sxVwfMl7EKbmU
 raVHwq+rJaqwLP/ikO69IU1yBYo75aAaSSALMt7dZ6Z9Pz2kEvG0FJ/WBFjFcNL3GiLc878Ob6
 eQRfzGV5/OyLhv6YvwMCvA398uIJp0LyOwenjzB907Y3Sq0PhTVcTwMiPsWpRkPF6lOpGmsb2D
 d3FDFdbTCwEGP5NtT2cZvxEV6ocri/SWCp0plvx97qhqHMrlgYQKFCp3AFTkFR+d2AKrVu/ATm
 fvrYuAHnEiiTI+WbRGpc/L9sdhtete/H5465OEmmTDUbK5vg==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing and sorry for late action.

On Thu, 23 Jul 2026 13:47:13 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Takashi,
> 
> Thanks! This is correct and well-targeted. It should go in.
> 
> On Tue, 21 Jul 2026, Takashi Yano wrote:
> 
> > Previously, the steps: cmd.exe -> bash -> cmd.exe exhibit broken
> > cursor position even with the commit b34394d456b6 ("Cygwin: pty:
> > Fixup pty state after a cygwin app exits").
> > 
> > This patch sets req_fixup_pcon_cur_pos also when reusing existing
> > pseudo console as well as req_xfer_input.
> 
> The coupling in `setup_pseudoconsole()` is sound: Before this patch, only
> `req_xfer_input` would be set, and a reply to CSI6n would simply be
> swallowed. With this patch, the reply is consumed instead (and
> intentionally not forwarded), the same handshake `req_fixup_pcon_state()`
> already performs.
> 
> It complements b34394d456 (Cygwin: pty: Fixup pty state after a cygwin app
> exits, 2026-06-13) by covering the sibling boundary: a new native app
> reusing the existing pseudo console (your cmd.exe -> bash -> cmd.exe
> case), rather than a cygwin app exiting.
> 
> One pre-existing race, not a blocker: the reuse branch sets
> `pcon_start_pid` without the spin-until-clear reservation loop
> `req_fixup_pcon_state()` uses, and the master clears `pcon_start_pid`
> outside `input_mutex` (the store sits just past `ReleaseMutex`). So an
> overlapping handshake from another process can clobber it to zero early,
> and the slave stops spinning before its own DSR reply is handled. Before
> this patch that stray late reply was harmless (swallowed); now it could
> drive a stale `fixup_pcon_cursor_position()`. Probability is very low, and
> the same exposure already exists via `req_fixup_pcon_state()`, so the
> verdict stands. Optional separate fix: move the clear inside
> `input_mutex`, and/or give the reuse branch the reservation loop.
> 
>   Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for the advice. I'll push this patch to master branch,
with the fix in which 'pcon_start_pid' is cleared inside the
`input_mutex`.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
