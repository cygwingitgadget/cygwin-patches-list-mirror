Return-Path: <SRS0=XFaT=S6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 3D7AD3858D20
	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2024 12:16:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D7AD3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3D7AD3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733400962; cv=none;
	b=SHBkSwbK/jm7cQBoyvM4PfTAXvFN41rbJgXETBsectAwAdo6CC5xWZcty+011WcaTgEj+LLc9CTguSWM3yfk78OQZluoNV/x/s3s2LdmMlm3LqfWvtZyZSbj6Kn+Gbs+Y8euK1jMutiF4DGgKs45BlBTaz3Lx1sPVYJmB1sGLwo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733400962; c=relaxed/simple;
	bh=bfnuxjXlPL8TDlZjjeLvDY+E3wXoDQjlyA5JMZeAnFc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=gW3svIhqwJFKhnuaW8sNI7sMKAwrJL1eO+8T9zL7vxC7v96QfAaXje4UfZcJCso8DoF89ynBgaCCBR+6k9JViRO3YFqKeJvZJsaGe0DJJoLllpbuKAC0uhXaAlEOqO+vX4wC1rjiofnsZvd45886Cw1juATlaV9RQb+PWifG4R8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D7AD3858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=A0PdEFqe
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20241205121600172.LRZJ.115271.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 5 Dec 2024 21:16:00 +0900
Date: Thu, 5 Dec 2024 21:15:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Introduce a lock for the signal
 queue
Message-Id: <20241205211559.c20838664bfb81186d477321@nifty.ne.jp>
In-Reply-To: <Z1GWR0MF5xuAYfJz@calimero.vinschen.de>
References: <20241205032548.29799-1-takashi.yano@nifty.ne.jp>
	<Z1GFwzDzoLA88AI6@calimero.vinschen.de>
	<20241205204327.8382aaccd89b00779ee2114c@nifty.ne.jp>
	<Z1GWR0MF5xuAYfJz@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733400960;
 bh=wF7BpMAXVUQlunKww3IBkI9GoGS9NZfk2j+ZyedIF4Q=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=A0PdEFqeCh5RyZNxegt7+q2vOdWLLHfLqMfiPaHYNRkhE1kwYriKjRt97ccSD47pC5O32ts3
 3evH11z5KdrypfNqKbj0D2LTrZQkpxtjU0v4HTb/LcJal7dM60j/0lxhA+5S91DFj9qKvRPgvg
 0+S8fqf7NEy1lgVaI/yE5h4esI04yG+beRtOY0eqNWl6ycINdWl2R6cIC2y+TmWP1gmkPMMthd
 +yGcpzz+7Ol+IEv5wxKUAYoMlJO+ke460TEZdQ59d4L//livSLrV/h/8O4hzYz2kgYxgFMsNlU
 AQkojPQ0K3BSD+DlgA95XpC21qVxfKDn3FvtRAHUJJlzpBFg==
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 5 Dec 2024 13:02:15 +0100
Corinna Vinschen wrote:
> On Dec  5 20:43, Takashi Yano wrote:
> > On Thu, 5 Dec 2024 11:51:47 +0100
> > Corinna Vinschen wrote:
> > > On Dec  5 12:25, Takashi Yano wrote:
> > > > Currently, the signal queue is touched by the thread sig as well as
> > > > other threads that call sigaction_worker(). This potentially has
> > > > a possibility to destroy the signal queue chain. A possible worst
> > > > result may be a self-loop chain which causes infinite loop. With
> > > > this patch, lock()/unlock() are introduce to avoid such a situation.
> > > > 
> > > > Fixes: 474048c26edf ("* sigproc.cc (pending_signals::add): Just index directly into signal array rather than treating the array as a heap.")
> > > > Suggested-by: Corinna Vinschen <corinna@vinschen.de>
> > > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > > ---
> > > >  winsup/cygwin/exceptions.cc            | 12 +++++------
> > > >  winsup/cygwin/local_includes/sigproc.h |  2 +-
> > > >  winsup/cygwin/signal.cc                |  4 ++--
> > > >  winsup/cygwin/sigproc.cc               | 28 +++++++++++++++++++++-----
> > > >  4 files changed, 32 insertions(+), 14 deletions(-)
> > > 
> > > LGTM, please push.
> > 
> > With the patch
> > [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the queue chain when cleared
> > ?
> 
> Erm... wasn't this patch replacing v3 3/9?
> 
> Looks like I seriously lost track. Can you please send a small series
> with just the patches you still want to apply?

Sure.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
