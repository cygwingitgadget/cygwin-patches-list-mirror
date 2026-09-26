Return-Path: <SRS0=9EPT=HS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id E7ED04BA9029
	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2026 15:40:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E7ED04BA9029
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E7ED04BA9029
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790437208; cv=none;
	b=JslCvwpRDqrUkQMjtO9LIRUoPAuv4uWYNKFwcYAO1xjwiJWZ8kSh3j+MmQTC21STEed63yRWsnGifdmoPLZ+7rt4joYCzwV6gjMDF0ZSZ022ipC8OqinOTsmTUrJuV6NHMl5O4ky3oDpeiAEHaUKrdQbuUdstCy/MjWxjRRfwxM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790437208; c=relaxed/simple;
	bh=Ck/dWhmqm7XTf7+5AK7eFF8XOnMdPN71yv3HRyl/IEc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=i7p2Axay518VIGmF6NN9jfYI3fRO/GK0rH0HQKvdzxgJnQtFihlM09g8ZOSR8oTsQaTYRiWx1507sb96QQsxrblu1fNWm1+QrcK6EWoefeI35YBF+bsur6K0NLiu/p9DibR/ruXvO2KwWkh7GyXEoEbzp1em5RZuEuizd1rJOOs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ppAmyCGD
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E7ED04BA9029
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ppAmyCGD
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260926154003209.VVNA.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 00:40:03 +0900
Date: Sun, 27 Sep 2026 00:40:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Clear readahead buffer on tcflush()
Message-Id: <20260927004000.82c393a88f3bced4c345142b@nifty.ne.jp>
In-Reply-To: <59a99c34-239b-73c0-2f74-4feb6cd81db2@gmx.de>
References: <20260915063431.602-1-takashi.yano@nifty.ne.jp>
	<59a99c34-239b-73c0-2f74-4feb6cd81db2@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790437203;
 bh=Qb4oDQjgVD/g+osXhVJB4ywvpGuPELrOhh9XVsjzjx0=;
 h=Date:From:To:Subject:In-Reply-To;
 b=ppAmyCGDua+fB0PjJjSehvJ/KHiRO2JgzN9WbL1bhXoIVxH8Chvzf7IuYW3yc74Jd8zDcNiz
 56U4L4m5LJiRBq/AJAdAp9/ZHPiCq1aAYUen0Wwon0q4Da9562RbzeavdOcgKaAOyRvOkcX787
 TTKdhVbBgzE0VNqD/QO6uHdcOsryoWMEcS95pE4xkS/H+pg+d6tewVkKHpfv6ARUsakQqI37Jn
 RXKDNFa/cWoYxj4NifcAN0T26AfAw3kSZtwaZJXJC+NB9S/EGD2kElsMZjjR4wmiFb5Nm4ywuA
 mQbGUbQE3w/6+HBpZE5gdMALeZK52zBKnSc/FQkN0ujT19YQ==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Thu, 24 Sep 2026 22:08:04 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 15 Sep 2026, Takashi Yano wrote:
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
> 
> Thank you for this version. It correctly flushes the Windows input queue,
> `con_ra`, `input_ready`, and also `cons_rapoi` under `input_mutex`.
> 
> It also fixes v3's lock-order problem by calling `tcflush()` after
> releasing `output_mutex`.
> 
> However, one concern remains unresolved: `input_ready` is process-static,
> but `close()` frees and zeroes `con_ra` without clearing `input_ready`. In
> the same process, closing the last reference to a secondary console and
> reopening it could therefore retain `input_ready == true` with an empty
> buffer, potentially producing an apparent EOF. Or am I misreading the
> code?

Indeed. Fixed in v5. Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
