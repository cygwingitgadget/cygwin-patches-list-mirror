Return-Path: <SRS0=Z4hW=VJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 5E2813858D20
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 18:38:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5E2813858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5E2813858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739903932; cv=none;
	b=mBQF5qRqkATzHO/CYJbEx3s2QCZe7MlQZQ0znOPxNSHXB9uq1BM9PGKoEyTXJVaI2ipbeg5xEYeaYatIoriRGDocWBOlNl3E9JMGIyNs22cfH8ZDgt79jYBHYhgb2YYcUio1pdvDRljeFDvUCeXObji5xbMEgkyc6l/7vzAYoWM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739903932; c=relaxed/simple;
	bh=HfMMppOuVmxlZ4wks4rakyIdwG83wVCnDgxcGnO2q+A=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=koNb6og4qYc59CnrFBynqYZT5iq+1XacwC7Ascf05kk2SmpXw6fFmcZZ385nOo2EiVMA7B5FgbwuZfY2bNQnKTAioTqXU+0GI1haInhzxcMs3kr7TC3YlcDd1tNT4XK/+UttYenYSrAO7GxY6JHAHYz4BojO6FIuR3z6AfNroDQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5E2813858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ycjXzpZy
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 07D6C45C30
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 13:38:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=5uSl1
	WNODyS6yQTizKvlAwdj7vM=; b=ycjXzpZyLes6xyHHtIEPrGsL7GKp8ty9swHhe
	8bSr0nEUBHwFHELnNyZyIlLoLZSA2IlG/iOe0a/akfKb2drRdiZVd1daxJywbOSb
	VTyeFTlmID5+vp5uABEQz0dtqbpexBC1VtD9yXJF2EtnqXZazp1Y9xVDUEUUM4o4
	NHK4+Q=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CFB8845BF6
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 13:38:51 -0500 (EST)
Date: Tue, 18 Feb 2025 10:38:51 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: skip floppy drives in cygdrive_getmntent.
Message-ID: <df854454-c96e-8fe0-ead7-c70c566ec1d3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This was previously done, but was lost when the function was updated to
list all Windows mount points, not just drive letters.

Fixes: 04a5b072940cc ("Cygwin: expose all windows volume mount points.")
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---

I finally got a chance to test on a machine that still has a physical
floppy drive, and running "mount" resulted in the annoying
floppy-drive-spinup sound.  I changed next_dos_mount () to return both the
device and mount point, and used the existing logic from get_disk_type
without the extra call to QueryDosDeviceW.  This same function could be
used by https://cygwin.com/pipermail/cygwin-patches/2023q3/012436.html if
that ever comes up again.

 winsup/cygwin/local_includes/mount.h |  8 ++++++-
 winsup/cygwin/mount.cc               | 31 ++++++++++++++++++----------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/local_includes/mount.h b/winsup/cygwin/local_includes/mount.h
index 3049de8ba3..2ae67a7035 100644
--- a/winsup/cygwin/local_includes/mount.h
+++ b/winsup/cygwin/local_includes/mount.h
@@ -23,6 +23,7 @@ enum disk_type
   DT_SHARE_NFS
 };

+disk_type get_device_type (LPCWSTR);
 disk_type get_disk_type (LPCWSTR);

 /* Don't add new fs types without adding them to fs_names in mount.cc!
@@ -239,6 +240,11 @@ public:
   dos_drive_mappings ();
   ~dos_drive_mappings ();
   wchar_t *fixup_if_match (wchar_t *path);
-  const wchar_t *next_dos_mount ();
+  struct dos_device_mountpoint
+  {
+    const wchar_t *device;
+    const wchar_t *mountpoint;
+  };
+  dos_device_mountpoint next_dos_mount ();
 };
 #endif
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index b8d8d4a974..a3d9e5bd0f 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1742,17 +1742,19 @@ struct mntent *
 mount_info::cygdrive_getmntent ()
 {
   tmp_pathbuf tp;
-  const wchar_t *wide_path;
+  dos_drive_mappings::dos_device_mountpoint dos_mount;
   char *win32_path, *posix_path;

   if (!_my_tls.locals.drivemappings)
     _my_tls.locals.drivemappings = new dos_drive_mappings ();

-  wide_path = _my_tls.locals.drivemappings->next_dos_mount ();
-  if (wide_path)
+  dos_mount = _my_tls.locals.drivemappings->next_dos_mount ();
+  while (dos_mount.device && get_device_type (dos_mount.device) == DT_FLOPPY)
+    dos_mount = _my_tls.locals.drivemappings->next_dos_mount ();
+  if (dos_mount.mountpoint)
     {
       win32_path = tp.c_get ();
-      sys_wcstombs (win32_path, NT_MAX_PATH, wide_path);
+      sys_wcstombs (win32_path, NT_MAX_PATH, dos_mount.mountpoint);
       posix_path = tp.c_get ();
       cygdrive_posix_path (win32_path, posix_path, 0);
       return fillout_mntent (win32_path, posix_path, cygdrive_flags);
@@ -1899,11 +1901,9 @@ cygwin_umount (const char *path, unsigned flags)
 #define is_dev(d,s)	wcsncmp((d),(s),sizeof(s) - 1)

 disk_type
-get_disk_type (LPCWSTR dos)
+get_device_type (LPCWSTR dev)
 {
-  WCHAR dev[MAX_PATH], *d = dev;
-  if (!QueryDosDeviceW (dos, dev, MAX_PATH))
-    return DT_NODISK;
+  const WCHAR *d = dev;
   if (is_dev (dev, L"\\Device\\"))
     {
       d += 8;
@@ -1934,6 +1934,15 @@ get_disk_type (LPCWSTR dos)
   return DT_NODISK;
 }

+disk_type
+get_disk_type (LPCWSTR dos)
+{
+  WCHAR dev[MAX_PATH];
+  if (!QueryDosDeviceW (dos, dev, MAX_PATH))
+    return DT_NODISK;
+  return get_device_type (dev);
+}
+
 extern "C" FILE *
 setmntent (const char *filep, const char *)
 {
@@ -2106,7 +2115,7 @@ dos_drive_mappings::fixup_if_match (wchar_t *path)
   return path;
 }

-const wchar_t *
+dos_drive_mappings::dos_device_mountpoint
 dos_drive_mappings::next_dos_mount ()
 {
   if (cur_dos)
@@ -2118,10 +2127,10 @@ dos_drive_mappings::next_dos_mount ()
       else
 	cur_mapping = mappings;
       if (!cur_mapping)
-	return NULL;
+	return {NULL, NULL};
       cur_dos = &cur_mapping->dos;
     }
-  return cur_dos->path;
+  return {cur_mapping->ntdevpath, cur_dos->path};
 }

 dos_drive_mappings::~dos_drive_mappings ()
-- 
2.48.1.windows.1

