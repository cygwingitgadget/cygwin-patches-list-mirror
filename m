Return-Path: <cygwin-patches-return-2320-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23499 invoked by alias); 6 Jun 2002 00:26:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23485 invoked from network); 6 Jun 2002 00:26:38 -0000
Message-ID: <00ef01c20cf1$08974c20$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Patch for sub-second resolution in stat(2)
Date: Wed, 05 Jun 2002 17:26:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00EC_01C20CF9.6A07A0B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00303.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00EC_01C20CF9.6A07A0B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1280

After Chris's exciting news that my assignment has reached RedHat, here's a
patch!

This adds sub-second resolution to the access, modification, and creation
times returned by stat(2) etc. I thought this would make a nice companion to
Corinna's work on making other things in stat(2) be 64-bit.

Also, I was having trouble with a makefile where the commands could execute
in less than a second leading to irregular breakage: this patch fixes that.

I've checked that this maintains both source and binary compatibility (tho'
it does add macros for st_mtime etc. to hide the indirection involved).

I'm unclear whether this is the best naming / type scheme but it is one
recognised by both the make and fileutils packages available from the cygwin
setup (i.e. make this patch and re-compile those packages and they detect
the new fields).

I've provided two separate patches: one for types.h (in the newlib.patch)
and one for the cygwin sources (in winsup.patch). The changelog entries are:

newlib:

Changelog message:
* types.h (timespec_t timestruc_t): New typedefs.

winsup/cygwin:

Changelog message:
* fhandler.cc (fhandler_base::fstat):
* fhandler_disk_file.cc (fhandler_disk_file::fstat_helper):
* fhandler_process.cc (*fhandler_process::fstat)
* glob.c (stat32_to_STAT):


------=_NextPart_000_00EC_01C20CF9.6A07A0B0
Content-Type: application/octet-stream;
	name="newlib.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="newlib.patch"
Content-length: 915

Index: newlib/libc/include/sys/types.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/newlib/libc/include/sys/types.h,v=0A=
retrieving revision 1.13=0A=
diff -u -u -r1.13 types.h=0A=
--- newlib/libc/include/sys/types.h	3 Jun 2002 17:48:06 -0000	1.13=0A=
+++ newlib/libc/include/sys/types.h	6 Jun 2002 00:12:51 -0000=0A=
@@ -73,10 +73,11 @@=0A=
=20=0A=
 /* Time Value Specification Structures, P1003.1b-1993, p. 261 */=0A=
=20=0A=
-struct timespec {=0A=
+typedef struct timespec {=0A=
   time_t  tv_sec;   /* Seconds */=0A=
   long    tv_nsec;  /* Nanoseconds */=0A=
-};=0A=
+} timespec_t;=0A=
+typedef struct timespec timestruc_t;=0A=
=20=0A=
 struct itimerspec {=0A=
   struct timespec  it_interval;  /* Timer period */=0A=

------=_NextPart_000_00EC_01C20CF9.6A07A0B0
Content-Type: application/octet-stream;
	name="winsup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="winsup.patch"
Content-length: 9934

Index: winsup/cygwin/fhandler.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v=0A=
retrieving revision 1.127=0A=
diff -u -u -r1.127 fhandler.cc=0A=
--- winsup/cygwin/fhandler.cc	5 Jun 2002 04:01:42 -0000	1.127=0A=
+++ winsup/cygwin/fhandler.cc	6 Jun 2002 00:12:52 -0000=0A=
@@ -842,7 +842,8 @@=0A=
   buf->st_mode |=3D get_device () =3D=3D FH_FLOPPY ? S_IFBLK : S_IFCHR;=0A=
   buf->st_nlink =3D 1;=0A=
   buf->st_blksize =3D S_BLKSIZE;=0A=
-  buf->st_atime =3D buf->st_mtime =3D buf->st_ctime =3D time (NULL) - 1;=
=0A=
+  time_as_timestruc_t (&buf->st_ctim);=0A=
+  buf->st_atim =3D buf->st_mtim =3D buf->st_ctim;=0A=
   return 0;=0A=
 }=0A=
=20=0A=
Index: winsup/cygwin/fhandler_disk_file.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v=0A=
retrieving revision 1.23=0A=
diff -u -u -r1.23 fhandler_disk_file.cc=0A=
--- winsup/cygwin/fhandler_disk_file.cc	5 Jun 2002 01:42:28 -0000	1.23=0A=
+++ winsup/cygwin/fhandler_disk_file.cc	6 Jun 2002 00:12:52 -0000=0A=
@@ -200,9 +200,9 @@=0A=
       && ftCreationTime.dwHighDateTime =3D=3D 0)=0A=
     ftCreationTime =3D ftLastWriteTime;=0A=
