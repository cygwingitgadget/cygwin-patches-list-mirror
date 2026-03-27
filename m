Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 0012E4BA540B
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 11:10:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0012E4BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0012E4BA540B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774609848; cv=none;
	b=kFf3R1CgU8YdB/WsN8jN6NunvRq5377QMG8+5iP9KNVOdsTzToOBgN25H14cfmZAxN4ecRmAatsvjzjRbeg7oE+KZcXu2sa08Gw2ZvZOAKNthikyBEAXqARUajYsBKT/6Vufhh+YvRjFZ/6o0sBCGbaXpoZgOQZ1pGkAtaW6mBs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774609848; c=relaxed/simple;
	bh=N0CBEssSx5FmjMnS8yhHMF75Xith7DocixI35QNIcMM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=QwRIjnKEtj51yDXAi5g5sg4u2shQcgqUOxfVGZAeiVgogVuwBomfOG12GWzXDoFyMEzLwSKcazQdONUjG3Ap4w/c4p+QQV1Tug2VvJvXetnzlU+pXWRrDAs1RvVIsDa3jhl6ZAvi6UjKX/RYrmJ5s5isiNiiEQ9jeqLHxOimH0E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0012E4BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=kLW+VwTY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774609840; x=1775214640;
	i=johannes.schindelin@gmx.de;
	bh=kv0245RPDTTMXgOcgVpEUDSC2gYHfh8nEi3bfuIanwA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kLW+VwTYOXD0OxO51pXLNMsUrFm40ALuZ9pUAH+HA1ieKhrRZjQF9TDpnutCA7rR
	 pMgIIlu0ZRWrXiZtxaHTOX5O6q993rCZkik+YcSiJaBbDgTM41fxpoCV1ZcUkOfyz
	 ZCtaxQtfdJiXlwlptmM3vpTCBTajUe4wg80sVv7CCy3AJo9fmxrC74bJBT0REhoSX
	 Wg385Zot8Omobn0AZmzSvp904Rzvm8nLcfgl2uxmNFJh+fsCzcCCvXSnzDy+ATFn/
	 SOJCksrpXH9g0WlTYgKdDyTY8Ogv3v0BoYbO3S0wfcEaRRBsumERP5T90/uQz3PpO
	 pBcFx+1H5F9xZO90YQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1wBKPf2Oz9-002By1; Fri, 27
 Mar 2026 12:10:40 +0100
Date: Fri, 27 Mar 2026 12:10:40 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/4] Cygwin: pty: Remove pcon_start readahead flush that
 displaces readline data
In-Reply-To: <20260318161609.5ce8dc5140d82f5f30c5815a@nifty.ne.jp>
Message-ID: <b7907ed3-6b29-e655-614e-09971ab70cea@gmx.de>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com> <d0936448e07081445fb24b611654741bb6020709.1772461480.git.gitgitgadget@gmail.com> <20260318161609.5ce8dc5140d82f5f30c5815a@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Eq+paxy04QqXXTujVjYQDALNH1goXlFpiFhdql8gsmVnUB5owlb
 C/wfJ7QG7mQ+3Z6EGdv91kruBPTtYHMNyWt8qm+ByIUIs6QmJG5BVbKMUESJ4QTNOiSiLYP
 XKCuCr/QH4+lz32desBOAjN08YX/RqLKjyfuu9geghasCzKUs7PM6XK4Mgy2FJQYHnv7ide
 b7PKwEwB6H0Azzdn4QWCg==
UI-OutboundReport: notjunk:1;M01:P0:nwy4tTFanyE=;7tOo/1P7m8K3FUzwiCzbtgHXFPp
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 18 Mar 2026, Takashi Yano wrote:

> On Mon, 02 Mar 2026 14:24:38 +0000
> "Johannes Schindelin wrote:
>=20
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > After the previous commit addressed the worst data-stealing code
> > path, roughly one in five test iterations still shows a stray
> > character.  Another transfer code path in master::write() is
> > responsible.
> >=20
> > [...]
>=20
> This patch breaks the key input for non-cygwin app in the case
> that pseudo console is enabled.
>=20
> Please try just:
>=20
> cmd.exe {Enter}
>=20
> cmd.exe cannot read key input with this patch.

Confirmed. This patch is therefore also incorrect, and based on an
incomplete understanding of the input transfer.

Ciao,
Johannes
