Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 1055C3857B8C
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 06:45:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1055C3857B8C
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1055C3857B8C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750833901; cv=none;
	b=Ef6kZnAFYqRFZDTry3bw7CgQbe0k/wKJi5MO+3leU9PRbzvoXUl1ZUhfQOTTbnmyAGpTlBCkE7TtqGuoGi5H/4N1JoiCDNbPKJSvNTS5Sd/k+1LP27thR3eeDQdGN1vB8RsbKyLNBgFJeLeJebMIKSIOLgV5XQRLDkCJGoqnRxk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750833901; c=relaxed/simple;
	bh=gT4+YK96EnF40/ALl7kkAFzgsQlKuyPMUtLkTeBpWVA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=KXEXRdcFIrV2/qJukTgK3m5InaVkpRFa8H+P9Hwyna+g9neYBX8Uq0JYFWIkCActDDlr0+DF9G5xYoRiZEakDxydybYqR5H3g5KHJf+jpj1B8FcIGWqGeR20cYV8Fv90ooQIQIaq6A/8ZJb52a4blOz29BPPePnBhBYaSDym+3A=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1055C3857B8C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rGNi2Uhl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750833899; x=1751438699;
	i=johannes.schindelin@gmx.de;
	bh=gT4+YK96EnF40/ALl7kkAFzgsQlKuyPMUtLkTeBpWVA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rGNi2UhlhasLniL+bXXvd/gPMIp2jvNzG8x+kiBB5OP0FlK1p7F5zhxYNpDm4pVh
	 IJnytdgmRE6AGvJUAFAYcnIshWEsIWyB+XkcosVWw3HSK4Y/MwMEMeC+rWqJV8xG8
	 DFb+jzWjYHixG4lzTvH9muZDBhp6GRkEd8F2foqPxp1fDwSMHDNXxPHjh211KOMdu
	 wmEKDa+SWFPg346IYfntoGFJhNFRS7SsumWjyNGQeUh2NpivwhU9zzj1nAZDxH9am
	 oiWMdM9LARbkidv0LTtqF6xOy1f5Sm/9UQt7uwNN4AUJNOQ+R7tJUzBjiXTAhcpy/
	 zVCUxfvxyNxKmkNeFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Z5-1ugbdY2ERX-0162lE; Wed, 25
 Jun 2025 08:44:59 +0200
Date: Wed, 25 Jun 2025 08:44:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
Message-ID: <2b5eb0fd-b754-ccbd-908e-8e4836cf5f93@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann> <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de> <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
 <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wSWe+6HBCefXaV1p4J1S1NXIXpbnD63Jz9dPC9POW7uXKQqovh/
 hMMlsR9CA6OHvX5mE5DR9W2nYRmEundKbBFVF8YWYtoxG8mGUctZY6CqyJTDeu7P2wSYG2x
 tFLpvrYhgppRFNi4xlwPS10l5LMBjv8kGa4S+y6w+msjMjjzug6x3tnNFh0LAkYItoBlc+5
 DF3+a6uCXdIKpEt5ulCWA==
UI-OutboundReport: notjunk:1;M01:P0:iRbt3z60gbM=;E9LXUozYLbU7LBLNt8rXxgTx84S
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Jun 2025, Johannes Schindelin wrote:

> On Wed, 25 Jun 2025, Takashi Yano wrote:
>=20
> > I found the patch blocks non-blocking write in some condition.
>=20
> Could you please describe these conditions?

I had _guessed_ from looking at the diff that one problem it would address
is what has been reported in Git for Windows: That Ctrl+C is no longer
able to interrupt the clone when running the `git clone` from PowerShell
inside a Windows Terminal (Ctrl+C still works when running in a MinTTY
window). But unfortunately your augmented patch does not fix that. Maybe
in addition to explaining which conditions you were thinking of, you can
help me with this problem, too?

When Git for Windows receives a Ctrl+C, it tries to run `ExitProcess()`
via a remote thread in its spawned children (it does not use
`GenerateConsoleCtrlEvent()` because that would terminate all processes
attached to the same Console).

Do you have any hint where this should be handled so that Ctrl+C works
again?

Another thing I noticed is that when I manually run `kill <pid>` on the
ssh process from another terminal window, it corrupts the PowerShell
session in some way. At first, it _looks_ as if everything is okay, but
when I type anything, only the first keystroke seems to be accepted but
then, after a couple of seconds the Windows Terminal window in which I
started the clone will simply close (it's too fast to tell whether there
is an error message or not), even though neither `ssh.exe` nor `git.exe`
should still be running, only the interactive PowerShell should be
present. This happens with or without pressing Ctrl+C.

Any idea what is going on there?

Ciao,
Johannes
