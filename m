Return-Path: <SRS0=KLwD=WE=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id A80F2385B531
	for <cygwin-patches@cygwin.com>; Mon, 17 Mar 2025 18:26:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A80F2385B531
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A80F2385B531
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742235967; cv=none;
	b=Xaq0rpeKUndM/nSM8tKSKmQpWYwg7HJFXJnldhR1nHNLNJDggLLW8Hd3OIDSiGMn1hBnMIy2MLr8Pri2elRFmUPCgimri+QH6i0o/6wSGso3IzcaIWeQY43HLsF31QUQXe0yxufocoeQXX3Ftpwo4rpAKvh1XgjeIDhr/Y6iMYs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742235967; c=relaxed/simple;
	bh=SfO69+sffDJoKhT5iYkiLUc9i1/ZktEv1JjCrOBwSUk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=S7zm3DHRHs6HmKbHo2tzjAO37iiMYElf6VlvXeiR3cdbYRuiyw1ZR4BaPFsQc3nqH/Zyf1PkoSk60bTHfe02RF9468DxhDaUlx0GZoeMkuekRf2BdkRkPE604WwjsGg0acD5xltA7AkhreotFBQ6pf5sVKZkIfP0s6jg9qkvQ0E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A80F2385B531
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=a9iM8rPb
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 95F2F45C8D
	for <cygwin-patches@cygwin.com>; Mon, 17 Mar 2025 14:26:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=vWy2I
	iNt6Ei3bmkvcLpoKUhf7bE=; b=a9iM8rPbspnaOBWIdKo00Wwurg+gBw01zkJN1
	AcgnV+QDPg82ccy4iVV8e6Tj+vb7G9om+G6+AF4rvwFZbvyFsiCDkshjqUBWUNyz
	S5yK2hHy1M037HmUFGU/LyUs7tCSKVgfjZLTFRno5GDJEdO1IZBoYkp7qrkUjktk
	vR0eMQ=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7E7ED45C8C
	for <cygwin-patches@cygwin.com>; Mon, 17 Mar 2025 14:26:03 -0400 (EDT)
Date: Mon, 17 Mar 2025 11:26:03 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix native symlink spawn passing wrong arg0 (fwd)
Message-ID: <715c0684-765a-2dc7-253c-80279c9357f6@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---------- Forwarded message ----------
Date: Mon, 17 Mar 2025 18:23:32 +0000
From: Chris Denton <chris@chrisdenton.dev>
To: Jeremy Drake <cygwin@jdrake.com>
Subject: Re: [PATCH] fix native symlink spawn passing wrong arg0

Sorry, missed this. I'm still getting the hand of email pathces.

> If you just agree here on the list, I will do the above changes manually.
> No reason to send another patch version.

I agree to changing the Signed-off-by to me personally.
Chris Denton



---- On Mon, 17 Mar 2025 18:15:22 +0000 Jeremy Drake  wrote ---

 > On Tue, 11 Mar 2025, Corinna Vinschen wrote:
 >
 > > Hi Chris,
 > >
 > > This was a bit of a puzzler for me, given we added the PC_SYM_NOFOLLOW_REP
 > > only 2011 with commit be371651146c ("* path.cc (path_conv::check): Don't
 > > follow reparse point symlinks if PC_SYM_NOFOLLOW_REP flag is set.")
 > >
 > > I think we should use this patch for the "Fixes:" info.
 > >
 > > > Signed-off-by: SquallATF squallatf@gmail.com>
 > >
 > > Hmm, on second thought, we can't do that.
 > >
 > > Given you provide your own version of this patch, and given that this is
 > > a trivial patch, I would prefer your personal Signed-off-by.
 > >
 > > If you just agree here on the list, I will do the above changes manually.
 > > No reason to send another patch version.
 > >
 > > Ok?
 >
 >
 > Ping?
 >
