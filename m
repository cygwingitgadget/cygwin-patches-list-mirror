Return-Path: <cygwin-patches-return-3642-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24078 invoked by alias); 28 Feb 2003 04:09:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24052 invoked from network); 28 Feb 2003 04:09:43 -0000
Message-Id: <3.0.5.32.20030227230453.007d3a60@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Fri, 28 Feb 2003 04:09:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: access () and path.cc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00291.txt.bz2

Corinna,

The patch below needs careful review & probably work as I
don't know path.cc very well and you may have other ideas.

The starting point was that I noticed a problem when testing 
the new access() implementation with non-file paths, 
such as /dev/dsp or /proc/registry.

The design is to handle such paths the old way, i.e. through a 
call to stat_worker (real_path, &st, 0). 
As you know, real_path returns a pointer to its internal path buffer.
For disk files, this is more efficient than passing the posix path.
Passing the posix path would solve my problem, but not the other 
 issues below.

Problem 1:
**********
Files under /proc get an invalid path buffer. Compare the 
following lines: 
  681  445978 [main] ls 1106753 mount_info::conv_to_win32_path: 
src_path /dev/dsp, dst \dev\dsp, flags 0x2, rc 0
  700  345708 [main] ls 1105981 mount_info::conv_to_win32_path: 
src_path /proc/registry, dst C:\progra~1\cygnus\proc\registry, flags 0xA, rc 0
                             ^^^^^^^^^^^^^^^^^^^ 
Problem 2:
**********
Even when the path is correct, e.g. \dev\dsp, stat_worker()
passes it to fdtab.build_fhandler_from_name(), which passes it
to pc.check(), which *fails*.
It fails because the path is in Windows format (backslashes)
but \dev\dsp means nothing to Windows.

There is a related issue in fstat64(), which calls
   path_conv pc (cfd->get_win32_name (), PC_SYM_NOFOLLOW)
which can thrash a lot, as seen in the following strace:

12003  366989 [main] ls 1105981 normalize_posix_path: src \dev\pipew  <== NOT A WINDOWS PATH
  736  367725 [main] ls 1105981 cwdstuff::get: posix /c/home/pierre
  647  368372 [main] ls 1105981 cwdstuff::get: (c:\home\pierre) = cwdstuff::get (0x254F160, 260, 0, 0), errno 22
  660  369032 [main] ls 1105981 normalize_win32_path: c:\dev\pipew = normalize_win32_path (\dev\pipew)
  876  369908 [main] ls 1105981 mount_info::conv_to_win32_path: conv_to_win32_path (c:/dev/pipew)
  674  370582 [main] ls 1105981 mount_info::conv_to_win32_path: c:/dev/pipew already win32
  643  371225 [main] ls 1105981 normalize_win32_path: c:\dev\pipew = normalize_win32_path (c:/dev/pipew)
  664  371889 [main] ls 1105981 set_flags: flags: binary (0x2)
  641  372530 [main] ls 1105981 mount_info::conv_to_win32_path: src_path c:/dev/pipew, dst c:\dev\pipew, flags 0x2, rc 0
 1633  374163 [main] ls 1105981 symlink_info::check: GetFileAttributes (c:\dev\pipew) failed

<snip>, it goes on and on

  649  385200 [main] ls 1105981 symlink_info::check: 0 = symlink.check (c:\dev, 0x254EE20) (0x2)
  662  385862 [main] ls 1105981 mount_info::conv_to_win32_path: conv_to_win32_path (c:)
  669  386531 [main] ls 1105981 mount_info::conv_to_win32_path: c: already win32
  815  387346 [main] ls 1105981 normalize_win32_path: c: = normalize_win32_path (c:)
  655  388001 [main] ls 1105981 set_flags: flags: binary (0x2)
  795  388796 [main] ls 1105981 mount_info::conv_to_win32_path: src_path c:, dst c:, flags 0x2, rc 0
  910  389706 [main] ls 1105981 symlink_info::check: not a symlink
  657  390363 [main] ls 1105981 symlink_info::check: 0 = symlink.check (c:\, 0x254EE20) (0x2)
  654  391017 [main] ls 1105981 path_conv::check: root_dir(c:\), this->path(c:\dev\pipew), set_has_acls(0)
  669  391686 [main] ls 1105981 fhandler_base::fstat: here
  826  392512 [main] ls 1105981 fstat64: 0 = fstat (1, 0x254F640)   <= Eventual success

