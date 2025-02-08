Return-Path: <SRS0=BywE=U7=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 32DA8385781A
	for <cygwin-patches@cygwin.com>; Sat,  8 Feb 2025 04:38:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 32DA8385781A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 32DA8385781A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1738989498; cv=none;
	b=IDpcarzAcoXA3v7vz7CZ71jFYwDUMw+aEh6Db7YSNBd3sz2YA4JOp6eBbVhIYLv0F3wxpIY5UIz4FdBkm6ZOTEcccRvMqM+WjjQdncIYtGn5/1s869lHCUZ4w0YEZCs0BRvawJK9626djMQXOD/9nYbGWYe8rt9atazpFHLChpM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1738989498; c=relaxed/simple;
	bh=5IC2g6ycUh0JMq3aiVKnX7x4AW3q8K9vMLpO6XoNXlc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mcB47OXoFc7Gon7uqwZBfXo5IhuX4U94MUgcNSZnQgtc9xNMO99hMglhVPdQJ1U0FKgD9J0fwSD7ZJr26qj4TrNZh+pyRShKIOmL3UEPFbJEUtN6W7aY+lMqw1C4MkTdyQu5QoD2WjgRwxkooBjGZhUkKJskYJiypANR98xH+tg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 32DA8385781A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=YT/QPEK3
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id C7B7445CBB
	for <cygwin-patches@cygwin.com>; Fri,  7 Feb 2025 23:38:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=ASZr8
	6TvCacxqIznrVfLZE1K0WE=; b=YT/QPEK3/TGPZ+aGq8VlCclLYJafsm6a/f76P
	BDrpzDJKW1OIcgkCJBgKWxDtjKaPQkcSNNcI3CczTBbCeM9L95sqmTrk7bgxGnos
	bFFzch0ur+9ima5E+Gb1iGgFRa9UA7skZdDthtiGITyTtcZevvygwTM0alXLx3YZ
	uey7vQ=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9A0A645C73
	for <cygwin-patches@cygwin.com>; Fri,  7 Feb 2025 23:38:17 -0500 (EST)
Date: Fri, 7 Feb 2025 20:38:17 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: expose all windows volume mount points.
Message-ID: <be64d541-a24d-b5ff-5a50-9aae577a48ae@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

They are exposed via the getmntent API and proc filesystem entries
dealing with mounts.  This allows things like `df` to show volumes
that are only mounted on directories, not on drive letters.

Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257251.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
Rather amazingly, this seemed to work as I expected.  Kind of gross due to
keeping state in the _mytls.locals struct, but it seems to do the job.
Does this approach make sense, or is there something I'm missing?

 winsup/cygwin/cygtls.cc               |   7 ++
 winsup/cygwin/fhandler/process.cc     |  14 ++-
 winsup/cygwin/local_includes/cygtls.h |   9 +-
 winsup/cygwin/local_includes/mount.h  |   1 +
 winsup/cygwin/mount.cc                | 168 ++++++++++++++++++++------
 5 files changed, 158 insertions(+), 41 deletions(-)

diff --git a/winsup/cygwin/cygtls.cc b/winsup/cygwin/cygtls.cc
index 1134adc3e2..903ddb12f5 100644
--- a/winsup/cygwin/cygtls.cc
+++ b/winsup/cygwin/cygtls.cc
@@ -121,6 +121,13 @@ _cygtls::remove (DWORD wait)
       CloseHandle (h);
     }

+  /* Close handle and free memory used by getmntent */
+  if (locals.volumesearchhandle)
+    {
+      FindVolumeClose (locals.volumesearchhandle);
+      locals.volumesearchhandle = NULL;
+    }
+  free_local (volumemountpoints);
   /* Close handle and free memory used by select. */
   if (locals.select.sockevt)
     {
diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index f779028116..555d1ddca2 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -1397,7 +1397,12 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)

   /* Store old value of _my_tls.locals here. */
   int iteration = _my_tls.locals.iteration;
