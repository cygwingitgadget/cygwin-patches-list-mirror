Return-Path: <SRS0=SG5m=GM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 2B5334BA79A3
	for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 06:14:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2B5334BA79A3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2B5334BA79A3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1787120074; cv=none;
	b=siWLq7uwDzEUb/IyrCTz8rh7dRG01uZLdh+S07qWT6wJBQgso3dwlBO9qhoPgFdkmhDFgNubiDASgUjtOrogrxDyYoj8Sz0ol7N4oWYZjj99rsbJh+Cy+O2o1J0aa8mW5GDQFdIJE7K9UoCWexVGaULKuju9M2y8KiirEz1BhgQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787120074; c=relaxed/simple;
	bh=1W6pbaNpf4ShQcy9xLAVlbCigxiVZz2TjLGpRjNifw8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=m9KkrSgaDIS9CT5zp4/l6X2866o2JNn1dP/niivBnmKcgr8fiOun8ZA07P9mnwOkyFp6nhozSsVfDcFJSWgp9YH/s5i2xcSe3Y6MqvuxY0TQ6iP8dKcJN7GpCfbAnUjfkrZf3KH4SvlbDcyjusq5stWSTx2rooP2fTWpQN42LMw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EplSbGsg
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B5334BA79A3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EplSbGsg
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260819061431596.TLLT.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 15:14:31 +0900
Date: Wed, 19 Aug 2026 15:14:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix regression in console input
Message-Id: <20260819151430.de60f08f649d952e6acbdcbb@nifty.ne.jp>
In-Reply-To: <4550afe5-7728-80a4-87b3-1565eec5609c@gmx.de>
References: <20260803025011.5289-1-takashi.yano@nifty.ne.jp>
	<9a1a2379-361e-86b4-b310-d162af82a417@gmx.de>
	<20260807012551.c176e66e6288f13ad597d9a2@nifty.ne.jp>
	<20260807013620.678c7579ce2846ec0e658d6f@nifty.ne.jp>
	<4550afe5-7728-80a4-87b3-1565eec5609c@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1787120071;
 bh=3nxBJ0WjRaJPPy8i1lz+Eh1q2uNkX+9ZJ4ZE7rynrMQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=EplSbGsgtYze5nUDp0IxrtGmErowFFppUf8J7pbDOybWPTrr40TK1kFvAvifMPw2RVa42N9B
 ++IR0LVUWcJa620MXdVx58DqsgkxV1xW6TJ+l0d/gq+y3EynyXlJQmx1jHUrnujW3Z+G2Sovf8
 Gdjc9xChuFkyBMM2g3EhZUu5MON0YzgBWrxC+3ftvmJa3oyL3RSWBLcUAScK8c6JHqMfDDGu9I
 p90TtrQkizNGZNywuURDc5ViT5Nvj3cBpqDrRNjGQy6+gz24j1FWr3DTOsTsai2W9/Axau/rMQ
 ZyJBSaF4mfKa2OPFZPX7yD1oGXWpvoxebMrtA8M3Woisu+UA==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Tue, 11 Aug 2026 12:34:19 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 7 Aug 2026, Takashi Yano wrote:
> 
> > On Fri, 7 Aug 2026 01:25:51 +0900 Takashi Yano wrote:
> > > 
> > > On Thu, 6 Aug 2026 16:21:49 +0200 (CEST) Johannes Schindelin wrote:
> > > > 
> > > > On Mon, 3 Aug 2026, Takashi Yano wrote:
> > > > [...]
> > > > > +
> > > > >    for (i = 0; i < total_read; i ++)
> > > > >      {
> > > > >        DWORD nread = 1;
> > > > > @@ -1794,7 +1797,6 @@ fhandler_console::process_input_message (size_t len)
> > > > >  	}
> > > > >  
> > > > >        num_input_events_processed = i + 1;
> > > > > -      num_chars += nread;
> > > > >        if (toadd)
> > > > >  	{
> > > > >  	  ssize_t ret;
> > > > > @@ -1813,21 +1815,17 @@ fhandler_console::process_input_message (size_t len)
> > > > >  	    }
> > > > >  	}
> > > > >        /* len == 0 if called from select.cc:peek_console() */
> > > > > -      if (len && num_chars >= len)
> > > > > +      if (input_ready && (len == 0 || con_ra.ralen >= len))
> > > > 
> > > > Something GPT 5.6 Sol stumbled over, before noticing that this is a
> > > > pre-existing issue: the raw multi-pass caller passes full `buflen`
> > > > (not `buflen - copied_chars`). That was already there before this
> > > > patch (and both GPT and Opus think that this is incorrect, I haven't
> > > > had time to wrap my head around it), and the new `ralen`-based check
> > > > is actually neutral-to-better; and `tcflush(TCIFLUSH)` doesn't flush
> > > > `con_ra`.
> > > > 
> > > > I'm fairly certain that this is out of scope for this here bug fix,
> > > > if it is an issue at all (what do you think? Is this `buflen` issue
> > > > real? Should `tcflush()` also flush `con_ra`?).
> > > 
> > > Thanks for finding this. I rechecked here and concluded passing
> > > `buflen` for process_input_message() is correct. This is because, the
> > > length check in the process_input_message is:
> > > 
> > >       if (input_ready && (len == 0 || con_ra.ralen >= len))
> > >         goto out;
> > > 
> > > After the `while` loop, the chars in readahead data of length `con_ra.ralen`
> > > will be copied into buffer of `buflen`. So the `len` should be total buffer
> > > size here.
> > 
> > `copied_chars` is always 0 here in the first place, isn't it?
> 
> Not necessarily. The total-buffer-size explanation overlooks the
> `read_more` path. In non-canonical mode, `read()` jumps back there when
> fewer than `VMIN` bytes were copied, so a subsequent
> `process_input_message(buflen)` can run with `copied_chars` already
> greater than zero.
> 
> For example, with `buflen == VMIN == 10`, the first pass may copy 6 bytes.
> On the second pass only 4 bytes of the caller’s buffer remain, but passing
> 10 can consume up to 10 more bytes into `con_ra`, leaving 6 in this
> process’s private readahead. Passing `buflen - copied_chars` would stop
> after filling the remaining 4 bytes and leave later typeahead in the
> console buffer.
> 
> The exact batching depends on `line_edit()`, but `copied_chars` is
> therefore not always zero at that call.

Ah, right. Thanks for letting me know that.
I'll submit another patch to fix the argument of process_input_message().

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
