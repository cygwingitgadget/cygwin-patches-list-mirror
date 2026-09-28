Return-Path: <SRS0=RROI=HU=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 8D4554BA2E27
	for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 13:53:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8D4554BA2E27
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8D4554BA2E27
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790603634; cv=none;
	b=wnlHeHy5keCw6CNDPjaaCIcOjqKq4mkWJGWIfFQmkP4GVj/EoxQy50lh8Op3Ik5qv74q/LQVHNe0mLwo1TYc/t5AWQ1qDjSbwg2Zenk2jg+3+7EPX3ESRVQQbiPLwu9a2E4VYvuTFJkJ9Emj7Oi5n1ylwl2H/ixRCVkk6BOSfSo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790603634; c=relaxed/simple;
	bh=cRxRufs6jlkFJrtIKg7EM6jILHnC4JJ7lSiY0hquBK0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=YpAaHX/0YD0OzmIswbBimnwByphbu2QRAVZwdtt0rZBBeRBbzre++4EM+U1mDarsr0XTRl5TM7lNxYTy81a5z5RiI6ucOEf+qbr/khvsGp2weu1VlgDT+Ifmos7mSRrK3a+qO9bPsJhQfd4VoMPCdd2CO3mUyswxgDHhpfaq4q8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=WQTkUoNM
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8D4554BA2E27
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=WQTkUoNM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790603633; x=1791208433;
	i=johannes.schindelin@gmx.de;
	bh=RLlXJiDUCQug5GSP1g631Wo4goBeEccykHrZnPGj9Kw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WQTkUoNM1bNCpTprf8+lExnhfQGsu9SP/YaQv+oBUG1qHFBIfMnaSFpglNEiFKyv
	 UGCIjDCCB8sFYRkD7JvRtZr+KdG2JlZCetVOEu9y4NOFPqjwHwXe0N1h4dyQ2oNSS
	 QwWIVdzooAUPJKZWTPBnR1It1opIY0Oz714u/g94tnpvkeR6vSQdjdEWpGCEWGtRS
	 4x6BNAW/zH7vuZ05ZiO6CJaxrqq18O2M24R0xW5FqUcEiVP9UY8o6KczmlGIjoQZE
	 L9twLTs4r0Q6VToEDWRmoIk6TTpdmlEMYhwXcgIEXasV14EWkPfXo2wVNLntSwUUN
	 5V8KWH+gtc4Hwy3L2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXhK-1xNkpv1E0Y-00Y0rd; Mon, 28
 Sep 2026 15:53:53 +0200
Date: Mon, 28 Sep 2026 15:53:52 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7] Cygwin: console: Improve the performance of
 peek_console
In-Reply-To: <20260928194349.a6c32e912c8da406749422b6@nifty.ne.jp>
Message-ID: <9c131746-2780-75f9-441f-29890807e194@gmx.de>
References: <20260927203545.526-1-takashi.yano@nifty.ne.jp> <284d786f-d60c-0350-a8aa-f96779612ae5@gmx.de> <20260928194349.a6c32e912c8da406749422b6@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:dyLucHvzh0ieOoCj75jfovsFN8a/YLB0mfGnwhM3ep5yzPry3Dr
 XLghtlt0ikWJfmDTH5d4SenSGELc/AXtqzq6g+suikINNQeiFPA5qFrv0hAZY4iFjXK75Yx
 2W0WodNAQLMw+T7oFHziKuwin/b4jVVVnfHx9cXML+B543sdpUBPNqRQ1kujkRbVkVZ29bn
 IsDKrAHeljZBHa/J+IWAQ==
UI-OutboundReport: notjunk:1;M01:P0:PeEf+aFPuuM=;HEeCniEKYmIjLwvl50SPGvGcela
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 28 Sep 2026, Takashi Yano wrote:

> On Mon, 28 Sep 2026 09:46:33 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > On Mon, 28 Sep 2026, Takashi Yano wrote:
> >=20
> > > Previously, peek_console() used PeekConsoleInput() to confirm whethe=
r
> > > the console input buffer has some input records. However, this need
> > > attaching to the console if the process does not attach to the conso=
le.
> > > To reduce that overhead, this patch uses WaitForSingleObject() with
> > > console input handle instead. WaitForSingleObject() works without
> > > attaching to the console, so this simplifies the peek_console()
> > > code.
> > >=20
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > ---
> > > v2: Do not remove PeekConsoleInputW() call.
> > > v3: Revert to v1 and check empty buffer in process_input_message()
> > > v4: Handle input_empty and input_error returned from process_input_m=
essage()
> > >     properly.
> > > v5: Set thread_errno rather than errno in peek_console().
> > > v6: Preserve errno/thread_errno as soon as the error occurs.
> > > v7: Do not overwrite errno in input_error case.
> >=20
> > That looks good, with one minor correction:
>=20
> Thanks for reviewing. I'll push the patch with the
> correction you suggested.

Wonderful!
Johannes
