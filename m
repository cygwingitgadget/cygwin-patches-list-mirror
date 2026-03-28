Return-Path: <SRS0=IPbk=B4=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 9F5DC4BA23D1
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 14:40:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9F5DC4BA23D1
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9F5DC4BA23D1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774708858; cv=none;
	b=Cb3cdAPLpAG+qrKY1yRjd1X878s0y+ED2vdznpOBf9d79i+W0ttQIhVRmXNz5C3N7RRVJaYtPXMttb1+picmkUCmb8HpBTwii0kZwlz/6wNtFvScbwqMVMyeuYtX0JXtB/qO9YR7wLeTy2ZJa2qPquZsn9ec6WTELkc2I9vDieU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774708858; c=relaxed/simple;
	bh=zsfJlqumswtHroEoEzF+ceFfNR5j8i5fc+D9fU24eBM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vpfbGV+CaaoGebnsVmcjUk9L6fLwVPbmez6kK2tdEx1gcEKvzI0/APngFkjZSfaya60/yjIoJfisXtIU8VVjCcenNJm3/CNmMQiWXVYPKyPzya9Lw+f6aA+hu6aSxS4WV2Gk6r6uYWQDnuBlC/jBlX8mKEAwdbvBQQ6R2bg6GuQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F5DC4BA23D1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=htDxIIza
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774708856; x=1775313656;
	i=johannes.schindelin@gmx.de;
	bh=k5hKawfro/qZDoF5EiYb7hXIOB0HVt/k6SaJ2i0WoJM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=htDxIIzaVM2lYe2UIZTDbQp87ya9VEwAux0r4k3DwWUwtTHzGF7DDINukduwIpR8
	 VDSztUWDjcAadQMsRNTcs8TTi6NcTXU21mZJHXUVSKvLUqLxZMPkwI+CiLZcSJ9Jk
	 e+DMwiG82xbkXCZO99ifixy2xiz4ABqanYoUf5HPvnitvFomLxGStLpbkWazcGPQH
	 bQqMt5YTogPsRxnmEqpxOIJqdnXf6+lwRMDJW43XRD6nCEZFG8UFATHgAxim9ce9K
	 FWhfU+R5CvSGviF4YzWQwG3FYstmD6gxmWdh7hs1GKf5RxTT7pqw+kvAIkKMWimKm
	 SsSgRTp44Vkd9y8nFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsnF-1vpeNh0zDp-00UIps; Sat, 28
 Mar 2026 15:40:56 +0100
Date: Sat, 28 Mar 2026 15:40:54 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8 0/7] Fix out-of-order keystrokes
In-Reply-To: <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
Message-ID: <4cd2d39a-9f31-de6f-1929-2f261a5a1a80@gmx.de>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oRN7d8InxMF0k50SdkvbCZZij9/uE2UMijBW3dGDElDQn9p3PCn
 dM4pcL3MtNTNKkLx3cICh9E1mTMuFqcmFmVGuj3cIiGw6/zjQYRYdCOqXuFR8BxsFj5TLNC
 sjM5cH8VQsujvi812C+bhWDv5GJXq+jMpPvRD6NKw2wrBtStrRfvKdlBRehobkmWIvfgXdj
 /+7sbaZbmbAeSqwFXD+Ug==
UI-OutboundReport: notjunk:1;M01:P0:Jz2npi0T6l8=;vKbOOjKjUKG8N++hYkX2hrXXzoy
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 28 Mar 2026, Takashi Yano wrote:

> The reproducer that uses AutoHotKey provided by Johannes:
> https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
> uncovered several issues regarding input transfer between nat-
> pipe and cyg-pipe. Most of the issues happen when non-cygwin
> shell start cygwin-app. This patch series addresses these issues.
>=20
> v8: (changes from v7)
>   PATCH 1/7: Replace the commit message.
>   PATCH 2/7: Replace the commit message.
>              The handle h_pcon_in to retrieve console mode is
>              cached now to prevent calling OpenProcess() everytime.
>   PATCH 3/7: Replace the commit message.
>              Add NULL check for parent_pty_input_mutex.
>   PATCH 4/7: Replace the commit message.
>              Use tmp_pathbuf for the buffer to applying line_edit().

It's a bit of a strange thing to use a path buffer (that is meant to hold
an absolute path) in `line_edit()` (where it consumes input events instead
of a path), but hey, it works ;-)

>   PATCH 5/7: Replace the commit message. Add short comment as suggested.
>   PATCH 6/7: Replace the commit message.
>   PATCH 7/7: Replace the commit message.

Once again: Thank you for your hard work. I have spent quite the dozens of
hours pouring over the code (and that's nothing compared to the time I let
Claude Opus spend with it to guide me and to test hypotheses), so I know
how much work this was. I am thoroughly grateful!

I've integrated v8 (plus 2/7 fixup) into
https://github.com/git-for-windows/msys2-runtime/pull/124 and for good
measure threw in a test case for the Ctrl+H bug you worked around in 2/7.

Just to make it explicit: I think that, unless you want to let it simmer
for a bit first, this iteration could be pushed as-is (noting that
"Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist"
should probably go first so that the patches apply cleanly, and noting
that a backport to the `cygwin-3_6-branch` would also require 699c6892f1
(Cygwin: pty: Fix nat pipe hand-over when pcon is disabled, 2026-03-03)
and 9ef8e3ad3b (Cygwin: console: Release pipe_sw_mutex in
pcon_hand_over_proc(), 2026-03-24) to be backported).

Thanks!
Johannes
