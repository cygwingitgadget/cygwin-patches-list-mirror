Return-Path: <cygwin-patches-return-4664-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5919 invoked by alias); 10 Apr 2004 16:51:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5910 invoked from network); 10 Apr 2004 16:51:01 -0000
Message-Id: <3.0.5.32.20040410124817.0083fc20@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 10 Apr 2004 16:51:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: rootdir
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1081630097==_"
X-SW-Source: 2004-q2/txt/msg00016.txt.bz2

--=====================_1081630097==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 367

This patch avoids a couple of long strcpy. 

Pierre

2004-04-10  Pierre Humblet <pierre.humblet@ieee.org>
 
	* fhandler.cc (rootdir): Add and use second argument.
	* winsup.h: (rootdir) Add second argument in declaration.
	* path.cc (fs_info::update): Modify call to rootdir.
	* syscalls.cc (check_posix_perm): Ditto.
	(statfs): Ditto. Move syscall_printf near top.


--=====================_1081630097==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="rootdir.diff"
Content-length: 4664

Index: winsup.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.139
diff -u -p -r1.139 winsup.h
--- winsup.h	9 Apr 2004 12:09:45 -0000	1.139
+++ winsup.h	10 Apr 2004 16:08:28 -0000
@@ -240,7 +240,7 @@ int __stdcall stat_dev (DWORD, int, unsi

 __ino64_t __stdcall hash_path_name (__ino64_t hash, const char *name) __at=
tribute__ ((regparm(2)));
 void __stdcall nofinalslash (const char *src, char *dst) __attribute__ ((r=
egparm(2)));
-extern "C" char *__stdcall rootdir (char *full_path) __attribute__ ((regpa=
rm(1)));
+extern "C" char *__stdcall rootdir (const char *full_path, char *root_path=
) __attribute__ ((regparm(2)));

 /* String manipulation */
 extern "C" char *__stdcall strccpy (char *s1, const char **s2, char c);
Index: fhandler.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.181
diff -u -p -r1.181 fhandler.cc
--- fhandler.cc	10 Apr 2004 13:45:09 -0000	1.181
+++ fhandler.cc	10 Apr 2004 16:08:30 -0000
@@ -1028,36 +1028,41 @@ fhandler_base::lock (int, struct __flock
 }

 extern "C" char * __stdcall
-rootdir (char *full_path)
+rootdir (const char *full_path, char *root_path)
 {
   /* Possible choices:
    * d:... -> d:/
    * \\server\share... -> \\server\share\
-   * else current drive.
    */
-  char *root =3D full_path;
+  int len;

   if (full_path[1] =3D=3D ':')
-    strcpy (full_path + 2, "\\");
+    {
+      len =3D 2;
+      memcpy (root_path, full_path, 2);
+    }
   else if (full_path[0] =3D=3D '\\' && full_path[1] =3D=3D '\\')
     {
-      char *cp =3D full_path + 2;
+      const char *cp =3D full_path + 2;
       while (*cp && *cp !=3D '\\')
 	cp++;
       if (!*cp)
-	{
-	  set_errno (ENOTDIR);
-	  return NULL;
-	}
+	goto error;
       cp++;
       while (*cp && *cp !=3D '\\')
 	cp++;
-      strcpy (cp, "\\");
+      len =3D cp - full_path;
+      memcpy (root_path, full_path, len);
+    }
+  else
+    {
+    error:
+      set_errno (ENOTDIR);
+      return NULL;
     }
-  else
-    root =3D NULL;

-  return root;
+  strcpy(root_path + len, "\\");
+  return root_path;
 }

 int __stdcall
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.324
diff -u -p -r1.324 syscalls.cc
--- syscalls.cc	10 Apr 2004 13:45:10 -0000	1.324
+++ syscalls.cc	10 Apr 2004 16:08:34 -0000
@@ -1457,7 +1457,7 @@ check_posix_perm (const char *fname, int
   if (!allow_ntsec)
     return 0;

-  char *root =3D rootdir (strcpy ((char *)alloca (strlen (fname)), fname));
+  char *root =3D rootdir (fname, (char *)alloca (strlen (fname)));

   if (!allow_smbntsec
       && ((root[0] =3D=3D '\\' && root[1] =3D=3D '\\')
@@ -1793,7 +1793,9 @@ get_osfhandle (int fd)
 extern "C" int
 statfs (const char *fname, struct statfs *sfs)
 {
-  char root_dir[CYG_MAX_PATH];
+  char root[CYG_MAX_PATH];
+
+  syscall_printf ("statfs %s", fname);

   if (!sfs)
     {
@@ -1802,10 +1804,8 @@ statfs (const char *fname, struct statfs
     }

   path_conv full_path (fname, PC_SYM_FOLLOW | PC_FULL);
-  strncpy (root_dir, full_path, CYG_MAX_PATH);
-  const char *root =3D rootdir (root_dir);
-
-  syscall_printf ("statfs %s", root);
+  if (!rootdir (full_path, root))
+    return -1;

   /* GetDiskFreeSpaceEx must be called before GetDiskFreeSpace on
      WinME, to avoid the MS KB 314417 bug */
Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.296
diff -u -p -r1.296 path.cc
--- path.cc	10 Apr 2004 13:45:10 -0000	1.296
+++ path.cc	10 Apr 2004 16:08:40 -0000
@@ -361,9 +361,8 @@ fs_info::update (const char *win32_path)
 {
   char fsname [CYG_MAX_PATH];
   char root_dir [CYG_MAX_PATH];
-  strncpy (root_dir, win32_path, CYG_MAX_PATH);

-  if (!rootdir (root_dir))
+  if (!rootdir (win32_path, root_dir))
     {
       debug_printf ("Cannot get root component of path %s", win32_path);
       clear ();

--=====================_1081630097==_--
