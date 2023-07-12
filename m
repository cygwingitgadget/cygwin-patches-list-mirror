Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 709D4385840B; Wed, 12 Jul 2023 12:08:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 709D4385840B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689163686;
	bh=p64gIy2J/pENFPtRXUcdPzTOTi+0+Qfexjgg7pplI1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSLQvx+HUJ949Y57Rs7ckb+DsOYBsYvn/HVxjRvx+cqvTgv59saD8TOsuWb+o8WWG
	 qr4MR5aHrntC/NpA7WutwA5QDWq2LDy9kDTHGhjNsUw5wfXC4aJ2H5A8mVL+Nh6Qj/
	 wq+JNiNQtWaJGG+DyHqrnhLjmI7BMwbkSQHT+MoM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A289EA80F7C; Wed, 12 Jul 2023 14:08:04 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/5] Cygwin: use new _AT_NULL_PATHNAME_ALLOWED flag
Date: Wed, 12 Jul 2023 14:08:02 +0200
Message-Id: <20230712120804.2992142-4-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Convert gen_full_path_at to take flag values from the caller, rather
than just a bool indicating that empty paths are allowed.  This is in
preparation of a better AT_EMPTY_PATH handling in a followup patch.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/syscalls.cc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index f0ef8955cee8..cf8c4e0cfb9f 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4414,11 +4414,10 @@ pclose (FILE *fp)
 
 static int
 gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
-		  bool null_pathname_allowed = false)
+		  int flags = 0)
 {
-  /* Set null_pathname_allowed to true to allow GLIBC compatible behaviour
-     for NULL pathname.  Only used by futimesat. */
-  if (!pathname && !null_pathname_allowed)
+  /* futimesat allows a NULL pathname. */
+  if (!pathname && !(flags & _AT_NULL_PATHNAME_ALLOWED))
     {
       set_errno (EFAULT);
       return -1;
@@ -4676,7 +4675,7 @@ futimesat (int dirfd, const char *pathname, const struct timeval times[2])
   __try
     {
       char *path = tp.c_get ();
-      if (gen_full_path_at (path, dirfd, pathname, true))
+      if (gen_full_path_at (path, dirfd, pathname, _AT_NULL_PATHNAME_ALLOWED))
 	__leave;
       return utimes (path, times);
     }
-- 
2.40.1

