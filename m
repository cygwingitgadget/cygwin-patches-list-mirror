Return-Path: <cygwin-patches-return-2148-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11678 invoked by alias); 3 May 2002 14:23:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11374 invoked from network); 3 May 2002 14:23:50 -0000
X-WM-Posted-At: avacado.atomice.net; Fri, 3 May 02 15:26:41 +0100
Message-ID: <005d01c1f2ae$8aafc190$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: Fixes for miscellaneous bugs in /proc patch
Date: Fri, 03 May 2002 07:23:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005A_01C1F2B6.EC402140"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00132.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_005A_01C1F2B6.EC402140
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1975

This patch superceeds "Fix for incorrect handling of open flags in
fhandler_proc".

Fixes the following bugs:
* '.' and '..' directory entries were missing.
* fhandler_*::open() were using the mode parameter as if it was the flags
parameter. This has been corrected and some minor changes made to the error
handling logic.
* Correctly indentifies the case when you try to create a new file in /proc
or one of its subdirectories.
* dup() was broken, hence cat </proc/uptime, etc. failed. This has now been
corrected.
* fhandler_registry::telldir didn't return the correct position in the
directory.
* fhandler_registry::seekdir didn't work.

Regards
Chris

2002-05-03  Christopher January <chris@atomice.net>

 * fhandler_proc.cc (fhandler_proc::open): Change use of mode to flags.
 If the file does not exist already, fail with EROFS if O_CREAT flag is
 set.
 Use cmalloc to allocate memory for filebuf.
 * fhandler_process.cc (fhandler_process::open): Ditto.
 * fhandler_registry.cc (fhandler_registry::open): Ditto.
 Move check for open for writing before open_key.
 * path.cc (path_conv::check): Do not return ENOENT if a file is not found
 in /proc.
 * fhandler_virtual.cc (fhandler_virtual::write): Change EROFS error to
 EACCES error.
 * fhandler_virtual.cc (fhandler_virtual::open): Set the NOHANDLE flag.
 * fhandler_virtual.cc (fhandler_virtual::dup): Add call to
 fhandler_base::dup.
 Allocate child's filebuf using cmalloc.
 Copy filebuf from parent to child.
 * fhandler_virtual.cc (fhandler_virtual::close): Use cfree to free filebuf.
 * fhandler_proc.cc: Add '.' and '..' to directory listing.
 * fhandler_process.cc: Ditto.
 * fhandler_registry.cc: Ditto.
 * fhandler_registry.cc (fhandler_registry::readdir): Add support for '.'
 and '..' files in subdirectories of /proc/registry.
 * fhandler_registry.cc (fhandler_registry::telldir): Use lower 16 bits
 of __d_position as position in directory.
 * fhandler_registry.cc (fhandler_registry::seekdir): Ditto.


------=_NextPart_000_005A_01C1F2B6.EC402140
Content-Type: application/octet-stream;
	name="ChangeLog2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog2"
Content-length: 1504

2002-05-03  Christopher January <chris@atomice.net>=0A=
=0A=
	* fhandler_proc.cc (fhandler_proc::open): Change use of mode to flags.=0A=
	If the file does not exist already, fail with EROFS if O_CREAT flag is=0A=
	set.=0A=
	Change EROFS error to EACCES error when writing to a file.=0A=
	Use cmalloc to allocate memory for filebuf.=09=0A=
	* fhandler_process.cc (fhandler_process::open): Ditto.=0A=
	* fhandler_registry.cc (fhandler_registry::open): Ditto.=0A=
	Move check for open for writing before open_key.=0A=
	* path.cc (path_conv::check): Do not return ENOENT if a file is not found=
=0A=
	in /proc.=0A=
	* fhandler_virtual.cc (fhandler_virtual::write): Change EROFS error to=0A=
	EACCES error.=0A=
	* fhandler_virtual.cc (fhandler_virtual::open): Set the NOHANDLE flag.=0A=
	* fhandler_virtual.cc (fhandler_virtual::dup): Add call to=0A=
	fhandler_base::dup.=0A=
	Allocate child's filebuf using cmalloc.=0A=
	Copy filebuf from parent to child.=0A=
	* fhandler_virtual.cc (fhandler_virtual::close): Use cfree to free filebuf=