-  unsigned available_drives = _my_tls.locals.available_drives;
+  int volumemountpointoffset = _my_tls.locals.volumemountpointoffset;
+  HANDLE volumesearchhandle = _my_tls.locals.volumesearchhandle;
+  WCHAR *volumemountpoints = _my_tls.locals.volumemountpoints;
+  DWORD volumemountpointslen = _my_tls.locals.volumemountpointslen;
+  _my_tls.locals.volumesearchhandle = NULL;
+  _my_tls.locals.volumemountpoints = NULL;
   /* This reinitializes the above values in _my_tls. */
   setmntent (NULL, NULL);
   /* Restore iteration immediately since it's not used below.  We use the
@@ -1470,8 +1475,11 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
 	}
     }

-  /* Restore available_drives */
-  _my_tls.locals.available_drives = available_drives;
+  /* Restore old values of _my_tls.locals here. */
+  _my_tls.locals.volumemountpointoffset = volumemountpointoffset;
+  _my_tls.locals.volumesearchhandle = volumesearchhandle;
+  _my_tls.locals.volumemountpoints = volumemountpoints;
+  _my_tls.locals.volumemountpointslen = volumemountpointslen;

   if (u_hdl) /* Only not-NULL if open_shared has been called. */
     {
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
index d814814b19..ba9e980ec1 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -93,10 +93,13 @@ struct _local_storage
   int dl_error;
   char dl_buffer[256];

-  /* path.cc */
+  /* mount.cc */
   struct mntent mntbuf;
   int iteration;
-  unsigned available_drives;
+  int volumemountpointoffset;
+  HANDLE volumesearchhandle;
+  WCHAR *volumemountpoints; // note: malloced
+  DWORD volumemountpointslen;
   char mnt_type[80];
   char mnt_opts[80];
   char mnt_fsname[CYG_MAX_PATH];
@@ -181,7 +184,7 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
   siginfo_t *sigwait_info;
   HANDLE signal_arrived;
   bool will_wait_for_signal;
-#if 1
+#if 0
   long __align;			/* Needed to align context to 16 byte. */
 #endif
   /* context MUST be aligned to 16 byte, otherwise RtlCaptureContext fails.
diff --git a/winsup/cygwin/local_includes/mount.h b/winsup/cygwin/local_includes/mount.h
index b2acdf08b4..7120281069 100644
--- a/winsup/cygwin/local_includes/mount.h
+++ b/winsup/cygwin/local_includes/mount.h
@@ -216,6 +216,7 @@ class mount_info
   bool from_fstab (bool user, WCHAR [], PWCHAR);

   int cygdrive_win32_path (const char *src, char *dst, int& unit);
+  struct mntent *cygdrive_getmntent ();
 };

 class dos_drive_mappings
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index bf26c4af3e..3ca0b94e45 100644
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
@@ -1744,41 +1738,133 @@ mount_item::getmntent ()
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
+  char *win32_path, *posix_path;
+  DWORD endpos;
+  int err;
+  WCHAR volumename[64];
+  volumename[0] = L'\0';
+  if (!_my_tls.locals.volumesearchhandle)
+    {
+      _my_tls.locals.volumesearchhandle = FindFirstVolumeW (volumename,
+					  sizeof (volumename) / sizeof (WCHAR));
+      if (_my_tls.locals.volumesearchhandle == INVALID_HANDLE_VALUE)
+	{
+	  __seterrno();
+	  _my_tls.locals.volumesearchhandle = NULL;
+	  goto cleanup;
+	}
+    }

-  while (_my_tls.locals.available_drives)
+  if (!_my_tls.locals.volumemountpoints)
     {
-      for (/* nothing */; drive <= 'z'; mask <<= 1, drive++)
-	if (_my_tls.locals.available_drives & mask)
-	  break;
+      _my_tls.locals.volumemountpoints = (WCHAR *) malloc (NT_MAX_PATH * sizeof (WCHAR));
+      _my_tls.locals.volumemountpoints[0] = L'\0';
+      _my_tls.locals.volumemountpointoffset = 0;
+      _my_tls.locals.volumemountpointslen = NT_MAX_PATH;
+    }
+
+  while (!_my_tls.locals.volumemountpoints[_my_tls.locals.volumemountpointoffset])
+    {
+      if (!volumename[0] &&
+	  !FindNextVolumeW (_my_tls.locals.volumesearchhandle, volumename,
+			    sizeof (volumename) / sizeof (WCHAR)))
+	{
+	  __seterrno ();
+	  goto cleanup;
+	}

-      __small_sprintf (native_path, "%c:\\", cyg_toupper (drive));
-      if (GetFileAttributes (native_path) == INVALID_FILE_ATTRIBUTES)
+      WCHAR *volumemountpoints = _my_tls.locals.volumemountpoints;
+      DWORD volumemountpointslen = _my_tls.locals.volumemountpointslen;
+      BOOL success;
+      while (!(success = GetVolumePathNamesForVolumeNameW (volumename,
+		volumemountpoints, volumemountpointslen,
+		&volumemountpointslen)) &&
+	     GetLastError () == ERROR_MORE_DATA &&
+	     (volumemountpoints = (WCHAR *) realloc (volumemountpoints,
+				       volumemountpointslen * sizeof (WCHAR))))
 	{
-	  _my_tls.locals.available_drives &= ~mask;
-	  continue;
+	  _my_tls.locals.volumemountpoints = volumemountpoints;
+	  _my_tls.locals.volumemountpointslen = volumemountpointslen;
+	}
+
+      if (!volumemountpoints)
+	{
+	  set_errno (ENOMEM);
+	  goto cleanup;
+	}
+
+      if (!success)
+	{
+	  if (GetLastError () != ERROR_NO_MORE_FILES)
+	    __seterrno ();
+	  else
+	    set_errno (0);
+	  goto cleanup;
 	}
-      native_path[2] = '\0';
-      __small_sprintf (posix_path, "%s%c", mount_table->cygdrive, drive);
-      ret = fillout_mntent (native_path, posix_path, mount_table->cygdrive_flags);
-      break;
+
+      _my_tls.locals.volumemountpointoffset = 0;
+      volumename[0] = L'\0';
     }

