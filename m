Return-Path: <SRS0=7VsH=WU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id DAA4C3858D38
	for <cygwin-patches@cygwin.com>; Wed,  2 Apr 2025 17:24:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DAA4C3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DAA4C3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743614687; cv=none;
	b=x41j+JXwvkU/al7QIRboCLZpqr6eQ+Pl9Pgb4Ods3QixH+irQY+6v4W0sBi2vqRWQ4ttN13yroP91kc8oifY4ULkdIzqX1PsENy3e6guwxlCheChE32rO3+v76qyXJXIWetlNBBJ4LQo9FjssvvWSi+OmIGHU3XTzfF9YMMVKxw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743614687; c=relaxed/simple;
	bh=5HLBYJifE5hQwSU74yObzoE06KvNMBq9AvgVrYWyj30=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=O4shH0iyyHSk5FwOlhqQyIXLfo98Tql8L/NavEj0O8qH6AmziBb0IGcR7GHu4oE/TGNgMf6jArHs7oE/dCkQzfuoXzbPcluzB6sarg7UC1076u8T4lQZqXuY+Tp3EPWhcP0l7YlwzIbEtOSErRqQUmoxpEhEXsALhDK4RgMOGww=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DAA4C3858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=sqITaM2v
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 83D1245C83
	for <cygwin-patches@cygwin.com>; Wed, 02 Apr 2025 13:24:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=SI45F6c7Acecf7FjJxPNvi11sP8=; b=sqITa
	M2vBAH9M3VtCbtxZQOtt6UY2vZydBAL3oWix3NkCEUbi0Q/m7Qz4gqNLXc+JymaL
	tZog2s52ce3RBq7YUZSepoPlXEIcZleGl8y2cwqAHokXYdX4G7Ytp4T+dbHORtgG
	d14VZ1qnCtvp9fOdZCJjmDHcLBVxbU1e3hLXuU=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 644AC45C78
	for <cygwin-patches@cygwin.com>; Wed, 02 Apr 2025 13:24:47 -0400 (EDT)
Date: Wed, 2 Apr 2025 10:24:47 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <Z-z3Y4RwfkBdIt3g@calimero.vinschen.de>
Message-ID: <18067b8a-4884-0de4-f860-97d765fb061c@jdrake.com>
References: <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com> <Z-pQB1d2It9jkuFS@calimero.vinschen.de> <Z-r0vQTnzdkrCIsq@calimero.vinschen.de> <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com> <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
 <236d3480-bda4-08cc-9ef5-e83ff9f668d3@jdrake.com> <Z-ugBR-lzNL7WxHT@calimero.vinschen.de> <Z-up6Q9eFQ6ir35Z@calimero.vinschen.de> <c302213f-6d65-2ad3-6dd5-b6a887b3ede6@jdrake.com> <c9bbf5d2-8e93-49fe-c19b-a05aef399039@jdrake.com>
 <Z-z3Y4RwfkBdIt3g@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 2 Apr 2025, Corinna Vinschen wrote:

> On Apr  1 22:25, Jeremy Drake via Cygwin-patches wrote:
> > I changed the code to use the struct directly, and amazingly the dll was
> > the exact same size after stripping.  I then tried building the udis86/*.c
> > with -ffunction-sections -fdata-sections, and that resulted in a *larger*
> > dll.  Building just udis86.c with -ffunction-sections (in addition to the
> > struct access change) resulted in a 1k savings.  Instead #ifdef'ing out
> > the unused functions (including those now unused because the struct
> > members are read directly) in udis86.c resulted in a 2k savings.  In
> > addition to ifdef'ing out functions, building all 3 udis86/*.c files with
> > -Os resulted in an overall 4608 byte savings in stripped dll size.
>
> Yeah, that doesn't make sense.  No worries, don't put too much time into
> that.  But thanks for looking anyway.

NP.  I'm thinking I'll send a patch for the struct member access change
for consideration anyway, I think it's cleaner (I used some const
references to keep my short names insn opr0 and opr1 instead of
ud_obj.mnemonic ud_obj.operand[0] and ud_obj.operand[1] respectively)

I also had the idea to sort of "change my perspective" on these functions:
instead of looking at these conditions as "sanity checks" to make sure the
code hasn't changed, and bailing out if it has, instead look at them as
"guideposts" to find on the way to identifying the correct pointer.  For,
instead of bailing if the first lea is not loading FastPebLock, keep
looking for an lea that does.  Actually, now that I think about it, for
x86_64, that's probably the only one that'd change.  After that, we'd
still need to find the first call after that value ends up in rcx being to
RtlEnterCriticalSection, and then the first mov rXX, QWORD PTR [rip+XXX]
being immediately followed by test rXX, rXX.


I think the aarch64 code could be improved in this way also, I seem to
recall when I did the prototype immediately looking for the ldr of
RtlpCurDirRef and then looking for the other operations and returning if
they're not found.
