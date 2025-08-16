Return-Path: <SRS0=EPME=24=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 202AB3858D1E
	for <cygwin-patches@cygwin.com>; Sat, 16 Aug 2025 03:16:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 202AB3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 202AB3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755314188; cv=none;
	b=mrE4e9kincdBbwH2ngKRqygyi9TRcN5DnXxsC7dw/kouekVLTNx/qJx5q1JuSNW86TN3BIo+AsXVTR2FDKXj1VZ7SVeNcT1CYW0oPOrZi5J6ZtOMh6Fk8hnjrSEQvfzArxYroMcaumnOBx1I0DtqJvTBMD3+wiOadmjSx3/GAMo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755314188; c=relaxed/simple;
	bh=ecByaQwAwISNyBg2z4XAUsy+2fEbIvnID9pLAZxt75c=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=KtPyZN8Z4QX1NTrDQ1nUqEVVsSdsv5epM59kBuhGWpYTprzJmLYYoGNuFlV4evyLTe9Co5seiU7ym0XP5Kwaw36E9oN/3CCWrLwkHz8Slm+HMczE96yyplZh2YwQ0IiIO6hGM7/XfbQTLG9GJ27on98Z9h86Cg296Z5GiNkPlSg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 202AB3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PKv9PH6q
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20250816031624823.DJEL.78984.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 16 Aug 2025 12:16:24 +0900
Date: Sat, 16 Aug 2025 12:16:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: spawn: Make ch_spwan_local be fully initialized
Message-Id: <20250816121623.b7407924b9ce8c0ab4617894@nifty.ne.jp>
In-Reply-To: <ee1649ac-50bf-df75-b1bf-eabc99336d8f@jdrake.com>
References: <20250815213519.3049-1-takashi.yano@nifty.ne.jp>
	<ee1649ac-50bf-df75-b1bf-eabc99336d8f@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1755314184;
 bh=1KUPrbLeg3ZaBhiQtBEIUMbodc7ScVnf7ZITy5OZKdQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=PKv9PH6qqrBz1hHNufo8q0jidWbCpVwx4Lz4c+poh8SK0gexArPLWHBUrXZR5qtwhXtXGTgC
 WSSGesi7zqjdYpTFizuN7FSEWO/0MF/dmE0Lc3CgqDJlgvIWNtbuThi3E9/BKU4ItEU7SI7kp8
 XJ3z7tn6tG9bwM/aW2urw+Wo3fFRG2Je5YRkYgeLdDOrGdg+CPMUFShRozWcqCeb77rovl8eaf
 i+Si6NKEVC9T6eTxcwRlsXioVw91Zvrsa1W0kjlbxa/3UziDvZvyjgzymheZvwr7RfxRwy4zSP
 iwDBAP4lWq+A41IugMs+qerTRADoxbWRBaoLtlczH2JO9LcQ==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

Thanks for reviewing.

On Fri, 15 Aug 2025 14:46:31 -0700 (PDT)
Jeremy Drake wrote:
> On Sat, 16 Aug 2025, Takashi Yano wrote:
> 
> > The class child_info_spawn has two constructors: one without arguments
> > and one with two arguments. The former does not initialize any members.
> > Commit 1f836c5f7394 used the latter to ensure that the local ch_spawn
> > (i.e., ch_spawn_local) would be properly initialized. However, this was
> > insufficient - it initialized only the base child_info members, not the
> > fields specific to child_info_spawn. This led to the issue reported in
> > https://cygwin.com/pipermail/cygwin/2025-August/258660.html.
> >
> > This patch updates the former constructor to properly initialize all
> > member variables and switches ch_spawn_local to use it.
> >
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258660.html
> > Fixes: 1f836c5f7394 ("Cygwin: spawn: Make system() thread-safe")
> > Reported-by: Denis Excoffier <cygwin@Denis-Excoffier.org>
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/local_includes/child_info.h | 4 +++-
> >  winsup/cygwin/spawn.cc                    | 2 +-
> >  winsup/cygwin/syscalls.cc                 | 2 +-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
> > index 2da62ffaa..e359d3645 100644
> > --- a/winsup/cygwin/local_includes/child_info.h
> > +++ b/winsup/cygwin/local_includes/child_info.h
> > @@ -148,7 +148,9 @@ public:
> >    char filler[4];
> >
> >    void cleanup ();
> > -  child_info_spawn () {};
> > +  child_info_spawn () : child_info (sizeof *this, _CH_NADA, false),
> > +    hExeced (NULL), ev (NULL), sem (NULL), cygpid (0),
> > +    moreinfo (NULL), __stdin (0), __stdout (0) {};
> >    child_info_spawn (child_info_types, bool);
> >    void record_children ();
> >    void reattach_children ();
> 
> Making a change to the child_info* classes will require updating the
> "magic" define in that header.

Done.

> Do we really need to initialize all of the members?  It seems like most of
> them would be written during child_info_spawn::worker.  I expect sem to be
> an exception.  I guess it doesn't hurt.

Yeah, indeed. 'sem' is used only for _P_OVERLAY, so spawnve() and popen()
are not be affected. Only 'ev' is referred in child_info_spawn::cleanup()
without initialization. So, we need to initialize only ev, I think.

I'll submit v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
