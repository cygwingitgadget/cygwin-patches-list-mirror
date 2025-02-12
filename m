Return-Path: <SRS0=/5EK=VD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id ADD253858414
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 18:56:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ADD253858414
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ADD253858414
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739386581; cv=none;
	b=Z4SV2Z/mEUYdiH+M7LINLh/SASXAxr6lR52HbY9pVM93GpaZ1soY00eMGUDCIgeutM9YnSRwx2nb/WC3gaj2HgQBCGLH01p2b58TvXRpnuPzUvHT2SCI/anomBfZ+2STMEgPdSeHPGslKwZ5xAmgoJEu2nyUFOgK9f04b4ntB1c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739386581; c=relaxed/simple;
	bh=3qpFnxsnKZPiatOCPeJZUmnCJXQ1glhZWyLmcbcoxQs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lwbLSJS1Tswyei3F0SrS3iIbwnfsb37QrVwcz0TJwTPdx3PLZjuwpRtiHi7hSsoJSqjF2RPJol2EIc1Olh6bDiRqjPJ4PuGhpESmmL5FWTgfqkPA9qPZfPej32nm8Y9p53jREVhLZeda2HntuCqQv4hrDj0MvTsGyi/o0a2ekVw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ADD253858414
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=EZ8Bhhjy
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 8274245C30
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 13:56:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=Gf9I4
	H+BHfAgXgOm+WWz3ZUyqoE=; b=EZ8Bhhjy5q1I82qPXlWrlJb95HVUwZbYVup7W
	QlL1NFMATG2CoUUGJrkICiEglXglGkJbUrbj/IfqWoQqrXgMGxbs4l7RT1hxiY1h
	NpaAsWCrmwCko+3I83Xpt5NapHE7TwCLl/QoDitYyeIvY2WwxHJftUGPq0juVPBD
	Vb96HE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7CD4945C1D
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 13:56:21 -0500 (EST)
Date: Wed, 12 Feb 2025 10:56:21 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
Message-ID: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

They are exposed via the getmntent API and proc filesystem entries
dealing with mounts.  This allows things like `df` to show volumes
that are only mounted on directories, not on drive letters.

Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257251.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/cygtls.cc               |   6 ++
 winsup/cygwin/fhandler/process.cc     |  19 ++---
 winsup/cygwin/local_includes/cygtls.h |   6 +-
 winsup/cygwin/local_includes/mount.h  |   5 +-
 winsup/cygwin/mount.cc                | 107 +++++++++++++++++---------
 5 files changed, 91 insertions(+), 52 deletions(-)

diff --git a/winsup/cygwin/cygtls.cc b/winsup/cygwin/cygtls.cc
index 1134adc3e2..13d133f47c 100644
--- a/winsup/cygwin/cygtls.cc
+++ b/winsup/cygwin/cygtls.cc
@@ -121,6 +121,12 @@ _cygtls::remove (DWORD wait)
       CloseHandle (h);
     }

