Return-Path: <cygwin-patches-return-6357-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29478 invoked by alias); 26 Nov 2008 22:11:22 -0000
Received: (qmail 29468 invoked by uid 22791); 26 Nov 2008 22:11:21 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-71-97.bstnma.fios.verizon.net (HELO cgf.cx) (96.233.71.97)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 26 Nov 2008 22:10:23 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 1D1F313C026 	for <cygwin-patches@cygwin.com>; Wed, 26 Nov 2008 17:10:13 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 0D8292C410F; Wed, 26 Nov 2008 17:10:13 -0500 (EST)
Date: Wed, 26 Nov 2008 22:11:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Add dirent.d_type support to Cygwin 1.7 ?
Message-ID: <20081126221012.GA15970@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <492DBE7E.7020100@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492DBE7E.7020100@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00001.txt.bz2

On Wed, Nov 26, 2008 at 10:24:14PM +0100, Christian Franke wrote:
> This is an experimental patch to add dirent.d_type support to readdir(). It 
> sets d_type to DT_DIR/REG for normal disk directories/files and DT_UNKNOWN 
> in all other cases.
>
> Test result with original find (4.4.0-3) vs. same find rebuild with new 
> sys/dirent.h:
>
> $ export TIMEFORMAT='%1R'
>
> $ time find /cygdrive/c/cygwin >/dev/null
> 30.5
>
> $ time find-with-d_type /cygdrive/c/cygwin >/dev/null
> 9.5
>
> $ time cmd /c dir /a/s 'c:\cygwin' >/dev/null
> 5.2
>
> Due to the missing initialization of '__d_unused1', new programs with 
> d_type support would not be backward compatible.
>
>
> Christian
>

>diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
>index 30662e6..c200469 100644
>--- a/winsup/cygwin/dir.cc
>+++ b/winsup/cygwin/dir.cc
>@@ -93,6 +93,11 @@ readdir_worker (DIR *dir, dirent *de)
>     }
> 
>   de->d_ino = 0;
>+#ifdef _DIRENT_HAVE_D_TYPE
>+  de->d_type = DT_UNKNOWN;
>+#endif
>+  memset (&de->__d_unused1, 0, sizeof (de->__d_unused1));
>+

I don't see a need for a conditional here.  If this is added Cygwin
supports d_type.

>   int res = ((fhandler_base *) dir->__fh)->readdir (dir, de);
> 
>   if (res == ENMFILE)
>diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
>index e0880f0..c748e24 100644
>--- a/winsup/cygwin/fhandler_disk_file.cc
>+++ b/winsup/cygwin/fhandler_disk_file.cc
>@@ -1677,6 +1677,28 @@ fhandler_disk_file::readdir_helper (DIR *dir, dirent *de, DWORD w32_err,
>       dir->__flags &= ~dirent_set_d_ino;
>     }
> 
>+#ifdef _DIRENT_HAVE_D_TYPE
>+  /* Set d_type if type can be determined from file attributes.
>+     FILE_ATTRIBUTE_SYSTEM ommitted to leave DT_UNKNOWN for old symlinks.
>+     For new symlinks, d_type will be reset to DT_UNKNOWN below.  */
>+  if (attr &&
>+      !(attr & ~( FILE_ATTRIBUTE_NORMAL
>+                | FILE_ATTRIBUTE_READONLY
>+                | FILE_ATTRIBUTE_ARCHIVE
>+                | FILE_ATTRIBUTE_HIDDEN
>+                | FILE_ATTRIBUTE_COMPRESSED
>+                | FILE_ATTRIBUTE_ENCRYPTED
>+                | FILE_ATTRIBUTE_SPARSE_FILE
>+                | FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
>+                | FILE_ATTRIBUTE_DIRECTORY)))
>+    {
>+      if (attr & FILE_ATTRIBUTE_DIRECTORY)
>+        de->d_type = DT_DIR;
>+      else
>+        de->d_type = DT_REG;
>+    }
>+#endif
>+

This is just checking all of the Windows types but none of the Cygwin
types.  Shouldn't it be checking for devices, fifos, and symlinks?
>diff --git a/winsup/cygwin/include/sys/dirent.h b/winsup/cygwin/include/sys/dirent.h
>index 41bfcc1..d782e58 100644
>--- a/winsup/cygwin/include/sys/dirent.h
>+++ b/winsup/cygwin/include/sys/dirent.h
>@@ -18,11 +18,17 @@
> 
> #pragma pack(push,4)
> #if defined(__INSIDE_CYGWIN__) || defined (__CYGWIN_USE_BIG_TYPES__)
>+#define _DIRENT_HAVE_D_TYPE
> struct dirent
> {
>   long __d_version;			/* Used internally */
>   __ino64_t d_ino;
>+#ifdef _DIRENT_HAVE_D_TYPE
>+  unsigned char d_type;
>+  unsigned char __d_unused1[3];
>+#else
>   __uint32_t __d_unused1;
>+#endif

There is even less reason to define and use _DIRENT_HAVE_D_TYPE here.

Why not just define d_type as a __uint32_t?  We don't need to keep the
__d_unused1 around.

cgf
