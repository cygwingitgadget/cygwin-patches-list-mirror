Return-Path: <SRS0=LDpO=F4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 4A1584BA2E12
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 10:54:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A1584BA2E12
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A1584BA2E12
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785754487; cv=none;
	b=scdWMyI12HKxCXoV7K2NauxcjrVE7s/jZnzssxF+OJSP3G2yNgQqDr6+HEdNH6n8VqR5caaQaVR6dzah+Bib08hT8qeTjXyiwHHjHeZKMtmG8TTcLSugy6iMDXXUHk9AnwlZ9GxqeK4i6zIJOITbTtfMkEiLSlud9P+VlZ8EK/o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785754487; c=relaxed/simple;
	bh=a5kCtpbFxjahlU0VCNUMI4DA03nMtlW7S3FhuCbdSKU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=cvMoS3n2Boq1gGCmDJQdKkMCW35DNa2CfJm/fvKPmSP9L7So8LduMnlMGtYq2/KMHAGitoxUpWcU6k/Ub5MNnoUyOR7Hzg+cm7JmNHkA35t0BXpr2aztKFBzYnF4oLw6cmRTuEBac6DZELaSR6ZWidS7z391KgA32/g7Aiv9TyM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=HQFNdBqQ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A1584BA2E12
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=HQFNdBqQ
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260803105445065.ZTOH.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 3 Aug 2026 19:54:45 +0900
Date: Mon, 3 Aug 2026 19:54:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
Message-Id: <20260803195443.2ef79fe1f505267789e9e12e@nifty.ne.jp>
In-Reply-To: <6d404942-f6c1-6c4d-9915-a359c1f196f5@gmx.de>
References: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
	<bccbac3b-78e9-67d3-2a92-30986f6ff9b6@gmx.de>
	<20260722201012.8403bbf6045b2fb041af985b@nifty.ne.jp>
	<20260722215641.e9aad82023614cea4e1aec63@nifty.ne.jp>
	<6d404942-f6c1-6c4d-9915-a359c1f196f5@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1785754485;
 bh=Qz1cPwUuPHjc7Zbr26KR7vyWWN1W3+rDmCyPabMZ45Y=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=HQFNdBqQvaTuqZV6acifhLEnShuAzh8V5cbue6R/xQRGxHY1jf2T1R2GNIDY0RpDr2Od6Q37
 fEvbGwXUqHElklAbl1Ohexjl8tzMqHx8pckSxok30Nx825wUh0Twwebf/YfMz/2ei7gviEF6NR
 GMAfsBsJ9FEbMjLldFVRkYdNNFbi41vfNciG3eRtQGRQ65lCMtUXkZ4mFIKCxx/gQH08/UfjIb
 4A1Y0aYhJakj30+8n/58hf9Ez8FZEvRguxdY7zyhiHZjAl53FLHRZD52xg6eSvbdP1L4Wm4rO5
 95VGZAUgATtCwWFk/5+rhaFjpIH1B2BbYx0tBh8utcpBvDJg==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Wed, 22 Jul 2026 22:29:44 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for trying the experiment so quickly. To answer your closing
