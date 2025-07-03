Return-Path: <SRS0=6WXN=ZQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 71CD9385F027
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 18:05:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 71CD9385F027
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 71CD9385F027
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751565913; cv=none;
	b=FCEJCdercaLX6krniI20AnXF5LFliJLMZGRu0Qwb32SHkL+zq8KGZ8PknsB9CWRDCJck22GG5KD7IZRtsliwptVmvqOXj6qZk3gUOBajuDbCyix5p4qa/fst29XMZJRvZozfheSozeWS+Z+pCD7EiDmG8EtorzLhzzivXkitdNU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751565913; c=relaxed/simple;
	bh=xRU9F9OCCJzmb9nIQz2CHrabbqDZpAKURpzDODkbBqM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=h+jjBdRlckJoiUxBE/V1aZpYyXfsV6t1QoBhiDIF3dWPJbqvSEk5QhDf3InJbxpW7yqHwHl+zIK7ys33PORULV7ZLczvOli0bnSg+gDhUJVHpO1bbpvJ9H/W0ON8PUPTIIOuvT1YIPn6RuSrQ9SdOJMxbH3t1WuuC0PzFcnw+mA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 71CD9385F027
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=P/0i8alz
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id EB6C845CBA
	for <cygwin-patches@cygwin.com>; Thu, 03 Jul 2025 14:05:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=EmbW92Et8ZfFEW3U4HjW/rTe3c0=; b=P/0i8
	alzNek+hkEWvSIlAXsKh3VXm1GogIO45p7I4B8ZoslEObIW4uXO+WHoOry+t9Vye
	ziMxBHSCIlICVx6w7H4wLXh/m7hLPODUl0AODolhGxcSSNMjmSLtwshidNmNiy3B
	9xwDJu3SaMaAPBTQ6d8wpSQyJo7rLuIGjmYBqE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id E64E045CB2
	for <cygwin-patches@cygwin.com>; Thu, 03 Jul 2025 14:05:12 -0400 (EDT)
Date: Thu, 3 Jul 2025 11:05:12 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aGaZq6sSSuNCKX59@calimero.vinschen.de>
Message-ID: <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com> <aF6N5Ds7jmadgewV@calimero.vinschen.de> <7b118296-1d56-0b42-3557-992338335189@jdrake.com> <aGJl0crH02tjTIZs@calimero.vinschen.de> <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com> <aGaZq6sSSuNCKX59@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 3 Jul 2025, Corinna Vinschen wrote:

