Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id D93DA3858D35
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 12:31:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D93DA3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D93DA3858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733229108; cv=none;
	b=Pryrz9qGFtkBm27d68IPgkVD55Fh2O5JrcvaboXHFlvfsqvSeOT7qomNKmnPPvNRD1U+IABfmDcdr3KYI7KCMbptJyhUwLO/igWeNOto7aS53tWmlU0moBr+qaR2oNA4DXk19sbH8G9EpsHlE6/g0mjax+rt4oDqCdi4VlgU+p4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733229108; c=relaxed/simple;
	bh=trTKcwd/mW36gVx1tz5LMw9YMMboB7Jhk/bMkMWjKjs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Hs7s8P2pXYAzmW5dUgPUVnUaaVod9Xt1Jd6Nra54QgdPKG0stTc4kFC+4YZwnBC1tNtPXwKfr95tFvMPslXYobm22r+/QPPisZxptrpAMpKRKfWgh3G9aw60xTqhvh4jFbWVsZ6ySX5GYTc78iQ46coSma3sDKicyyvde7H3HwE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20241203123146048.VJVY.11752.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Dec 2024 21:31:46 +0900
Date: Tue, 3 Dec 2024 21:31:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the
 queue chain when cleared
Message-Id: <20241203213145.6fff24af965cf988234e87bc@nifty.ne.jp>
In-Reply-To: <20241203211747.926c7428ffd35ac600dc4659@nifty.ne.jp>
References: <20241129114835.14497-1-takashi.yano@nifty.ne.jp>
	<Z03O873ZPfo9akuc@calimero.vinschen.de>
	<20241203211747.926c7428ffd35ac600dc4659@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733229106;
 bh=TJ229Sg3Hs2sQp0Ty/1HK1Hs6pgKtZTv/h6ILdXg4fY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ahJMfJU+sADz36iX7XEOzBejk0nQjll4SjyJZQ8AovcAMwR6r4Xvygn+9hjWdfK1FrB5766k
 oHzytD2SgIXnH59A0AblJSmwLugOfkguNeRQIxTQ2jfjSuLobeilrHcKCwSiSIaUbe49bbfDrj
 FBx4InwVLOE1oisRJoZ9Nh7Llc85wF+DfKRkeRvbiHon1jyh10uItaue7P+or3sTHwSH7s3Gt5
 JmdvkNBrnJTKzLLsWVqybDpiRvqG5T15HkquDhZ2myOtzQTMiGlf58neoHFWESSpbbgcAD0Qu+
 6eem0YyFaW/Xy8eeKgBeo2NeaKcCHxm9rF9GDsJ0pQ0mMKGg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 3 Dec 2024 21:17:47 +0900
Takashi Yano wrote:
> On Mon, 2 Dec 2024 16:14:59 +0100
> Corinna Vinschen wrote:
> > On Nov 29 20:48, Takashi Yano wrote:
> > > The queue is cleaned up by removing the entries having si_signo == 0
> > > while processing the queued signals, however, sipacket::process() may
> > > set si_signo in the queue to 0 of the entry already processed but not
> > > succeed by calling sig_clear(). This patch ensures the sig_clear()
> > > to remove the entry from the queue chain.
> > 
> > Thanks for this patch.  I just have two questions.
> > 
> > > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > > Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
> > > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/local_includes/sigproc.h |  3 +-
> > >  winsup/cygwin/sigproc.cc               | 48 +++++++++++++++++---------
> > >  2 files changed, 34 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
> > > index 46e26db19..8b7062aae 100644
> > > --- a/winsup/cygwin/local_includes/sigproc.h
> > > +++ b/winsup/cygwin/local_includes/sigproc.h
> > > @@ -50,8 +50,9 @@ struct sigpacket
> > >    {
> > >      HANDLE wakeup;
> > >      HANDLE thread_handle;
> > > -    struct sigpacket *next;
> > >    };
> > > +  struct sigpacket *next;
> > > +  struct sigpacket *prev;
> > 
> > The former method using q and qnext ptr didn't need prev.  The question
> > is, why did you add prev?  If you think this has an advantage, even if
> > just better readability, it would be nice to document this in the commit
> > message.
> 
> Consider the queued signal chain is like:
> A->B->C->D
> Assume that now 'q' and 'qnext' ptr points to C and process() is
> processing C. If B is cleared in process(), A->next should be set
> to C.
in clear().

> Then, if process() for C succeeds, C should be removed from
> the queue, so A->next should be set to D. However, now we cannot
> access to A because we do not have the pointer to A.
in while loop in wait_sig().

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
