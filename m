Return-Path: <SRS0=jaUm=ZK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 07623385AC2E
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 17:34:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 07623385AC2E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 07623385AC2E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751045694; cv=none;
	b=WDjJTVcxZlHap4m/QwAQjmjnwpFXRDzD5r31hCjOPME4iWLAvQ2MyTUE7sAU8lV2XgrrjT/s2LBFiTlP2T7mE6LnFldaStwsWQKDiTbYu6VUrbIZvzDuuduNWXdh4rgeMpt82K5aJm5nYTj/e8KTuSY2mlk5SrYzSYSQnu1n/W4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751045694; c=relaxed/simple;
	bh=C7/+U3qcc7v9Rs3FZv+SpBJiGszNu9vslrxEyy2bIYw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=iSe/jO89KxpIy9ZnfMFNIQJEhsTereProukxoTVwTJjVDFQ956tDH34Iz3BDpR2y7Kq8sjJlO1SvII4omSkaT1VzzNnM8ZlBobM2uWaXJpUoVHFXHL4NzVYF/UDioEsaBanXOQZudDBUw5r3n8KoTZq4tE3SGm6l0VQozJ3NtW8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 07623385AC2E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=zs6SQ2pB
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id BA70F45D28
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 13:34:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=vM6Z0TQY7j4/GcDsrN/RJt5fAxs=; b=zs6SQ
	2pBK+sUP9GfcEqLhTi1EaOuOWenLEftfW7ScvAp/nEEE5wKbShlhH16UOAL9xXY4
	9kp215b5ORKAOLXKzlrawM1PDEDVaCeHGVhoRlmyEq2RTLmCKIgX5RL9ikZeG36o
	9FA0IeX/bcHpn88Xpdz0XIDf0+nIBZkdZ4NJQE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 95A1845D24
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 13:34:53 -0400 (EDT)
Date: Fri, 27 Jun 2025 10:34:53 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to
 spawn
In-Reply-To: <aF6OibgUJ3IUvmLN@calimero.vinschen.de>
Message-ID: <9555bc63-d6ae-e1ad-6b94-82712e1e9f2b@jdrake.com>
References: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com> <aF6OibgUJ3IUvmLN@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 27 Jun 2025, Corinna Vinschen wrote:

> On Jun 26 13:31, Jeremy Drake via Cygwin-patches wrote:
> > BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
> > -Wl,--disable-high-entropy-va in LDFLAGS?
>
> Why?

With high-entropy-va, it has been observed that the PEB, TEB and stack can
happen to overlap with the cygheap
https://cygwin.com/pipermail/cygwin/2024-May/256000.html
