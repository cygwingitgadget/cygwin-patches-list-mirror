Return-Path: <SRS0=LDpO=F4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id CB1B04BA540B
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 10:55:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB1B04BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB1B04BA540B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785754531; cv=none;
	b=u0Gxg2F6cUMKjY9KsYqnoTbcNS8mbwDf3b2SH/ldvrz9r/+83PGYAANNkZRKT9voitisB14lps+oVsFDHT+0KhWQtOuQEuyclQECGlSmigvc5fBPD5bwcBv0tfIeg3HSb603jRkda8XVVxN2Q/sRN603G0ihs+SYEXsYXlXRD1I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785754531; c=relaxed/simple;
	bh=aTUpyF63OD7EjjzqpfWZFOAhIjqwrnlPCiGgDWYGFBQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=B+Gecfnr9bIdf9ek1ENc8EhQ2+qfEZlK/dZN1HLpnaRHfz01cFd4EfVRhkBKUr+DNU90fmW8OmNyRMJlcXdkhx0GPHFowDGwPSrO0Jh+ZaxqShJHAE9C+/OFrLmU/Le3mQ5cdxg/u58TtrRieohqeZjqS7c/+zhUigHjTAhvwPc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gCQJhrrB
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB1B04BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gCQJhrrB
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260803105529150.ZTUU.117312.HP-Z230@nifty.com>;
          Mon, 3 Aug 2026 19:55:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: open: Do not set tentative fhandler to fdtab (A)
Date: Mon,  3 Aug 2026 19:55:09 +0900
Message-ID: <20260803105520.1232-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1785754529;
 bh=cHM6YNAZITumKQ+DeMX+ObeQbSaMa836HNkdskvATDY=;
 h=From:To:Cc:Subject:Date;
 b=gCQJhrrBbXeBCWcyciWdK6P8vp+GY0uqIq1RaNLuW6Yb56LiCLXk6MxIrQ6dGs8GMLrsCxhW
 UAYqI2BW3IhXy6jCfGPsaMFIqDnIF2OLdz3ASvLtFZkv46njfqeK1yr5ZiktzXuMAhAXcRnTr8
 JXzcD/jqwef4D1qVWagsNgKkEogssl7SA9N2u7KsYza4sTl1mS1iHtQm+82pf1XY/ia5uyuhcy
 oY8ApCcp/p/l5IiS7VbMz8eg6E1Po2nn0cOAhRpbEnwdXAiVD2V/0envgBjHiuvutw6wLsrdSe
 stvgAImRyIQIWusJQAYl5UoRYtAbP0qtZL+AAk1WxtPIuEKw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Tentative assignment of fhandler to fdtab introduced by the commit
524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
causes the undesired behaviour. The commit intended that fhandler
was just a marker for reservation of fd. However, another cygwin
call may assume that the fd is valid and in use, and may operate on
it.

This patch introduces a flag for fdtab that means the fd is reserved
and cannot be assigned for another open(), etc.

Fixes: 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/dtable.cc               | 17 ++++++++++++++++-
 winsup/cygwin/local_includes/dtable.h |  2 ++
 winsup/cygwin/syscalls.cc             |  7 ++++---
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index e4d1cdf8f..78eb7e3d9 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -73,6 +73,7 @@ dtable::extend (size_t howmuch, size_t min)
 {
   size_t new_size = size + howmuch;
   fhandler_base **newfds;
+  bool *new_reserved;
 
   if (new_size <= OPEN_MAX)
     /* ok */;
@@ -93,14 +94,28 @@ dtable::extend (size_t howmuch, size_t min)
       set_errno (ENOMEM);
       return 0;
     }
+  if (!(new_reserved =
+	(bool *) ccalloc (HEAP_ARGV, new_size, sizeof new_reserved[0])))
+    {
+      debug_printf ("calloc failed");
+      set_errno (ENOMEM);
+      cfree (newfds);
+      return 0;
+    }
   if (fds)
     {
       memcpy (newfds, fds, size * sizeof (fds[0]));
       cfree (fds);
     }
+  if (reserved)
+    {
+      memcpy (new_reserved, reserved, size * sizeof (reserved[0]));
+      cfree (reserved);
+    }
 
   size = new_size;
   fds = newfds;
+  reserved = new_reserved;
   debug_printf ("size %ld, fds %p", size, fds);
   return 1;
 }
@@ -233,7 +248,7 @@ dtable::find_unused_handle (size_t start)
   do
     {
       for (size_t i = start; i < size; i++)
-	if (fds[i] == NULL)
+	if (fds[i] == NULL && !reserved[i])
 	  {
 	    res = (int) i;
 	    goto out;
diff --git a/winsup/cygwin/local_includes/dtable.h b/winsup/cygwin/local_includes/dtable.h
index 7803fae1b..e3ba48228 100644
--- a/winsup/cygwin/local_includes/dtable.h
+++ b/winsup/cygwin/local_includes/dtable.h
@@ -21,6 +21,7 @@ class dtable
 {
   fhandler_base **fds;
   fhandler_base **archetypes;
+  bool *reserved;
   unsigned narchetypes;
   unsigned farchetype;
   static const int initial_archetype_size = 8;
@@ -76,6 +77,7 @@ public:
   void fixup_before_fork (DWORD win_proc_id);
   void lock () {lock_process::locker.acquire ();}
   void unlock () {lock_process::locker.release ();}
+  bool &reserve (int fd) { return reserved[fd]; }
 };
 
 fhandler_base *build_fh_dev (const device&, const char * = NULL);
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 5465d6c09..1d5e258dd 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1558,8 +1558,8 @@ open (const char *unix_path, int flags, ...)
 	  cygheap->fdtab.unlock ();
 	  __leave;		/* errno already set */
 	}
-      cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */
-      cygheap->fdtab.unlock();
+      cygheap->fdtab.reserve (fd) = true;
+      cygheap->fdtab.unlock ();
 
       if (fh->dev () == FH_PROCESSFD && fh->pc.follow_fd_symlink ())
 	{
@@ -1590,6 +1590,7 @@ open (const char *unix_path, int flags, ...)
       cygheap->fdtab.lock ();
       cygheap->fdtab[fd] = fh;
       fh->inc_refcnt ();
+      cygheap->fdtab.reserve (fd) = false;
       cygheap->fdtab.unlock ();
 
       if (fd <= 2)
@@ -1601,7 +1602,7 @@ open (const char *unix_path, int flags, ...)
     if (res < 0 && fd >= 0)
       {
 	cygheap->fdtab.lock ();
-	cygheap->fdtab[fd] = NULL; /* Mark as unused */
+	cygheap->fdtab.reserve (fd) = false;
 	cygheap->fdtab.unlock ();
       }
   if (res < 0 && fh)
-- 
2.51.0

