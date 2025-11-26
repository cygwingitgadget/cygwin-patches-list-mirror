Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B0CD83858D1E; Wed, 26 Nov 2025 11:55:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B0CD83858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764158127;
	bh=OFU8rngrx7+HM/P1XVkP8RAONSrNCxaT+V/dgp9bYYs=;
	h=From:To:Subject:Date:From;
	b=DJU6BHLfCq4shEpNldit0m1a75+qT5YSbue5d/R5qr7NgIc987X3nVqxqodd55217
	 qf9QLEWAgrATasFi6SjPuklotRMeQqmbbdm2uunwyr+JK+sax932I+BBl7P+Hr4/Sj
	 ecUuhwNOuyTZ5Fb1WucoFCuZxvFl24we6CP3d0zQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DC208A80F23; Wed, 26 Nov 2025 12:55:25 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: flock.cc: rename i_all to __i_all, improve inode_t comments
Date: Wed, 26 Nov 2025 12:55:25 +0100
Message-ID: <20251126115525.2963871-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Accessing i_all should always be performed via the i_all_lf pointer,
never directly.  Add leading underscores to support this notion.

Improve inode_t comments a bit so it's hopefully clearer what all the
members are doing.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/flock.cc | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 5c60f628b397..b7e3bc7d5abe 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -276,7 +276,8 @@ class lockf_t
     void del_lock_obj (HANDLE fhdl, bool signal = false);
 };
 
-/* Number of lockf_t structs which fit in the temporary buffer. */
+/* Max. number of lockf_t structs in the __i_all buffer so that an inode_t
+   fits into a 64K cygheap chunk. */
 #define MAX_LOCKF_CNT	((intptr_t)((NT_MAX_PATH * sizeof (WCHAR)) \
 				    / sizeof (lockf_t)) - 1)
 
@@ -287,19 +288,23 @@ class inode_t
 
   public:
     LIST_ENTRY (inode_t) i_next;
-    lockf_t		*i_lockf;  /* List of locks of this process. */
-				   /* list of all locks for this file. */
-    lockf_t		*i_all_lf;
+    lockf_t		*i_lockf;  /* List of locks held by this process. */
+    lockf_t		*i_all_lf; /* List of all locks on this file.  Always
+				      points to __i_all below.  The indirection
+				      is required by list handling. */
 
     dev_t		 i_dev;    /* Device ID */
     ino_t		 i_ino;    /* inode number */
 
   private:
-    HANDLE		 i_dir;
-    HANDLE		 i_mtx;
+    HANDLE		 i_dir;    /* Handle to directory in the NT namespace
+				      holding symlinks representing locks on
+				      this file. */
+    HANDLE		 i_mtx;	   /* Mutex handle controlling access to
+				      locks on this file. */
     uint32_t		 i_cnt;    /* # of threads referencing this instance. */
-    uint32_t		 i_lock_cnt; /* # of locks for this file */
-    lockf_t		 i_all[MAX_LOCKF_CNT];
+    uint32_t		 i_lock_cnt; /* # of locks on this file */
+    lockf_t		 __i_all[MAX_LOCKF_CNT];
 
   public:
     inode_t (dev_t dev, ino_t ino);
@@ -508,7 +513,7 @@ inode_t::get (dev_t dev, ino_t ino, bool create_if_missing, bool lock)
 }
 
 inode_t::inode_t (dev_t dev, ino_t ino)
-: i_lockf (NULL), i_all_lf (i_all), i_dev (dev), i_ino (ino), i_cnt (0L),
+: i_lockf (NULL), i_all_lf (__i_all), i_dev (dev), i_ino (ino), i_cnt (0L),
   i_lock_cnt (0)
 {
   HANDLE parent_dir;
-- 
2.51.1

