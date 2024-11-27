Return-Path: <SRS0=5dpU=SW=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 770C23858D37
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 01:25:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 770C23858D37
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 770C23858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732670732; cv=none;
	b=Ec0S1hLpO3Calwr0kywLX+NZ8yAECdSrCWlVjum7ewHM2yRUiDk2YUSjw/B0oIeVvtXi8ayYpF9P7nqKhvKiXKvd94g4AFvCyTZhbyF8/1RvxJ8eN9hmogPBDla8X67P5wspGk/Tk2Y5EtMa010MFoScQrx1q2CFsipay9BC3qI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732670732; c=relaxed/simple;
	bh=MzUnTaDmzdV6Go42qzVE64phhYB/dxm5H8Zb6qN4evk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ZAd9o9l70QSyi/2KOllIqnLnEtIqFioNWbMoM1DFF4u+NCsTkAkEL9RkVHO7GW/Tvks3AD0CAAv2NXuvKIKNi53ZL59qjdspZmQZEY5GB1mydS9KuLdgFicbxZv+8o/CTbCXZloHdB83+ujJ4XfKg0J+Y2V3KLa785H1EVD1Lak=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 770C23858D37
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=iVPg7obE
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 16A8A45C95
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 20:25:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=5Z/T81QGgo8RLzNt5hqzYk3svKE=; b=iVPg7
	obEHGk3neLSAHMjXSpi3dnELCpDX2vYvvYi+qWPPzKb3E67XVo0G1/AmmEK1K8vS
	xv0Kl0QF/N0rkCE1mHev/F74pACNkOAp6DYrldV8pioHQ3CdHqkYusQ15EzcyqH9
	0NtTrie9sDJfMdFpZiuw/y/jnw63ZcDjWpaMZY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D063145C3D
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 20:25:31 -0500 (EST)
Date: Tue, 26 Nov 2024 17:25:31 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: finding fast_cwd_pointer on ARM64
In-Reply-To: <59f580ca-bded-6d45-c624-fd1ca13bd744@jdrake.com>
Message-ID: <ec73a729-57e8-11f7-78be-ab78bde6c0a6@jdrake.com>
References: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com> <Z0XOOW365ff53K6B@calimero.vinschen.de> <59f580ca-bded-6d45-c624-fd1ca13bd744@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 26 Nov 2024, Jeremy Drake via Cygwin-patches wrote:

> On Tue, 26 Nov 2024, Corinna Vinschen wrote:
>
> > Btw...
> >
> > We're doing this because nobody being able to debug ARM64 assembler came
> > up with a piece of code checking the ntdll assembler code to find the
> > address of the fast_cwd_pointer on ARM64.
> >
> > You seem to have the knowledge and the means to do that, Jeremy.
> >
> > Any fun tracking this down?
>
> Ha, no, not really.  I looked into something similar trying to get Ruby
> running on Windows on ARM64, and learned enough to know that how ARM64
> encodes addresses is odd enough that I didn't want to dig further ;)
>
> Somebody else did end up implementing getting a private variable (out of
> UCRT) by looking at ARM64 assembler, maybe that could work as a starting
> point?
>
> https://github.com/ruby/ruby/commit/784fdecc4c9f6ba9a8fc872518872ed6bdbc6670#diff-883ccab70529ab9c4e51fa7b67e178a205940056b21cd123115ebadd8029f50f


I had a quick look in the debugger, and it's even worse than that...

First, because we're running emulated x64 code, the address returned from
GetProcAddress is an x64 stub, presumably to exit emulation and call the
native function.  Ok, not too bad, there's a jmp instruction in there to
the ARM64 function...  In RtlGetCurrentDirectory_U, again pretty
straightforward, first call is to RtlpReferenceCurrentDirectory... In that
function, however, is where things get intesting.  It's still much the
same theory as described for x86_64, however:

1) note that loading an absolute pointer on ARM64 involves 2 instructions.
The instructions getting the address of the fast peb lock and the fast cwd
pointer are actually *interleaved*, the upper bits of the fast cwd pointer
are loaded before the upper bits of the fast peb lock, but the lower bits
are not added until *after* the RtlEnterCriticalSection call.

2) the registers used differ between Windows 10 22H2 and Windows 11 23H2
(these are what I had handy - who knows what other versions do).

Also, because of the x64 stub thing, the address you'd get from
GetProcAddress for RtlEnterCriticalSection would differ from the native
RtlEnterCriticalSection actually called by the ARM64 code.
