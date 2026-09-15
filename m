Return-Path: <SRS0=ZHTZ=HH=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 20E6B4BA23FD
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 07:32:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 20E6B4BA23FD
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 20E6B4BA23FD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789457548; cv=none;
	b=uH8WLvvebv92xO1nfGItXw3foRGXPvvtv0IPddlqUkxweK1nUCvnFMlhiFjlyLhLskm8WdKK8dhaC5AdUjC/GrghEv1M35GE4iP6VsIalOtDx2IX2BwZn1ehjSDOxOep2gysrT2kYowOote7DHwYt2ftjdBhuS6K5Rt41ZVAlEw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789457548; c=relaxed/simple;
	bh=c4BNeza6pH+cWnHmyunEJZ6LOzpqYZsCGDG9NiYheGI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=dGUlFVvRF2wsoAEC28g9e1aoMZ/Y+iJUnGKSU+durFFPIlJIAff4YERFJbaT80Tt9C7h3ZTcOzEPyqKBBdHutCUmgN4Q/DKwo9Hv3G+TSo+ezOOEq2mWi9KfdjIJ2AJArxHmKQZNVIvkybpHAZh2OFY+2TxdVPLeTWoM5Ao6J7Y=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=pKnBRLBp
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 20E6B4BA23FD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=pKnBRLBp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789457546; x=1790062346;
	i=johannes.schindelin@gmx.de;
	bh=5AADYBAIH6l4RLUG4deT+0pnKPpYXfQmhvuCSmusoFM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pKnBRLBpofBjWzX6OAszvL1TZEHV13viGtNVXs5AA5cNaLYDGuYRM6vOkBKmfv8s
	 fXMcAIqPHiCUbB+eHfere+pqckNK1zhJE0vvr8dZIoWddMGEpgxrT5czzR5j79JKZ
	 WGUKCdM0ZEjSVkcljo3Nb29AeLU5YdPmyeWWH0PvyAQ+BQzaYTRYs3DC+5TPEUgCh
	 k14WWpUDQ0WXd4RXOSNIBZO0CkbxUTyrojB0ajiCwZ/Gi6oaI+ey8O2nGdT02r74u
	 842wBN5kjWA4cqa76lv+G/vKbYjO874LGqgD/42QN5OU1t3xA7bQuNy2Xa5ZSvATh
	 hGZl/xQWXxdKNL/QYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS9C-1wMZW41V50-00a5s3; Tue, 15
 Sep 2026 09:32:26 +0200
Date: Tue, 15 Sep 2026 09:32:26 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <20260914204639.e0e82ff87a6794781416865f@nifty.ne.jp>
Message-ID: <7a8728b4-39d3-8f8c-5620-030a9e6501b2@gmx.de>
References: <20260903234859.344934-1-takashi.yano@nifty.ne.jp> <cbb2e74c-ae66-7c47-808a-a9b68d954655@gmx.de> <20260914204639.e0e82ff87a6794781416865f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:jtV4hOsD3NV9vHeQvr6EhZTGcULIh9rd0EDVop6f085Qa5FVNo/
 R5NV0PkJAURu/jFLJ5olVpkAE4cFks3runen4qvZ0vuJvBvbsyhgVEI05vxOERKd1lTQTXD
 3AUBDaGeduS4hk2Lz/3VxjJmgYDxqlu81uWfyU+NbFPi/N2ZqS3uwNT4nTwxXvVufq1VAA7
 d4pBQdhSXi1vdWMMlwVRg==
UI-OutboundReport: notjunk:1;M01:P0:WU6i8MjeFTA=;x1XXbgazANMx9Hut4EkjQPDlIx3
 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
 A3DVO0cPlfxayXOR5pd+JHyDcaaR4bfapiQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 14 Sep 2026, Takashi Yano wrote:

