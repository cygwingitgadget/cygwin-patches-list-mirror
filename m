Return-Path: <cygwin-patches-return-8775-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92376 invoked by alias); 9 Jun 2017 22:44:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89538 invoked by uid 89); 9 Jun 2017 22:44:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_PASS autolearn=ham version=3.3.2 spammy=junction, Volume, H*r:10.2.1, (unknown)
X-HELO: mail.pismotechnic.com
Received: from mail.pismotechnic.com (HELO mail.pismotechnic.com) (162.218.67.164) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 09 Jun 2017 22:44:32 +0000
Received: from [10.2.1.30] (c-73-240-197-175.hsd1.or.comcast.net [73.240.197.175])	by mail.pismotechnic.com (Postfix) with ESMTPSA id BD11A160DCC	for <cygwin-patches@cygwin.com>; Fri,  9 Jun 2017 15:44:34 -0700 (PDT)
Message-ID: <593B24DD.10209@pismotec.com>
Date: Fri, 09 Jun 2017 22:44:00 -0000
From: Joe Lowe <joe@pismotec.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:25.9) Gecko/20160412 FossaMail/25.2.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Compatibility improvement to reparse point handling, v2
Content-Type: multipart/mixed; boundary="------------040608020601030808030507"
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00046.txt.bz2

This is a multi-part message in MIME format.
--------------040608020601030808030507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 871

2nd pass at reparse point handling patch.

Patch is intended to improve cygwin application compatibility with 
native mount points and native symlinks where target does not begin with 
"\??\X:" or "\??\UNC" or "\??\Volume{". Such symlinks function with 
native windows apps, but fail today with cygwin apps due to cygwin 
converting them into posix symlinks with non-working targets. The 
general change is for cygwin to check for supported target prefixes and 
treat outliers as normal directories. This is basically an extension of 
what is done today for volume mount points.

Please reference initial post for more info:
https://cygwin.com/ml/cygwin-developers/2017-04/msg00000.html

This version includes:
1. Fix some style and consistency issues.
2. Additional modifications to make sure that readdir() and stat() agree 
on which reparse points are posix symlinks.

--------------040608020601030808030507
Content-Type: text/plain; charset=windows-1252;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch.txt"
Content-length: 12180

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index bf5f988c2..b83d51f14 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -173,15 +173,13 @@ path_conv::isgood_inode (ino_t ino) const
   return true;
 }
 
-/* Check reparse point for type.  IO_REPARSE_TAG_MOUNT_POINT types are
-   either volume mount points, which are treated as directories, or they
-   are directory mount points, which are treated as symlinks.
-   IO_REPARSE_TAG_SYMLINK types are always symlinks.  We don't know
-   anything about other reparse points, so they are treated as unknown.  */
+/* Check reparse point to determine if it should be treated as a posix symlink
+   or as a normal directory.
+   */
 static inline int
 readdir_check_reparse_point (POBJECT_ATTRIBUTES attr)
 {
-  DWORD ret = DT_UNKNOWN;
+  int ret = DT_UNKNOWN;
   IO_STATUS_BLOCK io;
   HANDLE reph;
   UNICODE_STRING subst;
@@ -197,20 +195,11 @@ readdir_check_reparse_point (POBJECT_ATTRIBUTES attr)
 		      &io, FSCTL_GET_REPARSE_POINT, NULL, 0,
 		      (LPVOID) rp, MAXIMUM_REPARSE_DATA_BUFFER_SIZE)))
 	{
-	  if (rp->ReparseTag == IO_REPARSE_TAG_MOUNT_POINT)
-	    {
-	      RtlInitCountedUnicodeString (&subst,
-		  (WCHAR *)((char *)rp->MountPointReparseBuffer.PathBuffer
-			    + rp->MountPointReparseBuffer.SubstituteNameOffset),
-		  rp->MountPointReparseBuffer.SubstituteNameLength);
-	      /* Only volume mountpoints are treated as directories. */
-	      if (RtlEqualUnicodePathPrefix (&subst, &ro_u_volume, TRUE))
-		ret = DT_DIR;
-	      else
-		ret = DT_LNK;
-	    }
-	  else if (rp->ReparseTag == IO_REPARSE_TAG_SYMLINK)
-	    ret = DT_LNK;
+	  /* Need to agree with path_conv, so use common helper logic.
+	     */
+	  ret = get_reparse_point_type (rp, false/*remote*/, &subst);
+	  if (ret == DT_UNKNOWN)
+	    ret = DT_DIR;
 	  NtClose (reph);
 	}
     }
