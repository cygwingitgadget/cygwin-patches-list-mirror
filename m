Return-Path: <SRS0=+3/h=F6=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id B9D074BA79A0
	for <cygwin-patches@cygwin.com>; Wed,  5 Aug 2026 10:21:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B9D074BA79A0
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B9D074BA79A0
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785925316; cv=none;
	b=Ke3Tdy0myALeJbYX/rZoyXNKMtG0k5tVRg4xp4gHIl6RYi764XkvZo29AI8M48Gf4UX+NCpq7wFklP+uNl1/QrIIwBZjMU8liCccTr4Y5LTSzq7tpZh1fvRI4DUUqgYbHKM7gSC16HFI+RsozzSZmr1TeC+1CXECplAVgz4lR4g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785925316; c=relaxed/simple;
	bh=7IE5izUGPJcxkjaRH3SjbD2sW9Ft8AhcGFR/I7YRggQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=VmmccYTBOI13x+nQ4LGvE4+5kitITQTEhE7sGlVOfN+TG9hY1rDNjIE9QDZlz+qzjCSQi+AT1nuoGNHtvqXTwwRjtYca0YSlte/2EBSZiZlnGddxwfUlpz7wLBcz2Q78lFKEymN4kp9nPtL0/Y5wWOepKjk/01k8heSaZT/+V2Y=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=in7uhSDv
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B9D074BA79A0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=in7uhSDv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785925314; x=1786530114;
	i=johannes.schindelin@gmx.de;
	bh=Nj83LQW3QaouDRNP8+2wepPJ6IIUrLDlFAr3jUaqx0U=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=in7uhSDvJmevjc5u+CTok3wOxR5gCtEqVfC5dd8aMqmXapWRUnwWNsoxi1exOMmd
	 eaVqQWXtZafT+n505LrDqHIqJqMZhNcT35MA/dlLMidweK1aUbqN7CTjm0w3u4MHa
	 chrk1gijhyXPVI/iolcnP8xmDpm8Q3M8ldJqSOD0xlH4L9HQQw861kkTTcie/X6fS
	 XagYX5IWKUmXfkKZX7cY5tmiJweAErklAU5AnvqsrYU/HcBAGw4WO7IwWb65c3ioM
	 wfazwW4nDfg0auZX5Y/w+dd1cdlED6v0Aclz2mLwL7e0jlR7LKpcLlRfO+iBTt92Q
	 zXanmKyijwFSKvAMBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1xE15R0irn-00hqXW; Wed, 05
 Aug 2026 12:21:54 +0200
Date: Wed, 5 Aug 2026 12:21:50 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mark Geisert <mark@maxrnd.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: open: Add missing unlock on error
In-Reply-To: <18b718f2-c432-4c16-b00a-a3d3790c8dbf@maxrnd.com>
Message-ID: <f6973e95-3623-76c6-304c-ea786ad52c13@gmx.de>
References: <20260803032303.5382-1-takashi.yano@nifty.ne.jp> <0f3a1f92-f9fa-5aff-c837-249a2408b95f@gmx.de> <18b718f2-c432-4c16-b00a-a3d3790c8dbf@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:/k//umpYVYReKoNebI8srjUHBW5MaO8NxottHa6bx0JzLwheQSE
 8wOoqxdXoJmsKWQHl31ofYAunhCi+yUogOdyQci8Ar018KYmRmOvPu0EObkQoNpcFdsZ+g6
 8jVvXpyfqzkDgAAjL+bOER7GyFLiLjR6np46G9X+aA+GEKiuaxn1duOB/fUQr85q6FQyNnU
 dB9YfSA7JxsHa/qnGYcgQ==
UI-OutboundReport: notjunk:1;M01:P0:zBt63IoYytQ=;BnP6FTYbZMCpM1mM/n7acjG2sK2
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Mon, 3 Aug 2026, Mark Geisert wrote:

> On 8/3/2026 12:36 PM, Johannes Schindelin wrote:
> >=20
> > I independently reviewed this and reached the same conclusion: the fix
> > is correct and minimal. I see it already landed on master as
> > 0d3ea0ee653f (with Mark's Reviewed-by), so it's kind of a belated
> > review.
> >=20
> > On Mon, 3 Aug 2026, Takashi Yano wrote:
> >=20
> > > the commit 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_
> > > with_arch()") introduced a bug that fdtab lock was not unlocked when
> > > new fd cannot be allocated due to an error.
> >=20
> > Worth restating how much this matters, because the leaked lock is not
> > fd-table-local. The dtable lock acquires and releases
> > `lock_process::locker`, a process-wide recursive muto that also guards
> > `fork`, exec/spawn, `dup`, and every `open` and `close`. So the
> > pre-fix code let the owning thread hold it forever, turning a
> > transient out-of-descriptors failure (`EMFILE`) into a permanent,
> > process-wide deadlock. That is why it is a showstopper even though the
> > trigger is rare.
>=20
> I've neglected to add a h/t to Johannes for his series of analyses that =
have
> proven to me that often there is much more going on within Cygwin than m=
eets
> the eye.  These comments are invaluable, every one.
> Thank you Johannes very much!

Thank you!!!
Johannes
