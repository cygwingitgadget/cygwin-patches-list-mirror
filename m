Return-Path: <SRS0=Ov4U=6V=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id C7F7F4BA2E04;
	Mon, 15 Dec 2025 17:15:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C7F7F4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C7F7F4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765818914; cv=none;
	b=VwBzV2tdtCanInrHz2Qt/rUo1zq3yjKNvmwuDgR5mokjmRorxSJYjJMc6oYAjKyod8pHMNcA6VeN0r4Epx5oBD37I0s2qIJfQxKVXQFJ4Q4ZAdUr5quzYYxGHRS3DlzUHU0dBqnffS5N+n2BoVVJVNf8wjxnBDSOnSHn07dr7rQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765818914; c=relaxed/simple;
	bh=3g+WY+eGEeWZSmiZvPc/+UE0gKDZIeWP2lSE6wFEwLI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=wNy6LEBRxnCuP04g9DTjDJT5pthot+D+ebfk8TPwDRs9NseC1jrrpCMiJ0/kQCWLBVacQpojDoPnrFxuUcsuYcV30xoyhRi7rDU4TdE0BgwJhV9HIkNkRVQf+EfoUARjZzYxsw1kh+yg9rJm13Cz2MClMi7X/FvDayu5ylOrBLA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C7F7F4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Zm6WRRk2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765818912; x=1766423712;
	i=johannes.schindelin@gmx.de;
	bh=At9CMI0Tjq9fpB1/++M2DydlAJoDQ+evlsRSt56d1PY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zm6WRRk2aC3T7IufAR9pqNYfPN5PS9Q1X3DdBJEP4EhDTxlJCpEk3FwIdJkBc+2k
	 5pp2cVBX2UGcQ0SeMQ6uhvkvae5LUeAgQu/NpREJnSTrxUhSR08m1ZhuibhCibMbV
	 leD0gj3IO//+PGbCECL556XM+9hf6c94SCPQCacCyTq8htOVUkOldIU7JbnFKcrs+
	 UYmtF9mP+fnuhkbPMARhlSND5ep/3Qd3zDN2LIA/bki+Igst1D90ERIGwdxGD06/P
	 pDTgWxparppFU+sTGg1HMLNxdiligXkwC2feOmwV5w9JwBNAtptIfAjclxPrCi2Uy
	 veFu/w7O/kJUirpe8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.18]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1vizfW1zww-008M0H; Mon, 15
 Dec 2025 18:15:12 +0100
Date: Mon, 15 Dec 2025 18:15:10 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
In-Reply-To: <aUAxwTZcfZ9qecW2@calimero.vinschen.de>
Message-ID: <f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com> <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com> <aUAoxVEKMpj6xNjM@calimero.vinschen.de> <18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
 <aUAxwTZcfZ9qecW2@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8p1Sm9fzNgbTs52JyLjGDX+8DFUGV4+F+eWLGRaZ/qDLL/5TH/6
 +oUeLwg/ivyCX6uK3aIUuS6Wy193U1nbfbWxpNakc7/GDmx6URc1z7BanxwbbPeeqk+0RL0
 rkhG4sggAV0qvS+llWezvaQJPfqrfQItnYMPgLpWn+6VOXcUFMbabNw0jxNfR2dkfKNmHF/
 f8Mq8euvLIX5XcDY21Dxg==
UI-OutboundReport: notjunk:1;M01:P0:gztIeJUWbnc=;suESmGXmUjocC0QUmueFSaap77y
 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
 oUP7nBh4=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 15 Dec 2025, Corinna Vinschen wrote:

> On Dec 15 16:40, Johannes Schindelin wrote:
> > Hey Corinna,
> >=20
> > [Sorry for top-posting]
>=20
> /*rolling eyes*/

I wanted to reply quickly, which precluded me from using a mailer that
allows inlined responses, sorry.

> > Also, it looks as if that other proposed patch will always add
> > overhead, not only when the reparse point needs to be handled in a
> > special way. Given that this code path imposes already quite a bit of
> > overhead, overhead that delays execution noticeably and makes
> > debugging less delightful than I'd like, I would much prefer to do it
> > in the way that I proposed, where the extra time penalty is imposed
> > _only_ in case the special handling is actually needed.
>=20
> You may want to discuss this with Takashi.  Simplicity vs. Speed ;)

With that little rationale, the patch to always follow symlinks does not
exactly look simple to me, but complex and requiring some
head-scratching...

> But, if we take your patch, I'd suggest adding a source code comment
> why the extra call to CreateFileW is necessary.  It's not obvious when
> scanning the code.

Done.

> And I just noticed another small hiccup...
>=20
> > -------- Original Message --------
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >=20
> > > In 0a9ee3ea23 (Allow executing Windows Store's "app execution aliase=
s",
>=20
> $ git show 0a9ee3ea23
> fatal: ambiguous argument '0a9ee3ea23': unknown revision or path not in =
the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
>=20
> Oops?

Fixed, sorry. This was a commit from a fork, of course.

Ciao,
Johannes
