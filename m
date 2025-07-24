Return-Path: <SRS0=Pspn=2F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id 4EE283858D1E
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 08:35:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4EE283858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4EE283858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753346149; cv=none;
	b=SywvXzObmJaYDGE9a/46PLlVwnyKb0qLTIZlRp5a6YHbvSWB51dmHAJ5/3lgJjGBAXVvs+/EDyuOoFgnLY5OI0C11vcz0GpOLFpl+LncDfJPMOnAimf+wYvZ7uipH7xjbQN8i074729gp/jWgClWl08kf2gH6Sq7zlX8hNaAN1w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753346149; c=relaxed/simple;
	bh=yr7kfEVaEvt5oMtnk4XSLOsyUkI+RMQOmRwOrQ3f3Bw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=voU3SMhtUwczlrQenDvJtu/LLilqnlTxq5NXIUHSeQpSxWKSBaebvWagY63Nj6ZjDWZl2p4ywTPVENGQy/0cIhpLupmXoztA0w3pukYPiQ2YAhQWcm96h/F7fmgWZ1wNmTWD+2woxf13kS4fQG3mGL8n5eNlRBp1gS8JboQs4b8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4EE283858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fjSK2Wuw
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20250724083546101.TQGL.37487.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 17:35:46 +0900
Date: Thu, 24 Jul 2025 17:35:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: process_fd: Fix handling of archetype fhandler
Message-Id: <20250724173544.4749a24ea759fa21a44829f2@nifty.ne.jp>
In-Reply-To: <aIHovtkfg_7GU9Tz@calimero.vinschen.de>
References: <20250722123240.349-1-takashi.yano@nifty.ne.jp>
	<aIClgpTaJ_6khEmq@calimero.vinschen.de>
	<20250723195536.5783866c1683727f0ca49fb1@nifty.ne.jp>
	<aIDbTUeOEM6kSDUh@calimero.vinschen.de>
	<20250724091016.f04b1709e164619f58b21032@nifty.ne.jp>
	<20250724111733.90d0b036a2113af56199dcf9@nifty.ne.jp>
	<aIHovtkfg_7GU9Tz@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753346146;
 bh=tOY0BHeEdpUQ8UnrEZOKrO54TrnVdBmZwOW+i8M3NHI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=fjSK2Wuw9wUGoYQBHWAQrsH42qgOstb6I7XPNwTJ2bTuW+GTqNeIDYBZtdi9mPg0Q+ZBbzOf
 edObnhqeNW2SFJs819yXsTrdOXlsZw/Gg7YrW8ANTOyRpVa2v7sUQcwBzxnkKc7YO6ZDXpUyMB
 fLbSWnQ6RFuBloz3ooIgPbFz6XyaCyuIQWtj7nuNTGUw3r722CmezXmbxe/xgyngk98D9ogMxT
 TaznIhklZ5Qny/DA1w3sGTSDukAXj47BJefBd+GF0hFNSRGwVzRqGH8G6rmlB38QOWUFyZXtjk
 w0T71pwklWePgkEh5s5Xl4DF3GvU9H5Xe/YYWKeP62fSt4bw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 24 Jul 2025 10:03:10 +0200
Corinna Vinschen wrote:
> On Jul 24 11:17, Takashi Yano wrote:
> > On Thu, 24 Jul 2025 09:10:16 +0900
> > Takashi Yano wrote:
> > > On Wed, 23 Jul 2025 14:53:33 +0200
> > > Corinna Vinschen wrote:
> > > > No, wait.  build_fh_name() creates a path_conv instance and that in turn
> > > > is used to call build_fh_pc().  build_fh_pc() calls fh_alloc() and then
> > > > calls fh->set_name (pc) in allmost all scenarios.  This in turn should
> > > > copy pc.path_flags, because the underlying path_conv::<< operator is
> > > > basically a memcpy().
> > > 
> > > In the case use_archetype() is true, fh->set_name(pc) does not seem
> > > to be called.
> > > https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/dtable.cc;h=f1832a1693d45d5fd1e27acb830d5a12a6a34238;hb=HEAD#l683
> > https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/dtable.cc;h=f1832a1693d45d5fd1e27acb830d5a12a6a34238;hb=HEAD#l676
> 
> Ah, right, thank you.  That's what I missed.  I only saw the
> fh->set_name() calls but missed the fact that some of them are not using
> the variation taking a path_conv argument.  D'oh.
> 
> > So, the following patch also fixes the issue.
> > 
> > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > index f1832a169..3b25e9160 100644
> > --- a/winsup/cygwin/dtable.cc
> > +++ b/winsup/cygwin/dtable.cc
> > @@ -674,6 +674,7 @@ build_fh_pc (path_conv& pc)
> >  		    fh->archetype->get_handle ());
> >        if (!fh->get_name ())
> >  	fh->set_name (fh->archetype->dev ().name ());
> > +      fh->pc.set_isopen ();
> 
> I think it's basically the right thing to do, but like this?
> 
>          if (pc->isopen())
> 	   fh->pc.set_isopen ();
> 
> ?

Ah, yes. I'll submit a new patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
