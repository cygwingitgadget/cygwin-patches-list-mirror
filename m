Return-Path: <SRS0=6WXN=ZQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C4F4E385213A
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 18:06:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C4F4E385213A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C4F4E385213A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751565991; cv=none;
	b=AIR3RWLYLYUjOADYPi7G3QvusCQB6elofU2E0t6WjW2cbnq5u1wGly/o/GVVqaNwlyyCBzoG4DeoGdATJTZv1atfIAaEE3momt1KwoPRm60uRU/oOWeX4FMKIouyfMMAt5q/oJZhQDYJRUdf16ffjQzi4fh3iDC3QEyz+WjXXFw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751565991; c=relaxed/simple;
	bh=+ARmi6w6oKrqVabFH1osC2UtuwiYX/gHHPXL+x6zM7w=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=JR5bLnqW9QBafzHSz578ipZbm+BN5ks9kUmLZ/nVn0jQSo4bLNayMVB4v/eho1EzqihLS/72hiMQEprct9dPRJBWaSk9/aolbOw2DZT3kLyQGV1xTiRkHkZpfv0586UH4yrEy+O+8rqEKNHLuYzIHpjylzkzoXt56/uBrJbUBUU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C4F4E385213A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=lL7WKbpU
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A0AAC45CBA
	for <cygwin-patches@cygwin.com>; Thu, 03 Jul 2025 14:06:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=cY2I3x4zxqkUz5ANtFMrpK89LuU=; b=lL7WK
	bpUTFRfrg3KC3GliT4cp9i3jKJOa3vNMm/zQBbwIZ1lXyGvCEvDNLLWAtRpdn59F
	yTwr/DLEtC1C9XG49p6EN2BqQ0OYctKvyrIhpSa1TH0+Bn+W/ntHSE419VHtBmye
	u6HhQlB4vI/aFSpyYL1Xv8Zx3a7z4hchNoaU3M=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 987C445CB2
	for <cygwin-patches@cygwin.com>; Thu, 03 Jul 2025 14:06:31 -0400 (EDT)
Date: Thu, 3 Jul 2025 11:06:31 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to
 spawn
In-Reply-To: <aGaIblK4MDa0AHPq@calimero.vinschen.de>
Message-ID: <6ff55395-7a18-0995-7b16-7bf2e7655370@jdrake.com>
References: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com> <aF6OibgUJ3IUvmLN@calimero.vinschen.de> <9555bc63-d6ae-e1ad-6b94-82712e1e9f2b@jdrake.com> <aGJeJH1rLCeitrqo@calimero.vinschen.de> <8d3b0ebf-4766-cf94-13c0-8176a8ac3da7@jdrake.com>
 <aGUMafwtImU7wGrZ@calimero.vinschen.de> <1fd4e2b5-bbcc-4f5f-0085-c3138bdc914c@jdrake.com> <aGaIblK4MDa0AHPq@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 3 Jul 2025, Corinna Vinschen wrote:

> On Jul  2 10:37, Jeremy Drake via Cygwin-patches wrote:
> > On Wed, 2 Jul 2025, Corinna Vinschen wrote:
> >
> > > On Jun 30 10:11, Jeremy Drake via Cygwin-patches wrote:
> > > > On Mon, 30 Jun 2025, Corinna Vinschen wrote:
> > > >
> > > > > On Jun 27 10:34, Jeremy Drake via Cygwin-patches wrote:
> > > > > > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> > > > > >
> > > > > > > On Jun 26 13:31, Jeremy Drake via Cygwin-patches wrote:
> > > > > > > > BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
> > > > > > > > -Wl,--disable-high-entropy-va in LDFLAGS?
> > > > > > >
> > > > > > > Why?
> > > > > >
> > > > > > With high-entropy-va, it has been observed that the PEB, TEB and stack can
> > > > > > happen to overlap with the cygheap
> > > > > > https://cygwin.com/pipermail/cygwin/2024-May/256000.html
> > > > >
> > > > > Yeah, but HEVA simply breaks fork.  We don't have to test this, because
> > > > > it won't work and we don't do it.  You can set the PE flag, but than
> > > > > you're on your own.
> > > >
> > > > Outside of fork, is cygheap able to "relocate" in case the memory it would
> > > > like to occupy is already used?
> > >
> > > I don't think so, without checking and, well, fixing every pointer usage
> > > potentially pointing into the cygheap.  Even fhandlers have pointers to
> > > fhandlers...
> > >
> >
> > So shouldn't any user of the cygwin dll then need
> > -Wl,--disable-high-entropy-va to avoid the chance that Windows places its
> > structures where cygheap wants to be?
>
> -Wl,--disable-high-entropy-va isn't required because gcc doesn't enable
> it by default on Cygwin.
>
> If newer versions do, it's a bug in these gcc versions.

cygload is built in the mingw directory, with the mingw cross toolchain.
