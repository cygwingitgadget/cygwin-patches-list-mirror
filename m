Return-Path: <cygwin-patches-return-4705-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19223 invoked by alias); 5 May 2004 02:36:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19206 invoked from network); 5 May 2004 02:36:07 -0000
X-Originating-IP: [24.236.218.217]
X-Originating-Email: [yjfwhhvvvhzk6wdy@hotmail.com]
X-Sender: yjfwhhvvvhzk6wdy@hotmail.com
From: "Stephen Cleary" <yjfwhhvvvhzk6wdy@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Patch to handle Win32 named pipes as file names
Date: Wed, 05 May 2004 02:36:00 -0000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_85d_14eb_4942"
Message-ID: <BAY9-F27kwn9Wgtc2S6000011ec@hotmail.com>
X-OriginalArrivalTime: 05 May 2004 02:36:07.0317 (UTC) FILETIME=[B7EFE450:01C43249]
X-SW-Source: 2004-q2/txt/msg00057.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_85d_14eb_4942
Content-Type: text/plain; format=flowed
Content-length: 1210

Attached is a patch, ChangeLog, and one new file that allows Cygwin programs 
to open Win32 named pipe instances (e.g., "\\.\pipe\pipename") through an 
open() call. The resulting handle will appear like a FIFO to the calling 
program.

This has nothing to do with mkfifo(), Unix-style pipes, or the (partial?) 
implementations of FH_PIPE, FH_PIPER, FH_PIPEW, or FH_FIFO already in CVS. 
All this patch does is allow, e.g.,
  echo Howdy > //server/pipe/bob
assuming that a program running on 'server' has already opened a server-side 
named pipe with the name of 'bob'.

This is my first patch to Cygwin, so please let me know if I did anything 
wrong.

Notes:
- In general, I made the Win32 pipe act as much as possible as a Win32 file. 
Win32 pipes are part of the Win32 file system, so this should be correct, 
but not all behavior has been tested (e.g., getting/setting file security 
attributes).
- I am not familiar with device major/minor numbers, so I just chose major 
0, minor 246 for Win32 named pipes.

        -Steve

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar  get it now! 
http://toolbar.msn.com/go/onm00200415ave/direct/01/

------=_NextPart_000_85d_14eb_4942
Content-Type: text/plain; name="win32_pipe_patch"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="win32_pipe_patch"
Content-length: 10002

? fhandler_win32_pipe.cc
Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.163
diff -u -p -r1.163 Makefile.in
--- Makefile.in	4 May 2004 15:09:58 -0000	1.163
+++ Makefile.in	5 May 2004 02:04:25 -0000
@@ -124,7 +124,7 @@ DLL_OFILES:=assert.o autoload.o bsdlib.o
	environ.o errno.o exceptions.o exec.o external.o fcntl.o fhandler.o \
	fhandler_clipboard.o fhandler_console.o fhandler_disk_file.o \
	fhandler_dsp.o fhandler_fifo.o fhandler_floppy.o fhandler_mem.o \
-	fhandler_nodevice.o fhandler_proc.o fhandler_process.o \
+	fhandler_nodevice.o fhandler_proc.o fhandler_process.o 
fhandler_win32_pipe.o \
	fhandler_random.o fhandler_raw.o fhandler_registry.o fhandler_serial.o \
	fhandler_socket.o fhandler_tape.o fhandler_termios.o \
	fhandler_tty.o fhandler_virtual.o fhandler_windows.o \
@@ -232,6 +232,7 @@ fhandler_CFLAGS:=-fomit-frame-pointer
fhandler_clipboard_CFLAGS:=-fomit-frame-pointer
fhandler_console_CFLAGS:=-fomit-frame-pointer
fhandler_disk_file_CFLAGS:=-fomit-frame-pointer
+fhandler_win32_pipe_CFLAGS:=-fomit-frame-pointer
fhandler_dsp_CFLAGS:=-fomit-frame-pointer
fhandler_floppy_CFLAGS:=-fomit-frame-pointer
fhandler_mem_CFLAGS:=-fomit-frame-pointer
Index: devices.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/devices.cc,v
retrieving revision 1.12
diff -u -p -r1.12 devices.cc
--- devices.cc	21 Jan 2004 19:14:19 -0000	1.12
+++ devices.cc	5 May 2004 02:04:35 -0000
@@ -22,6 +22,9 @@ const device dev_cygdrive_storage =
const device dev_fs_storage =
   {"", FH_FS, ""};

