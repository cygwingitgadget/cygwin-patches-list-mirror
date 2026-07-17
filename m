Return-Path: <SRS0=sMld=FL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id EE5034BA2E11
	for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2026 02:38:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE5034BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EE5034BA2E11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784255917; cv=none;
	b=ol204aL30OrLRRbEkheVQ/PUDdK+HaG3wd8b4kijJE6igQ1uqWr+X/sK/0e7rF5hZl3e/MOqNgTulHrkaCIDmEe1VXjQtR8dkksPYOS1SSD49jqbSJSZFSE3oUqyvjWCEDJwPLo1eiSe9X0JGC6UxM5PzTUu9Iu9zEgSGSLOvVQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784255917; c=relaxed/simple;
	bh=WHKp2pbfmnrIvQmQjjAWT9i1M6pWz5uPbCrZcpm/sZw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=IMY11v0pZBU87CyjN0OwJ4pSWUYVdNvxCgdtq2j6b3//pRoSnpZIxfL+5HvXhrX2kDVHr3sFmJNCQdkNyFWqQtj/D/8a/8hS8RVUWUCPumiS/gRTM3VcF04c0aJv5v99w69Mal3T827uwo7xYO6+Qor8frV/QEYgNmswLP8l1k0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Opg8+1j2
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EE5034BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Opg8+1j2
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260717023832633.ERSO.17441.HP-Z230@nifty.com>;
          Fri, 17 Jul 2026 11:38:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	kikairoya <kikairoya@gmail.com>
Subject: [PATCH] Cygwin: open: Unlock fdtab before open_with_arch()
Date: Fri, 17 Jul 2026 11:38:18 +0900
Message-ID: <20260717023826.1398-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784255912;
 bh=Z1TQcX5suzBlhQrhHc/8zR5Bcys/mnln+7bD0+DkBMM=;
 h=From:To:Cc:Subject:Date;
 b=Opg8+1j2QAGn9KZgAEF/uCerZsr20a/QLhP9SPnXhF8ilWm0thT+I5MKksXsBGjT0dyqQYlQ
 MXoBk6lTOxizDl7urZ8xKEOqqaCVST5HvN3brs2OdsUvQsRkNCrxcEIJZqK1smRyms47EXIgZ5
 iaXk2Kd+Wgbk4eq2JAop2HLNrY3O9L6GYt5DE0uO0oNBscg0Jnei2MUSrJDym2b62UnJKj9rS/
 xRKsZMiwFvyKlqn5D1wd4IPFZc08jSmT1l5XTYASl8iKPIF4G7fz7kann2Z5dwNFkdB/KM5oAS
 3TMrPSMwznUFsV/SlPdv5H/aROEkJZpTg4Gd2+3iG0B6DoqA==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Since the commit 31bf91f867c5, opening fifo causes a deadlock. This
is because, open_with_arch() for fifo can be blocked until the other
side of the fifo is opened. The commit 31bf91f867c5 moves the creating
cygheap_fdnew before open_with_arch() to address the issue:
https://cygwin.com/pipermail/cygwin/2026-May/259664.html
However, cygheap_fdnew locks fdtab, so open() for the other side of
fifo cannot create cygheap_fdnew until fdtab is unlocked. This is
the cause of the deadlock.

With this patch, fdtab is unlocked before open_with_arch(), but marked
as used using tentative fhandler. The summary of open() is as follows.
 1) Lock fdtab.
 2) Create new fd.
 3) Mark fd as used using tentative fhandler.
 4) Unlock fdtab.
 5) Call open_with_arch().
 6) Set final fhandler to fd.

The important point is that create fd before open_with_arch() to
address https://cygwin.com/pipermail/cygwin/2026-May/259664.html,
but unlock fdtab before open_with_arch() to address
https://cygwin.com/pipermail/cygwin/2026-July/259884.html.

Fixes: 31bf91f867c5 ("Cygwin: Ensure unused fd available for open()")
Addresses: https://cygwin.com/pipermail/cygwin/2026-July/259884.html
Reported-by: kikairoya <kikairoya@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/syscalls.cc | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 2bea79768..5ea006034 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1451,6 +1451,7 @@ extern "C" int
 open (const char *unix_path, int flags, ...)
 {
   int res = -1;
+  int fd = -1;
   va_list ap;
   mode_t mode = 0;
   fhandler_base *fh = NULL;
@@ -1550,9 +1551,12 @@ open (const char *unix_path, int flags, ...)
       /* Reserve an fdtable entry here, before calling open_with_arch() below.
          Otherwise there's a tiny chance of hitting OPEN_MAX further on which
          could create a new file without any way for Cygwin to refer to it. */
-      cygheap_fdnew fd;
+      cygheap->fdtab.lock();
+      fd = cygheap->fdtab.find_unused_handle ();
       if (fd < 0)
-        __leave;		/* errno already set */
+	__leave;		/* errno already set */
+      cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */
+      cygheap->fdtab.unlock();
 
       if (fh->dev () == FH_PROCESSFD && fh->pc.follow_fd_symlink ())
 	{
@@ -1580,13 +1584,17 @@ open (const char *unix_path, int flags, ...)
 	try_to_bin (fh->pc, fh->get_handle (), DELETE,
 		    FILE_OPEN_FOR_BACKUP_INTENT);
 
-      fd = fh;
+      cygheap->fdtab[fd] = fh;
+      fh->inc_refcnt ();
+
       if (fd <= 2)
 	set_std_handle (fd);
       res = fd;
     }
   __except (EFAULT) {}
   __endtry
+    if (res < 0 && fd >= 0)
+      cygheap->fdtab[fd] = NULL; /* Mark as unused */
   if (res < 0 && fh)
     delete fh;
   syscall_printf ("%R = open(%s, %y)", res, unix_path, flags);
-- 
2.51.0

