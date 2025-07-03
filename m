Return-Path: <SRS0=6WXN=ZQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 6DD9D385E02F
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 05:51:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6DD9D385E02F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6DD9D385E02F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751521893; cv=none;
	b=rEqR44tZurHyeC2NkbYyEHmOyx+sWbuezVrG+PVRvaz5dXZz+a1Y8FaR/iLgBruV+xWuVOclU6OUKBLJZzdjGJDJgbQz0LgLTrqYAtOUR0kQ+YNA5dGYQmxtd8A4GgnkhZHPaNvYZ3zEu7P5FPvoG3gRG0I5iWZpRWt0o/p6G00=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751521893; c=relaxed/simple;
	bh=YPz940W7CoRDneHipSWKNyM8yNeSmAMhIIeWBI0ANig=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=epBspJud3T2zBgMtW6TjPPku67BNG9xI1hxh052UolRM2zZr+wtc/agrSAiLuT0rEUZamVy1Q4Y+BrDKjhK/84XHY9UBKhukNd0mWIA3M5c6lTD96BBuamnr8SXJvTTIXRA1ZHWTH0U1wgOwhcxmvm4RWy6rucB3yJzUkNcgS7Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6DD9D385E02F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=TFFt4IXo
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1935A45CA9
	for <cygwin-patches@cygwin.com>; Thu, 03 Jul 2025 01:51:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=8PbqWgN2JCn6t+A7DYH104DhT64=; b=TFFt4
	IXoX9NzQd00rDPc9QsPIuSVaMGo03NzGndUK7G3cUOuuIxTyYvU1tDsKfWg5h28B
	wziu3vmDvmDLLVGz7zC4A1vuplorokfqpBwr+MrfDk5iNlk2tIvm2DwmVihbZE1N
	wOM50X0GoUbkgQcTRC+sFJzpzSSVDrYKiJNMcE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id F216D45CB2
	for <cygwin-patches@cygwin.com>; Thu, 03 Jul 2025 01:51:32 -0400 (EDT)
Date: Wed, 2 Jul 2025 22:51:32 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aGUfpy6cTysuyaId@calimero.vinschen.de>
Message-ID: <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com> <aF6N5Ds7jmadgewV@calimero.vinschen.de> <7b118296-1d56-0b42-3557-992338335189@jdrake.com> <aGJl0crH02tjTIZs@calimero.vinschen.de> <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 2 Jul 2025, Corinna Vinschen wrote:

> One problem is that you dup and open files in the parent, which are
> supposed to be dup'ed and opened in the child.  That's ok for a native
> child, because we can't just hook into the native child process as Linux'
> clone3 call does.
>
> But generally it's not ok for Cygwin parent and child.  We have methods
> in place to communicate to the child what its supposed to do at startup,
> so we can do this right with a bit of tweaking, no?
>
> > It kind of sounds like what you are envisioning is pushing this to a lower
> > level, potentially even re-architecting child_info_spawn and related
> > startup code (I don't know if handle_spawn would necessarily encapsulate
> > everything) in terms of posix_spawn's parameters.  I was not looking to
> > get that deep into things.
>
> I don't see this as a deeper level.  It's just the child side of the same
> mechanism.  You're adding lots of code to make this work, but for Cygwin
> processes it's just in the wrong spot.


I was thinking about this further this evening, and I think I found a flaw
that couldn't be readily solved *without* processing the file actions in
the parent.  We already know and agree that the parent must process the
chdir and fchdir actions, in order to properly resolve relative path_args
(and relative #!s for that matter).  However, fchdir takes a file
descriptor, and the state of the file descriptors depends on the file
actions before the fchdir.  Therefore, all file actions prior to an fchdir
must be processed (or at least considered, probably through multiple
passes of the singly-linked actions queue) in the parent.

addopen (42, "dir", O_SEARCH|O_DIRECTORY)
addfchdir (42)
addclose (42)
(therefore addopen needs to be considered)

fd = open ("dir", O_SEARCH|O_DIRECTORY)
addclose (fd)
addfchdir (fd)
needs to fail with EBADF (therefore addclose needs to be considered.)

fd = open ("dir", O_SEARCH|O_DIRECTORY)
fd2 = open ("dir2", O_SEARCH|O_DIRECTORY)
adddup2 (fd2, fd)
addfchdir (fd)
needs to chdir to dir2, not dir (therefore dup2 needs to be considered)

addchdir ("dir")
addopen (42, "subdir", O_SEARCH|O_DIRECTORY)
addfchdir (42)
addclose (42)
needs to chdir to dir/subdir (so chdir needs to be considered before open).

What scenario would not work properly if the file actions were not done in
the child?  The main thing I can think of is opening things under
/proc/self, but that would do the wrong thing anyway even if done in the
child startup (vs the "proper" behavior in a real fork/exec), if you open
/proc/self/exe.  There is the RESETIDS flag that could implicate that the
operations need to happen as a different user, but I was definitely not
planning to handle that flag and letting fork/exec take care of it.
setuid binary (if those are even supported in Cygwin) would mean the child
would be running as the new id, while a fork running the actions would
still be running as the old id before execing the suid binary, so point
for processing in the parent for that I guess.


