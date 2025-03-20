Return-Path: <SRS0=0OHw=WH=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 256A63857B9F
	for <cygwin-patches@cygwin.com>; Thu, 20 Mar 2025 20:01:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 256A63857B9F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 256A63857B9F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742500911; cv=none;
	b=oFEQVYyPXM6T5YmgKmRnbQ1msJHZeqdTramGji0+keOd6PbLD7kup9Z31j7p0yiMi5874lUctaTKT9aUWQlzXyp+hTBhIXJI+dmvFyBstjlQgom10CywWylohi4oz55/ETbE7xOfc0wZt+h4KSNnkrdCQ9KClMWN3RjPOzxM4sY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742500911; c=relaxed/simple;
	bh=+KSZx2eKWMv1U0JLCwAWrRuHutfEjXVs85ie5WLuFqg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=eIv9jXuo7W/7tNKygDpPRzc7Fp88SJsgBWZ/yqrdiUJtidsQTZrMJwxb/owLQuNmkLw1x3W5T74x2hf6FqKQQlBp7Aa9URyv9ZIfQZvMUTPKZ4e2BQs30oEU7wSPaaRN0YIUeFshCAsVRBIe8fPANH73svDkbSaXu5L2TvcICRs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 256A63857B9F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Ic4vO3Gn
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9EFEF45C83
	for <cygwin-patches@cygwin.com>; Thu, 20 Mar 2025 16:01:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=YWGoqXDpigL7DkAlJmjggMl3rYY=; b=Ic4vO
	3GnlskfHebVxJbHwDd2I9MUnx8Id4Zo9j88zqHiGnrfufH9LUALjyKBmQeHrfmS2
	B2pcWNEtjacwd+gXwGVyJ+ID3sDjduhcp6ATz6n4TjvoGmw/8AQQlcWpuB4fOoeQ
	pM1bTdcASU7RCG8EdVBYyCeRmlW6ZoOuTuoLnA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9A08F45C82
	for <cygwin-patches@cygwin.com>; Thu, 20 Mar 2025 16:01:50 -0400 (EDT)
Date: Thu, 20 Mar 2025 13:01:50 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: Use udis86 to walk x64 machine code in find_fast_cwd_pointer
In-Reply-To: <Z9wgpVqrlTML8Mq7@calimero.vinschen.de>
Message-ID: <62ec041c-a21c-2a38-4bf6-3853b504057d@jdrake.com>
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de> <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com> <Z9k9OcYu5Y47VsjU@calimero.vinschen.de> <e63f40de-faf7-2187-9f13-7bce6f7d7238@jdrake.com>
 <Z9nIRlpIEfAbNoJ2@calimero.vinschen.de> <5097ccfa-83f6-c76e-6c59-28c876cc2db8@jdrake.com> <Z9wgTR92yo4P24Ze@calimero.vinschen.de> <Z9wgpVqrlTML8Mq7@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 20 Mar 2025, Corinna Vinschen wrote:

> On Mar 20 15:03, Corinna Vinschen wrote:
> > On Mar 18 22:11, Jeremy Drake via Cygwin-patches wrote:
> > > On Tue, 18 Mar 2025, Corinna Vinschen wrote:
> > >
> > > > Subdir of winsup/cygwin, probably.  What I'm most curious about is the
> > > > size it adds to the DLL.  I wonder if, say, an extra 32K is really
> > > > usefully spent, given it only checks a small part of ntdll.dll, and only
> > > > once per process tree, too.
> > >
> > > I did this with msys-2.0.dll, but it shouldn't matter as a delta.
> > > all are stripped msys-2.0.dll size
> > > start:
> > > 3,246,118 bytes
> > > with udis86 vendored, but not called:
> > > 3,247,142 bytes
> > > with find_fast_cwd_pointer rewritten to use udis86:
> > > 3,328,550 bytes
> > >
> > > (I know the second one isn't realistic, the linker could exclude unused
> > > code, I was just kind of curious)
> > >
> > > This is with all the "translate to assembly text, intel or at&t syntax"
> > > and "table of strings for opcodes" stuff removed to try to save space,
> > > still a net increase of 82,432 bytes.
> >
> > The DLL has currently a size of 3 Megs, optimzed, stripped.  82K are
> > two more allocation granularity slots, 51 instead of 49, about 2%.
>
> 4!  4%.  I said 4%, right?
>
> *facepalm*

I'll take that as "patches welcome" :)  I'd also like to take the
opportunity to add ARM64 support based on my PoC, but I feel bad about
dropping another blob of code into path.cc.  Would it make sense to rename
to find_fast_cwd_pointer_x64, move it into a separate source file, and add
another source file for find_fast_cwd_pointer_arm64?  Or I guess put both
into a fastcwd.cc and #ifdef __x86_64__ the x64 variant (that will of
course always be true at this point)?
