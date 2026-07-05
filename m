Return-Path: <SRS0=TCz0=E7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 7653A4BA2E0C
	for <cygwin-patches@cygwin.com>; Sun,  5 Jul 2026 14:28:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7653A4BA2E0C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7653A4BA2E0C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783261722; cv=none;
	b=JYw3BoR34UoOkjVcce/oLw5Ox0MHQqlrCLHnxKgZBWJaRx022+6TVtyP0wfSjjt1PkDsvzLeWx+K33j/z2dT5Lm2+8Nq9eh9gzw/BTYrpxNIJd/QtG43gE3tqcBtnYxLjWjfMrJ46v7nsenYUe4G0d12eZDLxERF5kbeREu3IEI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783261722; c=relaxed/simple;
	bh=22vJTwE6wk+ozFoTX1C51Xw47H1E6mXkxYBDCvoF1Dg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=hV+Vrb4+L0TsnjguONu/Vy8l8d/UbIyrPTXvczH51Uf3ZYoepkhzlJUpOdS/2hVRC1/kse3Md2Nl7eRGjaiSQsnaPu6tBs0+6egOXtit+plMz4P2aYSnf+FIJ1Pn/iouuvR8jpKAqC4Noom6g0weLhUxJ+j4tLXb3F5sXubk+Xk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WkpcfvTS
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7653A4BA2E0C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WkpcfvTS
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260705142838249.EDWR.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 5 Jul 2026 23:28:38 +0900
Date: Sun, 5 Jul 2026 23:28:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: re-enable the master thread before
 selecting cygwin input mode
Message-Id: <20260705232836.92d456032d8f7b7d1a1e02f3@nifty.ne.jp>
In-Reply-To: <69136f7a-24a3-0d96-7ef5-2d444aad8d7c@gmx.de>
References: <20260630114735.118967-1-takashi.yano@nifty.ne.jp>
	<69136f7a-24a3-0d96-7ef5-2d444aad8d7c@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783261718;
 bh=KDol1kNiT4E8MlgF/d2ppx/uAKl9FkUX7RlhfZMt1K8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=WkpcfvTScJYKjDigTQiF/9XGUioKAydxsEJ5klY4C1Btw6uW+rsHtQgqT7ZnNN27qIhUaSNm
 gRwdZfkXLDM7GV0Llj8sykFmNW0d08z8JN2rbyylZ48gL0FaG66GP0ycQ9WNLT1sYhfLh+UHkV
 NcfJ2jN5qDnu8fh2XWqTCyKnHVNPRxeMZBONOsY2x4RYo6EgRtKu8p9FmihResP1CC0BIVJAFm
 hfpAs0HlSPR3SDDnPLcn+TeEwJ0L9j3rxU+OK3wKfhtUi5s43fqfwHlGu2oIVsJeKG8RRo8UXI
 DXCXsxFMAcM+jMOo9dK2euZRmwTpbHiJ7YQeB/5G8uvNvqEg==
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 4 Jul 2026 14:38:55 +0200 (CEST)
Johannes Schindelinwrote:
> Hi Takashi,
> 
> On Tue, 30 Jun 2026, Takashi Yano wrote:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > When a cygwin program and a non-cygwin program run in the same foreground
> > process group (for example the pipeline `cat | ping`), Ctrl-C stopped
> > interrupting the cygwin program after "Cygwin: console: Ensure the master
> > thread runs only when it is supposed to".
> > 
> > The console only delivers Ctrl-C as a raw 0x03 byte (which the console
> > master thread reads and turns into a SIGINT for the foreground process
> > group) while that thread is live. When it is suspended or disabled,
> > set_input_mode (tty::cygwin) instead requests ENABLE_PROCESSED_INPUT, so
> > the console raises a CTRL_C_EVENT and the 0x03 byte never reaches the
> > master thread. The referenced commit reordered the two enable paths,
> > bg_check () and post_open_setup (), so that set_input_mode (tty::cygwin)
> > runs while disable_master_thread is still set; that leaves
> > ENABLE_PROCESSED_INPUT on and the cygwin program never receives its SIGINT.
> > 
> > Clear disable_master_thread before selecting cygwin input mode in those two
> > paths, so the mode is configured with the master thread already live and
> > ENABLE_PROCESSED_INPUT stays off. The disable paths and the synchronous
> > suspension that the referenced commit added are left unchanged, so
> > non-cygwin programs still get the master thread reliably suspended.
> > 
> > Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
> > Assisted-by: Opus 4.8
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Co-Authored-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> 
> Thank you for extending this patch! My only concern: The commit message
> still says "the two enable paths, bg_check () and post_open_setup ()" and
> "Clear disable_master_thread before selecting cygwin input mode in those
> two paths."
> 
> With the `cleanup_for_non_cygwin_app()` hunk added, this needs to say
> three paths and enumerate them. Also, "clear" isn't accurate for the
> cleanup path where the argument is `con.owner == GetCurrentProcessId()`,
> not literal `false`. Maybe "set `disable_master_thread` to its target
> value before..."?

This is for a special case, that itself is a master process which calls
exec() for a non-cygwin app. In this case, subsequent set_input_mode()
call sets the mode to tty::restore, and the master thread should be kept
'disabled' until the process exits.

> The functional change looks like a real improvement over the version I had
> sent. The reorder is internally consistent, the asymmetry with the
> "disable" paths is correct, and the change is a strict improvement (no
> regressions for the owner of the `tty:restore` sub-cases, and closes a
> latent bug for the non-owner `tty::cygwin` sub-case). I integrated it into
> https://github.com/git-for-windows/msys2-runtime/pull/131 just to be extra
> certain, and the AutoHotKey-based UI tests still show that the tested
> scenarios do not regress.

I modified the commit message regarding above commnet, and pushed master
and cygwin-3_6-branch.

Thank you very much!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
