Return-Path: <cygwin-patches-return-1856-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27907 invoked by alias); 9 Feb 2002 23:05:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27839 invoked from network); 9 Feb 2002 23:05:14 -0000
Message-ID: <008901c1b1be$80b36e70$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: /proc and /proc/registry
Date: Sat, 09 Feb 2002 20:37:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0086_01C1B1BE.80286C80"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00213.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0086_01C1B1BE.80286C80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 335

The attached patch (against cygwin-1.3.9-1/winsup/cygwin) adds support for a
/proc virtual filesystem and a read-only version of /proc/registry. I've
read http://cygwin.com/assign.txt but need to sort out the legalese before
doing anything.
Partically fufills Cygwin TODO item:
2001-11-08    /proc filesystem    Nicos

Regards
Chris



------=_NextPart_000_0086_01C1B1BE.80286C80
Content-Type: application/octet-stream;
	name="ChangeLog.dat"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.dat"
Content-length: 1145

2002-02-09  Christopher January <chris@atomice.net>

	* Makefile.in: Add fhandler_proc.o, fhandler_registry.o,
	fhandler_process.o and fhandler_virtual.o.
	* dtable.cc (dtable::build_fhandler): Add entries for FH_PROC,
	FH_REGISTRY and FH_PROCESS.
	* fhandler.h: Add constants for FH_PROC, FH_REGISTRY and FH_PROCESS.
	Add class declarations for fhandler_virtual, fhandler_proc,
	fhandler_registry and fhandler_virtual.
	Update fhandler_union accordingly.
	* fhandler_proc.c: Add implementation for fhandler_proc.
	* fhandler_virtual.c: Add implementation for fhandler_virtual.
	* fhandler_process.c Add implementation for fhandler_process.
	* fhandler_registry.c: Add implementation for fhandler_registry.
	* path.cc: Add isproc and isvirtual_dev macros.
	* path.cc (path_conv::check): Add check for virtual devices.
	* path.cc (mount_info::conv_to_win32_path): Convert paths in /proc to
	empty Win32 paths.
	* path.cc (chdir): Replace check for FH_CYGDRIVE with more generic
	isvirtual_dev macro.
	* path.h: Add externally visible path_prefix_p and normalized_posix_path
	prototypes. (nb: same path_prefix_p prototype is in cygheap.h as well)

------=_NextPart_000_0086_01C1B1BE.80286C80
Content-Type: application/octet-stream;
	name="proc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.patch"
Content-length: 50595

diff -U 3 -p -b -B -N -x *.d cygwin.bak/Makefile.in cygwin/Makefile.in=0A=
--- cygwin.bak/Makefile.in	Mon Feb  4 22:18:37 2002=0A=
+++ cygwin/Makefile.in	Thu Feb  7 22:43:29 2002=0A=
@@ -123,7 +123,8 @@ DLL_OFILES:=3Dassert.o autoload.o cygheap.=0A=
 	fhandler_disk_file.o fhandler_dsp.o fhandler_floppy.o fhandler_mem.o \=0A=
 	fhandler_random.o fhandler_raw.o fhandler_serial.o fhandler_socket.o \=0A=
 	fhandler_tape.o fhandler_termios.o fhandler_tty.o fhandler_windows.o \=0A=
-	fhandler_zero.o fnmatch.o \=0A=
+	fhandler_zero.o fhandler_proc.o fhandler_registry.o fhandler_process.o \=
=0A=
+	fhandler_virtual.o fnmatch.o \=0A=
 	fork.o glob.o grp.o heap.o init.o ioctl.o localtime.o \=0A=
 	malloc.o miscfuncs.o mmap.o net.o ntea.o passwd.o path.o pinfo.o pipe.o \=
=0A=
 	poll.o pthread.o regcomp.o regerror.o regexec.o regfree.o registry.o \=0A=
diff -U 3 -p -b -B -N -x *.d cygwin.bak/dtable.cc cygwin/dtable.cc=0A=
--- cygwin.bak/dtable.cc	Mon Feb  4 22:18:36 2002=0A=
+++ cygwin/dtable.cc	Thu Feb  7 22:26:24 2002=0A=
@@ -335,6 +335,15 @@ dtable::build_fhandler (int fd, DWORD de=0A=
       case FH_OSS_DSP:=0A=
 	fh =3D cnew (fhandler_dev_dsp) ();=0A=
 	break;=0A=
+      case FH_PROC:=0A=
+        fh =3D cnew (fhandler_proc) ();=0A=
+        break;=0A=
+      case FH_REGISTRY:=0A=
+        fh =3D cnew (fhandler_registry) ();=0A=
+        break;=0A=
+      case FH_PROCESS:=0A=
+        fh =3D cnew (fhandler_process) ();=0A=
+        break;=0A=
       default:=0A=
 	system_printf ("internal error -- unknown device - %p", dev);=0A=
 	fh =3D NULL;=0A=
diff -U 3 -p -b -B -N -x *.d cygwin.bak/fhandler.h cygwin/fhandler.h=0A=
--- cygwin.bak/fhandler.h	Mon Feb  4 22:18:36 2002=0A=
+++ cygwin/fhandler.h	Fri Feb  8 11:37:28 2002=0A=
@@ -70,8 +70,11 @@ enum=0A=
   FH_CLIPBOARD =3D 0x00000017,	/* is a clipboard device */=0A=
   FH_OSS_DSP =3D 0x00000018,	/* is a dsp audio device */=0A=
   FH_CYGDRIVE=3D 0x00000019,	/* /cygdrive/x */=0A=
+  FH_PROC    =3D 0x0000001a,      /* /proc */=0A=
+  FH_REGISTRY =3D0x0000001b,      /* /proc/registry */=0A=
+  FH_PROCESS =3D 0x0000001c,      /* /proc/<n> */=0A=
=20=0A=
-  FH_NDEV    =3D 0x0000001a,	/* Maximum number of devices */=0A=
+  FH_NDEV    =3D 0x0000001d,      /* Maximum number of devices */=0A=
   FH_DEVMASK =3D 0x00000fff,	/* devices live here */=0A=
   FH_BAD     =3D 0xffffffff=0A=
 };=0A=
@@ -100,6 +103,9 @@ enum=0A=
 extern const char *windows_device_names[];=0A=
 extern struct __cygwin_perfile *perfile_table;=0A=
 #define __fmode (*(user_data->fmode_ptr))=0A=
+extern const char *proc;=0A=
+extern const int proc_len;=0A=
+=0A=
=20=0A=
 class select_record;=0A=
 class path_conv;=0A=
@@ -1024,6 +1030,79 @@ class fhandler_dev_dsp : public fhandler=0A=
   void fixup_after_exec (HANDLE);=0A=
 };=0A=