-  return ret;
+  endpos = _my_tls.locals.volumemountpointoffset +
+				wcslen (_my_tls.locals.volumemountpoints +
+					_my_tls.locals.volumemountpointoffset);
+  if (_my_tls.locals.volumemountpoints[endpos - 1] == L'\\')
+    _my_tls.locals.volumemountpoints[endpos - 1] = L'\0';
+  win32_path = tp.c_get ();
+  sys_wcstombs (win32_path, NT_MAX_PATH, _my_tls.locals.volumemountpoints +
+					_my_tls.locals.volumemountpointoffset);
+  _my_tls.locals.volumemountpointoffset = endpos + 1;
+
+  posix_path = tp.c_get ();
+  if ((err = conv_to_posix_path(win32_path, posix_path, 0)))
+    {
+      set_errno (err);
+      goto cleanup;
+    }
+
+  return fillout_mntent (win32_path, posix_path, cygdrive_flags);
+
+cleanup:
+  save_errno errno_saver;
+
+  if (_my_tls.locals.volumesearchhandle)
+  {
+    FindVolumeClose (_my_tls.locals.volumesearchhandle);
+    _my_tls.locals.volumesearchhandle = NULL;
+  }
+  if (_my_tls.locals.volumemountpoints)
+  {
+    free (_my_tls.locals.volumemountpoints);
+    _my_tls.locals.volumemountpoints = NULL;
+  }
+  return NULL;
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
+	      if (!strcmp (ret->mnt_dir, mount[i].posix_path) &&
+		  strcasematch (ret->mnt_fsname, mount[i].native_path))
+		goto cygdrive_mntent_continue;
+	    }
+	  break;
+cygdrive_mntent_continue:;
+	}
+      return ret;
+    }
   return mount[native_sorted[x]].getmntent ();
 }

@@ -1943,14 +2029,16 @@ extern "C" FILE *
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
+  if (_my_tls.locals.volumesearchhandle)
+  {
+    FindVolumeClose (_my_tls.locals.volumesearchhandle);
+    _my_tls.locals.volumesearchhandle = NULL;
+  }
+  if (_my_tls.locals.volumemountpoints)
+  {
+    free (_my_tls.locals.volumemountpoints);
+    _my_tls.locals.volumemountpoints = NULL;
+  }
   return (FILE *) filep;
 }

@@ -1991,6 +2079,16 @@ getmntent_r (FILE *, struct mntent *mntbuf, char *buf, int buflen)
 extern "C" int
 endmntent (FILE *)
 {
+  if (_my_tls.locals.volumesearchhandle)
+  {
+    FindVolumeClose (_my_tls.locals.volumesearchhandle);
+    _my_tls.locals.volumesearchhandle = NULL;
+  }
+  if (_my_tls.locals.volumemountpoints)
+  {
+    free (_my_tls.locals.volumemountpoints);
+    _my_tls.locals.volumemountpoints = NULL;
+  }
   return 1;
 }

-- 
2.47.1.windows.2

