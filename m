Return-Path: <cygwin-patches-return-2146-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16724 invoked by alias); 3 May 2002 11:56:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16710 invoked from network); 3 May 2002 11:56:44 -0000
X-WM-Posted-At: avacado.atomice.net; Fri, 3 May 02 12:59:36 +0100
Message-ID: <00d801c1f299$fee62be0$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: Fix for incorrect handling of open flags in fhandler_proc
Date: Fri, 03 May 2002 04:56:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00D5_01C1F2A2.607FB350"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00130.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00D5_01C1F2A2.607FB350
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1060

This patch fixes some problems with the handling of open flags in
fhandler_proc, fhandler_process and fhandler_registry.

Regards
Chris

2002-05-03  Christopher January <chris@atomice.net>

 * fhandler_proc.cc (fhandler_proc::open): Change use of mode to flags.
 If the file does not exist already, fail with EROFS if O_CREAT flag is
 set.
 Change EROFS error to EACCES error when writing to a file.
 * fhandler_process.cc (fhandler_process::open): Change use of mode to
 flags.
 If the file does not exist already, fail with EROFS if O_CREAT flag is
 set.
 Change EROFS error to EACCES error when writing to a file.
 * fhandler_registry.cc (fhandler_registry::open): Change use of mode to
 flags.
 If the file does not exist already, fail with EROFS if O_CREAT flag is
 set.
 Change EROFS error to EACCES error when writing to a file.
 Move check for open for writing before open_key.
 * path.cc (path_conv::check): Do not return ENOENT if a file is not found
 in /proc.
 * fhandler_virtual.cc (fhandler_virtual::write): Change EROFS error to
 EACCES error.


------=_NextPart_000_00D5_01C1F2A2.607FB350
Content-Type: application/octet-stream;
	name="proc.patch.2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.patch.2"
