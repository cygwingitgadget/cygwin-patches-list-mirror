Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 6E6304BA2E04
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 11:35:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6E6304BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6E6304BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774611304; cv=none;
	b=FNgnMF7dekCNN7ikOTj8on9QeQtWr1mDl0etaJvhwjWMteb78QRdrasabl9WdvDgUhR0DXXK2BDai4XfRtoJen4R5SN64bVxYbcwUpOqRn/YjSq5R6EjZw9Zh8mU6wHVhSgS5XZUg+TUTu8G+K+WzDR4qfkzNVSyLeMgr7WQ/Wc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774611304; c=relaxed/simple;
	bh=HDA53j4Y24fHpMw1m+C125ywFl6trXxS6GgqmtkzO34=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ripUkrLGY9lZY7iJku+twn2vPLJvnQy9ehP3/XnklA2OcgdsBfgGVjjtaR3cuBggRyITewfesYDpKmUJJDXIm6ID4JmYalz83szskhKNebOkDTyxI1uCQ/i6iivF6nDEf+WnQHD5EYSDbEVMEzm1en04g8gu8K+F2sCYxKdZqa4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6E6304BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=C1EJtY7k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774611303; x=1775216103;
	i=johannes.schindelin@gmx.de;
	bh=IYGxWFB6R2BMtqOIGhBDMhb3qCrHBUu/MdlscnbYfBg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C1EJtY7krI85T95dBGMffIn+3yTV+1grEkZmkp52bKdeNoKd6VRhPg9P+9QZXrvw
	 IsLMNpqiwdDlp7eYa7T1KPPW94QBZYYEKckkoni9OqnhkVAG0tDKwU7rtg2bk9aZD
	 NAAmYxXkTABTgXbQqw/hr57sl5LoVVr6tEDJCssxhMCgX1P3egXuCmh9DeyM5FLhX
	 8OjvpvPGZN5cBPiz4IQned3BbW+OQtDuw5PqN3blfrBVtv1XUH7fHRYqtG/AgGhgH
	 p4vrSI6iN2rI0jB3Lag8Gf1OSM+fQABkxR7aT/NTWgwfB1suey1rQRf5W+PbSFovR
	 yn3YO7+0fanYXsW+Zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvrL-1vcoWo0Y8b-00abLo; Fri, 27
 Mar 2026 12:35:03 +0100
Date: Fri, 27 Mar 2026 12:35:02 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 0/7] Fix out-of-order keystrokes
In-Reply-To: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
Message-ID: <85e4fc6c-0d00-906e-67b3-94bb7e03c72f@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gh489T5Pi2MLaHNmpRNTXEXaMiBO9jK92I65tedMjjFUVzdgZKm
 02sataQt/MfptbO+QHC7nhf2w9z+StoHhQ0YsivEJHOT2bcw7e6o3EciIMn8YfzEMjlVmXr
 dykZun9vvlDqYXm7WVluvnDJARepgJxSyj4CuZbH3I7Np5IZAfs7ZqVKNb+X6kc0FQhXU7B
 aI2aggOlMN/ID38O8rFGQ==
UI-OutboundReport: notjunk:1;M01:P0:QXaDBxF1nv0=;PwNaHPH/7jIDFEknm7eDrUgV25n
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Mar 2026, Takashi Yano wrote:

> The reproducer that uses AutoHotKey provided by Johannes:
> https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
> uncovered several issues regarding input transfer between nat-
> pipe and cyg-pipe. Most of the issues happen when non-cygwin
> shell start cygwin-app. This patch series addresses these issues.
>=20
> v7: (changes from v6)
>   Add 7th patch: Fix another bug causes out-of-order keystroke
>=20
> v6: (changes from v5)
>   PATCH 6/6: Wait for pcon_start_pid as well as pcon_start in
>              to_be_read_from_nat_pipe() because accept_input(),
>              called from master::write(), also calls
>              to_be_read_from_nat_pipe() after pcon_start is cleared.
>=20
> v5: (changes from v4)
>   PATCH 1/6: I was wrong in v4. The first attempt to reorder (fix)
>              is necessary after all to avoid incorrect fix.
>=20
> v4: (changes from v3)
>   PATCH 1/6: The patch reworked from the first step completely, because
>              understanding of the root cause was incorrect
>=20
> v4: (changes from v1, v2)
>   PATCH 1/6: Give-up input event nandling when input event sequence seem=
s
>              corrupted to avoid infinite loop
>   PATCH 2/6: Drop pushing input event of backspace by WriteConsoleInput(=
)
>              and adopt another workaround
>   PATCH 4/6: Use WFMO instead of busy loop waiting for flags in
>              master_fwd_thread
>   PATCH 6/6: Check WAIT_TIMEOUT rather than WAIT_OBJECT_0 in
>              to_be_read_from_nat_pipe() because mutex can be
>              acquired if the return value of WFSO is not WAIT_OBJECT_0,
>              e.g. WAIT_ABANDONED

Thank you for your hard work, and also: Thank you for figuring out a way
to drop the Backspace handling via WriteConsoleInputW() I objected to.

I tested this patch series (which required cherry-picking 699c6892f1
(Cygwin: pty: Fix nat pipe hand-over when pcon is disabled, 2026-03-03)
and applying
https://inbox.sourceware.org/cygwin-patches/20260310085139.113-1-takashi.y=
ano@nifty.ne.jp/
("Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist")
before the 7 patches would apply cleanly.

I can confirm that the AutoHotKey-based test now finishes.

However, I have some concerns about the commit messages, and also about
some coding patterns (such as introducing an expensive `OpenProcess()`
into a potentially hot code path).

I haven't managed to finish a full review yet, but hope to send out at
least my finalized feedback for v7 patch 1/7 today, still.

Ciao,
Johannes
