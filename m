Return-Path: <cygwin-patches-return-2997-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14821 invoked by alias); 19 Sep 2002 02:06:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14807 invoked from network); 19 Sep 2002 02:06:53 -0000
Message-Id: <3.0.5.32.20020918220225.00810100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 18 Sep 2002 19:06:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: More changes about open on Win95 directories.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00445.txt.bz2

Running more complicated tests around my changes of yesterday, I can produce
the following system_printf by doing close on exec's and then forking:

 121340 [main] a 86211543 fhandler_base::fork_fixup: /dev/zero - Win32 error 6,                                           handle io_handle<0x0>
 121358 [main] a 86211543 fhandler_base::fork_fixup: /dev/random - Win32 error 6                                          , handle io_handle<0x0>
 121374 [main] a 86211543 fhandler_base::fork_fixup: /dev/clipboard - Win32 erro                                          r 6, handle io_handle<0x0>
 
What's happening is that these files have no handle to duplicate.
[Well, I must admit that my fix had the same problem :(  ]

In addition the close on exec itself generates internal errors for 
the same reason, e.g.: 
  176 1542126 [main] a 69681459 fhandler_base::set_inheritance: DuplicateHandle failed, Win32 error 6
  173 1542299 [main] a 69681459 fhandler_base::set_close_on_exec: set close_on_exec for /dev/clipboard to 1

I fixed all that by adding set_nohandle () and get_nohandle () appropriately.
To avoid submitting patches on top of yesterday changes, I include cumulative 
changes for the last two days.

Also, on line 476 of fhandler_disk_file.cc, in lock,  I see
  if (fl->l_len < 0)
    {
      win32_start -= fl->l_len;
      win32_len = -fl->l_len;
    }
It seems to me that we want to decrement win32_start, which would mean
we should add the negative fl->l_len, or am I confused?
 
And yesterday's question: On line 173 of fhandler_disk_file.cc 
[strpbrk (get_win32_name (), "?*|<>|")] is there a need for the 
two '|'? Was something else meant?

Pierre

2002-09-18  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.cc (fhandler_base::raw_read): Add case for 
	ERROR_INVALID_HANDLE due to Win95 directories.
	(fhandler_base::open): Handle errors due to Win95 directories.
	(fhandler_base::close): Add get_nohandle () test.
	(fhandler_base::set_close_on_exec): Ditto.
	(fhandler_base::fork_fixup): Ditto.
	(fhandler_base::lock): Change error code to Posix EINVAL.
	(fhandler_base::dup): If get_nohandle (), set new value to
	INVALID_HANDLE_VALUE instead of NULL.
	* fhandler_disk_file.cc (fhandler_disk_file::fstat): Call
 	fstat_by_name () if get_nohandle ().
	(fhandler_disk_file::open): Remove test for Win95 directory.
	* fhandler_random.cc	(fhandler_dev_random::open): Add set_nohandle ().
	* fhandler_clipboard.cc (fhandler_dev_clipboard::open): Ditto. 
	* fhandler_zero.cc (fhandler_dev_zero::open): Ditto.
	(fhandler_dev_zero::close): Delete.
	* fhandler.h	(class fhandler_dev_zero): Ditto.


--- fhandler.cc.orig	2002-09-16 22:23:44.000000000 -0400
+++ fhandler.cc	2002-09-18 21:11:56.000000000 -0400
@@ -275,6 +275,7 @@ fhandler_base::raw_read (void *ptr, size
 	    return 0;
 	case ERROR_INVALID_FUNCTION:
 	case ERROR_INVALID_PARAMETER:
+	case ERROR_INVALID_HANDLE:
 	  if (openflags & O_DIROPEN)
 	    {
 	      set_errno (EISDIR);
@@ -441,11 +442,20 @@ fhandler_base::open (path_conv *pc, int 
 
   if (x == INVALID_HANDLE_VALUE)
     {
-      if (GetLastError () == ERROR_INVALID_HANDLE)
-	set_errno (ENOENT);
+      if (pc->isdir () && !wincap.can_open_directories ())
+        {
+          if (mode & (O_CREAT | O_EXCL) == (O_CREAT | O_EXCL))
+            set_errno (EEXIST);
+          else if (mode & (O_WRONLY | O_RDWR))
+            set_errno (EISDIR);
+          else 
+            set_nohandle (true);
+        } 
+      else if (GetLastError () == ERROR_INVALID_HANDLE)
+        set_errno (ENOENT);
       else
-	__seterrno ();
-      goto done;
+        __seterrno ();
+      if (!get_nohandle ()) goto done;
     }
 
   /* Attributes may be set only if a file is _really_ created.
@@ -871,7 +881,7 @@ fhandler_base::close ()
   int res = -1;
 
   syscall_printf ("closing '%s' handle %p", get_name (), get_handle());
-  if (CloseHandle (get_handle()))
+  if (get_nohandle () || CloseHandle (get_handle()))
     res = 0;
   else
     {
@@ -898,7 +908,7 @@ fhandler_base::ioctl (unsigned int cmd, 
 int
 fhandler_base::lock (int, struct flock *)
 {
-  set_errno (ENOSYS);
+  set_errno (EINVAL);
   return -1;
 }
 
@@ -996,7 +1006,7 @@ fhandler_base::dup (fhandler_base *child
 
   HANDLE nh;
   if (get_nohandle ())
-    nh = NULL;
+    nh = INVALID_HANDLE_VALUE;
   else if (!DuplicateHandle (hMainProc, get_handle(), hMainProc, &nh, 0, TRUE,
 			DUPLICATE_SAME_ACCESS))
     {
@@ -1207,7 +1217,8 @@ fhandler_base::fork_fixup (HANDLE parent
 void
 fhandler_base::set_close_on_exec (int val)
 {
-  set_inheritance (io_handle, val);
+  if (!get_nohandle ())
+    set_inheritance (io_handle, val);
   set_close_on_exec_flag (val);
   debug_printf ("set close_on_exec for %s to %d", get_name (), val);
 }
@@ -1216,7 +1227,8 @@ void
 fhandler_base::fixup_after_fork (HANDLE parent)
 {
   debug_printf ("inheriting '%s' from parent", get_name ());
-  fork_fixup (parent, io_handle, "io_handle");
+  if (!get_nohandle ())
+    fork_fixup (parent, io_handle, "io_handle");
 }
 
 bool
--- fhandler_disk_file.cc.orig	2002-09-16 21:10:42.000000000 -0400
+++ fhandler_disk_file.cc	2002-09-18 20:33:10.000000000 -0400
@@ -156,8 +156,12 @@ fhandler_disk_file::fstat (struct __stat
   bool query_open_already;
 
   if (get_io_handle ())
-    return fstat_by_handle (buf, pc);
-
+    {
+      if (get_nohandle ())
+	return fstat_by_name (buf, pc);
+      else
+	return fstat_by_handle (buf, pc);
+    }
   /* If we don't care if the file is executable or we already know if it is,
      then just do a "query open" as it is apparently much faster. */
   if (pc->exec_state () != dont_know_if_executable)
@@ -191,7 +195,7 @@ fhandler_disk_file::fstat (struct __stat
 	}
     }
 
-  if (!oret)
+  if (!oret || get_nohandle ())
     res = fstat_by_name (buf, pc);
   else
     {
@@ -364,15 +368,7 @@ fhandler_disk_file::open (path_conv *rea
   set_isremote (real_path->isremote ());
 
   int res;
-  if (!real_path->isdir () || wincap.can_open_directories ())
-    res = this->fhandler_base::open (real_path, flags | O_DIROPEN, mode);
-  else
-    {
-      set_errno (EISDIR);
-      res = 0;
-    }
-
-  if (!res)
+  if (!(res = this->fhandler_base::open (real_path, flags | O_DIROPEN, mode)))
     goto out;
 
   /* This is for file systems known for having a buggy CreateFile call
--- fhandler_random.cc.orig	2002-09-18 20:36:16.000000000 -0400
+++ fhandler_random.cc	2002-09-18 20:37:18.000000000 -0400
@@ -32,6 +32,7 @@ int
 fhandler_dev_random::open (path_conv *, int flags, mode_t)
 {
   set_flags ((flags & ~O_TEXT) | O_BINARY);
+  set_nohandle (true);
   set_open_status ();
   return 1;
 }
--- fhandler_clipboard.cc.orig	2002-09-18 20:36:36.000000000 -0400
+++ fhandler_clipboard.cc	2002-09-18 20:38:30.000000000 -0400
@@ -73,6 +73,7 @@ fhandler_dev_clipboard::open (path_conv 
   membuffer = NULL;
   if (!cygnativeformat)
     cygnativeformat = RegisterClipboardFormat (CYGWIN_NATIVE);
+  set_nohandle (true);
   set_open_status ();
   return 1;
 }
--- fhandler_zero.cc.orig	2002-09-16 18:18:08.000000000 -0400
+++ fhandler_zero.cc	2002-09-18 20:54:24.000000000 -0400
@@ -24,6 +24,7 @@ int
 fhandler_dev_zero::open (path_conv *, int flags, mode_t)
 {
   set_flags ((flags & ~O_TEXT) | O_BINARY);
+  set_nohandle (true);
   set_open_status ();
   return 1;
 }
@@ -47,12 +48,6 @@ fhandler_dev_zero::lseek (__off64_t, int
   return 0;
 }
 
-int
-fhandler_dev_zero::close (void)
-{
-  return 0;
-}
-
 void
 fhandler_dev_zero::dump ()
 {
--- fhandler.h.orig	2002-09-18 20:55:00.000000000 -0400
+++ fhandler.h	2002-09-18 20:55:42.000000000 -0400
@@ -954,7 +954,6 @@ class fhandler_dev_zero: public fhandler
   int write (const void *ptr, size_t len);
   int __stdcall read (void *ptr, size_t len) __attribute__ ((regparm (3)));
   __off64_t lseek (__off64_t offset, int whence);
-  int close (void);
 
   void dump ();
 };