=20=0A=
+class fhandler_virtual : public fhandler_base=0A=
+{=0A=
+ protected:=0A=
+  char normalized_path[MAX_PATH];=0A=
+  char *filebuf;=0A=
+  int bufalloc, filesize, position;=0A=
+=0A=
+  /* 0 =3D not exist, >0 =3D dir, <0 =3D file */=0A=
+  virtual int exists(const char *path);=0A=
+ public:=0A=
+=0A=
+  fhandler_virtual (DWORD devtype);=0A=
+  virtual ~fhandler_virtual();=0A=
+=0A=
+  DIR *opendir (path_conv& pc);=0A=
+  virtual DIR *opendir(const char *path);=0A=
+  off_t telldir (DIR *);=0A=
+  void seekdir (DIR *, off_t);=0A=
+  void rewinddir (DIR *);=0A=
+  int closedir (DIR *);=0A=
+  int write (const void *ptr, size_t len);=0A=
+  int __stdcall read (void *ptr, size_t len) __attribute__ ((regparm (3)))=
;=0A=
+  off_t lseek (off_t, int);=0A=
+  int dup (fhandler_base * child);=0A=
+  int open (path_conv *, int flags, mode_t mode =3D 0);=0A=
+  virtual int open(const char *path, int flags, mode_t mode);=0A=
+  int close (void);=0A=
+  virtual int fstat (const char *path, struct stat *buf);=0A=
+  int __stdcall fstat (struct stat *buf, path_conv *pc) __attribute__ ((re=
gparm (3)));=0A=
+};=0A=
+=0A=
+class fhandler_proc: public fhandler_virtual=0A=
+{=0A=
+ protected:=0A=
+  int exists(const char *path);=0A=
+ public:=0A=
+  fhandler_proc ();=0A=
+  fhandler_proc (DWORD devtype);=0A=
+  struct dirent *readdir (DIR *);=0A=
+  int fstat (const char *path, struct stat *buf);=0A=
+  int open(const char *path, int flags, mode_t mode);=0A=
+=0A=
+  static DWORD get_proc_fhandler(const char *path);=0A=
+};=0A=
+=0A=
+class fhandler_registry: public fhandler_proc=0A=
+{=0A=
+ protected:=0A=
+  int exists(const char *path);=0A=
+ public:=0A=
+  fhandler_registry ();=0A=
+  struct dirent *readdir (DIR *);=0A=
+  off_t telldir (DIR *);=0A=
+  void seekdir (DIR *, off_t);=0A=
+  void rewinddir (DIR *);=0A=
+  int closedir (DIR *);=0A=
+  virtual int fstat (const char *path, struct stat *buf);=0A=
+  int open (const char *path, int flags, mode_t mode =3D 0);=0A=
+=0A=
+  static HKEY open_key(const char *name, REGSAM access =3D KEY_READ, bool =
isValue =3D false);=0A=
+};=0A=
+=0A=
+class fhandler_process: public fhandler_proc=0A=
+{=0A=
+ protected:=0A=
+  int exists(const char *path);=0A=
+ public:=0A=
+  fhandler_process ();=0A=
+  struct dirent *readdir (DIR *);=0A=
+  virtual int fstat (const char *path, struct stat *buf);=0A=
+  int open (const char *path, int flags, mode_t mode =3D 0);=0A=
+};=0A=
+=0A=
 typedef union=0A=
 {=0A=
   char base[sizeof(fhandler_base)];=0A=
@@ -1039,7 +1118,10 @@ typedef union=0A=
   char dev_zero[sizeof(fhandler_dev_zero)];=0A=
   char disk_file[sizeof(fhandler_disk_file)];=0A=
   char pipe[sizeof(fhandler_pipe)];=0A=
+  char proc[sizeof(fhandler_proc)];=0A=
+  char process[sizeof(fhandler_process)];=0A=
   char pty_master[sizeof(fhandler_pty_master)];=0A=
+  char registry[sizeof(fhandler_registry)];=0A=
   char serial[sizeof(fhandler_serial)];=0A=
   char socket[sizeof(fhandler_socket)];=0A=
   char termios[sizeof(fhandler_termios)];=0A=
diff -U 3 -p -b -B -N -x *.d cygwin.bak/fhandler_proc.cc cygwin/fhandler_pr=
oc.cc=0A=
--- cygwin.bak/fhandler_proc.cc	Thu Jan  1 00:00:00 1970=0A=
+++ cygwin/fhandler_proc.cc	Sat Feb  9 22:53:35 2002=0A=
@@ -0,0 +1,291 @@=0A=
+/* fhandler_proc.cc */=0A=
+/*=0A=
+    (C) Copyright Christopher January 2002=0A=
+=20=20=20=20=0A=
+    This program is free software; you can redistribute it and/or modify=
=0A=
+    it under the terms of the GNU General Public License as published by=
=0A=
+    the Free Software Foundation; either version 2 of the License, or=0A=
+    (at your option) any later version.=0A=
+=0A=
+    This program is distributed in the hope that it will be useful,=0A=
+    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+    GNU General Public License for more details.=0A=
+=0A=
+    You should have received a copy of the GNU General Public License=0A=
+    along with this program; if not, write to the Free Software=0A=
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA=20=20=20=20=20=20=0A=
+*/=0A=
+=0A=
+#include "winsup.h"=0A=
+#include <sys/fcntl.h>=0A=
+#include <errno.h>=0A=
+#include <unistd.h>=0A=
+#include <stdlib.h>=0A=
+#include <sys/cygwin.h>=0A=
+#include "cygerrno.h"=0A=
+#include "security.h"=0A=
+#include "fhandler.h"=0A=
+#include "path.h"=0A=
+#include "sigproc.h"=0A=
+#include "pinfo.h"=0A=
+#include <assert.h>=0A=
+#include <sys/utsname.h>=0A=
+=0A=
+#define _COMPILING_NEWLIB=0A=
+#include <dirent.h>=0A=
+=0A=
+/* offsets in proc_listing */=0A=
+static const int PROC_REGISTRY =3D 0;   /* /proc/registry */=0A=
+static const int PROC_VERSION  =3D 1;   /* /proc/version */=0A=
+static const int PROC_UPTIME   =3D 2;   /* /proc/uptime */=0A=
+static const int PROC_LINK_COUNT =3D 3;=0A=
+=0A=
+/* names of objects in /proc */=0A=
+static const char *proc_listing[PROC_LINK_COUNT] =3D { "registry",=0A=
+                                                     "version",=0A=
+                                                     "uptime" };=0A=
+/* FH_PROC in the table below means the file/directory is handles by fhand=
ler_proc=0A=
+ * at present, there are no files in /proc so fhandler_proc does not have =
support for opening/closing=0A=
+ * files.=0A=
+ */=0A=
+static DWORD proc_fhandlers[PROC_LINK_COUNT] =3D { FH_REGISTRY ,=0A=
+                                                 FH_PROC,=0A=
+                                                 FH_PROC };=0A=
+=0A=
+const char *proc =3D "/proc";=0A=
+const int proc_len =3D strlen(proc);=0A=
+=0A=
+/* auxillary function that returns the fhandler associated with the given =
path=0A=
+ * this is where it would be nice to have pattern matching in C - polymorp=
hism=0A=
+ * just doesn't cut it=0A=
+ */=0A=
+DWORD=0A=
+fhandler_proc::get_proc_fhandler(const char *path)=0A=
+{=0A=
+  path +=3D proc_len;=0A=
+  while (SLASH_P(*path))=0A=
+    path++;=0A=
+=0A=
+  if (*path =3D=3D 0)=0A=
+    return FH_PROC;=0A=
+  for (int i=3D0;i<PROC_LINK_COUNT;i++)=0A=
+  {=0A=
+    if (path_prefix_p(proc_listing[i], path, strlen(proc_listing[i])))=0A=
+      return proc_fhandlers[i];=0A=
+    }=0A=
+=0A=
+  int pid =3D atoi(path);=0A=
+  winpids pids;=0A=
+  for (unsigned i =3D 0; i < pids.npids; i++)=0A=
+  {=0A=
+    _pinfo *p =3D pids[i];=0A=
+=0A=
+    if (!proc_exists (p))=0A=
+     continue;=0A=
+=0A=
+    if (p->pid =3D=3D pid)=0A=
+      return FH_PROCESS;=0A=
+  }=0A=
+  return FH_PROC;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_proc::exists(const char *path)=0A=
+{=0A=
+  debug_printf ("exists (%s)", path);=0A=
+  path +=3D proc_len;=0A=
+  if (*path =3D=3D 0)=0A=
+    return 2;=0A=
+  for (int i=3D0;i<PROC_LINK_COUNT;i++)=0A=
+    if (pathmatch(path + 1, proc_listing[i]))=0A=
+      return (proc_fhandlers[i] =3D=3D FH_PROC) ? -1 : 1;=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+fhandler_proc::fhandler_proc () :=0A=
+  fhandler_virtual (FH_PROC)=0A=
+{=0A=
+}=0A=
+fhandler_proc::fhandler_proc (DWORD devtype) :=0A=
+  fhandler_virtual (devtype)=0A=
+{=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_proc::fstat (const char *path, struct stat *buf)=0A=
+{=0A=
+  debug_printf("fstat (%s)", path);=0A=
+  path +=3D proc_len;=0A=
+  if (*path =3D=3D 0) {=0A=
+    buf->st_mode =3D S_IFDIR | 0555;=0A=
+    buf->st_nlink =3D PROC_LINK_COUNT;=0A=
+    return 0;=0A=
+  }=0A=
+  else=0A=
+  {=0A=
+    for (int i=3D0;i<PROC_LINK_COUNT;i++)=0A=
+      if (pathmatch(path + 1, proc_listing[i]))=0A=
+      {=0A=
+        buf->st_mode =3D (proc_fhandlers[i] =3D=3D FH_PROC)?(S_IFREG | 044=
4):(S_IFDIR | 0555);=0A=
+        buf->st_nlink =3D 1;=0A=
+        return 0;=0A=
+     }=0A=
+  }=0A=
+  set_errno(ENOENT);=0A=
+  return -1;=0A=
+}=0A=
+=0A=
+struct dirent *=0A=
+fhandler_proc::readdir (DIR *dir)=0A=
+{=0A=
+  if (dir->__d_position >=3D PROC_LINK_COUNT)=0A=
+    {=0A=
+      winpids pids;=0A=
+      int found =3D 0;=0A=
+      for (unsigned i =3D 0; i < pids.npids; i++)=0A=
+      {=0A=
+        _pinfo *p =3D pids[i];=0A=
+=0A=
+        if (!proc_exists (p))=0A=
+          continue;=0A=
+=0A=
+        if (found =3D=3D dir->__d_position - PROC_LINK_COUNT)=0A=
+          {=0A=
+            __small_sprintf(dir->__d_dirent->d_name, "%d", p->pid);=0A=
+            dir->__d_position++;=0A=
+            return dir->__d_dirent;=0A=
+          }=0A=
+        found++;=0A=
+      }=0A=
+      return NULL;=0A=
+    }=0A=
+=0A=
+  strcpy(dir->__d_dirent->d_name, proc_listing[dir->__d_position++]);=0A=
+  syscall_printf ("%p =3D readdir (%p) (%s)", &dir->__d_dirent, dir,=0A=
+                  dir->__d_dirent->d_name);=0A=
+  return dir->__d_dirent;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_proc::open (const char *path, int flags, mode_t mode)=0A=
+{=0A=
+  int proc_file_no =3D -1;=0A=
+=0A=
+  int res =3D fhandler_virtual::open(path, flags, mode);=0A=
+  if (!res)=0A=
+    goto out;=0A=
+=0A=
+  path +=3D proc_len;=0A=
+=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno(EEXIST);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else if (mode & O_WRONLY)=0A=
+        {=0A=
+          set_errno(EISDIR);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          flags |=3D O_DIROPEN;=0A=
+          goto success;=0A=
+        }=0A=
+    }=0A=
+=0A=
+  proc_file_no =3D -1;=0A=
+  for (int i=3D0;i<PROC_LINK_COUNT;i++)=0A=
+    if (path_prefix_p(proc_listing[i], path + 1, strlen(proc_listing[i])))=
=0A=
+      {=0A=
+        proc_file_no =3D i;=0A=
+        if (proc_fhandlers[i] !=3D FH_PROC)=0A=
+          {=0A=
+            if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+              {=0A=
+                set_errno(EEXIST);=0A=
+                res =3D 0;=0A=
+                goto out;=0A=
+              }=0A=
+            else if (mode & O_WRONLY)=0A=
+              {=0A=
+                set_errno(EISDIR);=0A=
+                res =3D 0;=0A=
+                goto out;=0A=
+              }=0A=
+            else=0A=
+              {=0A=
+                flags |=3D O_DIROPEN;=0A=
+                goto success;=0A=
+              }=0A=
+           }=0A=
+      }=0A=
+=0A=
+  if (proc_file_no =3D=3D -1)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno(EROFS);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          set_errno(ENOENT);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+    }=0A=
+  if (mode & O_WRONLY)=0A=
+    {=0A=
+      set_errno(EROFS);=0A=
+      res =3D 0;=0A=
+      goto out;=0A=
+    }=0A=
+  switch(proc_file_no)=0A=
+    {=0A=
+      case PROC_VERSION:=0A=
+        {=0A=
+          struct utsname uts_name;=0A=
+          uname(&uts_name);=0A=
+          filesize =3D bufalloc =3D strlen(uts_name.sysname) + 1 +=0A=
+                                strlen(uts_name.release) + 1 +=0A=
+                                strlen(uts_name.version) + 2;=0A=
+          filebuf =3D new char[bufalloc];=0A=
+          __small_sprintf (filebuf, "%s %s %s\n", uts_name.sysname,=0A=
+                                                  uts_name.release,=0A=
+                                                  uts_name.version);=0A=
+          break;=0A=
+        }=0A=
+      case PROC_UPTIME:=0A=
+        {=0A=
+          /* GetTickCount() wraps after 49 days - on WinNT/2000/XP, should=
 use=0A=
+           * perfomance counters but I don't know Redhat's policy on=0A=
+           * NT only dependancies.=0A=
+           */=0A=
+          DWORD ticks =3D GetTickCount();=0A=
+          filebuf =3D new char[bufalloc =3D 40];=0A=
+          __small_sprintf(filebuf, "%d.%02d\n", ticks / 1000, (ticks / 10)=
 % 100);=0A=
+          filesize =3D strlen(filebuf);=0A=
+          break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+  if (flags & O_APPEND)=0A=
+    position =3D filesize;=0A=
+  else=0A=
+    position =3D 0;=0A=
+=0A=
+success:=0A=
+  res =3D 1;=0A=
+  set_open_status ();=0A=
+  set_flags(flags);=0A=
+out:=0A=
+  syscall_printf ("%d =3D fhandler_proc::open (%p, %d)", res, flags, mode)=
;=0A=
+  return res;=0A=
+}=0A=
diff -U 3 -p -b -B -N -x *.d cygwin.bak/fhandler_process.cc cygwin/fhandler=
_process.cc=0A=
--- cygwin.bak/fhandler_process.cc	Thu Jan  1 00:00:00 1970=0A=
+++ cygwin/fhandler_process.cc	Sat Feb  9 22:53:47 2002=0A=
@@ -0,0 +1,287 @@=0A=
+/* fhandler_process.cc */=0A=
+/*=0A=
+    (C) Copyright Christopher January 2002=0A=
+=20=20=20=20=0A=
+    This program is free software; you can redistribute it and/or modify=
=0A=
+    it under the terms of the GNU General Public License as published by=
=0A=
+    the Free Software Foundation; either version 2 of the License, or=0A=
+    (at your option) any later version.=0A=
+=0A=
+    This program is distributed in the hope that it will be useful,=0A=
+    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+    GNU General Public License for more details.=0A=
+=0A=
+    You should have received a copy of the GNU General Public License=0A=
+    along with this program; if not, write to the Free Software=0A=
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA=20=20=20=20=20=20=0A=
+*/=0A=
+=0A=
+=0A=
+#include "winsup.h"=0A=
+#include <sys/fcntl.h>=0A=
+#include <errno.h>=0A=
+#include <unistd.h>=0A=
+#include <stdlib.h>=0A=
+#include <sys/cygwin.h>=0A=
+#include "cygerrno.h"=0A=
+#include "security.h"=0A=
+#include "fhandler.h"=0A=
+#include "sigproc.h"=0A=
+#include "pinfo.h"=0A=
+#include "path.h"=0A=
+#include "shared_info.h"=0A=
+#include <assert.h>=0A=
+=0A=
+#define _COMPILING_NEWLIB=0A=
+#include <dirent.h>=0A=
+=0A=
+static const int PROCESS_PPID     =3D 0;=0A=
+static const int PROCESS_EXENAME  =3D 1;=0A=
+static const int PROCESS_WINPID   =3D 2;=0A=
+static const int PROCESS_WINEXENAME =3D 3;=0A=
+static const int PROCESS_STATUS   =3D 4;=0A=
+static const int PROCESS_UID      =3D 5;=0A=
+static const int PROCESS_GID      =3D 6;=0A=
+static const int PROCESS_PGID     =3D 7;=0A=
+static const int PROCESS_SID      =3D 8;=0A=
+static const int PROCESS_CTTY     =3D 9;=0A=
+static const int PROCESS_LINK_COUNT =3D 10;=0A=
+=0A=
+static const char *process_listing[PROCESS_LINK_COUNT] =3D { "ppid",=0A=
+                                                           "exename",=0A=
+                                                           "winpid",=0A=
+                                                           "winexename",=
=0A=
+                                                           "status",=0A=
+                                                           "uid",=0A=
+                                                           "gid",=0A=
+                                                           "pgid",=0A=
+                                                           "sid",=0A=
+                                                           "ctty" };=0A=
+=0A=
+int=0A=
+fhandler_process::exists(const char *path)=0A=
+{=0A=
+  debug_printf ("exists (%s)", path);=0A=
+  path +=3D proc_len + 1;=0A=
+  while (*path !=3D 0 && !SLASH_P(*path))=0A=
+    path++;=0A=
+  if (*path =3D=3D 0)=0A=
+    return 2;=0A=
+=0A=
+  for (int i=3D0;i<PROCESS_LINK_COUNT;i++)=0A=
+    if (pathmatch(path + 1, process_listing[i]))=0A=
+      return -1;=0A=
+  return 1;=0A=
+}=0A=
+=0A=
+fhandler_process::fhandler_process () :=0A=
+  fhandler_proc (FH_PROCESS)=0A=
+{=0A=
+=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_process::fstat (const char *path, struct stat *buf)=0A=
+{=0A=
+  int file_type =3D exists(path);=0A=
+  switch (file_type)=0A=
+    {=0A=
+      case 0:=0A=
+        set_errno(ENOENT);=0A=
+        return -1;=0A=
+      case 1:=0A=
+        buf->st_mode =3D S_IFDIR | 0555;=0A=
+        buf->st_nlink =3D 1;=0A=
+        return 0;=0A=
+      case 2:=0A=
+        buf->st_mode =3D S_IFDIR | 0555;=0A=
+        buf->st_nlink =3D PROCESS_LINK_COUNT;=0A=
+        return 0;=0A=
+      case -1:=0A=
+        buf->st_mode =3D S_IFREG | 0444;=0A=
+        buf->st_nlink =3D 1;=0A=
+        return 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+struct dirent *=0A=
+fhandler_process::readdir (DIR *dir)=0A=
+{=0A=
+  if (dir->__d_position >=3D PROCESS_LINK_COUNT)=0A=
+    return NULL;=0A=
+  strcpy(dir->__d_dirent->d_name, process_listing[dir->__d_position++]);=
=0A=
+  syscall_printf ("%p =3D readdir (%p) (%s)", &dir->__d_dirent, dir,=0A=
+                  dir->__d_dirent->d_name);=0A=
+  return dir->__d_dirent;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_process::open (const char *path, int flags, mode_t mode)=0A=
+{=0A=
+  int process_file_no =3D -1, pid;=0A=
+  winpids pids;=0A=
+  _pinfo *p;=0A=
+=0A=
+  int res =3D fhandler_virtual::open(path, flags, mode);=0A=
+  if (!res)=0A=
+    goto out;=0A=
+=0A=
+  path +=3D proc_len + 1;=0A=
+  pid =3D atoi(path);=0A=
+  while (*path !=3D 0 && !SLASH_P(*path))=0A=
+    path++;=0A=
+=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno(EEXIST);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else if (mode & O_WRONLY)=0A=
+        {=0A=
+          set_errno(EISDIR);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          flags |=3D O_DIROPEN;=0A=
+          goto success;=0A=
+        }=0A=
+    }=0A=
+=0A=
+  process_file_no =3D -1;=0A=
+  for (int i=3D0;i<PROCESS_LINK_COUNT;i++)=0A=
+    if (path_prefix_p(process_listing[i], path + 1, strlen(process_listing=
[i])))=0A=
+        process_file_no =3D i;=0A=
+  if (process_file_no =3D=3D -1)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno(EROFS);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          set_errno(ENOENT);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+    }=0A=
+  if (mode & O_WRONLY)=0A=
+    {=0A=
+      set_errno(EROFS);=0A=
+      res =3D 0;=0A=
+      goto out;=0A=
+    }=0A=
+  debug_printf("here");=0A=
+  for (unsigned i =3D 0; i < pids.npids; i++)=0A=
+  {=0A=
+    p =3D pids[i];=0A=
+=0A=
+    if (!proc_exists (p))=0A=
+      continue;=0A=
+=0A=
+    if (p->pid =3D=3D pid)=0A=
+      goto found;=0A=
+  }=0A=
+  set_errno(ENOENT);=0A=
+  res =3D 0;=0A=
+  goto out;=0A=
+found:=0A=
+  switch(process_file_no)=0A=
+    {=0A=
+      case PROCESS_UID:=0A=
+      case PROCESS_GID:=0A=
+      case PROCESS_PGID:=0A=
+      case PROCESS_SID:=0A=
+      case PROCESS_CTTY:=0A=
+      case PROCESS_PPID:=0A=
+        {=0A=
+          filebuf =3D new char[bufalloc =3D 40];=0A=
+          int num;=0A=
+          switch (process_file_no) {=0A=
+            case PROCESS_PPID:=0A=
+              num =3D p->ppid; break;=0A=
+            case PROCESS_UID:=0A=
+              num =3D p->uid; break;=0A=
+            case PROCESS_PGID:=0A=
+              num =3D p->pgid; break;=0A=
+            case PROCESS_SID:=0A=
+              num =3D p->sid; break;=0A=
+            case PROCESS_CTTY:=0A=
+              num =3D p->ctty; break;=0A=
+          }=0A=
+          __small_sprintf(filebuf, "%d\n", num);=0A=
+          filesize =3D strlen(filebuf);=0A=
+          break;=0A=
+        }=0A=
+      case PROCESS_EXENAME:=0A=
+        {=0A=
+          filebuf =3D new char[bufalloc =3D MAX_PATH];=0A=
+          if (p->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
+            strcpy(filebuf, "<defunct>");=0A=
+          else=0A=
+            {=0A=
+              mount_table->conv_to_posix_path (p->progname, filebuf, 1);=
=0A=
+              int len =3D strlen(filebuf);=0A=
+              if (len > 4)=0A=
+                {=0A=
+                  char *s =3D filebuf + len - 4;=0A=
+                  if (strcasecmp(s, ".exe") =3D=3D 0)=0A=
+                    *s =3D 0;=0A=
+                }=0A=
+            }=0A=
+          filesize =3D strlen(filebuf);=0A=
+          break;=0A=
+        }=0A=
+      case PROCESS_WINPID:=0A=
+        {=0A=
+          filebuf =3D new char[bufalloc =3D 40];=0A=
+          __small_sprintf(filebuf, "%d\n", p->dwProcessId);=0A=
+          filesize =3D strlen(filebuf);=0A=
+          break;=0A=
+        }=0A=
+      case PROCESS_WINEXENAME:=0A=
+        {=0A=
+          int len =3D strlen(p->progname);=0A=
+          filebuf =3D new char[len + 2];=0A=
+          strcpy(filebuf, p->progname);=0A=
+          filebuf[len] =3D '\n';=0A=
+          filesize =3D len + 1;=0A=
+          break;=0A=
+        }=0A=
+      case PROCESS_STATUS:=0A=
+        {=0A=
+          filebuf =3D new char[bufalloc =3D 3];=0A=
+          filebuf[0] =3D ' ';=0A=
+          filebuf[1] =3D '\n';=0A=
+          filebuf[2] =3D 0;=0A=
+          if (p->process_state & PID_STOPPED)=0A=
+            filebuf[0] =3D 'S';=0A=
+          else if (p->process_state & PID_TTYIN)=0A=
+            filebuf[0] =3D 'I';=0A=
+          else if (p->process_state & PID_TTYOU)=0A=
+            filebuf[0] =3D 'O';=0A=
+          filesize =3D 2;=0A=
+          break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+  if (flags & O_APPEND)=0A=
+    position =3D filesize;=0A=
+  else=0A=
+    position =3D 0;=0A=
+=0A=
+success:=0A=
+  res =3D 1;=0A=
+  set_open_status ();=0A=
+  set_flags(flags);=0A=
+out:=0A=
+  syscall_printf ("%d =3D fhandler_proc::open (%p, %d)", res, flags, mode)=
;=0A=
+  return res;=0A=
+}=0A=
diff -U 3 -p -b -B -N -x *.d cygwin.bak/fhandler_registry.cc cygwin/fhandle=
r_registry.cc=0A=
--- cygwin.bak/fhandler_registry.cc	Thu Jan  1 00:00:00 1970=0A=
+++ cygwin/fhandler_registry.cc	Sat Feb  9 22:53:51 2002=0A=
@@ -0,0 +1,502 @@=0A=
+/* fhandler_registry.cc */=0A=
+/*=0A=
+    (C) Copyright Christopher January 2002=0A=
+=20=20=20=20=0A=
+    This program is free software; you can redistribute it and/or modify=
=0A=
+    it under the terms of the GNU General Public License as published by=
=0A=
+    the Free Software Foundation; either version 2 of the License, or=0A=
+    (at your option) any later version.=0A=
+=0A=
+    This program is distributed in the hope that it will be useful,=0A=
+    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+    GNU General Public License for more details.=0A=
+=0A=
+    You should have received a copy of the GNU General Public License=0A=
+    along with this program; if not, write to the Free Software=0A=
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA=20=20=20=20=20=20=0A=
+*/=0A=
+=0A=
+=0A=
+/* access permissions are ignored at the moment... */=0A=
+/* use splipath ? */=0A=
+=0A=
+#include "winsup.h"=0A=
+#include <sys/fcntl.h>=0A=
+#include <errno.h>=0A=
+#include <unistd.h>=0A=
+#include <stdlib.h>=0A=
+#include <sys/cygwin.h>=0A=
+#include "cygerrno.h"=0A=
+#include "security.h"=0A=
+#include "fhandler.h"=0A=
+#include "path.h"=0A=
+#include <assert.h>=0A=
+=0A=
+#define _COMPILING_NEWLIB=0A=
+#include <dirent.h>=0A=
+=0A=
+const int registry_len =3D strlen("registry");=0A=
+/* if this bit is set in __d_position then we are enumerating values,=0A=
+ * else sub-keys. keeping track of where we are is horribly messy=0A=
+ * the bottom 16 bits are the absolute position and the top 15 bits=0A=
+ * make up the value index if we are enuerating values.=0A=
+ */=0A=
+const off_t REG_ENUM_VALUES_MASK =3D 0x8000000;=0A=
+=0A=
+const int ROOT_KEY_COUNT =3D 7;=0A=
+=0A=
+/* root keys in /proc/registry=0A=
+ * possibly we should filter out those not relevant to the flavour of Wind=
ows=0A=
+ * cygwin is running on=0A=
+ */=0A=
+static const char *registry_listing[ROOT_KEY_COUNT] =3D { "HKEY_CLASSES_RO=
OT",=0A=
+                                                        "HKEY_CURRENT_CONF=
IG",=0A=
+                                                        "HKEY_CURRENT_USER=
",=0A=
+                                                        "HKEY_LOCAL_MACHIN=
E",=0A=
+                                                        "HKEY_USERS",=0A=
+                                                        "HKEY_DYN_DATA",  =
        // 95/98/Me=0A=
+                                                        "HKEY_PERFOMANCE_D=
ATA" }; // NT/2000/XP=0A=
+static HKEY registry_keys[ROOT_KEY_COUNT] =3D { HKEY_CLASSES_ROOT,=0A=
+                                              HKEY_CURRENT_CONFIG,=0A=
+                                              HKEY_CURRENT_USER,=0A=
+                                              HKEY_LOCAL_MACHINE,=0A=
+                                              HKEY_USERS,=0A=
+                                              HKEY_DYN_DATA,=0A=
+                                              HKEY_PERFORMANCE_DATA };=0A=
+=0A=
+const char *DEFAULT_VALUE_NAME =3D "@";=0A=
+=0A=
+/* we open the last key but one and then enum it's sub-keys and values to =
see if the=0A=
+ * final component is there. this gets round the problem of not having sec=
urity access=0A=
+ * to the final key in the path.=0A=
+ */=0A=
+=0A=
+int fhandler_registry::exists(const char *path)=0A=
+{=0A=
+  int file_type =3D 0, index =3D 0, pathlen;=0A=
+  DWORD buf_size =3D MAX_PATH;=0A=
+  LONG error;=0A=
+  char buf[buf_size];=0A=
+  const char *file;=0A=
+  HKEY hKey =3D (HKEY)INVALID_HANDLE_VALUE;=0A=
+=0A=
+  debug_printf ("exists (%s)", path);=0A=
+  path +=3D proc_len + 1 + registry_len;=0A=
+  if (*path =3D=3D 0)=0A=
+  {=0A=
+    file_type =3D 2;=0A=
+    goto out;=0A=
+  }=0A=
+=0A=
+  path++;=0A=
+  pathlen =3D strlen(path);=0A=
+  file =3D path + pathlen - 1;=0A=
+  if (SLASH_P(*file) && pathlen > 1)=0A=
+    file--;=0A=
+  while (!SLASH_P(*file))=0A=
+    file--;=0A=
+  file++;=0A=
+=0A=
+  if (file =3D=3D path)=0A=
+    {=0A=
+        for (int i=3D0;i<ROOT_KEY_COUNT;i++)=0A=
+          if (path_prefix_p(registry_listing[i], path, strlen(registry_lis=
ting[i])))=0A=
+            {=0A=
+              file_type =3D 1;=0A=
+              goto out;=0A=
+            }=0A=
+        goto out;=0A=
+    }=0A=
+=0A=
+  hKey =3D open_key(path, KEY_READ, true);=0A=
+  if (hKey =3D=3D (HKEY)INVALID_HANDLE_VALUE)=0A=
+      return 0;=0A=
+=0A=
+  while (ERROR_SUCCESS =3D=3D=0A=
+         (error =3D RegEnumKeyEx(hKey, index++, buf, &buf_size, NULL, NULL=
,=0A=
+                               NULL, NULL)) ||=0A=
+         (error =3D=3D ERROR_MORE_DATA))=0A=
+    {=0A=
+      if (pathmatch(buf, file))=0A=
+        {=0A=
+          file_type =3D 1;=0A=
+          goto out;=0A=
+        }=0A=
+      buf_size =3D MAX_PATH;=0A=
+  }=0A=
+  if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
+    {=0A=
+      seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+      goto out;=0A=
+   }=0A=
+  index =3D 0;=0A=
+  buf_size =3D MAX_PATH;=0A=
+  while (ERROR_SUCCESS =3D=3D=0A=
+         (error =3D RegEnumValue(hKey, index++, buf, &buf_size, NULL, NULL=
,=0A=
+                               NULL, NULL)) ||=0A=
+         (error =3D=3D ERROR_MORE_DATA))=0A=
+    {=0A=
+      if (pathmatch(buf, file) || (buf[0] =3D=3D '\0' &&=0A=
+          pathmatch(file, DEFAULT_VALUE_NAME)))=0A=
+        {=0A=
+          file_type =3D -1;=0A=
+          goto out;=0A=
+        }=0A=
+     buf_size =3D MAX_PATH;=0A=
+  }=0A=
+  if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
+    {=0A=
+      seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+      goto out;=0A=
+   }=0A=
+out:=0A=
+  if (hKey !=3D (HKEY)INVALID_HANDLE_VALUE)=0A=
+    RegCloseKey(hKey);=0A=
+  return file_type;=0A=
+}=0A=
+=0A=
+fhandler_registry::fhandler_registry () :=0A=
+  fhandler_proc (FH_REGISTRY)=0A=
+{=0A=
+=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_registry::fstat (const char *path, struct stat *buf)=0A=
+{=0A=
+  int file_type =3D exists(path);=0A=
+  switch (file_type)=0A=
+    {=0A=
+      case 0:=0A=
+        set_errno(ENOENT);=0A=
+        return -1;=0A=
+      case 1:=0A=
+        buf->st_mode =3D S_IFDIR | 0555;=0A=
+        buf->st_nlink =3D 1;=0A=
+        return 0;=0A=
+      case 2:=0A=
+        buf->st_mode =3D S_IFDIR | 0555;=0A=
+        buf->st_nlink =3D ROOT_KEY_COUNT;=0A=
+        return 0;=0A=
+      case -1:=0A=
+        buf->st_mode =3D S_IFREG | 0444;=0A=
+        buf->st_nlink =3D 1;=0A=
+        return 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+struct dirent *=0A=
+fhandler_registry::readdir (DIR *dir)=0A=
+{=0A=
+  DWORD buf_size =3D MAX_PATH;=0A=
+  char buf[buf_size];=0A=
+  HANDLE handle;=0A=
+  struct dirent *res =3D NULL;=0A=
+  const char *path =3D dir->__d_dirname + proc_len + 1 + registry_len;=0A=
+  LONG error;=0A=
+=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      if (dir->__d_position >=3D ROOT_KEY_COUNT)=0A=
+        goto out;=0A=
+      strcpy(dir->__d_dirent->d_name, registry_listing[dir->__d_position++=
]);=0A=
+      res =3D dir->__d_dirent;=0A=
+      goto out;=0A=
+   }=0A=
+=0A=
+  if (dir->__d_u.__d_data.__handle =3D=3D INVALID_HANDLE_VALUE=0A=
+      && dir->__d_position =3D=3D 0)=0A=
+    {=0A=
+      handle =3D open_key(path + 1);=0A=
+      dir->__d_u.__d_data.__handle =3D handle;=0A=
+    }=0A=
+  if (dir->__d_u.__d_data.__handle =3D=3D INVALID_HANDLE_VALUE)=0A=
+    goto out;=0A=
+retry:=0A=
+  if (dir->__d_position & REG_ENUM_VALUES_MASK)=0A=
+    /* for the moment, the type of key is ignored here. when write access =
is added,=0A=
+     * maybe add an extension for the type of each value?=0A=
+     */=0A=
+    error =3D RegEnumValue((HKEY)dir->__d_u.__d_data.__handle,=0A=
+                         (dir->__d_position & ~REG_ENUM_VALUES_MASK) >> 16=
,=0A=
+                         buf, &buf_size, NULL, NULL, NULL, NULL);=0A=
+  else=0A=
+    error =3D RegEnumKeyEx((HKEY)dir->__d_u.__d_data.__handle, dir->__d_po=
sition, buf,=0A=
+                         &buf_size, NULL, NULL, NULL, NULL);=0A=
+  if (error =3D=3D ERROR_NO_MORE_ITEMS && (dir->__d_position & REG_ENUM_VA=
LUES_MASK) =3D=3D 0)=0A=
+    {=0A=
+      /* if we're finished with sub-keys, start on values under this key *=
/=0A=
+      dir->__d_position |=3D REG_ENUM_VALUES_MASK;=0A=
+      buf_size =3D MAX_PATH;=0A=
+      goto retry;=0A=
+    }=0A=
+  if (error !=3D ERROR_SUCCESS && error !=3D ERROR_MORE_DATA)=0A=
+    {=0A=
+      RegCloseKey ((HKEY)dir->__d_u.__d_data.__handle);=0A=
+      dir->__d_u.__d_data.__handle =3D INVALID_HANDLE_VALUE;=0A=
+      if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
+          seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+      goto out;=0A=
+    }=0A=
+=0A=
+  /* We get here if `buf' contains valid data.  */=0A=
+  if (*buf =3D=3D 0)=0A=
+    strcpy (dir->__d_dirent->d_name, DEFAULT_VALUE_NAME);=0A=
+  else=0A=
+    strcpy (dir->__d_dirent->d_name, buf);=0A=
+=0A=
+  dir->__d_position++;=0A=
+  if (dir->__d_position & REG_ENUM_VALUES_MASK)=0A=
+    dir->__d_position +=3D 0x10000;=0A=
+  res =3D dir->__d_dirent;=0A=
+out:=0A=
+  syscall_printf ("%p =3D readdir (%p) (%s)",=0A=
+      &dir->__d_dirent, dir, buf);=0A=
+  return res;=0A=
+}=0A=
+=0A=
+off_t=0A=
+fhandler_registry::telldir (DIR *dir)=0A=
+{=0A=
+  return dir->__d_position & REG_ENUM_VALUES_MASK;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_registry::seekdir (DIR *dir, off_t loc)=0A=
+{=0A=
+  /* unfortunately cannot just set __d_position due to transition from sub=
-keys to=0A=
+   * values.=0A=
+   */=0A=
+  rewinddir (dir);=0A=
+  while (loc > dir->__d_position)=0A=
+    if (!readdir (dir))=0A=
+  break;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_registry::rewinddir (DIR *dir)=0A=
+{=0A=
+  if (dir->__d_u.__d_data.__handle !=3D INVALID_HANDLE_VALUE)=0A=
+    {=0A=
+      (void) RegCloseKey ((HKEY)dir->__d_u.__d_data.__handle);=0A=
+      dir->__d_u.__d_data.__handle =3D INVALID_HANDLE_VALUE;=0A=
+    }=0A=
+  dir->__d_position =3D 0;=0A=
+  return;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_registry::closedir (DIR *dir)=0A=
+{=0A=
+  int res =3D 0;=0A=
+  if (dir->__d_u.__d_data.__handle !=3D INVALID_HANDLE_VALUE &&=0A=
+      RegCloseKey ((HKEY)dir->__d_u.__d_data.__handle) !=3D ERROR_SUCCESS)=
=0A=
+    {=0A=
+      __seterrno ();=0A=
+      res =3D -1;=0A=
+    }=0A=
+  syscall_printf ("%d =3D closedir (%p)", res, dir);=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_registry::open (const char *path, int flags, mode_t mode)=0A=
+{=0A=
+  DWORD type, size;=0A=
+  LONG error;=0A=
+  HKEY hKey =3D (HKEY)INVALID_HANDLE_VALUE;=0A=
+  int pathlen;=0A=
+  const char *file;=0A=
+=0A=
+  int res =3D fhandler_virtual::open(path, flags, mode);=0A=
+  if (!res)=0A=
+    goto out;=0A=
+=0A=
+  path +=3D proc_len + 1 + registry_len;=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno(EEXIST);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else if (mode & O_WRONLY)=0A=
+        {=0A=
+          set_errno(EISDIR);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          flags |=3D O_DIROPEN;=0A=
+          goto success;=0A=
+        }=0A=
+    }=0A=
+  path++;=0A=
+  pathlen =3D strlen(path);=0A=
+  file =3D path + pathlen - 1;=0A=
+  if (SLASH_P(*file) && pathlen > 1)=0A=
+    file--;=0A=
+  while (!SLASH_P(*file))=0A=
+    file--;=0A=
+  file++;=0A=
+=0A=
+  if (file =3D=3D path)=0A=
+    {=0A=
+      for (int i=3D0;i<ROOT_KEY_COUNT;i++)=0A=
+        if (path_prefix_p(registry_listing[i], path, strlen(registry_listi=
ng[i])))=0A=
+          {=0A=
+            if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+              {=0A=
+                set_errno(EEXIST);=0A=
+                res =3D 0;=0A=
+                goto out;=0A=
+              }=0A=
+            else if (mode & O_WRONLY)=0A=
+              {=0A=
+                set_errno(EISDIR);=0A=
+                res =3D 0;=0A=
+                goto out;=0A=
+              }=0A=
+            else=0A=
+              {=0A=
+                flags |=3D O_DIROPEN;=0A=
+                goto success;=0A=
+              }=0A=
+          }=0A=
+=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno(EROFS);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          set_errno(ENOENT);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+    }=0A=
+=0A=
+  hKey =3D open_key(path, KEY_READ, true);=0A=
+  if (hKey =3D=3D (HKEY)INVALID_HANDLE_VALUE)=0A=
+    {=0A=
+      res =3D 0;=0A=
+      goto out;=0A=
+    }=0A=
+  if (mode & O_WRONLY)=0A=
+    {=0A=
+      set_errno(EROFS);=0A=
+      res =3D 0;=0A=
+      goto out;=0A=
+    }=0A=
+  if (pathmatch(file, DEFAULT_VALUE_NAME))=0A=
+    file =3D "";=0A=
+=0A=
+  if (hKey !=3D HKEY_PERFORMANCE_DATA)=0A=
+    {=0A=
+      error =3D RegQueryValueEx(hKey, file, NULL, &type, NULL, &size);=0A=
+      if (error !=3D ERROR_SUCCESS)=0A=
+        {=0A=
+          seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+          res =3D -1;=0A=
+          goto out;=0A=
+        }=0A=
+      bufalloc =3D size;=0A=
+      filebuf =3D new char[bufalloc];=0A=
+      error =3D RegQueryValueEx(hKey, file, NULL, NULL, (BYTE *)filebuf, &=
size);=0A=
+      if (error !=3D ERROR_SUCCESS)=0A=
+        {=0A=
+          seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      filesize =3D size;=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      bufalloc =3D 0;=0A=
+      do {=0A=
+        bufalloc +=3D 1000;=0A=
+        if (filebuf)=0A=
+          {=0A=
+            delete filebuf; filebuf =3D new char[bufalloc];=0A=
+          }=0A=
+        error =3D RegQueryValueEx(hKey, file, NULL, &type, (BYTE *)filebuf=
, &size);=0A=
+        if (error !=3D ERROR_SUCCESS && res !=3D ERROR_MORE_DATA)=0A=
+          {=0A=
+            seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+            res =3D 0;=0A=
+            goto out;=0A=
+          }=0A=
+       } while (error =3D=3D ERROR_MORE_DATA);=0A=
+       filesize =3D size;=0A=
+    }=0A=
+=0A=
+  if (flags & O_APPEND)=0A=
+    position =3D filesize;=0A=
+  else=0A=
+    position =3D 0;=0A=
+=0A=
+success:=0A=
+  res =3D 1;=0A=
+  set_open_status ();=0A=
+  set_flags(flags);=0A=
+out:=0A=
+  if (hKey !=3D (HKEY)INVALID_HANDLE_VALUE)=0A=
+    RegCloseKey(hKey);=0A=
+  syscall_printf ("%d =3D fhandler_registry::open (%p, %d)", res, flags, m=
ode);=0A=
+  return res;=0A=
+}=0A=
+=0A=
+/* auxillary member functions */=0A=
+=0A=
+HKEY=0A=
+fhandler_registry::open_key(const char *name, REGSAM access =3D KEY_READ, =
bool isValue =3D false)=0A=
+{=0A=
+  HKEY hKey =3D (HKEY)INVALID_HANDLE_VALUE;=0A=
+  HKEY hParentKey =3D (HKEY)INVALID_HANDLE_VALUE;=0A=
+  bool parentOpened =3D false;=0A=
+  char component[MAX_PATH];=0A=
+=0A=
+  while (*name) {=0A=
+    const char *anchor =3D name;=0A=
+    while (*name && !SLASH_P(*name))=0A=
+      name++;=0A=
+    strncpy(component, anchor, name-anchor);=0A=
+    component[name-anchor] =3D '\0';=0A=
+    if (*name)=0A=
+      name++;=0A=
+    if (*name =3D=3D 0 && isValue =3D=3D true)=0A=
+      goto out;=0A=
+=0A=
+    if (hParentKey !=3D (HKEY)INVALID_HANDLE_VALUE)=0A=
+      {=0A=
+        hKey =3D (HKEY)INVALID_HANDLE_VALUE;=0A=
+        LONG error =3D RegOpenKeyEx(hParentKey, component, 0, access, &hKe=
y);=0A=
+        if (hKey =3D=3D (HKEY)INVALID_HANDLE_VALUE)=0A=
+          {=0A=
+            seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+            return hKey;=0A=
+          }=0A=
+        if (parentOpened)=0A=
+          RegCloseKey(hParentKey);=0A=
+        hParentKey =3D hKey;=0A=
+        parentOpened =3D true;=0A=
+      }=0A=
+    else=0A=
+      {=0A=
+        for (int i=3D0;i<ROOT_KEY_COUNT;i++)=0A=
+          if (pathmatch(component, registry_listing[i]))=0A=
+            hKey =3D registry_keys[i];=0A=
+        if (hKey =3D=3D (HKEY)INVALID_HANDLE_VALUE)=0A=
+          return hKey;=0A=
+        hParentKey =3D hKey;=0A=
+      }=0A=
+  }=0A=
+out:=0A=
+  return hKey;=0A=
+}=0A=
diff -U 3 -p -b -B -N -x *.d cygwin.bak/fhandler_virtual.cc cygwin/fhandler=
_virtual.cc=0A=
--- cygwin.bak/fhandler_virtual.cc	Thu Jan  1 00:00:00 1970=0A=
+++ cygwin/fhandler_virtual.cc	Sat Feb  9 22:53:56 2002=0A=
@@ -0,0 +1,238 @@=0A=
+/* fhandler_virtual.cc */=0A=
+/* at least unames and unlink don't work with virtual fhandlers yet */=0A=
+/*=0A=
+    (C) Copyright Christopher January 2002=0A=
+=20=20=20=20=0A=
+    This program is free software; you can redistribute it and/or modify=
=0A=
+    it under the terms of the GNU General Public License as published by=
=0A=
+    the Free Software Foundation; either version 2 of the License, or=0A=
+    (at your option) any later version.=0A=
+=0A=
+    This program is distributed in the hope that it will be useful,=0A=
+    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+    GNU General Public License for more details.=0A=
+=0A=
+    You should have received a copy of the GNU General Public License=0A=
+    along with this program; if not, write to the Free Software=0A=
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA=20=20=20=20=20=20=0A=
+*/=0A=
+=0A=
+=0A=
+#include "winsup.h"=0A=
+#include <sys/fcntl.h>=0A=
+#include <errno.h>=0A=
+#include <unistd.h>=0A=
+#include <stdlib.h>=0A=
+#include <sys/cygwin.h>=0A=
+#include "cygerrno.h"=0A=
+#include "security.h"=0A=
+#include "fhandler.h"=0A=
+#include "path.h"=0A=
+#include "dtable.h"=0A=
+#include "cygheap.h"=0A=
+#include "shared_info.h"=0A=
+#include <assert.h>=0A=
+=0A=
+#define _COMPILING_NEWLIB=0A=
+#include <dirent.h>=0A=
+=0A=
+fhandler_virtual::fhandler_virtual (DWORD devtype) :=0A=
+  fhandler_base (devtype), filebuf(NULL), bufalloc(-1)=0A=
+{=0A=
+}=0A=
+fhandler_virtual::~fhandler_virtual()=0A=
+{=0A=
+    if (filebuf)=0A=
+      delete filebuf; filebuf =3D NULL;=0A=
+}=0A=
+=0A=
+DIR *=0A=
+fhandler_virtual::opendir (const char *path)=0A=
+{=0A=
+  DIR *dir;=0A=
+  DIR *res =3D NULL;=0A=
+  size_t len;=0A=
+=0A=
+  if (exists(path) <=3D 0)=0A=
+    set_errno (ENOTDIR);=0A=
+  else if ((len =3D strlen (path))> MAX_PATH - 3)=0A=
+    set_errno (ENAMETOOLONG);=0A=
+  else if ((dir =3D (DIR *) malloc (sizeof (DIR))) =3D=3D NULL)=0A=
+    set_errno (ENOMEM);=0A=
+  else if ((dir->__d_dirname =3D (char *) malloc (len + 3)) =3D=3D NULL)=
=0A=
+    {=0A=
+      free (dir);=0A=
+      set_errno (ENOMEM);=0A=
+    }=0A=
+  else if ((dir->__d_dirent =3D=0A=
+      (struct dirent *) malloc (sizeof (struct dirent))) =3D=3D NULL)=0A=
+    {=0A=
+      free (dir);=0A=
+      set_errno (ENOMEM);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      strcpy(dir->__d_dirname, path);=0A=
+      dir->__d_dirent->d_version =3D __DIRENT_VERSION;=0A=
+      cygheap_fdnew fd;=0A=
+      fd =3D this;=0A=
+      fd->set_nohandle (true);=0A=
+      dir->__d_dirent->d_fd =3D fd;=0A=
+      dir->__d_u.__d_data.__fh =3D this;=0A=
+      dir->__d_cookie =3D __DIRENT_COOKIE;=0A=
+      dir->__d_u.__d_data.__handle =3D INVALID_HANDLE_VALUE;=0A=
+      dir->__d_position =3D 0;=0A=
+      dir->__d_dirhash =3D get_namehash ();=0A=
+=0A=
+      res =3D dir;=0A=
+    }=0A=
+=0A=
+  syscall_printf ("%p =3D opendir (%s)", res, get_name ());=0A=
+  return res;=0A=
+}=0A=
+=0A=
+=0A=
+DIR *=0A=
+fhandler_virtual::opendir (path_conv& real_name)=0A=
+{=0A=
+  normalize_posix_path(get_name(), normalized_path);=0A=
+  return opendir(normalized_path);=0A=
+}=0A=
+=0A=
+off_t=0A=
+fhandler_virtual::telldir (DIR *dir)=0A=
+{=0A=
+  return dir->__d_position;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_virtual::seekdir (DIR *dir, off_t loc)=0A=
+{=0A=
+  dir->__d_position =3D loc;=0A=
+  return;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_virtual::rewinddir (DIR *dir)=0A=
+{=0A=
+  dir->__d_position =3D 0;=0A=
+  return;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::closedir (DIR *dir)=0A=
+{=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+off_t=0A=
+fhandler_virtual::lseek (off_t offset, int whence)=0A=
+{=0A=
+  switch (whence)=0A=
+    {=0A=
+      case SEEK_SET:=0A=
+        position =3D offset;=0A=
+        break;=0A=
+      case SEEK_CUR:=0A=
+        position +=3D offset;=0A=
+        break;=0A=
+      case SEEK_END:=0A=
+        position =3D filesize + offset;=0A=
+        break;=0A=
+      default:=0A=
+        set_errno(EINVAL);=0A=
+        return (off_t)-1;=0A=
+    }=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::dup (fhandler_base *child)=0A=
+{=0A=
+  fhandler_virtual *fhproc_child =3D (fhandler_virtual *)child;=0A=
+  fhproc_child->filebuf =3D new char[filesize];=0A=
+  fhproc_child->bufalloc =3D fhproc_child->filesize =3D filesize;=0A=
+  fhproc_child->position =3D position;=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::close ()=0A=
+{=0A=
+  if (filebuf)=0A=
+    delete [] filebuf; filebuf =3D NULL; bufalloc =3D -1;=0A=
+  cygwin_shared->delqueue.process_queue ();=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::read (void *ptr, size_t len)=0A=
+{=0A=
+  if (len =3D=3D 0)=0A=
+    return 0;=0A=
+  if (openflags & O_DIROPEN) {=0A=
+    set_errno(EISDIR);=0A=
+    return -1;=0A=
+  }=0A=
+  if (!filebuf)=0A=
+    return 0;=0A=
+  int read =3D max(0, min(len, filesize - position));=0A=
+  if (read >=3D 0)=0A=
+    memcpy(ptr, filebuf + position, read);=0A=
+  position +=3D read;=0A=
+  return read;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::write (const void *ptr, size_t len)=0A=
+{=0A=
+  set_errno(EROFS);=0A=
+  return -1;=0A=
+}=0A=
+=0A=
+/* low-level open for all proc files */=0A=
+int=0A=
+fhandler_virtual::open (const char *normalized_path, int flags, mode_t mod=
e)=0A=
+{=0A=
+  set_r_binary (1);=0A=
+  set_w_binary (1);=0A=
+=0A=
+  set_has_acls (false);=0A=
+  set_isremote (false);=0A=
+=0A=
+  /* what to do about symlinks? */=0A=
+  set_symlink_p (false);=0A=
+  set_execable_p (not_executable);=0A=
+  set_socket_p (false);=0A=
+=0A=
+  set_flags(flags);=0A=
+=0A=
+  return 1;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::open (path_conv *real_path, int flags, mode_t mode)=0A=
+{=0A=
+  normalize_posix_path(get_name(), normalized_path);=0A=
+  return open(normalized_path, flags, mode);=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::fstat (struct stat *buf, path_conv *pc)=0A=
+{=0A=
+  normalize_posix_path(get_name(), normalized_path);=0A=
+  return fstat(normalized_path, buf);=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::fstat(const char *path, struct stat *buf)=0A=
+{=0A=
+  set_errno(ENOENT);=0A=
+  return -1;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::exists(const char *path)=0A=
+{=0A=
+  return 0;=0A=
+}=0A=
diff -U 3 -p -b -B -N -x *.d cygwin.bak/path.cc cygwin/path.cc=0A=
--- cygwin.bak/path.cc	Mon Feb  4 22:18:37 2002=0A=
+++ cygwin/path.cc	Sat Feb  9 22:17:09 2002=0A=
@@ -118,6 +118,12 @@ int pcheck_case =3D PCHECK_RELAXED; /* Det=0A=
    (isdirsep(path[mount_table->cygdrive_len + 1]) || \=0A=
     !path[mount_table->cygdrive_len + 1]))=0A=
=20=0A=
+#define isproc(path) \=0A=
+  (path_prefix_p (proc, (path), proc_len))=0A=
+=0A=
+#define isvirtual_dev(devn) \=0A=
+  (devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_PROC || devn =3D=3D FH_REGIST=
RY || devn =3D=3D FH_PROCESS)=0A=
+=0A=
 /* Return non-zero if PATH1 is a prefix of PATH2.=0A=
    Both are assumed to be of the same path style and / vs \ usage.=0A=
    Neither may be "".=0A=
@@ -490,6 +496,11 @@ path_conv::check (const char *src, unsig=0A=
 		}=0A=
 	      goto out;=0A=
 	    }=0A=
+    else if (isvirtual_dev(devn))=0A=
+    {=0A=
+      fileattr =3D 0;=0A=
+      return;=0A=
+    }=0A=
 	  /* devn should not be a device.  If it is, then stop parsing now. */=0A=
 	  else if (devn !=3D FH_BAD)=0A=
 	    {=0A=
@@ -1405,10 +1416,17 @@ mount_info::conv_to_win32_path (const ch=0A=
       else if (mount_table->cygdrive_len > 1)=0A=
 	return ENOENT;=0A=
     }=0A=
+  if (isproc (pathbuf))=0A=
+  {=0A=
+    devn =3D fhandler_proc::get_proc_fhandler(pathbuf);=0A=
+    debug_printf("returned %d\n", devn);=0A=
+    dst[0] =3D '\0';=0A=
+    goto out;=0A=
+  }=0A=
=20=0A=
   int chrooted_path_len;=0A=
   chrooted_path_len =3D 0;=0A=
-  /* Check the mount table for prefix matches. */=0A=
+  /* Check the mount table for prefix matches */=0A=
   for (i =3D 0; i < nmounts; i++)=0A=
     {=0A=
       const char *path;=0A=
@@ -1472,7 +1490,7 @@ mount_info::conv_to_win32_path (const ch=0A=
       *flags =3D mi->flags;=0A=
     }=0A=
=20=0A=
-  if (devn !=3D FH_CYGDRIVE)=0A=
+  if (!isvirtual_dev(devn))=0A=
     win32_device_name (src_path, dst, devn, unit);=0A=
=20=0A=
  out:=0A=
@@ -3233,7 +3251,8 @@ chdir (const char *in_dir)=0A=
       path.get_win32 ()[3] =3D '\0';=0A=
     }=0A=
   int res;=0A=
-  if (path.get_devn () !=3D FH_CYGDRIVE)=0A=
+  int devn =3D path.get_devn();=0A=
+  if (!isvirtual_dev(devn))=0A=
     res =3D SetCurrentDirectory (native_dir) ? 0 : -1;=0A=
   else=0A=
     {=0A=
diff -U 3 -p -b -B -N -x *.d cygwin.bak/path.h cygwin/path.h=0A=
--- cygwin.bak/path.h	Mon Feb  4 22:18:37 2002=0A=
+++ cygwin/path.h	Fri Feb  8 12:17:10 2002=0A=
@@ -178,3 +178,6 @@ has_exec_chars (const char *buf, int len=0A=
=20=0A=
 int pathmatch (const char *path1, const char *path2) __attribute__ ((regpa=
rm (2)));=0A=
 int pathnmatch (const char *path1, const char *path2, int len) __attribute=
__ ((regparm (2)));=0A=
+=0A=
+int path_prefix_p (const char *path1, const char *path2, int len1) __attri=
bute__ ((regparm (3)));=0A=
+int normalize_posix_path (const char *src, char *dst);=0A=
=0A=

------=_NextPart_000_0086_01C1B1BE.80286C80--
