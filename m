Return-Path: <cygwin-patches-return-5846-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16727 invoked by alias); 8 May 2006 14:43:05 -0000
Received: (qmail 16704 invoked by uid 22791); 8 May 2006 14:43:04 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout05.sul.t-online.com (HELO mailout05.sul.t-online.com) (194.25.134.82)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 08 May 2006 14:42:38 +0000
Received: from fwd30.aul.t-online.de  	by mailout05.sul.t-online.com with smtp  	id 1Fd6wU-0001Fw-01; Mon, 08 May 2006 16:42:34 +0200
Received: from [10.3.2.2] (JOyJEZZeYeQiqc+0jDwjKz3NBF-p+wi21nHQLM5X-UqXcK03yLyT0P@[80.137.117.231]) by fwd30.sul.t-online.de 	with esmtp id 1Fd6wH-1iaeOG0; Mon, 8 May 2006 16:42:21 +0200
Message-ID: <445F58D3.3050509@t-online.de>
Date: Mon, 08 May 2006 14:43:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [Patch] Adding ".." may not work in readdir()
Content-Type: multipart/mixed;  boundary="------------050708010003060908060604"
X-ID: JOyJEZZeYeQiqc+0jDwjKz3NBF-p+wi21nHQLM5X-UqXcK03yLyT0P
X-TOI-MSGID: 0ec38eb8-5b31-4539-aea2-035162636624
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00034.txt.bz2

This is a multi-part message in MIME format.
--------------050708010003060908060604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 211

Both else-if conditions at the end of readdir() are identical, so ".." 
case will never be executed.

The attached patch for fhandler_disk_file.cc 1.183 may fix this
(untested blind patch, sorry ;-)

Christian


--------------050708010003060908060604
Content-Type: text/plain;
 name="fhandler_disk_file.cc-1.183-patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fhandler_disk_file.cc-1.183-patch.txt"
Content-length: 996

--- fhandler_disk_file.cc.orig	2006-05-08 16:21:46.984375000 +0200
+++ fhandler_disk_file.cc	2006-05-08 16:25:08.609375000 +0200
@@ -1778,25 +1778,25 @@ fhandler_disk_file::readdir (DIR *dir, d
 
   if (!(res = readdir_helper (dir, de, RtlNtStatusToDosError (status),
 			      buf ? buf->FileAttributes : 0, fname)))
     dir->__d_position++;
   else if (!(dir->__flags & dirent_saw_dot))
     {
       strcpy (de->d_name , ".");
       de->d_ino = readdir_get_ino_by_handle (dir->__handle);
       dir->__d_position++;
       dir->__flags |= dirent_saw_dot;
       res = 0;
     }
-  else if (!(dir->__flags & dirent_saw_dot))
+  else if (!(dir->__flags & dirent_saw_dot_dot))
     {
       strcpy (de->d_name , "..");
       de->d_ino = readdir_get_ino (dir, pc.normalized_path, true);
       dir->__d_position++;
       dir->__flags |= dirent_saw_dot_dot;
       res = 0;
     }
 
   syscall_printf ("%d = readdir (%p, %p) (%s)", res, dir, &de, res ? "***" : de->d_name);
   return res;
 }
 

--------------050708010003060908060604--
