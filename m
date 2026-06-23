Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 783E64BA5439
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 22:50:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 783E64BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 783E64BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782255027; cv=none;
	b=DyAhymnLtZtX45E+SqGsQb2QTop4Jwodwv31OiGZXVrArtRqRvOgkZPdC6aglCguTXXJ55VITcGJ9VGvWlhDzADgYunJQUw3nVeHiqzhqQAsO2i2tha10GaQKF7cQTnlNL0O2TybFP5879vjfJ8XN5tJkvWdR2HoQhwMDOgSX0E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782255027; c=relaxed/simple;
	bh=hMALvyT1zyoYzQnvOBJbuigl1zfQaNQIwZ/OpPgvdPs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=eogjjFHcvN4qRSgz9PdYs21rafoNRhQHVFKzD6UmuEqy14//KA/4+nRdhbWVepLfgXMbK1RdbLeJFtNSCQQVxBjNmmdbpRj4tXuLxXyx5BUkROaD/dcXQ8dRf0DBJPSIlLSvOddqQGUoENNPldoLUcnZlBsHidgQgYuz6pbeCZk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=uATX1J2U
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 783E64BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=uATX1J2U
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260623225024087.VOLP.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 07:50:24 +0900
Date: Wed, 24 Jun 2026 07:50:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: pty: Fix race issue between starting and
 exiting non-cygwin apps
Message-Id: <20260624075022.75fe4a1675905e8e73dda239@nifty.ne.jp>
In-Reply-To: <20260623232423.5dec0125b316a8b7503f18a4@nifty.ne.jp>
References: <20260613140718.25268-1-takashi.yano@nifty.ne.jp>
	<9e5fa557-3ff1-41c2-8bb0-f09630eb1834@maxrnd.com>
	<20260623212925.b12a2d4dc3c2c52926d44874@nifty.ne.jp>
	<20260623232423.5dec0125b316a8b7503f18a4@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782255024;
 bh=FIizQD0i+AeAFBQR4m8TtdSZf/YSrOLCeW8/MhO6yFE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=uATX1J2U1f/86vPznvyxbecfNfikUy0B9Xq5+x3nqlr9E4qfqkAJtnIPqyKWRo1Wko6iIZcw
 FRNzN7MXFL0Lhs1X14qO9e7IfueDBrgyKsNcNnDMZNoAhAW8iYCOrZ/kpnvvPZ+giUZ9yBROcS
 MfctV6pfCb75WBZy/0qXgOAOD1Zjd4zh00hMdJJN5CFBhXFtJHzgS16ztdvSXayHBoVDpGBLxS
 Fj0yKEIV1U4EIXNL5I/q9ZIQ8nHPpWochvJgD/3RkqpVfqOfgPqVZQk5hOvwMamM06WzF8aApT
 dqPHveCZPjnD/NZs7InLJ81XQfq01+jFIeMfaqL+5486lwLQ==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 23 Jun 2026 23:24:23 +0900
Takashi Yano wrote:
> On Tue, 23 Jun 2026 21:29:25 +0900
> Takashi Yano wrote:
> > > I am a little concerned if the replacement WFSO is equivalent to the 
> > > looping WFSO being replaced.  I.e., it terminates for the same 
> > > condition(s) with the pty being in correct state.  I can't point to 
> > > something specific though.  Can you reassure me?  Or is this just 
> > > re-establishing code to the way it was before?
> > 
> > The code before the patch intended to leave wait-loop when pcon_start
> > mode is set even though the pipe_sw_mutex was not acquired. With this
> > patch, to_be_read_from_nat_pipe() is not called from master::write()
> > anymore, so the busy-loop is not necessary due to changes below.
> > 
> > @@ -2496,7 +2519,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> > @@ -2580,20 +2603,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> 
> Ah, I forgot to mention.
> 
> to_be_read_from_nat_pipe() is called in master::write() below, however,
> it is called only when pseudo console is not activated. In this case,
> the slave is never in setup_pseudoconsole(). So to_be_read_from_nat_pipe()
> can acquire pipe_sw_mutex after a short while.

No! I was wrong.
If master::write() is called when setup_pseudoconsole() is called
but the pcon_activated is not set yet, to_be_read_from_nat_pipe()
will be called while the slave holds pipe_sw_mutex.

I'll revert this change, and submit v7 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
