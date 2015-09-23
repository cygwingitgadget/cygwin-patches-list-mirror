Return-Path: <cygwin-patches-return-8246-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28686 invoked by alias); 23 Sep 2015 15:24:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28251 invoked by uid 89); 23 Sep 2015 15:24:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=4.5 required=5.0 tests=BAYES_99,BAYES_999,FREEMAIL_FROM,KAM_STOCKGEN,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-HELO: forward16p.cmail.yandex.net
Received: from forward16p.cmail.yandex.net (HELO forward16p.cmail.yandex.net) (87.250.241.143) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 23 Sep 2015 15:24:28 +0000
Received: from web4g.yandex.ru (web4g.yandex.ru [IPv6:2a02:6b8:0:1402::14])	by forward16p.cmail.yandex.net (Yandex) with ESMTP id 0516320FFA	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2015 18:23:51 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])	by web4g.yandex.ru (Yandex) with ESMTP id A0A123800D02;	Wed, 23 Sep 2015 18:23:51 +0300 (MSK)
Received: by web4g.yandex.ru with HTTP;	Wed, 23 Sep 2015 18:23:51 +0300
From: Evgeny Grin <k2k@yandex.ru>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add ability to use NTFS native directory symlinks without admin rights on XP and later
MIME-Version: 1.0
Message-Id: <766021443021831@web4g.yandex.ru>
Date: Wed, 23 Sep 2015 15:24:00 -0000
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-IsSubscribed: yes
X-SW-Source: 2015-q3/txt/msg00028.txt.bz2

(second try, previous was truncated) 
This patch will add ability to create directory junction which are supported from Windows 2000 and not require any special rights (unlike file/directory symbolic links).
New three modes for symbolic links creation added: "safenative", "safenativestrict" and "safenativeonly". First two allow fallback to "native" and "nativesctrict", last one use only directory junction for symbolic links (file links will fail with this setting, but it can be useful for derived projects like MSys or Git for Windows).

Only creation of directory junctions is implemented in this patch, reading and resolving junction as symbolic links are already supported by Cygwin.
I'd recommend to set default mode to "safenative" as it allow to use system functionality out-of-box with fallback to Cygwin's functionality where system's symlinks are not available.


---
 winsup/cygwin/environ.cc |   9 ++
 winsup/cygwin/globals.cc |   5 +-
 winsup/cygwin/path.cc    | 215 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 226 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 8f25fb1..b02d685 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -84,6 +84,15 @@ set_winsymlinks (const char *buf)
     allow_winsymlinks = WSYM_lnk;
   else if (ascii_strncasematch (buf, "lnk", 3))
     allow_winsymlinks = WSYM_lnk;
+  else if (ascii_strncasematch (buf, "safenative", 10))
+    {
+      if (ascii_strcasematch (buf + 10, "strict"))
+        allow_winsymlinks = WSYM_safenativestrict;
+      else if (ascii_strcasematch (buf + 10, "only"))
+        allow_winsymlinks = WSYM_safenativeonly;
+      else
+        allow_winsymlinks = WSYM_safenative;
+    }
   /* Make sure to try native symlinks only on systems supporting them. */
   else if (ascii_strncasematch (buf, "native", 6))
     {
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index 09c08f2..c468741 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -59,7 +59,10 @@ enum winsym_t
   WSYM_lnk,
   WSYM_native,
   WSYM_nativestrict,
-  WSYM_nfs
+  WSYM_nfs,
+  WSYM_safenative,
+  WSYM_safenativestrict,
+  WSYM_safenativeonly
 };
 
 exit_states NO_COPY exit_state;
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 89dbdab..fb7b191 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1734,6 +1734,207 @@ symlink_native (const char *oldpath, path_conv &win32_newpath)
   return 0;
 }
 
