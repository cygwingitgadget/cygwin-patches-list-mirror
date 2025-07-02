Return-Path: <SRS0=Hj8f=ZP=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 021CC385E825
	for <cygwin-patches@cygwin.com>; Wed,  2 Jul 2025 17:55:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 021CC385E825
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 021CC385E825
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751478906; cv=none;
	b=akcEt46bZxpgBgew+KdigOFX+gySJPzcFNo4eZ00p6APCpy4XTy1WfKRzyad3JoSXZ6WOtjdzWvYYmVRTua1frSYdeaHTU8dl2xatxD63CoTjyAPZqO5Dx1AgW/aDjfq2o8qwLCWz7eHKO6X/Dv1oOy6+i1/GG3QWpfJYaUS5o4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751478906; c=relaxed/simple;
	bh=+bY3bgmTgzpclozgfNv6ud09FEawCFjjjM5JZvBIMzM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=tHTx7bXbHOkTRqPMb5MkK8tmJbryeN4A/+GlDMCuzGMJ4+ulFEpbY77yFiLa/mMYU+yQ2VfuhXCCCtMZ9s8O0TmKUR0bED5uOt478+Ry2rDf/vQYMIJJ0lw+eZKhae1QbaGQkB/0OQvSsCso38vcUkeuyjeIo8EMptbzRrqjHGQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id C4ABB45CA9
	for <cygwin-patches@cygwin.com>; Wed, 02 Jul 2025 13:55:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=o0lUjYMl3E7pjBGmlqJVDm0G0qI=; b=qKr81
	ys3rBhziLhB/qSdXFPUxeqKxYLKuGS/H8/grPZdzwkSlmoWOAcaRDugrcwdMK4Dd
	0cPiNVPCLB544epT/SIcaFEeSFdQL3UAiXNq6pKbYbAdKHz35PwvzKddB3C/WVIS
	vcZeuHxkF6Sf1ecloAmNXBfPoJ+X+aXoQ+csHQ=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id ACF2945CA8
	for <cygwin-patches@cygwin.com>; Wed, 02 Jul 2025 13:55:05 -0400 (EDT)
Date: Wed, 2 Jul 2025 10:55:05 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/6] Cygwin: add ability to pass cwd to child
 process
In-Reply-To: <aGUketWC7RES61Nx@calimero.vinschen.de>
Message-ID: <fb1daa1c-9201-c245-8caf-a1d2d8d93643@jdrake.com>
References: <66a1dec3-77a2-6c9f-0388-da2f85489e89@jdrake.com> <aGUketWC7RES61Nx@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 2 Jul 2025, Corinna Vinschen wrote:

> On Jul  1 16:43, Jeremy Drake via Cygwin-patches wrote:
> > This will be used by posix_spawn_fileaction_add_(f)chdir.
> >
> > The int cwdfd is placed such that it fits into space previously unused
> > due to alignment in the cygheap_exec_info class.
> >
> > This uses a file descriptor rather than a path both because it is easier
> > to marshal to the child and because this should protect against races
> > where the directory might be renamed or removed between addfchdir and
> > the actual setting of the cwd in the child.
> >
> > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > ---
> >  winsup/cygwin/dcrt0.cc                    |  19 +++-
> >  winsup/cygwin/local_includes/child_info.h |   4 +-
> >  winsup/cygwin/local_includes/path.h       |   6 +-
> >  winsup/cygwin/local_includes/winf.h       |   2 +-
> >  winsup/cygwin/spawn.cc                    | 100 ++++++++++++++++++----
> >  winsup/cygwin/syscalls.cc                 |   4 +-
> >  6 files changed, 113 insertions(+), 22 deletions(-)
> >
> > diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> > index b0fb5c9c1e..6adc31495a 100644
> > --- a/winsup/cygwin/dcrt0.cc
> > +++ b/winsup/cygwin/dcrt0.cc
> > @@ -46,6 +46,7 @@ extern "C" void __sinit (_reent *);
> >
> >  static int NO_COPY envc;
> >  static char NO_COPY **envp;
> > +static int NO_COPY cwdfd = AT_FDCWD;
> >
> >  bool NO_COPY jit_debug;
> >
> > @@ -656,6 +657,7 @@ child_info_spawn::handle_spawn ()
> >    __argv = moreinfo->argv;
> >    envp = moreinfo->envp;
> >    envc = moreinfo->envc;
> > +  cwdfd = moreinfo->cwdfd;
> >    if (!dynamically_loaded)
> >      cygheap->fdtab.fixup_after_exec ();
> >    if (__stdin >= 0)
> > @@ -842,7 +844,22 @@ dll_crt0_1 (void *)
> >
> >    ProtectHandle (hMainThread);
> >
> > -  cygheap->cwd.init ();
> > +  if (cwdfd >= 0)
> > +    {
> > +      int res = fchdir (cwdfd);
> > +      if (res < 0)
> > +	{
> > +	  /* if the error occurs after the calling process successfully
> > +	     returns, the child process shall exit with exit status 127. */
> > +	  /* why is this byteswapped? */
> > +	  set_api_fatal_return (0x7f00);
> > +	  api_fatal ("can't fchdir, %R", res);
> > +	}
> > +      close (cwdfd);
> > +      cwdfd = AT_FDCWD;
> > +    }
> > +  else
> > +    cygheap->cwd.init ();
>
> Weeeeell, as discussed in the other thread, and on second thought, maybe
> this is the right spot to handle all the posix_spawn stuff.
>
> But then, it should be in it's own function.  And you don't need
> moreinfo->cwdfd, because the entire set of actions requested by the
> posix_spawn caller should run one at a time in that function, so
> multiple chdir and fchdir actions may be required.
>
> I would also suggest to pimp cwdstuff::init() by adding an argument
> which allows to say

... ?

> Eventually, this code snippet in dll_crt0_1 should probably look like
> this:
>
>   cygheap->cwd.init ();
>   if (posix_spawn_actions_present)
>     posix_spawn_run_child_actions (...);
>
> Regardless if posix_spawn chdir/fchdir file actions are present or not,
> in the first place the cwd of the child is the parent's cwd.  The
> posix_spawn chdir/fchdir file actions run afterwards.


In https://cygwin.com/pipermail/cygwin-developers/2025-March/012733.html,
you said
> For posix_spawn without forking, this complicates matters.  For
> instance, we don't want having to close FD_CLOEXEC handles in the
> spawned child because that's a security problem.

FD_CLOEXEC sets handles as non-inherited at the Windows level, but for
posix_spawn_file_actions_addclose is that still a security problem?


Also, it is allowed to posix_spawn_file_actions_adddup2 from a FD_CLOEXEC
file descriptor, so the parent would have to go through all the file
actions, work the (f)chdirs to know where to look for relative prog_arg,
and check adddup2s for FD_CLOEXEC descriptors, set them to not-FD_CLOEXEC
and record that they were for the child to know to close them (and put
them back to FL_CLOEXEC after the spawn).  This is already a good part of
the work being done in the parent in my patch.