> On Sun, 13 Sep 2026 13:56:38 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > On Fri, 4 Sep 2026, Takashi Yano wrote:
> >=20
> > > Previously, peek_console() used PeekConsoleInput() to confirm
> > > whether the console input buffer has some input records. However,
> > > this need attaching to the console if the process does not attach to
> > > the console. To reduce that overhead, this patch uses
> > > WaitForSingleObject() with console input handle instead.
> > > WaitForSingleObject() works without attaching to the console, so
> > > this simplifies the peek_console() code.
> >=20
> > Great! I like when Cygwin's code is taught to avoid expensive operatio=
ns.
> >=20
> > One issue, though:
> >=20
> > >=20
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Reviewed-by:
> > > ---
> > >  winsup/cygwin/select.cc | 9 +--------
> > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > >=20
> > > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > > index 592f6d14d..d565f4d5b 100644
> > > --- a/winsup/cygwin/select.cc
> > > +++ b/winsup/cygwin/select.cc
> > > @@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
> > >        return 1;
> > >      }
> > > =20
> > > -  INPUT_RECORD irec;
> > > -  DWORD events_read;
> > >    HANDLE h;
> > >    set_handle_or_return_if_not_open (h, me);
> > > =20
> > > @@ -1161,12 +1159,7 @@ peek_console (select_record *me, bool)
> > >        else
> > >  	{
> > >  	  fh->acquire_input_mutex (mutex_timeout);
> > > -	  acquire_attach_mutex (mutex_timeout);
> > > -	  DWORD resume_pid =3D fh->attach_console (fh->get_owner ());
> > > -	  BOOL r =3D PeekConsoleInputW (h, &irec, 1, &events_read);
> > > -	  fh->detach_console (resume_pid, fh->get_owner ());
> > > -	  release_attach_mutex ();
> > > -	  if (!r || !events_read)
> > > +	  if (WaitForSingleObject (h, 0) !=3D WAIT_OBJECT_0)
> >=20
> > With this change, a host can report readiness without leaving any reco=
rds
> > to process. Here is a concrete source counterexample in released
> > OpenConsole `v1.24.11911.0`:
> >=20
> > 1. `SetConsoleActiveScreenBufferImpl()`
> >    (https://github.com/microsoft/terminal/blob/v1.24.11911.0/src/host/=
getset.cpp#L474-L498)
> >    calls `SetActiveScreenBuffer()`
> >    (https://github.com/microsoft/terminal/blob/v1.24.11911.0/src/host/=
output.cpp#L446-L476),
> >    which invokes `FlushAllButKeys()`.
>=20
> I wonder why
>     if (_storage.empty())
>     {
>         ServiceLocator::LocateGlobals().hInputEvent.ResetEvent();
>     }
> is missing from:
> https://github.com/microsoft/terminal/blob/main/src/host/inputBuffer.cpp=
#L347-L353
> while flush()
> https://github.com/microsoft/terminal/blob/main/src/host/inputBuffer.cpp=
#L333-L337
> and read()
> https://github.com/microsoft/terminal/blob/main/src/host/inputBuffer.cpp=
#L466-L469
> reset the event.

This seems to be a genuine omission. I did research discussions, issues
and PRs in microsoft/terminal, but it does not seem to be discussed
directly. The closest I (or more precisely, GPT-6) found is:
https://github.com/microsoft/terminal/pull/14745#discussion_r1107879996
which is followed by an explanation that the `resetWaitEvent` mechanism
was replaced with `_storage.empty()`. So from my point of view, you're
right, `FlushAllButKeys()` should probably also reset the event if
`_storage` is empty. But take that with a big rock of salt, as I am
_definitely_ out of my depth when talking about `microsoft/terminal` code.

> > 2. If the queue contained only non-key records, it becomes empty while=
 the
> >    input-available event remains signaled.
> > 3. An empty subsequent peek returns before the event-reset code
> >    (https://github.com/microsoft/terminal/blob/v1.24.11911.0/src/host/=
inputBuffer.cpp#L460-L470).
> >    With no other input activity repairing that state, Cygwin's new loo=
p
> >    can repeatedly see "signaled handle" followed by "zero records."
> >=20
> > In other words: changing active screen buffers can discard the remaini=
ng
> > non-key records without resetting the input-available event. The queue=
 is
> > then empty but the handle remains signaled; an empty peek does not rep=
air
> > the event. The new preliminary wait consequently succeeds repeatedly,
> > while `process_input_message(0)` finds zero records and returns
> > `input_processing` without changing readiness. `peek_console()` loops
> > without progress, so even a zero-timeout `select()` can hang. The old
> > preliminary peek explicitly broke out when its record count was zero.
> >=20
> > This is not merely the normal distinction between a keypress and a
> > complete line. It is a stale host notification paired with an actually
> > empty queue. The source counterexample keeps Cygwin's worker paused
> > through Win32 input mode, with no new input or other reader repairing =
the
> > state.
> >=20
> > I think we can keep the cheap `WaitForSingleObject()` check, but could=
 we
> > let `process_input_message()` report an empty queue separately from
> > `input_processing`? If its `PeekConsoleInputW()` call finds no records=
,
> > `peek_console()` needs to stop retrying rather than spin on a handle t=
hat
> > stays signaled. Simply breaking on `input_processing` would also stop =
when
> > we consumed input but hadn't yet completed a canonical line, so we nee=
d to
> > keep those cases separate. Please handle input errors explicitly, too.
>=20
> What about calling read() with AmountToRead =3D=3D 0
> https://github.com/microsoft/terminal/blob/main/src/host/inputBuffer.cpp=
#L372-L475
> ?

Unfortunately, there's an early return in that function if `OutEvents` is
empty, _before_ the event is reset:
https://github.com/microsoft/terminal/blob/dcfbcdd8639813994734ced60abec37=
474cb3ec7/src/host/inputBuffer.cpp#L462-L469

Ciao,
Johannes

>=20
> It seems that read() with length 0 resets the event if the
> input buffer is empty.
>=20
> What do you think?
>=20
> --=20
> Takashi Yano <takashi.yano@nifty.ne.jp>
>=20
