Return-Path: <SRS0=8hwm=F6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 4333A4BA903E
	for <cygwin-patches@cygwin.com>; Wed,  5 Aug 2026 07:18:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4333A4BA903E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4333A4BA903E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785914295; cv=none;
	b=nMvnDmyXwxb8Ps5FaQKc/9SsB8JIyUokkmuirQfTYITF1SO5QEyp5YFCZyPXTuFcznpjbhdX9ARakHx4esZL4Uz8V9AfQZ3SbdxamczQXHB5YUpvihp9PVaopDVqKkrH5Sx6CNnxJPSaIHqOwBjwVMO1DZ9eIbgCIRKACxOe94w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785914295; c=relaxed/simple;
	bh=ySsASnwXPgMuQVOsdfvRrcqRMBn3SIFQS3JrXTqeCsY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=nTRC8GxqFl7Yu7iFwHP6YrEq2lL59Kqlpo56mIPSJI8Z/b6N7cvFhejiOJMx8gNqjcQs69S1rdS2SUjD9SSwtp2FwgNPulke6fbprdUqiic35qP0A8BiptcAJM/fiO2vk+h2fGjJqxhKKoFJubM9/yMsQEKQuPhE6Em1WTnad3c=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dHJ0nrvc
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4333A4BA903E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dHJ0nrvc
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260805071810114.HAUG.102121.HP-Z230@nifty.com>;
          Wed, 5 Aug 2026 16:18:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: open: Do not set tentative fhandler to fdtab
Date: Wed,  5 Aug 2026 16:17:53 +0900
Message-ID: <20260805071801.1079-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1785914290;
 bh=5B61MW+RCwwvjWG18CZN7RmaPp7eTmZXUZkQt2HVGD8=;
 h=From:To:Cc:Subject:Date;
 b=dHJ0nrvckIsPXy4UWg7n2NcLzYOdaAT7lNSt1vRlXIZVOx/sRhQ97DSbFNkM1HTyvSOe0oLO
 5F94hmWWNOoDiL3/iIoOYeKXAukUVPeUK9R/7Z4vWfzZ7NCwvkD/qX4uW7SRguyWUvcCu8ZpBp
 cPA4fUTxQT+dhgzBUQ3aaZKAUh8Pd2WzXu8YNRSMe0L7T1ku8zDJX0lfTI7mMGSbrYXAwwegbD
 kNCH/lzs1Bvs1snpoqR0zKxK/Vc7C0k2Xve/om2MUyod0FYjFFx2hlfXZVsGKrN+40hoLmXN1H
 /SCZih5R+6LC2Dmsj6vE2cTmfO4K5gEhN6kRgl3VfvAgoMCw==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Tentative assignment of fhandler to fdtab introduced by the commit
524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
causes the undesired behaviour. The commit intended that fhandler
was just a marker for reservation of fd. However, another cygwin
call may assume that the fd is valid and in use, and may operate on
it.

This patch introduces a special value ((fhandler_base *) -1) for
fdtab that marks the fd as reserved and means it cannot be assigned
for another open(), etc.

Fixes: 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/dtable.cc                | 29 ++++++++++++-----------
 winsup/cygwin/local_includes/cygheap.h |  6 ++---
 winsup/cygwin/local_includes/dtable.h  | 32 ++++++++++++++++++++++++--
 winsup/cygwin/syscalls.cc              | 13 +++++++----
 4 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index e4d1cdf8f..7a4fd7dca 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -13,6 +13,7 @@ details. */
 #include <stdio.h>
 #include <unistd.h>
 #include <wchar.h>
+#include <assert.h>
 
 #define USE_SYS_TYPES_FD_SET
 #include <winsock.h>
@@ -123,7 +124,7 @@ dtable::get_debugger_info ()
 	    fhandler_base *fh = build_fh_name (std[i]);
 	    if (!fh)
 	      continue;
-	    fds[i] = fh;
+	    fds.set_fhandler (i, fh);
 	    if (!fh->open ((i ? (i == 2 ? O_RDWR : O_WRONLY) : O_RDONLY)
 			   | O_BINARY, 0777))
 	      release (i);
