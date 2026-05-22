Return-Path: <SRS0=Hoif=DT=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 1D78C4B92089
	for <cygwin-patches@cygwin.com>; Fri, 22 May 2026 07:29:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D78C4B92089
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D78C4B92089
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779434957; cv=none;
	b=RNsNggYexdw+Uk626MzEBJYQmlVXyreuqpwIbL2ynUUlmiCo7w96rza1ydbYx0+lmdP7fUP2ZVmInTPYi8Tr5HBkQEUbCqJ+xZhcrteHI1n573XORv0RmjjtUp9zXsTfoeLKvfSRwjIAw0dt7ybJyzBCa6Q7NuGBTv+ysXTT2/M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779434957; c=relaxed/simple;
	bh=yMvUUy9Yg32IyZItarhlqfC1c+ZxZnZpIkusT+8S0Ck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=strO7sBto5v+dDl3gvIbvHWm8oNnZGYh16jx0SYlPGOutQSzd4MH2ST3MqkWTA2xkMylRJn0ojs+P9jAiOlDT+f5oXvhzmp6TJY95MBA5yeyV0DS6b6UxPRyIdA5VmgurdJsA3yauh8mJp5tytVCG7gr4ro0S9Fy0buT9a1PcNA=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D78C4B92089
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 64M7igaE098547;
	Fri, 22 May 2026 00:44:42 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpd7fNRa1; Fri May 22 00:44:37 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: Implement 'reserved' marker in fdtable entries
Date: Fri, 22 May 2026 00:28:19 -0700
Message-ID: <20260522072913.574-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The existing logic for open() assumes an entry is always available in
the fdtable for a newly-created file.  The fdtable is extended if needed
up to OPEN_MAX in size.  Stress testing has found a situation where, if
there is no fdtable entry available, the file is created (by Windows)
but cannot be referenced by a Cygwin fd.

Investigation found the fdtable entry was not obtained until after low-
level operations had been done.  If the fdtable was full, the problem
situation occurs.  The solution is to obtain the fd earlier in open().

Then it was realized that there is no multi-thread protection of the
fdtable entries.  The fdtable itself can be locked and unlocked, but
the fdtable entries are either NULL (unused) or non-NULL (pointer to
fhandler_base structure associated with that fd).

With the planned update to open(), there was now a larger timing window
between obtaining the fdtable entry then associating the fhandler_base.
There is no protection against another thread obtaining the same fdtable
entry during that time.  This is true for any users of cygheap_fdnew;
open() is just one of the syscalls that have a possibly problematic
timing window.

This patch implements a 'reserved' marker for fdtable entries.  That
marker is an integer value equal to the fdtable entry index.  This leads
to localized changes in dtable.h and cygheap.h as laid out below.

The notion is that an fdtable entry provided by cygheap_fdnew is marked
so that another thread can't obtain it.  Care is taken to reset the
marker when the entry is no longer needed.  Actually, in the usual case
the marker is overwritten with a pointer to an fhandler_base structure,
by the reserving thread, as the syscall completes.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2026-May/259664.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: e859706578ba (* autoload.cc (NtCreateFile): Add.)

---
 winsup/cygwin/local_includes/cygheap.h | 31 +++++++++++++++++++++-----
 winsup/cygwin/local_includes/dtable.h  |  4 +++-
 winsup/cygwin/syscalls.cc              | 14 +++++-------
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_includes/cygheap.h
index 74cfff652..1eccf6d36 100644
--- a/winsup/cygwin/local_includes/cygheap.h
+++ b/winsup/cygwin/local_includes/cygheap.h
@@ -576,9 +576,13 @@ class cygheap_fdmanip
   fhandler_base *operator -> () const {return cygheap->fdtab[fd];}
   bool isopen () const
   {
-    if (cygheap->fdtab[fd])
+    /* check fdtab entry present (i.e. non-NULL) and not a "reserved" marker */
+    if (cygheap->fdtab[fd] && cygheap->fdtab[fd] != (fhandler_base *)(int64_t) fd)
       return true;
-    set_errno (EBADF);
+    /* check fdtab entry is not present */
+    if (cygheap->fdtab[fd] == NULL)
+      set_errno (EBADF);
+    /* remaining case is fdtab entry present and is a "reserved" marker */
     return false;
   }
 };
