Return-Path: <SRS0=uXRy=U2=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id D576E3858C35
	for <cygwin-patches@cygwin.com>; Mon,  3 Feb 2025 19:38:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D576E3858C35
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D576E3858C35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1738611529; cv=none;
	b=qEklEE/wV861bTbMixAnrAgGlbp1fv4oaLdfPBcbPIyDFMQ33371/PgtImvyzpyu26QglzLpYfxfNvdjp5XA4+bDU2RFC0WlQIK3fSDRzpChDCZvwNLmpXzRWlHj5psZ/qekrmOlCbZh1B473t7WTYLDMjFWUqX7kfjVVs0B5rM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1738611529; c=relaxed/simple;
	bh=dGfT4krLWd6Sb/QGEhfpd0kSn8LDtnyQenZnGd2G5Sg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=hcgeru1FEW/498CUDv7KpMe2xqnPs518p/anEgk36E0yQv+LF/R7kjzAq0UA99YmVAyUcFrKFFnadcE00pf7413Bh+cYxg5QYMxxHaN/Wwhz58dXbthiWuQF3vGA2TCv124i3KTZgCjH6PWNLshQnIsDCM+lnyKnQt9D6qON6CA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D576E3858C35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Ay8zaiXy
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 09E7945CD3
	for <cygwin-patches@cygwin.com>; Mon,  3 Feb 2025 14:38:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=Ez68m
	zZqCMx1/J1YdPnPWHAyyP8=; b=Ay8zaiXyca24iFa/uzQuukuSePi5oqJ3Mfin/
	PLEfGTzIa0MdciIYLoIYcO5GYHjQEFkp0akMiuoNtljIKYu1CtqIhERZMNamIn0/
	Bgm8Y2ymmZOTW+vmS5lhkIOUqT7bIFjkVCQ1YodvWBvKtXGQk0Y5NAysJ+E4/0NA
	1N0OHI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 04CFC45CD0
	for <cygwin-patches@cygwin.com>; Mon,  3 Feb 2025 14:38:49 -0500 (EST)
Date: Mon, 3 Feb 2025 11:38:48 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: factor out code to resolve a symlink target.
Message-ID: <fd3e4a7d-6d5d-a938-79b5-65e2a5a8942f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This code was duplicated between the lnk symlink type and the native
symlink type.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/path.cc | 62 +++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 658f3f9cf7..d2aaed3143 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1756,6 +1756,31 @@ symlink (const char *oldpath, const char *newpath)
   return -1;
 }

+/* The symlink target is relative to the directory in which the symlink gets
+   created, not relative to the cwd.  Therefore we have to mangle the path
+   quite a bit before calling path_conv. */
+static bool
+resolve_symlink_target (const char *oldpath, const path_conv &win32_newpath,
+			path_conv &win32_oldpath)
+{
+  if (isabspath (oldpath))
+    {
+      win32_oldpath.check (oldpath, PC_SYM_NOFOLLOW, stat_suffixes);
+      return true;
+    }
+  else
+    {
+      tmp_pathbuf tp;
+      size_t len = strrchr (win32_newpath.get_posix (), '/')
+		    - win32_newpath.get_posix () + 1;
+      char *absoldpath = tp.t_get ();
+      stpcpy (stpncpy (absoldpath, win32_newpath.get_posix (), len),
+	      oldpath);
+      win32_oldpath.check (absoldpath, PC_SYM_NOFOLLOW, stat_suffixes);
+      return false;
+    }
+}
+
 static int
 symlink_nfs (const char *oldpath, path_conv &win32_newpath)
 {
@@ -1816,23 +1841,10 @@ symlink_native (const char *oldpath, path_conv &win32_newpath)
   UNICODE_STRING final_oldpath_buf;
   DWORD flags;

-  if (isabspath (oldpath))
-    {
-      win32_oldpath.check (oldpath, PC_SYM_NOFOLLOW, stat_suffixes);
-      final_oldpath = win32_oldpath.get_nt_native_path ();
-    }
+  if (resolve_symlink_target (oldpath, win32_newpath, win32_oldpath))
+    final_oldpath = win32_oldpath.get_nt_native_path ();
   else
     {
-      /* The symlink target is relative to the directory in which
-	 the symlink gets created, not relative to the cwd.  Therefore
-	 we have to mangle the path quite a bit before calling path_conv. */
-      ssize_t len = strrchr (win32_newpath.get_posix (), '/')
-		    - win32_newpath.get_posix () + 1;
-      char *absoldpath = tp.t_get ();
-      stpcpy (stpncpy (absoldpath, win32_newpath.get_posix (), len),
-	      oldpath);
-      win32_oldpath.check (absoldpath, PC_SYM_NOFOLLOW, stat_suffixes);
-
       /* Try hard to keep Windows symlink path relative. */

       /* 1. Find common path prefix.  Skip leading \\?\, but take pre-increment
@@ -2025,7 +2037,6 @@ int
 symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 {
   int res = -1;
-  size_t len;
   char *buf, *cp;
   tmp_pathbuf tp;
   winsym_t wsym_type;
@@ -2134,24 +2145,7 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 		 going to be. */
 	      IShellFolder *psl;

-	      /* The symlink target is relative to the directory in which the
-		 symlink gets created, not relative to the cwd.  Therefore we
-		 have to mangle the path quite a bit before calling path_conv.*/
-	      if (isabspath (oldpath))
-		win32_oldpath.check (oldpath,
-				     PC_SYM_NOFOLLOW,
-				     stat_suffixes);
-	      else
-		{
-		  len = strrchr (win32_newpath.get_posix (), '/')
-			- win32_newpath.get_posix () + 1;
-		  char *absoldpath = tp.t_get ();
-		  stpcpy (stpncpy (absoldpath, win32_newpath.get_posix (),
-				   len),
-			  oldpath);
-		  win32_oldpath.check (absoldpath, PC_SYM_NOFOLLOW,
-				       stat_suffixes);
-		}
+	      resolve_symlink_target (oldpath, win32_newpath, win32_oldpath);
 	      if (SUCCEEDED (SHGetDesktopFolder (&psl)))
 		{
 		  WCHAR wc_path[win32_oldpath.get_wide_win32_path_len () + 1];
-- 
2.47.1.windows.2

