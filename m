Return-Path: <SRS0=Whra=UY=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 2AD4D3858D39
	for <cygwin-patches@cygwin.com>; Sat,  1 Feb 2025 18:22:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2AD4D3858D39
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2AD4D3858D39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1738434159; cv=none;
	b=AuE+doOF1K5gYSVV70JoH06p+Lhl5bdtV5qIwAAFlnfg/DrlpfB/hqUXg1bjrr7dWG4cJ6foenI1YST+C78G+cw5iqJ4D6P0vnB9npvF2KOPH8C7UhHYOxYpuhSPS5wl9XEOgclFjeqa4PY1lzWrnoPjf9S11I+vV0lSuHN0LZ0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1738434159; c=relaxed/simple;
	bh=tLUzeMsZ8v2IkFh0XYFVmf1QHND1z4LltOJql5qUPWo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=m8UuAAl27WU/gN+6weRJQ3KDRXTkGKDpp3iL4v/aGzRsnLiwcL2xH2TGPa+8DiEvBcjK/shQQqgVaZXuyRvNtUX4VBrVnv6ElieYDGQL4IAAUDFjRPMAw1vih06QaqFMgB5vVNHOIq9Mg7Y2KTPHHDj774LYBKoNTtkap1wm24g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2AD4D3858D39
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=CnzuiFTL
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3EC6445CDC
	for <cygwin-patches@cygwin.com>; Sat,  1 Feb 2025 13:22:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=OQc1o
	EPjVxmRHcQm4mNa2/R2JSs=; b=CnzuiFTLm+HKP8Q7Z8txk0DH+Aa/QU1JJbzE4
	c0xLWtVny8IiAw2kMc4c4SUFm3Y2ND5BGL2mN3EYxNkQ6ufO3fkaTEtaxCEtJ+1V
	apiDc7yplOo+RTF/xQWHUiI+he6yKf69wm6ORsIsp6aU2fl3N+yZctA0GoTg4Htv
	Ac52DU=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id F007245CDA
	for <cygwin-patches@cygwin.com>; Sat,  1 Feb 2025 13:22:37 -0500 (EST)
Date: Sat, 1 Feb 2025 10:22:36 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: factor out code to resolve a symlink target.
Message-ID: <00a51487-ed74-8ad6-39aa-bd6963af54c2@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This code was duplicated between the lnk symlink type and the native
symlink type.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---

I have been working on cleaning up msys2's "deepcopy" symlink mode code
and noticed it was doing the same thing in a different way.  I copy-pasted
the code from the lnk path, then factored it out into a function when I
noticed the native path doing the same thing.  Then I realized, "that's
stupid, I'm creating a bigger diff from upstream for a code cleanup".
So I reverted it there and figured I'd send it here first, and adopt
using it in the deepcopy code if/when it's applied here and in a released
version.

 winsup/cygwin/path.cc | 52 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 658f3f9cf7..69675b2e23 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1756,6 +1756,28 @@ symlink (const char *oldpath, const char *newpath)
   return -1;
 }

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
@@ -1816,23 +1838,12 @@ symlink_native (const char *oldpath, path_conv &win32_newpath)
   UNICODE_STRING final_oldpath_buf;
   DWORD flags;

-  if (isabspath (oldpath))
+  if (resolve_symlink_target (oldpath, win32_newpath, win32_oldpath))
     {
-      win32_oldpath.check (oldpath, PC_SYM_NOFOLLOW, stat_suffixes);
       final_oldpath = win32_oldpath.get_nt_native_path ();
     }
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
@@ -2025,7 +2036,6 @@ int
 symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 {
   int res = -1;
-  size_t len;
   char *buf, *cp;
   tmp_pathbuf tp;
   winsym_t wsym_type;
@@ -2137,21 +2147,7 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 	      /* The symlink target is relative to the directory in which the
 		 symlink gets created, not relative to the cwd.  Therefore we
 		 have to mangle the path quite a bit before calling path_conv.*/
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