=20=0A=
-  buf->st_atime   =3D to_time_t (&ftLastAccessTime);=0A=
-  buf->st_mtime   =3D to_time_t (&ftLastWriteTime);=0A=
-  buf->st_ctime   =3D to_time_t (&ftCreationTime);=0A=
+  to_timestruc_t (&ftLastAccessTime, &buf->st_atim);=0A=
+  to_timestruc_t (&ftLastWriteTime, &buf->st_mtim);=0A=
+  to_timestruc_t (&ftCreationTime, &buf->st_ctim);=0A=
   buf->st_nlink   =3D nNumberOfLinks;=0A=
   buf->st_dev     =3D pc->volser ();=0A=
   buf->st_size    =3D ((__off64_t)nFileSizeHigh << 32) + nFileSizeLow;=0A=
Index: winsup/cygwin/fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.13=0A=
diff -u -u -r1.13 fhandler_process.cc=0A=
--- winsup/cygwin/fhandler_process.cc	5 Jun 2002 01:42:28 -0000	1.13=0A=
+++ winsup/cygwin/fhandler_process.cc	6 Jun 2002 00:12:52 -0000=0A=
@@ -121,7 +121,8 @@=0A=
       return 0;=0A=
     case 2:=0A=
       buf->st_ctime =3D buf->st_mtime =3D p->start_time;=0A=
-      buf->st_atime =3D time(NULL);=0A=
+      buf->st_ctim.tv_nsec =3D buf->st_mtim.tv_nsec =3D 0;=0A=
+      time_as_timestruc_t(&buf->st_atim);=0A=
       buf->st_uid =3D p->uid;=0A=
       buf->st_gid =3D p->gid;=0A=
       buf->st_mode |=3D S_IFDIR | S_IXUSR | S_IXGRP | S_IXOTH;=0A=
Index: winsup/cygwin/glob.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/glob.c,v=0A=
retrieving revision 1.11=0A=
diff -u -u -r1.11 glob.c=0A=
--- winsup/cygwin/glob.c	15 Mar 2002 10:12:30 -0000	1.11=0A=
+++ winsup/cygwin/glob.c	6 Jun 2002 00:12:52 -0000=0A=
@@ -818,9 +818,9 @@=0A=
   dst->st_gid =3D src->st_gid;=0A=
   dst->st_rdev =3D src->st_rdev;=0A=
   dst->st_size =3D src->st_size;=0A=
-  dst->st_atime =3D src->st_atime;=0A=
-  dst->st_mtime =3D src->st_mtime;=0A=
-  dst->st_ctime =3D src->st_ctime;=0A=
+  dst->st_atim =3D src->st_atim;=0A=
+  dst->st_mtim =3D src->st_mtim;=0A=
+  dst->st_ctim =3D src->st_ctim;=0A=
   dst->st_blksize =3D src->st_blksize;=0A=
   dst->st_blocks =3D src->st_blocks;=0A=
 }=0A=
Index: winsup/cygwin/syscalls.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v=0A=
retrieving revision 1.199=0A=
diff -u -u -r1.199 syscalls.cc=0A=
--- winsup/cygwin/syscalls.cc	5 Jun 2002 16:01:55 -0000	1.199=0A=
+++ winsup/cygwin/syscalls.cc	6 Jun 2002 00:12:57 -0000=0A=
@@ -1000,9 +1000,9 @@=0A=
   dst->st_gid =3D src->st_gid;=0A=
   dst->st_rdev =3D src->st_rdev;=0A=
   dst->st_size =3D src->st_size;=0A=
-  dst->st_atime =3D src->st_atime;=0A=
-  dst->st_mtime =3D src->st_mtime;=0A=
-  dst->st_ctime =3D src->st_ctime;=0A=
+  dst->st_atim =3D src->st_atim;=0A=
+  dst->st_mtim =3D src->st_mtim;=0A=
+  dst->st_ctim =3D src->st_ctim;=0A=
   dst->st_blksize =3D src->st_blksize;=0A=
   dst->st_blocks =3D src->st_blocks;=0A=
 }=0A=
Index: winsup/cygwin/times.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v=0A=
retrieving revision 1.34=0A=
diff -u -u -r1.34 times.cc=0A=
--- winsup/cygwin/times.cc	2 Jun 2002 06:07:01 -0000	1.34=0A=
+++ winsup/cygwin/times.cc	6 Jun 2002 00:12:57 -0000=0A=
@@ -233,6 +233,47 @@=0A=
   return x;=0A=
 }=0A=
