Return-Path: <SRS0=Aef5=D2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 1672D4BA2E26
	for <cygwin-patches@cygwin.com>; Fri, 29 May 2026 02:36:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1672D4BA2E26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1672D4BA2E26
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780022213; cv=none;
	b=BxbpNax3WoxJRdBH6U/l5pXOq//L1ug7bUzILrMlicuHpJJWXxsdw1vXJLYgrR2UwC27Pi+rqPOUKtzXCt8xPrvYS/mLM1Un/4MEx9vJd9RDH/N3wS3iWwVs4hMu9plzR0SICoaJXFAv5TBAsEaKjQx7u8epBSZPOB4e7FCUio8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780022213; c=relaxed/simple;
	bh=e9YtqtImXVYxEvII1Cg9EEzzxqDZh4hYBs2e1G03Puw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=wtDZnX7lbruBtZclCXD043H+3EOQBX1MeD1pqLolW23RL6auxvftmTRAnFxcuhXz7fa7okWpNJChTx+XDXmsvui1t3u0gKe7uSZKRLQ9gXU2QRwiOsJv2HQuJ8J1zHzpOGIKS8AiB4ydasHwFSS56GrT6fP97QId/iF9Wrv0oh4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lJ4v7eeF
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1672D4BA2E26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lJ4v7eeF
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260529023650237.RNGB.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 29 May 2026 11:36:50 +0900
Date: Fri, 29 May 2026 11:36:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix deadlock in console teardown that
 arises from pcon
Message-Id: <20260529113649.e6c4d215f798cf12d844ae64@nifty.ne.jp>
In-Reply-To: <86c4329d-ee10-4c9a-be10-f8b8de78a6b5@gmx.de>
References: <20260521212621.130760-1-takashi.yano@nifty.ne.jp>
	<86c4329d-ee10-4c9a-be10-f8b8de78a6b5@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780022210;
 bh=UZPTNGfYecqEph9483ED0XFf8QqvTWl90bTd4kXilIM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=lJ4v7eeFQNOpk1CfC90RC5ngpyEwXsO+9Bnw79l4HOQNt4vgSxZm+tXt/LxgFWBEWYyk5Y70
 kUyOoQEprJL8yMIJrt+iO6KdLqdA1WPQmvSOBlPbLhYyVYkqghg3S0T739T9Dc5QUJ9Abu4stK
 gsN/CZ4SSKcYzm4huKhV6Ex394hAjcQdTC5Ga5O4G4E5IkqmwU+SbMvLNBRY+x6SNYWp7Tmdux
 iPGUL+lKig8vx1DFPLLmYRp1Oa/1dLFff/wiR3ZIY0S0GOAjGIwk/1tpV/1ho3tcaOAId7iNL7
 E3hBKKlTuseweai3Zjys/BGsjgvDyF9m0HS/OuV39l44O5hg==
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 28 May 2026 15:38:46 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 22 May 2026, Takashi Yano wrote:
> 
> > When a console process originating from a pseudo console exits, the
> > current sequence is as follows:
> > 
> >   1) atexit handlers (pcon_handover_proc) called. This also closes
> >      parent_pty_input_mutex which is introduced by the commit
> >      c4fb720afcf1.
> >   2) close_all_files() is called via _exit(). This terminates
> >      cons_master_thread.
> > 
> > parent_pty_input_mutex is referenced in cons_master_thread, so
> > cons_master_thread may still use the mutex after it has been closed.
> > This can lead to undesired behaviour, including a deadlock. Instead
> > of registering pcon_hand_over_proc() as an atexit handler, this
> > patch calls pcon_handover_proc() at a point in fhandler_console::close
> > where cons_master_thread has already terminated, ensuring that no
> > other thread accesses the mutex.
> 
> Thank you so much for this excellent commit message, which motivates the
> patch well and preempts all the questions I would have asked about the
> code changes.
> 
> The entire patch looks good to me!

Thanks for the review. Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
