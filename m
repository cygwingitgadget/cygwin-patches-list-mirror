Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 852CB4BA540B
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 11:09:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 852CB4BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 852CB4BA540B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774609763; cv=none;
	b=WrJ67gVmyNpQAJRwWCzSGZCfTY9noXJtieCOXHVOJ6/yus/mJP0ebQTHIJA+eqeNBP00NSUs++ZFbQDpgqzz+i1PQCwJO97lBku163MMS8lE6xcr31GAcb96348ZgsjkTQKsfwBi5odrLkoNSb6ZSWMGpyEuDrjuPKP5rFi3Dt4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774609763; c=relaxed/simple;
	bh=25bTy67e8TeUEih90GV1lYhpxLfIaw3x1SJ6rn/h2qc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=YVuD8pYmqtt+eOhwROPPBHf9NyXmZqBBwbv4AIqBD3GQliP0a9LOHWwAz4mIBhtnKfRuIIWejgo5+XmKN5PxFBwwOkBsLn8tkcxvmZET2KzBUWRqJKapiZjLwmkv+PSUQdG/Q8lIQ9Jn8l0YPSzncdR7C+2+4VRGTxSKpSCxXls=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 852CB4BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dAtNHg1m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774609757; x=1775214557;
	i=johannes.schindelin@gmx.de;
	bh=25bTy67e8TeUEih90GV1lYhpxLfIaw3x1SJ6rn/h2qc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dAtNHg1mGSqVW1eCoRhJ8qale3wTdHVq5XBP1YW2pfe2/7pHt2NQzOxT+G4SxcYj
	 Bjm+A/84WE4Jd16aympX0LDHNK5EKj970z82FigvXr6MUQOxSEh8LlqukEu0+bPbc
	 2dn5QIG20QJuIWlMDCsMHsomMthyMzX/qANmlB8I6ZQ57i4FsoW2HbRYbun7lpTT0
	 KK/eYgqpHYY6MyjVYI2oiQd1en69DIhvxzBPNDio6Fme77STNl39VGppYeou625SO
	 ViT7xWl4V2XmawCtKvBIOt6KeMnyD4tflxrRmMFOIVot3sga7q0+oZdfXImK+9/R6
	 z745EBgjxanrSX0vlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1vIfKj0HAa-00uBo1; Fri, 27
 Mar 2026 12:09:17 +0100
Date: Fri, 27 Mar 2026 12:09:16 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] Cygwin: pty: Fix jumbled keystrokes by removing the
 per-keystroke pipe transfer
In-Reply-To: <20260318161555.65856d3e2e50a91dcb22d236@nifty.ne.jp>
Message-ID: <3a96aec7-8caa-3ad1-124a-fc855f440ff6@gmx.de>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com> <c7b8058842d8228a4480236f36d8de11d50c5715.1772461480.git.gitgitgadget@gmail.com> <20260318161555.65856d3e2e50a91dcb22d236@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sbAuaLvGsdJCqxrKuVhxKZ2fV+XAwwg5OuVJfgPS3jsPW4sRy/f
 BMruxezY2HPv6R8IOMkFNThINI8bsYdNDDR9rkVol9I7W4CQebCprgGh3hVwDJY9uJENmOM
 mz0eIvXwo79hYSuHbec50rwP+7i/l9UmRYjF6qM5j4mYqLx1rTjknplCWQcjiM6AAu3LHWI
 6R12TXRORWkOPzF/3aBBQ==
UI-OutboundReport: notjunk:1;M01:P0:6f/t9srfIlk=;2YURH7Ei5VQJvY37lD/p6GbFXAf
 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
 tipTm8SLbw/
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 18 Mar 2026, Takashi Yano wrote:

> On Mon, 02 Mar 2026 14:24:37 +0000
> "Johannes Schindelin wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > When rapidly typing at a Cygwin terminal while a native Windows
> > program runs and exits (e.g. typing while a short-lived git command
> > prints output in a mintty terminal), keystrokes can arrive at bash in
> > the wrong order: typing "git log" may display "igt olg" or similar
> > scrambled output.
> >=20
> > [...]
>=20
> I think the commit message is based on correct understanding
> of the current pseudo console and pty implementation, and well
> described.
>=20
> However, with this patch, please try:
>=20
> 1) env CYGWIN=3Ddisable_pcon mintty
> 2) run cmd.exe in the new mintty window
> 3) run cat in cmd.exe
> 4) press Ctrl-C to terminate cat
>=20
> After 4), cmd.exe cannot read the key input.
> So, I don't think this is the right thing to do.
>=20
> If we adopt this patch, we need another transfer_input() call
> elsewhere.

Thank you for pointing that out. This patch is indeed incorrect.

Ciao,
Johannes
