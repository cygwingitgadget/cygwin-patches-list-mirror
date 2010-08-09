Return-Path: <cygwin-patches-return-7060-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14709 invoked by alias); 9 Aug 2010 06:22:59 -0000
Received: (qmail 14692 invoked by uid 22791); 9 Aug 2010 06:22:57 -0000
X-SWARE-Spam-Status: No, hits=-50.7 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,TW_CP,TW_FP,TW_MV,TW_UF
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 09 Aug 2010 06:22:51 +0000
Received: by yxk30 with SMTP id 30so3598925yxk.2        for <cygwin-patches@cygwin.com>; Sun, 08 Aug 2010 23:22:49 -0700 (PDT)
Received: by 10.100.197.4 with SMTP id u4mr17272260anf.17.1281334969722;        Sun, 08 Aug 2010 23:22:49 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id r7sm7905368anb.15.2010.08.08.23.22.48        (version=SSLv3 cipher=RC4-MD5);        Sun, 08 Aug 2010 23:22:49 -0700 (PDT)
Subject: [PATCH] implement /proc/filesystems
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-PMveFJn1R+WpocyMrWWf"
Date: Mon, 09 Aug 2010 06:22:00 -0000
Message-ID: <1281334969.6576.8.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00020.txt.bz2


--=-PMveFJn1R+WpocyMrWWf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 780

This patch implements /proc/filesystems:

$ cat /proc/filesystems
        vfat
        ntfs
nodev   smbfs
nodev   nfs
nodev   netapp
        iso9660
        udf
nodev   csc-cache
nodev   sunwnfs
nodev   unixfs
nodev   mvfs
nodev   cifs
nodev   nwfs

(Actual indentation is tabs, not spaces, as on Linux.)

"nodev" is meant to indicate that the filesystem does not represent a
block device[1].  While I tried to base this on Linux as best I could
figure out from web searches, it's very possible that I misjudged some
of these FS types.

I'll follow up with a patch to new-features.sgml later (my pending
CLOCK_MONOTONIC patch currently conflicts with that).


Yaakov

[1]
http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/en-US/Reference_Guide/s2-proc-filesystems.html


--=-PMveFJn1R+WpocyMrWWf
Content-Disposition: attachment; filename="winsup-proc-filesystems.patch"
Content-Type: text/x-patch; name="winsup-proc-filesystems.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 4197

2010-08-08  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* fhandler_proc.cc: Add /proc/filesystems virtual file.
	(format_proc_filesystems): New function.
	* mount.cc (fs_names): Move to global scope. Redefine as array
	of { "name", block_device? } structs.
	(fillout_mntent): Use name member of fs_names.
	* mount.h (fs_names): New prototype.

Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.89
diff -u -r1.89 fhandler_proc.cc
--- fhandler_proc.cc	12 Mar 2010 23:13:47 -0000	1.89
+++ fhandler_proc.cc	9 Aug 2010 05:00:16 -0000
@@ -28,6 +28,7 @@
 #include <winioctl.h>
 #include <wchar.h>
 #include "cpuid.h"
+#include "mount.h"
 
 #define _COMPILING_NEWLIB
 #include <dirent.h>
@@ -41,6 +42,7 @@
 static _off64_t format_proc_partitions (void *, char *&);
 static _off64_t format_proc_self (void *, char *&);
 static _off64_t format_proc_mounts (void *, char *&);
+static _off64_t format_proc_filesystems (void *, char *&);
 
 /* names of objects in /proc */
 static const virt_tab_t proc_tab[] = {
@@ -59,6 +61,7 @@
   { "registry32", FH_REGISTRY,	virt_directory,	NULL },
   { "registry64", FH_REGISTRY,	virt_directory,	NULL },
   { "net",	  FH_PROCNET,	virt_directory,	NULL },
+  { "filesystems", FH_PROC,	virt_file,	format_proc_filesystems },
   { NULL,	  0,		virt_none,	NULL }
 };
 
@@ -1220,4 +1223,22 @@
   return __small_sprintf (destbuf, "self/mounts");
 }
 
+static _off64_t
+format_proc_filesystems (void *, char *&destbuf)
+{
+  tmp_pathbuf tp;
+  char *buf = tp.c_get ();
+  char *bufptr = buf;
+
+  /* start at 1 to skip type "none" */
+  for (int i = 1; fs_names[i].name; i++)
+    bufptr += __small_sprintf(bufptr, "%s\t%s\n",
+                              fs_names[i].block_device ? "" : "nodev",
+                              fs_names[i].name);
+
+  destbuf = (char *) crealloc_abort (destbuf, bufptr - buf);
+  memcpy (destbuf, buf, bufptr - buf);
+  return bufptr - buf;
+}
+
 #undef print
Index: mount.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mount.cc,v
retrieving revision 1.61
diff -u -r1.61 mount.cc
--- mount.cc	29 Apr 2010 10:38:04 -0000	1.61
+++ mount.cc	9 Aug 2010 05:00:17 -0000
@@ -1472,6 +1472,24 @@
 
 /************************* mount_item class ****************************/
 
+/* Order must be identical to mount.h, enum fs_info_type. */
+fs_names_t fs_names[] = {
+    { "none", false },
+    { "vfat", true },
+    { "ntfs", true },
+    { "smbfs", false },
+    { "nfs", false },
+    { "netapp", false },
+    { "iso9660", true },
+    { "udf", true },
+    { "csc-cache", false },
+    { "sunwnfs", false },
+    { "unixfs", false },
+    { "mvfs", false },
+    { "cifs", false },
+    { "nwfs", false }
+};
+
 static mntent *
 fillout_mntent (const char *native_path, const char *posix_path, unsigned flags)
 {
@@ -1509,26 +1527,8 @@
     RtlAppendUnicodeToString (&unat, L"\\");
   mntinfo.update (&unat, NULL);
 
-  /* Order must be identical to mount.h, enum fs_info_type. */
-  const char *fs_names[] = {
-    "none",
-    "vfat",
-    "ntfs",
-    "smbfs",
-    "nfs",
-    "netapp",
-    "iso9660",
-    "udf",
-    "csc-cache",
-    "sunwnfs",
-    "unixfs",
-    "mvfs",
-    "cifs",
-    "nwfs"
-  };
-
   if (mntinfo.what_fs () > 0 && mntinfo.what_fs () < max_fs_type)
-    strcpy (_my_tls.locals.mnt_type, fs_names[mntinfo.what_fs ()]);
+    strcpy (_my_tls.locals.mnt_type, fs_names[mntinfo.what_fs ()].name);
   else
     strcpy (_my_tls.locals.mnt_type, mntinfo.fsname ());
 
Index: mount.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mount.h,v
retrieving revision 1.13
diff -u -r1.13 mount.h
--- mount.h	26 Apr 2010 13:48:03 -0000	1.13
+++ mount.h	9 Aug 2010 05:00:17 -0000
@@ -32,6 +32,11 @@
   max_fs_type
 };
 
+extern struct fs_names_t {
+    const char *name;
+    bool block_device;
+} fs_names[];
+
 #define IMPLEMENT_FS_FLAG(func, flag) \
   bool func (bool val) { if (val) status.fs_type = flag; return val; } \
   bool func () const   { return status.fs_type == flag; }

--=-PMveFJn1R+WpocyMrWWf--
