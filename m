Return-Path: <cygwin-patches-return-3014-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21952 invoked by alias); 20 Sep 2002 23:32:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21938 invoked from network); 20 Sep 2002 23:32:23 -0000
Message-Id: <3.0.5.32.20020920192828.0080c640@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Fri, 20 Sep 2002 16:32:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Cleaning up for NULL handles
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00462.txt.bz2


The patch below takes care of the possibility that CreateFile
might return a 0 handle, in the area that I touched recently.

2002-09-20  Pierre Humblet <pierre.humblet@ieee.org>

	* dtable.cc (dtable::dup_worker): Do not NULL the io_handle
	of the child. It is copied from the parent.
	* fhandler.cc (fhandler_base::dup): If the io_handle is invalid,
	keep the value set in the parent.
	* fhandler_disk_file.cc (fhandler_disk_file::fstat): Use 
	get_open_status () instead of get_io_handle () to test if the 
	file is open.

--- dtable.cc.orig      2002-09-19 21:50:56.000000000 -0400
+++ dtable.cc   2002-09-19 21:51:28.000000000 -0400
@@ -409,7 +409,6 @@ dtable::dup_worker (fhandler_base *oldfh
 {
   fhandler_base *newfh = build_fhandler (-1, oldfh->get_device ());
   *newfh = *oldfh;
-  newfh->set_io_handle (NULL);
   if (oldfh->dup (newfh))
     {
       cfree (newfh);
--- fhandler.cc.orig    2002-09-19 22:39:34.000000000 -0400
+++ fhandler.cc 2002-09-19 22:39:50.000000000 -0400
@@ -1005,19 +1005,19 @@ fhandler_base::dup (fhandler_base *child
 {
   debug_printf ("in fhandler_base dup");
 
-  HANDLE nh;
-  if (get_nohandle ())
-    nh = INVALID_HANDLE_VALUE;
-  else if (!DuplicateHandle (hMainProc, get_handle(), hMainProc, &nh, 0,
TRUE,
-                       DUPLICATE_SAME_ACCESS))
+  if (!get_nohandle ())
     {
-      system_printf ("dup(%s) failed, handle %x, %E",
-                    get_name (), get_handle());
-      __seterrno ();
-      return -1;
+      HANDLE nh;
+      if (!DuplicateHandle (hMainProc, get_handle(), hMainProc, &nh, 0, TRUE,
+                           DUPLICATE_SAME_ACCESS))
+        {
+         system_printf ("dup(%s) failed, handle %x, %E",
+                        get_name (), get_handle());
+         __seterrno ();
+         return -1;
+       }
+      child->set_io_handle (nh);
     }
-
-  child->set_io_handle (nh);
   return 0;
 }
 
--- fhandler_disk_file.cc.orig  2002-09-19 21:49:18.000000000 -0400
+++ fhandler_disk_file.cc       2002-09-19 21:57:30.000000000 -0400
@@ -155,7 +155,7 @@ fhandler_disk_file::fstat (struct __stat
   int open_flags = O_RDONLY | O_BINARY | O_DIROPEN;
   bool query_open_already;
 
-  if (get_io_handle ())
+  if (get_open_status ())
     {
       if (get_nohandle ())
        return fstat_by_name (buf, pc);