@@ -233,7 +234,7 @@ dtable::find_unused_handle (size_t start)
   do
     {
       for (size_t i = start; i < size; i++)
-	if (fds[i] == NULL)
+	if (fds[i] == NULL && !fds.reserved (i))
 	  {
 	    res = (int) i;
 	    goto out;
@@ -249,8 +250,9 @@ dtable::release (int fd)
 {
   if (fds[fd]->need_fixup_before ())
     dec_need_fixup_before ();
+  assert (fds[fd]);
   fds[fd]->dec_refcnt ();
-  fds[fd] = NULL;
+  fds.set_fhandler (fd, NULL);
   if (fd <= 2)
     set_std_handle (fd);
 }
@@ -263,11 +265,12 @@ cygwin_attach_handle_to_fd (char *name, int fd, HANDLE handle, mode_t bin,
   if (fd == -1)
     fd = cygheap->fdtab.find_unused_handle ();
   fhandler_base *fh = build_fh_name (name);
-  if (!fh)
+  if (!fh || cygheap->fdtab.reserved (fd))
     fd = -1;
   else
     {
-      cygheap->fdtab[fd] = fh;
+      cygheap->fdtab.set_fhandler (fd, fh);
+      assert (cygheap->fdtab[fd]);
       cygheap->fdtab[fd]->inc_refcnt ();
       fh->init (handle, myaccess, bin ?: fh->pc_binmode ());
     }
@@ -348,7 +351,7 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
     handle_to_fn (handle, name);
 
   if (!name[0] && !dev)
-    fds[fd] = NULL;
+    fds.set_fhandler (fd, NULL);
   else
     {
       fhandler_base *fh;
@@ -425,7 +428,8 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
       if (!fh->open_setup (openflags))
 	api_fatal ("open_setup failed, %E");
       fh->usecount = 0;
-      cygheap->fdtab[fd] = fh;
+      cygheap->fdtab.set_fhandler (fd, fh);
+      assert (cygheap->fdtab[fd]);
       cygheap->fdtab[fd]->inc_refcnt ();
       set_std_handle (fd);
       paranoid_printf ("fd %d, handle %p", fd, handle);
@@ -795,16 +799,15 @@ dtable::dup3 (int oldfd, int newfd, int flags)
 
   if (!not_open (newfd))
     close (newfd);
-  else if ((size_t) newfd >= size
-	   && find_unused_handle (newfd) < 0)
+  else if (((size_t) newfd >= size && find_unused_handle (newfd) < 0)
+	   || reserved (newfd))
     /* couldn't extend fdtab */
     {
       newfh->close ();
       res = -1;
       goto done;
     }
-
-  fds[newfd] = newfh;
+  fds.set_fhandler (newfd, newfh);
 
   if ((res = newfd) <= 2)
     set_std_handle (res);
@@ -874,8 +877,8 @@ void
 dtable::move_fd (int from, int to)
 {
   // close (to); /* It is assumed that this is close-on-exec */
-  fds[to] = fds[from];
-  fds[from] = NULL;
+  fds.set_fhandler (to, fds[from]);
+  fds.set_fhandler (from, NULL);
 }
 
 void
diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_includes/cygheap.h
index 74cfff652..db740f03d 100644
--- a/winsup/cygwin/local_includes/cygheap.h
+++ b/winsup/cygwin/local_includes/cygheap.h
@@ -569,10 +569,10 @@ class cygheap_fdmanip
   }
   virtual void release () { cygheap->fdtab.release (fd); }
   operator int &() {return fd;}
-  operator fhandler_base* &() {return cygheap->fdtab[fd];}
+  operator fhandler_base* () {return cygheap->fdtab[fd];}
   operator fhandler_socket* () const {return reinterpret_cast<fhandler_socket *> (cygheap->fdtab[fd]);}
   operator fhandler_pipe* () const {return reinterpret_cast<fhandler_pipe *> (cygheap->fdtab[fd]);}
-  void operator = (fhandler_base *fh) {cygheap->fdtab[fd] = fh;}
+  void operator = (fhandler_base *fh) {cygheap->fdtab.set_fhandler (fd, fh);}
   fhandler_base *operator -> () const {return cygheap->fdtab[fd];}
   bool isopen () const
   {
@@ -609,7 +609,7 @@ class cygheap_fdnew : public cygheap_fdmanip
     if (cygheap->fdtab[fd])
       cygheap->fdtab[fd]->inc_refcnt ();
   }
-  void operator = (fhandler_base *fh) {cygheap->fdtab[fd] = fh;}
+  void operator = (fhandler_base *fh) {cygheap->fdtab.set_fhandler (fd, fh);}
 };
 
 class cygheap_fdget : public cygheap_fdmanip
diff --git a/winsup/cygwin/local_includes/dtable.h b/winsup/cygwin/local_includes/dtable.h
index 7803fae1b..89c776c2d 100644
--- a/winsup/cygwin/local_includes/dtable.h
+++ b/winsup/cygwin/local_includes/dtable.h
@@ -17,9 +17,30 @@ details. */
 class suffix_info;
 
 #define BFH_OPTS (PC_NULLEMPTY | PC_FULL | PC_POSIX)
+#define FDTAB_RESERVED ((fhandler_base *) -1)
 class dtable
 {
-  fhandler_base **fds;
+  class dtable_fds
+  {
+    fhandler_base **fds;
+  public:
+    inline void set_fhandler (int fd, fhandler_base *fh) {fds[fd] = fh;}
+    inline fhandler_base *operator [](int fd) const
+    {
+      fhandler_base *fh = fds[fd];
+      return (fh == FDTAB_RESERVED) ? NULL : fh;
+    }
+    operator fhandler_base **() {return fds;}
+    void operator = (fhandler_base **ptr) {fds = ptr;}
+    inline void reserve (int fd) { fds[fd] = FDTAB_RESERVED; }
+    inline void unreserve (int fd)
+    {
+      if (fds[fd] == FDTAB_RESERVED)
+	fds[fd] = NULL;
+    }
+    inline bool reserved (int fd) { return fds[fd] == FDTAB_RESERVED; }
+  };
+  dtable_fds fds;
   fhandler_base **archetypes;
   unsigned narchetypes;
   unsigned farchetype;
@@ -61,7 +82,11 @@ public:
   void init_std_file_from_handle (int fd, HANDLE handle);
   int dup3 (int oldfd, int newfd, int flags);
   void fixup_after_exec ();
-  inline fhandler_base *&operator [](int fd) const { return fds[fd]; }
+  inline void set_fhandler (int fd, fhandler_base *fh)
+  {
+    fds.set_fhandler (fd, fh);
+  }
+  inline fhandler_base *operator [](int fd) const { return fds[fd]; }
   bool select_read (int fd, select_stuff *);
   bool select_write (int fd, select_stuff *);
   bool select_except (int fd, select_stuff *);
@@ -76,6 +101,9 @@ public:
   void fixup_before_fork (DWORD win_proc_id);
   void lock () {lock_process::locker.acquire ();}
   void unlock () {lock_process::locker.release ();}
+  inline void reserve (int fd) { fds.reserve (fd); }
+  inline void unreserve (int fd) { fds.unreserve (fd); }
+  inline bool reserved (int fd) { return fds.reserved (fd); }
 };
 
 fhandler_base *build_fh_dev (const device&, const char * = NULL);
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 5465d6c09..5ca02c0a1 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -24,6 +24,7 @@ details. */
 #include <dirent.h>
 #include <ntsecapi.h>
 #include <iptypes.h>
+#include <assert.h>
 #include "ntdll.h"
 
 #include <cygwin/version.h>
@@ -146,7 +147,9 @@ dup_finish (int oldfd, int newfd, int flags)
   int res;
   if ((res = cygheap->fdtab.dup3 (oldfd, newfd, flags | O_EXCL)) == newfd)
     {
-      cygheap_fdget (newfd)->inc_refcnt ();
+      cygheap_fdget cfd (newfd);
+      assert ((fhandler_base *) cfd);
+      cfd->inc_refcnt ();
       cygheap->fdtab.unlock ();	/* dup3 exits with lock set on success */
     }
   return res;
@@ -1558,8 +1561,8 @@ open (const char *unix_path, int flags, ...)
 	  cygheap->fdtab.unlock ();
 	  __leave;		/* errno already set */
 	}
-      cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */
-      cygheap->fdtab.unlock();
+      cygheap->fdtab.reserve (fd);
+      cygheap->fdtab.unlock ();
 
       if (fh->dev () == FH_PROCESSFD && fh->pc.follow_fd_symlink ())
 	{
@@ -1588,7 +1591,7 @@ open (const char *unix_path, int flags, ...)
 		    FILE_OPEN_FOR_BACKUP_INTENT);
 
       cygheap->fdtab.lock ();
-      cygheap->fdtab[fd] = fh;
+      cygheap->fdtab.set_fhandler (fd, fh);
       fh->inc_refcnt ();
       cygheap->fdtab.unlock ();
 
@@ -1601,7 +1604,7 @@ open (const char *unix_path, int flags, ...)
     if (res < 0 && fd >= 0)
       {
 	cygheap->fdtab.lock ();
-	cygheap->fdtab[fd] = NULL; /* Mark as unused */
+	cygheap->fdtab.unreserve (fd);
 	cygheap->fdtab.unlock ();
       }
   if (res < 0 && fh)
-- 
2.51.0

