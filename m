Return-Path: <SRS0=8BWJ=WW=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 904833857C78
	for <cygwin-patches@cygwin.com>; Fri,  4 Apr 2025 12:14:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 904833857C78
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 904833857C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743768847; cv=none;
	b=Aakh/FfKvi1qIj2/BGvOS4G8FvvOl/vpZLMeWgq29TeD/KUMwvCPG8gicWTj8Ey2SH3fZDlL6J8uhDUNlVk/ZsbCO6KZAgPHnOkgLyNFj3QSok+Qv6xeHTOf/VHUs+ftdodlPf2FgDQDvxBRFjej41rCSDhCOvqPOsHcLD5Nctc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743768847; c=relaxed/simple;
	bh=GOmuYfMFv9bciCRq5sXO6K0bNOOa9aiEHlj7/EfZV+0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Cip9ci4czC2vnEefgjsbBmKbEHbkklOGa6dRx/L0VGlxBe7lMV57xlGKPyC1bpMaZ0rGBy4GGCy9OwswXAYj1YGiPvND2Pf0rV698nrtdm+vSeER+8tpWOIlHvLEkKPipH4HoMbIYMAzDNLkY4MQWw/ZqwbUTOjXp6DkGC28U3I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 904833857C78
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=IVbKvGjv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743768838; x=1744373638;
	i=johannes.schindelin@gmx.de;
	bh=GOmuYfMFv9bciCRq5sXO6K0bNOOa9aiEHlj7/EfZV+0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IVbKvGjvQtRgil2T6vVPRy3KervwmFpUwkHv4V1cUuekD1tusbeaTQkDPU0lLHs9
	 W8R7OF1nvIOpJ7yIIlr59k8liVS50OetHdGjZNncRfqb1WPuPGI0Xbuy67anvPsjX
	 gMAqQOC/aEzCVMox7VXgWS7IsFA7dmvQ0NM1XVHh5AIwKd1kGIh0BAbGjfXbMrm+v
	 /4/qGQ+ILEXcnn56P64oB4GNfCKg+z+4JIkpNXMeOayLMfi5R9fR1rpnDFyhfKV27
	 OTNqlRFfRT+feRMzuljJgGWkasSW1j2ytYoeM5xnpTvv54VXwXoniXdtfkCui3Df1
	 9UlzJhamwXMmthlkSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1syypt2Rlf-011ceF; Fri, 04
 Apr 2025 14:13:58 +0200
Date: Fri, 4 Apr 2025 14:13:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other
 initializations
In-Reply-To: <20250404210609.b0d38a4cac7e195ad20a9ced@nifty.ne.jp>
Message-ID: <57624128-5aa1-b47f-a192-2b342eb2072b@gmx.de>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp> <969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de> <ec45497d-a248-1056-4993-da137267b7c5@jdrake.com> <20250404105839.6652c8849bfb169d669f3799@nifty.ne.jp> <C262E1A5-1B14-4D38-AE47-2EC7709DB6D1@gmx.de>
 <20250404210609.b0d38a4cac7e195ad20a9ced@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Pa6i3qUlSpF8VqsgtomAvSpwradm/MsSGd3EjS/sumLTbWbVxcJ
 mMrpeI5BPuyUBDCmwoJgeUDYW+cp418mLeZcgfkcWYitcXDoy5GzqbzfEeS2o56pS94Nl/j
 XEgqcwaMJUfTOFkPQU2/F7SOIyk2KBSP35Z5l1F0biyG9pSvj24PeBTXExN82P4AF2kQScQ
 T1OQmwt/Oh95KQOngqrIg==
