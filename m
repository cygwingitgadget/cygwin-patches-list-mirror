Return-Path: <SRS0=bcf7=HF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 342AA4BAE7EA
	for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 21:49:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 342AA4BAE7EA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 342AA4BAE7EA
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789336190; cv=none;
	b=jQAnegpiIzpjTqQAKipqM08qnr8az1qgYukgdDaa90gX9+XzW61wDt5+x+A5xEJjy/s+JKw9njANHfJ/KT217M+uAxOlSGYRJWaezwYNTV29Hx3BnPgkpE4CyVusLKC3Fag0YlE5wYZQTsksk3jURPOxP/CeFWLjQv3Pd3on2bY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789336190; c=relaxed/simple;
	bh=kIyPlX7ZR78w0N9LNhhxmufQ+mbi4lDxuOBzV2LGInk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=AjoKxG88Uc7coYdB1JI9AUzrn1sbMH3Y5cZKpxPBYKdmEU7Cz1S12ZRvzdfvQ9XuLPpcmvTZejqCi3+xZ07TfHW2hpiIxSjYAk+NM8Ees54kEXyYywxK7P348tuo69ceAQ0MEDoC0WuUIiAbw3myzbrZf7SVjBxqdyHYE5ZYcWs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bVJ6sF7F
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 342AA4BAE7EA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bVJ6sF7F
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260913214948294.KGPI.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 14 Sep 2026 06:49:48 +0900
Date: Mon, 14 Sep 2026 06:49:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Clear readahead buffer on tcflush()
Message-Id: <20260914064947.662a73ab663306e3a3808817@nifty.ne.jp>
In-Reply-To: <707a417a-2f2c-8116-bf3c-d1bc842f47e4@gmx.de>
References: <20260819051609.128310-1-takashi.yano@nifty.ne.jp>
	<707a417a-2f2c-8116-bf3c-d1bc842f47e4@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789336188;
 bh=PThEWgfBOvizWC/jP1EV1d8JdumiIBPzLFB7jGRNCtg=;
 h=Date:From:To:Subject:In-Reply-To;
 b=bVJ6sF7F4RQ0CU7S2aM3p67tYQgnBZIy6gdg6CgA0be5yvBBxFwYKOhSzrDG9AjkuopiiZ6i
 op03Ft6QGFlJwUHQ3kiiYqXO7H7gXZGsZ7FLeZZd1A5hX8EfDunCEzE4vxnCtrlZ1aoqvtA/Aa
 xV+sqOq3R/eF/l7OZcS7/PN8Q4v0qVogPoijZeJe/to2VZNhf/W2In06Rr0hwsIwkyh5gIZU7e
 g5+XnH4bRngoQDG+3f78LnTH9WCmSgbI/Pnua4dzkXVD4bHcZhHZcYHyK6KfSAw6u1CR7Nyaq3
 vS0ZQ+dds9czEcqlLGwDe1PWUxrrIuLbIFtWHsmOv0bENcmg==
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sun, 13 Sep 2026 12:50:13 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> thank you for addressing my concerns. I have two more concerns, though:
> 
> On Wed, 19 Aug 2026, Takashi Yano wrote:
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
> > 
> >  winsup/cygwin/fhandler/console.cc | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index ba35ca44c..a5887ca8d 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -2351,6 +2351,9 @@ fhandler_console::tcflush (int queue)
> >    if (queue == TCIFLUSH
> >        || queue == TCIOFLUSH)
> >      {
> > +      /* tcflush() may be called inside the input_mutex,
> > +	 however, mutex of Win32 can be acquired recursively. */
> > +      WaitForSingleObject (input_mutex, mutex_timeout);
> 
> The flush ioctl introduces an opposite lock order. The dangerous entry
> point is specifically `ioctl(fd, TCFLSH, TCIFLUSH)` or its `TCIOFLUSH`
> equivalent. Console `ioctl()` holds `output_mutex` before calling the
> handler's `tcflush()`, which now waits for `input_mutex`. Concurrent
> reading and echoing hold `input_mutex` and wait for `output_mutex`. Each
> can therefore wait forever for the other.

Indeed!
I've added acquire_input_mutex() in ioctl() before qcquire_output_mutex().

> Normal public `tcflush()` and signal-driven `sigflush()` call the handler
> directly, without this ioctl output lock: they do not follow this
> particular cycle. Any fix of the ioctl's lock scope/order needs to retain
> the necessary input guard.
> 
> >        acquire_attach_mutex (mutex_timeout);
> >        DWORD resume_pid = attach_console (con.owner);
> >        BOOL r = FlushConsoleInputBuffer (get_handle ());
> > @@ -2362,6 +2365,10 @@ fhandler_console::tcflush (int queue)
> >  	  res = -1;
> >  	}
> >        con.num_processed = 0;
> > +      eat_readahead (-1);
> > +      input_ready = false;
> 
> Flushing a duplicate can manufacture apparent EOF. Two duplicated console
> descriptors, A and B, share `con_ra` within their process, but each
> handler has its own `input_ready` flag. Let `select(A)` buffer a complete
> line and mark A ready, then call `tcflush(B, TCIFLUSH)`. V2 empties the
> common buffer but clears only B's flag. Descriptor A remains falsely
> ready; its next blocking canonical `read()` skips waiting, finds no bytes
> and returns zero, which looks like EOF. No race or EOF keystroke is
> required. Readiness must be shared or invalidated consistently with buffer
> ownership; simply making every empty-ready read wait would break genuine
> canonical `VEOF` handling.

input_ready flag reflects the status of con_ra, so I've made input_ready
static as con_ra is.

> I'm sorry that I cause more work for you!

Thanks for reviewing. Please take a look v3.

> Ciao,
> Johannes
> 
> > +      con.cons_rapoi = NULL;
> > +      ReleaseMutex(input_mutex);
> >      }
> >    return res;
> >  }
> > -- 
> > 2.51.0
> > 
> > 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
