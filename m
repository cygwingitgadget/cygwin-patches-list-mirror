Return-Path: <SRS0=jZxs=FQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id F04204BA2E0B
	for <cygwin-patches@cygwin.com>; Wed, 22 Jul 2026 20:29:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F04204BA2E0B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F04204BA2E0B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784752193; cv=none;
	b=FXl8RLxE1yXYCrlZ9rJ1MKqKAnS8OBF020BEbQaN1savw674uyIUM8ZyhIUd/f3Nc01wih2hH6zEXcSy0OjDCqaU2XJlfEJgiKnhZYLoThtUKWB5sPFwCvKRba4V+3NrcKRYOpdfMdvvA3Xqye5DCJywW+tTU2m2IEGrIVu1cIc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784752193; c=relaxed/simple;
	bh=mUE/HDrXsAOUXqiJd7rTpUOkSBtoYiim3b7Y521dKL0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=FLYO4m98vn7/KmSPDE2UCV9Pg3EIlK1ytw5AdXdebtFEoKZ+KsNI4RBTYIIDmDVj8AbG5Y3YVh5RixXRpsLQDJ4I0XXajQ8oJlhxo/PVmL2+G7q0gEV39i5ZAuPNwquQsds8GTYhJF7gmwII+iO7gwvAUWKDVywYSDsKKP6w5CI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=SQcVvukd
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F04204BA2E0B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=SQcVvukd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784752185; x=1785356985;
	i=johannes.schindelin@gmx.de;
	bh=mUE/HDrXsAOUXqiJd7rTpUOkSBtoYiim3b7Y521dKL0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SQcVvukd5T0s2tto827D0N+JlXgqwglmlU82qSuwwL3l4QuJcRfjIp4oBBlS38FH
	 wukggeQXNEksefFnGOBt/xh/hwvq7CJIAJ3RIEarBL/Qo6fWtvIGp/xlDCa+cnqSf
	 B3DKh53ZUmb2XTArI3HT1OEn0udVjeRjlyQO6B6/1zF0oH6aIgbxJjuPu/aQaHwZa
	 /42ShRp8++HxMLEMSkCoDVJyHImOA9G1Bc0HBKPePUKMJnEPfTjdAT97jQ7nWTWFD
	 AfoyY/xvPQvDnwL+vAF/wa1EsugF0JaZG2OctsqLnMLBQ3/7ah8FYjjW60CRXa4Bp
	 YIx/A8G269bc8znStw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1wS4Za2fG3-00IH1v; Wed, 22
 Jul 2026 22:29:45 +0200
Date: Wed, 22 Jul 2026 22:29:44 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
In-Reply-To: <20260722215641.e9aad82023614cea4e1aec63@nifty.ne.jp>
Message-ID: <6d404942-f6c1-6c4d-9915-a359c1f196f5@gmx.de>
References: <20260717031021.1537-1-takashi.yano@nifty.ne.jp> <bccbac3b-78e9-67d3-2a92-30986f6ff9b6@gmx.de> <20260722201012.8403bbf6045b2fb041af985b@nifty.ne.jp> <20260722215641.e9aad82023614cea4e1aec63@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:GdQPlG/frdeQ4jdgJJmHM3qeUi9+9cJZec0okzzpKUlyegsas6B
 oiwbfl1g1XY7lvGUDGEN/LKRiQ9gs2jrv7pKa/kLiG3FlLjJCHz85tff+0DXZbxSBqucz5+
 2RaVNPW5yrdhktmAvOHRtYGeuivEE4VeU924ZE6H3/2cSUDsYc1q5Uk7SgsySytcv6gFfMZ
 zDynWw1dOZ/EwF42XVtEQ==
UI-OutboundReport: notjunk:1;M01:P0:/M0K3n4VZrs=;HRG3phzCxPpIHxml4Sm+zrht1W8
 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
 Wq0sDVcuzXA1Rmv2YinwW
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for trying the experiment so quickly. To answer your closing
question first: yes, both outputs are exactly what a correct fix should
produce. Let me walk through why, and then flag two caveats about the
reserved-marker design before we build it out.

On Wed, 22 Jul 2026, Takashi Yano wrote:

