Return-Path: <cygwin-patches-return-6356-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7523 invoked by alias); 26 Nov 2008 21:25:25 -0000
Received: (qmail 7459 invoked by uid 22791); 26 Nov 2008 21:25:21 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout02.t-online.de (HELO mailout02.t-online.de) (194.25.134.17)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 26 Nov 2008 21:24:28 +0000
Received: from fwd08.aul.t-online.de  	by mailout02.sul.t-online.de with smtp  	id 1L5Rs0-0003lb-01; Wed, 26 Nov 2008 22:24:24 +0100
Received: from [10.3.2.2] (Vsln8rZDghrwX1f9KutolEGCzl4cqGPftMyp8KVqJVlRDiDiPCHs7GsDS0kswkxZMF@[217.235.217.36]) by fwd08.aul.t-online.de 	with esmtp id 1L5Rrs-0Aq3Wq0; Wed, 26 Nov 2008 22:24:16 +0100
Message-ID: <492DBE7E.7020100@t-online.de>
Date: Wed, 26 Nov 2008 21:25:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] Add dirent.d_type support to Cygwin 1.7 ?
Content-Type: multipart/mixed;  boundary="------------000201030405030705000606"
X-ID: Vsln8rZDghrwX1f9KutolEGCzl4cqGPftMyp8KVqJVlRDiDiPCHs7GsDS0kswkxZMF
X-TOI-MSGID: a9a2bc98-a531-44d7-ad72-6e64b550aa30
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------000201030405030705000606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 580

This is an experimental patch to add dirent.d_type support to readdir(). 
It sets d_type to DT_DIR/REG for normal disk directories/files and 
DT_UNKNOWN in all other cases.

Test result with original find (4.4.0-3) vs. same find rebuild with new 
sys/dirent.h:

$ export TIMEFORMAT='%1R'

$ time find /cygdrive/c/cygwin >/dev/null
30.5

$ time find-with-d_type /cygdrive/c/cygwin >/dev/null
9.5

$ time cmd /c dir /a/s 'c:\cygwin' >/dev/null
5.2

Due to the missing initialization of '__d_unused1', new programs with 
d_type support would not be backward compatible.


Christian


--------------000201030405030705000606
Content-Type: text/x-patch;
 name="cygwin-dirent-d_type.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-dirent-d_type.patch"
Content-length: 3704

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index 30662e6..c200469 100644
--- a/winsup/cygwin/dir.cc
+++ b/winsup/cygwin/dir.cc
@@ -93,6 +93,11 @@ readdir_worker (DIR *dir, dirent *de)
     }
 
   de->d_ino = 0;
+#ifdef _DIRENT_HAVE_D_TYPE
+  de->d_type = DT_UNKNOWN;
+#endif
+  memset (&de->__d_unused1, 0, sizeof (de->__d_unused1));
+
   int res = ((fhandler_base *) dir->__fh)->readdir (dir, de);
 
   if (res == ENMFILE)
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index e0880f0..c748e24 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1677,6 +1677,28 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
       dir->__flags &= ~dirent_set_d_ino;
     }
 
+#ifdef _DIRENT_HAVE_D_TYPE
+  /* Set d_type if type can be determined from file attributes.
+     FILE_ATTRIBUTE_SYSTEM ommitted to leave DT_UNKNOWN for old symlinks.
+     For new symlinks, d_type will be reset to DT_UNKNOWN below.  */
+  if (attr &&
+      !(attr & ~( FILE_ATTRIBUTE_NORMAL
+                | FILE_ATTRIBUTE_READONLY
+                | FILE_ATTRIBUTE_ARCHIVE
+                | FILE_ATTRIBUTE_HIDDEN
+                | FILE_ATTRIBUTE_COMPRESSED
+                | FILE_ATTRIBUTE_ENCRYPTED
+                | FILE_ATTRIBUTE_SPARSE_FILE
+                | FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
+                | FILE_ATTRIBUTE_DIRECTORY)))
+    {
+      if (attr & FILE_ATTRIBUTE_DIRECTORY)
+        de->d_type = DT_DIR;
+      else
+        de->d_type = DT_REG;
+    }
+#endif
+
   /* Check for directory reparse point.  These are potential volume mount
      points which have another inode than the underlying directory. */
   if ((attr & (FILE_ATTRIBUTE_DIRECTORY | FILE_ATTRIBUTE_REPARSE_POINT))
@@ -1728,7 +1750,12 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
 	    }
 	  path_conv fpath (&fbuf, PC_SYM_NOFOLLOW);
 	  if (fpath.issymlink () || fpath.is_fs_special ())
-	    fname->Length -= 4 * sizeof (WCHAR);
+            {
+	      fname->Length -= 4 * sizeof (WCHAR);
+#ifdef _DIRENT_HAVE_D_TYPE
+              de->d_type = DT_UNKNOWN;
+#endif
+            }
 	}
     }
 
diff --git a/winsup/cygwin/include/sys/dirent.h b/winsup/cygwin/include/sys/dirent.h
index 41bfcc1..d782e58 100644
--- a/winsup/cygwin/include/sys/dirent.h
+++ b/winsup/cygwin/include/sys/dirent.h
@@ -18,11 +18,17 @@
 
 #pragma pack(push,4)
 #if defined(__INSIDE_CYGWIN__) || defined (__CYGWIN_USE_BIG_TYPES__)
+#define _DIRENT_HAVE_D_TYPE
 struct dirent
 {
   long __d_version;			/* Used internally */
   __ino64_t d_ino;
+#ifdef _DIRENT_HAVE_D_TYPE
+  unsigned char d_type;
+  unsigned char __d_unused1[3];
+#else
   __uint32_t __d_unused1;
+#endif
   __uint32_t __d_internal1;
   char d_name[NAME_MAX + 1];
 };
@@ -36,6 +42,8 @@ struct dirent
   char d_name[NAME_MAX + 1];
 };
 #endif
+/* Compile time size check.  */
+typedef char __ASSERT_SIZEOF_dirent[sizeof(struct dirent) == 20+NAME_MAX+1 ? 1 : -1];
 #pragma pack(pop)
 
 #define __DIRENT_COOKIE 0xdede4242
@@ -77,7 +85,7 @@ int scandir (const char *__dir,
 	     int (*compar) (const struct dirent **, const struct dirent **));
 
 int alphasort (const struct dirent **__a, const struct dirent **__b);
-#if 0  /* these make no sense in the absence of d_type */
+#ifdef _DIRENT_HAVE_D_TYPE
 /* File types for `d_type'.  */
 enum
 {
@@ -104,6 +112,6 @@ enum
 /* Convert between stat structure types and directory types.  */
 # define IFTODT(mode)		(((mode) & 0170000) >> 12)
 # define DTTOIF(dirtype)        ((dirtype) << 12)
-#endif /* #if 0 */
+#endif /* _DIRENT_HAVE_D_TYPE */
 #endif /* _POSIX_SOURCE */
 #endif /*_SYS_DIRENT_H*/

--------------000201030405030705000606--
