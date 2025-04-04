Return-Path: <SRS0=8BWJ=WW=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 7CFA33857C67
	for <cygwin-patches@cygwin.com>; Fri,  4 Apr 2025 14:17:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7CFA33857C67
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7CFA33857C67
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743776248; cv=none;
	b=KPwecWr0nrWmQ/b7Z1FvPyaG3w7+0xa7JFFS2dNuqqCTWShcOK+wQoi/CzGyg6vS2vRffQArfXZA+QPyJLAqtRNUzPFM3nhHs6Irt73RISe1GzlP6yOINSp06KQHvOAmDU3IdpE2GtdXadYeLrIyaGgI4IuR72QZUyonCuVKAgw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743776248; c=relaxed/simple;
	bh=HUsWkogpR63VGh8DTzLGR9k/9awEbIzWSKjUWVRtJIw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=MtKI0++2lEkHojmUEYxu9of4HoDHOkjI2nOC8iz6a+garVbKaxZEoSObsRil0LZN4uDUm/pYqesz66r3qOMB9uz5gGNslR2xz708WyCm8wF9FfFSCrjU+9MS/JgNYAaIekoBMPOaYk8l3rbD23ZDpKeraQdufaeymbmYn85E8II=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7CFA33857C67
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=h5mxuKAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743776241; x=1744381041;
	i=johannes.schindelin@gmx.de;
	bh=HUsWkogpR63VGh8DTzLGR9k/9awEbIzWSKjUWVRtJIw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h5mxuKADM+fKtQQjT6+Wq3TgnHtKYvRH61+fYlviKTTx3WrOhK7H0nGtBYFCxdOf
	 rLzknDzNy6Xj6nLU/+zJev9LDJKO1e39yXVsoyiqSp0W9mfTgCUwyDes5NnjxUZoa
	 WXI1RcYB7mTa7+TSo/kutA09HFdX1/pZvUcOfzXqPuLk3nrC85izFtMY9JNqzR37e
	 KBABAV8ghM00vRxHVz9O5t40cQSZI0W35n1vlmUHoYsapgJoN+fGltcgDsUDs+b1w
	 i+S75Z8k5DENcMGF7xOrA791sTExHRl7W+osCP0HvrCqs061tT1icvBVq5k1OiHws
	 OHFNWrCPqwr27vxQSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.168.126.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1tue6Z2Aju-0080tn; Fri, 04
 Apr 2025 16:17:21 +0200
Date: Fri, 4 Apr 2025 16:17:21 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other
 initializations
In-Reply-To: <20250404225337.08412ac9089cc9a066cae4da@nifty.ne.jp>
Message-ID: <15ea8e11-bef3-f08e-e0a1-c6c5aaaad519@gmx.de>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp> <969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de> <ec45497d-a248-1056-4993-da137267b7c5@jdrake.com> <20250404105839.6652c8849bfb169d669f3799@nifty.ne.jp> <C262E1A5-1B14-4D38-AE47-2EC7709DB6D1@gmx.de>
 <20250404210609.b0d38a4cac7e195ad20a9ced@nifty.ne.jp> <57624128-5aa1-b47f-a192-2b342eb2072b@gmx.de> <20250404225337.08412ac9089cc9a066cae4da@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nMrcOd6LzQjgoTVqzul2Uh0HMU4rgthHwqBg2p3gkU2rOKTkeAR
 dngWPaAKriSi3Nx55WqdDeWl8ZqzuDFN87UaezMt6SvFkeqkFst4abN6fXcokpoVdZ1KqCZ
 jtZVkR80BfEvAvSv8evh+68zFCZl9kleYCl/m5fJSKSkl6sPLGyLF5h7NiCK/+kph8b9e26
 LstXhdeUt64bpIn44esAA==