> On Jul  2 22:51, Jeremy Drake via Cygwin-patches wrote:
> > On Wed, 2 Jul 2025, Corinna Vinschen wrote:
> >
> > > One problem is that you dup and open files in the parent, which are
> > > supposed to be dup'ed and opened in the child.  That's ok for a native
> > > child, because we can't just hook into the native child process as Linux'
> > > clone3 call does.
> > >
> > > But generally it's not ok for Cygwin parent and child.  We have methods
> > > in place to communicate to the child what its supposed to do at startup,
> > > so we can do this right with a bit of tweaking, no?
> > >
> > > > It kind of sounds like what you are envisioning is pushing this to a lower
> > > > level, potentially even re-architecting child_info_spawn and related
> > > > startup code (I don't know if handle_spawn would necessarily encapsulate
> > > > everything) in terms of posix_spawn's parameters.  I was not looking to
> > > > get that deep into things.
> > >
> > > I don't see this as a deeper level.  It's just the child side of the same
> > > mechanism.  You're adding lots of code to make this work, but for Cygwin
> > > processes it's just in the wrong spot.
> >
> >
> > I was thinking about this further this evening, and I think I found a flaw
> > that couldn't be readily solved *without* processing the file actions in
> > the parent.  We already know and agree that the parent must process the
> > chdir and fchdir actions, in order to properly resolve relative path_args
> > (and relative #!s for that matter).  However, fchdir takes a file
> > descriptor, and the state of the file descriptors depends on the file
> > actions before the fchdir.  Therefore, all file actions prior to an fchdir
> > must be processed (or at least considered, probably through multiple
> > passes of the singly-linked actions queue) in the parent.
> >
> > addopen (42, "dir", O_SEARCH|O_DIRECTORY)
> > addfchdir (42)
> > addclose (42)
> > (therefore addopen needs to be considered)
> >
> > fd = open ("dir", O_SEARCH|O_DIRECTORY)
> > addclose (fd)
> > addfchdir (fd)
> > needs to fail with EBADF (therefore addclose needs to be considered.)
> >
> > fd = open ("dir", O_SEARCH|O_DIRECTORY)
> > fd2 = open ("dir2", O_SEARCH|O_DIRECTORY)
> > adddup2 (fd2, fd)
> > addfchdir (fd)
> > needs to chdir to dir2, not dir (therefore dup2 needs to be considered)
> >
> > addchdir ("dir")
> > addopen (42, "subdir", O_SEARCH|O_DIRECTORY)
> > addfchdir (42)
> > addclose (42)
> > needs to chdir to dir/subdir (so chdir needs to be considered before open).
>
> I see where you are coming from, but there's a twist.  The file actions
> are *supposed* to run in the child.
>
> From the POSIX man page of posix_spawn_file_actions_addchdir:
>
> APPLICATION USAGE
>
>   [...] all file actions are processed in sequence in the context of the
>   child at a point where the child process is still single-threaded
>
>   [...]
>
>   File actions are performed in a new process created by posix_spawn()
>   or posix_spawnp() in the same order that they were added to the file
>   actions object.

The docs I was reading use "as if", to allow implementations where the
actions are not actually processed in the child.

https://pubs.opengroup.org/onlinepubs/9799919799/functions/posix_spawn_file_actions_addclose.html

> A spawn file actions object, when passed to posix_spawn() or
> posix_spawnp(), shall specify how the set of open file descriptors in
> the calling process is transformed into a set of potentially open file
> descriptors for the spawned process. This transformation shall be as if
> the specified sequence of actions was performed exactly once, in the
> context of the spawned process (prior to execution of the new process
> image), in the order in which the actions were added to the object;
> additionally, when the new process image is executed, any file
> descriptor (from this new set) which has its FD_CLOEXEC flag set shall
> be closed (see posix_spawn()).

> But, either way, performing these actions in the parent is a problem,
> too.
>
> > What scenario would not work properly if the file actions were not done in
> > the child?  The main thing I can think of is opening things under
>
> How do you run, say,
>
>   addopen (42, "dir", O_SEARCH|O_DIRECTORY)
>
> without potentially disrupting the actions of another parallel thread,
> just reading data from a file attached to fd 42?

First, I wouldn't be rushing to optimize the case of file descriptors
greater than 2, because I don't see that as a common case.  However, if
necessary, I'd do it much the same way as for 0 through 2:

hold the lock_process lock
perform the open, and assign the returned file descriptor into a mapping
of file descriptors for the child.
for a Win32 child, implement the lpReserved2 used by msvcrt to specify
the fd to handle mapping
for a Cygwin child, change the stdin/stdout/stderr child_info_spawn to
some mapping structure for move_fd operations to perform in handle_spawn.

>
> How do you run
>
>   addfchdir (42)
>
> without disrupting another thread trying to open a file with relative
> path?

That's easy and already implemented: just keep track of a "cwd" file
descriptor while processing the file actions, and use openat instead of
open (and for a subsequent chdir use openat and use that as the "cwd" file
descriptor).

The posix doc I linked above gives these notes about why they can't be
done in the parent:

3. It allows file opens that might otherwise fail or violate file
ownership/access rights if executed by the parent process.

Regarding 3. above, note that if the calling process needs to open one or
more files for access by the spawned process, but has insufficient spare
file descriptors, then the open action is necessary to allow the open() to
occur in the context of the child process after other file descriptors
have been closed (that must remain open in the parent).

Additionally, if a parent is executed from a file having a "set-user-id"
mode bit set and the POSIX_SPAWN_RESETIDS flag is set in the spawn
attributes, a file created within the parent process will (possibly
incorrectly) have the parent's effective user ID as its owner, whereas a
file created via an open() action during posix_spawn() or posix_spawnp()
will have the parent's real ID as its owner; and an open by the parent
process may successfully open a file to which the real user should not
have access or fail to open a file to which the real user should have
access.

Also, they say
The standard developers had originally proposed using an array which
specified the mapping of child file descriptors back to those of the
parent. It was pointed out by the ballot group that it is not possible to
reshuffle file descriptors arbitrarily in a library implementation of
posix_spawn() or posix_spawnp() without provision for one or more spare
file descriptor entries (which simply may not be available). Such an array
requires that an implementation develop a complex strategy to achieve the
desired mapping without inadvertently closing the wrong file descriptor at
the wrong time.


So it sounds like the main issue with my approach is when there are not
enough available file descriptors in the parent.  I had not considered
that at all...

