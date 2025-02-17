Return-Path: <SRS0=OXt3=VI=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id ADF553858C54;
	Mon, 17 Feb 2025 17:38:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ADF553858C54
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ADF553858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739813920; cv=none;
	b=n/uZTZvUYAYJ4ZPmPU51oaLI+drZfDRfH4fWp8npaKCS6VLIhJxX5vICoOmkCSQXh2+OQnoqpL4Bl6TpfN5IurUpn90FoGRdjOJ6woqpOliIwJNI6Ag8eM+llCFuPYRgiYq5yKcMFv1GJ1PG4zmrO87AQPbMpoooA/8nA2ukMBs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739813920; c=relaxed/simple;
	bh=AUQvUhF9qudrfmDysJ37wqSqV58tZm2Cl9gaJrGVmN4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=gpvGH7mNPjwHqNyTJMGZlARcXHADnIm/VwoOVBDZKEbZYqt51IER8tfIyVFgnK4u+Qd5JxYVsCMonCPkPULj9a7oMVpBNK6jIfVOnXxX4pBkuZYqxwd83SQyAsLHC8NiJgcS4nS3anhJiSUd0ScNzxuFaI948nDmA+AGNG7ZGJc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ADF553858C54
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=V1OqJDUM
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 82E3A45BF6;
	Mon, 17 Feb 2025 12:38:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=pKYrXXwVMF8+EonCvBGXdLNtYJ4=; b=V1OqJ
	DUM9Ojpwht4estfVQIsQ93EKKh508joO+KB6QOz63SIro27QFa+uN+LC8aJtUn75
	JqT3RTkMo7yY3I7AHRYn7tqb2ROvqVQR9NlbC+Z5nJ6q5RN+m1UE7haNYuJNET+1
	oE6Y7hMb2SiLxT8p6+cb7xE3aj7itaj3+heocg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 5550F45BD4;
	Mon, 17 Feb 2025 12:38:40 -0500 (EST)
Date: Mon, 17 Feb 2025 09:38:40 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin@cygwin.com
cc: cygwin-patches@cygwin.com
Subject: Re: WinAPI spawn() not used by Cygwin posix_spawn()? Re: [PATCH]
 Cygwin: Add spawn family of functions to docs
In-Reply-To: <Z7MKkIbgMh0C5snl@calimero.vinschen.de>
Message-ID: <7ae72b46-ca96-092e-9cd6-aaa7f61b8a0e@jdrake.com>
References: <20250216214657.2303-1-mark@maxrnd.com> <CAPJSo4VH0MufLhpgPiD1GV1gFsbTLdtOKrP82eaA_Yv_DHPXEQ@mail.gmail.com> <Z7MKkIbgMh0C5snl@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 17 Feb 2025, Corinna Vinschen wrote:

> The requirements of posix_spawn and their helper functions are so
> that we can't easily fulfill them without doing the fork/exec
> twist.
>
> See https://man7.org/linux/man-pages/man3/posix_spawn.3.html.
> Windows CreateProcess() is not quite the same as Linux clone().
>
> However, if you think you can come up with a version only running the
> spawnve function and thus speed up Cygwin, feel free to send patches.

(based on my recollections rather than actually reading the docs again...)
Specifically, maybe the case where the attributes which are supposed to do
things effectively between fork and exec are not set could be fast-pathed
to use spawn/CreateProcess, and the more complex cases fall back to
fork/exec.  If the created process is also a Cygwin process, perhaps the
actions that are supposed to happen between fork and exec could happen in
the startup code (much like fork emulation).

Just brainstorming.

BTW, I vaguely remember an issue with GNU make in MSYS2, where we found
that making it *not* use posix_spawn made it faster.
https://github.com/msys2/MSYS2-packages/blob/a0902f1e21781022c5ceca44c64190998a62e048/make/PKGBUILD#L31-L32