> On Wed, 22 Jul 2026 20:10:12 +0900
> Takashi Yano wrote:
> > Hi Johannes,
> >=20
> > Thanks for reviewing!
> >=20
> > On Tue, 21 Jul 2026 19:16:11 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > This is the first point where the slot and its reference count agree
> > > again; Too late for anything that looked in between. And the cleanup=
 only
> > > runs for non-negative descriptors, so it never covers the case above=
.
> > >=20
> > > Since it is already in `master`, a follow-up patch probably makes mo=
st
> > > sense. Two things to fix: release the lock when no descriptor is
> > > available, and stop a reserved-but-not-yet-open descriptor from look=
ing
> > > like a fully open one to the rest of the fdtable. Reviving the old i=
nteger
> > > marker would mean teaching every consumer of the table about it, so =
it is
> > > not a drop-in.
> >=20
> > Ah, I got it. The user program cannot know that, but cygwin1.dll can
> > refere fdtab inside it. What about adding reserved flag to fdtab?

Adding a reserved marker is the right approach, and it is what I had in
mind too. Keeping the reserved slot hidden from the rest of the table lets
`open()` remain the sole owner of the handler and delete it on any error
path, including the `FH_PROCESSFD` reopen, without any reference-count
juggling.

The first caveat, and the bigger one: this is not a drop-in change. Every
place that treats a non-NULL slot as a live handler has to learn to skip
the reserved marker. Besides `cygheap_fdget`, that includes
`cygheap_fdenum::next`, `not_open`, and the five fork/exec fixup loops
(`set_file_pointers_for_exec`, `fixup_after_exec`, `fixup_after_fork`,
`fixup_before_fork`, and `fixup_before_exec`). If a fork or exec runs on
another thread while a FIFO open is still holding the reservation, those
loops would dereference the marker.

To keep that safe, I would encode the marker as a single distinguished
pointer value stored in the slot itself, rather than as a separate flag.
Then the lock-free `cygheap_fdget` keeps working with one added
comparison, and there is no risk of a torn read.

>=20
> I tried it as quick experiment.
>=20
> The result of the first reproducer is:
> baseline close(-1): result=3D-1 errno=3D9
> descriptor allocation stopped after 3197 opens: errno=3D24
> second-thread close(-1): result=3D-1 errno=3D9

The decisive line here is the second thread's `close(-1)` returning
`EBADF` (errno 9) instead of blocking. That is the proof that the table
lock is no longer held when no descriptor is available; before the fix,
the second thread would have waited forever on the process-wide lock. The
allocation stopping after 3197 opens with `EMFILE` (errno 24) is right as
well: that is `OPEN_MAX` (3200, spelled `__OPEN_MAX` in the headers) minus
the three standard descriptors, so the ceiling is reached cleanly.

> The result of the second reproducer is:
> expected FIFO writer descriptor: 4
> provisional descriptor query: result=3D-1 writer_done=3D0

This one is exactly right too. The writer taking descriptor 4 is just the
expected setup; the line that matters is the provisional-descriptor query,
which returns -1 (`EBADF`) with `writer_done` still 0 while the FIFO open
is still blocked waiting for the other end. The reserved descriptor now
reports a bad descriptor instead of triggering the access violation
(status 0xC0000005) I saw before, where `cygheap_fdget` raised the
reference count from zero to one and its destructor then lowered it back
to zero and deleted the handler while `open()` was still blocked inside
`open_with_arch()`.

> Are these results as you expected?

Yes, as detailed above. The second caveat is about coverage: the two
reproducers drive `close()` and the descriptor lookup on a single known
number, but not the paths that walk the whole table. `close_range` is the
clearest of those. It iterates every descriptor in the range and looks
each one up, so it reaches a reserved slot without ever being told its
number. That, incidentally, answers the question you raised earlier about
how the racing thread could reference a descriptor that `open()` has not
returned yet: it does not _have_ to. The internal iterators reach the slot
regardless. A `close_range` call and a fork or exec, each racing an
in-flight open, would exercise the paths the current reproducers miss.

Independently of all that, the lock-leak fix stands on its own and is
trivial, namely releasing the table lock when no descriptor is available,
so it could land first as a separate commit while we work out the marker
design.

Ciao,
Johannes