The solution adopted in the patch is the following: 
 Whenever a Windows path is meaningless to Windows (e.g. \dev, \proc),
 store the path in posix format, which can be quickly interpreted
 by path_conv::check.
Doing this can't hurt because the old form is unusable, so why have it?
With that change, fstat64 behaves as follows:

  500  547907 [main] ls 60140799 normalize_posix_path: src /dev/pipew
  177  548084 [main] ls 60140799 normalize_posix_path: /dev/pipew = normalize_posix_path (/dev/pipew)
  161  548245 [main] ls 60140799 mount_info::conv_to_win32_path: conv_to_win32_path (/dev/pipew)
  167  548412 [main] ls 60140799 mount_info::conv_to_win32_path: src_path /dev/pipew, dst /dev/pipew, flags 0x2, rc 0
  164  548576 [main] ls 60140799 fhandler_base::fstat: here
  219  548795 [main] ls 60140799 fstat64: 0 = fstat (1, 0x254F640)

saving 13 ms per call.
There are remaining places (e.g. sockets) where this approach isn't 
yet implemented.
 
Problem 3
*********
I have kept paths such as '\Device\Tape%d', thinking that they might
be needed somewhere. I have not found the spots where they are used
by Cygwin.

Those paths cause thrashing as above, just strace the following program
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
main()
{
  struct stat buf;
  int i;
  i = open("/dev/fd0", O_RDWR);
  printf("i = %d\n", i);
  i = fstat(i, &buf);
  printf("i = %d\n", i);
}

If these paths are needed and meaningful to Windows, shouldn't 
normalize_win32_path recognize them?


2003-02-28  Pierre Humblet  <pierre.humblet@ieee.org>

	* path.cc (windows_device_names): Use / when appropriate.
	(mount_info::conv_to_win32_path): For paths under /proc,
	generate this->path directly and go to out_no_chroot_check.



Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.246
diff -u -p -r1.246 path.cc
--- path.cc	21 Feb 2003 14:29:18 -0000	1.246
+++ path.cc	27 Feb 2003 22:57:08 -0000
@@ -854,30 +854,30 @@ digits (const char *name)
 const char *windows_device_names[] NO_COPY =
 {
   NULL,
-  "\\dev\\console",
+  "/dev/console",
   "conin",
   "conout",
-  "\\dev\\ttym",
-  "\\dev\\tty%d",
-  "\\dev\\ptym",
+  "/dev/ttym",
+  "/dev/tty%d",
+  "/dev/ptym",
   "\\\\.\\com%d",
-  "\\dev\\pipe",
-  "\\dev\\piper",
-  "\\dev\\pipew",
-  "\\dev\\socket",
-  "\\dev\\windows",
+  "/dev/pipe",
+  "/dev/piper",
+  "/dev/pipew",
+  "/dev/socket",
+  "/dev/windows",
 
   NULL, NULL, NULL,
 
-  "\\dev\\disk",
-  "\\dev\\fd%d",
-  "\\dev\\st%d",
+  "/dev/disk",
+  "/dev/fd%d",
+  "/dev/st%d",
   "nul",
-  "\\dev\\zero",
-  "\\dev\\%srandom",
-  "\\dev\\mem",
-  "\\dev\\clipboard",
-  "\\dev\\dsp"
+  "/dev/zero",
+  "/dev/%srandom",
+  "/dev/mem",
+  "/dev/clipboard",
+  "/dev/dsp"
 };
 
 #define deveq(s) (strcasematch (name, (s)))
@@ -1122,7 +1122,7 @@ win32_device_name (const char *src_path,
       case FH_SOCKET:
 	char *c;
 	strcpy (win32_path, src_path);
-	while (c = strchr (win32_path, '/'))
+	while ((c = strchr (win32_path, '/')))
 	  *c = '\\';
         break;
       case FH_RANDOM:
@@ -1489,7 +1489,13 @@ mount_info::conv_to_win32_path (const ch
     {
       devn = fhandler_proc::get_proc_fhandler (pathbuf);
       if (devn == FH_BAD)
-	return ENOENT;
+	rc = ENOENT;
+      else
+        {
+	  rc = 0;
+	  strcpy (dst, pathbuf);
+	}
+      goto out_no_chroot_check;
     }
   else if (iscygdrive (pathbuf))
     {