+const device dev_win32_pipe_storage =
+  {"", FH_WIN32_PIPE, ""};
+
const device dev_proc_storage =
   {"", FH_PROC, ""};

@@ -14814,6 +14817,20 @@ return	NULL;



+// Win32 pipe names have a prefix that follows the pattern: //[^/]+/pipe/
+static bool
+is_win32_pipe_name (const char * const s)
+{
+  if (strncmp(s, "//", 2))
+    return false;
+  const char * const p = strchr(s + 2, '/');
+  if (!p || p - s == 2)
+    return false;
+  if (strnicmp(p + 1, "pipe/", 5))
+    return false;
+  return true;
+}
+
void
device::parse (const char *s)
{
@@ -14821,7 +14838,17 @@ device::parse (const char *s)
   const device *dev = KR_find_keyword (s, len);

   if (!dev)
-    *this = *fs_dev;
+  {
+    // FIXME: Should this also handle other Windows "devices" that can be 
opened
+    //  via CreateFile, e.g., \\.\COM*, mailslots, etc.?
+
+    // This is not a defined Cygwin device, so it must be either a Win32 
named pipe instance
+    //  or a disk file
+    if (is_win32_pipe_name(s))
+      *this = *win32_pipe_dev;
+    else
+      *this = *fs_dev;
+  }
   else
     *this = *dev;
}
Index: devices.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/devices.h,v
retrieving revision 1.12
diff -u -p -r1.12 devices.h
--- devices.h	3 Dec 2003 16:35:52 -0000	1.12
+++ devices.h	5 May 2004 02:04:35 -0000
@@ -48,6 +48,7 @@ enum fh_devices
   FH_PROCESS = FHDEV (0, 248),

   FH_FS      = FHDEV (0, 247),	/* filesystem based device */
+  FH_WIN32_PIPE = FHDEV (0, 246),

   DEV_FLOPPY_MAJOR = 2,
   FH_FLOPPY  = FHDEV (DEV_FLOPPY_MAJOR, 0),
@@ -173,3 +174,5 @@ extern const device dev_fh_storage;
#define fh_dev (&dev_fh_storage)
extern const device dev_fs_storage;
#define fs_dev (&dev_fs_storage)
+extern const device dev_win32_pipe_storage;
+#define win32_pipe_dev (&dev_win32_pipe_storage)
Index: devices.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/devices.in,v
retrieving revision 1.4
diff -u -p -r1.4 devices.in
--- devices.in	21 Jan 2004 19:14:19 -0000	1.4
+++ devices.in	5 May 2004 02:04:35 -0000
@@ -18,6 +18,9 @@ const device dev_cygdrive_storage =
const device dev_fs_storage =
   {"", FH_FS, ""};

+const device dev_win32_pipe_storage =
+  {"", FH_WIN32_PIPE, ""};
+
const device dev_proc_storage =
   {"", FH_PROC, ""};

@@ -78,6 +81,20 @@ const device dev_bad_storage =
"/dev/sd%{a-z}s%(1-15)d", FH_SD{uc $1} | {$2}, "\\Device\\Harddisk{ord($1) - 
ord('a')}\\Partition{$2 % 16}"
%other	{return	NULL;}
%%
+// Win32 pipe names have a prefix that follows the pattern: //[^/]+/pipe/
+static bool
+is_win32_pipe_name (const char * const s)
+{
+  if (strncmp(s, "//", 2))
+    return false;
+  const char * const p = strchr(s + 2, '/');
+  if (!p || p - s == 2)
+    return false;
+  if (strnicmp(p + 1, "pipe/", 5))
+    return false;
+  return true;
+}
+
void
device::parse (const char *s)
{
@@ -85,7 +102,17 @@ device::parse (const char *s)
   const device *dev = KR_find_keyword (s, len);

   if (!dev)
-    *this = *fs_dev;
+  {
+    // FIXME: Should this also handle other Windows "devices" that can be 
opened
+    //  via CreateFile, e.g., \\.\COM*, mailslots, etc.?
+
+    // This is not a defined Cygwin device, so it must be either a Win32 
named pipe instance
+    //  or a disk file
+    if (is_win32_pipe_name(s))
+      *this = *win32_pipe_dev;
+    else
+      *this = *fs_dev;
+  }
   else
     *this = *dev;
}
Index: dtable.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.140
diff -u -p -r1.140 dtable.cc
--- dtable.cc	11 Apr 2004 04:00:01 -0000	1.140
+++ dtable.cc	5 May 2004 02:04:36 -0000
@@ -422,6 +422,9 @@ build_fh_pc (path_conv& pc)
	  case FH_FS:
	    fh = cnew (fhandler_disk_file) ();
	    break;
