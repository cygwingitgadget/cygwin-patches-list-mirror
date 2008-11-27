Return-Path: <cygwin-patches-return-6362-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5755 invoked by alias); 27 Nov 2008 21:43:09 -0000
Received: (qmail 5744 invoked by uid 22791); 27 Nov 2008 21:43:08 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout05.t-online.de (HELO mailout05.t-online.de) (194.25.134.82)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 27 Nov 2008 21:42:14 +0000
Received: from fwd02.aul.t-online.de  	by mailout05.sul.t-online.de with smtp  	id 1L5ocl-0005j3-02; Thu, 27 Nov 2008 22:42:11 +0100
Received: from [10.3.2.2] (Z4pDhcZcZheL2VjM+ABpZ2ejf-2DQb+6dVXHs-TV7QtASP6w-CXctobLkSpqKPAwMi@[217.235.213.153]) by fwd02.aul.t-online.de 	with esmtp id 1L5ocV-2GqtCS0; Thu, 27 Nov 2008 22:41:55 +0100
Message-ID: <492F1424.5000004@t-online.de>
Date: Thu, 27 Nov 2008 21:43:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Add dirent.d_type support to  Cygwin 1.7 ?
References: <492DBE7E.7020100@t-online.de> <20081126221012.GA15970@ednor.casa.cgf.cx> <492DD7D0.6050001@t-online.de> <20081127093023.GA9487@calimero.vinschen.de> <1L5eGn-03rme80@fwd09.aul.t-online.de> <20081127111502.GF30831@calimero.vinschen.de>
In-Reply-To: <20081127111502.GF30831@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------090300040403090608070002"
X-ID: Z4pDhcZcZheL2VjM+ABpZ2ejf-2DQb+6dVXHs-TV7QtASP6w-CXctobLkSpqKPAwMi
X-TOI-MSGID: 73f5e193-77c2-4d55-b0b5-b341417d75fc
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00006.txt.bz2

This is a multi-part message in MIME format.
--------------090300040403090608070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 953

Corinna Vinschen wrote:
> The logic sounds ok to me.  I just don't think we need a warning 
> and the condition could be simplified accordingly.
>
>   

New patch below. Conditionals removed as suggested by cgf.

Define of _DIRENT_HAVE_D_TYPE still there - google code search finds 
several projects using this instead of a ./configure check.


2008-11-27  Christian Franke  <franke@computer.org>

	* dir.cc (readdir_worker): Initialize dirent.d_type and __d_unused1.
	* fhandler_disk_file.cc (fhandler_disk_file::readdir_helper):
	Set dirent.d_type based on FILE_ATTRIBUTE_*.
	* include/sys/dirent.h: Define _DIRENT_HAVE_D_TYPE.
	(struct dirent): Add d_type. Adjust __d_unused1 size to preserve layout.
	[_DIRENT_HAVE_D_TYPE]: Enable DT_* declarations.



Christian


PS: find is not as smart as expected: 'find /path -type d' calls lstat() 
for each entry, even if d_type != DT_UNKNOWN.
So 'find /path' is 2-3 times faster than 'find /path -type d'.


--------------090300040403090608070002
Content-Type: text/x-patch;
 name="cygwin-dirent-d_type-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-dirent-d_type-2.patch"
Content-length: 2974

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index 30662e6..2b9125f 100644
--- a/winsup/cygwin/dir.cc
+++ b/winsup/cygwin/dir.cc
@@ -93,6 +93,9 @@ readdir_worker (DIR *dir, dirent *de)
     }
 
   de->d_ino = 0;
+  de->d_type = DT_UNKNOWN;
+  memset (&de->__d_unused1, 0, sizeof (de->__d_unused1));
+
   int res = ((fhandler_base *) dir->__fh)->readdir (dir, de);
 
   if (res == ENMFILE)
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index c388a13..ac7ee2e 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1677,6 +1677,20 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
       dir->__flags &= ~dirent_set_d_ino;
     }
 
+  /* Set d_type if type can be determined from file attributes.
+     FILE_ATTRIBUTE_SYSTEM ommitted to leave DT_UNKNOWN for old symlinks.
+     For new symlinks, d_type will be reset to DT_UNKNOWN below.  */
+  if (attr &&
+      !(attr & (  ~FILE_ATTRIBUTE_VALID_FLAGS
+		| FILE_ATTRIBUTE_SYSTEM
+		| FILE_ATTRIBUTE_REPARSE_POINT)))
+    {
+      if (attr & FILE_ATTRIBUTE_DIRECTORY)
+	de->d_type = DT_DIR;
+      else
+	de->d_type = DT_REG;
+    }
+
   /* Check for directory reparse point.  These are potential volume mount
      points which have another inode than the underlying directory. */
   if ((attr & (FILE_ATTRIBUTE_DIRECTORY | FILE_ATTRIBUTE_REPARSE_POINT))
@@ -1728,7 +1742,10 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
 	    }
 	  path_conv fpath (&fbuf, PC_SYM_NOFOLLOW);
 	  if (fpath.issymlink () || fpath.is_fs_special ())
-	    fname->Length -= 4 * sizeof (WCHAR);
+	    {
+	      fname->Length -= 4 * sizeof (WCHAR);
+	      de->d_type = DT_UNKNOWN;
+	    }
 	}
     }
 
diff --git a/winsup/cygwin/include/sys/dirent.h b/winsup/cygwin/include/sys/dirent.h
index 41bfcc1..451c802 100644
--- a/winsup/cygwin/include/sys/dirent.h
+++ b/winsup/cygwin/include/sys/dirent.h
@@ -18,11 +18,13 @@
 
 #pragma pack(push,4)
 #if defined(__INSIDE_CYGWIN__) || defined (__CYGWIN_USE_BIG_TYPES__)
+#define _DIRENT_HAVE_D_TYPE
 struct dirent
 {
   long __d_version;			/* Used internally */
   __ino64_t d_ino;
-  __uint32_t __d_unused1;
+  unsigned char d_type;
+  unsigned char __d_unused1[3];
   __uint32_t __d_internal1;
   char d_name[NAME_MAX + 1];
 };
@@ -77,7 +79,7 @@ int scandir (const char *__dir,
 	     int (*compar) (const struct dirent **, const struct dirent **));
 
 int alphasort (const struct dirent **__a, const struct dirent **__b);
-#if 0  /* these make no sense in the absence of d_type */
+#ifdef _DIRENT_HAVE_D_TYPE
 /* File types for `d_type'.  */
 enum
 {
@@ -104,6 +106,6 @@ enum
 /* Convert between stat structure types and directory types.  */
 # define IFTODT(mode)		(((mode) & 0170000) >> 12)
 # define DTTOIF(dirtype)        ((dirtype) << 12)
-#endif /* #if 0 */
+#endif /* _DIRENT_HAVE_D_TYPE */
 #endif /* _POSIX_SOURCE */
 #endif /*_SYS_DIRENT_H*/

--------------090300040403090608070002--
