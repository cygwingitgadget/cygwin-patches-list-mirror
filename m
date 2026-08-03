Return-Path: <SRS0=LDpO=F4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 8748E4BA2E1F
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 10:55:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8748E4BA2E1F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8748E4BA2E1F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785754539; cv=none;
	b=p3PDoXxWQ80sKwfVt5cebAlnRTVNkoaxUkCOdet1YVvuarpxCquGQIaxCF8IFlCm1/nko71X5fOMkAQGyTllqsWNWqypC6W9SI+Skwn2kvnDeKhdNsd5KhqvygqzI48AlgORBmp9utSqRfyHTx+qb/AB6mWOddjJgtKMDIL4ocA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785754539; c=relaxed/simple;
	bh=t5Q70IEtPs5NWPy98BIeggAkZNMNoBUerYOHrkaKU68=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=PjGV4UvxI566+lAv3c/vPKC9C6sr2vO8PqMpNvXEc+k9k+6PnUNuGV5IdDX0oFBOlSYvH05s1pL1eVRBwqqBUkgdOA1blXEidEr8IRphxLgB4C/smfhdGqRXak95iK/AWduqNCosl5ww88b47p4ARx1c8irdMJhwZZGfEdCaOQs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kK5T2rVv
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8748E4BA2E1F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kK5T2rVv
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260803105536897.ZTVU.117312.HP-Z230@nifty.com>;
          Mon, 3 Aug 2026 19:55:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: open: Do not set tentative fhandler to fdtab (B)
Date: Mon,  3 Aug 2026 19:55:10 +0900
Message-ID: <20260803105520.1232-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803105520.1232-1-takashi.yano@nifty.ne.jp>
References: <20260803105520.1232-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1785754536;
 bh=/ewErLB8Q1wt8ZYN90REl/oJVRlOdpKQcd7uBZ7o9Xo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kK5T2rVvBFzuXc6j9F2FPIHO0uIrRBhMgNAw3cVNyEqNOPzdp+Z9iJnXD5TlmyhxZeVYmbTI
 vo2bIZMw129BCcHJJrh36bSHueNYgh6FKkMe8twguk+lKpoFVoKmoxieQ0/ArbNPN/sGfYnrVg
 q19Wffe7H3n0kYRWdckKGyvWLxVAuTHtpSghjxDPEu0PQo/r+3uBW1f70QqtECCknoPuNhBuvC
 mzPoEqknUK0v8br0iSBtYJ+RFy28KVCb/cLx9zFRrlIT2rzF7qos5H050lQpCPfpgbBtk1hXfb
 ydlBCZeBodS7p7+8c4XoNV6dzsSVBB0opa7TBa1JA9i/RFGg==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by:
