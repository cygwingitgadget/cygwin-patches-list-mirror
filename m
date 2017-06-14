Return-Path: <cygwin-patches-return-8785-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11235 invoked by alias); 14 Jun 2017 20:17:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11213 invoked by uid 89); 14 Jun 2017 20:17:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_PASS autolearn=ham version=3.3.2 spammy=ntfs, NTFS, FUTURE, literally
X-HELO: mail.pismotechnic.com
Received: from mail.pismotechnic.com (HELO mail.pismotechnic.com) (162.218.67.164) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 14 Jun 2017 20:17:01 +0000
Received: from [10.2.1.30] (c-73-240-197-175.hsd1.or.comcast.net [73.240.197.175])	by mail.pismotechnic.com (Postfix) with ESMTPSA id 5C544160281	for <cygwin-patches@cygwin.com>; Wed, 14 Jun 2017 13:17:04 -0700 (PDT)
Message-ID: <594199C4.9080804@pismotec.com>
Date: Wed, 14 Jun 2017 20:17:00 -0000
From: Joe Lowe <joe@pismotec.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:25.9) Gecko/20160412 FossaMail/25.2.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Compatibility improvement to reparse point handling, v3
Content-Type: multipart/mixed; boundary="------------080703070706090208020707"
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00056.txt.bz2

This is a multi-part message in MIME format.
--------------080703070706090208020707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 305

3rd pass at reparse point handling patch.

Changes to this version of the patch.
1. Refactored, smaller, less code impact.
2. readdir() and stat() consistency changes now also handle native file 
(non-directory) symbolic links. readir() returns DT_REG to match lstat() 
indicating a normal file.

Joe L.


--------------080703070706090208020707
Content-Type: text/plain; charset=windows-1252;
 name="0001-Compatibility-improvements-to-reparse-point-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Compatibility-improvements-to-reparse-point-handling.pa";
 filename*1="tch"
Content-length: 9306

From 736979422efb815f4b2906642d522c51d98ba230 Mon Sep 17 00:00:00 2001
From: Joe_Lowe <joe@pismotec.com>
Date: Wed, 14 Jun 2017 13:01:28 -0700
Subject: [PATCH] Compatibility improvements to reparse point handling.

---
 winsup/cygwin/fhandler_disk_file.cc | 63 +++++++++++++++++++++++--------------
 winsup/cygwin/path.cc               | 59 +++++++++++++++++++++++++++-------
 winsup/cygwin/path.h                |  1 +
 3 files changed, 87 insertions(+), 36 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 01a9afe15..f8adcaa4c 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -161,15 +161,19 @@ path_conv::isgood_inode (ino_t ino) const
   return true;
 }
 
