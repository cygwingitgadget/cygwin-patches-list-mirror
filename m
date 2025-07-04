Return-Path: <SRS0=8qQe=ZR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id B6475385AC1D
	for <cygwin-patches@cygwin.com>; Fri,  4 Jul 2025 18:43:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B6475385AC1D
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B6475385AC1D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751654605; cv=none;
	b=wowWUHNzhSJDu0D2HiZLQCowoEsba7DA2HxhhHexjHGS79evdFtjgSXLddlDkVrHeBO51W6U472GstFIU01bYvkquFazAPEKkzeLlGSUw+Yq8p89n2i3uwvYBkEy6+MALbVeodbd2HGT0qMKzan6+BE0awCylOoJfEjuOeOruvo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751654605; c=relaxed/simple;
	bh=uC6HPbUfy3IUlx3zhBtjY0/gWuEPkGIQ7JCHIb60AI8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=p+vvOB6FYtIPP82rKciljq1wxk/06zM6J+ezb9ukia5l1QnD4+PEvcMzoTpsZm+SeFBwhSwAgujAfIizceMCLifbSqsSQwBSCUJnvi3hZ0DhDoosdfgMYmlCSBwPbVANzq3GkDH78DzUrNoRNoWEvCmMotBS9cYaVLqFgOX8YYM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B6475385AC1D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=y/Pf5uyu
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4BB9845C94
	for <cygwin-patches@cygwin.com>; Fri, 04 Jul 2025 14:43:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=1B1joU3PdN2TXSjC97HyBYpcEvM=; b=y/Pf5
	uyuoHnYMTVO11KOMF9x8OeKIGQpYLFl2YNLDXy7zJ2oWY2+6+oVWtFxrXFSjV4hc
	xImz75NgycGl0qQjap53kAWpLsp+YLdL+pA8om1OKlMOwXfMe5m/g038rvQlZoPm
	OnhsvplLyhLKHHgMT3WIUJ/yxtW65vJXbIvJdc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 32F2F45C86
	for <cygwin-patches@cygwin.com>; Fri, 04 Jul 2025 14:43:25 -0400 (EDT)
Date: Fri, 4 Jul 2025 11:43:25 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aGeQMtwhTueOa4MT@calimero.vinschen.de>
Message-ID: <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com>
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com> <aF6N5Ds7jmadgewV@calimero.vinschen.de> <7b118296-1d56-0b42-3557-992338335189@jdrake.com> <aGJl0crH02tjTIZs@calimero.vinschen.de> <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com> <aGaZq6sSSuNCKX59@calimero.vinschen.de> <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com> <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
 <aGeQMtwhTueOa4MT@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 4 Jul 2025, Corinna Vinschen wrote:

> On Jul  3 12:03, Jeremy Drake via Cygwin-patches wrote:
> > On Thu, 3 Jul 2025, Jeremy Drake via Cygwin-patches wrote:
> > >
> > > https://pubs.opengroup.org/onlinepubs/9799919799/functions/posix_spawn_file_actions_addclose.html
> > >
> > > > A spawn file actions object, when passed to posix_spawn() or
> > > > posix_spawnp(), shall specify how the set of open file descriptors in
> > > > the calling process is transformed into a set of potentially open file
> > > > descriptors for the spawned process. This transformation shall be as if
> > > > the specified sequence of actions was performed exactly once, in the
> > > > context of the spawned process (prior to execution of the new process
> > > > image), in the order in which the actions were added to the object;
>
> I see what you mean.  The question of questions is if "as if" only
> covers the "performed exactly once" requirement, or if the "as if"
> really encompasses all three requirements, i.e.
>
> - as if the specified sequence of actions was performed exactly once
>
> - exactly in the context of the spawned process (prior to execution of the new
>   process image)
>
> - exactly in the order in which the actions were added to the object
>
> in contrast to
>
> - as if the specified sequence of actions was performed exactly once
>
> - as if in the context of the spawned process (prior to execution of the new
>   process image)
>
> - as if in the order in which the actions were added to the object
>
> My understanding (as a non-native speaker) is that "as if" only
> covers the "performed exactly once" requirement.  Applying "as if"
> to the order requirement doesn't make much sense to me.  And applying "as if"
> implicitely to the second requirement, but not to the third, doesn't
> make much sense to me either.

The "as if" performed exactly once doesn't make a whole lot of sense to me
either... To me, the only case where "as if" adds flexibility is the
context of the child process.

