Return-Path: <SRS0=O3CV=YO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 986023857BB3
	for <cygwin-patches@cygwin.com>; Fri, 30 May 2025 23:18:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 986023857BB3
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 986023857BB3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748647136; cv=none;
	b=J8z4xZtRF2MDpOPKWbhhxyzpcQy3OYpQD/celCc5KpKgrOTz9f+ACQY+IqqE464fIn7v1a90Bb5Yx548ojqU6bFWXZuq8ZXFIyUhpDTkor9dTbZ/P57b9TKnlG88Ny1ysG23d6kgu15LQZO2DA82CHWJ+vhpm6VD0NSwjjCYaVg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748647136; c=relaxed/simple;
	bh=RfmWAIckQC96JCkiMHcDXO8Reg5h0lOVjrsWAqJJrWs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=GRF8fizpOlGdWgb6OVIlOdKBPHfTW7xeJr9FVpcJMsdQJjL8q39LwCmlut1qLE1iAph7QgS2XyBYxlN5rR5U91toPuDPRVN3BYZvHWX95/H99gvTL80XnIIpTkIXCwbDE5d1w75Djxwo3agmJLZJEKI0ZKC9VpCyJ/0UhDRByyI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 986023857BB3
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=FBMISDsJ
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4B47F45C42
	for <cygwin-patches@cygwin.com>; Fri, 30 May 2025 19:18:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Irxc2TCjU6f3oCydDVNB2KeHctU=; b=FBMIS
	DsJdfSarBM83xiZ/KaVx2eMrxs9grpMajQpl6Z0SVVabDV+2ry6gcX7QqerzW+3K
	7FZbLVBz7ZlgWeSS4rMADFUNMRuPAj5InMlJy3KGKaxg21MXNMKthjX6KQnEyXYf
	1SUsbdKtro3fpu/Yf0pLG37UcS/5f/+Rh73wSk=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 2E58945C1D
	for <cygwin-patches@cygwin.com>; Fri, 30 May 2025 19:18:56 -0400 (EDT)
Date: Fri, 30 May 2025 16:18:56 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 3/3] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <2f8b971d-a604-9bef-97d5-f816d92b9dfd@jdrake.com>
Message-ID: <3baf10c3-c393-1b04-c9d3-651c8eac9d28@jdrake.com>
References: <2f8b971d-a604-9bef-97d5-f816d92b9dfd@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 29 May 2025, Jeremy Drake via Cygwin-patches wrote:

> +  /* TODO: possibly implement spawnattr flags:
> +     POSIX_SPAWN_RESETIDS
> +     POSIX_SPAWN_SETPGROUP
> +     POSIX_SPAWN_SETSCHEDPARAM
> +     POSIX_SPAWN_SETSCHEDULER
> +     POSIX_SPAWN_SETSIGDEF
> +     POSIX_SPAWN_SETSIGMASK */

It looks like sigmask is already passed as part of child_info, but I don't
know if there's a good way to override it other than adding yet another
parameter to child_info_spawn::worker.  It took me a while to figure out
where it was getting set at all: child_info_spawn::worker calls the 'set'
method, which does a placement new over the existing 'this' pointer,
invoking the constructors.


> +	      case __posix_spawn_file_actions_entry::FAE_DUP2:
> +		if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
> +		  goto closes;
> +		fds[fae->fae_newfildes] = dup (fae->fae_fildes);
> +		oldflags[fae->fae_newfildes] = fcntl (fae->fae_newfildes,
> +						      F_GETFD, 0);
> +		fcntl (fae->fae_newfildes, F_SETFD, FD_CLOEXEC);
> +		break;

Minor bug-fix here

3:  713b610be3 ! 3:  999681b451 Cygwin: add fast-path for posix_spawn(p)
    @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
     +        case __posix_spawn_file_actions_entry::FAE_DUP2:
     +          if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
     +            goto closes;
    -+          fds[fae->fae_newfildes] = dup (fae->fae_fildes);
    ++          if (fae->fae_fildes >= 0 && fae->fae_fildes <= 2 &&
    ++              fds[fae->fae_fildes] != -1)
    ++            fds[fae->fae_newfildes] = dup (fds[fae->fae_fildes]);
    ++          else
    ++            fds[fae->fae_newfildes] = dup (fae->fae_fildes);
     +          oldflags[fae->fae_newfildes] = fcntl (fae->fae_newfildes,
     +                                                F_GETFD, 0);
     +          fcntl (fae->fae_newfildes, F_SETFD, FD_CLOEXEC);

> +	      /* TODO: FAE_(F)CHDIR */

I am not seeing how the posix cwd is passed to a spawned child.  Windows
handles the cwd itself, but for cases where the cwd is virtual (say under
/proc) there must be a way to pass a cwd that Windows doesn't know
about...
