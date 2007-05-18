Return-Path: <cygwin-patches-return-6088-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15439 invoked by alias); 18 May 2007 19:02:36 -0000
Received: (qmail 15421 invoked by uid 22791); 18 May 2007 19:02:34 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout10.sul.t-online.com (HELO mailout10.sul.t-online.com) (194.25.134.21)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 18 May 2007 19:02:28 +0000
Received: from fwd26.aul.t-online.de  	by mailout10.sul.t-online.com with smtp  	id 1Hp7iY-000636-00; Fri, 18 May 2007 21:02:22 +0200
Received: from [10.3.2.2] (SyJMgYZrge1GxS91gszJhzapaE1t8M4fyTudg1bcLlRlq3v1Aayu4M@[217.235.243.100]) by fwd26.sul.t-online.de 	with esmtp id 1Hp7iM-0OxKCW0; Fri, 18 May 2007 21:02:10 +0200
Message-ID: <464DF837.6020304@t-online.de>
Date: Fri, 18 May 2007 19:02:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP] ddrescue  1.3)
Content-Type: multipart/mixed;  boundary="------------010505050505060906050807"
X-ID: SyJMgYZrge1GxS91gszJhzapaE1t8M4fyTudg1bcLlRlq3v1Aayu4M
X-TOI-MSGID: 329cc1e1-1733-4416-bf04-51549dc6a83c
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00034.txt.bz2

This is a multi-part message in MIME format.
--------------010505050505060906050807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 631

Hi,

Cygwin 1.5.24-2 segfaults on unaligned lseek() on raw block devices with 
sector size >512 bytes.

Testcases:
$ dd skip=1000 bs=2047 if=/dev/scd0 of=/dev/null

$ ddrescue -c 1 /dev/scd0 file.iso


This is due to a fixed 512 byte buffer in fhandler_dev_floppy::lseek().
It is still present in HEAD revision.

The attached patch should fix. It should work for any sector size.
(Smoke-)tested with 1.5.24-2 (too busy to test with current CVS, sorry).

2007-05-18  Christian Franke <franke@computer.org>

	* fhandler_floppy.cc (fhandler_dev_floppy::lseek): Fixed segfault on
	unaligned seek due to fixed size buffer.


Christian


--------------010505050505060906050807
Content-Type: text/plain;
 name="cygwin-1.5.24-2-rawseek.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.5.24-2-rawseek.patch.txt"
Content-length: 961

--- cygwin-1.5.24-2.orig/winsup/cygwin/fhandler_floppy.cc	2006-07-18 14:56:37.001000000 +0200
+++ cygwin-1.5.24-2/winsup/cygwin/fhandler_floppy.cc	2007-05-18 19:53:07.468750000 +0200
@@ -12,6 +12,7 @@ details. */
 #include "winsup.h"
 #include <sys/termios.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <winioctl.h>
 #include <asm/socket.h>
 #include <cygwin/rdevio.h>
@@ -408,7 +409,6 @@ fhandler_dev_floppy::raw_write (const vo
 _off64_t
 fhandler_dev_floppy::lseek (_off64_t offset, int whence)
 {
-  char buf[512];
   _off64_t lloffset = offset;
   LARGE_INTEGER sector_aligned_offset;
   _off64_t bytes_left;
@@ -454,7 +454,14 @@ fhandler_dev_floppy::lseek (_off64_t off
   if (bytes_left)
     {
       size_t len = bytes_left;
+      char *buf = (char *) malloc (len);
+      if (!buf)
+	{
+	  set_errno (ENOMEM);
+	  return -1;
+	}
       raw_read (buf, len);
+      free(buf);
     }
   return sector_aligned_offset.QuadPart + bytes_left;
 }


--------------010505050505060906050807--
