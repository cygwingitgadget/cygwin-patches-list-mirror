Return-Path: <SRS0=iCjl=ZJ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 6EDDA385626D
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 15:22:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6EDDA385626D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6EDDA385626D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750951334; cv=none;
	b=j6/PZZAc905S/YfS2VfHFPz/X2ZGamc8ei3+8E+WY5xk2nXEph0wsQeqHwx0ckGxMZ17PuvIHBadpu9THSn5Pk1IG9lAUfV8Yii4S9pr3x/Qzfk4syivEQ8H/QTyXANJrGfG2XSq1giZm0RQbDIWKbVkSOKV4eu7L/cvc3KdJIM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750951334; c=relaxed/simple;
	bh=Q+jQn4mXGqhkhst+Awvbsjg80/2+mj+dcoy9dd/w5Kw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=G2GBPtSB+hnglouDs50QOux3XJlGSoXKFC9GmtXFp9TRgeqfqhcbQL1lM6a5qDDfKg915+k6atM1kVhXKCK9E9wC6Lu8CeWiCcjGH2VdhbZQvpeICCp+4hXUqjoRxur4RagNLhbE0YdRaA8mbel9zbV28yHKqmXCrxHx2aVFhQU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6EDDA385626D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ssq8LuwB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750951327; x=1751556127;
	i=johannes.schindelin@gmx.de;
	bh=pYNILdkdpXgfP8CH72qMvDuLR660T36QN1bXP3/Gw0I=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ssq8LuwBoA1oG4TnJ2SNeDKQHjEvUt/BjexhPvMUF266cFLGC/FYl1DUerMnNGt7
	 C5Wf0mLOfVFCyjkzGzD7OWagOKUp4P6LnQ7GUmBgP6w09cu0FcPTpNnmRjOnhmF/9
	 CKY1/dMgY49qVx5mx+BE4GDELGgFtB++/P9HGBYOOJyqvq3+0tS9t/Ksj271Cl+gg
	 rF9oze4MsyTLvFxVkk1HnxRv02nbqu1sVGF8RuBjJBbDEGi1euHNTmqQn6u8ez8ty
	 gpsYQw8P3i6LwDJAhseLwDKz1Zi0zrdqqaijvc8V/Fn1CciO9EE2QZNCRdkXyFbwV
	 0uWZQ8z92YBoGfWP9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1usmGc21nN-010HrP; Thu, 26
 Jun 2025 17:22:07 +0200
Date: Thu, 26 Jun 2025 17:22:05 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pipe: Simplify raw_write() a bit (stop to
 use chunk)
In-Reply-To: <20250626143723.760e7bfdea7ca71e7f53faaf@nifty.ne.jp>
Message-ID: <1c824617-b7df-83ba-0616-d1430d3388be@gmx.de>
References: <20250625114202.927-1-takashi.yano@nifty.ne.jp> <db956baa-e4e1-68cb-e5b2-349a113c7654@gmx.de> <20250626143723.760e7bfdea7ca71e7f53faaf@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8PW5ezeI6MblAzBfPxNm1/lbrwQ8YW9UgrqWmedHblGdeLjM2C0
 BfQsFZ4G52xVImoitG6U2BoZ2NrHOglzSQAk++pA3TNJJXEjYkjFmTcYn7TqKoROnSQFdCA
 8CVjBhJJVJ4+Eko1HTSWhe1mon7OD1doRkWhrak9F/l+7Cqa+nikvjcTGzWLHQgiC2h1/zl
 c69EE4pNogWDsKWysLT7Q==
UI-OutboundReport: notjunk:1;M01:P0:paoWQApyJiw=;s7z/okINvS9urBgO0SHEffXPgT5
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 26 Jun 2025, Takashi Yano wrote:

> On Wed, 25 Jun 2025 14:55:35 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > On Wed, 25 Jun 2025, Takashi Yano wrote:
> >=20
> > > Reviewed-by:
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> >=20
> > This is way too terse. There is a difference between being succinct an=
d
> > leaving things unsaid.
> >=20
> > Also, please make sure that v2 is a reply to v1 of the patch. I almost
> > commented on v1 by mistake.
> >=20
> > > ---
> > >  winsup/cygwin/fhandler/pipe.cc | 10 ++--------
> > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler=
/pipe.cc
> > > index e35d523bb..c35411abf 100644
> > > --- a/winsup/cygwin/fhandler/pipe.cc
> > > +++ b/winsup/cygwin/fhandler/pipe.cc
> > > @@ -443,7 +443,6 @@ ssize_t
> > >  fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> > >  {
> > >    size_t nbytes =3D 0;
> > > -  ULONG chunk;
> >=20
> > Okay, removing this local variable is a good indicator that this diff
> > shows all the related logic, without having to resort to looking at th=
e
> > entire `pipe.cc` file that is not reproduced in this email.
> >=20
> > >    NTSTATUS status =3D STATUS_SUCCESS;
> > >    IO_STATUS_BLOCK io;
> > >    HANDLE evt;
> > > @@ -540,11 +539,6 @@ fhandler_pipe_fifo::raw_write (const void *ptr,=
 size_t len)
> > >  	}
> > >      }
> > > =20
> > > -  if (len <=3D (size_t) avail)
> > > -    chunk =3D len;
> > > -  else
> > > -    chunk =3D avail;
> > > -
> > >    if (!(evt =3D CreateEvent (NULL, false, false, NULL)))
> > >      {
> > >        __seterrno ();
> > > @@ -561,8 +555,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, =
size_t len)
> > >        ULONG len1;
> > >        DWORD waitret =3D WAIT_OBJECT_0;
> > > =20
> > > -      if (left > chunk && !is_nonblocking ())
> > > -	len1 =3D chunk;
> > > +      if (left > (size_t) avail && !is_nonblocking ())
> > > +	len1 =3D (ULONG) avail;
> > >        else
> > >  	len1 =3D (ULONG) left;
> >=20
> > So there is a subtle change here, which _should_ result in the same
> > behavior, but it is far from obvious.
>=20
> Is that so? It seems abvious to me. Because...
>=20
> chunk has len (< avail) or avail.
> When left (=3D len - nbytes) > chunk, len > chunk.
> If len > chunk, chunk =3D=3D avail.
>=20
> Isn't this obvious?

Yes, after spending a lot of time to reason about the code. That's a
really wasteful way to spend readers' time when a clear and informative
commit message could have saved them the time.

That's why I keep harping on improving your commit message writing skills,
it is essential.

> Anyway, I'll add commit message and submit v3 patch
> after "SSH hang fix" is settled.

Thanks,
Johannes
