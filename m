Return-Path: <cygwin-patches-return-2207-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9675 invoked by alias); 22 May 2002 16:03:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9624 invoked from network); 22 May 2002 16:03:18 -0000
X-WM-Posted-At: avacado.atomice.net; Wed, 22 May 02 17:06:21 +0100
Message-ID: <001701c201aa$9cca0ab0$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: /dev patch
Date: Wed, 22 May 2002 09:03:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0014_01C201B2.FE268920"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00191.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0014_01C201B2.FE268920
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2037

I've had this patch kicking about for a while and I was going to merge it
with the next /proc patch but I remembered that separate patches are
generally preferred on this list and the /proc stuff has been delayed
somewhat.
This patch adds support for a virtual /dev which just lists the devices that
cygwin currently supports. The /dev prefix is read from the mount_table, as
is now the /proc prefix. I haven't added a mechanism to read these from the
registry or allow them to be changed using mount since most programs expect
to find these directories at a fixed location.

Regards
Chris

---
2002-05-22  Christopher January <chris@atomice.net>

 * Makefile.in: Add fhandler_dev.o.
 * dtable.cc (dtable::build_fhandler): Add entry for FH_DEV.
 * fhandler.h: Add constant for FH_DEV. Add class declaration for
 fhandler_dev. Update fhandler_union accordingly. Remove global declarations
 for proc and proc_len.
 * fhandler_proc.cc: Remove global definitions for proc and proc_len.
 * fhandler_proc.cc (fhandler_proc::get_proc_fhandler): Use proc prefix from
 mount_table.
 (fhandler_proc::exists): Ditto.
 (fhandler_proc::fstat): Ditto.
 (fhandler_proc::open): Ditto.
 * fhandler_process.cc (fhandler_process::exists): Use proc prefix from
 mount_table.
 (fhandler_proc::fstat): Ditto.
 (fhandler_proc::open): Ditto.
 * fhandler_registry.cc (fhandler_registry::exists): Use proc prefix from
 mount_table.
 (fhandler_registry::readdir): Ditto.
 (fhandler_registry::open): Ditto.
 * fhandler_virtual.cc (fhandler_virtual::close): Remove call to
 delqueue.process_queue().
 * path.cc: Add is_dev macro. Use proc prefix from mount_table in is_proc
 macro. Add FH_DEV to isvirtual_dev macro.
 (path_conv::check): Add FH_DEV support.
 (path_conv::get_device_number): Use dev prefix from mount_table.
 (mount_info::init): Initialise default prefixes for /proc and /dev.
 (mount_info::conv_to_win32_path): Add support for /dev.
 * shared_info.h: Add dev, dev_len, proc and proc_len members to
 mount_table class.
 * fhandler_dev.cc: New file.


------=_NextPart_000_0014_01C201B2.FE268920
Content-Type: application/octet-stream;
	name="dev.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dev.patch"
Content-length: 20862

Index: Makefile.in=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v=0A=
retrieving revision 1.87=0A=
diff -u -3 -p -u -p -b -B -r1.87 Makefile.in=0A=
--- Makefile.in	18 May 2002 06:10:16 -0000	1.87=0A=
+++ Makefile.in	22 May 2002 16:00:06 -0000=0A=
@@ -122,9 +122,9 @@ DLL_OFILES:=3Dassert.o autoload.o cygheap.=0A=
 	cygserver_transport_pipes.o cygserver_transport_sockets.o dcrt0.o debug.o=
 \=0A=
 	delqueue.o dir.o dlfcn.o dll_init.o dtable.o environ.o errno.o exceptions=
.o \=0A=
 	exec.o external.o fcntl.o fhandler.o fhandler_clipboard.o fhandler_consol=
e.o \=0A=
-	fhandler_disk_file.o fhandler_dsp.o fhandler_floppy.o fhandler_mem.o \=0A=
-	fhandler_proc.o fhandler_process.o fhandler_random.o fhandler_raw.o \=0A=
-	fhandler_registry.o fhandler_serial.o fhandler_socket.o \=0A=
+	fhandler_dev.o fhandler_disk_file.o fhandler_dsp.o fhandler_floppy.o \=0A=
+	fhandler_mem.o fhandler_proc.o fhandler_process.o fhandler_random.o \=0A=
+	fhandler_raw.o fhandler_registry.o fhandler_serial.o fhandler_socket.o \=
=0A=
 	fhandler_tape.o fhandler_termios.o fhandler_tty.o fhandler_virtual.o \=0A=
 	fhandler_windows.o fhandler_zero.o fnmatch.o fork.o glob.o grp.o \=0A=
 	heap.o init.o ioctl.o ipc.o localtime.o malloc.o miscfuncs.o mmap.o \=0A=