+  if (locals.drivemappings)
+    {
+      delete locals.drivemappings;
+      locals.drivemappings = NULL;
+    }
+
   /* Close handle and free memory used by select. */
   if (locals.select.sockevt)
     {
diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index f779028116..550da2a820 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -1395,16 +1395,11 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
     u_shared = user_shared;
   mount_info *mtab = &u_shared->mountinfo;

-  /* Store old value of _my_tls.locals here. */
-  int iteration = _my_tls.locals.iteration;
-  unsigned available_drives = _my_tls.locals.available_drives;
-  /* This reinitializes the above values in _my_tls. */
-  setmntent (NULL, NULL);
-  /* Restore iteration immediately since it's not used below.  We use the
-     local iteration variable instead*/
-  _my_tls.locals.iteration = iteration;
-
-  for (iteration = 0; (mnt = mtab->getmntent (iteration)); ++iteration)
+  /* Store old value of _my_tls.locals.drivemappings here. */
+  class dos_drive_mappings *drivemappings = _my_tls.locals.drivemappings;
+  _my_tls.locals.drivemappings = NULL;
+
+  for (int iteration = 0; (mnt = mtab->getmntent (iteration)); ++iteration)
     {
       /* We have no access to the drives mapped into another user session and
 	 _my_tls.locals.available_drives contains the mappings of the current
@@ -1470,8 +1465,8 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
 	}
     }

-  /* Restore available_drives */
-  _my_tls.locals.available_drives = available_drives;
+  /* Restore old value of _my_tls.locals.drivemappings here. */
+  _my_tls.locals.drivemappings = drivemappings;

   if (u_hdl) /* Only not-NULL if open_shared has been called. */
     {
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index d814814b19..dfd3198435 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -93,10 +93,10 @@ struct _local_storage
   int dl_error;
   char dl_buffer[256];

-  /* path.cc */
+  /* mount.cc */
   struct mntent mntbuf;
   int iteration;
-  unsigned available_drives;
+  class dos_drive_mappings *drivemappings;
   char mnt_type[80];
   char mnt_opts[80];
   char mnt_fsname[CYG_MAX_PATH];
@@ -181,7 +181,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   siginfo_t *sigwait_info;
   HANDLE signal_arrived;
   bool will_wait_for_signal;
-#if 1
+#if 0
   long __align;			/* Needed to align context to 16 byte. */
 #endif
   /* context MUST be aligned to 16 byte, otherwise RtlCaptureContext fails.
diff --git a/winsup/cygwin/local_includes/mount.h b/winsup/cygwin/local_includes/mount.h
index c96b34781e..3049de8ba3 100644
--- a/winsup/cygwin/local_includes/mount.h
+++ b/winsup/cygwin/local_includes/mount.h
@@ -216,6 +216,7 @@ class mount_info
   bool from_fstab (bool user, WCHAR [], PWCHAR);

   int cygdrive_win32_path (const char *src, char *dst, int& unit);
+  struct mntent *cygdrive_getmntent ();
 };

 class dos_drive_mappings
@@ -231,11 +232,13 @@ class dos_drive_mappings
       wchar_t *path;
       size_t len;
     } dos;
-  } *mappings;
+  } *mappings, *cur_mapping;
+  mapping::dosmount *cur_dos;

 public:
   dos_drive_mappings ();
   ~dos_drive_mappings ();
   wchar_t *fixup_if_match (wchar_t *path);
+  const wchar_t *next_dos_mount ();
 };
 #endif
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index 4be24fbe84..ef3070dbe1 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1645,14 +1645,8 @@ fillout_mntent (const char *native_path, const char *posix_path, unsigned flags)
   struct mntent& ret=_my_tls.locals.mntbuf;
   bool append_bs = false;

-  /* Remove drivenum from list if we see a x: style path */
   if (strlen (native_path) == 2 && native_path[1] == ':')
-    {
-      int drivenum = cyg_tolower (native_path[0]) - 'a';
-      if (drivenum >= 0 && drivenum <= 31)
-	_my_tls.locals.available_drives &= ~(1 << drivenum);
       append_bs = true;
-    }

   /* Pass back pointers to mount_table strings reserved for use by
      getmntent rather than pointers to strings in the internal mount
@@ -1744,41 +1738,65 @@ mount_item::getmntent ()
   return fillout_mntent (native_path, posix_path, flags);
 }

-static struct mntent *
-cygdrive_getmntent ()
+struct mntent *
+mount_info::cygdrive_getmntent ()
 {
-  char native_path[4];
-  char posix_path[CYG_MAX_PATH];
-  DWORD mask = 1, drive = 'a';
-  struct mntent *ret = NULL;
+  tmp_pathbuf tp;
+  const wchar_t *wide_path;
+  char *win32_path, *posix_path;
+  int err;

-  while (_my_tls.locals.available_drives)
+  if (!_my_tls.locals.drivemappings)
+    _my_tls.locals.drivemappings = new dos_drive_mappings ();
+
+  wide_path = _my_tls.locals.drivemappings->next_dos_mount ();
+  if (wide_path)
     {
-      for (/* nothing */; drive <= 'z'; mask <<= 1, drive++)
-	if (_my_tls.locals.available_drives & mask)
-	  break;
+      win32_path = tp.c_get ();
+      sys_wcstombs (win32_path, NT_MAX_PATH, wide_path);
+      posix_path = tp.c_get ();
+      if ((err = conv_to_posix_path(win32_path, posix_path, 0)))
+      {
+	set_errno (err);
+	return NULL;
+      }

-      __small_sprintf (native_path, "%c:\\", cyg_toupper (drive));
-      if (GetFileAttributes (native_path) == INVALID_FILE_ATTRIBUTES)
+      return fillout_mntent (win32_path, posix_path, cygdrive_flags);
+    }
+  else
+    {
+      if (_my_tls.locals.drivemappings)
 	{
-	  _my_tls.locals.available_drives &= ~mask;
-	  continue;
+	  delete _my_tls.locals.drivemappings;
+	  _my_tls.locals.drivemappings = NULL;
 	}
-      native_path[2] = '\0';
-      __small_sprintf (posix_path, "%s%c", mount_table->cygdrive, drive);
-      ret = fillout_mntent (native_path, posix_path, mount_table->cygdrive_flags);
-      break;
+      return NULL;
     }
-
-  return ret;
 }

 struct mntent *
 mount_info::getmntent (int x)
 {
   if (x < 0 || x >= nmounts)
-    return cygdrive_getmntent ();
-
+    {
+      struct mntent *ret;
+      /* de-duplicate against explicit mount entries */
+      while ((ret = cygdrive_getmntent ()))
+	{
+	  for (int i = 0; i < nmounts; ++i)
+	    {
+	      int cmp = strcmp (ret->mnt_dir, mount[posix_sorted[i]].posix_path);
+	      if (!cmp && strcasematch (ret->mnt_fsname,
+					mount[posix_sorted[i]].native_path))
+		goto cygdrive_mntent_continue;
+	      else if (cmp > 0)
+		break;
+	    }
+	  break;
+cygdrive_mntent_continue:;
+	}
+      return ret;
+    }
   return mount[native_sorted[x]].getmntent ();
 }