@@ -2027,13 +2016,23 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
 
       InitializeObjectAttributes (&attr, fname, pc.objcaseinsensitive (),
 				  get_handle (), NULL);
-      de->d_type = readdir_check_reparse_point (&attr);
-      if (de->d_type == DT_DIR)
+      switch (readdir_check_reparse_point (&attr))
 	{
-	  /* Volume mountpoints are treated as directories.  We have to fix
-	     the inode number, otherwise we have the inode number of the
-	     mount point, rather than the inode number of the toplevel
-	     directory of the mounted drive. */
+	case DT_LNK:
+	  de->d_type = DT_LNK;
+	  break;
+	case DT_UNKNOWN:
+	  /* Unknown reparse point type: HSM, dedup, compression, ...
+	     Treat as normal directory. */
+	  de->d_type = DT_DIR;
+	  break;
+	default:
+	  /* Volume mount points and some mount point and native symlink
+	     reparse points are treated as normal directories. We have to
+	     fix the inode number, otherwise we have the inode number of
+	     the mount point, rather than the inode number of the
+	     symlink target. */
+	  de->d_type = DT_DIR;
 	  if (NT_SUCCESS (NtOpenFile (&reph, READ_CONTROL, &attr, &io,
 				      FILE_SHARE_VALID_FLAGS,
 				      FILE_OPEN_FOR_BACKUP_INTENT)))
@@ -2041,6 +2040,7 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
 	      de->d_ino = pc.get_ino_by_handle (reph);
 	      NtClose (reph);
 	    }
+	  break;
 	}
     }
 
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 7d1d23d72..cd62355d7 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2261,6 +2261,86 @@ symlink_info::check_sysfile (HANDLE h)
   return res;
 }
 