=20=0A=
+/* Cygwin internal */=0A=
+/* Convert a Win32 time to "UNIX" timestruc_t format. */=0A=
+void __stdcall=0A=
+to_timestruc_t (FILETIME *ptr, timestruc_t *out)=0A=
+{=0A=
+  /* A file time is the number of 100ns since jan 1 1601=0A=
+     stuffed into two long words.=0A=
+     A timestruc_t is the number of seconds and microseconds since jan 1 1=
970=0A=
+     stuffed into a time_t and a long.  */=0A=
+=0A=
+  long rem;=0A=
+  long long x =3D ((long long) ptr->dwHighDateTime << 32) + ((unsigned)ptr=
->dwLowDateTime);=0A=
+=0A=
+  /* pass "no time" as epoch */=0A=
+  if (x =3D=3D 0)=0A=
+    {=0A=
+      out->tv_sec =3D 0;=0A=
+      out->tv_nsec =3D 0;=0A=
+      return;=0A=
+    }=0A=
+=0A=
+  x -=3D FACTOR;			/* number of 100ns between 1601 and 1970 */=0A=
+  rem =3D x % ((long long)NSPERSEC);=0A=
+  x /=3D (long long) NSPERSEC;		/* number of 100ns in a second */=0A=
+  out->tv_nsec =3D rem * 100;	/* as tv_nsec is in nanoseconds */=0A=
+  out->tv_sec =3D x;=0A=
+}=0A=
+=0A=
+/* Cygwin internal */=0A=
+/* Get the current time as a "UNIX" timestruc_t format. */=0A=
+void __stdcall=0A=
+time_as_timestruc_t (timestruc_t * out)=0A=
+{=0A=
+  SYSTEMTIME systemtime;=0A=
+  FILETIME filetime;=0A=
+=0A=
+  GetSystemTime (&systemtime);=0A=
+  SystemTimeToFileTime (&systemtime, &filetime);=0A=
+  to_timestruc_t (&filetime, out);=0A=
+}=0A=
+=0A=
 /* time: POSIX 4.5.1.1, C 4.12.2.4 */=0A=
 /* Return number of seconds since 00:00 UTC on jan 1, 1970 */=0A=
 extern "C"=0A=
Index: winsup/cygwin/winsup.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v=0A=
retrieving revision 1.92=0A=
diff -u -u -r1.92 winsup.h=0A=
--- winsup/cygwin/winsup.h	29 May 2002 15:04:27 -0000	1.92=0A=
+++ winsup/cygwin/winsup.h	6 Jun 2002 00:12:57 -0000=0A=
@@ -206,6 +206,8 @@=0A=
 /* Time related */=0A=
 void __stdcall totimeval (struct timeval *dst, FILETIME * src, int sub, in=
t flag);=0A=
 long __stdcall to_time_t (FILETIME * ptr);=0A=
+void __stdcall to_timestruc_t (FILETIME * ptr, timestruc_t * out);=0A=
+void __stdcall time_as_timestruc_t (timestruc_t * out);=0A=
=20=0A=
 void __stdcall set_console_title (char *);=0A=
 void early_stuff_init ();=0A=
Index: winsup/cygwin/include/cygwin/stat.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/stat.h,v=0A=
retrieving revision 1.3=0A=
diff -u -u -r1.3 stat.h=0A=
--- winsup/cygwin/include/cygwin/stat.h	3 Jun 2002 17:44:09 -0000	1.3=0A=
+++ winsup/cygwin/include/cygwin/stat.h	6 Jun 2002 00:12:57 -0000=0A=
@@ -27,12 +27,9 @@=0A=
   __gid16_t     st_gid;=0A=
   __dev16_t     st_rdev;=0A=
   __off32_t     st_size;=0A=
-  time_t        st_atime;=0A=
-  long          st_spare1;=0A=
-  time_t        st_mtime;=0A=
-  long          st_spare2;=0A=
-  time_t        st_ctime;=0A=
-  long          st_spare3;=0A=
+  timestruc_t   st_atim;=0A=
+  timestruc_t   st_mtim;=0A=
+  timestruc_t   st_ctim;=0A=
   blksize_t     st_blksize;=0A=
   __blkcnt32_t  st_blocks;=0A=
   long          st_spare4[2];=0A=
@@ -48,12 +45,9 @@=0A=
   __gid32_t     st_gid;=0A=
   __dev32_t     st_rdev;=0A=
   __off64_t     st_size;=0A=
-  time_t        st_atime;=0A=
-  long          st_spare1;=0A=
-  time_t        st_mtime;=0A=
-  long          st_spare2;=0A=
-  time_t        st_ctime;=0A=
-  long          st_spare3;=0A=
+  timestruc_t   st_atim;=0A=
+  timestruc_t   st_mtim;=0A=
+  timestruc_t   st_ctim;=0A=
   blksize_t     st_blksize;=0A=
   __blkcnt64_t  st_blocks;=0A=
   long          st_spare4[2];=0A=
@@ -75,16 +69,17 @@=0A=
   gid_t         st_gid;=0A=
   dev_t         st_rdev;=0A=
   off_t         st_size;=0A=
-  time_t        st_atime;=0A=
-  long          st_spare1;=0A=
-  time_t        st_mtime;=0A=
-  long          st_spare2;=0A=
-  time_t        st_ctime;=0A=
-  long          st_spare3;=0A=
+  timestruc_t   st_atim;=0A=
+  timestruc_t   st_mtim;=0A=
+  timestruc_t   st_ctim;=0A=
   blksize_t     st_blksize;=0A=
   blkcnt_t      st_blocks;=0A=
   long          st_spare4[2];=0A=
 };=0A=
+=0A=
+#define st_atime st_atim.tv_sec=0A=
+#define st_mtime st_mtim.tv_sec=0A=
+#define st_ctime st_ctim.tv_sec=0A=
=20=0A=
 #ifdef __cplusplus=0A=
 }=0A=

------=_NextPart_000_00EC_01C20CF9.6A07A0B0--

