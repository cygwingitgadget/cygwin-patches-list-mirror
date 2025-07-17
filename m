Return-Path: <SRS0=5VK5=Z6=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 03E0D385E02F
	for <cygwin-patches@cygwin.com>; Thu, 17 Jul 2025 17:04:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 03E0D385E02F
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 03E0D385E02F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752771882; cv=none;
	b=QbVf29Irm/N7GNV+AVFzHVSQwSsY7yYNWVYHhjfmq2bOjTHtVp0+rMlFWZ6WEjlMRubtH2ma4BiF613T23s34ExKq7JpIjz8FDyObu7kzqCiqQMhmKxmRnsS5i2ja4cDQxhqdzJYV/5tSwOR1Fitbtp/fa7zhve7K3HcPiUsRaA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752771882; c=relaxed/simple;
	bh=D9GIvQ4VEZJnxYq2jbJyJsRbil1g9+c5G6ExV9yQL+k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=tJT2MtBo/STs4BW9cuXp35uXkpU8YPzj5ztloqabHc8XQYR4JvyM2IE8vh3d3fnsUDRfb88tyuiaKtUzhvcth3O6Agr7s64cNyJ8TQOssi0NY82SqCiDUrYEFRU6N5pdgwgI9lSBmmnuKqxdgB2U95cYRz1Kp1zTkA+5jp4xXQI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03E0D385E02F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FvKe7WUH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752771873; x=1753376673;
	i=johannes.schindelin@gmx.de;
	bh=i/cBhaKYnxC2cDZSxznaE0L213KIytSGAArWAPWP8zk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FvKe7WUHW6nanQsaDYUsXO6wPkhg4YD1A2cGAEiRD7jq95f/hDN7va5lTsPuaL1t
	 4+6NETw7WoO4kuxYuhIKAHDQD/DKp7GtIJfjSDltvximCwbv4UpCCdOazGkAeDNZN
	 Iy1/OjBwGVqN5ajIb725slRtIqm75SlZ23CgqPteexjCNsH20jgUXnsZjIbbNOkk5
	 Yg7F4bMmY+8rl9ifLTO9dfHHrL4dUBQ80eTXub3eA+K6Xbwgob5ZbfMMDvOp4KT2C
	 za8JqIbYg7dL9FtdQxABNP+vOzEkEKKeBUy0qn/CbG8jcWiEdH6HgBuWUVWsBLx57
	 xPNEwCcqZVtCWO4DXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1uvd2s2FRH-0188hV; Thu, 17
 Jul 2025 19:04:33 +0200
Date: Thu, 17 Jul 2025 19:04:30 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeremy Drake <cygwin@jdrake.com>
cc: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
In-Reply-To: <cef0e1d0-8736-57ca-6d8c-6e6ee8fb8696@jdrake.com>
Message-ID: <9323a02d-753b-6cb3-c996-9d86f379bc21@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp> <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de> <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp> <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de> <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
 <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de> <cef0e1d0-8736-57ca-6d8c-6e6ee8fb8696@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PDsaUJQ23IXfkjI/Q/f8LKgkKMsj4ExbZwZdlhyce5ozEbhJ2no
 8UG3RcqXkEqr5/l5AlWcKponMWP3XzarvnhCBxMQb/T4vzLcUASri0IzL1Vo3Tv5OQlkSb3
 HxTibg4NdjIrHzyhZOgKziqrfYHawXMy9yo/J0TM+beWOn8z3JHBa7IlDIm2TRYsszOEXr4
 WkEVwFTh/xRca3665fOTw==
UI-OutboundReport: notjunk:1;M01:P0:bSMmH59UNT0=;6XptjEUjcN8G0eWY8SQUlSKadZ0
 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
 nXSGcASRULlN3WN2YZ3e2WnrGE
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Mon, 7 Jul 2025, Jeremy Drake wrote:

> On Mon, 7 Jul 2025, Johannes Schindelin wrote:
>=20
> > fix by a regression test in `winsup/testsuite/`?
> >
> > For several days, I tried to find a way to reproduce a way to reproduc=
e
> > the SSH hang using combinations of Cygwin programs and MINGW
> > programs/Node.JS scripts and did not find any. FWIW I don't think that
> > MINGW programs or Node.JS scripts would be allowed in the test suite,
> > anyway, but I wanted to see whether I could replicate the conditions
> > necessary for the hang without resorting to SSH and `git.exe` _at all_=
.
>=20
> Technically, there is a mingw directory of the testsuite that builds
> executables with the cross mingw compiler.  I recently added a test that
> spawns a mingw program built from that directory.

Yes, I saw that you were working on MINGW-compiled stuff in the test
suite.

My problem is that I was unable to reproduce the issue short of standing
up a full-fledged SSH daemon and using Git for Windows to clone via
Cygwin's `ssh.exe`. I did essentially something like this in
https://github.com/git-for-windows/msys2-runtime/pull/105, which is really
not ideal (integration tests open the door for problems to contribute to
test failures which are outside of the project's control, something I was
loathe to do).

> There's also the new "STC" repository that also runs in CI, that seems
> to be more intended for regression tests, but that doesn't have any ming=
w
> builds yet.

Oh, you mean the stress tests? From my work in the Git project, I probably
mistook them for something they are not (I expected them to run the same
tests concurrently to increase the chances of flakes to break the tests).

Ciao,
Johannes
