Return-Path: <cygwin-patches-return-3878-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6750 invoked by alias); 23 May 2003 22:33:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6693 invoked from network); 23 May 2003 22:33:52 -0000
Message-Id: <3.0.5.32.20030523183423.008059c0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Fri, 23 May 2003 22:33:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: df and ls for root directories on Win9X
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1053743663==_"
X-SW-Source: 2003-q2/txt/msg00105.txt.bz2

--=====================_1053743663==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1337

On Win9X, ls reports incorrect date and size (aliasing 
with those from a file) for Windows filesystem root dirs.  

~: ls -ld /c /c/MSDOS.SYS 
drwxr-xr-x   12 pierre   unknown      1660 Jul 18  2001 /c/
-r--r--r--    1 pierre   unknown      1660 Jul 18  2001 /c/MSDOS.SYS

Also UNC pathnames of root directories cannot be stat. 

~: ls -ld //hpn5170x/c //hpn5170x/c/msdos.sys
ls: //hpn5170x/c: No such file or directory
-r--r--r--    1 pierre   unknown      1660 Jul 18  2001 //hpn5170x/c/msdos.sys

Both problems stem from incorrect use of FindFirstFile
(FindFirstFile(c:\*) does not return a handle to c:\ )

Also df is known to be broken for disks > 2 GB. A patch has been
submitted long ago, but was never completed:
<http://cygwin.com/ml/cygwin-patches/2001-q1/msg00183.html>
I have been in touch with the author, without looking at his patch.
He told me that he never got someone to sign the release.
I thus wrote a new patch from scratch.

2003-05-23  Pierre Humblet  <pierre.humblet@ieee.org>

	* autoload.cc (GetDiskFreeSpaceEx): Add.
	* syscalls.cc (statfs): Call full_path.root_dir() instead of
	rootdir(full_path). Use GetDiskFreeSpaceEx when available and
	report space available in addition to free space.
	* fhandler_disk_file.cc (fhandler_disk_file::fstat_by_name):
	Do not call FindFirstFile for disk root directories.

--=====================_1053743663==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ls_df.diff"
Content-length: 4546

Index: autoload.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.69
diff -u -p -r1.69 autoload.cc
--- autoload.cc	20 Apr 2003 08:56:42 -0000	1.69
+++ autoload.cc	23 May 2003 22:11:09 -0000
@@ -502,6 +502,7 @@ LoadDLLfuncEx (CreateHardLinkA, 12, kern
 LoadDLLfuncEx (CreateToolhelp32Snapshot, 8, kernel32, 1)
 LoadDLLfuncEx2 (GetCompressedFileSizeA, 8, kernel32, 1, 0xffffffff)
 LoadDLLfuncEx (GetConsoleWindow, 0, kernel32, 1)
+LoadDLLfuncEx (GetDiskFreeSpaceEx, 16, kernel32, 1)
 LoadDLLfuncEx (GetSystemTimes, 12, kernel32, 1)
 LoadDLLfuncEx2 (IsDebuggerPresent, 0, kernel32, 1, 1)
 LoadDLLfunc (IsProcessorFeaturePresent, 4, kernel32);
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.269
diff -u -p -r1.269 syscalls.cc
--- syscalls.cc	21 May 2003 08:01:57 -0000	1.269
+++ syscalls.cc	23 May 2003 22:11:29 -0000
@@ -1871,11 +1871,12 @@ statfs (const char *fname, struct statfs
     }

   path_conv full_path (fname, PC_SYM_FOLLOW | PC_FULL);
-  char *root =3D rootdir (full_path);
+
+  const char *root =3D full_path.root_dir();

   syscall_printf ("statfs %s", root);

-  DWORD spc, bps, freec, totalc;
+  DWORD spc, bps, availc, freec, totalc;

   if (!GetDiskFreeSpace (root, &spc, &bps, &freec, &totalc))
     {
@@ -1883,6 +1884,17 @@ statfs (const char *fname, struct statfs
       return -1;
     }

+  ULARGE_INTEGER availb, freeb, totalb;
+
+  if (GetDiskFreeSpaceEx (root, &availb, &totalb, &freeb))
+    {
+      availc =3D availb.QuadPart / (spc*bps);
+      totalc =3D totalb.QuadPart / (spc*bps);
+      freec =3D freeb.QuadPart / (spc*bps);
+    }
+  else
+    availc =3D freec;
+
   DWORD vsn, maxlen, flags;

   if (!GetVolumeInformation (root, NULL, 0, &vsn, &maxlen, &flags, NULL, 0=
))
@@ -1893,7 +1905,8 @@ statfs (const char *fname, struct statfs
   sfs->f_type =3D flags;
   sfs->f_bsize =3D spc*bps;
   sfs->f_blocks =3D totalc;
-  sfs->f_bfree =3D sfs->f_bavail =3D freec;
+  sfs->f_bavail =3D availc;
+  sfs->f_bfree =3D freec;
   sfs->f_files =3D -1;
   sfs->f_ffree =3D -1;
   sfs->f_fsid =3D vsn;
Index: fhandler_disk_file.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.50
diff -u -p -r1.50 fhandler_disk_file.cc
--- fhandler_disk_file.cc	11 May 2003 21:52:09 -0000	1.50
+++ fhandler_disk_file.cc	23 May 2003 22:11:42 -0000
@@ -109,39 +109,26 @@ fhandler_disk_file::fstat_by_name (struc
       set_errno (ENOENT);
       res =3D -1;
     }
+  else if (pc->isdir () && strlen (*pc) <=3D strlen (pc->root_dir ()))
+    {
+      FILETIME ft =3D {};
+      res =3D fstat_helper (buf, pc, ft, ft, ft, 0, 0);
+    }
+  else if ((handle =3D FindFirstFile (*pc, &local)) =3D=3D INVALID_HANDLE_=
VALUE)
+    {
+      debug_printf ("FindFirstFile failed for '%s', %E", (char *) *pc);
+      __seterrno ();
+      res =3D -1;
+    }
   else
     {
-      char drivebuf[5];
-      char *name;
-      if ((*pc)[3] !=3D '\0' || !isalpha ((*pc)[0]) || (*pc)[1] !=3D ':' |=
| (*pc)[2] !=3D '\\')
-	name =3D *pc;
-      else
-	{
-	  /* FIXME: Does this work on empty disks? */
-	  drivebuf[0] =3D (*pc)[0];
-	  drivebuf[1] =3D (*pc)[1];
-	  drivebuf[2] =3D (*pc)[2];
-	  drivebuf[3] =3D '*';
-	  drivebuf[4] =3D '\0';
-	  name =3D drivebuf;
-	}
-
-      if ((handle =3D FindFirstFile (name, &local)) =3D=3D INVALID_HANDLE_=
VALUE)
-      {
-	debug_printf ("FindFirstFile failed for '%s', %E", name);
-	__seterrno ();
-	res =3D -1;
-      }
-    else
-      {
-	FindClose (handle);
-	res =3D fstat_helper (buf, pc,
-			    local.ftCreationTime,
-			    local.ftLastAccessTime,
-			    local.ftLastWriteTime,
-			    local.nFileSizeHigh,
-			    local.nFileSizeLow);
-      }
+      FindClose (handle);
+      res =3D fstat_helper (buf, pc,
+			  local.ftCreationTime,
+			  local.ftLastAccessTime,
+			  local.ftLastWriteTime,
+			  local.nFileSizeHigh,
+			  local.nFileSizeLow);
     }
   return res;
 }

--=====================_1053743663==_--
