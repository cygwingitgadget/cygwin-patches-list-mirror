Return-Path: <SRS0=VIT6=WW=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id BCE453861856
	for <cygwin-patches@cygwin.com>; Fri,  4 Apr 2025 17:13:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BCE453861856
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BCE453861856
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743786815; cv=none;
	b=ljVJiylfX22/aftHNIUtTpGC1u/Ms1SF/OjJfdIeELm0ZLPas4Zw0a9FXCf60/LCmqj3TImanZAM8GRf+EIa3RKNE1NUQSHKxeKCKBPHX49J0+GC2TJUYqhrGzt6Kx8IUyeGPjHbIjX04t6V8Rla8M5sJEtVdOubELebOpVe//c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743786815; c=relaxed/simple;
	bh=GJmrdWS3Mbj7dxXjCnmCGXeIelqT727I/qokhFxiV+g=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=pAwNWHUcsbs+FzSROtHxSi9oaCg2prIOjHFddmbk3nFO4Fe95iBVl3Ix4Seuq/ldSH/seKzsK60/DDkXqTGTxmkfzRKnJH3Czce0rH954d1weEd1epdfK5FVLQcsAexJ1LdFYdenKgvswSudAhw6hSC3Pzu2po/6SwiHkedp6o0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BCE453861856
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=uKx0wNVK
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 6587B45CAB;
	Fri, 04 Apr 2025 13:13:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=9ZhPRrXAtgYc7sDnXUTw/DoQlmw=; b=uKx0w
	NVKVykPbOlfNN1CnUsGNCbv7kMmlTxiYwvBUArqurGFeYkfpK+5E4OU26HqCxgSj
	FX06t5JIL1m1VOLCGHpI2gHW8NQrcl6ltFF4JXr2k1ORSQdl9JwpUqsSh0IETNqx
	YvzfxtIbXvFb0W4Oizdq4vXkrj8npbnUlzYweg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 6066345CA9;
	Fri, 04 Apr 2025 13:13:35 -0400 (EDT)
Date: Fri, 4 Apr 2025 10:13:35 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other
 initializations
In-Reply-To: <20250404234129.144ce273445bab47737cbdeb@nifty.ne.jp>
Message-ID: <dd4363f5-8d9c-af84-91dc-3c52dc5f7f0a@jdrake.com>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp> <969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de> <ec45497d-a248-1056-4993-da137267b7c5@jdrake.com> <20250404105839.6652c8849bfb169d669f3799@nifty.ne.jp> <C262E1A5-1B14-4D38-AE47-2EC7709DB6D1@gmx.de>
 <20250404210609.b0d38a4cac7e195ad20a9ced@nifty.ne.jp> <57624128-5aa1-b47f-a192-2b342eb2072b@gmx.de> <20250404225337.08412ac9089cc9a066cae4da@nifty.ne.jp> <15ea8e11-bef3-f08e-e0a1-c6c5aaaad519@gmx.de> <20250404234129.144ce273445bab47737cbdeb@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15595026251776-729146534-1743786815=:11368"
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15595026251776-729146534-1743786815=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Apr 2025, Takashi Yano wrote:

> On Fri, 4 Apr 2025 16:17:21 +0200 (CEST)
> Johannes Schindelin wrote:
> > But that means that the `signal_arrived` that is copied from the pare=
nt
> > process should be invalidated in the child processes, right?
>
> Yes.
>
> The 'value' of the handle is copied by child_copy() because the process
> is forked, however, the handle itslef is not validated because the hand=
le
> is created by:
>       signal_arrived =3D CreateEvent (NULL, false, false, NULL);
> (i.e. lpEventAttributes is NULL)
>
> [in, optional] lpEventAttributes
> A pointer to a SECURITY_ATTRIBUTES structure. If this parameter is NULL=
,
> the handle cannot be inherited by child processes.

One bit of info was missing from that reply: the 'value' of signal_arrive=
d
is 'invalidated in the child process' by fixup_after_fork, hence why
moving pthread::atforkchild later in that function seems like the correct
fix.  I think anything which runs user callbacks should be late enough in
that function that it can be assured that if the callback calls any cygwi=
n
dll functions, they will work just as well as if they were called after
fork returned 0.  (The man page for pthread_atfork on Linux says:
> After a fork(2) in a multithreaded process returns  in  the  child,  th=
e
> child   should   call   only   async-signal-safe   functions  (see  sig=
=E2=80=90
> nal-safety(7)) until such time as it calls execve(2) to  execute  a  ne=
w
> program.

Note that pthread_atfork doesn't necessarily imply a multithreaded proces=
s
though, it's just that pthread happened to be the part of POSIX that
specified a callback mechanism for fork (opensc used it to make sure the
forked child did not inherit the active session to the smartcard, for
security purposes.  They probably could have used O_CLOFORK if it
existed at the time).
--15595026251776-729146534-1743786815=:11368--
