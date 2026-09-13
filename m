Return-Path: <SRS0=nquO=HF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 078404BB58F9
	for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 12:14:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 078404BB58F9
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 078404BB58F9
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789301666; cv=none;
	b=GS16SI369YWsDlnC7/asDPh4APwxVqnqdEZb1Yl6enmIVinY7JY85ud4N9jRxIejUNHeH07SaTAe1kH3nuGDyN9mqFzVFay5c5nxtF/+s+Fqjg8Xuk0oYIAbePhhnq66DXp4ORT5KmyHuDh013c2Vlx8eGjDo7m224JD6VPstXc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789301666; c=relaxed/simple;
	bh=c/H80uMRsEwMhNdCb3pdIh2GO7kI7wkjI3UxB63PZgg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=s8IETBEjfUfrv5TzLe4bTCblwWkN/sMX67DeaJHV2d5mrEAHu5vnB0iecHgrZuRsHsAGOY8yBpwGhxroLpv+fJ/X4/I+Okzli6Q+DYEnSyyRISYl2J5xvEWcML4WRvyOxeQkIZBmsCEG4/aS2nfhERCLIOfKCSb22ekkjkV+YkA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=G0ILMMvC
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 078404BB58F9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=G0ILMMvC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789301664; x=1789906464;
	i=johannes.schindelin@gmx.de;
	bh=X1G+U/NMZIAqn2Vibhy/MWbpf9Jh8lXA2TJ7+g/pBnQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G0ILMMvC29mqWZvCLd0zJDnGnMQYo8UPi297pK7iR5AR85JFS0fkOHiwQRb91mRm
	 crhCiRVLzdno/S8V7/g3+/FxcOpGSPBNvIftS4zFcmK3fCD9uhpST1URVZY43suhB
	 OzLfnSa3VEG1ih9h1oQ1XFpV3N+NNm/X/zXM5M6MNKkUtNwkw6fAfae+I+mwYNBxF
	 y+Jh/byFOpbl5WqLhmKvns6CnqLhpgYd+T3erCE8kn2JW/tbSpKiggl6mU/ZqsTjP
	 NLGmEAwl9+gqRzdltFMbOU2K1L1UinZjuXEgJfaU9TbyfWz8tj3bhEQY+OUQYaxbE
	 BTI2F4HrkpJPu/Dcag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1wmgVz1tCB-00xVgR; Sun, 13
 Sep 2026 14:14:24 +0200
Date: Sun, 13 Sep 2026 14:14:23 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: console patches
In-Reply-To: <20260904083819.ff0ff05bb39ac93ae6ed0086@nifty.ne.jp>
Message-ID: <cc0ad942-c03c-4c9e-dd37-54227e278cad@gmx.de>
References: <20260904083819.ff0ff05bb39ac93ae6ed0086@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=832332817999977771789301665524983
X-Provags-ID: V03:K1:w+bkT55nosbi+5pALfQeXf12IPkjrGx8LE07Q5riX/hxOMLAo7l
 lXdyFR0UYgMbiG3kHQU8y/5Wal5pchZQbtfxuTgzpDIY+c+UKIsIxuoYVHHZ3tsqr1ZvqFA
 xJWSv6I+LUjfA8o6uoGAqt+Ou0He823ySpmXp/IR2I5newjA/oUXT/xwgETAe/fz8Tsp3+i
 xyQvvvF2HDt//9Hym1neA==
UI-OutboundReport: notjunk:1;M01:P0:eoeyO466tdE=;B3xu7X9ZQOivR47SQCNjKbBs35k
 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
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--832332817999977771789301665524983
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Fri, 4 Sep 2026, Takashi Yano wrote:

> I understand you=E2=80=99re busy, but could you please continue with the=
 review?
>=20
> [PATCH v14] Cygwin: console: Fix undesired mode change at exit of non-cy=
gwin apps
> [PATCH v2] Cygwin: console: Clear readahead buffer on tcflush()
> [PATCH] Cygwin: console: Fix argument of process_input_message() in read=
()

So sorry! I hate when people have to wait for me.

I now set aside time for those reviews; Hopefully you will find them
useful!

Ciao,
Johannes

--832332817999977771789301665524983--