-/* Check reparse point for type.  IO_REPARSE_TAG_MOUNT_POINT types are
-   either volume mount points, which are treated as directories, or they
-   are directory mount points, which are treated as symlinks.
-   IO_REPARSE_TAG_SYMLINK types are always symlinks.  We don't know
-   anything about other reparse points, so they are treated as unknown.  */
-static inline uint8_t
-readdir_check_reparse_point (POBJECT_ATTRIBUTES attr)
+/* Check reparse point to determine if it should be treated as a posix symlink
+   or as a normal file/directory. Mount points are treated as normal directories
+   to match behavior of other systems. Unknown reparse tags are used for
+   things other than links (HSM, compression, dedup), and generally should be
+   treated as a normal file/directory. Native symlinks and mount points are
+   treated as posix symlinks, depending on the prefix of the target name.
+   This logic needs to agree with equivalent logic in path.cc
+   symlink_info::check_reparse_point() .
+   */
+static inline bool
+readdir_check_reparse_point (POBJECT_ATTRIBUTES attr, bool remote)
 {
-  uint8_t ret = DT_UNKNOWN;
+  bool ret = false;
   IO_STATUS_BLOCK io;
   HANDLE reph;
   UNICODE_STRING subst;
@@ -185,20 +189,29 @@ readdir_check_reparse_point (POBJECT_ATTRIBUTES attr)
 		      &io, FSCTL_GET_REPARSE_POINT, NULL, 0,
 		      (LPVOID) rp, MAXIMUM_REPARSE_DATA_BUFFER_SIZE)))
 	{
-	  if (rp->ReparseTag == IO_REPARSE_TAG_MOUNT_POINT)
+	  if (!remote && rp->ReparseTag == IO_REPARSE_TAG_MOUNT_POINT)
 	    {
 	      RtlInitCountedUnicodeString (&subst,
 		  (WCHAR *)((char *)rp->MountPointReparseBuffer.PathBuffer
 			    + rp->MountPointReparseBuffer.SubstituteNameOffset),
 		  rp->MountPointReparseBuffer.SubstituteNameLength);
-	      /* Only volume mountpoints are treated as directories. */
-	      if (RtlEqualUnicodePathPrefix (&subst, &ro_u_volume, TRUE))
-		ret = DT_DIR;
-	      else
-		ret = DT_LNK;
+	      if (check_reparse_point_target (&subst))
+	        ret = true;
 	    }
 	  else if (rp->ReparseTag == IO_REPARSE_TAG_SYMLINK)
-	    ret = DT_LNK;
+	    {
+	      if (rp->SymbolicLinkReparseBuffer.Flags & SYMLINK_FLAG_RELATIVE)
+		ret = true;
+	      else
+		{
+		  RtlInitCountedUnicodeString (&subst,
+		      (WCHAR *)((char *)rp->SymbolicLinkReparseBuffer.PathBuffer
+			    + rp->SymbolicLinkReparseBuffer.SubstituteNameOffset),
+		      rp->SymbolicLinkReparseBuffer.SubstituteNameLength);
+		  if (check_reparse_point_target (&subst))
+		    ret = true;
+		}
+	    }
 	  NtClose (reph);
 	}
     }
@@ -1995,8 +2008,7 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
   /* Set d_type if type can be determined from file attributes.  For .lnk
      symlinks, d_type will be reset below.  Reparse points can be NTFS
      symlinks, even if they have the FILE_ATTRIBUTE_DIRECTORY flag set. */
-  if (attr &&
-      !(attr & (~FILE_ATTRIBUTE_VALID_FLAGS | FILE_ATTRIBUTE_REPARSE_POINT)))
+  if (attr && !(attr & ~FILE_ATTRIBUTE_VALID_FLAGS))
     {
       if (attr & FILE_ATTRIBUTE_DIRECTORY)
 	de->d_type = DT_DIR;
@@ -2005,19 +2017,22 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
 	de->d_type = DT_REG;
     }
 
-  /* Check for directory reparse point. These may be treated as a posix
-     symlink, or as mount point, so need to figure out whether to return
-     a directory or link type. In all cases, returning the INO of the
-     reparse point (not of the target) matches behavior of posix systems.
+  /* Check for reparse points that can be treated as posix symlinks.
+     Mountpoints and unknown or unhandled reparse points will be treated
+     as normal file/directory/unknown. In all cases, returning the INO of
+     the reparse point (not of the target) matches behavior of posix systems.
      */
-  if ((attr & (FILE_ATTRIBUTE_DIRECTORY | FILE_ATTRIBUTE_REPARSE_POINT))
-      == (FILE_ATTRIBUTE_DIRECTORY | FILE_ATTRIBUTE_REPARSE_POINT))
+  if (attr & FILE_ATTRIBUTE_REPARSE_POINT)
     {
       OBJECT_ATTRIBUTES oattr;
 
       InitializeObjectAttributes (&oattr, fname, pc.objcaseinsensitive (),
 				  get_handle (), NULL);
-      de->d_type = readdir_check_reparse_point (&oattr);
+      /* FUTURE: Ideally would know at this point if reparse point
+         is stored on a remote volume. Without this, may return DT_LNK
+         for remote names that end up lstat-ing as a normal directory. */
+      if (readdir_check_reparse_point (&oattr, false/*remote*/))
+        de->d_type = DT_LNK;
     }
 
   /* Check for Windows shortcut. If it's a Cygwin or U/WIN symlink, drop the
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 7d1d23d72..53cbf4917 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2261,6 +2261,31 @@ symlink_info::check_sysfile (HANDLE h)
   return res;
 }
 
+bool
+check_reparse_point_target (PUNICODE_STRING subst)
+{
+  /* Native mount points, or native non-relative symbolic links,
+     can be treated as posix symlinks only if the SubstituteName
+     can be converted from a native NT object namespace name to
+     a win32 name. We only know how to convert names with two
+     prefixes :
+       "\??\UNC\..."
+       "\??\X:..."
+     Other reparse points will be treated as files or
+     directories, not as posix symlinks.
+     */
+  if (RtlEqualUnicodePathPrefix (subst, &ro_u_natp, FALSE))
+    {
+      if (subst->Length >= 6*sizeof(WCHAR) && subst->Buffer[5] == L':' &&
+          (subst->Length == 6*sizeof(WCHAR) || subst->Buffer[6] == L'\\'))
+        return true;
+      else if (subst->Length >= 8*sizeof(WCHAR) &&
+          wcsncmp (subst->Buffer + 4, L"UNC\\", 4) == 0)
+        return true;
+    }
+  return false;
+}
+
 int
 symlink_info::check_reparse_point (HANDLE h, bool remote)
 {
@@ -2299,14 +2324,24 @@ symlink_info::check_reparse_point (HANDLE h, bool remote)
       return 0;
     }
   if (rp->ReparseTag == IO_REPARSE_TAG_SYMLINK)
