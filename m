Return-Path: <SRS0=BFuG=DY=lesderid.net=les@sourceware.org>
Received: from anna.lesderid.net (anna.lesderid.net [178.62.57.241])
	by sourceware.org (Postfix) with ESMTP id BCC403858412
	for <cygwin-patches@cygwin.com>; Mon,  7 Aug 2023 10:13:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BCC403858412
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=lesderid.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=lesderid.net
DKIM-Signature: a=rsa-sha256; bh=+cV3y9xQdlAc08wwNgb6BTRvN3qbNHik54u9bV6Mmd0=;
 c=relaxed/relaxed; d=lesderid.net;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@lesderid.net; s=default; t=1691403213; v=1; x=1691835213;
 b=dXqTnysmbTgpgQ1gxaENWkaX3wvj3DQJcsden6/cmBG51kMrFBFXWM7jJGBinq7AAgNC3gat
 99YK9yhRHKRANPXBFXE933xyEracixqie+HttBEqvqJfeWzDf3SNWsFWQSJQazUbEKQNrv16SoH
 w6AAv/kSR5lQBb+Hz/3vZQb0DXx6dwSClvUE/D5WmFj+1R6zcecix5tePCEgN4gPjZvZPCmtqt7
 QMUYyiD8uYoFZDkbFm7XAGaj/lMUWs27obZxIZDdBxRap9LiAmW00fWZqeS2gN151/2Rha7ycdC
 RNCThWIi4k+VxYOWbNDT9TjzfQMvpB8jNe0DI+KYmSl1A==
Received: by anna.lesderid.net (envelope-sender <les@lesderid.net>) with
 ESMTPS id 9c182c16; Mon, 07 Aug 2023 12:13:33 +0200
From: Les De Ridder <les@lesderid.net>
To: cygwin-patches@cygwin.com
Cc: Les De Ridder <les@lesderid.net>
Subject: [PATCH 1/2] Detect RAM disks as a separate filesystem type
Date: Mon,  7 Aug 2023 03:13:14 -0700
Message-ID: <9d1cbf57a0ff67bb9d7af619e24a86005cad1cbf.1690932049.git.les@lesderid.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690932049.git.les@lesderid.net>
References: <cover.1690932049.git.les@lesderid.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Native RAM disks, e.g. as are used in WinPE environments, have other
characteristics than regular filesystems such as NTFS. For instance,
re-opening files with NtOpenFile is buggy.

This commit checks whether a volume is a RAM disk through the NT object
the drive letter link refers to. This seems to be the only reliable
method of checking whether a volume is a native RAM disk.

Signed-off-by: Les De Ridder <les@lesderid.net>
---
 winsup/cygwin/local_includes/mount.h |  2 ++
 winsup/cygwin/local_includes/path.h  |  1 +
 winsup/cygwin/mount.cc               | 12 ++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/winsup/cygwin/local_includes/mount.h b/winsup/cygwin/local_includes/mount.h
index 5bb84b976..e8a71a994 100644
--- a/winsup/cygwin/local_includes/mount.h
+++ b/winsup/cygwin/local_includes/mount.h
@@ -47,6 +47,7 @@ enum fs_info_type
   ncfsd,
   afs,
   prlfs,
+  ramdisk,
   /* Always last. */
   max_fs_type
 };
@@ -117,6 +118,7 @@ class fs_info
   IMPLEMENT_FS_FLAG (ncfsd)
   IMPLEMENT_FS_FLAG (afs)
   IMPLEMENT_FS_FLAG (prlfs)
+  IMPLEMENT_FS_FLAG (ramdisk)
   fs_info_type what_fs () const { return status.fs_type; }
   bool got_fs () const { return status.fs_type != none; }
 
diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
index 74f831e53..2e34f0e18 100644
--- a/winsup/cygwin/local_includes/path.h
+++ b/winsup/cygwin/local_includes/path.h
@@ -387,6 +387,7 @@ class path_conv
   bool fs_is_ncfsd () const {return fs.is_ncfsd ();}
   bool fs_is_afs () const {return fs.is_afs ();}
   bool fs_is_prlfs () const {return fs.is_prlfs ();}
+  bool fs_is_ramdisk () const {return fs.is_ramdisk ();}
   fs_info_type fs_type () const {return fs.what_fs ();}
   ULONG fs_serial_number () const {return fs.serial_number ();}
   inline const char *set_path (const char *p)
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index 36ab042a7..1950dadb0 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -292,6 +292,17 @@ fs_info::update (PUNICODE_STRING upath, HANDLE in_vol)
   if (!NT_SUCCESS (status))
     ffdi.DeviceType = ffdi.Characteristics = 0;
 
+  if (upath->Buffer[5] == L':' && upath->Buffer[6] == L'\\')
+   {
+     WCHAR dos[3] = {upath->Buffer[4], upath->Buffer[5], L'\0'};
+     WCHAR dev[MAX_PATH];
+     if (QueryDosDeviceW (dos, dev, MAX_PATH))
+       {
+          is_ramdisk (wcsncmp (dev, L"\\Device\\Ramdisk", 15));
+          has_buggy_reopen (is_ramdisk ());
+       }
+   }
+
   if ((ffdi.Characteristics & FILE_REMOTE_DEVICE)
       || (!ffdi.DeviceType
 	  && RtlEqualUnicodePathPrefix (attr.ObjectName, &ro_u_uncp, TRUE)))
@@ -1612,6 +1623,7 @@ fs_names_t fs_names[] = {
     { "ncfsd", false },
     { "afs", false },
     { "prlfs", false },
+    { "ramdisk", false },
     { NULL, false }
 };
 
-- 
2.41.0

