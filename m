Return-Path: <cygwin-patches-return-4424-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5564 invoked by alias); 18 Nov 2003 19:06:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5551 invoked from network); 18 Nov 2003 19:06:14 -0000
Message-ID: <71A0F7B0F1F4F94F85F3D64C4BD0CCFE03D6A2E0@bmkc1svmail01.am.mfg>
From: "Parker, Ron" <rdparker@butlermfg.com>
To: cygwin-patches@cygwin.com
Subject: RE: thunk createDirectory and createFile calls
Date: Tue, 18 Nov 2003 19:06:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3AE06.D0ABC260"
X-SW-Source: 2003-q4/txt/msg00143.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3AE06.D0ABC260
Content-Type: text/plain;
	charset="iso-8859-1"
Content-length: 934

> From: Corinna Vinschen [mailto:cygwin-patches@cygwin.com]

> Well, we have a small problem with get_file_attributes and
> set_file_attributes.  We already have two functions called
> get_file_attribute and set_file_attribute.  Note that the difference
> is only the trailing 's'.
> 
> I'd suggest to change the name of the exisiting functions to something
> a bit different so that it's less likely to confuse the two calls.
> get_file_permissions and set_file_permissions would be good names for
> them, wouldn't they?

Here's a small patch against this morning's CVS that does this, and its
Changelog.

2003-11-18  Ron Parker <rparker1@kc.rr.com>

        * dir.cc: Changed get_file_attribute and set_file_attribute to
        get_file_permissions and set_file_permissions.
        * fhandler_disk_file.cc: Ditto.
        * path.cc: Ditto.
        * security.cc: Ditto.
        * security.h: Ditto.
        * syscalls.cc: Ditto.


------_=_NextPart_000_01C3AE06.D0ABC260
Content-Type: application/octet-stream;
	name="cvs01-file-permissions.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cvs01-file-permissions.diff"
Content-length: 7252