+static int
+symlink_safenative (const char *oldpath, path_conv &win32_newpath)
+{
+  tmp_pathbuf tp;
+  path_conv win32_oldpath;
+  PUNICODE_STRING nt_oldpath;
+  NTSTATUS status;
+  HANDLE fh;
+  OBJECT_ATTRIBUTES attr;
+  IO_STATUS_BLOCK io;
+  PREPARSE_DATA_BUFFER prdb;
+  ACCESS_MASK access_mask;
+
+  syscall_printf ("symlink_safenative (oldpath: '%s', newpath: '%s')", oldpath,
+                win32_newpath.get_posix ());
+
+  /* Directory junction cannot be created on remote drive.
+     Leave this check here to simplify routing in symlink_worker(). */
+  if (win32_newpath.isremote ())
+    {
+      debug_printf ("'%S' is on remote drive",
+                    win32_newpath.get_nt_native_path ());
+      set_errno (EXDEV);
+      return -1;
+    }
+
+  win32_oldpath.check (oldpath, PC_SYM_NOFOLLOW);
+
+  /* Make sure that symlink target is directory as directory junction
+     can point only to directory. If target is not exist yet then
+     don't create junction to prevent an invalid state with junction
+     pointing to later created regular file. */
+  if (!win32_oldpath.exists () || !win32_oldpath.isdir ())
+    {
+      debug_printf ("'%S' does not exist or is not a directory",
+                    win32_oldpath.get_nt_native_path ());
+      set_errno (ENOTDIR);
+      return -1;
+    }
+
+  nt_oldpath = win32_oldpath.get_nt_native_path ();
+
+  /* Directory junction can point only to local mounted drive. */
+  if (nt_oldpath->Length < 6 * sizeof (wchar_t) ||
+      nt_oldpath->Buffer[5] != L':')
+    {
+      debug_printf ("'%S' is not on local mounted drive", nt_oldpath);
+      set_errno (EXDEV);
+      return -1;
+    }
+
+  /* Make sure that slash for root directory is present otherwise OS will 
+     misbehavior when resolving such junction. This is an extra care as 
+     get_nt_native_path() should return correct path. */
+  if (nt_oldpath->Length < 7 * sizeof (wchar_t) ||
+      nt_oldpath->Buffer[6] != L'\\')
+    {
+      set_errno (ENOTDIR);
+      return -1;
+    }
+
+  if (offsetof (REPARSE_DATA_BUFFER, MountPointReparseBuffer.PathBuffer) +
+      nt_oldpath->Length * 2 + (2 - 4) * sizeof (wchar_t)
+      > MAXIMUM_REPARSE_DATA_BUFFER_SIZE)
+    {
+      set_errno (ENAMETOOLONG);
+      return -1;
+    }
+
+#if MAXIMUM_REPARSE_DATA_BUFFER_SIZE > NT_MAX_PATH
+#error REPARSE_DATA_BUFFER do not fit into tmp_pathbuf::c_get() buffer. Rewrite code.
+#endif
+  prdb = (PREPARSE_DATA_BUFFER) tp.c_get ();
+
+  prdb->Reserved = 0;
+  prdb->ReparseTag = IO_REPARSE_TAG_MOUNT_POINT;
+  prdb->MountPointReparseBuffer.SubstituteNameOffset = 0;
+  memcpy(prdb->MountPointReparseBuffer.PathBuffer, nt_oldpath->Buffer,
+         nt_oldpath->Length);
+  prdb->MountPointReparseBuffer.SubstituteNameLength =
+          (USHORT)(nt_oldpath->Length);
+  prdb->MountPointReparseBuffer.PathBuffer[
+          prdb->MountPointReparseBuffer.SubstituteNameLength / sizeof (wchar_t)] = 0;
+  prdb->MountPointReparseBuffer.PrintNameOffset =
+          prdb->MountPointReparseBuffer.SubstituteNameLength + 1 * sizeof (wchar_t);
+  memcpy(&(prdb->MountPointReparseBuffer.PathBuffer[
+         prdb->MountPointReparseBuffer.PrintNameOffset / sizeof (wchar_t)]),
+         &(nt_oldpath->Buffer[4]), nt_oldpath->Length - 4 * sizeof (wchar_t));
+  prdb->MountPointReparseBuffer.PrintNameLength =
+          (USHORT)(nt_oldpath->Length - 4 * sizeof (wchar_t));
+  prdb->MountPointReparseBuffer.PathBuffer[
+          (prdb->MountPointReparseBuffer.PrintNameOffset + 
+           prdb->MountPointReparseBuffer.PrintNameLength) / sizeof (wchar_t)] = 0;
+  prdb->ReparseDataLength = (USHORT) offsetof(REPARSE_DATA_BUFFER,
+                                              MountPointReparseBuffer.PathBuffer) -
+          REPARSE_DATA_BUFFER_HEADER_SIZE +
+          prdb->MountPointReparseBuffer.PrintNameOffset +
+          prdb->MountPointReparseBuffer.PrintNameLength + 1 * sizeof (wchar_t);
+
+  /* DELETE access is required to delete empty directory if it's not
+     transformed into directory junctions. */
+  access_mask = FILE_WRITE_ATTRIBUTES | FILE_LIST_DIRECTORY |
+      FILE_TRAVERSE | SYNCHRONIZE | DELETE;
+  /* READ_CONTROL and WRITE_DAC are required for reuse handle in
+     set_file_attribute() otherwise function will need to reopen file. */
+  if (win32_newpath.has_acls ())
+    access_mask |= READ_CONTROL | WRITE_DAC;
+
+  status = NtCreateFile (&fh, access_mask,
+                         win32_newpath.get_object_attr (attr, sec_none_nih),
+                         &io, NULL, FILE_ATTRIBUTE_DIRECTORY,
+                         0, FILE_CREATE, FILE_DIRECTORY_FILE |
+                         FILE_OPEN_REPARSE_POINT | FILE_OPEN_FOR_BACKUP_INTENT,
+                         NULL, 0);
+  if (!NT_SUCCESS (status))
+    {
+      if (status == STATUS_ACCESS_DENIED)
+        {
+          ULONG share_access;
+          /* Retry with less requested access rights. */
+          debug_printf ("Creating '%S' with restricted access rights",
+                        win32_newpath.get_nt_native_path ());
+
+          access_mask &= ~(DELETE | READ_CONTROL | WRITE_DAC);
+
+          /* Allow sharing otherwise set_file_attribute() will fail. */
+          share_access = win32_newpath.has_acls () ? (FILE_SHARE_READ |
+                                                      FILE_SHARE_WRITE) : 0;
+          status = NtCreateFile (&fh, access_mask,
+                                 win32_newpath.get_object_attr (attr, sec_none_nih),
+                                 &io, NULL, FILE_ATTRIBUTE_DIRECTORY,
+                                 share_access, FILE_CREATE, FILE_DIRECTORY_FILE |
+                                 FILE_OPEN_REPARSE_POINT |
+                                 FILE_OPEN_FOR_BACKUP_INTENT, NULL, 0);
+        }
+      if (!NT_SUCCESS (status))
+        {
+          debug_printf ("Creating '%S' failed, status = %y", 
+                        win32_newpath.get_nt_native_path (), status);
+          __seterrno_from_nt_status (status);
+          return -1;
+        }
+    }
+
+  if (win32_newpath.has_acls ())
+    set_file_attribute (fh, win32_newpath, ILLEGAL_UID, ILLEGAL_GID,
+                        S_JUSTCREATED | S_IFDIR | S_IFLNK |
+                        STD_RBITS | STD_WBITS | STD_XBITS);
+
+  debug_printf ("Setting SubstituteName '%W' and PrintName '%W' for directory junction '%S'", 
+                prdb->MountPointReparseBuffer.PathBuffer +
+                  prdb->MountPointReparseBuffer.SubstituteNameOffset / sizeof (wchar_t),
+                prdb->MountPointReparseBuffer.PathBuffer +
+                  prdb->MountPointReparseBuffer.PrintNameOffset / sizeof (wchar_t),
+                win32_newpath.get_nt_native_path ());
+  status = NtFsControlFile (fh, NULL, NULL, NULL, &io, FSCTL_SET_REPARSE_POINT,
+                            prdb, (ULONG)(prdb->ReparseDataLength +
+                                    REPARSE_DATA_BUFFER_HEADER_SIZE), NULL, 0);
+  if (status == STATUS_PENDING)
+    {
+      if (WaitForSingleObject (fh, 2000) == WAIT_OBJECT_0)
+        status = io.Status;
+      else
+        status = STATUS_ACCESS_DENIED;
+    }
+
+  if (!NT_SUCCESS (status))
+    {
+      FILE_DISPOSITION_INFORMATION disp = { TRUE };
+      if (status == STATUS_IO_REPARSE_TAG_INVALID || status == STATUS_IO_REPARSE_DATA_INVALID)
+        debug_printf ("Setting reparse point failed because reparse point data is invalid, status = %y", status);
+      else
+        debug_printf ("Setting reparse point failed, status = %y", status);
+      __seterrno_from_nt_status (status);
+
+      /* Delete created junction blank. */
+      status = NtSetInformationFile (fh, &io, &disp, sizeof (disp),
+                                     FileDispositionInformation);
+      NtClose (fh);
+      if (!NT_SUCCESS (status))
+        {
+          /* Reopen junction blank for deletion. */
+          status = NtCreateFile (&fh, DELETE,
+                                 win32_newpath.get_object_attr (attr, sec_none_nih),
+                                 &io, NULL, FILE_ATTRIBUTE_DIRECTORY,
+                                 FILE_SHARE_DELETE, FILE_OPEN, FILE_DIRECTORY_FILE |
+                                 FILE_OPEN_REPARSE_POINT | FILE_OPEN_FOR_BACKUP_INTENT |
+                                 FILE_DELETE_ON_CLOSE, NULL, 0);
+          if (NT_SUCCESS (status))
+            NtClose (fh);
+        }
+      if (!NT_SUCCESS (status) && status != STATUS_DELETE_PENDING)
+        debug_printf ("Removing directory junction blank failed, status = %y", status);
+
+      return -1;
+  }
+
+  NtClose (fh);
+  return 0;
+}
+
 int
 symlink_worker (const char *oldpath, const char *newpath, bool isdevice)
 {
@@ -1798,7 +1999,10 @@ symlink_worker (const char *oldpath, const char *newpath, bool isdevice)
 	  wsym_type = WSYM_nativestrict;
 	}
       /* Don't try native symlinks on FSes not supporting reparse points. */