+        case FH_WIN32_PIPE:
+          fh = cnew (fhandler_win32_pipe) ();
+          break;
	  case FH_NULL:
	    fh = cnew (fhandler_dev_null) ();
	    break;
Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.193
diff -u -p -r1.193 fhandler.cc
--- fhandler.cc	30 Apr 2004 17:36:36 -0000	1.193
+++ fhandler.cc	5 May 2004 02:04:37 -0000
@@ -1200,6 +1200,9 @@ fhandler_base::fstat (struct __stat64 *b
     case FH_PIPER:
       buf->st_mode = S_IFIFO | STD_RBITS;
       break;
+    case FH_WIN32_PIPE:
+      buf->st_mode = S_IFIFO | STD_RBITS | STD_WBITS | S_IWGRP | S_IWOTH;
+      break;
     default:
       buf->st_mode = S_IFCHR | STD_RBITS | STD_WBITS | S_IWGRP | S_IWOTH;
       break;
Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.206
diff -u -p -r1.206 fhandler.h
--- fhandler.h	20 Apr 2004 15:51:24 -0000	1.206
+++ fhandler.h	5 May 2004 02:04:38 -0000
@@ -590,6 +590,16 @@ class fhandler_disk_file: public fhandle
   int closedir (DIR *);
};

+class fhandler_win32_pipe: public fhandler_base
+{
+ public:
+  fhandler_win32_pipe ();
+
+  int open (int flags, mode_t mode);
+  int close ();
+  bool isdevice () { return false; }
+};
+
class fhandler_cygdrive: public fhandler_disk_file
{
   int ndrives;
@@ -1188,6 +1198,7 @@ typedef union
   char __dev_tape[sizeof (fhandler_dev_tape)];
   char __dev_zero[sizeof (fhandler_dev_zero)];
   char __disk_file[sizeof (fhandler_disk_file)];
+  char __win32_pipe[sizeof (fhandler_win32_pipe)];
   char __pipe[sizeof (fhandler_pipe)];
   char __proc[sizeof (fhandler_proc)];
   char __process[sizeof (fhandler_process)];
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.308
diff -u -p -r1.308 path.cc
--- path.cc	4 May 2004 15:14:48 -0000	1.308
+++ path.cc	5 May 2004 02:04:42 -0000
@@ -925,7 +925,7 @@ static bool
win32_device_name (const char *src_path, char *win32_path, device& dev)
{
   dev.parse (src_path);
-  if (dev.devn == FH_FS)
+  if (dev.devn == FH_FS || dev.devn == FH_WIN32_PIPE)
     return false;
   strcpy (win32_path, dev.native);
   return true;
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.64
diff -u -p -r1.64 path.h
--- path.h	30 Apr 2004 17:36:36 -0000	1.64
+++ path.h	5 May 2004 02:04:42 -0000
@@ -140,9 +140,9 @@ class path_conv
   }
   int issymlink () const {return path_flags & PATH_SYMLINK;}
   int is_lnk_symlink () const {return path_flags & PATH_LNK;}
-  int isdevice () const {return dev.devn && dev.devn != FH_FS && dev.devn 
!= FH_FIFO;}
+  int isdevice () const {return dev.devn && dev.devn != FH_FS && dev.devn 
!= FH_FIFO && dev.devn != FH_WIN32_PIPE;}
   int isfifo () const {return dev == FH_FIFO;}
-  int isspecial () const {return dev.devn && dev.devn != FH_FS;}
+  int isspecial () const {return dev.devn && dev.devn != FH_FS && dev.devn 
!= FH_WIN32_PIPE;}
   int is_auto_device () const {return isdevice () && !is_fs_special ();}
   int is_fs_special () const {return isspecial () && dev.isfs ();}
   int issocket () const {return path_flags & PATH_SOCKET;}
@@ -165,7 +165,7 @@ class path_conv
   void set_binary () {path_flags |= PATH_BINARY;}
   void set_symlink (DWORD n) {path_flags |= PATH_SYMLINK; symlink_length = 
n;}
   void set_has_symlinks () {path_flags |= PATH_HAS_SYMLINKS;}
-  void set_isdisk () {path_flags |= PATH_ISDISK; dev.devn = FH_FS;}
+  void set_isdisk () {path_flags |= PATH_ISDISK;}
   void set_exec (int x = 1) {path_flags |= x ? PATH_EXEC : PATH_NOTEXEC;}

