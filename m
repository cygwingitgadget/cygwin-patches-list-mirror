Return-Path: <SRS0=/5EK=VD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 479CB3858432
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 22:06:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 479CB3858432
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 479CB3858432
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739398006; cv=none;
	b=RJykuNKEBw2H9wh3FbG28L2vcyA3FDD9Q6SCdVi2tVETJFaDwyvnoqb17DtmUVYDXGeQA9lGZHV53A77nRTw0BKjlmbFuOBlUfIzHrARUW3rYb683haVsTJJg52XWWluPkOwJkHPXIan/WhIQrR62oLetO6A/cmiFv258hsmIXM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739398006; c=relaxed/simple;
	bh=ZCn766HXCPtpNrTZa8vY4z16UpbAoo+wSdkyl32mFKI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Pvx3XfdFbpvO4TkSgfyl+OZQ4qUSAFimzOGRJt1ijprKVlDPnKpUYAw0DqiHAu4M6mT81H0FvsFG7+mkfZCQqwjUUsBNESEm3/eHpjP5imuvUuDZo422G5l7Fhn32tWmRfrXfsYCDCNbF6EGO+T2lXTgntwSJS3Mjc2Cz4IPApg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 479CB3858432
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=1K44vBNH
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 10E7E45C1D
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 17:06:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=n7TnWNAup/mw495Gfh1OsKxrJqg=; b=1K44v
	BNHG5CijMzN5n4yAXBUrRp8sTwxxZe3ZaTwrqDu7DUnf+eMM3LNwZsQci+Zcu8ln
	/qHIN5nU5okdXI26p8TVOaYfiPm0xzp+Cw5/3JNckBsJdremBAQ1jD3ue6fT8Ob9
	lxNK3b6taa4ivEaHSke4tfTtW4Bp0Fn0PlerO0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CF08445BF6
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 17:06:45 -0500 (EST)
Date: Wed, 12 Feb 2025 14:06:45 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
In-Reply-To: <9fd9ec5e-f9a5-d510-2792-3e0ca24e3f11@jdrake.com>
Message-ID: <522175b6-08ed-9929-3705-aaadf30283ff@jdrake.com>
References: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com> <Z60QiLIEAvDzSs5k@calimero.vinschen.de> <9fd9ec5e-f9a5-d510-2792-3e0ca24e3f11@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 12 Feb 2025, Jeremy Drake via Cygwin-patches wrote:

> It was *supposed* to not return the second one.  Maybe I broke it when
> trying to break out of the loop early...  I will test this scenario and
> see why it doesn't work as expected.

Yeah, I never actually looked at how posix_sorted was sorted.  It's sorted
by length first, then by strcmp.  This was probably a premature
optimization anyway.  conv_to_posix_path doesn't try to bail early, it
just continues, and that's going to be a much more common code path than
this...
