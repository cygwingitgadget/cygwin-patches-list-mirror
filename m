Return-Path: <SRS0=co2e=QA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 8A71C3858D37
	for <cygwin-patches@cygwin.com>; Mon,  2 Sep 2024 14:33:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8A71C3858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8A71C3858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725287600; cv=none;
	b=oefumk70tMS5RlY+NdBC0mDClHHXv6G8lhvNCGdWFqhHvdjPCG4OTif4c/PqpNyoiSSf1sEeZdHtHujNRy3X4G/1I0fecqIq1zP3IAMfJf32D/lvaBqs4UKH5rApL+21mOqHalXMFusYTvZlNP9h0ewq+OPS4NnnFVcFNZuIcAA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725287600; c=relaxed/simple;
	bh=CUVQ/GVb/QoVs6wnX9RqcWv35bto2iqEzE1ggqx4IJ8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=fstuiR1YAAwrwjxVneK5/gvIZUc/FPFPdLWkpcOKp9/l8pZ9fPPwyaDsnbkgItmJSfthxLzuXaKFr1nD2s8sJ4F6JfC079lXlyOwUavPD5zTUZyB/ijTpQgucvOLcw2eGq38wy7TtUu84lGk/AP5oGDAArojtyfD/cgriAF5SI8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20240902143315201.VLXA.55939.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 2 Sep 2024 23:33:15 +0900
Date: Mon, 2 Sep 2024 23:33:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-Id: <20240902233313.171fb48cc8243cd095d7280f@nifty.ne.jp>
In-Reply-To: <20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
	<ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
	<a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
	<20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725287595;
 bh=/wo7HxtlV3uhfB9bEqjNGBbfAQBWWOH7O9PV9EkRbEQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=hH1Ntboo2AnMY4P0Zybtv7BybM88ufWrfg1P/9xx+9TXr0pAqMYvHHvU1XEHOoAise8ixSkB
 WRKSDIbTaNEIsPX/EthCqGHYY864dkTQ3ddnEkrA/O5FCmnpYtcpE2MMWu8Uv816CMwLOvGC7O
 Ag5knlKW68yD7kyAJ24VM6B9dFQO7VT7tKaB1jkkr2x9EHyWT2bac4yoTxJO+PAP7QOZId/yX3
 +q/YQ3H36S76Iq6jp52Geyc2kf520ATOSk6deSOeNYL6JnmuxFCtYhCBoCSY16bEfIR+C5IXQs
 nBKaDeix4bqk6leluqefXABWLxmHwL2jPJMxB3qQ+6H/phCg==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Sep 2024 22:50:45 +0900
Takashi Yano wrote:
> On Mon, 2 Sep 2024 14:48:35 +0200 (CEST)
> Johannes Schindelin wrote:
> > I have tested it and the symptom is addressed.
> 
> Thanks for testing.
> 
> > I do have to wonder whether it is intentional that calling
> > `set_pipe_non_blocking(false)` followed by `set_pipe_non_blocking(true)`
> > on an originally-non-blocking pipe will "restore" it to blocking mode,
> > though.
> 
> I'm not sure how such symptom occurs.
> 
> Calling `set_pipe_non_blocking(true)` on an originally-non-blocking pipe
> will set `was_blocking_read_pipe` to false.
> 
> Furthermore, regardless of the value of `was_blocking_read_pipe`, calling
> set_pipe_non_blocking(false) always sets the pipe blocking mode. It is not
> due to "restore" logic.

Ah...
However, if a cygwin app executes non-cygwin app and the non-cygwin app exits,
the read pipe remains on blocking mode. Then the cygwin app cannot handle
signal on blocking read() after that.

Let me consider...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