.=0A=
	* fhandler_proc.cc: Add '.' and '..' to directory listing.=0A=
	* fhandler_process.cc: Ditto.=0A=
	* fhandler_registry.cc: Ditto.=0A=
	* fhandler_registry.cc (fhandler_registry::readdir): Add support for '.'=
=0A=
	and '..' files in subdirectories of /proc/registry.=0A=
	* fhandler_registry.cc (fhandler_registry::telldir): Use lower 16 bits=0A=
	of __d_position as position in directory.=0A=
	* fhandler_registry.cc (fhandler_registry::seekdir): Ditto.=0A=
=09=

------=_NextPart_000_005A_01C1F2B6.EC402140
Content-Type: application/octet-stream;
	name="proc.patch.3"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.patch.3"
Content-length: 19310

Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.2=0A=
diff -u -3 -p -u -p -a -w -r1.2 fhandler_proc.cc=0A=
--- fhandler_proc.cc	3 May 2002 02:43:45 -0000	1.2=0A=
+++ fhandler_proc.cc	3 May 2002 14:18:00 -0000=0A=
@@ -20,6 +20,8 @@ details. */=0A=
 #include "path.h"=0A=
 #include "sigproc.h"=0A=
 #include "pinfo.h"=0A=
+#include "dtable.h"=0A=
+#include "cygheap.h"=0A=
 #include <assert.h>=0A=
 #include <sys/utsname.h>=0A=
=20=0A=
@@ -27,12 +29,14 @@ details. */=0A=
 #include <dirent.h>=0A=
=20=0A=
 /* offsets in proc_listing */=0A=