+static bool
+check_reparse_point_target (PUNICODE_STRING subst)
+{
+  /* Native junction reparse points, or native non-relative
+     symbolic links, can be treated as posix symlinks only
+     if the SubstituteName can be converted from a native NT
+     object namespace name to a win32 name. We only know how
+     to convert names with two prefixes :
+       "\??\UNC\..."
+       "\??\X:..."
+     Other reparse points will be treated as files or
+     directories, not as posix symlinks. Possible values
+     include:
+       "\??\Volume{..."
+       "\Device\HarddiskVolume1\..."
+       "\Device\Lanman\...\..."
+     */
+  if (RtlEqualUnicodePathPrefix( subst, &ro_u_uncp, TRUE))
+    {
+      return true;
+    }
+  else if (RtlEqualUnicodePathPrefix (subst, &ro_u_natp, TRUE) &&
+      subst->Length >= 6*sizeof(WCHAR) && subst->Buffer[5] == ':' &&
+      (subst->Length == 6*sizeof(WCHAR) || subst->Buffer[6] == '\\'))
+    {
+      return true;
+    }
+  return false;
+}
+
+int
+get_reparse_point_type (PREPARSE_DATA_BUFFER rp, bool remote, PUNICODE_STRING subst)
+{
+  if (rp->ReparseTag == IO_REPARSE_TAG_SYMLINK)
+    {
+      /* Windows evaluates native symlink literally.  If a remote symlink
+         points to, say, C:\foo, it will be handled as if the target is the
+         local file C:\foo.  That comes in handy since that's how symlinks
+         are treated under POSIX as well. */
+      RtlInitCountedUnicodeString (subst,
+		  (WCHAR *)((char *)rp->SymbolicLinkReparseBuffer.PathBuffer
+			+ rp->SymbolicLinkReparseBuffer.SubstituteNameOffset),
+		  rp->SymbolicLinkReparseBuffer.SubstituteNameLength);
+      /* Native symlinks are treated as posix symlinks if relative or if the
+         target has a prefix that we know how to deal with.
+         */
+      if ((rp->SymbolicLinkReparseBuffer.Flags & SYMLINK_FLAG_RELATIVE) ||
+          check_reparse_point_target (subst))
+        return DT_LNK;
+    }
+  else if (rp->ReparseTag == IO_REPARSE_TAG_MOUNT_POINT)
+    {
+      RtlInitCountedUnicodeString (subst,
+		  (WCHAR *)((char *)rp->MountPointReparseBuffer.PathBuffer
+			  + rp->MountPointReparseBuffer.SubstituteNameOffset),
+		  rp->MountPointReparseBuffer.SubstituteNameLength);
+      /* Don't handle junctions on remote filesystems as symlinks.  This type
+         of reparse point is handled transparently by the OS so that the
+         target of the junction is the remote directory it is supposed to
+         point to.  If we handle it as symlink, it will be mistreated as
+         pointing to a dir on the local system. */
+      if (remote)
+        return DT_DIR;
+      /* Native mount points are treated as posix symlinks only if
+         the target has a prefix that does not indicate a volume
+         mount point and that we know how to deal with.
+         */
+      if (check_reparse_point_target (subst))
+        return DT_LNK;
+    }
+  else
+    {
+      /* Maybe it's a reparse point, but it's certainly not one we recognize.
+         */
+      memset (subst, 0, sizeof (*subst));
+      return DT_UNKNOWN;
+    }
+  return DT_DIR;
+}
+
 int
 symlink_info::check_reparse_point (HANDLE h, bool remote)
 {
@@ -2298,41 +2378,23 @@ symlink_info::check_reparse_point (HANDLE h, bool remote)
 	set_error (EIO);
       return 0;
     }
-  if (rp->ReparseTag == IO_REPARSE_TAG_SYMLINK)
-    /* Windows evaluates native symlink literally.  If a remote symlink points
-       to, say, C:\foo, it will be handled as if the target is the local file
-       C:\foo.  That comes in handy since that's how symlinks are treated under
-       POSIX as well. */
-    RtlInitCountedUnicodeString (&subst,
-		  (WCHAR *)((char *)rp->SymbolicLinkReparseBuffer.PathBuffer
-			+ rp->SymbolicLinkReparseBuffer.SubstituteNameOffset),
-		  rp->SymbolicLinkReparseBuffer.SubstituteNameLength);
-  else if (!remote && rp->ReparseTag == IO_REPARSE_TAG_MOUNT_POINT)
+  switch (get_reparse_point_type (rp, remote, &subst))
     {
-      /* Don't handle junctions on remote filesystems as symlinks.  This type
-	 of reparse point is handled transparently by the OS so that the
-	 target of the junction is the remote directory it is supposed to
-	 point to.  If we handle it as symlink, it will be mistreated as
-	 pointing to a dir on the local system. */
-      RtlInitCountedUnicodeString (&subst,
-		  (WCHAR *)((char *)rp->MountPointReparseBuffer.PathBuffer
-			  + rp->MountPointReparseBuffer.SubstituteNameOffset),
-		  rp->MountPointReparseBuffer.SubstituteNameLength);
-      if (RtlEqualUnicodePathPrefix (&subst, &ro_u_volume, TRUE))
-	{
-	  /* Volume mount point.  Not treated as symlink. The return
-	     value of -1 is a hint for the caller to treat this as a
-	     volume mount point. */
-	  return -1;
-	}
-    }
-  else
-    {
-      /* Maybe it's a reparse point, but it's certainly not one we recognize.
-	 Drop REPARSE attribute so we don't try to use the flag accidentally.
-	 It's just some arbitrary file or directory for us. */
-      fileattr &= ~FILE_ATTRIBUTE_REPARSE_POINT;
+    default:
+      /* Reparse point was a volume mount point or had a target that
+         can not be treated as a posix symlink, so treat as a normal
+         directory. Return -1 to indicate file information needs to
+         be queried using a file handle opened without
+         FILE_OPEN_REPARSE_POINT, so will reflect the target instead
+         of the reparse point itself.
+         */
+      return -1;
+    case DT_UNKNOWN:
+      /* Unknown reparse point type: HSM, dedup, compression, ...
+         Treat as normal directory. */
       return 0;
+    case DT_LNK:
+      break;
     }
   sys_wcstombs (srcbuf, SYMLINK_MAX + 7, subst.Buffer,
 		subst.Length / sizeof (WCHAR));