@@ -595,7 +599,11 @@ class cygheap_fdnew : public cygheap_fdmanip
     else
       fd = cygheap->fdtab.find_unused_handle (seed_fd + 1);
     if (fd >= 0)
-      locked = lockit;
+      {
+        locked = lockit;
+        /* mark as "reserved" for open(), or other syscall, in progress */
+        cygheap->fdtab[fd] = (fhandler_base *)(int64_t) fd;
+      }
     else
       {
 	/* errno set by find_unused_handle */
@@ -607,7 +615,18 @@ class cygheap_fdnew : public cygheap_fdmanip
   ~cygheap_fdnew ()
   {
     if (cygheap->fdtab[fd])
-      cygheap->fdtab[fd]->inc_refcnt ();
+      {
+        /* check if fdtab entry is a "reserved" marker */
+        if (cygheap->fdtab[fd] == (fhandler_base *)(int64_t) fd)
+          {
+            /* remove "reserved" marker */
+            cygheap->fdtab.lock ();
+            cygheap->fdtab[fd] = NULL;
+            cygheap->fdtab.unlock ();
+          }
+        else
+          cygheap->fdtab[fd]->inc_refcnt ();
+      }
   }
   void operator = (fhandler_base *fh) {cygheap->fdtab[fd] = fh;}
 };
@@ -620,7 +639,9 @@ public:
   {
     if (lockit)
       cygheap->fdtab.lock ();
-    if (fd >= 0 && fd < (int) cygheap->fdtab.size && cygheap->fdtab[fd] != NULL)
+    /* this is similar to ::isopen() above, but doesn't set_errno() on fail */
+    if (fd >= 0 && fd < (int) cygheap->fdtab.size && cygheap->fdtab[fd] &&
+	cygheap->fdtab[fd] != (fhandler_base *)(int64_t) fd)
       {
 	this->fd = fd;
 	locked = lockit;
diff --git a/winsup/cygwin/local_includes/dtable.h b/winsup/cygwin/local_includes/dtable.h
index 7803fae1b..a434554fb 100644
--- a/winsup/cygwin/local_includes/dtable.h
+++ b/winsup/cygwin/local_includes/dtable.h
@@ -51,7 +51,9 @@ public:
   inline int not_open (int fd)
   {
     lock ();
-    int res = fd < 0 || fd >= (int) size || fds[fd] == NULL;
+    /* treat fds entry marked "reserved" same as not present fds entry */
+    int res = fd < 0 || fd >= (int) size ||
+              fds[fd] == NULL || fds[fd] == (fhandler_base *)(int64_t) fd;
     unlock ();
     return res;
   }
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 7a8e5d4fd..e42771c18 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1460,6 +1460,12 @@ open (const char *unix_path, int flags, ...)
 
   __try
     {
+      /* try to reserve a new fd now rather than later in this block */
+      cygheap_fdnew fd;
+
+      if (fd < 0)
+        __leave;		/* errno already set */
+
       syscall_printf ("open(%s, %y)", unix_path, flags);
       if (!*unix_path)
 	{
@@ -1573,14 +1579,6 @@ open (const char *unix_path, int flags, ...)
 	try_to_bin (fh->pc, fh->get_handle (), DELETE,
 		    FILE_OPEN_FOR_BACKUP_INTENT);
 
-      cygheap_fdnew fd;
-
-      if (fd < 0)
-	{
-	  fh->close();
-	  __leave;		/* errno already set */
-	}
-
       fd = fh;
       if (fd <= 2)
 	set_std_handle (fd);
-- 
2.51.0

