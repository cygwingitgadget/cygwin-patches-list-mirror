Return-Path: <SRS0=+dHo=6W=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 766C14BA2E04
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 22:52:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 766C14BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 766C14BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765925533; cv=none;
	b=hBI5a+kmKxRE9+gOF2woZuX+F7WrDA72QeORtZ2olkm1qf8GvjMM3CuRcU/Q53H5gTs4ubP5MEbsSx7exV0rxJhxIMA7aZC7z7UjMuAH5P8DRRIO6XKbIIuMR3JKrApkZjppyAC4unmceN3hUV5VRirE40KOiJbE1LNnd9pSGP4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765925533; c=relaxed/simple;
	bh=tJLJNRB05lWMw1QUYhQ0vE5/Scb+88Dyf3tkq+YRZPA=;
	h=Date:From:To:Message-ID:Subject:MIME-Version; b=ZXooEr6v0cI3Lqo/MxVpQpfrQsnMvOysWMf80SD1QyyT2U2NGsNCOh9QWzI9nWqbaiIsih09ovloFurqlbMocnEUgUNGoEhHLCqaHsIONFBeT4cZnUN+c2NN79+qnznCW5AHbE8eITkvVkzBerf8LGpBh8qg2SYnyDEOhALAze4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 766C14BA2E04
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 5BGN2FTO030797
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 15:02:15 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from mfone.maxrnd.com(127.0.0.127)
 via SMTP by m0.truegem.net, id smtpdQHqqhB; Tue Dec 16 15:02:08 2025
Date: Tue, 16 Dec 2025 14:52:01 -0800 (PST)
From: mark@maxrnd.com
To: cygwin-patches@cygwin.com
Message-ID: <2e583cec-64e5-4e2d-8503-d0e78a7ede9b@maxrnd.com>
In-Reply-To: <aUFKBBdIN5rqztD7@calimero.vinschen.de>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com> <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com> <aUAoxVEKMpj6xNjM@calimero.vinschen.de> <18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de> <aUAxwTZcfZ9qecW2@calimero
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <2e583cec-64e5-4e2d-8503-d0e78a7ede9b@maxrnd.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

[sorry for the formatting]
I immediately recognized perhaps_blah() as meaning to conditionally determi=
ne if blah is needed then do it. I've been using maybe_blah() for years, th=
ough not often.
YMMV,

..mark

Dec 16, 2025 4:11:26 AM Corinna Vinschen <corinna-cygwin@cygwin.com>:

> On Dec 16 10:31, Johannes Schindelin wrote:
>> 2. What purpose is the name `perhaps_suffix()` possibly trying to convey=
?
>> =C2=A0=C2=A0 I know naming is hard, but... `perhaps_suffix()`? Really?
>=20
> The function is named thus since before 2000, when Cygwin was imported
> into the public CVS repo ;)
>=20
>=20
> Corinna
