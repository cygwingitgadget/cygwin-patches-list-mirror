Return-Path: <SRS0=ezLI=ZN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 05D303854ABE
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 19:18:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 05D303854ABE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 05D303854ABE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751311103; cv=none;
	b=KaCjCKASasu2a5uiaaSAM4iLl8M56C9rPx1RYSOK24QLzfo+PrrJilGba8XIfw37JyjoMsVFV5UH73zB+f/wUObX70+Jkj7nqi8O8JzI70ZdLDiIMWaWeEsQPgX1hzsKbmHkGPJb98byKHWU+mi8fvvw8w8MPxdoZKwS+eg1V8U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751311103; c=relaxed/simple;
	bh=1hCXlyrV5ALXrwTZLvbcRGw2X2eOGzV0Bt53MSyOn6Y=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=cyuT0pX+rrpWhmOAOeS1zQE2AUCJi2N3FYqu2xmeWLhCMqfgp3t4efqsjibMveaasdxUU3kGjoWkLV2XiPO53Ag3mY3LY+TMKHHYZHgJQo4mWfI7lIW6hw5Hin9RHgLi9f6KDOm3F5yCwrhvBmDq9GZS/6J8ZNHJYJ6GeuQJres=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 05D303854ABE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=aZuBNOqX
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CD6A345CC6
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 15:18:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=589S4YH/AjhjgydL+4kEudHq3zw=; b=aZuBN
	OqXGlglwLqq4Sczsgc9BqUsClZWBm+rezEAzjEpbWJdAL+QbuMfFOHlacJxnNPpB
	JE0PsDHAKr8XZcTLa8nYfW8cmoWL3JoXGWYYc0mVZEzQSBoFMjuF3fBZXvlcpWYu
	vopHkZ4xjjtxDiQsS4D2007ujssc3io1bx9X60=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B6FF745CC4
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 15:18:22 -0400 (EDT)
Date: Mon, 30 Jun 2025 12:18:22 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: allow redirecting stderr in ch_spawn
In-Reply-To: <aGJe8j_E8aitHVoE@calimero.vinschen.de>
Message-ID: <6d39964a-ca56-e76c-0076-90ed7694aa73@jdrake.com>
References: <cb938c47-80dd-78c6-876f-7a36112960af@jdrake.com> <aF59GwzNozRYeAp4@calimero.vinschen.de> <aF6Qoq0yXMg4z3Jo@calimero.vinschen.de> <e3b78bde-3b2e-cdc8-0319-fda17c47579e@jdrake.com> <aGJe8j_E8aitHVoE@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 30 Jun 2025, Corinna Vinschen wrote:

> On Jun 27 16:32, Jeremy Drake via Cygwin-patches wrote:
> > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> >
> > It's getting kind of silly how many args this function has.  The
> > construction of this function (using placement new to reconstruct "this"
> > inside worker) is kind of awkward for using members and setters (though
> > this was done for the posix_spawn semaphore).  Might it make sense to pass
> > a (pointer to a) struct/class instead?
>
> Kind of like CreateProcess :}
>
> But yeah. I'd suggets to keep the first three args (argc, argv, envp)
> as they are and add a struct as arg 4. This way, all args are passed
> through registers.

darn, one too many args (mode) so that most callers could not need to use
the struct.  I'd suggest moving mode to the front and putting envp in the
struct, but all existing callers do pass envp (it seems the various exec*
and spawn* variants all funnel down to one that passes environment).
Could pack both argc and mode into one 64-bit arg, but that's too ugly to
seriously consider.
