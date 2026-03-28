Return-Path: <SRS0=IPbk=B4=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 369684BA23D1
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:33:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 369684BA23D1
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 369684BA23D1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774694008; cv=none;
	b=T054t7167mFqtFbrfEwTM1kG2fOH7qE4ZjTh8/SNfh6TB3a58b5irmkJuNEnGnUD1fUnAk5gg25PpabdN8oaVPJ8iVGV6/Ush7A0Tmb2orkDsvIqD915M9uz/qv5xaoYnYk2kyILPq1s81vwKLPBQ/UZNkycy4n/tRbWjLTRznM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774694008; c=relaxed/simple;
	bh=ZFbSfubENc4SBXDeas+BqT25Qw0vUAiNBm7CqlloOe4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=fxKtmbkLdvgzUdaqHYLckc9q3gvP4tiFdaLnwS1EDrYM+5be5VoWrrnzlANZh6XZrdmL2FenjZrV3AexbHhmTp5pyb23CnSXdDMMl4rYxS5NFuU0SZ8UgHExhPOJyX5aEmoZTgIqmwRqXPN3/Ma8OlBD4FCqqvPtU/QHGX5FdCk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 369684BA23D1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=oxyuqtSC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774694000; x=1775298800;
	i=johannes.schindelin@gmx.de;
	bh=H9KMlayfSCnOoeQcU2AiuX630nq+KrTN30Ok7H/X5EE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oxyuqtSC/uq3DhNY6GLqmC+CfaqifgBEmZj4hBxEGmY/TCTgouPdSZIPBkh3SY7w
	 ajdFUuMROEaMbOx0O0BgL7Xj/pPnqXrRr56LKZ8NsKxSVgkgZZ9pvNCbSZONByU8z
	 Dn4vpgGdW7uU8CDrJFJtrsBZGHElgq8OV8Yh0QffAd0qmKcIdiUvX8nJVnKiw3Gsf
	 FYYfojTOyNfTRo7FEcQShAeDDOYCp41gk87RIDNI9oCaVn+nGOrATigGnKIyRoXnp
	 Bey7ZgD6oMmC6Cvs8BK3A2denU08PrXadbic3NoP4TNjHgYbrliXnX41Qojx/mJdG
	 cOVd+nL+p+tt8oGgEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4axq-1w4mHh3oow-00AJ0S; Sat, 28
 Mar 2026 11:33:20 +0100
Date: Sat, 28 Mar 2026 11:33:17 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 2/7] Cygwin: pty: Add workaround for handling of
 backspace when pcon enabled
In-Reply-To: <20260328191514.360fed717ef42a086bac019b@nifty.ne.jp>
Message-ID: <463c3df7-3810-ed9a-9f7c-c2cf4fd6a7b7@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-3-takashi.yano@nifty.ne.jp> <4ef32266-f86b-0555-62a8-16df5e879a24@gmx.de>
 <20260328191514.360fed717ef42a086bac019b@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SmpEgPDvVvoQfR8HMq/exmWRxvyAzq3aFZioCLlfEbLOP1Ut4li
 zP5pzJhgOqZ7yBqY3ADCuwyub/ZLF1YsAYhUfwbA+dD20SyvgsWns8laTvxNWT3r/9MIIWm
 Vg8qzeMXAikqtC3LkX4tjXKPweMn7k2/Rs2GG7rWab9FwaCy7LP2IZzIEAr2ueoRHPqnX5d
 /umZFkulhmxNZTjB8J5Ew==
UI-OutboundReport: notjunk:1;M01:P0:M+GJgeqLWM4=;s+HPig7jy/wufi0YppB03/4+KPE
 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
 TZfqqlE7haM
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 28 Mar 2026, Takashi Yano wrote:

> On Fri, 27 Mar 2026 14:25:50 +0100 (CET)
> Johannes Schindelin wrote:
> >=20
> > One open question that I already asked in
> >=20
> >   https://inbox.sourceware.org/cygwin-patches/c4dc071d-fa7e-ed2e-0c14-=
3fddb5240f1c@gmx.de/
> >=20
> > but have not yet received an answer to: how was this bug originally
> > discovered/reproduced? I still do not know how to trigger the
> > Backspace problem in a regular Windows Terminal running on
> > OpenConsole.exe, and I need a concrete repro to test the upstream fix
> > I prepared.
>=20
> I encountered the issue that Ctrl-H on cmd.exe running in pseudo console
> erases word (not char). This is because, Ctrl-H (0x08) is translated to
> Ctrl-Backspace in conhost.exe which erases a word (in Windows 11).

Ah! Running `Cygwin.bat`, then launching `mintty`, and in that
newly-opened MinTTY's Bash, type `abc` and then _not_ Backspace but Ctrl+H
does indeed delete all three characters, not just `c`.

> But I do not see similar problem in Windows Terminal. In Windoes Termina=
l,
> both Ctrl-H and Backspace are translated to 0x08. I'm not sure why.

This might be a `conhost.exe` vs `OpenConsole.exe` thing, i.e. the fact
that the former is lagging behind the latter.

But then, if I run Cygwin's `bash.exe -li` in a `conhost.exe`, then launch
`cmd.exe` inside it, then type `abc` followed by Ctrl+H, it only deleted
the `c`, so maybe I am holding this thing wrong?

This is all done in Windows 10.0.26200.7985, so maybe there's a version
difference to your setup?

Ciao,
Johannes