> On top of that you'd have the problem that the man pages of
> osix_spawn_file_actions_addclose and posix_spawn_file_actions_addchdir
> contradict each other.  This, of course, is always possible.  Only an
> RFC to the Austin Group could clarify this.  Maybe we should really do
> that.

The parts you quoted are in a section labeled "The following sections are
informative.".  But there does seem to be some confusion over whether the
actions *must* be performed in the child, or only *as if* they were
performed in the child.  Maybe they could clarify.  I interpreted the
posix_spawn rationale applying to the Windows model, whereas maybe they
only meant systems lacking fork due to their embedded-ness (lacking mmu
etc).  I don't see why they would preclude this though.  I'm kind of
considering the Cygwin dll as the "kernel" in this context.

> > > > How do you run, say,
> > > >
> > > >   addopen (42, "dir", O_SEARCH|O_DIRECTORY)
> > > >
> > > > without potentially disrupting the actions of another parallel thread,
> > > > just reading data from a file attached to fd 42?
> > >
> > > First, I wouldn't be rushing to optimize the case of file descriptors
> > > greater than 2, because I don't see that as a common case.  However, if
> > > necessary, I'd do it much the same way as for 0 through 2:
> > >
> > > hold the lock_process lock
> > > perform the open, and assign the returned file descriptor into a mapping
> > > of file descriptors for the child.
> > > for a Win32 child, implement the lpReserved2 used by msvcrt to specify
> > > the fd to handle mapping
> > > for a Cygwin child, change the stdin/stdout/stderr child_info_spawn to
> > > some mapping structure for move_fd operations to perform in handle_spawn.
> >
> > I get the idea that "some mapping structure" in child_info_spawn could
> > just be the file actions and attributes from posix_spawn, and instead of
> > move_fd process the actions and attributes in handle_spawn.  Why I am
> > resisting this is that I don't want to have to do this twice: once in the
> > parent as I do now, which must continue to exist for win32 processes AND
> > to find the directory to which a relative program path is relative; and do
> > it again during Cygwin process startup.  I'm really struggling to see why
> > the added complexity of a special path for Cygwin children is necessary
> > here.
>
> Yeah, ok, I get that.  I understand that you're frustrated.  Please keep
> in mind that, to me, Cygwin processes are the first class citizens,
> native processes are second class.  Therefore it would be great to be
> able to do it right for Cygwin processes in the first place.
>
> I'm not trying to be unreasonable and inclined to go with your patchset
> for a start.  But, to me, considering the Issue 8 descriptions, it
> seems we could do more, better for Cygwin processes.
>
> Or maybe not!  But that will probably require more tedious discussions
> like this one and throwing ideas back and forth.  It would be a bit
> disappointing to be stuck with this and not trying to come up with
> funny ideas to workaround obstacles like O_CLOEXEC, POSIX_SPAWN_RESETIDS,
> etc.

I'm sorry if I'm sounding frustrated.  I am just trying to debate to find
the best implementation.  I think that having two versions of processing
the file actions is asking for inconsistencies and bugs.  As you point
out, non-Cygwin processes are second-class citizens to Cygwin but are more
important to MSYS2 and Git for Windows, so I can see bugs in the
non-Cygwin case going undiscovered until after a Cygwin release, when
MSYS2 and Git for Windows try to integrate it and exercise the case of a
Cygwin GNU make running mingw gcc, or Cygwin bash running mingw git
running Cygwin ssh, or any other bizarre combination.

I'd be happy to consider a counter implementation.  I think this would
have to:
1. exist inside child_info_spawn::worker, because path_conv.iscygexec ()
wouldn't be reliable until after av::setup has run and set it based in
hook_or_detect_cygwin.
2. process the file actions in the parent to compute the child's cwd, so
that a relative program is found relative to the correct cwd.  This has
a certain amount of chicken-and-egg because av::setup needs to use this
cwd to find relative paths in the #! at least.
3. the malloc/strdup/free in newlib posix_spawn.c needs to be swapped out
for cmalloc-based ones so the structures remain available in the child.
4. the posix_spawnattrs_t and posix_spawn_file_actions_t need to be passed
to the child (child_info_spawn or the moreinfo member)
5. the process_spawnattr and process_file_actions in newlib posix_spawn.c
need to be called from dcrt0.c (probably handle_spawn).



