Return-Path: <SRS0=7LkC=YN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id EA5373857C6C
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 17:56:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EA5373857C6C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EA5373857C6C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748541408; cv=none;
	b=G/kS2L2Y5oMxq/rM87iYJhHS5ajxcM3+X2fcre9ZQn1hW2bewVrRTJV9tR/Tz581sk0YLGr/0OA1FER3WyHF2O9wqrkgQiDh7lDFvOOeITP5NAlYO5xtae1e3abamm8NSIEa0jOCLJD+xZxC95EFFAApAIcRj2nOMcNviuAu1Zk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748541408; c=relaxed/simple;
	bh=ADUxhNJ6Ao2M2OyYPlHaU3M+5GgGGihx8ugR4l5wIlU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=qNEI/A2MgaAeGcbUUJOvaIhUJGXQfOPnKN5rRQ6UWSZsm1o4K1JsLjfXJyXbWYzwpu6wW+uIU8eG+3cZ3i1Q384aXxZNQaN7LCaVSvMf2pajC12oMVHYnxt4esyThhhBVjDaBGrg5P+zw+DLenImlbkQtAEuC7KQVr1XSZ9uSgk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EA5373857C6C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=yFJg+anK
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9235E45CB2
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 13:56:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=XAzxo
	c6FI7tffiOlkkQAVUXACLE=; b=yFJg+anK/DvG5gyQBnOKuYFtMwzC3daRfu0Km
	M20rJFl5kSj3AHBrHoN6v6KWjimE+EZmaBst7Ha+iDfSXw4Q5UlMt2dvf5Ycgrwz
	eZDOy5gk06WZK9p+h+XY4KAax0GO7aWBPPLDajcz5yx+w3s4EP8TnCMgp93btjjI
	S8BTSE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 8C1B245CA8
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 13:56:47 -0400 (EDT)
Date: Thu, 29 May 2025 10:56:47 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [RFC PATCH 0/3] posix_spawn improvements
Message-ID: <118ca545-598c-cd2d-3813-e27c99b85d0b@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

An idea I proposed on cygwin-devel that I intended to look at for 3.7, and
which came up again with rustc having dll base conflicts, I started
looking at optimizing posix_spawn to use spawn instead of fork/exec where
it's already more-or-less possible.  I did add the ability to redirect
stderr in ch_spawn.worker, as was already done for stdin and stdout, since
that was used by rust and apparently by llvm.  I have not handled any of
the spawnattr flags or (f)chdir, but it feels like they shouldn't be too
horribly difficult to deal with (particularly chdir since CreateProcessW
can take a current directory parameter).

The ugliness of this is that I had to copy/paste some structs from
newlib/libc/posix/posix_spawn.c to access the file actions.

Jeremy Drake (3):
  Cygwin: allow redirecting stderr in ch_spawn
  Cygwin: hook posix_spawn/posix_spawnp
  Cygwin: add fast-path for posix_spawn(p)

 winsup/cygwin/cygwin.din                  |   4 +-
 winsup/cygwin/dcrt0.cc                    |   2 +
 winsup/cygwin/local_includes/child_info.h |   6 +-
 winsup/cygwin/spawn.cc                    | 167 +++++++++++++++++++++-
 4 files changed, 172 insertions(+), 7 deletions(-)

-- 
2.49.0.windows.1

