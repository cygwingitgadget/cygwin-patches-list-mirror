Return-Path: <SRS0=STBq=SO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id D5C023858D21
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 10:13:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D5C023858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D5C023858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732011186; cv=none;
	b=TspXqt0SLNQKgSh9DMTO2EYgYDh54s/lQVM0HCN0E32odQwBj7CBXSbX5OLazA27m9Q+vDEJPKb4+f5SzzmH6QZFU5plrbTgAEp6LcLjNGYFl5Eu+LjDgrxe/nPfBm/WIU095nRCK4Lst8i5nUFVQ1fpdD1zKgi6I6SmmMj3NwY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732011186; c=relaxed/simple;
	bh=Sp6m49PlU5it2FyHBmxG4fxPDgm4E2f7bN+yYR99Smw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=SEhN6yhLnCI1HrwWAlqVwFqhm1iC/rDaKRSbq7rj9fLQ0iAv2Q57Fjjdz8psIm8dH4tKBKmN7gonSnCqBKcPhbeJlBl69X5Eroi1J4It3oRA+nQwSrLh0E/FlO+9idc6T9rXoxprLZWPs8xJG3c3Wq7TGqqs0dCgVgHQ1XpDFlk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D5C023858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MWtumf4W
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20241119101303328.BAYP.84424.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 19:13:03 +0900
Date: Tue, 19 Nov 2024 19:13:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: lockf: Fix access violation in
 lf_clearlock().
Message-Id: <20241119191302.9dea6a8aabb69727cdd3feb8@nifty.ne.jp>
In-Reply-To: <ZzxfM9T2uy5Bdiao@calimero.vinschen.de>
References: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
	<20241115131422.2066-2-takashi.yano@nifty.ne.jp>
	<ZztjYs4Cu28xZgtl@calimero.vinschen.de>
	<20241119173939.5ba0cb14459b3da22d226262@nifty.ne.jp>
	<ZzxfM9T2uy5Bdiao@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732011183;
 bh=jtuZSoY2tAVN3T53YnuyOiQp8f1hNDfD5Tec2nvkDV8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=MWtumf4WzIMKZDdvTZV+AqXOYcdSJSFr6bSTao0K5WPpisePRVRv6MoX0b4VBURXbJ7h0q/w
 8Av2wmxfjNEWFP4th9UyjM+UnJXE2p7l7qZB51fd1uB5B9h7WadlF/3UTLJq/dq8GBaR6qqP28
 p0M+JQRxBBxjSJ362l+/x4C/5hn24ReESd/65eaI75QKv9iNVXA/ym+oCw74S9oqsDl9tAQsxk
 +XfbpGM2orVnkOmVVrcEZnfq4LLKg7SM6+IdlzRxLsz0MwYAk4wnctBSpRGwfy5jxxWSQgq5kk
 U6vqhI//uWkoAnr7PESM/2NSlA/a+9PSUefbGIetSJcrMBYg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 19 Nov 2024 10:49:39 +0100
Corinna Vinschen wrote:
> On Nov 19 17:39, Takashi Yano wrote:
> > On Mon, 18 Nov 2024 16:55:14 +0100
> > Corinna Vinschen wrote:
> > > On Nov 15 22:14, Takashi Yano wrote:
> > > > The commit ae181b0ff122 has a bug that the pointer is referred bofore
> > > > NULL check in the function lf_clearlock(). This patch fixes that.
> > > > 
> > > > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256750.html
> > > > Fixes: ae181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too many locks")
> > > > Reported-by: Sebastian Feld <sebastian.n.feld@gmail.com>
> > > > Reviewed-by:
> > > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > > ---
> > > >  winsup/cygwin/flock.cc | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> > > > index 3821bddd6..794e66bd7 100644
> > > > --- a/winsup/cygwin/flock.cc
> > > > +++ b/winsup/cygwin/flock.cc
> > > > @@ -1524,6 +1524,10 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
> > > >    lockf_t *lf = *head;
> > > >    lockf_t *overlap, **prev;
> > > >    int ovcase;
> > > > +
> > > > +  if (lf == NOLOCKF)
> > > > +    return 0;
> > > > +
> > > >    inode_t *node = lf->lf_inode;
> > > >    tmp_pathbuf tp;
> > > >    node->i_all_lf = (lockf_t *) tp.w_get ();
> > > > @@ -1531,8 +1535,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
> > > >    uint32_t lock_cnt = node->get_lock_count ();
> > > >    bool first_loop = true;
> > > >  
> > > > -  if (lf == NOLOCKF)
> > > > -    return 0;
> > > >    prev = head;
> > > >    while ((ovcase = lf_findoverlap (lf, unlock, SELF, &prev, &overlap)))
> > > >      {
> > > > -- 
> > > > 2.45.1
> > > 
> > > LGTM, please push.
> > 
> > Thanks for reviewing this patch. Could you please review
> >  [PATCH v2] Cygwin: flock: Fix overlap handling in lf_setlock() and lf_clearlock()
> > as well?
> 
> Give me a bit of time.  While the patch might fix the problem, what
> bugs me is the deviation from upstream code.  We will at least need
> a few comments to explain why we don't follow the upstream behaviour.

I've got it. Does this code come from 'upstream'? From what code?
Essentially, the ovcase 1 can be a part of ovcase 3. I guess the
'upstream' does not add lock entry having same lock range unlike
current cygwin (lf_ver related). So, ovcase 1 can break after
handling 1 overlap. However, we need find overlap repeatedly
because we have lf_ver.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
