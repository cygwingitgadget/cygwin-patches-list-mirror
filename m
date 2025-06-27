Return-Path: <SRS0=jaUm=ZK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id EF1F93858408
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 18:44:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EF1F93858408
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EF1F93858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751049899; cv=none;
	b=NV3KAhDs03M7maEvw8LU3rBIxBiBTISelXP9aVw4hDAHzt/SQIG6HwG2GPeC+9ED2SIl2WtUkg02nHokXlXigiYzx/fOCVd5sudM8Gz5NB1RIi/do3W8i1F9E7HNgXUrhiHm7D7mwS/VHJwAZSEuDuM7sCeyoBPj2xxILqJOgjk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751049899; c=relaxed/simple;
	bh=RYy11kBxT+8cr8RMg+ZYgadWT7upUUgX6rU2zzDDW7k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=DNwMVQZb2VAODynbwamB8qlTkzOVUHWV2BZesSWTtIG/0WsvQxl7A1kY7KfqxryJXy1qAb28g8kxWaXfvSZIDLxzxP433DUTPvI4lvGcPMhMjge7g3SaLU9Q4bSR/1Loyq9RJRiILXTUiN272LrNCrqvPU/JJng/g0gJQ5jdMNs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EF1F93858408
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=PFgWAGqq
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9D14245D22
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 14:44:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=vMBIpoOmXtcDwanK+wCL1X5RjfA=; b=PFgWA
	GqqUuMlUvn7B+zXkUTWIPu//P9fTk5ydHEAtZ82mhiP/JruRhx5n4/oI1tFgOXcJ
	+9Z7YOanReTO2MJS+NCK1TGtGYVxIiOV6+eRJioE9jh8zYl2TQKJkuCNEXd6UFi2
	Ob08mKYAKAoKXO1bVLevie8LTzHY2QnzSg1YUM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 8B95345D1B
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 14:44:58 -0400 (EDT)
Date: Fri, 27 Jun 2025 11:44:58 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aF6N5Ds7jmadgewV@calimero.vinschen.de>
Message-ID: <7b118296-1d56-0b42-3557-992338335189@jdrake.com>
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com> <aF6N5Ds7jmadgewV@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 27 Jun 2025, Corinna Vinschen wrote:

> On Jun 26 16:59, Jeremy Drake via Cygwin-patches wrote:
> > Currently just file actions open/close/dup2 are supported in the fast
> > path.
>
> I'm wondering about that a bit, see below.
>
> Also, ETOOSHORTCOMMITMESSAGE

+1

> > +	      case __posix_spawn_file_actions_entry::FAE_DUP2:
> > +		if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
> > +		  goto closes;
>
> Hmmmm.  So we only may dup2/open/close stdin/out/err?  That's not
> exactly what POSIX requires.

In this fast-path.  Otherwise, it will use the existing fork/exec
implementation in newlib.  Also, close can work for other fds (by setting
them to cloexec for the duration).  Note this is done holding
lock_process, which seems to be the same lock around dtable, so it should
be safe to temporarily muck about with file descriptors in this way.
Probably something else that needs a comment ;)

> I understand that this is because CreateProcess or better, Windows, only
> defines three handles which can be unambiguously connected to descriptor
> numbers, but theoretically, this restriction should only apply to
> non-Cygwin executables.

I was thinking maybe the lpReserved2 for non-Cygwin executables could be
the MSVCRT file descriptor list that would let other file descriptors be
passed.  But that's above and beyond what I was hoping to accomplish with
this patch.

> Actually, I think this code path should really only be used with
> non-native executables.  With Cygwin executables, all the actions should
> be performed in the child process.  This is basically a job for
> child_info_spawn::handle_spawn() in dcrt0.cc.

Possibly.  My thought process was to implement what could be done reliably
for all executables in a 'fast-path' and leave the more complicated cases
to the existing fork/exec case where the actions would be performed in the
child.

To do the actions in the child with a spawn rather than a fork/exec, it
might be able to use cmalloc instead of malloc for allocating the file
actions (and spawnattrs?) and passing the pointers in the child info.
Then the child could do the same processing of actions as are done
post-fork in the newlib code.  I don't know how this would coordinate with
the newlib code (if it would require moving all of that into cygwin
proper), and the case of dup2ing cloexec fds would need to be dealt with.
That's beyond the scope of what I was trying to accomplish here, but seems
like another good optimization that could be done.

>
> With only one exception: if the executable path is relative, create an
> absolute path by emulating (but not actually executing) the chdir/fchdir
> calls inside the file_action object.

Are you suggesting the relative executable path case should be handled in
do_posix_spawn rather than in child_info_spawn::worker?  That would
probably be simpler in the normal case, but would require doing something
for the interpreter (#!) case due to potentially setting argv[0] to an
absolute path rather than keeping it relative and needing to use the
emulated cwd for relative paths in the #! line.

Now that I think about it, this would still require handling a different
cwd in find_exec, perhaps_suffix, and probably av::setup (since it does
the work for resolving #!).  I don't think it would save anything.

> As for this code, it wouldn't hurt to add more comments explicitely
> describing what it's doing and why.  I would add the first comment
> already when defining the fds array ;)