Index: dtable.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v=0A=
retrieving revision 1.80=0A=
diff -u -3 -p -u -p -b -B -r1.80 dtable.cc=0A=
--- dtable.cc	3 May 2002 02:43:45 -0000	1.80=0A=
+++ dtable.cc	22 May 2002 16:00:09 -0000=0A=
@@ -374,6 +374,9 @@ dtable::build_fhandler (int fd, DWORD de=0A=
       case FH_PROCESS:=0A=
         fh =3D cnew (fhandler_process) ();=0A=
         break;=0A=
+      case FH_DEV:=0A=
+        fh =3D cnew (fhandler_dev) ();=0A=
+        break;=0A=
       default:=0A=
 	system_printf ("internal error -- unknown device - %p", dev);=0A=
 	fh =3D NULL;=0A=
Index: fhandler.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v=0A=
retrieving revision 1.115=0A=
diff -u -3 -p -u -p -b -B -r1.115 fhandler.h=0A=
--- fhandler.h	12 May 2002 03:08:59 -0000	1.115=0A=
+++ fhandler.h	22 May 2002 16:00:12 -0000=0A=
@@ -73,8 +73,9 @@ enum=0A=
   FH_PROC    =3D 0x0000001a,      /* /proc */=0A=
   FH_REGISTRY =3D0x0000001b,      /* /proc/registry */=0A=
   FH_PROCESS =3D 0x0000001c,      /* /proc/<n> */=0A=
+  FH_DEV     =3D 0x0000001d,      /* /dev */=0A=
=20=0A=
-  FH_NDEV    =3D 0x0000001d,      /* Maximum number of devices */=0A=
+  FH_NDEV    =3D 0x0000001e,      /* Maximum number of devices */=0A=
   FH_DEVMASK =3D 0x00000fff,	/* devices live here */=0A=
   FH_BAD     =3D 0xffffffff=0A=
 };=0A=
@@ -103,8 +104,6 @@ enum=0A=
 extern const char *windows_device_names[];=0A=
 extern struct __cygwin_perfile *perfile_table;=0A=
 #define __fmode (*(user_data->fmode_ptr))=0A=
-extern const char proc[];=0A=
-extern const int proc_len;=0A=
=20=0A=
 class select_record;=0A=
 class path_conv;=0A=
@@ -1113,10 +1112,20 @@ class fhandler_process: public fhandler_=0A=
   void fill_filebuf ();=0A=
 };=0A=
