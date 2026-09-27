Return-Path: <SRS0=6sOE=HT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 5A5D04BA540B
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 02:17:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5A5D04BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5A5D04BA540B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790475457; cv=none;
	b=VjyRBKQY8geMpuqi0Bz4PVye7KB14flilp8aVj43dhSzAldWE2ApDFEeVzwR3HXQdwrnEI1HjDjDEVYimDusdxGcWtwSPb5aOVjrlM964qXAcw7JHZ3EQupbl0B0PyLnPBln/yej+Y+jumZjkgTTLUl4K7SXb3Op9dLzAID36ok=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790475457; c=relaxed/simple;
	bh=+VjqF9kGFHxMtSjUiMNOWPOMrryG0TxtoTqe2aGRO50=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=pLCS2mgqxMdfieiLtFNSXQhvGsSHVXHl/CsodOcOc/8ArLE/XDXqMaQpS3xZhHeR8CLa6NN8w3keWooZtaQgKyBfOc5DnhOh24QEsg/TTABrrq0H1dHVQmLrSiJcbol9fkkKvZPGm30FCe8wteqCs83URp4WKEmUiOM+jErMY74=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rbLqBvci
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5A5D04BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rbLqBvci
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260927021730856.WJO.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 11:17:30 +0900
Date: Sun, 27 Sep 2026 11:17:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: console: Clear readahead buffer on tcflush()
Message-Id: <20260927111729.1076d2ca880d4761739baf41@nifty.ne.jp>
In-Reply-To: <65917936-1766-f022-c6b4-91a8a6983d39@gmx.de>
References: <20260926154038.3364-1-takashi.yano@nifty.ne.jp>
	<65917936-1766-f022-c6b4-91a8a6983d39@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790475450;
 bh=+iXquk2ndn9KKqimU2v4jQNIqbhW0g5171FUz/BRWuA=;
 h=Date:From:To:Subject:In-Reply-To;
 b=rbLqBvciGp9czA8sD5MlvBOAuk+7rJT6TqLp9ZdUs9QqmP3zQTcQk69hi+EEwq6ehaySUB/L
 mw3c1ZOoDstbFR8DJ/w1aLuBnQG5Nzuujbwo6RP5AMng0rts6mp1WZ/jt+jGZr5SC8hRyWg3Ei
 VhXHg08ucLd+n26es8qgThdWUeIOFmEenPeBp9Q8jQ/UDzjXmqfmF31+KFS3qqhGukohtqctss
 iWaupyn2Ti+9oT74myz4+vQbBm2JcrltWzwhIhqYd4aIkbbB9deNWynoyMFXeq/g/Cu7AHyj/t
 QVdDNSa2/CGxfbqLhNUayoB2lV6Pw4CHq0eg3VWvaW/cwoaQ==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sat, 26 Sep 2026 19:12:12 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sun, 27 Sep 2026, Takashi Yano wrote:
> 
> > Previously, tcflush(TCIFLUSH) only discarded the input events and
> > did not clear the readahead buffer. Because of this bug, when user
> > program called select() -> tcflush() -> read(), the last read()
> > returned the contents of the readahead buffer instead of blocking
> > as it should.
> > 
> > Correctly, tcflush() must discard all pending input, so read()
> > should block until new input arrives. With this patch, the read-
> > ahead buffer and `rapoi` are also cleared as well as input events.
> > 
> > Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> > Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Add input_mutex guard. Clear rapoi as well.
> > v3: Acquire input_mutex before output_mutex in ioctl() to avoid
> >     deadlock in tcflush().
> >     Make input_ready static as con_ra is.
> > v4: Revert input_mutex in ioctl() and move tcflush() outside
> >     output_mutex insted.
> > v5: Clear input_ready in close().
> 
> Excellent! I fail to have any concern about this patch iteration ;-)
> 
> Thank you so, so much for keeping at it. I know I have been complaining a
> lot about the pseudo console support in Cygwin, and I cannot imagine how
> annoying my frequent feedback is that requires so many patch revisions.
> I'm sorry! And I am really grateful that you are taking my feedback so
> gracefully and keep improving Cygwin.

Thank you as well for your always‑accurate and helpful feedback.
I would appreciate your continued support in improving the quality
of Cygwin.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