@@ -2397,6 +2459,17 @@ symlink_info::posixify (char *srcbuf)
      The above rules are used exactly the same way on Cygwin specific symlinks
      (sysfiles and shortcuts) to eliminate non-POSIX paths in the output. */
 
+  /* The following logic should use the relative flag from native NT symbolic
+     link reparse data. This logic functions without the flag because it makes
+     the following assumptions:
+     1) Relative symlink targets never start with "\??\".
+     2) Absolute symlink and junction targets always start with "\??\".
+     The first assumption, though arguably wrong, is unlikely to cause
+     issues since '?' characters are illegal on windows file systems.
+     The second assumption is incorrect and would cause compatibility
+     issues, but code in check_reparse_point() above makes sure the non-
+     conformers do not make it here. */
+
   /* Eliminate native NT prefixes. */
   if (srcbuf[0] == '\\' && !strncmp (srcbuf + 1, "??\\", 3))
     {
@@ -2944,22 +3017,25 @@ restart:
 		&= ~FILE_ATTRIBUTE_DIRECTORY;
 	      break;
 	    }
-	  else
+	  else if (res == -1)
 	    {
-	      /* Volume moint point or unrecognized reparse point type.
+	      /* Volume moint point or unhandled reparse point.
 		 Make sure the open handle is not used in later stat calls.
 		 The handle has been opened with the FILE_OPEN_REPARSE_POINT
 		 flag, so it's a handle to the reparse point, not a handle
-		 to the volumes root dir. */
+		 to the reparse point target. */
 	      pflags &= ~PC_KEEP_HANDLE;
-	      /* Volume mount point:  The filesystem information for the top
-		 level directory should be for the volume top level directory,
-		 rather than for the reparse point itself.  So we fetch the
-		 filesystem information again, but with a NULL handle.
-		 This does what we want because fs_info::update opens the
-		 handle without FILE_OPEN_REPARSE_POINT. */
-	      if (res == -1)
-		fs.update (&upath, NULL);
+	      /* The filesystem information should be for the target of
+		 the reparse point rather than for the reparse point itself.
+		 So we fetch the filesystem information again, but with a
+		 NULL handle. This does what we want because fs_info::update
+		 opens the handle without FILE_OPEN_REPARSE_POINT. */
+	      fs.update (&upath, NULL);
+	    }
+	  else
+	    {
+	      /* Unknown reparse point type: HSM, dedup, compression, ...
+	         Treat as normal directory. */
 	    }
 	}
 
diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index c6b2d2bed..c50016fb6 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -405,6 +405,8 @@ class path_conv
   char *modifiable_path () {return (char *) path;}
 };
 
+int get_reparse_point_type (PREPARSE_DATA_BUFFER, bool remote, PUNICODE_STRING subst);
+
 /* Symlink marker */
 #define SYMLINK_COOKIE "!<symlink>"
 

--------------040608020601030808030507--
