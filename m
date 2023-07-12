Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7C12A385840D; Wed, 12 Jul 2023 12:08:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C12A385840D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689163686;
	bh=WlFCnSy6+bY8C1+Yce65LJcUrLWLEiOA585CHGgf7UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dw1v3UGZsC7OW3733TY1nWfCUEUHE5VlAhyFJMuTe7hIgPkpytIek3uD2LwB9Ald4
	 TF1BSW4d/N22rnvs0zkdwOk3wdv3vQXsJNqKUynHTI3fQkUD1ZBVkB5Rfajf4eK6vq
	 Ddq9XwFO2sz+FfzF2lCCIYNvRxBKqcb7l83JfqeI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A93EBA80F80; Wed, 12 Jul 2023 14:08:04 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/5] Cygwin: Fix and streamline AT_EMPTY_PATH handling
Date: Wed, 12 Jul 2023 14:08:03 +0200
Message-Id: <20230712120804.2992142-5-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

The GLIBC extension AT_EMPTY_PATH allows the functions fchownat
and fstatat to operate on dirfd alone, if the given pathname is an
empty string.  This also allows to operate on any file type, not
only directories.

Commit fa84aa4dd2fb4 broke this.  It only allows dirfd to be a
directory in calls to these two functions.

Fix that by handling AT_EMPTY_PATH right in gen_full_path_at.
A valid dirfd and an empty pathname is now a valid combination
and, noticably, this returns a valid path in path_ret.  That
in turn allows to remove the additional path generation code
from the callers.

Fixes: fa84aa4dd2fb ("Cygwin: fix errno values set by readlinkat")
Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/syscalls.cc | 47 +++++++++------------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index cf8c4e0cfb9f..c369c7713b19 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4439,7 +4439,7 @@ gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
 	  cygheap_fdget cfd (dirfd);
 	  if (cfd < 0)
 	    return -1;
-	  if (!cfd->pc.isdir ())
+	  if (!cfd->pc.isdir () && !(flags & AT_EMPTY_PATH))
 	    {
 	      set_errno (ENOTDIR);
 	      return -1;
@@ -4450,6 +4450,8 @@ gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
 	{
 	  if (!*pathname)
 	    {
+	      if (flags & AT_EMPTY_PATH)
+		return 0;
 	      set_errno (ENOENT);
 	      return -1;
 	    }
@@ -4571,29 +4573,14 @@ fchownat (int dirfd, const char *pathname, uid_t uid, gid_t gid, int flags)
 	  __leave;
 	}
       char *path = tp.c_get ();
-      int res = gen_full_path_at (path, dirfd, pathname);
+      int res = gen_full_path_at (path, dirfd, pathname, flags);
       if (res)
+	__leave;
+      if (!*pathname) /* Implies AT_EMPTY_PATH */
 	{
-	  if (!(errno == ENOENT && (flags & AT_EMPTY_PATH)))
-	    __leave;
-	  /* pathname is an empty string.  Operate on dirfd. */
-	  if (dirfd == AT_FDCWD)
-	    {
-	      cwdstuff::acquire_read ();
-	      strcpy (path, cygheap->cwd.get_posix ());
-	      cwdstuff::release_read ();
-	    }
-	  else
-	    {
-	      cygheap_fdget cfd (dirfd);
-	      if (cfd < 0)
-		__leave;
-	      strcpy (path, cfd->get_name ());
-	      /* If dirfd refers to a symlink (which was necessarily
-		 opened with O_PATH | O_NOFOLLOW), we must operate
-		 directly on that symlink.. */
-	      flags = AT_SYMLINK_NOFOLLOW;
-	    }
+	  /* If dirfd refers to a symlink (which was necessarily opened with
+	     O_PATH | O_NOFOLLOW), we must operate directly on that symlink. */
+	  flags = AT_SYMLINK_NOFOLLOW;
 	}
       return chown_worker (path, (flags & AT_SYMLINK_NOFOLLOW)
 				 ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW, uid, gid);
@@ -4616,21 +4603,9 @@ fstatat (int dirfd, const char *__restrict pathname, struct stat *__restrict st,
 	  __leave;
 	}
       char *path = tp.c_get ();
-      int res = gen_full_path_at (path, dirfd, pathname);
+      int res = gen_full_path_at (path, dirfd, pathname, flags);
       if (res)
-	{
-	  if (!(errno == ENOENT && (flags & AT_EMPTY_PATH)))
-	    __leave;
-	  /* pathname is an empty string.  Operate on dirfd. */
-	  if (dirfd == AT_FDCWD)
-	    {
-	      cwdstuff::acquire_read ();
-	      strcpy (path, cygheap->cwd.get_posix ());
-	      cwdstuff::release_read ();
-	    }
-	  else
-	    return fstat (dirfd, st);
-	}
+	  __leave;
       path_conv pc (path, ((flags & AT_SYMLINK_NOFOLLOW)
 			   ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW)
 			  | PC_POSIX | PC_KEEP_HANDLE, stat_suffixes);
-- 
2.40.1

