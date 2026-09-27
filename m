Return-Path: <SRS0=BQMy=HT=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 455204BA2E03
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 18:45:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 455204BA2E03
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 455204BA2E03
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790534741; cv=none;
	b=slY8eh99oY0DW87Mh4UkbmXhbn4oq0kYqlardhMRYt5pondto3ErdGhR7r+cFurxRukFUNNhX6hPKOwci/tG0XixrLUQKJWWElukIBqqPC5w1XmB3GT1MqMvyP3iEA0o98zij20GACfnuxFyZ2dFI8/De34yJf5icVJfr6pio00=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790534741; c=relaxed/simple;
	bh=Ik+J7SvR2WSdoJ6/gPUnN8zcCmYEeqxZO69Sll1OXOs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=QgwizXdgO73TDaXxkjDbPDnip7ZBaNGoG5MTWRM4v7ucE7oO0OTZl2qWjgysRMKJOdvOKXfbFxBUXA3Dg4sPFaDXc2cZPgE53F/Osg94RrrCi+BOzIQO2XH/IbV9Iatp/EwhTg5mi/If5bZuAbuIOoGf8mGcop93sUONOSdV+LA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=uYrIwuf8
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 455204BA2E03
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=uYrIwuf8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790534739; x=1791139539;
	i=johannes.schindelin@gmx.de;
	bh=Ik+J7SvR2WSdoJ6/gPUnN8zcCmYEeqxZO69Sll1OXOs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uYrIwuf86Gqthx52m94pfNx06NbYvzBx61/T+A9023GFEY6Bkaxni9dFPUfDUrMd
	 WL1Iu9ZtKpkZzH8ycnMM3i2qwwMVbF4HUWEsAU5bSwi+gn1uZSHR7txaZep7fNwFE
	 yUzdDLWcu9FMs44OkY+LNbyVs5yeU5hnIfinc2tNYhRXdBwA3W4nw+14HNUggTMTg
	 9nG1UIlc3SXV0Cv3h/bo6n6ZNzaJlMYpJwbP9qLvAGW+81ITcjk0Otw4hWV0QpplS
	 tfNlzYDnvq7FKmzIuyDS9gi7Ge6HCoNbqF1sNE6sbK7xuR4+2RDUlKt3ln1QQcUEK
	 GLzV+tRovBQgd7HZiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1wluWC2Qtz-013uhJ; Sun, 27
 Sep 2026 20:45:39 +0200
Date: Sun, 27 Sep 2026 20:45:37 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <20260927225926.f004f30c5d86c827a5a051e8@nifty.ne.jp>
Message-ID: <3e1a148e-e175-235d-e843-7e47a9f6ca3f@gmx.de>
References: <20260927132627.1002-1-takashi.yano@nifty.ne.jp> <20260927224922.4e839303d240bc48ce084153@nifty.ne.jp> <20260927225926.f004f30c5d86c827a5a051e8@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:li+aAKoEXTL429t6Gl6scGJSqodDqo9BcXrvKrBag81C1MzUug8
 sioej+i33E6oHIW+bzBKfue8F5xjDyasBXKoPOnz7wSsVyQIUmsO5549R1j9qDPdWTTjSMp
 5JMKi2TVXGUx/zgnAoSHWPvsLqBW/UuIjKMgSnG+6JZGrxOJltnHQaIsNNm0yzLUZ7aAuKk
 5KC2YLOUaHYvGLR2jrklw==
UI-OutboundReport: notjunk:1;M01:P0:YfvX6pwreU4=;lvNTNkYX1xV7JSu7RwiTeyfG/iI
 +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
 zeAMFKMT2k9DHQSgNwwer9ddcA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sun, 27 Sep 2026, Takashi Yano wrote:

> On Sun, 27 Sep 2026 22:49:22 +0900
> Takashi Yano wrote:
> > I've measured the performance.
> > I measured the time it takes to paste 10,000 characters into bash.
> >=20
> > Without this patch: 5.1 - 5.9 sec.
> > With this patch: 3.9 - 4.3 sec.
> >=20
> > It seems that this patch can reduce the overhead by about 20%.

Nice improvement!

> In 3.6.10, the same attempt took 428 sec. (@_@;

Whoa. That rings a bell...
https://github.com/msys2/msys2-runtime/issues/358 talks about that
problem, and you already fixed it!

Thanks,
Johannes