-      else if ((wsym_type == WSYM_native || wsym_type == WSYM_nativestrict)
+      else if ((wsym_type == WSYM_native || wsym_type == WSYM_nativestrict
+                || wsym_type == WSYM_safenative
+                || wsym_type == WSYM_safenativestrict
+                || wsym_type == WSYM_safenativeonly)
 	       && !(win32_newpath.fs_flags () & FILE_SUPPORTS_REPARSE_POINTS))
 	wsym_type = WSYM_sysfile;
 
@@ -1838,13 +2042,20 @@ symlink_worker (const char *oldpath, const char *newpath, bool isdevice)
 	case WSYM_nfs:
 	  res = symlink_nfs (oldpath, win32_newpath);
 	  __leave;
+        case WSYM_safenative:
+	case WSYM_safenativestrict:
+        case WSYM_safenativeonly:
+          res = symlink_safenative (oldpath, win32_newpath);
+	  if (!res || wsym_type == WSYM_safenativeonly)
+	    __leave;
+	/* Intentional fall-through */
 	case WSYM_native:
 	case WSYM_nativestrict:
 	  res = symlink_native (oldpath, win32_newpath);
 	  if (!res)
 	    __leave;
 	  /* Strictly native?  Too bad. */
-	  if (wsym_type == WSYM_nativestrict)
+	  if (wsym_type == WSYM_nativestrict || wsym_type == WSYM_safenativestrict)
 	    {
 	      __seterrno ();
 	      __leave;
-- 
2.5.1.windows.1