-    /* Windows evaluates native symlink literally.  If a remote symlink points
-       to, say, C:\foo, it will be handled as if the target is the local file
-       C:\foo.  That comes in handy since that's how symlinks are treated under
-       POSIX as well. */
-    RtlInitCountedUnicodeString (&subst,
-		  (WCHAR *)((char *)rp->SymbolicLinkReparseBuffer.PathBuffer
-			+ rp->SymbolicLinkReparseBuffer.SubstituteNameOffset),
-		  rp->SymbolicLinkReparseBuffer.SubstituteNameLength);
+    {
+      /* Windows evaluates native symlink literally.  If a remote symlink points
+         to, say, C:\foo, it will be handled as if the target is the local file
+         C:\foo.  That comes in handy since that's how symlinks are treated under
+         POSIX as well. */
+      RtlInitCountedUnicodeString (&subst,
+		    (WCHAR *)((char *)rp->SymbolicLinkReparseBuffer.PathBuffer
+			  + rp->SymbolicLinkReparseBuffer.SubstituteNameOffset),
+		    rp->SymbolicLinkReparseBuffer.SubstituteNameLength);
+      if (!(rp->SymbolicLinkReparseBuffer.Flags & SYMLINK_FLAG_RELATIVE) &&
+          !check_reparse_point_target (&subst))
+	{
+	  /* Unsupport native symlink target prefix. Not treated as symlink.
+	     The return value of -1 indicates name needs to be opened without
+	     FILE_OPEN_REPARSE_POINT flag. */
+	  return -1;
+	}
+    }
   else if (!remote && rp->ReparseTag == IO_REPARSE_TAG_MOUNT_POINT)
     {
       /* Don't handle junctions on remote filesystems as symlinks.  This type
@@ -2318,11 +2353,11 @@ symlink_info::check_reparse_point (HANDLE h, bool remote)
 		  (WCHAR *)((char *)rp->MountPointReparseBuffer.PathBuffer
 			  + rp->MountPointReparseBuffer.SubstituteNameOffset),
 		  rp->MountPointReparseBuffer.SubstituteNameLength);
-      if (RtlEqualUnicodePathPrefix (&subst, &ro_u_volume, TRUE))
+      if (!check_reparse_point_target (&subst))
 	{
-	  /* Volume mount point.  Not treated as symlink. The return
-	     value of -1 is a hint for the caller to treat this as a
-	     volume mount point. */
+	  /* Volume mount point, or unsupported native target prefix. Not
+	     treated as symlink. The return value of -1 indicates name needs
+	     to be opened without FILE_OPEN_REPARSE_POINT flag. */
 	  return -1;
 	}
     }
diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index c6b2d2bed..046892879 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -88,6 +88,7 @@ enum path_types
 };
 
 NTSTATUS file_get_fai (HANDLE, PFILE_ALL_INFORMATION);
+bool check_reparse_point_target (PUNICODE_STRING);
 
 class symlink_info;
 
-- 
2.12.2.windows.2


--------------080703070706090208020707--
