Return-Path: <SRS0=SG5m=GM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id 4EA014BA23E2
	for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 05:27:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4EA014BA23E2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4EA014BA23E2
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1787117229; cv=none;
	b=UFjI0q9NeOR5aK7QVIcStVw4qmPQlw4UJ+WfZsJn3trNqKXRlmZGaHIuDu2qM7DAo7FonAgTFMkS1rmA0kLbCJJuDYaEszkDIEGOEsS7Oc1NcaGpukHTehcgAium6qES2N8K6Yj55erNAj5bssxuigLL6w+bWd974q8Z6eoyL3A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787117229; c=relaxed/simple;
	bh=YZJzj+CM005lzaAKUct7jMFou9oV8iR/YE30g9VP14A=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=vViuw4nbqF0lyx6XWK5kUjQMRxetVJ4cW8cDVEy+0+J6PwPD5hMGCXQhm7+mVtulqYrHrQ1WILYZ68mNxUu292tloS5ob9d2jAe+5C0ZGTZSYDH7Pzv9G+2Zf2DjyWEWi1NjNP4OgV2tvNgtLPgTcIpOh0hKZOurelni9nC8Y3k=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tjcMEKvc
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4EA014BA23E2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tjcMEKvc
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260819052707357.MNZY.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 14:27:07 +0900
Date: Wed, 19 Aug 2026 14:27:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Clear readahead buffer on tcflush()
Message-Id: <20260819142705.a6ddbac3ea79a7dd8291c4db@nifty.ne.jp>
In-Reply-To: <954fb6e8-851d-d19c-e9e7-e93a029890cf@gmx.de>
References: <20260807111245.2139-1-takashi.yano@nifty.ne.jp>
	<954fb6e8-851d-d19c-e9e7-e93a029890cf@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1787117227;
 bh=PluPLSjKrmqoMEhoJ0DAd9MLNCg4/zD3vekyS6iHC48=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=tjcMEKvcuLqS1fv++st7xHGpxzyytPTtHDl+F8KqbOZCWTI7YQoupJ/6OoVJnsciIEVLd64T
 sCkPXXEaBVGCIHPUoZTTnxlZz5T0v+jSm2p4ZVKdW1IYjTPUxKKlb1q3d6Gg1bCay4pbLPdPj3
 TlnOaO/M5L85xnac9v3WXnCvT81R7C9C5Mzwcw1gFtRmRM1Y2blZNSTmm7WxwEuq5dExLJTK+b
 uEwkcc04+yxGqVoDL6J6XJZdywiWsUrghyCDSa9lei9I9TQen79Wi1mOQIsI7k81Hh7nqw5bca
 utXArkzvYET/mgJb/YX95J5iq7fQWnKHehMais6/rQ96xqbw==
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPAM_BODY,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing.

On Tue, 11 Aug 2026 12:14:13 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 7 Aug 2026, Takashi Yano wrote:
> 
> > Previously, tcflush(TCIFLUSH) only discarded the input events and
> > did not clear the readahead buffer. Because of this bug, when user
> > program called select() -> tcflush() -> read(), the last read()
> > returned the contents of the readahead buffer instead of blocking
> > as it should.
> > 
> > Correctly, tcflush() must discard all pending input, so read()
> > should block until new input arrives. With this patch, the read-
> > ahead buffer is also cleared as well as input events.
> > 
> > Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> > Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/console.cc | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index ba35ca44c..d3fb2fcbd 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -2362,6 +2362,8 @@ fhandler_console::tcflush (int queue)
> >  	  res = -1;
> >  	}
> >        con.num_processed = 0;
> > +      eat_readahead (-1);
> > +      input_ready = false;
> 
> The core fix is right: with `con_ra` drained and `input_ready` cleared,
> `read()` keeps waiting (its loop gates on `input_ready` and
> `get_cons_readahead_valid()`), so the select() -> tcflush() -> read() path
> no longer hands back the stale readahead. I confirmed it fires only for
> `TCIFLUSH`/`TCIOFLUSH`, not `TCOFLUSH`, and that clearing `input_ready`
> cannot drop a window-resize or signal event, since those travel via
> `input_winch` and `input_signalled`.
> 
> Two things should change before this lands, though, I think.
> 
> First, this input flush is not serialized against `input_mutex`.
> `tcflush()` here runs holding only `output_mutex` (taken by `ioctl()`) and
> `attach_mutex`, not `input_mutex`, yet `con_ra` and `input_ready` are
> otherwise mutated only under `input_mutex`: `process_input_message()`
> fills them, `read()` clears `input_ready`, and `peek_console()` reads
> them. So a concurrent `read()`/`select()` on the same console can, right
> after this flush empties the buffer, line-edit already-drained events back
> into `con_ra`, and the pre-flush input reappears once `tcflush()` returns.
> Please take `input_mutex` around the flush body.

Done.

> One caveat there: the signal path (`sigflush()` -> `tcflush(TCIFLUSH)`)
> may already hold `input_mutex`, so it is worth confirming there is no
> self-deadlock. Windows mutexes are recursive per-thread, and
> `process_sigs` releases `input_mutex` around `kill_pgrp`, so it is
> probably fine, but that should be checked rather than assumed.

kill_pgrp() is called the places other than process_sigs(), but yes,
a mutex of Windows can be acquired recursively, so adding input_mutex
guard in tcflush() is safe, I think.
https://learn.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-releasemutex

> Second, `get_cons_readahead_valid()` gates on `con.cons_rapoi`, which is a
> separate buffer holding terminal query responses (the cursor-position and
> device-attribute reports that `char_command()` queues), not `con_ra`. The
> patch leaves `con.cons_rapoi` untouched, so if such a response is pending,
> `read()` after `tcflush(TCIFLUSH)` still returns it instead of blocking.
> That is arguably the POSIX "data received but not read" that the flush is
> meant to discard. Either clear `con.cons_rapoi` as part of the same
> (locked) flush, or, if leaving the query-response buffer intact is
> intentional, say so in the commit message so the exemption is on record.

Done.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
