Return-Path: <SRS0=+6LR=VP=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id B0C813858D29
	for <cygwin-patches@cygwin.com>; Mon, 24 Feb 2025 21:22:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B0C813858D29
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B0C813858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740432157; cv=none;
	b=sZNKhQCBv8fs6SXHV+l9o9bKnsnG0jEjqp7QoSlMvSUq3MgLkPE6jixqbkJp8IX5jsLyAA2Gu+tAEaTBAc/9OItAVf4R5B/0pqbwO0//213z+RsOaI8E461M6GwOZ+6O1xqiqYyp5F7VYcZbDGE3jXalHXPCnouoSXYB/GTXUz4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740432157; c=relaxed/simple;
	bh=1C7ITIbSl2zq+xcddhIPdQCLZrldPgpOyqMqz1244a0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=CqUnNv9HuNOKN9xMeuwKNulCBJTkBabg40tN7X0kYrLMs+Un3jE8GBBVX+cbPxq9CWLNIW8C+eNnZ9wrsa/LldlFsCvEOuoxksX29MzEsR4Wk01jVNJ+WTD3XQNIezjgvCiD9jdfaj8WF/SL+cKdMoSfjDnVRu62LsI6WF0SbRo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B0C813858D29
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=cXcIjhSk
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3E8EF459FE;
	Mon, 24 Feb 2025 16:22:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:message-id:mime-version:content-type; s=csoft; bh=wA
	XPUqmkOLP1jk5nKk1UUpzedvI=; b=cXcIjhSk81ccPQoprXjBqJnfN05U0TfZJr
	Yvmfepm1zPp/RGFisC9S37FMJtWWtqSJdLrb80jAlbKEyD3zbZoDDYJf4TcV9MMY
	0R3Ga0zWgdqxIlqqrRjjrbH8pC0p3keCHt5/5BQVMTfxBHirImPQWC6InrVbEH8f
	MJTFvCxMk=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0618F45C32;
	Mon, 24 Feb 2025 16:22:37 -0500 (EST)
Date: Mon, 24 Feb 2025 13:22:36 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Patch from git-for-windows for SSH hangs
Message-ID: <3604c9a5-c130-da33-076a-987b6cf3c7a7@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch exists in the git-for-windows fork of msys2-runtime (which is
itself a fork of cygwin).  There have been complaints and requests to
apply this patch to msys2-runtime (such as
https://github.com/msys2/MSYS2-packages/issues/4962), but it makes more
sense to me to try to figure this out upstream, so everyone can benefit.
I did not write the patch, nor do I personally encounter the bug it is
intended to fix, so I can't really advocate for its approach, but the
commit message is pretty detailed as to the investigation that led to it.

This is the original patch from
https://github.com/git-for-windows/msys2-runtime/pull/75, if necessary I
can rebase it on cygwin's master branch, it does so cleanly (or you can
try git am -3, that tends to work for me in cases where straight git am
does not).

-- >8 --
From cbe555e054cefeccd65250bb11dc56f82196301f Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 10 Oct 2024 19:52:47 +0200
Subject: [PATCH] Fix SSH hangs

It was reported in https://github.com/git-for-windows/git/issues/5199
that as of v3.5.4, cloning or fetching via SSH is hanging indefinitely.

Bisecting the problem points to 555afcb2f3 (Cygwin: select: set pipe
writable only if PIPE_BUF bytes left, 2024-08-18). That commit's
intention seems to look at the write buffer, and only report the pipe as
writable if there are more than one page (4kB) available.

However, the number that is looked up is the number of bytes that are
already in the buffer, ready to be read, and further analysis
shows that in the scenario described in the report, the number of
available bytes is substantially below `PIPE_BUF`, but as long as they
are not handled, there is apparently a dead-lock.

Since the old logic worked, and the new logic causes a dead-lock, let's
essentially revert 555afcb2f3 (Cygwin: select: set pipe writable only if
PIPE_BUF bytes left, 2024-08-18).

Note: This is not a straight revert, as the code in question has been
modified subsequently, and trying to revert the original commit would
cause merge conflicts. Therefore, the diff looks very different from the
reverse diff of the commit whose logic is reverted.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/select.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index bc02c3f9d4..2c09b14d1c 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -776,7 +776,7 @@ peek_pipe (select_record *s, bool from_select)
 	}
       ssize_t n = pipe_data_available (s->fd, fh, h, PDA_SELECT | PDA_WRITE);
       select_printf ("write: %s, n %d", fh->get_name (), n);
-      gotone += s->write_ready = (n >= PIPE_BUF);
+      gotone += s->write_ready = (n > 0);
       if (n < 0 && s->except_selected)
 	gotone += s->except_ready = true;
     }
@@ -990,7 +990,7 @@ peek_fifo (select_record *s, bool from_select)
       ssize_t n = pipe_data_available (s->fd, fh, fh->get_handle (),
 				       PDA_SELECT | PDA_WRITE);
       select_printf ("write: %s, n %d", fh->get_name (), n);
-      gotone += s->write_ready = (n >= PIPE_BUF);
+      gotone += s->write_ready = (n > 0);
       if (n < 0 && s->except_selected)
 	gotone += s->except_ready = true;
     }
@@ -1416,7 +1416,7 @@ peek_pty_slave (select_record *s, bool from_select)
     {
       ssize_t n = pipe_data_available (s->fd, fh, h, PDA_SELECT | PDA_WRITE);
       select_printf ("write: %s, n %d", fh->get_name (), n);
-      gotone += s->write_ready = (n >= PIPE_BUF);
+      gotone += s->write_ready = (n > 0);
       if (n < 0 && s->except_selected)
 	gotone += s->except_ready = true;
     }
