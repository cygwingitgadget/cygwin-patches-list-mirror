Return-Path: <SRS0=M6U3=Y3=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 2F9F5380D589
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 20:47:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2F9F5380D589
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2F9F5380D589
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749761233; cv=none;
	b=QVEEvluW7tIUgHkdPB77B3BwP1XMgERCExauH38B0uf+Qul6wysYQ0EvKJMdx7bG81n8OfGG9KgiM6foAV7GrX4MSx0CLANVqfClLGeNr4Wr+6s6dWtiXEG3d5WaKYVIyGBaPtnTgxxZnXXqGVZJPAAoujpvG9dPECNO8krY/80=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749761233; c=relaxed/simple;
	bh=7UKP91VAq+9ZqcIlCva40sNv+zJk18mtk2QZXqkVBgk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=a5zLTwsYNiqyC5WC4eR9Ne2JKG5LB7MLYx4nUBKY1vBXc+ZVxW3zAzq3+BKtOIww0cA3dp0Xie18/LU00uTo1lbbmGkaXNSy3ahtyqugPxHWuVtt+tJNqSK8kGk8VlSEBL+htc3Ch7R9nQDW0rX2SOwYdc+taJGXpBn0htgwafs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2F9F5380D589
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=oOETSReb
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id C6E7A45CF9
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 16:47:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=4FQWTys/Y+pXwwLipdwx0hNLXtY=; b=oOETS
	RebjlXl+lm9dHDpJP89+WTszXT/Zy50c1Mvm6RTGcGxVS4OSlx47XutJckphoh/N
	Y+M+98/wucxUhvirE4KF26YCgpFK7hjAHZfNR8CHA97mO+Mr5jtIe+kjuykX8t4H
	4rPX685bnzwAMa46In3bzNKnMKfaIKcfNWI1+c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id A9CD245CF7
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 16:47:12 -0400 (EDT)
Date: Thu, 12 Jun 2025 13:47:12 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: implement spinlock pause for AArch64
In-Reply-To: <c03e5943-d622-4381-8ce1-c85f1ffa3c69@SystematicSW.ab.ca>
Message-ID: <e768114d-c2e5-7033-c30d-9991c5982f3b@jdrake.com>
References: <DB9PR83MB09237758F38BC0ACB9AAB51B9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <c03e5943-d622-4381-8ce1-c85f1ffa3c69@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 12 Jun 2025, Brian Inglis wrote:

> Rust apparently uses yield on arm32, and isb (instruction sync barrier) on
> aarch64, as yield is effectively a NOP (although it could be implemented to
> free up pipeline slots, SMT switch, or signal), while isb (with optional sy
> operand) is more like pause on x86_64:

I looked up what mingw-w64 does, and for both arm32 and aarch64 they use
"dmb ishst" followed by "yield" for YieldProcessor().  I think this makes
sense, since you'd want any pending stores to be available before
re-checking the spin condition.
