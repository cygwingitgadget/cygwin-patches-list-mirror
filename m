Return-Path: <SRS0=vdJ1=24=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 5F6E43858D1E
	for <cygwin-patches@cygwin.com>; Sat, 16 Aug 2025 07:45:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F6E43858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F6E43858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755330322; cv=none;
	b=mQC7XFN4aOrwmm2lkJwFzKumQx5vrR0QHb3aRoSpNb6gB632hDH1mB56CHnBWdDYM9SIKhJe+u9JXBq2VJxNRUeYFiQXmqxn0h22+Tp5GYFm9Hnt0Bj2uKtxYbLqo5kjFrEiilccJSH4kNr0iUp9s74e9jKbgf7Jh5Ab0kPObTU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755330322; c=relaxed/simple;
	bh=COQ9MizTU+6REwv51m7X/bOdxm0h1HMePxuvc01oh8Y=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=kngbHumxcmuF6s85+CivQAHWyvTMB2iXMjZWPL0G8GQK/spo4MDJR84Z/AQ1I++uXPn3Dzy/XLVSc0/TKB5j7Fe9qBmdeEEM7URVK4Kh0bMGY+kp7qFUPJ0nkFrrBum66difM88hqv1rxny0jbectzX3RLpxXV9IQKjB7uEz7yc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F6E43858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=unyLT0hb
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2BC5E45A5F;
	Sat, 16 Aug 2025 03:45:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=QxMEZYp6H1HG7uqI9cFurMApUDs=; b=unyLT
	0hbv0Dgj4DIyhXmEN1q51UxRsRuqvAHzRwEisEd1Qdk3sGlPbhY61mtH9eJsKqhx
	KTz2Y1aCNKtVxK7AS9KO0dQhYacWn8iR1KCDwbNVtTmsiROuOrrd35md/IvzcQnA
	IWxiX+d3u7yVS3JciIpoqRQ2hniLhoW9ejqcDw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 26E3845A25;
	Sat, 16 Aug 2025 03:45:22 -0400 (EDT)
Date: Sat, 16 Aug 2025 00:45:22 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Denis Excoffier <cygwin@Denis-Excoffier.org>
Subject: Re: [PATCH v2] Cygwin: spawn: Make ch_spwan_local be initialized
 properly
In-Reply-To: <7f233866-9276-1eb6-1876-2f8d44b5c042@jdrake.com>
Message-ID: <129ca853-27b1-e4be-d5d2-2482c245a80c@jdrake.com>
References: <20250816031650.557-1-takashi.yano@nifty.ne.jp> <7f233866-9276-1eb6-1876-2f8d44b5c042@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 15 Aug 2025, Jeremy Drake via Cygwin-patches wrote:

> On Sat, 16 Aug 2025, Takashi Yano wrote:
>
> > The class child_info_spawn has two constructors: one without arguments
> > and one with two arguments. The former does not initialize any members.
> > Commit 1f836c5f7394 used the latter to ensure that the local ch_spawn
> > (i.e., ch_spawn_local) would be properly initialized. However, this was
> > insufficient - it initialized only the base child_info members, not the
> > fields specific to child_info_spawn. This led to the issue reported in
> > https://cygwin.com/pipermail/cygwin/2025-August/258660.html.
> >
> > This patch updates the former constructor to properly initialize member
> > variable 'ev' which was referred without initialization, and switches
> > ch_spawn_local to use it.
> >
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258660.html
> > Fixes: 1f836c5f7394 ("Cygwin: spawn: Make system() thread-safe")
> > Reported-by: Denis Excoffier <cygwin@Denis-Excoffier.org>
> > Reviewed-by: Jeremy Drake <cygwin@jdrake.com>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/local_includes/child_info.h | 5 +++--
> >  winsup/cygwin/spawn.cc                    | 2 +-
> >  winsup/cygwin/syscalls.cc                 | 2 +-
> >  3 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
> > index 2da62ffaa..b8707b9ec 100644
> > --- a/winsup/cygwin/local_includes/child_info.h
> > +++ b/winsup/cygwin/local_includes/child_info.h
> > @@ -33,7 +33,7 @@ enum child_status
> >  #define EXEC_MAGIC_SIZE sizeof(child_info)
> >
> >  /* Change this value if you get a message indicating that it is out-of-sync. */
> > -#define CURR_CHILD_INFO_MAGIC 0xacbf4682U
> > +#define CURR_CHILD_INFO_MAGIC 0x39f766b5U
> >
> >  #include "pinfo.h"
> >  struct cchildren
> > @@ -148,7 +148,8 @@ public:
> >    char filler[4];
> >
> >    void cleanup ();
> > -  child_info_spawn () {};
> > +  child_info_spawn () :
> > +    child_info (sizeof *this, _CH_NADA, false), ev (NULL) {};
>
> I noticed that moreinfo is checked/used in cleanup too, but it is set in
> worker.  It'd probably be safer to initialize it too though.  Looking at
> child_info, subproc_ready seems to not be initialized if
> need_subproc_ready is false.  It'd probably be subject to the same issue
> as ev.

More thoughts as I'm trying to sleep.  "Complicating" the default
constructor may now require actually running code to construct the global
ch_spawn instance.  Perhaps a new constructor for this purpose?

I'd put the constructor with initializers in a .cpp file rather than
inlining it in the header, due to the CHILD_INFO_MAGIC hashing going on
with the header.  Then I think it'd be cleaner initializing more members
too (all the pointers/handles would make sense).

>
> >    child_info_spawn (child_info_types, bool);
> >    void record_children ();
> >    void reattach_children ();
> > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > index 680f0fefd..6cd97ec17 100644
> > --- a/winsup/cygwin/spawn.cc
> > +++ b/winsup/cygwin/spawn.cc
> > @@ -950,7 +950,7 @@ spawnve (int mode, const char *path, const char *const *argv,
> >    if (!envp)
> >      envp = empty_env;
> >
> > -  child_info_spawn ch_spawn_local (_CH_NADA, false);
> > +  child_info_spawn ch_spawn_local;
> >    switch (_P_MODE (mode))
> >      {
> >      case _P_OVERLAY:
> > diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> > index 863f8f23c..83a54ca05 100644
> > --- a/winsup/cygwin/syscalls.cc
> > +++ b/winsup/cygwin/syscalls.cc
> > @@ -4535,7 +4535,7 @@ popen (const char *command, const char *in_type)
> >        fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);
> >
> >        /* Start a shell process to run the given command without forking. */
> > -      child_info_spawn ch_spawn_local (_CH_NADA, false);
> > +      child_info_spawn ch_spawn_local;
> >        pid_t pid = ch_spawn_local.worker ("/bin/sh", argv, environ, _P_NOWAIT,
> >  					 __std[0], __std[1]);
> >
> >

-- 
I've given up reading books; I find it takes my mind off myself.