   void check (const char *src, unsigned opt = PC_SYM_FOLLOW,
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.336
diff -u -p -r1.336 syscalls.cc
--- syscalls.cc	3 May 2004 11:53:07 -0000	1.336
+++ syscalls.cc	5 May 2004 02:04:44 -0000
@@ -1420,7 +1420,7 @@ fpathconf (int fd, int v)
	}
     case _PC_POSIX_PERMISSIONS:
     case _PC_POSIX_SECURITY:
-      if (cfd->get_device () == FH_FS)
+      if (cfd->get_device () == FH_FS || cfd->get_device () == 
FH_WIN32_PIPE)
	return check_posix_perm (cfd->get_win32_name (), v);
       set_errno (EINVAL);
       return -1;


------=_NextPart_000_85d_14eb_4942
Content-Type: text/plain; name="ChangeLog"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ChangeLog"
Content-length: 811

2004-05-21 Stephen Cleary  <yjfwhhvvvhzk6wdy@hotmail.com>

* Makefile.in: Added fhandler_win32_pipe.cc

* devices.in (is_win32_pipe_name): New function.
(device::parse): Detects Win32 pipe names.

* devices.h: Added FH_WIN32_PIPE, win32_pipe_dev definitions.

* dtable.cc (build_fh_pc): Handles FH_WIN32_PIPE.

* fhandler.cc (fstat): Hardcoded mode for FH_WIN32_PIPE type.

* fhander.h: Added class fhandler_win32_pipe.

* path.cc (win32_device_name): FH_WIN32_PIPE handled as file instead of 
special Cygwin device.

* path.h (path_conv::isdevice): FH_WIN32_PIPE handled as file instead of 
device.
(path_conv::isspecial): FH_WIN32_PIPE handled as not special.
(path_conv::set_isdisk): Only sets PATH_ISDISK flag (no longer sets dev.devn 
to FH_FS).

* syscalls.cc (fpathconf): FH_WIN32_PIPE handled as file.


------=_NextPart_000_85d_14eb_4942
Content-Type: text/plain; name="fhandler_win32_pipe.cc"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="fhandler_win32_pipe.cc"
Content-length: 918

/* fhandler_win32_pipe.cc

   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004 Red Hat, 
Inc.

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#include "winsup.h"
#include <unistd.h>
#include <stdlib.h>
#include <sys/cygwin.h>
#include <signal.h>
#include "cygerrno.h"
#include "perprocess.h"
#include "security.h"
#include "cygwin/version.h"
#include "path.h"
#include "fhandler.h"
#include "dtable.h"
#include "cygheap.h"
#include "shared_info.h"
#include "pinfo.h"
#include <assert.h>
#include <ctype.h>

#define _COMPILING_NEWLIB
#include <dirent.h>

fhandler_win32_pipe::fhandler_win32_pipe () :
  fhandler_base ()
{
}

int
fhandler_win32_pipe::open (int flags, mode_t mode)
{
  return open_fs (flags, mode);
}

int
fhandler_win32_pipe::close ()
{
  return close_fs ();
}



------=_NextPart_000_85d_14eb_4942--
