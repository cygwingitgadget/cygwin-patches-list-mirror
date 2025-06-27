Return-Path: <SRS0=jaUm=ZK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 0F3E2385C6F5
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 00:13:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0F3E2385C6F5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0F3E2385C6F5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750983180; cv=none;
	b=xpg7WSIY2Vio/zJppTYfyCXEYUtTHL+mxa0+hZKXsp9DXoXgXHYTL9VcpQK/K85XZCXlkL1+SoE/5GjzB3nFWLZ0M8qN/9tu8xqo8vhqzRwaxt5bPzsiSC1RpFuKdpKOfgsX7khk2MiLgNsLAbtlewISt8MiRK0BLH+uI25QxR0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750983180; c=relaxed/simple;
	bh=M/FokIO4D+pw1PPAE2ScReiUkWVkn4WC+50WVr4IcDE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mFyfuWC2/BIu0e8Zvjrd614dm1Oro4KpAeUarAaUCCH8IXekucIHe6sqh/5rVzfZHOgBlbmKLnqc2Iiktk5F28dmP5Vodrof5dqYeh7pNWt8EoRPbVuJW80M0sIGcDyuq+6bNQJazhWfBFDPXxOtLNiNFuS6p48VbJi1jabTpiM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0F3E2385C6F5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=hN5jXF9w
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D6AB745D31
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 20:12:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=+ryO2zK0Aml9j5bOz/a2dsAQ09o=; b=hN5jX
	F9wKMwxrypCLyW372DNZJqYT58lWP1fuCUxxEr9aattviG13Yi1AqGkXxml4MRn8
	V/C8zu8/3AmAKgLIyKhxno3NZDHmvOR6Lu4bnBtcz6iaTVjKzssGCfQ110qXkAqs
	bJC/uOZtmajO3D92MSVlXPJndEEGgOoxaKTkGg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id BC4AF45CE0
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 20:12:59 -0400 (EDT)
Date: Thu, 26 Jun 2025 17:12:59 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] posix_spawn fast path
In-Reply-To: <5c8c9bad-0109-b328-195e-0a1d1da0c4cf@jdrake.com>
Message-ID: <6560d72a-c5e2-d084-c815-f44b5afd897f@jdrake.com>
References: <5c8c9bad-0109-b328-195e-0a1d1da0c4cf@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 26 Jun 2025, Jeremy Drake via Cygwin-patches wrote:

> I *thought* this was all finally good to go, but while working on
> posix_spawn tests today I found that it does not properly handle the case
> where an (f)chdir file action is present and the path/file argument is
> relative.  In that case, it should be relative to the child's cwd, not the
> parent's.  As a result, I have left out a patch to actually hook up the
> (f)chdir actions in the fast path, so it will continue to fall back to
> fork/exec in that case.
>
> I *think* it would need a find_exec overload that uses a specified cwd, as
> well as perhaps_suffix.  I am not sure if av::setup needs to know about
> this or not.  It takes the path_conv real_path that came out of
> perhaps_suffix, and only uses the prog_arg in the case of a script
> replacing argv[0].  By the time the interpreter is run, the startup code
> would have already chdir'd, so that'd be fine.  I am not sure about the
> use of find_exec in av::setup though, I don't think something like
> #!./prog is legal but if it is that will need to know the child's cwd too.

Nope, I was wrong.  I tried it on Linux and this works:
cp /bin/bash .
echo '#!./bash' > test.sh
echo 'readlink /proc/$$/exe' >> test.sh
chmod +x test.sh
./test.sh

Looks like av::setup needs to pass through the child's cwd to its
invocation of find_exec also then.

>
> Basically, this one little issue is seeming rather complicated, so I
> figured I'd get what's working out for review while I figure that out.
>
> Jeremy Drake (5):
>   Cygwin: allow redirecting stderr in ch_spawn
>   Cygwin: add ability to pass cwd to child process
>   Cygwin: hook posix_spawn/posix_spawnp
>   Cygwin: add fast-path for posix_spawn(p)
>   Cygwin: posix_spawn: add fastpath support for SETSIGMASK and
>     SETSIGDEF.
>
>  winsup/cygwin/cygwin.din                  |   4 +-
>  winsup/cygwin/dcrt0.cc                    |  21 +-
>  winsup/cygwin/local_includes/child_info.h |   8 +-
>  winsup/cygwin/spawn.cc                    | 275 +++++++++++++++++++++-
>  4 files changed, 292 insertions(+), 16 deletions(-)
>
>

