Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id E772A4BA2E04
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 11:23:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E772A4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E772A4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774610638; cv=none;
	b=CSno9G0/uztY+vYxIZR+enFPvmyAeNOiaf/EA/JgFkFpziHI46Gdcr8p8rPsEmWb4wuhuEp8vbVyb6ZdgBL2T/H99kbzRInrWor3LiWfs2fwXgjRwJIILdp5wTzLqwFyKMiE/nim+1a2TnGRow+iHJFckIq2RHMVeaTMWrzRA3g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774610638; c=relaxed/simple;
	bh=yhIW525le/wltlZuOwFJevtrHmBgLfn2mDZo7d8l9oQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=rmHeAlzkbs3MgirQz/a8ArLi0fvbbP+1YVew777Be6oZ5Hfa2OveXcXGz+eFTAoH0YgP86NMvetTHCvlGu3uIGjFXHBb969kuahmGuYP8Xf6bJDTWOnUpEyl++UNcQrmtAsP0gYQ7qIhDoHBAtwV0hyuVYgIRb0aI4dqV0xXulU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E772A4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=e14PcNdm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774610631; x=1775215431;
	i=johannes.schindelin@gmx.de;
	bh=Z6WzzD/zV6KVgAlHytCuKbehtDeGqWWigXJgHYilGJk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e14PcNdm7Jv2xqHOHVwoD57iL6zmrpw6M4CCw0LW/Kt6bHu7JTh5qolK7Mq63XO9
	 JWhf3L6X2YH5zUQnc/9laYvR9GflpTEIvH2oApERJGXrWIWVxo49XHxo58Udk0LwW
	 OZp2rHZJYq8uPg2ivHhqMSZa7M7NK+/mGzge7Oy37j7CjMOhdTBhFHmBdvahYgeLS
	 /A1os0S3aY0qP1xghJQ0C7Mj61HaDCUiVM2SzVjqOOMyPDiLBKQJ8j4FYdUzD/jpU
	 uK3wEdPWdoo3fxmPG63o1SnQjB7ODkctITz8nz7ovxZtdJKP4YBUCCCTPvu730Qtp
	 brFUtdra5vRhUF7rjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD2O-1vatPQ43hy-00c4Zz; Fri, 27
 Mar 2026 12:23:51 +0100
Date: Fri, 27 Mar 2026 12:23:50 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/4] Cygwin: pty: Guard accept_input routing and flush
 stale readahead in fast path
In-Reply-To: <20260318161624.6ecfa0e53714a8c9704ae4c7@nifty.ne.jp>
Message-ID: <7b1a0f5b-7c3b-f676-62b4-afd8a9f0968f@gmx.de>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com> <eba6e857a65bfab4e51a37b88d84829d8e65d5c7.1772461480.git.gitgitgadget@gmail.com> <20260318161624.6ecfa0e53714a8c9704ae4c7@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UIgnGEWYxtN3Iv3d9yzWgcNqEiRztAeLTZZGNrZL1OiqQmCmyRP
 kTn3/l3/MxXCVAwDe8D9KrKLt4LivrNtSvvSyJhcjssCDq2idNePumPjhuY9pNR0McTfkUJ
 ZAxdv9OmizYcRah7seKa8XrGP2rvfTAUyoSF8wZ8toVa5gEvrlzbfvF+OX4d3IkXLu1dXHN
 ypWRnGrGS8Ta+6Hp8nV/A==
UI-OutboundReport: notjunk:1;M01:P0:FUUorbf9j68=;g5FLnq7EWtLbt7WntvYt5uqRW86
 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
 qX
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 18 Mar 2026, Takashi Yano wrote:

> On Mon, 02 Mar 2026 14:24:40 +0000
> "Johannes Schindelin wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pt=
y.cc
> > index dd7ea9038..fcff53d88 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -489,6 +489,7 @@ fhandler_pty_master::accept_input ()
> >    HANDLE write_to =3D get_output_handle ();
> >    tmp_pathbuf tp;
> >    if (to_be_read_from_nat_pipe ()
> > +      && !get_ttyp ()->pcon_activated
> >        && get_ttyp ()->pty_input_state =3D=3D tty::to_nat)
> >      {
> >        /* This code is reached if non-cygwin app is foreground and
> > @@ -2208,8 +2209,18 @@ fhandler_pty_master::write (const void *ptr, si=
ze_t len)
> >    WaitForSingleObject (input_mutex, mutex_timeout);
> >    if (to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
> >        && get_ttyp ()->pty_input_state =3D=3D tty::to_nat)
> > -    { /* Reaches here when non-cygwin app is foreground and pseudo co=
nsole
> > -	 is activated. */
> > +    {
> > +      /* Flush any stale readahead data from a prior line_edit call t=
hat
> > +	 ran while pty_input_state was temporarily to_cyg (e.g. during a
> > +	 setpgid_aux transition when a cygwin child of the native process
> > +	 started or exited).  Without this, the readahead contents would
> > +	 be stranded and emitted after the direct WriteFile below,
> > +	 breaking chronological order. */
> > +      if (get_readahead_valid ())
> > +	{
> > +	  accept_input ();
>=20
> Does the code path really reach here?
> At the end of pcon_start phase, accept_input() is already called as
> shown below. After that, transfer_input (tty::to_nat, ...) is called.
> Therefore, in the pcon_activated state, all key input will go to nat-
> pipe, not to readahead-buffer/cyg-pipe.
>=20
>       if (!get_ttyp ()->pcon_start)
>         { /* Pseudo console initialization has been done in above code. =
*/
>           pinfo pp (get_ttyp ()->pcon_start_pid);
>           if (get_ttyp ()->switch_to_nat_pipe
>               && pp && pp->pgid =3D=3D get_ttyp ()->getpgid ()
>               && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
>             {
>               /* This accept_input() call is needed in order to transfer=
 input
>                  which is not accepted yet to non-cygwin pipe. */
>               WaitForSingleObject (input_mutex, mutex_timeout);
>               if (get_readahead_valid ())
>                 accept_input ();                   // <=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D This
>               acquire_attach_mutex (mutex_timeout);
>               fhandler_pty_slave::transfer_input (tty::to_nat, from_mast=
er,
>                                                   get_ttyp (),
>                                                   input_available_event)=
;
>               release_attach_mutex ();
>               ReleaseMutex (input_mutex);
>             }
>           get_ttyp ()->pcon_start_pid =3D 0;
>         }
>=20
> What situation do you assume? Is there any case that the key input goes
> into cyg-pipe during pcon_activated other than mask_switch_to_nat_pipe()
> case?

In my AutoHotKey-based tests, this patch was required to fix the keystroke
out-of-order delivery.

However, adding `!pcon_activated` broke the routing in the `disable_pcon
case`. The readahead flush was addressing a symptom of the oscillation
rather than the root cause.

In your v7 series, `accept_input()` routes to the `nat` pipe whenever
`to_be_read_from_nat_pipe() && pty_input_state =3D=3D to_nat`, regardless =
of
`pcon_activated`, which does not have the shortcomings of this here patch.

The readahead flush I added in this patch is handled differently (and
better) by your v7 4/7 via the `input_transferred_to_cyg`.

In short: I retract all of my patches, and thank you profusely for taking
the time to review them.

Ciao,
Johannes
