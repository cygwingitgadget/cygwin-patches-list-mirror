Return-Path: <SRS0=M9OL=DZ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id C97494BAE7FC
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 05:43:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C97494BAE7FC
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C97494BAE7FC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779946990; cv=none;
	b=Ze2dDlcssko10T1XfOSZkP4kSpcNrq97Pi8vaePm5xG+not3IHFyBptEhmv0nCBpjClKDIEeZgznMFfDBVFql9jlcPxhvU5LY6TU7IvPjGP+bKyxAShKzYGEkE/I4RmoT0/gfx7iCn0bXPf4k7NRwdKD+bo+Hni6aXStl6+URgc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779946990; c=relaxed/simple;
	bh=wHyWySNfnQOvuY5WKLKpoxVx4N6wD6d+2IWGMeTCcf4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ex4KJGd8Rrth+iOvqhmG5pv8E39Nl4yTMWrJyPSOm2smF4F4wMlC1HX9m2gaLYUxUe4zWULGyrGiuLue6uU3wI2Uln7Ovv5LVWVHGNCRkFvM70+/9JEhEQbUDKFtxsOHLyCT5HMNRvYQGP96Yny3NrWZP2ga047R0GEGRil0Suw=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C97494BAE7FC
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 64S5wWwk026117;
	Wed, 27 May 2026 22:58:32 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpdwoLdMr; Wed May 27 22:58:26 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2] Cygwin: Ensure unused fd available for open()
Date: Wed, 27 May 2026 22:42:44 -0700
Message-ID: <20260528054307.16582-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The existing logic for open() assumes an fd is always available in
the fdtable for a created file.  This leads to a situation where, if
there is no fd available due to the OPEN_MAX limit being hit, the
file is created but cannot be referenced by a Cygwin fd.

Move the fd reservation code to an earlier location within open().

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2026-May/259664.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: e859706578ba (* autoload.cc (NtCreateFile): Add.)

---
 winsup/cygwin/syscalls.cc | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 7a8e5d4fd..2bea79768 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1547,6 +1547,13 @@ open (const char *unix_path, int flags, ...)
 	  fh = fh_file;
 	}
 
+      /* Reserve an fdtable entry here, before calling open_with_arch() below.
+         Otherwise there's a tiny chance of hitting OPEN_MAX further on which
+         could create a new file without any way for Cygwin to refer to it. */
+      cygheap_fdnew fd;
+      if (fd < 0)
+        __leave;		/* errno already set */
+
       if (fh->dev () == FH_PROCESSFD && fh->pc.follow_fd_symlink ())
 	{
 	  /* Reopen file by descriptor */
@@ -1573,14 +1580,6 @@ open (const char *unix_path, int flags, ...)
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

