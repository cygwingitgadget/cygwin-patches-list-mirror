Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id A3D724BB58CD
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 21:34:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A3D724BB58CD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A3D724BB58CD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774474449; cv=none;
	b=rvVNeDf6/OwmzRAcn0Vf7NMedj3xg5p+AwIbhy0bPJC08uHd4CQ1IBkaQTEsoDw85GBpD1wugj8AjWQ8rxWaf5uYH6aTMvPVn9XFnouJ5Ap8JvC6YonpvXl6e7cQjicZrL0Fcsj2c7/OrrFCgVGcpeV88E7lzqmh6+GSKPxVR2M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774474449; c=relaxed/simple;
	bh=ZLVzNLQb99bawVyo0CzQ2QrWxOMtgyzRNxgS+t/p1+c=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=PD6YDdSjgTDDy0mXQkYm0Oo5vuBAwLnkKheC04MCLHjkgrnbnRL9op7l2goQZF2UTxfAdZtFyosoeaHXQK7upDYJ6SAZBQ9orZCTxC18laWSGHNbWJweuMVYdkShDoKXYXwXOVV1D+7MPg5Y00tP9UGWJ5mePy8ikhWsbtQjgNM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A3D724BB58CD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IvPPT6b0
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260325213406679.HFRM.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Mar 2026 06:34:06 +0900
Date: Thu, 26 Mar 2026 06:34:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Clear discard_input flag on master write()
Message-Id: <20260326063405.daa61e4a675abc74fcc88ede@nifty.ne.jp>
In-Reply-To: <acQ2VPnZkh2TSNNd@calimero.vinschen.de>
References: <20260325130734.65955-1-takashi.yano@nifty.ne.jp>
	<acQ2VPnZkh2TSNNd@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774474446;
 bh=P2OGrQ2S4OrwlTI1A+Zt08caejV3+UNpiO2geUkF3rM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=IvPPT6b0m5waCue5xhh3p0m0RC2ViFr9LxmNq8IyhvGfzv9DvjRZ2Cjp8KIYU2x5cDGLRuR4
 ILk/QL4TJzrkIglng4eoxuzU5sH0DLaa1WYcsJv76Gjx1OlS2A/rCY1Zq66Be+Wky8l1jX7zIL
 rtNCobNOk1GPWNHQveoCPzUewgTQTX0iGILbi/T7EEu55UH6/WawaYPNSHhvwMQKSB4AThySbM
 GkTL950W97iuao8UZJ3QO8XTYQWTqsOCcFr8pj2bK43W55M3M0cZFSwos+W0cm8SGLHa8rMKL0
 OWsAu6FZDOzNF+ETUXr/uEqR6T4IeMrnyfxWeMn/5JDwIWhQ==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Mar 2026 20:24:04 +0100
Corinna Vinschen wrote:
> On Mar 25 22:07, Takashi Yano wrote:
> > Currently, the first transfer_input() after Ctrl-C does not work
> > because discard_input flag remains asserted. This can cause loosing
> > typeahead input for non-cygwin app after Ctrl-C. With this patch,
> > the discard_input flag is cleared on master write() because the
> > input is new valid input after discarding input.
> > 
> > Fixes: 4e16e575db04 ("Cygwin: pty: Discard input already accepted on interrupt.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 0c50e50f5..c05462d1f 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2224,6 +2224,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >  
> >    push_process_state process_state (PID_TTYOU);
> >  
> > +  get_ttyp ()->discard_input = false;
> > +
> >    if (get_ttyp ()->pcon_start)
> >      { /* Reaches here when pseudo console initialization is on going. */
> >        /* Pseudo condole support uses "CSI6n" to get cursor position.
> > -- 
> > 2.51.0
> 
> LGTM.

Thanks for reviewing. Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
