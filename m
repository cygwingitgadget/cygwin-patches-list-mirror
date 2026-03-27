Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id A5E4E4BA540B
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 11:27:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A5E4E4BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A5E4E4BA540B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774610828; cv=none;
	b=N1ev6gwrKaaZKJb0TOLnjUQHUACVDhtw25teWuzNZs8WdVgwhgNmB4uNuCgqyXMQxgVr3+JOlmrklQlhKMOwLTe/clrAt4w/C2zd81B7bwl2K3vsau7ZUacyZigvqFsnaKEitfhliwryzXZ3/QIePXsaENG6LkvgMr3+1fwEM6g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774610828; c=relaxed/simple;
	bh=GOChcCRGUkmHQC4UvYfQHZmArXewMI7MJXQCWLdM5Fw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=pnW/QOABo3JUSI4ZV4Wu75IpTrCF6l92/d8+7b5zamGyWEk7/kfHMw8KAITKddwhfE9JB84UfYG2DehQUVVOCetNhViU+t/b9+KjdrexQ6Jlyjuh04ziVGl189dqYjD/iwW3OSYxVNoNzAEJHK+SISqfasU5ldLX1r6sEBv5kds=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A5E4E4BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=BTn7dEx+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774610820; x=1775215620;
	i=johannes.schindelin@gmx.de;
	bh=GOChcCRGUkmHQC4UvYfQHZmArXewMI7MJXQCWLdM5Fw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BTn7dEx+4jJLugIgqwa/78BgoNKNckRZG2LXVuGmaDF3iaM/G8GazQmBk8gQtQo9
	 OPCGNxCOTrP96XsO1XaJDAUEqesa5cnFxhoDdQ8A0buWIDdC3dMhuwhv5YZzl0nQW
	 H82byIPDFL9a+aJf99AinIpV8Wh6tPXTblccYHbsJr5G1lyA2faAeF04/kdUXVeiv
	 3W4LDdY7yjywuk1QMW29krDunAe7o+gi+Ua7RTXkzWEFFbBgjFO0s9qGJ5L5o9z8H
	 8fDBj5RIHg/iwMQthw8Xl+3le3zXP5k20mUWIUx7s0IFS0+PZ6fl4BKRrvXOKqJc+
	 p3v/6NSwyPJ4O020Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1wJGdQ1VeC-00BC4F; Fri, 27
 Mar 2026 12:27:00 +0100
Date: Fri, 27 Mar 2026 12:26:59 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/6] Cygwin: pty: Add workaround for handling of backspace
 when pcon enabled
In-Reply-To: <20260318202032.54cf28ea83d863082f1bb153@nifty.ne.jp>
Message-ID: <c4dc071d-fa7e-ed2e-0c14-3fddb5240f1c@gmx.de>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de> <20260317122433.721-1-takashi.yano@nifty.ne.jp> <20260317122433.721-3-takashi.yano@nifty.ne.jp> <2f8628d2-b79a-95a6-480d-7508375958d5@gmx.de> <20260318202032.54cf28ea83d863082f1bb153@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iAT5Tpc7iHv7AMJjwPhSFaVklzkOWQ6akToLAeAUWqdvdSfN8wI
 AUkcnOeCkYXljQyvomv85YH92sD0tN8UxUbezSy+v7AnEWicWUiMB53TmXSweaA5NiL93Be
 pB3KNIKKbYAvmCh/cYmcVskFNHqYdUrWKwKqXzmHm+wkwpkjpaz+PXf/zJxm+zqnpr95QoB
 U57n8+fyqvUKlIoU2G+/A==
UI-OutboundReport: notjunk:1;M01:P0:NPSc+vmhW+w=;WC+RJXehKfvMbHfB+iUmG0SFnfm
 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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 18 Mar 2026, Takashi Yano wrote:

> I'm also noticed your commit:
> https://github.com/dscho/terminal/commit/ddb7a3b411c040fb964e1eff3942c325afa1513b
> Are you planning to open PR?

I meant to set aside time to test it, but never managed to find an hour or
two. And now I realize: I do not even know how to reproduce the Backspace
problem, how did you get across it? Like, how could this be tested in a
regular Windows Terminal running on OpenConsole.exe?

Ciao,
Johannes
