Return-Path: <SRS0=P0/x=BD=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id CB15F4BAD14F
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 11:03:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB15F4BAD14F
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB15F4BAD14F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772535814; cv=none;
	b=Ux0SJY0DNEVuWyLf06GXbD5yYIm7iwWI+RQCdb3gIVPNKgfWrLlyiP/wz3J9kf41HoQd7qi8pwtpKTPtN3btIm0CYMMkgARATFGxVSWLz+gypkvZkuXSF4yWGxcC+47OZjE4688mDoZtl7dOomAT110YGtB8mSt37TzkZ/aJJmA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772535814; c=relaxed/simple;
	bh=rZk0YPPtXTZCwlqMkuxB7x9W7fs44fXyU9NPQN66Np0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jq+it4RvpH06+3W4LhNG00/+FOTHQSzRK5RE1AqYf/4B/X8CsXWJdcSwYwO7VGCqodnuTqLkR9QzRd0gBDaxVQl43QtYkZvbwVi1RLqwYWXwpeLbBE6r9p4EqFIHfgHCvUMOaF54D18mc5/XuMXTRJYZx7AdbBFBnZafw3bxGgo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB15F4BAD14F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Y1fcp26f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772535807; x=1773140607;
	i=johannes.schindelin@gmx.de;
	bh=d/A1BFAWjP+YZDvcAAw7YrUBbbpEwO4y1IdNqVNJjE8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y1fcp26fCdRUzUJ3eNgP4KIKGMw72x4s+x9xFJnOUBH4iviqOQZBhKcP5fp4RzwF
	 SfGP/0kog4unb9GQVs0qydm+aWq17xYpnreshzp0DVn6YC111EA+YRb55gb0TVJ0Y
	 84I3LjclnkkckaaDsXMvsjD0pnjnph3lV/nNZRgXs99iVNJkxSaDzUeEbRZADcUky
	 IPK6Jzymc7Xa/SlzOg3xs4EbrBtMKtYS6k2iudDb3u5xBk57A8C2zhB56U4DAq5Nh
	 GVifdmqBJ+eHz00ND177sFCtlxCJFHRgm7dneqjD28XVGi0J8xee31cEG4j2zXqRm
	 Ou8ovB4SvtyuJsTy7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1veKNc1hLD-012K77; Tue, 03
 Mar 2026 12:03:27 +0100
Date: Tue, 3 Mar 2026 12:03:25 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/4] Add support for OpenConsole.exe
In-Reply-To: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
Message-ID: <257059f0-abeb-2109-9b6e-a4683deedb14@gmx.de>
References: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AQVNlLIF57NMtDhD6EUaHJJ0boVDs+h68oqUe7xAWt9TFbqcdp1
 ZninSJnLphrNIUdmRoIHDOKHLM+hCJXGbM47LeoP7ygYepUjzwYV+I2UpbyMd81GTEXOmF0
 Fkg464hmtTC3McK4fk1pAI1q5wkRRTNNOac2sBx2qwhn4rncSyfesfjGszXXHzDp8fvDafn
 8mbdcq4xPA4Ya7ohuiH/A==
UI-OutboundReport: notjunk:1;M01:P0:Xe2CyTCGsCI=;fZdojY11BqWUrnqrmw1qnLcr7NS
 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
 YY0aVV/VEGMg8YPRe9nys+6sGc=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 28 Feb 2026, Takashi Yano wrote:

> v4:
>   * Do not close pi.hProcess in CreatePseudoConsole_new()
>   * Modify handling of CSIc response
>=20
> Takashi Yano (4):
>   Cygwin: pty: Use OpenConsole.exe if available
>   Cygwin: pty: Update workaround for rlwrap for pseudo console
>   Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
>   Cygwin: pty: Fix the terminal state after leaving pcon

 Three out of these four patches seem to be workarounds for bugs in
 OpenConsole.exe. The project is open-source and accepts PRs. Would it not
 make _much_ more sense to contribute fixes for those bugs?

 Ciao,
 Johannes

>=20
>  winsup/cygwin/fhandler/pty.cc           | 368 ++++++++++++++++++++++--
>  winsup/cygwin/local_includes/fhandler.h |   1 +
>  winsup/cygwin/local_includes/tty.h      |   1 +
>  winsup/cygwin/tty.cc                    |   1 +
>  4 files changed, 341 insertions(+), 30 deletions(-)
>=20
> --=20
> 2.51.0
>=20
>=20
