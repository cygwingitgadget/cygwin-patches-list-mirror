Return-Path: <SRS0=ezLI=ZN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 00CA3385DDD6
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 18:57:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 00CA3385DDD6
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 00CA3385DDD6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751309839; cv=none;
	b=E9RYKRcjqRmBJyHrC5r6E8UAygI1gEWI9B7gfU4npJVQL6ZX4RYZwi0WbrXQsjpRfL+YDsHBGvcamRDfX+pH8jvjKMRpbA1npPI28Sx0A/OpToLnTjt+fE6w0yhATtikyIhI7hO5h4FqK95L9Pp0RtIYCOPJZKGYxeZtCIjLgLg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751309839; c=relaxed/simple;
	bh=TrG3MD//5GV4INVW0Q2Ox/AYWinZt0znFIJVmseUnLM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=J20pV4q+lf6UBocq6KkjsgS4xMeiv1zQhe2D1r2Yvqj7UMnz/O94h8r/020bUmUDOPPud64H+Mykdxvw9l7VWA3Oe/w+mTpjxIHr7srtk4TFBDRz+FXpiLH/nd/YYhezsvzkehxhdxJXH2GagyFPBt3xpYa7+Oxw57HuCRQ4LHU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 00CA3385DDD6
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=aNCBwnF/
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B799045CC6
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 14:57:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=KFRqobDVUC+JJzzZugF14Tu0cxM=; b=aNCBw
	nF/0isZ9iqmv4u4YOQj2+U8mrRrDxXsmNDWilH+pIwNiXzmV11KWsFhY7slyYNYs
	c0PNgaQFdqd922qwtkZ1ItzsUpDqK7UbnceHCv7b1C9qoxQ4Ekxg2R2sk0V57tB0
	rDzOg/P5zjR5pBiz5yJPlW7NfFiLV5x8lhLl1g=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B308A45CC4
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 14:57:18 -0400 (EDT)
Date: Mon, 30 Jun 2025 11:57:18 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aGJl0crH02tjTIZs@calimero.vinschen.de>
Message-ID: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com> <aF6N5Ds7jmadgewV@calimero.vinschen.de> <7b118296-1d56-0b42-3557-992338335189@jdrake.com> <aGJl0crH02tjTIZs@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

(I kind of cut up bits of quoting to try to address my
thoughts/motivations better)

On Mon, 30 Jun 2025, Corinna Vinschen wrote:

> On Jun 27 11:44, Jeremy Drake via Cygwin-patches wrote:
> > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> >
> > > Hmmmm.  So we only may dup2/open/close stdin/out/err?  That's not
> > > exactly what POSIX requires.
> >
> > In this fast-path.  Otherwise, it will use the existing fork/exec
> > implementation in newlib.  Also, close can work for other fds (by setting
> > them to cloexec for the duration).  Note this is done holding
> > lock_process, which seems to be the same lock around dtable, so it should
> > be safe to temporarily muck about with file descriptors in this way.
> > Probably something else that needs a comment ;)
>
> Indeed.  Still, I'm not that happy with this code.  It seems to cater
> for native child processes in the first place, but Cygwin children are
> more important and the code should not go out of its way to handle
> native processes while neglecting cygwin processes.  It should *at
> least* already point into the direction the code is going to support
> Cygwin children in the first place.  Does that make sense?

> Yeah.  I don't have problems to use the fork/exec fallback for stuff
> which just isn't implemented yet.  I'm just reluctant if the code
> implements only the border case for native children.

> What exactly were you trying to accomplish with this patch?

My original idea was to implement the "least common denominator"
functionality that would apply to all child processes (cygwin and
non-cygwin).  This also seems to be what most users of posix_spawn use.
That's mostly redirecting stdin/out/err.  I wasn't particularly interested
in getting into the startup code for Cygwin processes, but it turned out I
had to hook up stderr, and then fchdir (because Cygwin processes will
ignore the Win32 cwd if the cwdstuff is already populated in the cygheap).

Looking at what llvm, rust, make, ninja do they don't seem to have file
actions for non-stdin/out/err, and only use some pretty easily implemented
parent-side flags (sigmask, sigdef, pgroup).  I imagine the
scheduler/schedparam are relatively easy too, but I don't think I've seen
any of those build tools try to use them so I haven't looked into them.

I was looking at hooking up (f)chdir because I knew there was a parameter
to CreateProcess for it, but now looking back it may not be all that
important.  Perhaps I should drop it for this first cut and come back to
it in a future patch.

It kind of sounds like what you are envisioning is pushing this to a lower
level, potentially even re-architecting child_info_spawn and related
startup code (I don't know if handle_spawn would necessarily encapsulate
everything) in terms of posix_spawn's parameters.  I was not looking to
get that deep into things.

I probably won't be able to get back to really working on this for at
least a week, but I'm hoping to at least get some comments written today.