@@ -1943,14 +1961,11 @@ extern "C" FILE *
 setmntent (const char *filep, const char *)
 {
   _my_tls.locals.iteration = 0;
-  _my_tls.locals.available_drives = GetLogicalDrives ();
-  /* Filter floppy drives on A: and B: */
-  if ((_my_tls.locals.available_drives & 1)
-      && get_disk_type (L"A:") == DT_FLOPPY)
-    _my_tls.locals.available_drives &= ~1;
-  if ((_my_tls.locals.available_drives & 2)
-      && get_disk_type (L"B:") == DT_FLOPPY)
-    _my_tls.locals.available_drives &= ~2;
+  if (_my_tls.locals.drivemappings)
+    {
+      delete _my_tls.locals.drivemappings;
+      _my_tls.locals.drivemappings = NULL;
+    }
   return (FILE *) filep;
 }

@@ -1996,6 +2011,8 @@ endmntent (FILE *)

 dos_drive_mappings::dos_drive_mappings ()
 : mappings(0)
+, cur_mapping(0)
+, cur_dos(0)
 {
   tmp_pathbuf tp;
   wchar_t vol[64]; /* Long enough for Volume GUID string */
@@ -2112,6 +2129,24 @@ dos_drive_mappings::fixup_if_match (wchar_t *path)
   return path;
 }

+const wchar_t *
+dos_drive_mappings::next_dos_mount ()
+{
+  if (cur_dos)
+    cur_dos = cur_dos->next;
+  while (!cur_dos)
+    {
+      if (cur_mapping)
+	cur_mapping = cur_mapping->next;
+      else
+	cur_mapping = mappings;
+      if (!cur_mapping)
+	return NULL;
+      cur_dos = &cur_mapping->dos;
+    }
+  return cur_dos->path;
+}
+
 dos_drive_mappings::~dos_drive_mappings ()
 {
   mapping *n = 0;
-- 
2.47.1.windows.2