UI-OutboundReport: notjunk:1;M01:P0:3OlbewdZGOs=;R5vhBTWEyR6QW9fGvsMfrBweM9Z
 JakTnavGc7fWoUzJ4cGUcywpzpjyYU0YtG26JDuZOXqnnxYwniXKxDDyXXuv7g2mDCKFOuHM5
 1E8ZauHSGuwM8FDlVwN+ooz1lalBuJzNIhbdThgFN+garnittg+YBKxM1ca7MweFym46rfnOu
 crCMlf+E9N/xvMHrutotq6thbIUMc7vQDd0RFFTHqk5DEkRHILS7s4U9Fuj+0DGtpWhJoThD3
 FPw7SXQ4YEV4igVWDGi1UOR5K/402IjcQ/p3B/GPVbt3wNb6CgdwKg8UFt+srueBhewHLGRd1
 XOeGcs7RzScjMpD+0xsO/cEpygoLWOOuYT2cLoYn6L1xzSLwFE25pqDYtUAxP1zSWnOReKI4d
 XNAf2+11JOAjEC9+9EY8sWI2gZF48Jgjl1iUm2dTvKUOWrglXhvxH7O2UBRx+pXiGkQDcGb/k
 dY978+6WJVYC4pvZsz7QuwzLeHPx08GJKhsk/YGfnjSl5lbymM6x+ZecEDIQtvIHrFWTN3Xie
 cU90VfkhKVSnQqalCsQ6zqom55dKVYtViIYBFEuM1D2vMSXb+sD4t4mmio9VhDVNK9X7q0JW/
 r27lY5U0dl0td2SMVeckeo+cTXmIDmdB0uisUDQ6WPYVltTZ9Y9jekV0bqQsnMZmm1qzOZ7hh
 UnoBXp45yJjbHBdn7z8cHtpZ/C77HF6k/5s8jLAjO07SkCTJccy2RNeoe0c7Xt/8zwNilMP68
 7TzagAfZ30YVNJipmbZrqBJq4aI1RQr/UrRQCF4Qy245QDWugxw2JMNG2J2St7lwnSW3vCVRO
 ylRQkskdIakvILmbH0Zaw2H7q1lZl3UOnEGW2g2sNx5b5KCHip/G4svj4TVwIg9tbYCRfaLmg
 DYJOM2tPRrRgLsR9USQR1EZWxoqqMYI4+KKwUqAyHgPiYODIuaxS6xf8T/pqSjhWfipUXjZ44
 cyDcWf/SVc4vAv7fwqg+agUvD6YxuLinDAVlsCch+PnpXkmtt7IEzMNNvUtePbX33cmP4cBDG
 US28HhleGLwW8CSvD2olMYDzOVFT6tu5ShAREruwHnxfUvY4CN3QuWDscpldGHGID3XP+FjjE
 M1GOVgj02bINz/K88KYfhU0UwLalsxjdyknLOHUNztH9zE6xGyu4bOTOFTojO/+OJVlPwpkL4
 8pqo68lC0PGgUpIrnjkxvk0tjLU8N5En/UTvwNuZF6qIiouMkr57IikAOXavxc716epzyD9Ui
 1VYuBTtFErO9nTC8bIakmqaxIQb1ATUWrz48QWHwqJqdT4TEcdcOhHOVNG1sm8c/dzKOdnjmm
 CroC+RiX5m3aThx2CWw3Q7VcAyZmHKWpzgoNiKEO1aiEMvYj7iNn/INdL3YO0UYkc3Te6pzW2
 Cj69n9t8mqMk/V+DvbBIyANf2lwU+docIbiFWKkE6AlkjxRwIniD4PVCAa7HQoSesrUfUYD2F
 aniwlvy2ukJFd0iZocrAlQwbn5TDn2XJ3STWIYvYFAveOkFM1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 4 Apr 2025, Takashi Yano wrote:

> On Fri, 4 Apr 2025 14:13:57 +0200 (CEST)
> Johannes Schindelin wrote:
> > On Fri, 4 Apr 2025, Takashi Yano wrote:
> > > On Fri, 04 Apr 2025 07:27:09 +0200 Johannes Schindelin wrote:
> > >
> > > > Is Jeremy's guess "if raw_write doesn't need to wait (ie, there's =
room
> > > > in the pipe for the write) it doesn't hit the signal stuff" correc=
t?
> > > > If so, it would be good to add that part to the commit message bec=
ause
> > > > the commit would otherwise still be incomplete.
> > >
> > > That's not correct. Indeed, raw_write() waits for room in the pipe,
> > > however, it does not matter in this case. The probelm occurs at
> > > cygwait() which waits for pipe mutex as already mentioned in the com=
mit
> > > message.
> >
> > So what is the explanation, then, that this hung only occasionally and=
 not
> > all the time?
>
> As far as I investigated, the event handle signal_arrived was never
> initialized all the time. Therefore, the its value is just copied from
> the parent. The event signal_arrived is not inheritable, so, the handle
> value is basically not a valid one.

But that means that the `signal_arrived` that is copied from the parent
process should be invalidated in the child processes, right?

> However, the handle value of win32 is a small value such as 0x1ac,
> it can easily be the same value with other existing handle.
> I observed two cases, one was the value of signal_arrived was a
> valid handle value but was not the event handle, the other was the
> value was a valid event handle (but not initialize as signal_arrived).
>
> I'm not quite sure why, but most of the cases were one of the above.
> Then sometimes its value is really invalid.

Okay, so basically it is the wrong handle all of the time but sometimes
the function calls still work by some happenstance?

I, too, have observed in the past that `HANDLE` values are reused
relatively quickly, therefore that sounds quite plausible an explanation
to me.

Again, good material for the commit message, so that others do not have to
repeat your analysis in its entirety.

Ciao,
Johannes

