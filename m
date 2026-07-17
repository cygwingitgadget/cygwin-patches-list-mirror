Return-Path: <SRS0=sMld=FL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id EE4284BA2E11
	for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2026 03:10:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE4284BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EE4284BA2E11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784257831; cv=none;
	b=F60YnINchV3vIz15ZBqf/2D9AMcSA3aCEjwbLtu0Dg58CMlwS9IiEYRFJCb+GY76UgVVBl0MUJd5HH5Ebv5BNlrBewKW3aP1hWJmFBmPmKqpG2hnY/O0l9XBhkDqumYapdCJ/Nl2y56tI4+Kq/jwCK2YGe0OyOfFghAUIoE32Ew=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784257831; c=relaxed/simple;
	bh=oAkpFfgTS4zoQaSBrlmX508B7GfbGBirQhiKiOt9uOM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jzg06uJGwaRiQ5i8FKnhwPy3RyBdtyubRjwV0Gb45gAeXYrL2rOjFqt6mLdJrkfMh1ayPMAZPTFqHstZU+YbqAxYjKvmSe36uU+5P6ryx4bKJEiJOXmMDYcxxVkDSillo7jnGlUYibSt4qGlZjzS3+Db4/Sg2zfFKHMd4WPE7wk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qETMH4Wx
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EE4284BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qETMH4Wx
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260717031028700.BSGW.102121.HP-Z230@nifty.com>;
          Fri, 17 Jul 2026 12:10:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	kikairoya <kikairoya@gmail.com>
Subject: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
Date: Fri, 17 Jul 2026 12:10:12 +0900
Message-ID: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784257828;
 bh=dEobIIDYnKTP8l3nO7kgdreoZxtTQTwD2rm9r9UNVWk=;
 h=From:To:Cc:Subject:Date;
 b=qETMH4WxFpI6GhYhjqFDE/1VmmXvzTUdUtb7P+tcfdvilvE3gudyx7JlO2RvDEXieKLpAtGB
 hEULHkFZAQfQvo+j7/Elu2ud42woR4vegiywh0ro7mrq38mYM6e5HQeBBdhO8VwKw0PiSPgYXI
 13MP9vHvksQhuyQs+7zHRPODchbtNP6ZxWd6p2L4KRRG+rmKY/uEpKQOycqzsRdA5iScVupi+Y
 SCt5bwSFCjIGhzl262/etJyE5Tzf7qkD8X8qi3rRXBzFmcSDwVcrPD6caYinL52VbZSLRVQvP5
 eSzRfUspBPbjaoDj+D6UiReh7GorfnIFF2ugl4icnFT6RhvA==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
v2: Add lock/unlock when modifying the fdtab, just to be safe.

 winsup/cygwin/syscalls.cc | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 2bea79768..e3ba8c65c 100644
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
@@ -1580,13 +1584,23 @@ open (const char *unix_path, int flags, ...)
 	try_to_bin (fh->pc, fh->get_handle (), DELETE,
 		    FILE_OPEN_FOR_BACKUP_INTENT);
 
-      fd = fh;
+      cygheap->fdtab.lock ();
+      cygheap->fdtab[fd] = fh;
+      fh->inc_refcnt ();
+      cygheap->fdtab.unlock ();
+
       if (fd <= 2)
 	set_std_handle (fd);
       res = fd;
     }
   __except (EFAULT) {}
   __endtry
+    if (res < 0 && fd >= 0)
+      {
+	cygheap->fdtab.lock ();
+	cygheap->fdtab[fd] = NULL; /* Mark as unused */
+	cygheap->fdtab.unlock ();
+      }
   if (res < 0 && fh)
     delete fh;
   syscall_printf ("%R = open(%s, %y)", res, unix_path, flags);
-- 
2.51.0

