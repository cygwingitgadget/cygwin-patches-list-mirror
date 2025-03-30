Return-Path: <SRS0=WO2z=WR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 4FF393857704
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 22:37:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4FF393857704
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4FF393857704
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743374270; cv=none;
	b=aRiX16Koq4Tp5aGxyZRWYxmlAPZHVxv6piSaoDsPBWstw7+8DHFAlLoq7cJNhZPYq2fLxKkUmwmGRPE4Fy10HujhcXp9vKv13Z7Fk2Cm2msa9JUUGZxkopwLOQUFVa5Cff6MzcGqH71TMCyYEbyUN9so/CTb1fUR1aQz5S17+QQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743374270; c=relaxed/simple;
	bh=EzG2P9dA4qdPMAVyPo5UB2NMngecQDLj9zhcrjOYoc8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Do4YGTMLo+MfLH0ehklcvX5yoLXBexGEFvfk3B5k7K+cYJijyrZgDvfKm1MG4PWyNL+TtqNJvJtuiiql/p8tuRRsmsIZ0GZgTkMRT7LACztbsQNoYuR2/5N5i6lPiAM73eErgYHrJ6e0EEwgfAhvs18R4dmebRyt37syReTX/r0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4FF393857704
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Mb0MTaH/
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id BD8DA45C90
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 18:37:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=RDtlALEa7mAeHN3XUTogUbN8Bng=; b=Mb0MT
	aH/f+51bJSqeSsi7JDvI26r1jK1Q9pYT1mC6ajkKCZM8uZjLbA8rO4WKcSN794QB
	zqyPSE3tKUb+PALGroPdpvIC1selxop+852BCCT+sTQRElwcgzrG5//JZA6Lsu29
	SozLDGBl6pWOsJZJwZHwmU3AgrmcSU9/4gzpmg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id A46D445C8D
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 18:37:49 -0400 (EDT)
Date: Sun, 30 Mar 2025 15:37:49 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <Z-m6ISyTeTULAWXf@calimero.vinschen.de>
Message-ID: <05c46ee2-4946-c109-bc96-fa38a2a759ce@jdrake.com>
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com> <Z-m6ISyTeTULAWXf@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 30 Mar 2025, Corinna Vinschen wrote:

> Hi Jeremy,
>
> Series looks good to me, just one question to clarify:
>
> On Mar 29 18:54, Jeremy Drake via Cygwin-patches wrote:
> > v4:
> > fixes x86_64-on-aarch64 on Windows 11 22000.
>
> Does aarch64 use entirely different build numbers?  Just asking because
> 22000 looks unusually low.  The latest release build of x86_64 Windows
> 11 has build id 26100...

No, I just don't have build 22000 (original Windows 11 release as of 21H2)
as part of my usual test matrix.  I normally just test on Win10 19045 and
Win11 22631 and 26100 and assume the out-of-support 22000 is OK if those
are.  Unfortunately for me, 22000 was the first (released) version with
x64 emulation, so it was more relevant than ususal as a version that might
be (and is!) different from the others.

> Thanks,
> Corinna

