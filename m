Return-Path: <cygwin-patches-return-2994-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13502 invoked by alias); 18 Sep 2002 01:02:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13488 invoked from network); 18 Sep 2002 01:02:29 -0000
Message-Id: <3.0.5.32.20020917205836.0080c100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Tue, 17 Sep 2002 18:02:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: open () on Win95 directories
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00442.txt.bz2

As reported on Sunday in the Cygwin list, applications such as 
mutt 1.4 do not work on Win95/98/ME because there Cygwin does
not implement open() on directories, as CreateFile () does 
not work on directories either. However often open () is used on 
directories with fchdir () or fstat (), which do not rely 
on CreateFile. So it would still be useful to have open.

The patch below does just that. Essentially on Windows 95 directories
are opened without a valid handle (set_nohandle). Then it's just a 
matter of calling get_nohandle () in a couple of places to make 
everything work.

The fhandler_zero.cc stuff is an unrelated fix for dup(/dev/zero).

On line 173 of fhandler_disk_file.cc [strpbrk (get_win32_name (), "?*|<>|")]
is there a need for the two '|'? Was something else meant?

Pierre

2002-09-17  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.cc (fhandler_base::raw_read): Add case for 
	ERROR_INVALID_HANDLE due to Win95 directories.
	(fhandler_base::open): Handle errors due to Win95 directories.
	(fhandler_base::close): Add get_nohandle () test.
	* fhandler_disk_file.cc (fhandler_disk_file::fstat): Call
 	fstat_by_name () if get_nohandle ().
	(fhandler_disk_file::open): Remove test for Win95 directory.
	(fhandler_disk_file::lock): Add get_nohandle () test. 
	* fhandler_zero.cc (fhandler_dev_zero::open): Add 
	get_nohandle () test. 

--- fhandler.cc.orig    2002-09-16 22:23:44.000000000 -0400
+++ fhandler.cc 2002-09-17 19:31:22.000000000 -0400
@@ -275,6 +275,7 @@ fhandler_base::raw_read (void *ptr, size
            return 0;
        case ERROR_INVALID_FUNCTION:
        case ERROR_INVALID_PARAMETER:
+       case ERROR_INVALID_HANDLE:
          if (openflags & O_DIROPEN)
            {
              set_errno (EISDIR);
@@ -441,11 +442,20 @@ fhandler_base::open (path_conv *pc, int 
 
   if (x == INVALID_HANDLE_VALUE)
     {
-      if (GetLastError () == ERROR_INVALID_HANDLE)
-       set_errno (ENOENT);
+      if (pc->isdir () && !wincap.can_open_directories ())
+        {
+          if (mode & (O_WRONLY | O_RDWR))
+            set_errno (EISDIR);
+          else if (mode & (O_CREAT | O_EXCL) == (O_CREAT | O_EXCL))
+            set_errno (EEXIST);
+          else 
+            set_nohandle (true);
+        } 
+      else if (GetLastError () == ERROR_INVALID_HANDLE)
+        set_errno (ENOENT);
       else
-       __seterrno ();
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
--- fhandler_disk_file.cc.orig  2002-09-16 21:10:42.000000000 -0400
+++ fhandler_disk_file.cc       2002-09-17 18:35:28.000000000 -0400
@@ -156,8 +156,12 @@ fhandler_disk_file::fstat (struct __stat
   bool query_open_already;
 
   if (get_io_handle ())
-    return fstat_by_handle (buf, pc);
-
+    {
+      if (get_nohandle ())
+       return fstat_by_name (buf, pc);
+      else
+       return fstat_by_handle (buf, pc);
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
+  if (!(res = this->fhandler_base::open (real_path, flags | O_DIROPEN,
mode)))
     goto out;
 
   /* This is for file systems known for having a buggy CreateFile call
@@ -434,7 +430,7 @@ fhandler_disk_file::lock (int cmd, struc
    * We don't do getlck calls yet.
    */
 
-  if (cmd == F_GETLK)
+  if (cmd == F_GETLK || get_nohandle ())
     {
       set_errno (ENOSYS);
--- fhandler_zero.cc.orig       2002-09-16 18:18:08.000000000 -0400
+++ fhandler_zero.cc    2002-09-16 18:25:58.000000000 -0400
@@ -24,6 +24,7 @@ int
 fhandler_dev_zero::open (path_conv *, int flags, mode_t)
 {
   set_flags ((flags & ~O_TEXT) | O_BINARY);
+  set_nohandle (true);
   set_open_status ();
   return 1;
 }