diff -Naur -x '*~' -x '*.orig' ../../../cygwin-cvs.orig/winsup/cygwin/dir.c=
c ./dir.cc=0A=
--- ../../../cygwin-cvs.orig/winsup/cygwin/dir.cc	2003-11-18 12:55:06.10835=
2000 -0600=0A=
+++ ./dir.cc	2003-11-18 12:59:50.907873600 -0600=0A=
@@ -283,8 +283,8 @@=0A=
   if (CreateDirectoryA (real_dir.get_win32 (), &sa))=0A=
     {=0A=
       if (!allow_ntsec && allow_ntea)=0A=
-	set_file_attribute (real_dir.has_acls (), real_dir.get_win32 (),=0A=
-			    S_IFDIR | ((mode & 07777) & ~cygheap->umask));=0A=
+	set_file_permissions (real_dir.has_acls (), real_dir.get_win32 (),=0A=
+			      S_IFDIR | ((mode & 07777) & ~cygheap->umask));=0A=
 #ifdef HIDDEN_DOT_FILES=0A=
       char *c =3D strrchr (real_dir.get_win32 (), '\\');=0A=
       if ((c && c[1] =3D=3D '.') || *real_dir.get_win32 () =3D=3D '.')=0A=
diff -Naur -x '*~' -x '*.orig' ../../../cygwin-cvs.orig/winsup/cygwin/fhand=
ler_disk_file.cc ./fhandler_disk_file.cc=0A=
--- ../../../cygwin-cvs.orig/winsup/cygwin/fhandler_disk_file.cc	2003-11-18=
 12:55:07.490339200 -0600=0A=
+++ ./fhandler_disk_file.cc	2003-11-18 12:59:50.947931200 -0600=0A=
@@ -291,15 +291,15 @@=0A=
     {=0A=
       /* symlinks are everything for everyone! */=0A=
       buf->st_mode =3D S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO;=0A=
-      get_file_attribute (pc.has_acls (), get_win32_name (), NULL,=0A=
-			  &buf->st_uid, &buf->st_gid);=0A=
+      get_file_permissions (pc.has_acls (), get_win32_name (), NULL,=0A=
+			    &buf->st_uid, &buf->st_gid);=0A=
       goto done;=0A=
     }=0A=
   else if (pc.issocket ())=0A=
     buf->st_mode =3D S_IFSOCK;=0A=
=20=0A=
-  if (get_file_attribute (pc.has_acls (), get_win32_name (), &buf->st_mode=
,=0A=
-			  &buf->st_uid, &buf->st_gid) =3D=3D 0)=0A=
+  if (get_file_permissions (pc.has_acls (), get_win32_name (), &buf->st_mo=
de,=0A=
+			    &buf->st_uid, &buf->st_gid) =3D=3D 0)=0A=
     {=0A=
       /* If read-only attribute is set, modify ntsec return value */=0A=
       if (pc.has_attribute (FILE_ATTRIBUTE_READONLY) && !get_symlink_p ())=
=0A=
@@ -422,7 +422,7 @@=0A=
   if (flags & O_CREAT=0A=
       && GetLastError () !=3D ERROR_ALREADY_EXISTS=0A=
       && !allow_ntsec && allow_ntea)=0A=
-    set_file_attribute (has_acls (), get_win32_name (), mode);=0A=
+    set_file_permissions (has_acls (), get_win32_name (), mode);=0A=
=20=0A=
   set_fs_flags (pc.fs_flags ());=0A=
   set_symlink_p (pc.issymlink ());=0A=
diff -Naur -x '*~' -x '*.orig' ../../../cygwin-cvs.orig/winsup/cygwin/path.=
cc ./path.cc=0A=
--- ../../../cygwin-cvs.orig/winsup/cygwin/path.cc	2003-11-18 12:55:16.2128=
81600 -0600=0A=
+++ ./path.cc	2003-11-18 12:59:51.028046400 -0600=0A=
@@ -2611,9 +2611,9 @@=0A=
 	{=0A=
 	  CloseHandle (h);=0A=
 	  if (!allow_ntsec && allow_ntea)=0A=
-	    set_file_attribute (win32_path.has_acls (),=0A=
-				win32_path.get_win32 (),=0A=
-				S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO);=0A=
+	    set_file_permissions (win32_path.has_acls (),=0A=
+				  win32_path.get_win32 (),=0A=
+				  S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO);=0A=
=20=0A=
 	  DWORD attr =3D use_winsym ? FILE_ATTRIBUTE_READONLY=0A=
 	    			  : FILE_ATTRIBUTE_SYSTEM;=0A=
diff -Naur -x '*~' -x '*.orig' ../../../cygwin-cvs.orig/winsup/cygwin/secur=
ity.cc ./security.cc=0A=
--- ../../../cygwin-cvs.orig/winsup/cygwin/security.cc	2003-11-18 12:55:19.=
217201600 -0600=0A=
+++ ./security.cc	2003-11-18 12:59:51.058089600 -0600=0A=
@@ -1377,8 +1377,8 @@=0A=
 }=0A=
=20=0A=
 int=0A=
-get_file_attribute (int use_ntsec, const char *file,=0A=
-		    mode_t *attribute, __uid32_t *uidret, __gid32_t *gidret)=0A=
+get_file_permissions (int use_ntsec, const char *file,=0A=
+		      mode_t *attribute, __uid32_t *uidret, __gid32_t *gidret)=0A=
 {=0A=
   int res;=0A=
   syscall_printf ("file: %s", file);=0A=
@@ -1843,8 +1843,8 @@=0A=
 }=0A=
=20=0A=
 int=0A=
-set_file_attribute (int use_ntsec, const char *file,=0A=
-		    __uid32_t uid, __gid32_t gid, int attribute)=0A=
+set_file_permissions (int use_ntsec, const char *file,=0A=
+		      __uid32_t uid, __gid32_t gid, int attribute)=0A=
 {=0A=
   int ret =3D 0;=0A=
=20=0A=
@@ -1856,16 +1856,16 @@=0A=
       __seterrno ();=0A=
       ret =3D -1;=0A=
     }=0A=
-  syscall_printf ("%d =3D set_file_attribute (%s, %d, %d, %p)",=0A=
+  syscall_printf ("%d =3D set_file_permissions (%s, %d, %d, %p)",=0A=
 		  ret, file, uid, gid, attribute);=0A=
   return ret;=0A=
 }=0A=
=20=0A=
 int=0A=
-set_file_attribute (int use_ntsec, const char *file, int attribute)=0A=
+set_file_permissions (int use_ntsec, const char *file, int attribute)=0A=
 {=0A=
-  return set_file_attribute (use_ntsec, file,=0A=
-			     myself->uid, myself->gid, attribute);=0A=
+  return set_file_permissions (use_ntsec, file,=0A=
+			       myself->uid, myself->gid, attribute);=0A=
 }=0A=
=20=0A=
 int=0A=
diff -Naur -x '*~' -x '*.orig' ../../../cygwin-cvs.orig/winsup/cygwin/secur=
ity.h ./security.h=0A=
--- ../../../cygwin-cvs.orig/winsup/cygwin/security.h	2003-11-18 12:55:19.2=
57259200 -0600=0A=
+++ ./security.h	2003-11-18 12:59:51.458665600 -0600=0A=
@@ -218,10 +218,10 @@=0A=
=20=0A=
 /* File manipulation */=0A=
 int __stdcall set_process_privileges ();=0A=
-int __stdcall get_file_attribute (int, const char *, mode_t *,=0A=
+int __stdcall get_file_permissions (int, const char *, mode_t *,=0A=
 				  __uid32_t * =3D NULL, __gid32_t * =3D NULL);=0A=
-int __stdcall set_file_attribute (int, const char *, int);=0A=
-int __stdcall set_file_attribute (int, const char *, __uid32_t, __gid32_t,=
 int);=0A=
+int __stdcall set_file_permissions (int, const char *, int);=0A=
+int __stdcall set_file_permissions (int, const char *, __uid32_t, __gid32_=
t, int);=0A=
 int __stdcall get_object_attribute (HANDLE handle, SE_OBJECT_TYPE object_t=
ype, mode_t *,=0A=
 				  __uid32_t * =3D NULL, __gid32_t * =3D NULL);=0A=
 LONG __stdcall read_sd(const char *file, PSECURITY_DESCRIPTOR sd_buf, LPDW=
ORD sd_size);=0A=
diff -Naur -x '*~' -x '*.orig' ../../../cygwin-cvs.orig/winsup/cygwin/sysca=
lls.cc ./syscalls.cc=0A=
--- ../../../cygwin-cvs.orig/winsup/cygwin/syscalls.cc	2003-11-18 12:55:20.=
348828800 -0600=0A=
+++ ./syscalls.cc	2003-11-18 12:59:51.478694400 -0600=0A=
@@ -842,12 +842,12 @@=0A=
       mode_t attrib =3D 0;=0A=
       if (win32_path.isdir ())=0A=
 	attrib |=3D S_IFDIR;=0A=
-      res =3D get_file_attribute (win32_path.has_acls (),=0A=
-				win32_path.get_win32 (),=0A=
-				&attrib);=0A=
+      res =3D get_file_permissions (win32_path.has_acls (),=0A=
+				  win32_path.get_win32 (),=0A=
+				  &attrib);=0A=
       if (!res)=0A=
-	 res =3D set_file_attribute (win32_path.has_acls (), win32_path, uid,=0A=
-				   gid, attrib);=0A=
+	 res =3D set_file_permissions (win32_path.has_acls (), win32_path, uid,=
=0A=
+				     gid, attrib);=0A=
       if (res !=3D 0 && (!win32_path.has_acls () || !allow_ntsec))=0A=
 	{=0A=
 	  /* fake - if not supported, pretend we're like win95=0A=
@@ -977,8 +977,8 @@=0A=
=20=0A=
       if (win32_path.isdir ())=0A=
 	mode |=3D S_IFDIR;=0A=
-      if (!set_file_attribute (win32_path.has_acls (), win32_path,=0A=
-			       ILLEGAL_UID, ILLEGAL_GID, mode)=0A=
+      if (!set_file_permissions (win32_path.has_acls (), win32_path,=0A=
+				 ILLEGAL_UID, ILLEGAL_GID, mode)=0A=
 	  && allow_ntsec)=0A=
 	res =3D 0;=0A=
=20=0A=

------_=_NextPart_000_01C3AE06.D0ABC260--
