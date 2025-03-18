Return-Path: <SRS0=rmGi=WF=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id DC2D03858CD9
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 17:45:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DC2D03858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DC2D03858CD9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742319956; cv=none;
	b=bCgzpP6v84JQj35wpmEwPhsiIMe8rV+kpqeVZP0VK2ghVQsPLFbBN2FlMk5gZ3YRhPdyrs0gUGxOp65vN/QTfk/KzH6RkJWHtjIP/sg6EdrrEPrPJPxxOGGscr2KN0wvWqyey4JjYZD5RUXYlZ3eF8bl/SFSknLMkNgzpQGJFdc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742319956; c=relaxed/simple;
	bh=7h7dlmh+Rsm0283+BiNk3yFJC5HSA1fkpG7EGgNiqt8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Powj524pQABPsbZ45AWptiQJgEdFl/I7xfmDDHMH6Of9eRHVgBdbNnoeWedaDxK6UKJiFquqU1xGXOlD4S8X5LmzzLXi9PtT7qgweUX/F/7gbQ0VntjU+2KHe3kANG1FLZw905YoAK0AH3wWXMvkfG0RMZpJiTMzpYqA0pC9+TM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 36DFD45C6C
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 13:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=8NiJG/aj5sT9KSyEl1W/JCmoBPA=; b=qn2R5
	LBkM7SQGNu5/cSArBk3mwOFAwSx3M/7yIp7cLsFv4EO1ac5Z698adaOGG/dfrX6a
	XW5XYLyj/P5o/6hv94ScO6arwcTIUj5YnjAFR5KTi0IO/g3hFgs7Eb8qp4zFdvgd
	DdITVhQvDvG4bwFoAU4OuhMjaqVdW6GZtS66/g=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 31EBD45C64
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 13:45:56 -0400 (EDT)
Date: Tue, 18 Mar 2025 10:45:56 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Adjust CWD magic to accommodate for the latest
 Windows previews
In-Reply-To: <Z9k9OcYu5Y47VsjU@calimero.vinschen.de>
Message-ID: <e63f40de-faf7-2187-9f13-7bce6f7d7238@jdrake.com>
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de> <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com> <Z9k9OcYu5Y47VsjU@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 18 Mar 2025, Corinna Vinschen wrote:

> On Mar 17 17:39, Jeremy Drake via Cygwin-patches wrote:
> > Since you kind of asked, here's a proof-of-concept that uses udis86 (I
> > left a whole bunch of pointer<->integer warnings since this is a PoC).
> > Tested on windows 11 and 8:
>
> Cool.  I like the idea.  But obviously, this can't make it into 3.6
> anymore.

Right.  So the next thing to figure out is how to include udis86.  It is
BSD 2-clause license, so that should be fine.  The way I see it, we could
either static link it from a Cygwin/MSYS2 package, or vendor it.  I keep
coming back to vendoring, there has not been any activity on the
repository in years, there are only a few source files in the library part
of the code, and of them several can be left out because we aren't
intending to generate disassembly text output.  There is also a
"standalone mode" macro that gets defined if built as part of the Linux
kernel, which suggests we can define that if inside Cygwin also.  We can
also reduce the size impact by removing/disabling the mappping of
instruction mnemonic enum to string since we won't need that either.

If I want to try that, would it make more sense to drop these files in a
subdirectory of winsup/cygwin, or winsup, or somewhere else?

Should I be moving this discussion to cygwin-developers?  (that list
doesn't seem to get much action, and the last time I used it I got
redirected to the cygwin list).