Content-length: 9235

Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.2=0A=
diff -u -3 -p -u -p -a -b -B -r1.2 fhandler_proc.cc=0A=
--- fhandler_proc.cc	3 May 2002 02:43:45 -0000	1.2=0A=
+++ fhandler_proc.cc	3 May 2002 11:52:15 -0000=0A=
@@ -92,7 +92,19 @@ fhandler_proc::get_proc_fhandler (const=20=0A=
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
@@ -203,13 +215,13 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
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
@@ -229,13 +241,13 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
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
@@ -251,7 +263,7 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
=20=0A=
   if (proc_file_no =3D=3D -1)=0A=
     {=0A=
-      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+      if (flags & O_CREAT)=0A=
         {=0A=
           set_errno (EROFS);=0A=
           res =3D 0;=0A=
@@ -264,9 +276,9 @@ fhandler_proc::open (path_conv *pc, int=20=0A=
           goto out;=0A=
         }=0A=
     }=0A=
-  if (mode & O_WRONLY)=0A=
+  if (flags & O_WRONLY)=0A=
     {=0A=
-      set_errno (EROFS);=0A=
+      set_errno (EACCES);=0A=
       res =3D 0;=0A=
       goto out;=0A=
     }=0A=
Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.3=0A=
diff -u -3 -p -u -p -a -b -B -r1.3 fhandler_process.cc=0A=
--- fhandler_process.cc	3 May 2002 02:43:45 -0000	1.3=0A=
+++ fhandler_process.cc	3 May 2002 11:52:15 -0000=0A=
@@ -133,13 +133,13 @@ fhandler_process::open (path_conv *pc, i=0A=
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
@@ -161,7 +161,7 @@ fhandler_process::open (path_conv *pc, i=0A=
     }=0A=
   if (process_file_no =3D=3D -1)=0A=
     {=0A=
-      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+      if (flags & O_CREAT)=0A=
         {=0A=
           set_errno (EROFS);=0A=
           res =3D 0;=0A=
@@ -174,9 +174,9 @@ fhandler_process::open (path_conv *pc, i=0A=
           goto out;=0A=
         }=0A=
     }=0A=
-  if (mode & O_WRONLY)=0A=
+  if (flags & O_WRONLY)=0A=
     {=0A=
-      set_errno (EROFS);=0A=
+      set_errno (EACCES);=0A=
       res =3D 0;=0A=
       goto out;=0A=
     }=0A=
Index: fhandler_registry.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_registry.cc,v=0A=
retrieving revision 1.2=0A=
diff -u -3 -p -u -p -a -b -B -r1.2 fhandler_registry.cc=0A=
--- fhandler_registry.cc	3 May 2002 02:43:45 -0000	1.2=0A=
+++ fhandler_registry.cc	3 May 2002 11:52:16 -0000=0A=
@@ -318,13 +318,13 @@ fhandler_registry::open (path_conv *pc,=20=0A=
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
@@ -351,13 +351,13 @@ fhandler_registry::open (path_conv *pc,=20=0A=
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
@@ -370,7 +370,7 @@ fhandler_registry::open (path_conv *pc,=20=0A=
               }=0A=
           }=0A=
=20=0A=
-      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+      if (flags & O_CREAT)=0A=
         {=0A=
           set_errno (EROFS);=0A=
           res =3D 0;=0A=
@@ -384,15 +384,16 @@ fhandler_registry::open (path_conv *pc,=20=0A=
         }=0A=
     }=0A=
=20=0A=
-  hKey =3D open_key (path, KEY_READ, true);=0A=
-  if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+  if (flags & O_WRONLY)=0A=
     {=0A=
+      set_errno (EACCES);=0A=
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
Index: fhandler_virtual.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v=0A=
retrieving revision 1.2=0A=
diff -u -3 -p -u -p -a -b -B -r1.2 fhandler_virtual.cc=0A=
--- fhandler_virtual.cc	3 May 2002 02:43:45 -0000	1.2=0A=
+++ fhandler_virtual.cc	3 May 2002 11:52:17 -0000=0A=
@@ -133,6 +133,7 @@ int=0A=
 fhandler_virtual::dup (fhandler_base * child)=0A=
 {=0A=
   fhandler_virtual *fhproc_child =3D (fhandler_virtual *) child;=0A=
+  // FIXME: this is broken=0A=
   fhproc_child->filebuf =3D new char[filesize];=0A=
   fhproc_child->bufalloc =3D fhproc_child->filesize =3D filesize;=0A=
   fhproc_child->position =3D position;=0A=
@@ -176,7 +177,7 @@ fhandler_virtual::read (void *ptr, size_=0A=
 int=0A=
 fhandler_virtual::write (const void *ptr, size_t len)=0A=
 {=0A=
-  set_errno (EROFS);=0A=
+  set_errno (EACCES);=0A=
   return -1;=0A=
 }=0A=
=20=0A=
Index: path.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v=0A=
retrieving revision 1.203=0A=
diff -u -3 -p -u -p -a -b -B -r1.203 path.cc=0A=
--- path.cc	3 May 2002 02:43:45 -0000	1.203=0A=
+++ path.cc	3 May 2002 11:52:27 -0000=0A=
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

------=_NextPart_000_00D5_01C1F2A2.607FB350
Content-Type: application/octet-stream;
	name="ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog"
Content-length: 923

2002-05-03  Christopher January <chris@atomice.net>

	* fhandler_proc.cc (fhandler_proc::open): Change use of mode to flags.
	If the file does not exist already, fail with EROFS if O_CREAT flag is
	set.
	Change EROFS error to EACCES error when writing to a file.
	* fhandler_process.cc (fhandler_process::open): Change use of mode to
	flags.
	If the file does not exist already, fail with EROFS if O_CREAT flag is
	set.
	Change EROFS error to EACCES error when writing to a file.	
	* fhandler_registry.cc (fhandler_registry::open): Change use of mode to
	flags.
	If the file does not exist already, fail with EROFS if O_CREAT flag is
	set.
	Change EROFS error to EACCES error when writing to a file.
	Move check for open for writing before open_key.
	* path.cc (path_conv::check): Do not return ENOENT if a file is not found
	in /proc.
	* fhandler_virtual.cc (fhandler_virtual::write): Change EROFS error to
	EACCES error.

------=_NextPart_000_00D5_01C1F2A2.607FB350--