> question first: yes, both outputs are exactly what a correct fix should
> produce. Let me walk through why, and then flag two caveats about the
> reserved-marker design before we build it out.
> 
> On Wed, 22 Jul 2026, Takashi Yano wrote:
> 
> > On Wed, 22 Jul 2026 20:10:12 +0900
> > Takashi Yano wrote:
> > > Hi Johannes,
> > > 
> > > Thanks for reviewing!
> > > 
> > > On Tue, 21 Jul 2026 19:16:11 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > > This is the first point where the slot and its reference count agree
> > > > again; Too late for anything that looked in between. And the cleanup only
> > > > runs for non-negative descriptors, so it never covers the case above.
> > > > 
> > > > Since it is already in `master`, a follow-up patch probably makes most
> > > > sense. Two things to fix: release the lock when no descriptor is
> > > > available, and stop a reserved-but-not-yet-open descriptor from looking
> > > > like a fully open one to the rest of the fdtable. Reviving the old integer
> > > > marker would mean teaching every consumer of the table about it, so it is
> > > > not a drop-in.
> > > 
> > > Ah, I got it. The user program cannot know that, but cygwin1.dll can
> > > refere fdtab inside it. What about adding reserved flag to fdtab?
> 
> Adding a reserved marker is the right approach, and it is what I had in
> mind too. Keeping the reserved slot hidden from the rest of the table lets
> `open()` remain the sole owner of the handler and delete it on any error
> path, including the `FH_PROCESSFD` reopen, without any reference-count
> juggling.
> 
> The first caveat, and the bigger one: this is not a drop-in change. Every
> place that treats a non-NULL slot as a live handler has to learn to skip
> the reserved marker. Besides `cygheap_fdget`, that includes
> `cygheap_fdenum::next`, `not_open`, and the five fork/exec fixup loops
> (`set_file_pointers_for_exec`, `fixup_after_exec`, `fixup_after_fork`,
> `fixup_before_fork`, and `fixup_before_exec`). If a fork or exec runs on
> another thread while a FIFO open is still holding the reservation, those
> loops would dereference the marker.
> 
> To keep that safe, I would encode the marker as a single distinguished
> pointer value stored in the slot itself, rather than as a separate flag.
> Then the lock-free `cygheap_fdget` keeps working with one added
> comparison, and there is no risk of a torn read.
> 
> > 
> > I tried it as quick experiment.
> > 
> > The result of the first reproducer is:
> > baseline close(-1): result=-1 errno=9
> > descriptor allocation stopped after 3197 opens: errno=24
> > second-thread close(-1): result=-1 errno=9
> 
> The decisive line here is the second thread's `close(-1)` returning
> `EBADF` (errno 9) instead of blocking. That is the proof that the table
> lock is no longer held when no descriptor is available; before the fix,
> the second thread would have waited forever on the process-wide lock. The
> allocation stopping after 3197 opens with `EMFILE` (errno 24) is right as
> well: that is `OPEN_MAX` (3200, spelled `__OPEN_MAX` in the headers) minus
> the three standard descriptors, so the ceiling is reached cleanly.
> 
> > The result of the second reproducer is:
> > expected FIFO writer descriptor: 4
> > provisional descriptor query: result=-1 writer_done=0
> 
> This one is exactly right too. The writer taking descriptor 4 is just the
> expected setup; the line that matters is the provisional-descriptor query,
> which returns -1 (`EBADF`) with `writer_done` still 0 while the FIFO open
> is still blocked waiting for the other end. The reserved descriptor now
> reports a bad descriptor instead of triggering the access violation
> (status 0xC0000005) I saw before, where `cygheap_fdget` raised the
> reference count from zero to one and its destructor then lowered it back
> to zero and deleted the handler while `open()` was still blocked inside
> `open_with_arch()`.
> 
> > Are these results as you expected?
> 
> Yes, as detailed above. The second caveat is about coverage: the two
> reproducers drive `close()` and the descriptor lookup on a single known
> number, but not the paths that walk the whole table. `close_range` is the
> clearest of those. It iterates every descriptor in the range and looks
> each one up, so it reaches a reserved slot without ever being told its
> number. That, incidentally, answers the question you raised earlier about
> how the racing thread could reference a descriptor that `open()` has not
> returned yet: it does not _have_ to. The internal iterators reach the slot
> regardless. A `close_range` call and a fork or exec, each racing an
> in-flight open, would exercise the paths the current reproducers miss.
> 
> Independently of all that, the lock-leak fix stands on its own and is
> trivial, namely releasing the table lock when no descriptor is available,
> so it could land first as a separate commit while we work out the marker
> design.

I implemented two different ways, one uses independent reserved flag,
the other uses special value ((fhandler_base *) -1) as a reservation
marker.

I'll submit both patches, so please review the one you think is the
better approach.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
