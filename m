Return-Path: <SRS0=0NVs=7N=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id C63524BA2E1E
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 08:32:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C63524BA2E1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C63524BA2E1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767861137; cv=none;
	b=wmub5N74kdws7mFshaZ+TyijxEFEdRGC56XGaeLISbc72AM7oCDT8D7p9XS3MVBhLBG6r+ThOTDMK2Tngh83EHIIh1GRQ8K7QZWGQg+3H2LmeQ7tBfwDHCLdM8hgERF95qS6JbG3nzcFWr1wk4dLlIyIPB1o04ZHnrLnS3ZGJzo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767861137; c=relaxed/simple;
	bh=/wp33HWtm6KxEuAJIe/VH8ONxNjl1rfcDacYQm40Wow=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=b71LaqNQVLfcNq64WUBQs5R+dMWRKDDd26yBgtsjXObD+OlgA3XXz+6M//VV0OUqLlkUX2MbVMgL7h3nZ9MquqRYS0tJSH6lZgMUf/9O2ts/76ZHCzU42pLrbnFcHj7puMeHCdFrcnUUsTmPDJbiaX83nXOqXzT+ybdWyKuEJlE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C63524BA2E1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=sDYKxdGP
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20260108083214811.XFQE.125258.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 8 Jan 2026 17:32:14 +0900
Date: Thu, 8 Jan 2026 17:32:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: flock deadlock
Message-Id: <20260108173212.b7dacf40c4fe3f2d94c6c234@nifty.ne.jp>
In-Reply-To: <aV465e_t3Agp-uf0@calimero.vinschen.de>
References: <CA+1R0Vg7b7YyvgDf1=or8oxskEX4BJwMJQxxTKYaUHWPQeD9iQ@mail.gmail.com>
	<CA+1R0Vju3VQYaz-s00vCroEV3pH7vBeUhoMGqtUxi0x5k56vpQ@mail.gmail.com>
	<20260103230511.24a6f772323927a141bf595f@nifty.ne.jp>
	<aV465e_t3Agp-uf0@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1767861134;
 bh=HJlVAKJKnEqhLd3WbEtGaYzffbSEU/j9Ahy3hsSeM1k=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=sDYKxdGPb3pgzapP/2Xcz6wj+beQFwkMf6i+SBryaZnmgetapW9bjbyNObybqUZwtCp3Y5G9
 gZYl9EskfHEj8dGV6jY3unvWnQ2wWDMixTY6K/AWy7z3NYGyNWW+dI47RffSOLzobtyqy9ACEj
 iCCQYKCTSH1Lmf8qRVbu2USrIwEbKglPB3CB128ciyEKW0TdNS2PBWIKO0LchFGqhkRreD6HKJ
 g2DW9UpJYKwG2DVe+F3FW+QS6Yu+Yd0DfKDFYj1Blu4B2b9km8B/GRLyV5AiihiQj+5mB32O9v
 AKCfOnVbPi+TnuLcsZjMSeolOcaLkDGhGwRafOMtC32NpkQA==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Thanks for the review.

On Wed, 7 Jan 2026 11:52:21 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Jan  3 23:05, Takashi Yano wrote:
> > On Sun, 28 Dec 2025 11:52:36 -0800
> > Nahor <nahor.j+cygwin@gmail.com> wrote:
> > > Attached is a reproducible example.
> > > The example just calls `fork()` then open/flock/close a directory and
> > > repeats (fork/open/flock/close). The forks optionally sleep then
> > > open/flock/close the same directory and exit.
> > > 
> > > There is no issue if either the parent or the children don't call `flock()`.
> > > Without sleeping, the example deadlocks immediately on my system 100%
> > > of the time. Killing the child allow the parent to proceed, fork the
> > > next child, which triggers the next deadlock.
> > > When sleeping, _sometimes_ one child will deadlock with the parent.
> > > Killing that child allows the parent and remaining children to proceed
> > > (and potentially trigger another deadlock). Killing the parent also
> > > unblocks all the children.
> > 
> > Thanks for the report and the test case.
> > I looked into the issue and found the cause. I also confirmed that
> > the patch attached solves the issue.
> > 
> > Could anyone please review the patch?
> > 
> > -- 
> > Takashi Yano <takashi.yano@nifty.ne.jp>
> 
> > From 5b0a3fac8c6f4f56626d108a2dfa9738f73ecf6b Mon Sep 17 00:00:00 2001
> > From: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Date: Sat, 3 Jan 2026 21:53:36 +0900
> > Subject: [PATCH] Cygwin: close: Do not lock fdtab
> > 
> > Otherwise, a deadlock can occur if the child process attempts to
> > lock a file while the parent process is closing the same file, which
> > is already locked. The deadlock mechanism is as follows.
> > 
> > When the child process attempts to lock a file, it notifies the parent
> > process by calling CreateRemoteThread(), which creates a remote thread
> > in the parent. That thread checks whether the file being locked is
> > currently opened in the parent. During the operation, cygheap->fdtab
> > is temporarily locked in order to enumerate the file descriptors.
> > 
> > However, if the parent process is closing the same file at that moment,
> > it also locks fdtab via cygheap_fdget cfd(fd, true) in __close().
> > If the parent acquires th fdtab lock first, it proceeds to call
> > del_my_locks(), which attempts to lock the inode in inode_t:get().
> > 
> > At this point, the inode is already locked in the child,
> > so the parent waits for the child to release the inode. Meanwhile,
> > the child is waiting to acquire the fdtab lock, which is still held
> > by the parent. As a result, the parent and child become deadlocked.
> > 
> > However, since close_all_files() and close_range() do not lock fdtab,
> 
> close_all_files() is called from _exit(), so there's no reason to lock
> fdtab.  close_range() locks fdtab explicitly right after EINVAL
> handling.
> 
> Since close() is a process manipulating the fdtab, I have a bad feeling
> to perform the action unlocked.  Wouldn't it make more sense to
> enumerate without locking in create_lock_in_parent()?

I agree. I submitted v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
