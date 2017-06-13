Return-Path: <cygwin-patches-return-8778-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119811 invoked by alias); 13 Jun 2017 18:12:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119792 invoked by uid 89); 13 Jun 2017 18:12:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail.pismotechnic.com
Received: from mail.pismotechnic.com (HELO mail.pismotechnic.com) (162.218.67.164) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 13 Jun 2017 18:12:56 +0000
Received: from [10.2.1.30] (unknown [73.240.197.175])	by mail.pismotechnic.com (Postfix) with ESMTPSA id 7735A16077A	for <cygwin-patches@cygwin.com>; Tue, 13 Jun 2017 11:12:59 -0700 (PDT)
Message-ID: <59402B22.4060001@pismotec.com>
Date: Tue, 13 Jun 2017 18:12:00 -0000
From: Joe Lowe <joe@pismotec.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:25.9) Gecko/20160412 FossaMail/25.2.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] readdir() with mount point dentry, return mount point INO
Content-Type: multipart/mixed; boundary="------------010103060600020401080504"
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00049.txt.bz2

This is a multi-part message in MIME format.
--------------010103060600020401080504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 503


This patch fixes a minor compatibility issue w/ cygwin mount point 
handling in readdir(), compared to equivalent behavior of Linux and 
MacOS. dentry.d_ino should indicate the INO of the mount point itself, 
not the target volume root folder.

Changed return type from readdir_check_reparse_point to uint8_t, to 
avoid unnecessarily being implicitly cast to and from a signed int.
	
Renamed a related local variable "attr" to "oattr" that was eclipsing a 
member variable with the same name.

Joe L.


--------------010103060600020401080504
Content-Type: text/plain; charset=windows-1252;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch.txt"
Content-length: 2436

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index bf5f988c2..f36030444 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -178,10 +178,10 @@ path_conv::isgood_inode (ino_t ino) const
    are directory mount points, which are treated as symlinks.
    IO_REPARSE_TAG_SYMLINK types are always symlinks.  We don't know
    anything about other reparse points, so they are treated as unknown.  */
-static inline int
+static inline uint8_t
 readdir_check_reparse_point (POBJECT_ATTRIBUTES attr)
 {
-  DWORD ret = DT_UNKNOWN;
+  uint8_t ret = DT_UNKNOWN;
   IO_STATUS_BLOCK io;
   HANDLE reph;
   UNICODE_STRING subst;
@@ -2016,32 +2016,19 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
 	de->d_type = DT_REG;
     }
 
-  /* Check for directory reparse point.  These are potential volume mount
-     points which have another inode than the underlying directory. */
+  /* Check for directory reparse point. These may be treated as a posix
+     symlink, or as mount point, so need to figure out whether to return
+     a directory or link type. In all cases, returning the INO of the
+     reparse point (not of the target) matches behavior of posix systems.
+     */
   if ((attr & (FILE_ATTRIBUTE_DIRECTORY | FILE_ATTRIBUTE_REPARSE_POINT))
       == (FILE_ATTRIBUTE_DIRECTORY | FILE_ATTRIBUTE_REPARSE_POINT))
     {
-      HANDLE reph;
-      OBJECT_ATTRIBUTES attr;
-      IO_STATUS_BLOCK io;
+      OBJECT_ATTRIBUTES oattr;
 
-      InitializeObjectAttributes (&attr, fname, pc.objcaseinsensitive (),
+      InitializeObjectAttributes (&oattr, fname, pc.objcaseinsensitive (),
 				  get_handle (), NULL);
-      de->d_type = readdir_check_reparse_point (&attr);
-      if (de->d_type == DT_DIR)
-	{
-	  /* Volume mountpoints are treated as directories.  We have to fix
-	     the inode number, otherwise we have the inode number of the
-	     mount point, rather than the inode number of the toplevel
-	     directory of the mounted drive. */
-	  if (NT_SUCCESS (NtOpenFile (&reph, READ_CONTROL, &attr, &io,
-				      FILE_SHARE_VALID_FLAGS,
-				      FILE_OPEN_FOR_BACKUP_INTENT)))
-	    {
-	      de->d_ino = pc.get_ino_by_handle (reph);
-	      NtClose (reph);
-	    }
-	}
+      de->d_type = readdir_check_reparse_point (&oattr);
     }
 
   /* Check for Windows shortcut. If it's a Cygwin or U/WIN symlink, drop the

--------------010103060600020401080504--