UI-OutboundReport: notjunk:1;M01:P0:msWsnOy46E0=;g1uUFN4gHcTDPfnqNUX88w9ta5A
 eUzRPQfEk1WC+f6ZDUwjdJnXbr0sZBDvcbg+SdXh1L/dAkbhQKCCMtAvdH2O3jesi4HAKRKbO
 RIRFSUmxn9zUT8E4rcJlmqH/Xe+Ep2IG/pBnyaKJ+xGSXMBx4/cnw6Cj/5sME3lWd4c7BiYm8
 gth+NcY1NkW5JPGra2x1qe5tgKGBJi9VYeZcP9Yw8jDojvHDU5ocwYQFotfhmRWg4ssTrp7v9
 RIAuuNZohg9saDQUPdGq6tRGVcL3yCLS3DdVmxNu8GdNuWxC+Ha75Y8hDlwKGZRU8JNsyqKTx
 r6tjj0tPS68yZfHYt71I4ZRKihebKikcccX94Iqaj1Hzg8X7EcfMa2Y7vu9PkACDqvOpvE3vj
 mavC7qvSqzhDRsu1YpPn9skizjEu5Be6rPO2VMf1s9dRCleal3saG8dbMIzA9cPLDN/yW0nUM
 ksTIgwPA8oJZxxjowEUM1uMTG2BwoCKQWy8JX033JTFDSCP7jJ6UderC2PFg2K3hXxUsjSe72
 ceZYaeLhU2ih3lSMPexe+dD/ywY3BIN0crFCBGGWmCpP/ZaNu19RsS8mir4rFWdX51kV1Ao7C
 68IzEZkpQw9vk7R4lni9cs+kfaVsIRHfLsPMCZMYThKKBhHPRJvoxwb6l8gmYego3GldzDP6B
 pSPd+BjRAcMjT4vyroxC6FySMbLd2L6IRSqOMcqJmflAq4Xhlf2hI5XqfkOY/aw/y34TMlieP
 KLOe+xvqpQxXSgl6/ZwJRpl3dkOlgFrDf1NWe+3VQUTYukcNz8fSf93q2fCzZF/Jrd0YsECJ5
 YovemTJvqXqoVJjzD5yPjZGF46W3nH5niJm4Ejy0b23hPJMIfhNplo9s2d0wxV7gJARPRaH3k
 KswBVAJL7lc7gk33cUcAH0aJW1HynAXvnZWCO2K0HSSFN26C/oC7isEsWwDvw2YCHaEsgRfYd
 1jYyiO8v+Dy2bpeooaPRAld8Q2LknuNGE8cuY5XwJDBM0fy7m/DIK7dNLGlCssLVRrCZrWYmk
 DfEH1p2zh3ioyVBYxuh9fAAdXIIeSjsyqL5VTmZE2mLcg+Klq+Iwz20waMuo5KQVpLtFj7Wwe
 YNn0QVfb51W7tsplnTw6Wy8/yUs8YAHcOOnDxdXChtlpV5MwYyA5Il+AOhzrPevncRav99E7e
 CBgAaGHIX/+Ycc0ud1hZZ3GyNT7cc+afd+AERFi1N5FfpI36P0KbXWGC2R3kMO5VTXYqLRnQw
 shze7BEUe96QETrZrmH7xvPrKs43GHTT1v4Kw+L4c+1mS3dn1m/QdLb3ZVoN9BeE/Bz9EYHYI
 +bi0dZHMilwbuXRV0QfQQmqoD/AmrWgJzFsUdHmbzPlNPcDj7bBVGIyxVm7C0+vhbT0A21kxs
 MmBQMzjIgd/ynhCLzsiSC0ukSFHPipR9x3IYvTI4sIsioN9Oj5S39YydCO03KSWmJLEgtKDnf
 fcnWInTAIN4Bw41S1Wsk84EgEC7h0Gu2/u3xy0YuEUwmDnv52
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 4 Apr 2025, Takashi Yano wrote:

> On Fri, 04 Apr 2025 07:27:09 +0200 Johannes Schindelin wrote:
>
> > Is Jeremy's guess "if raw_write doesn't need to wait (ie, there's room
> > in the pipe for the write) it doesn't hit the signal stuff" correct?
> > If so, it would be good to add that part to the commit message because
> > the commit would otherwise still be incomplete.
>
> That's not correct. Indeed, raw_write() waits for room in the pipe,
> however, it does not matter in this case. The probelm occurs at
> cygwait() which waits for pipe mutex as already mentioned in the commit
> message.

So what is the explanation, then, that this hung only occasionally and not
all the time?

> > Also: referring to 7ed9adb356df may be technically correct, but human
> > readers have a much easier time when that shortened commit OID is
> > accompanied by some human-readable information, such as the string
> > obtained via `git show --format=3Dreference` (see
> > <https://git-scm.com/docs/git-show#_pretty_formats>).
>
> Do you mean "the commit 7ed9adb356df (Cygwin: pipe: Switch pipe mode to
> blocking mode by default, 2024-09-05)"? Not just "the commit
> 7ed9adb356df"?

Yes.

Remember, SHA-1 is considered cryptographically broken (and has actually
been so since 2005, Git's original decision to hard-code it everywhere
with no upgrade path whatsoever notwithstanding). Git already supports
SHA-256 repositories, even if most of the Git repository hosters do not.
There may very well be a time when 7ed9adb356df won't refer to the
intended commit anymore.

In any case, only when you are super familiar with the commits, and only
for a short time, can you associate "7ed9adb356df" with "Ah, that was the
change that switched to blocking pipe mode by default" as a human. You can
easily reduce the cognitive load even for those who associate them by
providing the `--format=3Dreference` form.

We're still spending a lot of time on getting reviewers such as myself up
to speed on the context, we're not even talking about the specifics of the
patch yet. Helpful commit messages help with such issues and accelerate
reviews, and by making it easier to review they also help ensure that the
patches are correct (and won't introduce yet other regressions that will
have to be fixed in the future, a pattern I seem to notice in this part of
Cygwin's code).

Ciao,
Johannes