---
 winsup/cygwin/dtable.cc                | 13 ++++++++-----
 winsup/cygwin/local_includes/cygheap.h |  6 +++---
 winsup/cygwin/local_includes/dtable.h  | 15 ++++++++++++---
 winsup/cygwin/syscalls.cc              |  8 ++++----
 4 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index e4d1cdf8f..fffc9bad5 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -247,9 +247,12 @@ out:
 void
 dtable::release (int fd)
 {
-  if (fds[fd]->need_fixup_before ())
-    dec_need_fixup_before ();
-  fds[fd]->dec_refcnt ();
+  if (fds[fd] && fds[fd] != FDTAB_RESERVED)
+    {
+      if (fds[fd]->need_fixup_before ())
+	dec_need_fixup_before ();
+      fds[fd]->dec_refcnt ();
+    }
   fds[fd] = NULL;
   if (fd <= 2)
     set_std_handle (fd);
@@ -267,7 +270,7 @@ cygwin_attach_handle_to_fd (char *name, int fd, HANDLE handle, mode_t bin,
     fd = -1;
   else
     {
-      cygheap->fdtab[fd] = fh;
+      cygheap->fdtab.set_fhandler (fd, fh);
       cygheap->fdtab[fd]->inc_refcnt ();
       fh->init (handle, myaccess, bin ?: fh->pc_binmode ());
     }
@@ -425,7 +428,7 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
       if (!fh->open_setup (openflags))
 	api_fatal ("open_setup failed, %E");
       fh->usecount = 0;
-      cygheap->fdtab[fd] = fh;
+      cygheap->fdtab.set_fhandler (fd, fh);
       cygheap->fdtab[fd]->inc_refcnt ();
       set_std_handle (fd);
       paranoid_printf ("fd %d, handle %p", fd, handle);
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
index 7803fae1b..910a7e849 100644
--- a/winsup/cygwin/local_includes/dtable.h
+++ b/winsup/cygwin/local_includes/dtable.h
@@ -17,6 +17,7 @@ details. */
 class suffix_info;
 
 #define BFH_OPTS (PC_NULLEMPTY | PC_FULL | PC_POSIX)
+#define FDTAB_RESERVED ((fhandler_base *) -1)
 class dtable
 {
   fhandler_base **fds;
@@ -26,10 +27,12 @@ class dtable
   static const int initial_archetype_size = 8;
   size_t first_fd_for_open;
   int cnt_need_fixup_before;
+  fhandler_base * const null_fds;
 public:
   size_t size;
 
-  dtable () : archetypes (NULL), narchetypes (0), farchetype (0), first_fd_for_open(3), cnt_need_fixup_before(0) {}
+  dtable () : archetypes (NULL), narchetypes (0), farchetype (0),
+  first_fd_for_open(3), cnt_need_fixup_before(0), null_fds (NULL) {}
   void init () {first_fd_for_open = 3;}
 
   void dec_need_fixup_before ()
@@ -51,7 +54,8 @@ public:
   inline int not_open (int fd)
   {
     lock ();
-    int res = fd < 0 || fd >= (int) size || fds[fd] == NULL;
+    int res = fd < 0 || fd >= (int) size
+      || fds[fd] == NULL || fds[fd] == FDTAB_RESERVED;
     unlock ();
     return res;
   }
@@ -61,7 +65,11 @@ public:
   void init_std_file_from_handle (int fd, HANDLE handle);
   int dup3 (int oldfd, int newfd, int flags);
   void fixup_after_exec ();
-  inline fhandler_base *&operator [](int fd) const { return fds[fd]; }
+  inline void set_fhandler (int fd, fhandler_base *fh) {fds[fd] = fh;}
+  inline fhandler_base *operator [](int fd) const
+  {
+    return (fds[fd] == FDTAB_RESERVED) ? null_fds : fds[fd];
+  }
   bool select_read (int fd, select_stuff *);
   bool select_write (int fd, select_stuff *);
   bool select_except (int fd, select_stuff *);
@@ -76,6 +84,7 @@ public:
   void fixup_before_fork (DWORD win_proc_id);
   void lock () {lock_process::locker.acquire ();}
   void unlock () {lock_process::locker.release ();}
+  void reserve (int fd) { fds[fd] = FDTAB_RESERVED; }
 };
 
 fhandler_base *build_fh_dev (const device&, const char * = NULL);
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 5465d6c09..af7471a7f 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1558,8 +1558,8 @@ open (const char *unix_path, int flags, ...)
 	  cygheap->fdtab.unlock ();
 	  __leave;		/* errno already set */
 	}
-      cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */
-      cygheap->fdtab.unlock();
+      cygheap->fdtab.reserve (fd);
+      cygheap->fdtab.unlock ();
 
       if (fh->dev () == FH_PROCESSFD && fh->pc.follow_fd_symlink ())
 	{
@@ -1588,7 +1588,7 @@ open (const char *unix_path, int flags, ...)
 		    FILE_OPEN_FOR_BACKUP_INTENT);
 
       cygheap->fdtab.lock ();
-      cygheap->fdtab[fd] = fh;
+      cygheap->fdtab.set_fhandler (fd, fh);
       fh->inc_refcnt ();
       cygheap->fdtab.unlock ();
 
@@ -1601,7 +1601,7 @@ open (const char *unix_path, int flags, ...)
     if (res < 0 && fd >= 0)
       {
 	cygheap->fdtab.lock ();
-	cygheap->fdtab[fd] = NULL; /* Mark as unused */
+	cygheap->fdtab.release (fd);
 	cygheap->fdtab.unlock ();
       }
   if (res < 0 && fh)
-- 
2.51.0

