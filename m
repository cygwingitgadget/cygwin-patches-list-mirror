Return-Path: <SRS0=kr8w=VE=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C54813858C42
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 01:41:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C54813858C42
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C54813858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739410889; cv=none;
	b=dGvQYDYaxXQcevoBigu6cqX8JShMlpK1OxVWXiob4ilIlzWqOgGYmA1wcsjl1mkYRpWjE8taD2E2tkt87HMmG8lggaSxD65Ss6O0URt7L54ayGDeyj74wTH0DyzTPevzMi/fvDSENSZH9CXHSDnIxtN2rG0GqmranL43QRxJQfs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739410889; c=relaxed/simple;
	bh=wUQpn879G4sLVFRNcH1IDnp597YSh64sfNjPVB3LXow=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lw83ZA3a2r62NljyO2yYLr/MRgpO6Gmx4vKde41Dy+hFyF92Zp0CjQfvVRdHP4fYKZthNdBLDJtlO0TmkpbUyIHEygYfYiOM8LkSIB5+EWk1oEBA3ovCwXY9A+t1ISWzHPpo0U5hWWntXUM/wo5ANndoJsC7c1mcC1N+eefHLew=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C54813858C42
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=UWgKIxa2
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9597F45C1D
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 20:41:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=6XOCX
	/uyV1KbQsTZor66GiIkjKQ=; b=UWgKIxa2pl0IWrPiCDvWzuRsHAev6IDEBEOhr
	59NamOfwqCdCKhj4GsuFiVY5FEABoIhPBm6FAt7i/pcA9wfonHQQX1yoqjpDBqw+
	aQNYc14FjQfQ+nz6p3IWt0okVhpdyxkGJG+A/2nzD9gHEQHPiOZEbQbfc1A184jF
	aCVhsQ=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 8F63C45BF6
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 20:41:27 -0500 (EST)
Date: Wed, 12 Feb 2025 17:41:27 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 3/3] Cygwin: always output cygdrive mntents.
Message-ID: <cff054ea-19d6-1317-9d77-396c66c76856@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,POISEN_SPAM_PILL_3,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, if there was an explicit mount entry for a drive letter
(say, C:), the output of the corresponding cygdrive mntent (like
/cygdrive/c) would be suppressed.  Once Windows directory mounts were
added to cygdrive mounts, the de-duplication code got more complicated.
Instead, always output the cygdrive mounts, under the cygdrive prefix.

Addresses: https://cygwin.com/pipermail/cygwin-patches/2025q1/013367.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/mount.cc | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index 722dc2aef5..b8d8d4a974 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1744,7 +1744,6 @@ mount_info::cygdrive_getmntent ()
   tmp_pathbuf tp;
   const wchar_t *wide_path;
   char *win32_path, *posix_path;
-  int err;

   if (!_my_tls.locals.drivemappings)
     _my_tls.locals.drivemappings = new dos_drive_mappings ();
@@ -1755,12 +1754,7 @@ mount_info::cygdrive_getmntent ()
       win32_path = tp.c_get ();
       sys_wcstombs (win32_path, NT_MAX_PATH, wide_path);
       posix_path = tp.c_get ();
-      if ((err = conv_to_posix_path (win32_path, posix_path, 0)))
-      {
-	set_errno (err);
-	return NULL;
-      }
-
+      cygdrive_posix_path (win32_path, posix_path, 0);
       return fillout_mntent (win32_path, posix_path, cygdrive_flags);
     }
   else
@@ -1778,34 +1772,8 @@ struct mntent *
 mount_info::getmntent (int x)
 {
   if (x < 0 || x >= nmounts)
-    {
-      struct mntent *ret;
-      /* de-duplicate against explicit mount entries */
-      while ((ret = cygdrive_getmntent ()))
-	{
-	  tmp_pathbuf tp;
-	  char *backslash_fsname = NULL;
-	  for (int i = 0; i < nmounts; ++i)
-	    {
-	      if (!strcmp (ret->mnt_dir, mount[i].posix_path))
-		{
-		  /* mount_item::native_path has backslashes, but
-		     mntent::mnt_fsname has forward slashes.  Lazily
-		     backslashify only if mnt_dir equals posix_path. */
-		  if (!backslash_fsname)
-		    {
-		      backslash_fsname = tp.c_get ();
-		      backslashify (ret->mnt_fsname, backslash_fsname, false);
-		    }
-		  if (strcasematch (backslash_fsname, mount[i].native_path))
-		    goto cygdrive_mntent_continue;
-		}
-	    }
-	  break;
-cygdrive_mntent_continue:;
-	}
-      return ret;
-    }
+    return cygdrive_getmntent ();
+
   return mount[native_sorted[x]].getmntent ();
 }

-- 
2.47.1.windows.2