-static const int PROC_REGISTRY =3D 0;     // /proc/registry=0A=
-static const int PROC_VERSION =3D 1;      // /proc/version=0A=
-static const int PROC_UPTIME =3D 2;       // /proc/uptime=0A=
+static const int PROC_REGISTRY =3D 2;     // /proc/registry=0A=
+static const int PROC_VERSION  =3D 3;     // /proc/version=0A=
+static const int PROC_UPTIME   =3D 4;     // /proc/uptime=0A=
=20=0A=
 /* names of objects in /proc */=0A=
 static const char *proc_listing[] =3D {=0A=
+  ".",=0A=
+  "..",=0A=
   "registry",=0A=
   "version",=0A=
   "uptime",=0A=
@@ -45,6 +49,8 @@ static const int PROC_LINK_COUNT =3D (size=0A=
  * fhandler_proc.=0A=
  */=0A=
 static const DWORD proc_fhandlers[] =3D {=0A=
+  FH_PROC,=0A=
+  FH_PROC,=0A=
   FH_REGISTRY,=0A=
   FH_PROC,=0A=
   FH_PROC=0A=
@@ -92,7 +98,19 @@ fhandler_proc::get_proc_fhandler (const=20=0A=
       if (p->pid =3D=3D pid)=0A=
         return FH_PROCESS;=0A=
     }=0A=
+=0A=
+    bool has_subdir =3D false;=0A=
+    while (*path)=0A=
+            if (SLASH_P (*path++))=0A=
+                has_subdir =3D true;=0A=
+=0A=
+    if (has_subdir)=0A=
+        /* The user is trying to access a non-existent subdirectory of /pr=
oc. */=0A=
   return FH_BAD;=0A=
+    else=0A=
+        /* Return FH_PROC so that we can return EROFS if the user is tryin=
g to create=0A=
+           a file. */=0A=
+        return FH_PROC;=0A=
 }=0A=
=20=0A=
 /* Returns 0 if path doesn't exist, >0 if path is a directory,=0A=
@@ -203,13 +221,13 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
=20=0A=
   if (!*path)=0A=
     {=0A=
-      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+      if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
         {=0A=
           set_errno (EEXIST);=0A=
           res =3D 0;=0A=
           goto out;=0A=
         }=0A=
-      else if (mode & O_WRONLY)=0A=
+      else if (flags & O_WRONLY)=0A=
         {=0A=
           set_errno (EISDIR);=0A=
           res =3D 0;=0A=
@@ -229,13 +247,13 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
         proc_file_no =3D i;=0A=
         if (proc_fhandlers[i] !=3D FH_PROC)=0A=
           {=0A=
-            if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+            if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
               {=0A=
                 set_errno (EEXIST);=0A=
                 res =3D 0;=0A=
                 goto out;=0A=
               }=0A=
-            else if (mode & O_WRONLY)=0A=
+            else if (flags & O_WRONLY)=0A=
               {=0A=
                 set_errno (EISDIR);=0A=
                 res =3D 0;=0A=
@@ -251,7 +269,7 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
=20=0A=
   if (proc_file_no =3D=3D -1)=0A=
     {=0A=
-      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+      if (flags & O_CREAT)=0A=
         {=0A=
           set_errno (EROFS);=0A=
           res =3D 0;=0A=
@@ -264,7 +282,7 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
           goto out;=0A=
         }=0A=
     }=0A=
-  if (mode & O_WRONLY)=0A=
+  if (flags & O_WRONLY)=0A=
     {=0A=
       set_errno (EROFS);=0A=
       res =3D 0;=0A=
@@ -278,7 +296,7 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
         uname (&uts_name);=0A=
         filesize =3D bufalloc =3D strlen (uts_name.sysname) + 1 +=0A=
           strlen (uts_name.release) + 1 + strlen (uts_name.version) + 2;=
=0A=
-        filebuf =3D new char[bufalloc];=0A=
+        filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc);=0A=
         __small_sprintf (filebuf, "%s %s %s\n", uts_name.sysname,=0A=
                          uts_name.release, uts_name.version);=0A=
         break;=0A=
@@ -290,7 +308,7 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
          * NT only dependancies.=0A=
          */=0A=
         DWORD ticks =3D GetTickCount ();=0A=
-        filebuf =3D new char[bufalloc =3D 40];=0A=
+        filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 40);=0A=
         __small_sprintf (filebuf, "%d.%02d\n", ticks / 1000,=0A=
                          (ticks / 10) % 100);=0A=
         filesize =3D strlen (filebuf);=0A=
Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.3=0A=
diff -u -3 -p -u -p -a -w -r1.3 fhandler_process.cc=0A=
--- fhandler_process.cc	3 May 2002 02:43:45 -0000	1.3=0A=
+++ fhandler_process.cc	3 May 2002 14:18:00 -0000=0A=
@@ -21,23 +21,27 @@ details. */=0A=
 #include "pinfo.h"=0A=
 #include "path.h"=0A=
 #include "shared_info.h"=0A=
+#include "dtable.h"=0A=
+#include "cygheap.h"=0A=
 #include <assert.h>=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
 #include <dirent.h>=0A=
=20=0A=
-static const int PROCESS_PPID =3D 0;=0A=
-static const int PROCESS_EXENAME =3D 1;=0A=
-static const int PROCESS_WINPID =3D 2;=0A=
-static const int PROCESS_WINEXENAME =3D 3;=0A=
-static const int PROCESS_STATUS =3D 4;=0A=
-static const int PROCESS_UID =3D 5;=0A=
-static const int PROCESS_GID =3D 6;=0A=
-static const int PROCESS_PGID =3D 7;=0A=
-static const int PROCESS_SID =3D 8;=0A=
-static const int PROCESS_CTTY =3D 9;=0A=
+static const int PROCESS_PPID =3D 2;=0A=
+static const int PROCESS_EXENAME =3D 3;=0A=
+static const int PROCESS_WINPID =3D 4;=0A=
+static const int PROCESS_WINEXENAME =3D 5;=0A=
+static const int PROCESS_STATUS =3D 6;=0A=
+static const int PROCESS_UID =3D 7;=0A=
+static const int PROCESS_GID =3D 8;=0A=
+static const int PROCESS_PGID =3D 9;=0A=
+static const int PROCESS_SID =3D 10;=0A=
+static const int PROCESS_CTTY =3D 11;=0A=
=20=0A=
 static const char *process_listing[] =3D {=0A=
+  ".",=0A=
+  "..",=0A=
   "ppid",=0A=
   "exename",=0A=
   "winpid",=0A=
@@ -133,13 +137,13 @@ fhandler_process::open (path_conv *pc, i=0A=
=20=0A=
   if (*path =3D=3D 0)=0A=
     {=0A=
-      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+      if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
         {=0A=
           set_errno (EEXIST);=0A=
           res =3D 0;=0A=
           goto out;=0A=
         }=0A=
-      else if (mode & O_WRONLY)=0A=
+      else if (flags & O_WRONLY)=0A=
         {=0A=
           set_errno (EISDIR);=0A=
           res =3D 0;=0A=
@@ -161,7 +165,7 @@ fhandler_process::open (path_conv *pc, i=0A=
     }=0A=
   if (process_file_no =3D=3D -1)=0A=
     {=0A=
-      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+      if (flags & O_CREAT)=0A=
         {=0A=
           set_errno (EROFS);=0A=
           res =3D 0;=0A=
@@ -174,7 +178,7 @@ fhandler_process::open (path_conv *pc, i=0A=
           goto out;=0A=
         }=0A=
     }=0A=
-  if (mode & O_WRONLY)=0A=
+  if (flags & O_WRONLY)=0A=
     {=0A=
       set_errno (EROFS);=0A=
       res =3D 0;=0A=
@@ -203,7 +207,7 @@ found:=0A=
     case PROCESS_CTTY:=0A=
     case PROCESS_PPID:=0A=
       {=0A=
-        filebuf =3D new char[bufalloc =3D 40];=0A=
+        filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 40);=0A=
         int num;=0A=
         switch (process_file_no)=0A=
           {=0A=
@@ -230,7 +234,7 @@ found:=0A=
       }=0A=
     case PROCESS_EXENAME:=0A=
       {=0A=
-        filebuf =3D new char[bufalloc =3D MAX_PATH];=0A=
+        filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D MAX_PATH);=0A=
         if (p->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
           strcpy (filebuf, "<defunct>");=0A=
         else=0A=
@@ -249,7 +253,7 @@ found:=0A=
       }=0A=
     case PROCESS_WINPID:=0A=
       {=0A=
-        filebuf =3D new char[bufalloc =3D 40];=0A=
+        filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 40);=0A=
         __small_sprintf (filebuf, "%d\n", p->dwProcessId);=0A=
         filesize =3D strlen (filebuf);=0A=
         break;=0A=
@@ -257,7 +261,7 @@ found:=0A=
     case PROCESS_WINEXENAME:=0A=
       {=0A=
         int len =3D strlen (p->progname);=0A=
-        filebuf =3D new char[len + 2];=0A=
+        filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D (len + 2));=
=0A=
         strcpy (filebuf, p->progname);=0A=
         filebuf[len] =3D '\n';=0A=
         filesize =3D len + 1;=0A=
@@ -265,7 +269,7 @@ found:=0A=
       }=0A=
     case PROCESS_STATUS:=0A=
       {=0A=
-        filebuf =3D new char[bufalloc =3D 3];=0A=
+        filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc =3D 3);=0A=
         filebuf[0] =3D ' ';=0A=
         filebuf[1] =3D '\n';=0A=
         filebuf[2] =3D 0;=0A=
Index: fhandler_registry.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_registry.cc,v=0A=
retrieving revision 1.2=0A=
diff -u -3 -p -u -p -a -w -r1.2 fhandler_registry.cc=0A=
--- fhandler_registry.cc	3 May 2002 02:43:45 -0000	1.2=0A=
+++ fhandler_registry.cc	3 May 2002 14:18:01 -0000=0A=
@@ -20,6 +20,8 @@ details. */=0A=
 #include "security.h"=0A=
 #include "fhandler.h"=0A=
 #include "path.h"=0A=
+#include "dtable.h"=0A=
+#include "cygheap.h"=0A=
 #include <assert.h>=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
@@ -32,12 +34,15 @@ static const int registry_len =3D sizeof (=0A=
  * make up the value index if we are enuerating values.=0A=
  */=0A=
 static const __off32_t REG_ENUM_VALUES_MASK =3D 0x8000000;=0A=
+static const __off32_t REG_POSITION_MASK    =3D 0xffff;=0A=
=20=0A=
 /* List of root keys in /proc/registry.=0A=
  * Possibly we should filter out those not relevant to the flavour of Wind=
ows=0A=
  * Cygwin is running on.=0A=
  */=0A=
 static const char *registry_listing[] =3D {=0A=
+  ".",=0A=
+  "..",=0A=
   "HKEY_CLASSES_ROOT",=0A=
   "HKEY_CURRENT_CONFIG",=0A=
   "HKEY_CURRENT_USER",=0A=
@@ -49,6 +54,8 @@ static const char *registry_listing[] =3D=20=0A=
 };=0A=
=20=0A=
 static const HKEY registry_keys[] =3D {=0A=
+  (HKEY) INVALID_HANDLE_VALUE,=0A=
+  (HKEY) INVALID_HANDLE_VALUE,=0A=
   HKEY_CLASSES_ROOT,=0A=
   HKEY_CURRENT_CONFIG,=0A=
   HKEY_CURRENT_USER,=0A=
@@ -60,6 +67,18 @@ static const HKEY registry_keys[] =3D {=0A=
=20=0A=
 static const int ROOT_KEY_COUNT =3D sizeof(registry_keys) / sizeof(HKEY);=
=0A=
=20=0A=
+/* These get added to each subdirectory in /proc/registry.=0A=
+ * If we wanted to implement writing, we could maybe add a '.writable' ent=
ry or=0A=
+ * suchlike.=0A=
+ */=0A=
+static const char *special_dot_files[] =3D {=0A=
+  ".",=0A=
+  "..",=0A=
+  NULL=0A=
+};=0A=
+=0A=
+static const int SPECIAL_DOT_FILE_COUNT =3D (sizeof(special_dot_files) / s=
izeof(const char *)) - 1;=0A=
+=0A=
 /* Name given to default values */=0A=
 static const char *DEFAULT_VALUE_NAME =3D "@";=0A=
=20=0A=
@@ -213,6 +232,11 @@ fhandler_registry::readdir (DIR * dir)=0A=
     }=0A=
   if (dir->__d_u.__d_data.__handle =3D=3D INVALID_HANDLE_VALUE)=0A=
     goto out;=0A=
+  if (dir->__d_position < SPECIAL_DOT_FILE_COUNT) {=0A=
+      strcpy (dir->__d_dirent->d_name, special_dot_files[dir->__d_position=
++]);=0A=
+      res =3D dir->__d_dirent;=0A=
+      goto out;=0A=
+  }=0A=
 retry:=0A=
   if (dir->__d_position & REG_ENUM_VALUES_MASK)=0A=
     /* For the moment, the type of key is ignored here. when write access =
is added,=0A=
@@ -223,8 +247,8 @@ retry:=0A=
                           buf, &buf_size, NULL, NULL, NULL, NULL);=0A=
   else=0A=
     error =3D=0A=
-      RegEnumKeyEx ((HKEY) dir->__d_u.__d_data.__handle, dir->__d_position=
,=0A=
-                    buf, &buf_size, NULL, NULL, NULL, NULL);=0A=
+      RegEnumKeyEx ((HKEY) dir->__d_u.__d_data.__handle, dir->__d_position=
 -=0A=
+                    SPECIAL_DOT_FILE_COUNT, buf, &buf_size, NULL, NULL, NU=
LL, NULL);=0A=
   if (error =3D=3D ERROR_NO_MORE_ITEMS=0A=
       && (dir->__d_position & REG_ENUM_VALUES_MASK) =3D=3D 0)=0A=
     {=0A=
@@ -260,7 +284,7 @@ out:=0A=
 __off64_t=0A=
 fhandler_registry::telldir (DIR * dir)=0A=
 {=0A=
-  return dir->__d_position & REG_ENUM_VALUES_MASK;=0A=
+  return dir->__d_position & REG_POSITION_MASK;=0A=
 }=0A=
=20=0A=
 void=0A=
@@ -270,7 +294,7 @@ fhandler_registry::seekdir (DIR * dir, _=0A=
    * values.=0A=
    */=0A=
   rewinddir (dir);=0A=
-  while (loc > dir->__d_position)=0A=
+  while (loc > (dir->__d_position & REG_POSITION_MASK))=0A=
     if (!readdir (dir))=0A=
       break;=0A=
 }=0A=
@@ -318,13 +342,13 @@ fhandler_registry::open (path_conv *pc,=20=0A=
   path =3D get_name () + proc_len + 1 + registry_len;=0A=
   if (!*path)=0A=
     {=0A=
-      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+      if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
         {=0A=
           set_errno (EEXIST);=0A=
           res =3D 0;=0A=
           goto out;=0A=
         }=0A=
-      else if (mode & O_WRONLY)=0A=
+      else if (flags & O_WRONLY)=0A=
         {=0A=
           set_errno (EISDIR);=0A=
           res =3D 0;=0A=
@@ -351,13 +375,13 @@ fhandler_registry::open (path_conv *pc,=20=0A=
         if (path_prefix_p=0A=
             (registry_listing[i], path, strlen (registry_listing[i])))=0A=
           {=0A=
-            if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+            if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
               {=0A=
                 set_errno (EEXIST);=0A=
                 res =3D 0;=0A=
                 goto out;=0A=
               }=0A=
-            else if (mode & O_WRONLY)=0A=
+            else if (flags & O_WRONLY)=0A=
               {=0A=
                 set_errno (EISDIR);=0A=
                 res =3D 0;=0A=
@@ -370,7 +394,7 @@ fhandler_registry::open (path_conv *pc,=20=0A=
               }=0A=
           }=0A=
=20=0A=
-      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+      if (flags & O_CREAT)=0A=
         {=0A=
           set_errno (EROFS);=0A=
           res =3D 0;=0A=
@@ -384,15 +408,16 @@ fhandler_registry::open (path_conv *pc,=20=0A=
         }=0A=
     }=0A=
=20=0A=
-  hKey =3D open_key (path, KEY_READ, true);=0A=
-  if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+  if (flags & O_WRONLY)=0A=
     {=0A=
+      set_errno (EROFS);=0A=
       res =3D 0;=0A=
       goto out;=0A=
     }=0A=
-  if (mode & O_WRONLY)=0A=
+=0A=
+  hKey =3D open_key (path, KEY_READ, true);=0A=
+  if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
     {=0A=
-      set_errno (EROFS);=0A=
       res =3D 0;=0A=
       goto out;=0A=
     }=0A=
@@ -409,7 +434,7 @@ fhandler_registry::open (path_conv *pc,=20=0A=
           goto out;=0A=
         }=0A=
       bufalloc =3D size;=0A=
-      filebuf =3D new char[bufalloc];=0A=
+      filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc);=0A=
       error =3D=0A=
         RegQueryValueEx (hKey, file, NULL, NULL, (BYTE *) filebuf, &size);=
=0A=
       if (error !=3D ERROR_SUCCESS)=0A=
@@ -428,8 +453,8 @@ fhandler_registry::open (path_conv *pc,=20=0A=
           bufalloc +=3D 1000;=0A=
           if (filebuf)=0A=
             {=0A=
-              delete filebuf;=0A=
-              filebuf =3D new char[bufalloc];=0A=
+              cfree (filebuf);=0A=
+              filebuf =3D (char *) cmalloc (HEAP_BUF, bufalloc);=0A=
             }=0A=
           error =3D=0A=
             RegQueryValueEx (hKey, file, NULL, &type, (BYTE *) filebuf,=0A=
Index: fhandler_virtual.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v=0A=
retrieving revision 1.2=0A=
diff -u -3 -p -u -p -a -w -r1.2 fhandler_virtual.cc=0A=
--- fhandler_virtual.cc	3 May 2002 02:43:45 -0000	1.2=0A=
+++ fhandler_virtual.cc	3 May 2002 14:18:01 -0000=0A=
@@ -19,8 +19,8 @@ details. */=0A=
 #include "fhandler.h"=0A=
 #include "path.h"=0A=
 #include "dtable.h"=0A=
-#include "cygheap.h"=0A=
 #include "shared_info.h"=0A=
+#include "cygheap.h"=0A=
 #include <assert.h>=0A=
=20=0A=
 #define _COMPILING_NEWLIB=0A=
@@ -132,18 +132,25 @@ fhandler_virtual::lseek (__off32_t offse=0A=
 int=0A=
 fhandler_virtual::dup (fhandler_base * child)=0A=
 {=0A=
+  int ret =3D fhandler_base::dup (child);=0A=
+=0A=
+  if (!ret)=0A=
+    {=0A=
   fhandler_virtual *fhproc_child =3D (fhandler_virtual *) child;=0A=
-  fhproc_child->filebuf =3D new char[filesize];=0A=
+      fhproc_child->filebuf =3D (char *) cmalloc (HEAP_BUF, filesize);=0A=
   fhproc_child->bufalloc =3D fhproc_child->filesize =3D filesize;=0A=
   fhproc_child->position =3D position;=0A=
-  return 0;=0A=
+      memcpy (fhproc_child->filebuf, filebuf, filesize);=0A=
+      fhproc_child->set_flags (get_flags ());=0A=
+    }=0A=
+  return ret;=0A=
 }=0A=
=20=0A=
 int=0A=
 fhandler_virtual::close ()=0A=
 {=0A=
   if (filebuf)=0A=
-    delete[]filebuf;=0A=
+    cfree (filebuf);=0A=
   filebuf =3D NULL;=0A=
   bufalloc =3D -1;=0A=
   cygwin_shared->delqueue.process_queue ();=0A=
@@ -176,7 +183,7 @@ fhandler_virtual::read (void *ptr, size_=0A=
 int=0A=
 fhandler_virtual::write (const void *ptr, size_t len)=0A=
 {=0A=
-  set_errno (EROFS);=0A=
+  set_errno (EACCES);=0A=
   return -1;=0A=
 }=0A=
=20=0A=
@@ -196,6 +203,8 @@ fhandler_virtual::open (path_conv *, int=0A=
   set_socket_p (false);=0A=
=20=0A=
   set_flags (flags);=0A=
+=0A=
+  set_nohandle (true);=0A=
=20=0A=
   return 1;=0A=
 }=0A=
Index: path.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v=0A=
retrieving revision 1.203=0A=
diff -u -3 -p -u -p -a -w -r1.203 path.cc=0A=
--- path.cc	3 May 2002 02:43:45 -0000	1.203=0A=
+++ path.cc	3 May 2002 14:18:12 -0000=0A=
@@ -525,13 +525,11 @@ path_conv::check (const char *src, unsig=0A=
               int file_type =3D fh->exists (path_copy);=0A=
               switch (file_type)=0A=
                 {=0A=
-                  case 0:=0A=
-                    error =3D ENOENT;=0A=
-		    break;=0A=
                   case 1:=0A=
                   case 2:=0A=
                     fileattr =3D FILE_ATTRIBUTE_DIRECTORY;=0A=
 		    break;=0A=
+                  default:=0A=
                   case -1:=0A=
                     fileattr =3D 0;=0A=
                 }=0A=

------=_NextPart_000_005A_01C1F2B6.EC402140--
