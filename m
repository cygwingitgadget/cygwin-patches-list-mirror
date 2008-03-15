Return-Path: <cygwin-patches-return-6297-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18004 invoked by alias); 15 Mar 2008 13:49:45 -0000
Received: (qmail 17993 invoked by uid 22791); 15 Mar 2008 13:49:43 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 15 Mar 2008 13:49:16 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JaWl8-0005wm-UH 	for cygwin-patches@cygwin.com; Sat, 15 Mar 2008 13:49:15 +0000
Message-ID: <47DBD3DA.8B718E2@dessent.net>
Date: Sat, 15 Mar 2008 13:49:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D3B079.C8BA614C@dessent.net> <20080309095109.GX18407@calimero.vinschen.de> <47D3BCAC.98C49164@dessent.net> <20080309103618.GZ18407@calimero.vinschen.de> <47D3D1CC.87E7D183@dessent.net> <20080309130342.GA18407@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------7FB67387EE6016E97F682FA8"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00071.txt.bz2

This is a multi-part message in MIME format.
--------------7FB67387EE6016E97F682FA8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1950

Corinna Vinschen wrote:

> Yuk.  I guess it would help a lot to reproduce path.cc:check_shortcut(*)
> in utils as close as possible.  Afaics it doesn't use any code which
> would be restricted to Cygwin, except for the call to
> mount_table->conv_to_posix_path in the posixify method.

I started down that road, trying to come up with a slick method for
sharing the code so that we don't need to maintain two copies.  After
poking at it for a while I came to the realization that the two are just
plumbed too differently to share code directly.  In the Cygwin code, the
"check if this is a valid symlink" and the "read its contents" are kind
of lumped together as the symlink_info class provides a convenient
location to store the data.  But in the cygcheck implementation we have
only is_symlink() and readlink(), with both take just a HANDLE and share
nothing, and no pflags to worry about, etc.

And of course there's the obvious that cygcheck has no Win32->POSIX
conversion capability which makes it hard to support reading reparse
points because readlink() is supposed to return the POSIX link target.

Anyway, the attached is the result of what happened when I started with
the Cygwin code and whittled it down.  It fixes the bug in the
grandparent of this email where it was reading the Win32 path out of a
shortcut that didn't have an ITEMIDLIST, and it supports the new-style
shortcut where the target > MAX_PATH gets stored at the end.  It does
not attempt to do anything with reparse points however.

Another factor was that the file IO in symlink_info::check_shortcut was
using the native API, which I rewrote to use the plain Win32 flavor in
case we want to keep cygcheck working on 9x/ME.  I don't think this will
matter if we want to make cygcheck support long paths though, since it's
just ReadFile, SetFilePointer, and GetFileInformationByHandle -- the
HANDLE is already open so this should require no change to support
WCHAR.

Brian
--------------7FB67387EE6016E97F682FA8
Content-Type: text/plain; charset=us-ascii;
 name="cygcheck_symlink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck_symlink.patch"
Content-length: 4035

2008-03-15  Brian Dessent  <brian@dessent.net>

	* path.cc: Include malloc.h for alloca.
	(is_symlink): Rewrite.  Just read the whole file in memory rather
	than by parts.  Account for an ITEMIDLIST if present, as well as
	the new style of Cygwin shortcut supporting targets > MAX_PATH.

 path.cc |   96 +++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 47 insertions(+), 49 deletions(-)

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/path.cc,v
retrieving revision 1.14
diff -u -p -r1.14 path.cc
--- path.cc	11 Mar 2008 17:20:02 -0000	1.14
+++ path.cc	15 Mar 2008 13:12:45 -0000
@@ -18,6 +18,7 @@ details. */
 #include <windows.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <malloc.h>
 #include "path.h"
 #include "cygwin/include/cygwin/version.h"
 #include "cygwin/include/sys/mount.h"