=20=0A=
+class fhandler_dev: public fhandler_virtual=0A=
+{=0A=
+ public:=0A=
+  fhandler_dev ();=0A=
+  int exists(const char *path);=0A=
+  struct dirent *readdir (DIR *);=0A=
+  int __stdcall fstat (struct __stat64 *buf, path_conv *) __attribute__ ((=
regparm (3)));=0A=
+};=0A=
+=0A=
 typedef union=0A=
 {=0A=
   char base[sizeof(fhandler_base)];=0A=
   char console[sizeof(fhandler_console)];=0A=
+  char dev[sizeof(fhandler_dev)];=0A=
   char dev_clipboard[sizeof(fhandler_dev_clipboard)];=0A=
   char dev_dsp[sizeof(fhandler_dev_dsp)];=0A=
   char dev_floppy[sizeof(fhandler_dev_floppy)];=0A=
Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.4=0A=
diff -u -3 -p -u -p -b -B -r1.4 fhandler_proc.cc=0A=
--- fhandler_proc.cc	12 May 2002 01:37:48 -0000	1.4=0A=
+++ fhandler_proc.cc	22 May 2002 16:00:13 -0000=0A=
@@ -23,6 +23,7 @@ details. */=0A=
 #include "pinfo.h"=0A=
 #include "dtable.h"=0A=
 #include "cygheap.h"=0A=
+#include "shared_info.h"=0A=
 #include <assert.h>=0A=
 #include <sys/utsname.h>=0A=
 #include "ntdll.h"=0A=
@@ -67,10 +68,6 @@ static const DWORD proc_fhandlers[PROC_L=0A=
   FH_PROC=0A=
 };=0A=
=20=0A=
-/* name of the /proc filesystem */=0A=
-const char proc[] =3D "/proc";=0A=
-const int proc_len =3D sizeof (proc) - 1;=0A=
-=0A=
 static off_t format_proc_meminfo (char *destbuf, size_t maxsize);=0A=
 static off_t format_proc_stat (char *destbuf, size_t maxsize);=0A=
 static off_t format_proc_uptime (char *destbuf, size_t maxsize);=0A=
@@ -83,7 +80,7 @@ DWORD=0A=
 fhandler_proc::get_proc_fhandler (const char *path)=0A=
 {=0A=
   debug_printf ("get_proc_fhandler(%s)", path);=0A=
-  path +=3D proc_len;=0A=
+  path +=3D mount_table->proc_len - 1;=0A=
   /* Since this method is called from path_conv::check we can't rely on=0A=
    * it being normalised and therefore the path may have runs of slashes=
=0A=
    * in it.=0A=
@@ -138,7 +135,7 @@ int=0A=
 fhandler_proc::exists (const char *path)=0A=
 {=0A=
   debug_printf ("exists (%s)", path);=0A=
-  path +=3D proc_len;=0A=
+  path +=3D mount_table->proc_len - 1;=0A=
   if (*path =3D=3D 0)=0A=
     return 2;=0A=
   for (int i =3D 0; proc_listing[i]; i++)=0A=
@@ -162,7 +159,7 @@ fhandler_proc::fstat (struct __stat64 *b=0A=
 {=0A=
   debug_printf ("fstat (%s)", get_name ());=0A=
   const char *path =3D get_name ();=0A=
-  path +=3D proc_len;=0A=
+  path +=3D mount_table->proc_len - 1;=0A=
   (void) fhandler_base::fstat (buf, pc);=0A=
=20=0A=
   buf->st_mode &=3D ~_IFMT & NO_W;=0A=
@@ -235,7 +232,7 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
=20=0A=
   const char *path;=0A=
=20=0A=
-  path =3D get_name () + proc_len;=0A=
+  path =3D get_name () + mount_table->proc_len - 1;=0A=
=20=0A=
   if (!*path)=0A=
     {=0A=
Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.5=0A=
diff -u -3 -p -u -p -b -B -r1.5 fhandler_process.cc=0A=
--- fhandler_process.cc	12 May 2002 01:37:48 -0000	1.5=0A=
+++ fhandler_process.cc	22 May 2002 16:00:18 -0000=0A=
@@ -77,7 +77,7 @@ int=0A=
 fhandler_process::exists (const char *path)=0A=
 {=0A=
   debug_printf ("exists (%s)", path);=0A=
-  path +=3D proc_len + 1;=0A=
+  path +=3D mount_table->proc_len;=0A=
   while (*path !=3D 0 && !SLASH_P (*path))=0A=
     path++;=0A=
   if (*path =3D=3D 0)=0A=
@@ -100,7 +100,7 @@ fhandler_process::fstat (struct __stat64=0A=
   const char *path =3D get_name ();=0A=
   int file_type =3D exists (path);=0A=
   (void) fhandler_base::fstat (buf, pc);=0A=
-  path +=3D proc_len + 1;=0A=
+  path +=3D mount_table->proc_len;=0A=
   int pid =3D atoi (path);=0A=
   winpids pids;=0A=
   _pinfo *p;=0A=
@@ -167,7 +167,7 @@ fhandler_process::open (path_conv *pc, i=0A=
     goto out;=0A=
=20=0A=
   const char *path;=0A=
-  path =3D get_name () + proc_len + 1;=0A=
+  path =3D get_name () + mount_table->proc_len;=0A=
   pid =3D atoi (path);=0A=
   while (*path !=3D 0 && !SLASH_P (*path))=0A=
     path++;=0A=
Index: fhandler_registry.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_registry.cc,v=0A=
retrieving revision 1.4=0A=
diff -u -3 -p -u -p -b -B -r1.4 fhandler_registry.cc=0A=
--- fhandler_registry.cc	12 May 2002 01:37:48 -0000	1.4=0A=
+++ fhandler_registry.cc	22 May 2002 16:00:19 -0000=0A=
@@ -22,6 +22,7 @@ details. */=0A=
 #include "path.h"=0A=
 #include "dtable.h"=0A=
 #include "cygheap.h"=0A=
+#include "shared_info.h"=0A=
 #include <assert.h>=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
@@ -103,7 +104,7 @@ fhandler_registry::exists (const char *p=0A=
   HKEY hKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
=20=0A=
   debug_printf ("exists (%s)", path);=0A=
-  path +=3D proc_len + 1 + registry_len;=0A=
+  path +=3D mount_table->proc_len + registry_len;=0A=
=20=0A=
   while (SLASH_P (*path))=0A=
     path++;=0A=
@@ -216,7 +217,7 @@ fhandler_registry::readdir (DIR * dir)=0A=
   char buf[buf_size];=0A=
   HANDLE handle;=0A=
   struct dirent *res =3D NULL;=0A=
-  const char *path =3D dir->__d_dirname + proc_len + 1 + registry_len;=0A=
+  const char *path =3D dir->__d_dirname + mount_table->proc_len + registry=
_len;=0A=
   LONG error;=0A=
=20=0A=
   if (*path =3D=3D 0)=0A=
@@ -343,7 +344,7 @@ fhandler_registry::open (path_conv *pc,=20=0A=
     goto out;=0A=
=20=0A=
   const char *path;=0A=
-  path =3D get_name () + proc_len + 1 + registry_len;=0A=
+  path =3D get_name () + mount_table->proc_len + registry_len;=0A=
   if (!*path)=0A=
     {=0A=
       if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
Index: fhandler_virtual.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v=0A=
retrieving revision 1.5=0A=
diff -u -3 -p -u -p -b -B -r1.5 fhandler_virtual.cc=0A=
--- fhandler_virtual.cc	12 May 2002 01:59:53 -0000	1.5=0A=
+++ fhandler_virtual.cc	22 May 2002 16:00:19 -0000=0A=
@@ -159,7 +159,6 @@ fhandler_virtual::close ()=0A=
     cfree (filebuf);=0A=
   filebuf =3D NULL;=0A=
   bufalloc =3D (size_t) -1;=0A=
-  cygwin_shared->delqueue.process_queue ();=0A=
   return 0;=0A=
 }=0A=
=20=0A=
Index: path.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v=0A=
retrieving revision 1.207=0A=
diff -u -3 -p -u -p -b -B -r1.207 path.cc=0A=
--- path.cc	18 May 2002 20:27:49 -0000	1.207=0A=
+++ path.cc	22 May 2002 16:00:30 -0000=0A=
@@ -118,11 +118,15 @@ int pcheck_case =3D PCHECK_RELAXED; /* Det=0A=
    (isdirsep(path[mount_table->cygdrive_len + 1]) || \=0A=
     !path[mount_table->cygdrive_len + 1]))=0A=
=20=0A=
+#define isdev(path) \=0A=
+  (path_prefix_p (mount_table->dev, (path), mount_table->dev_len))=0A=
+=0A=
 #define isproc(path) \=0A=
-  (path_prefix_p (proc, (path), proc_len))=0A=
+  (path_prefix_p (mount_table->proc, (path), mount_table->proc_len))=0A=
=20=0A=
 #define isvirtual_dev(devn) \=0A=
-  (devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_PROC || devn =3D=3D FH_REGIST=
RY || devn =3D=3D FH_PROCESS)=0A=
+  (devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_PROC || devn =3D=3D FH_REGIST=
RY || \=0A=
+   devn =3D=3D FH_PROCESS || devn =3D=3D FH_DEV)=0A=
=20=0A=
 /* Return non-zero if PATH1 is a prefix of PATH2.=0A=
    Both are assumed to be of the same path style and / vs \ usage.=0A=
@@ -504,7 +508,7 @@ path_conv::check (const char *src, unsig=0A=
 	  if (error)=0A=
 	    return;=0A=
=20=0A=
-	  if (devn =3D=3D FH_CYGDRIVE)=0A=
+    if (devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_DEV)=0A=
 	    {=0A=
 	      if (!component)=0A=
 		fileattr =3D FILE_ATTRIBUTE_DIRECTORY;=0A=
@@ -1039,7 +1043,7 @@ get_device_number (const char *unix_path=0A=
   DWORD devn =3D FH_BAD;=0A=
   unit =3D 0;=0A=
=20=0A=
-  if (*unix_path =3D=3D '/' && udeveqn ("/dev/", 5))=0A=
+  if (*unix_path =3D=3D '/' && udeveqn (mount_table->dev, 5))=0A=
     {=0A=
       devn =3D get_devn (unix_path, unit);=0A=
       if (devn =3D=3D FH_BAD && *w32_path =3D=3D '\\' && wdeveqn ("\\dev\\=
", 5))=0A=
@@ -1324,6 +1328,15 @@ mount_info::init ()=0A=
   /* Fetch the mount table and cygdrive-related information from=0A=
      the registry.  */=0A=
   from_registry ();=0A=
+=0A=
+  /* These paths are hard-coded because programs rely on them being at the=
se=0A=
+     paths. */=0A=
+  strcpy(dev, "/dev");=0A=
+  slashify (dev, dev, 1);=0A=
+  dev_len =3D strlen(dev);=0A=
+  strcpy(proc, "/proc");=0A=
+  slashify (proc, proc, 1);=0A=
+  proc_len =3D strlen(proc);=0A=
 }=0A=
=20=0A=
 /* conv_to_win32_path: Ensure src_path is a pure Win32 path and store=0A=
@@ -1439,6 +1452,18 @@ mount_info::conv_to_win32_path (const ch=0A=
       if (devn =3D=3D FH_BAD)=0A=
         return ENOENT;=0A=
     }=0A=
+  else if (isdev (pathbuf))=0A=
+    {=0A=
+      int n =3D mount_table->dev_len - 1;=0A=
+      if (!pathbuf[n] ||=0A=
+         (pathbuf[n] =3D=3D '/' && pathbuf[n + 1] =3D=3D '.' && !pathbuf[n=
 + 2]))=0A=
+        {=0A=
+          unit =3D 0;=0A=
+          dst[0] =3D '\0';=0A=
+          if (mount_table->dev_len > 1)=0A=
+             devn =3D FH_DEV;=0A=
+        }=0A=
+    }=0A=
   else if (iscygdrive (pathbuf))=0A=
     {=0A=
       int n =3D mount_table->cygdrive_len - 1;=0A=
Index: shared_info.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v=0A=
retrieving revision 1.19=0A=
diff -u -3 -p -u -p -b -B -r1.19 shared_info.h=0A=
--- shared_info.h	26 Dec 2001 21:35:16 -0000	1.19=0A=
+++ shared_info.h	22 May 2002 16:00:31 -0000=0A=
@@ -39,10 +39,10 @@ class mount_item=0A=
    scheme should be satisfactory for a long while yet.  */=0A=
 #define MAX_MOUNTS 30=0A=
=20=0A=
-#define MOUNT_VERSION	27	// increment when mount table changes and=0A=
+#define MOUNT_VERSION 28  // increment when mount table changes and=0A=
 #define MOUNT_VERSION_MAGIC CYGWIN_VERSION_MAGIC (MOUNT_MAGIC, MOUNT_VERSI=
ON)=0A=
 #define CURR_MOUNT_MAGIC 0x41e0=0A=
-#define MOUNT_INFO_CB 16488=0A=
+#define MOUNT_INFO_CB 17016=0A=
=20=0A=
 class reg_key;=0A=
=20=0A=
@@ -64,6 +64,12 @@ class mount_info=0A=
   char cygdrive[MAX_PATH];=0A=
   size_t cygdrive_len;=0A=
   unsigned cygdrive_flags;=0A=
+  /* This is where /dev is mounted. */=0A=
+  char dev[MAX_PATH];=0A=
+  size_t dev_len;=0A=
+  /* This is where /proc is mounted. */=0A=
+  char proc[MAX_PATH];=0A=
+  size_t proc_len;=0A=
  private:=0A=
   int posix_sorted[MAX_MOUNTS];=0A=
   int native_sorted[MAX_MOUNTS];=0A=
--- /dev/null	Wed May 22 17:04:13 2002=0A=
+++ fhandler_dev.cc	Wed May 22 16:58:09 2002=0A=
@@ -0,0 +1,153 @@=0A=
+/* fhandler_dec.cc: fhandler for /dev virtual filesystem=0A=
+=0A=
+   Copyright 2002 Red Hat, Inc.=0A=
+=0A=
+This file is part of Cygwin.=0A=
+=0A=
+This software is a copyrighted work licensed under the terms of the=0A=
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
+details. */=0A=
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
+#include "dtable.h"=0A=
+#include "cygheap.h"=0A=
+#include "shared_info.h"=0A=
+#include <assert.h>=0A=
+=0A=
+#define _COMPILING_NEWLIB=0A=
+#include <dirent.h>=0A=
+=0A=
+static const int DEV_LINK_COUNT =3D 573;=0A=
+=0A=
+static const char *dev_listing[DEV_LINK_COUNT];=0A=
+=0A=
+static bool dev_listing_initialised =3D false;=0A=
+=0A=
+static void initialise_dev_listing ();=0A=
+=0A=
+/* Returns 0 if path doesn't exist, >0 if path is a directory,=0A=
+ * <0 if path is a file.=0A=
+ */=0A=
+int=0A=
+fhandler_dev::exists (const char *path)=0A=
+{=0A=
+  debug_printf ("exists (%s)", path);=0A=
+  path +=3D mount_table->dev_len - 1;=0A=
+  if (*path =3D=3D 0)=0A=
+    return 2;=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_dev::fstat (struct __stat64 *buf, path_conv *pc)=0A=
+{=0A=
+      buf->st_nlink =3D DEV_LINK_COUNT;=0A=
+      buf->st_mode |=3D S_IFDIR | S_IXUSR | S_IXGRP | S_IXOTH;=0A=
+      return 0;=0A=
+}=0A=
+=0A=
+fhandler_dev::fhandler_dev ():=0A=
+  fhandler_virtual (FH_DEV)=0A=
+{=0A=
+        if (!dev_listing_initialised) {=0A=
+                initialise_dev_listing();=0A=
+                dev_listing_initialised =3D true;=0A=
+        }=0A=
+}=0A=
+=0A=
+struct dirent *=0A=
+fhandler_dev::readdir (DIR * dir)=0A=
+{=0A=
+  if (dir->__d_position >=3D DEV_LINK_COUNT)=0A=
+    return NULL;=0A=
+  strcpy (dir->__d_dirent->d_name, dev_listing[dir->__d_position++]);=0A=
+  syscall_printf ("%p =3D readdir (%p) (%s)", &dir->__d_dirent, dir,=0A=
+                  dir->__d_dirent->d_name);=0A=
+  return dir->__d_dirent;=0A=
+}=0A=
+=0A=
+static=0A=
+void=0A=
+initialise_dev_listing()=0A=
+{=0A=
+        char *mem =3D (char *)malloc (5000), *device =3D mem;=0A=
+        int devn =3D 0;=0A=
+        for (int i =3D 0; i <=3D 127; i++) {=0A=
+                __small_sprintf (device, "st%u", i);=0A=
+                dev_listing[devn++] =3D (const char *)device;=0A=
+                device +=3D strlen(device) + 1;=0A=
+        }=0A=
+        for (int i =3D 0; i <=3D 127; i++) {=0A=
+                __small_sprintf (device, "nst%u", i);=0A=
+                dev_listing[devn++] =3D (const char *)device;=0A=
+                device +=3D strlen(device) + 1;=0A=
+        }=0A=
+        for (int i =3D 0; i <=3D 15; i++) {=0A=
+                __small_sprintf (device, "fd%u", i);=0A=
+                dev_listing[devn++] =3D (const char *)device;=0A=
+                device +=3D strlen(device) + 1;=0A=
+        }=0A=
+        for (int i =3D 0; i <=3D 15; i++) {=0A=
+                __small_sprintf (device, "scd%u", i);=0A=
+                dev_listing[devn++] =3D (const char *)device;=0A=
+                device +=3D strlen(device) + 1;=0A=
+        }=0A=
+        for (int i =3D 0; i <=3D 11; i++) {=0A=
+                for (int u =3D 0; u <=3D 15; u++) {=0A=
+                        if (u =3D=3D 0)=0A=
+                                __small_sprintf (device, "sd%c", i+'a');=
=0A=
+                        else=0A=
+                                __small_sprintf (device, "sd%c%u", i+'a', =
u);=0A=
+                        dev_listing[devn++] =3D (const char *)device;=0A=
+                        device +=3D strlen(device) + 1;=0A=
+                }=0A=
+        }=0A=
+        for (int i =3D 0; i <=3D 63; i++) {=0A=
+                __small_sprintf (device, "tty%u", i);=0A=
+                dev_listing[devn++] =3D (const char *)device;=0A=
+                device +=3D strlen(device) + 1;=0A=
+        }=0A=
+        for (int i =3D 0; i <=3D 3; i++) {=0A=
+                __small_sprintf (device, "ttyS%u", i);=0A=
+                dev_listing[devn++] =3D (const char *)device;=0A=
+                device +=3D strlen(device) + 1;=0A=
+        }=0A=
+        for (int i =3D 0; i <=3D 3; i++) {=0A=
+                __small_sprintf (device, "com%u", i);=0A=
+                dev_listing[devn++] =3D (const char *)device;=0A=
+                device +=3D strlen(device) + 1;=0A=
+        }=0A=
+        dev_listing[devn++] =3D "tty";=0A=
+        dev_listing[devn++] =3D "ttym";=0A=
+        dev_listing[devn++] =3D "ptmx";=0A=
+        dev_listing[devn++] =3D "windows";=0A=
+        dev_listing[devn++] =3D "dsp";=0A=
+        dev_listing[devn++] =3D "conin";=0A=
+        dev_listing[devn++] =3D "conout";=0A=
+        dev_listing[devn++] =3D "null";=0A=
+        dev_listing[devn++] =3D "zero";=0A=
+        dev_listing[devn++] =3D "random";=0A=
+        dev_listing[devn++] =3D "urandom";=0A=
+        dev_listing[devn++] =3D "mem";=0A=
+        dev_listing[devn++] =3D "clipboard";=0A=
+        dev_listing[devn++] =3D "port";=0A=
+        dev_listing[devn++] =3D "pipe";=0A=
+        dev_listing[devn++] =3D "piper";=0A=
+        dev_listing[devn++] =3D "pipew";=0A=
+        dev_listing[devn++] =3D "tcp";=0A=
+        dev_listing[devn++] =3D "udp";=0A=
+        dev_listing[devn++] =3D "streamsocket";=0A=
+        dev_listing[devn++] =3D "dgsocket";=0A=
+        debug_printf ("%d bytes used, %d devices", device - mem, devn);=0A=
+  }=0A=

------=_NextPart_000_0014_01C201B2.FE268920
Content-Type: text/plain;
	name="ChangeLog.dev.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.dev.txt"
Content-length: 1441

2002-05-22  Christopher January <chris@atomice.net>

	* Makefile.in: Add fhandler_dev.o.
	* dtable.cc (dtable::build_fhandler): Add entry for FH_DEV.
	* fhandler.h: Add constant for FH_DEV. Add class declaration for
	fhandler_dev. Update fhandler_union accordingly. Remove global declarations
	for proc and proc_len.
	* fhandler_proc.cc: Remove global definitions for proc and proc_len.
	* fhandler_proc.cc (fhandler_proc::get_proc_fhandler): Use proc prefix from
	mount_table.
	(fhandler_proc::exists): Ditto.
	(fhandler_proc::fstat): Ditto.
	(fhandler_proc::open): Ditto.
	* fhandler_process.cc (fhandler_process::exists): Use proc prefix from
	mount_table.
	(fhandler_proc::fstat): Ditto.
	(fhandler_proc::open): Ditto.
	* fhandler_registry.cc (fhandler_registry::exists): Use proc prefix from
	mount_table.
	(fhandler_registry::readdir): Ditto.
	(fhandler_registry::open): Ditto.
	* fhandler_virtual.cc (fhandler_virtual::close): Remove call to
	delqueue.process_queue().
	* path.cc: Add is_dev macro. Use proc prefix from mount_table in is_proc
	macro. Add FH_DEV to isvirtual_dev macro.
	(path_conv::check): Add FH_DEV support.
	(path_conv::get_device_number): Use dev prefix from mount_table.
	(mount_info::init): Initialise default prefixes for /proc and /dev.
	(mount_info::conv_to_win32_path): Add support for /dev.
	* shared_info.h: Add dev, dev_len, proc and proc_len members to
	mount_table class.
	* fhandler_dev.cc: New file.

------=_NextPart_000_0014_01C201B2.FE268920--
