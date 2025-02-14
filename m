Return-Path: <SRS0=cBQE=VF=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 58BE73858C32
	for <cygwin-patches@cygwin.com>; Fri, 14 Feb 2025 00:27:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 58BE73858C32
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 58BE73858C32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739492860; cv=none;
	b=tQ7a1TlXRFhx4nd/ooiV7K2kucsYQU0sIbBRgs4YSwWvq3wZQ0b2sM4b7Ow6IC5CVOo4YWgukicl1X1ZVLX3zfLikqJIkwKiHBMZpNblwSVL3fIroRGLxbtBbur7WKNAFx9ybnzCZXy3fOd6CAa42unYXQI5a7OPLsU4KmMqLPg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739492860; c=relaxed/simple;
	bh=WbARDVB03F4pYva/CgS8ToFDtpibj07JWJisg/YGMz0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=BGaSJCNiovNcqHAQVS0WO+yoV/Sv1MD2sxNKmDX2+BaM5QdaFPwmhHretB3Zh5Ofwr0N3iAj+y0x6SQIQ6LP9kLqWRXIB98va9anb6rrfOPMkCay9Maf0RWRGUNa2onWlhxJUSSWfQfWeNF6Tn9vb3Ss344Ggk1pMtJrJITHFf0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 58BE73858C32
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ckeYPHvX
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2C74D45B2C
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 19:27:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=kjQwWuHIfRojLE1e/cJ/ooDz+bk=; b=ckeYP
	HvXHT/U1CSD1z/N22NTa2Xe3EtJu0AC72h+C4uU9c5auoVEy8CArQREtsTNueymz
	+7UaJeI+p+0UUe6i4bEVD8d6bVrc0vkjPNfERpjoc5BQFsbu/Atw1dEfOFo86Xaz
	iznEaARVZAkf572Zr13iFn2d7xb5Q7G5WNe3bw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id EF07245AFB
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 19:27:39 -0500 (EST)
Date: Thu, 13 Feb 2025 16:27:39 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
In-Reply-To: <Z65EIr3quZyhFWRu@calimero.vinschen.de>
Message-ID: <36cb1004-0f77-2676-c948-c5dd81bae7a6@jdrake.com>
References: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com> <Z60QiLIEAvDzSs5k@calimero.vinschen.de> <9fd9ec5e-f9a5-d510-2792-3e0ca24e3f11@jdrake.com> <522175b6-08ed-9929-3705-aaadf30283ff@jdrake.com> <ed1a01aa-8908-47a2-70e2-b955c65962c0@jdrake.com>
 <Z63-eTxbCyo65Jlj@calimero.vinschen.de> <Z64Cm3wHdcgw__6U@calimero.vinschen.de> <1ad8846b-2a13-b0d4-f70f-e1413bc48fcb@jdrake.com> <Z65EIr3quZyhFWRu@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 13 Feb 2025, Corinna Vinschen wrote:

> The new behaviour makes more sense, actually.
>
> Pushed!
>
> Would you mind to send a patch with a release message we can add
> to release/3.6.0?


Sent.  I also documented my other patches that only seem to be on the
master branch (ie, not backported to 3.5).
