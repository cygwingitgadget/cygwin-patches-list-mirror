Return-Path: <cygwin-patches-return-6096-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6338 invoked by alias); 20 May 2007 15:02:17 -0000
Received: (qmail 6328 invoked by uid 22791); 20 May 2007 15:02:16 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout11.sul.t-online.com (HELO mailout11.sul.t-online.com) (194.25.134.85)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 20 May 2007 15:02:13 +0000
Received: from fwd29.aul.t-online.de  	by mailout11.aul.t-online.de with smtp  	id 1HpmvC-0005ed-00; Sun, 20 May 2007 17:02:10 +0200
Received: from [10.3.2.2] (ZZMwrcZereIuDkqu2FWo4UWmU2VInkDB19M-Vz48UZfTyaJdzSwmcN@[217.235.225.179]) by fwd29.sul.t-online.de 	with esmtp id 1Hpmv3-1LwJcW0; Sun, 20 May 2007 17:02:01 +0200
Message-ID: <465062E9.4030003@t-online.de>
Date: Sun, 20 May 2007 15:02:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP]  ddrescue 1.3)
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx> <464ECCBA.3000700@portugalmail.pt> <464EE7C1.3000709@t-online.de>
In-Reply-To: <464EE7C1.3000709@t-online.de>
Content-Type: multipart/mixed;  boundary="------------020305000800070902000301"
X-ID: ZZMwrcZereIuDkqu2FWo4UWmU2VInkDB19M-Vz48UZfTyaJdzSwmcN
X-TOI-MSGID: 175f24d4-96bd-4da2-879e-c7a92d0b2915
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00042.txt.bz2

This is a multi-part message in MIME format.
--------------020305000800070902000301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 331

fhandler_dev_floppy::lseek() always clears the 60KB pre-read buffer, 
even on lseek(fd, 0, SEEK_CUR);
If a programm (like ddrescue) always calls lseek() before each read(), 
performance is poor, because the same block is read several times.

With this new version of the patch, the buffer is only cleared if necessary.

Christian


--------------020305000800070902000301
Content-Type: text/plain;
 name="cygwin-1.5.24-2-rawseek-3.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.5.24-2-rawseek-3.patch.txt"
Content-length: 1888

--- cygwin-1.5.24-2.orig/winsup/cygwin/fhandler_floppy.cc	2006-07-18 14:56:37.001000000 +0200
+++ cygwin-1.5.24-2/winsup/cygwin/fhandler_floppy.cc	2007-05-20 16:25:35.063800100 +0200
@@ -12,6 +12,7 @@ details. */
 #include "winsup.h"
 #include <sys/termios.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <winioctl.h>
 #include <asm/socket.h>
 #include <cygwin/rdevio.h>
@@ -408,8 +409,8 @@ fhandler_dev_floppy::raw_write (const vo
 _off64_t
 fhandler_dev_floppy::lseek (_off64_t offset, int whence)
 {
-  char buf[512];
   _off64_t lloffset = offset;
+  _off64_t current_pos = (_off64_t)-1;
   LARGE_INTEGER sector_aligned_offset;
   _off64_t bytes_left;
 
@@ -420,7 +421,8 @@ fhandler_dev_floppy::lseek (_off64_t off
     }
   else if (whence == SEEK_CUR)
     {
-      lloffset += get_current_position () - (devbufend - devbufstart);
+      current_pos = get_current_position ();
+      lloffset += current_pos - (devbufend - devbufstart);
       whence = SEEK_SET;
     }
 
@@ -430,6 +432,18 @@ fhandler_dev_floppy::lseek (_off64_t off
       return -1;
     }
 
+  /* If new position is in buffered range, adjust buffer and return */
+  if (devbufstart < devbufend)
+    {
+      if (current_pos == (_off64_t)-1)
+	current_pos = get_current_position ();
+      if (current_pos - devbufend <= lloffset && lloffset <= current_pos)
+	{
+	  devbufstart = devbufend - (current_pos - lloffset);
+	  return lloffset;
+	}
+    }
+
   sector_aligned_offset.QuadPart = (lloffset / bytes_per_sector)
 				   * bytes_per_sector;
   bytes_left = lloffset - sector_aligned_offset.QuadPart;
@@ -454,7 +468,9 @@ fhandler_dev_floppy::lseek (_off64_t off
   if (bytes_left)
     {
       size_t len = bytes_left;
+      char *buf = (char *) alloca (len);
       raw_read (buf, len);
+      /* TODO: return -1 on read errors ? */
     }
   return sector_aligned_offset.QuadPart + bytes_left;
 }

--------------020305000800070902000301--
