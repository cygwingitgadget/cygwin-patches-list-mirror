Return-Path: <SRS0=3P/8=VK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 768963858C42
	for <cygwin-patches@cygwin.com>; Wed, 19 Feb 2025 01:51:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 768963858C42
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 768963858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739929901; cv=none;
	b=pzcQ2vUoR+raNUOTbeMcUS0B8vIbApaA472cdDlHAeUYLYL/JQMy3VEFq96yegQRAwwoVrcoIj/7of2apXXW9IdvVCmdvdG818Ku3eLMAa/bxsrJzzFe1Ghavd3Mh86jmCim4xjCe0KrksU7VE3DeqRIqxmqjrZj2CIIDr/tLVs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739929901; c=relaxed/simple;
	bh=Q0TXhvhmjUMln6MwZ9kr7Hq5GhY/uwCuUNS5wBxujTY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=eSGHpFtz78LsywPGjyBFq8Iwfe249j5o4lco5i3BZUr7/tAEggj4e56pMV+mV4ff49nYymvrufSGeI2ASdhpZgPbIveXZyF59fzcOC1PFHx62he8QyZwSVXy+77OxOM282w17ugqPf6cLfxrHtLW6UJWAkEH9ypx7aQya/wcJYM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 768963858C42
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=XIWEfpzG
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4F1BE45C30
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 20:51:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=Klga+
	LFuX/Sji7MxC52qCJTtG7c=; b=XIWEfpzGJgtdgMUcvoTkh8uxlatJfab2Vh5IC
	D/KliCjHDT28czIEk6wn0jYaPXJr2vZBiZHS+ZOGRqt6Wve08aDTOBQIQyWiVmQH
	RpI5+kJGWbCuGC8pZV+gUWhMUNp83VDLJt7EEW9MNJgC816IEt4S3tHqQZvCx2sV
	/2EJ3o=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4844E45BF6
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 20:51:41 -0500 (EST)
Date: Tue, 18 Feb 2025 17:51:41 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/2] Cygwin: skip floppy drives in cygdrive_getmntent.
Message-ID: <9b20134b-c892-edbd-eac3-d2781bcec039@jdrake.com>
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
 winsup/cygwin/local_includes/mount.h |  3 ++-
 winsup/cygwin/mount.cc               | 23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/local_includes/mount.h b/winsup/cygwin/local_includes/mount.h
index 3049de8ba3..b719d98359 100644
--- a/winsup/cygwin/local_includes/mount.h
+++ b/winsup/cygwin/local_includes/mount.h
@@ -23,6 +23,7 @@ enum disk_type
   DT_SHARE_NFS
 };

+disk_type get_device_type (LPCWSTR);
 disk_type get_disk_type (LPCWSTR);

 /* Don't add new fs types without adding them to fs_names in mount.cc!
@@ -236,7 +237,7 @@ class dos_drive_mappings
   mapping::dosmount *cur_dos;

 public:
-  dos_drive_mappings ();
+  dos_drive_mappings (bool with_floppies = true);
   ~dos_drive_mappings ();
   wchar_t *fixup_if_match (wchar_t *path);
   const wchar_t *next_dos_mount ();
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index ab07c5abef..c921c7691c 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1746,7 +1746,7 @@ mount_info::cygdrive_getmntent ()
   char *win32_path, *posix_path;

   if (!_my_tls.locals.drivemappings)
-    _my_tls.locals.drivemappings = new dos_drive_mappings ();
+    _my_tls.locals.drivemappings = new dos_drive_mappings (false);

   wide_path = _my_tls.locals.drivemappings->next_dos_mount ();
   if (wide_path)
@@ -1899,11 +1899,9 @@ cygwin_umount (const char *path, unsigned flags)
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
@@ -1934,6 +1932,15 @@ get_disk_type (LPCWSTR dos)
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
@@ -2020,7 +2027,7 @@ resolve_dos_device (const wchar_t *dosname, wchar_t *devpath)
   return false;
 }

-dos_drive_mappings::dos_drive_mappings ()
+dos_drive_mappings::dos_drive_mappings (bool with_floppies)
 : mappings(0)
 , cur_mapping(0)
 , cur_dos(0)
@@ -2044,6 +2051,8 @@ dos_drive_mappings::dos_drive_mappings ()
 	mount[--len] = L'\0'; /* Drop trailing backslash */
 	if (resolve_dos_device (mount, devpath))
 	  {
+	    if (!with_floppies && get_device_type (devpath) == DT_FLOPPY)
+	      continue;
 	    mapping *m = new mapping ();
 	    if (m)
 	      {
@@ -2088,6 +2097,8 @@ dos_drive_mappings::dos_drive_mappings ()
 	*wcsrchr (vol, L'\\') = L'\0';
 	if (resolve_dos_device (vol + 4, devpath))
 	  {
+	    if (!with_floppies && get_device_type (devpath) == DT_FLOPPY)
+	      continue;
 	    mapping *m = new mapping ();
 	    bool hadrootmount = false;
 	    if (m)
-- 
2.48.1.windows.1