@@ -172,60 +173,57 @@ is_symlink (HANDLE fh)
 bool
 readlink (HANDLE fh, char *path, int maxlen)
 {
-  int got;
-  int magic = get_word (fh, 0x0);
+  DWORD rv;
+  char *buf, *cp;
+  unsigned short len;
+  win_shortcut_hdr *file_header;
+  BY_HANDLE_FILE_INFORMATION fi;
+
+  if (!GetFileInformationByHandle (fh, &fi)
+      || fi.nFileSizeHigh != 0
+      || fi.nFileSizeLow > 8192)
+    return false;
 
-  if (magic == SHORTCUT_MAGIC)
-    {
-      int offset = get_word (fh, 0x4c);
-      int slen = get_word (fh, 0x4c + offset + 2);
-      if (slen >= maxlen)
-	{
-	  SetLastError (ERROR_FILENAME_EXCED_RANGE);
-	  return false;
-	}
-      if (SetFilePointer (fh, 0x4c + offset + 4, 0, FILE_BEGIN) ==
-	  INVALID_SET_FILE_POINTER && GetLastError () != NO_ERROR)
-	return false;
+  buf = (char *) alloca (fi.nFileSizeLow + 1);
+  file_header = (win_shortcut_hdr *) buf;
 
-      if (!ReadFile (fh, path, slen, (DWORD *) &got, 0))
-	return false;
-      else if (got < slen)
-	{
-	  SetLastError (ERROR_READ_FAULT);
-	  return false;
-	}
-      else
-	path[got] = '\0';
-    }
-  else if (magic == SYMLINK_MAGIC)
+  if (SetFilePointer (fh, 0L, NULL, FILE_BEGIN) == INVALID_SET_FILE_POINTER
+      || !ReadFile (fh, buf, fi.nFileSizeLow, &rv, NULL)
+      || rv != fi.nFileSizeLow)
+    return false;
+  
+  if (fi.nFileSizeLow > sizeof (file_header)
+      && cmp_shortcut_header (file_header))
     {
-      char cookie_buf[sizeof (SYMLINK_COOKIE) - 1];
-
-      if (SetFilePointer (fh, 0, 0, FILE_BEGIN) == INVALID_SET_FILE_POINTER
-	  && GetLastError () != NO_ERROR)
-	return false;
-
-      if (!ReadFile (fh, cookie_buf, sizeof (cookie_buf), (DWORD *) &got, 0))
-	return false;
-      else if (got == sizeof (cookie_buf)
-	       && memcmp (cookie_buf, SYMLINK_COOKIE, sizeof (cookie_buf)) == 0)
-	{
-	  if (!ReadFile (fh, path, maxlen, (DWORD *) &got, 0))
-	    return false;
-	  else if (got >= maxlen)
-	    {
-	      SetLastError (ERROR_FILENAME_EXCED_RANGE);
-	      path[0] = '\0';
-	      return false;
-	    }
-	  else
-	    path[got] = '\0';
-	}
-    }
+      cp = buf + sizeof (win_shortcut_hdr);
+      if (file_header->flags & WSH_FLAG_IDLIST) /* Skip ITEMIDLIST */
+        cp += *(unsigned short *) cp + 2;
+      if (!(len = *(unsigned short *) cp))
+        return false;
+      cp += 2;
+      /* Has appended full path?  If so, use it instead of description. */
+      unsigned short relpath_len = *(unsigned short *) (cp + len);
+      if (cp + len + 2 + relpath_len < buf + fi.nFileSizeLow)
+        {
+          cp += len + 2 + relpath_len;
+          len = *(unsigned short *) cp;
+          cp += 2;
+        }
+      if (len + 1 > maxlen)
+        return false;
+      memcpy (path, cp, len);
+      path[len] = '\0';
+      return true;
+    }
+  else if (strncmp (buf, SYMLINK_COOKIE, strlen (SYMLINK_COOKIE)) == 0
+           && fi.nFileSizeLow - strlen (SYMLINK_COOKIE) <= (unsigned) maxlen
+           && buf[fi.nFileSizeLow - 1] == '\0')
+    {
+      strcpy (path, &buf[strlen (SYMLINK_COOKIE)]);
+      return true;
+    }      
   else
     return false;
-  return true;
 }
 
 typedef struct mnt

--------------7FB67387EE6016E97F682FA8--
