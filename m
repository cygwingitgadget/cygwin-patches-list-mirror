Return-Path: <SRS0=s/oq=S7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 11DA23858D21
	for <cygwin-patches@cygwin.com>; Fri,  6 Dec 2024 10:24:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 11DA23858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 11DA23858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733480661; cv=none;
	b=MMG7UGPo4o1W03zNEhcNH+8qbozyhinY02lUo/BTju5h56sizVLhxs4hMu6JyKFEfF35ZcLR6bBCgp7Z++Lz+pqAEHdEXh9/IKey8/pvxnLT1ZheLwKiWxUoGiTgqAt7XwN3yAyQxBs1UrY5JP7bvNFkZvCOsYPXyhWYE97PnYk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733480661; c=relaxed/simple;
	bh=4l6vJ4yA6s22qch7Ehm/XfVD47dX1vDCWA7i/lKoeBM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=mbnhoqxlkDX3F39evp8NZBrBXDrJKpy/zmfFdTJozXV4C/cULWO5oci67Mp09j9agME4i1EZRhzyDxi5jGwIkzGQqBDilaBLogPbNONYmJ/kI2rgCrXocXH4j+nZL/SHC+63rjHxNTV9sKnmn1zFvS+aoH/At5BA7sQtq5vJ9nA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 11DA23858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=md01YODG
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20241206102417922.HNJM.81160.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 6 Dec 2024 19:24:17 +0900
Date: Fri, 6 Dec 2024 19:24:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Signal patches still necessary
Message-Id: <20241206192417.29148292fad69234b0661c37@nifty.ne.jp>
In-Reply-To: <Z1G4fGj7kM0arCJx@calimero.vinschen.de>
References: <20241205122604.939-1-takashi.yano@nifty.ne.jp>
	<Z1G4fGj7kM0arCJx@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733480657;
 bh=cDciLOffN96x23KrGnNPelzQHJkMG1i+ewryPjkKRxA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=md01YODG1m7c0PGj2WRowzN0bErudxeFB/2nQd/UN3y/rLIxSz9CdixzBlh7nfKjxAM5N+n+
 3n9r9K3LhUXOTc0ri5xmMuC17e6+CvgDPc+4+J9+UyZ1sIK3b9YE/Nw00OVjaa21RsCO5MzQgg
 fAl0wWzlbmpAqVLfxFriqCAC7g2ZCs4S27koTcGxegNZwW3sarpOKyVP8Gtmq36SzmrwrpYNzw
 QBoA8Cy161z3y5R05qZoT8csmSCkMQSrV/JsMNOLJfW+xgKHlwDzUHhDmBskGX1sF6tlkB7Cmm
 skNcte9sL0JWqrcUXkgjvKoYZ5pfYJ0Y24Qfhl1cZ0gRQicg==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 5 Dec 2024 15:28:12 +0100
Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:

> On Dec  5 21:25, Takashi Yano wrote:
> > Takashi Yano (3):
> >   Cygwin: signal: Remove queue entry from the queue chain when cleared
> >   Cygwin: signal: Introduce a lock for the signal queue
> >   Cygwin: Document several fixes for signal handling in release note
> > 
> >  winsup/cygwin/exceptions.cc            | 12 ++---
> >  winsup/cygwin/local_includes/sigproc.h |  5 +-
> >  winsup/cygwin/release/3.5.5            |  4 ++
> >  winsup/cygwin/signal.cc                |  4 +-
> >  winsup/cygwin/sigproc.cc               | 72 +++++++++++++++++++-------
> >  5 files changed, 68 insertions(+), 29 deletions(-)
> > 
> > -- 
> > 2.45.1
> 
> LGTM.

Thanks! Pushd.

IIRC, the patches that should be cherry-picked for cygwin-3_5-branch are:
d243e51ef1d3 Cygwin: signal: Fix deadlock between main thread and sig thread
e10f822a2b39 Cygwin: signal: Handle queued signal without explicit __SIGFLUSH
57ce5f1e0bf4 Cygwin: signal: Drop unnecessary queue flush
9ae51bcc51a7 Cygwin: signal: Fix another deadlock between main and sig thread
9b7a84d24aa1 Cygwin: cygtls: Prompt system to switch tasks explicitly in lock()
2544e753963e Cygwin: signal: Fix a short period of deadlock
9a274a967d1f Cygwin: signal: Optimize the priority of the sig thread
c48d58d838d9 Cygwin: signal: Increase chance of handling signal in main thread
d565aca46f06 Cygwin: signal: Remove queue entry from the queue chain when cleared
496fa7b2ce00 Cygwin: signal: Introduce a lock for the signal queue
cfadd852aa57 Cygwin: Document several fixes for signal handling in release note
as well as your patches regarding longjmp.

Renaming sig to current_sig is not a bug fix, bug without this patch,
we should modify patches manually.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
