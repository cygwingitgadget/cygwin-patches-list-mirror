Return-Path: <cygwin-patches-return-4687-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13954 invoked by alias); 19 Apr 2004 12:31:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13944 invoked from network); 19 Apr 2004 12:31:03 -0000
Message-Id: <3.0.5.32.20040419082815.008a65a0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Mon, 19 Apr 2004 12:31:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: chown etc
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1082392095==_"
X-SW-Source: 2004-q2/txt/msg00039.txt.bz2

--=====================_1082392095==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1338

This is the cleanup patch mentioned earlier, plus a few other 
things
- In fhandler_base::open_fs I changed the call to set_file_attribute
  as you already did recently in mkdir and symlink_worker, and
- I also eliminated the test of GetLastError. After all, CreateFile did
  succeed so the LastError is meaningless.
- I noticed that the test (fh) had to me moved up in stat_worker, and
  I applied the same test in chown_worker, chmod and access. While I
  was at it I removed PC_FULL, which is automatic in fhandlers. 
  In stat_worker I added a check for the path existence (for speed).
 
Pierre

2004-04-19  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler_disk_file.cc (fhandler_base::open_fs): Change set_file_attribute
	call to indicate that NT security isn't used. Remove call to GetLastError.
	(fhandler_disk_file::fchmod): Rearrange to isolate 9x related statements.
	Do not set FILE_ATTRIBUTE_SYSTEM. 
	(fhandler_disk_file::fchown): Check noop case first. 
	* fhandler.cc (fhandler_base::open9x): Remove ntsec related statements.
(fhandler_base::set_name): Do not set namehash.
	* fhandler.h (fhandler_base::get_namehash): Compute and set namehash if
	needed. 
	* syscalls (access): Verify that fh is not NULL. Do not set PC_FULL.
	(chmod): Ditto.
	(chown_worker): Ditto.
	(stat_worker): Ditto. Verify if the path exists.

--=====================_1082392095==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="chown.diff"
Content-length: 8865

Index: fhandler_disk_file.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.89
diff -u -p -r1.89 fhandler_disk_file.cc
--- fhandler_disk_file.cc	16 Apr 2004 21:22:13 -0000	1.89
+++ fhandler_disk_file.cc	19 Apr 2004 04:04:01 -0000
@@ -387,16 +387,19 @@ fhandler_disk_file::fchmod (mode_t mode)
 	  if (!(oret =3D open_fs (O_BINARY, 0)))
 	    return -1;
 	}
-    }

-  if (!allow_ntsec && allow_ntea) /* Not necessary when manipulating SD. */
-    SetFileAttributes (pc, (DWORD) pc & ~FILE_ATTRIBUTE_READONLY);
-  if (pc.isdir ())
-    mode |=3D S_IFDIR;
-  if (!set_file_attribute (pc.has_acls (), get_io_handle (), pc,
-			   ILLEGAL_UID, ILLEGAL_GID, mode)
-      && allow_ntsec)
-    res =3D 0;
+      if (!allow_ntsec && allow_ntea) /* Not necessary when manipulating S=
D. */
+	SetFileAttributes (pc, (DWORD) pc & ~FILE_ATTRIBUTE_READONLY);
+      if (pc.isdir ())
+	mode |=3D S_IFDIR;
+      if (!set_file_attribute (pc.has_acls (), get_io_handle (), pc,
+			       ILLEGAL_UID, ILLEGAL_GID, mode)
+	  && allow_ntsec)
+	res =3D 0;
+
+      if (oret)
+	close_fs ();
+    }

   /* if the mode we want has any write bits set, we can't be read only. */
   if (mode & (S_IWUSR | S_IWGRP | S_IWOTH))
@@ -404,18 +407,12 @@ fhandler_disk_file::fchmod (mode_t mode)
   else
     (DWORD) pc |=3D FILE_ATTRIBUTE_READONLY;

-  if (!pc.is_lnk_symlink () && S_ISLNK (mode) || S_ISSOCK (mode))
-    (DWORD) pc |=3D FILE_ATTRIBUTE_SYSTEM;
-
   if (!SetFileAttributes (pc, pc))
     __seterrno ();
   else if (!allow_ntsec)
     /* Correct NTFS security attributes have higher priority */
     res =3D 0;

-  if (oret)
-    close_fs ();
-
   return res;
 }

@@ -424,6 +421,13 @@ fhandler_disk_file::fchown (__uid32_t ui
 {
   int oret =3D 0;

+  if (!pc.has_acls () || !allow_ntsec)
+    {
+      /* fake - if not supported, pretend we're like win95
+         where it just works */
+      return 0;
+    }
+
   enable_restore_privilege ();
   if (!get_io_handle ())
     {
@@ -439,12 +443,6 @@ fhandler_disk_file::fchown (__uid32_t ui
   if (!res)
     res =3D set_file_attribute (pc.has_acls (), get_io_handle (), pc,
 			      uid, gid, attrib);
-  if (res && (!pc.has_acls () || !allow_ntsec))
-    {
-      /* fake - if not supported, pretend we're like win95
-         where it just works */
-      res =3D 0;
-    }

   if (oret)
     close_fs ();
@@ -585,9 +583,8 @@ fhandler_base::open_fs (int flags, mode_
      This code is now only used for ntea here since the files
      security attributes are set in CreateFile () now. */
   if (flags & O_CREAT
-      && GetLastError () !=3D ERROR_ALREADY_EXISTS
       && !allow_ntsec && allow_ntea)
-    set_file_attribute (has_acls (), NULL, get_win32_name (), mode);
+    set_file_attribute (false, NULL, get_win32_name (), mode);

   set_fs_flags (pc.fs_flags ());

Index: fhandler.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.186
diff -u -p -r1.186 fhandler.cc
--- fhandler.cc	16 Apr 2004 21:22:13 -0000	1.186
+++ fhandler.cc	19 Apr 2004 04:04:03 -0000
@@ -152,7 +152,6 @@ fhandler_base::set_name (path_conv &in_p
 {
   memcpy (&pc, &in_pc, in_pc.size ());
   pc.set_normalized_path (in_pc.normalized_path);
-  namehash =3D hash_path_name (0, get_win32_name ());
 }

 /* Detect if we are sitting at EOF for conditions where Windows
@@ -435,7 +434,6 @@ fhandler_base::open_9x (int flags, mode_
   int shared;
   int creation_distribution;
   SECURITY_ATTRIBUTES sa =3D sec_none;
-  security_descriptor sd;

   syscall_printf ("(%s, %p)", get_win32_name (), flags);

@@ -492,17 +490,12 @@ fhandler_base::open_9x (int flags, mode_
   if (!(mode & (S_IWUSR | S_IWGRP | S_IWOTH)))
     file_attributes |=3D FILE_ATTRIBUTE_READONLY;

-  /* If the file should actually be created and ntsec is on,
-     set files attributes. */
-  if (flags & O_CREAT && get_device () =3D=3D FH_FS && allow_ntsec && has_=
acls ())
-    set_security_attribute (mode, &sa, sd);
-
   x =3D CreateFile (get_win32_name (), access, shared, &sa, creation_distr=
ibution,
 		  file_attributes, 0);

   if (x =3D=3D INVALID_HANDLE_VALUE)
     {
-      if (!wincap.can_open_directories () && pc.isdir ())
+      if (pc.isdir ())
 	{
 	  if (flags & (O_CREAT | O_EXCL) =3D=3D (O_CREAT | O_EXCL))
 	    set_errno (EEXIST);
Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.204
diff -u -p -r1.204 fhandler.h
--- fhandler.h	16 Apr 2004 21:22:13 -0000	1.204
+++ fhandler.h	19 Apr 2004 04:04:05 -0000
@@ -217,7 +217,7 @@ class fhandler_base
   bool has_attribute (DWORD x) const {return pc.has_attribute (x);}
   const char *get_name () const { return pc.normalized_path; }
   const char *get_win32_name () { return pc.get_win32 (); }
-  __ino64_t get_namehash () { return namehash; }
+    __ino64_t get_namehash () { return namehash ? : namehash =3D hash_path=
_name (0, get_win32_name ()); }

   virtual void hclose (HANDLE h) {CloseHandle (h);}
   virtual void set_no_inheritance (HANDLE &h, int not_inheriting);
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.333
diff -u -p -r1.333 syscalls.cc
--- syscalls.cc	16 Apr 2004 21:22:13 -0000	1.333
+++ syscalls.cc	19 Apr 2004 04:04:09 -0000
@@ -827,8 +827,11 @@ chown_worker (const char *name, unsigned
     return 0;			// return zero (and do nothing) under Windows 9x

   int res =3D -1;
-  fhandler_base *fh =3D build_fh_name (name, NULL, fmode | PC_FULL,
-				     stat_suffixes);
+  fhandler_base *fh;
+
+  if (!(fh =3D build_fh_name (name, NULL, fmode, stat_suffixes)))
+    goto error;
+
   if (fh->error ())
     {
       debug_printf ("got %d error from build_fh_name", fh->error ());
@@ -838,6 +841,7 @@ chown_worker (const char *name, unsigned
     res =3D fh->fchown (uid, gid);

   delete fh;
+ error:
   syscall_printf ("%d =3D %schown (%s,...)",
 		  res, (fmode & PC_SYM_NOFOLLOW) ? "l" : "", name);
   return res;
@@ -916,8 +920,10 @@ extern "C" int
 chmod (const char *path, mode_t mode)
 {
   int res =3D -1;
-  fhandler_base *fh =3D build_fh_name (path, NULL, PC_SYM_FOLLOW | PC_FULL,
-				     stat_suffixes);
+  fhandler_base *fh;
+  if (!(fh =3D build_fh_name (path, NULL, PC_SYM_FOLLOW, stat_suffixes)))
+    goto error;
+
   if (fh->error ())
     {
       debug_printf ("got %d error from build_fh_name", fh->error ());
@@ -927,6 +933,7 @@ chmod (const char *path, mode_t mode)
     res =3D fh->fchmod (mode);

   delete fh;
+ error:
   syscall_printf ("%d =3D chmod (%s, %p)", res, path, mode);
   return res;
 }
@@ -1056,17 +1063,18 @@ stat_worker (const char *name, struct __
   fhandler_base *fh =3D NULL;

   if (check_null_invalid_struct_errno (buf))
-    goto done;
-
-  fh =3D build_fh_name (name, NULL, (nofollow ? PC_SYM_NOFOLLOW : PC_SYM_F=
OLLOW)
-		      		  | PC_FULL, stat_suffixes);
+    goto error;

+  if (!(fh =3D build_fh_name (name, NULL, nofollow ? PC_SYM_NOFOLLOW : PC_=
SYM_FOLLOW,
+			    stat_suffixes)))
+    goto error;
+
   if (fh->error ())
     {
       debug_printf ("got %d error from build_fh_name", fh->error ());
       set_errno (fh->error ());
     }
-  else
+  else if (fh->exists ())
     {
       debug_printf ("(%s, %p, %d, %p), file_attributes %d", name, buf, nof=
ollow,
 		    fh, (DWORD) *fh);
@@ -1082,10 +1090,11 @@ stat_worker (const char *name, struct __
 	    buf->st_rdev =3D buf->st_dev;
 	}
     }
+  else
+    set_errno (ENOENT);

- done:
-  if (fh)
-    delete fh;
+  delete fh;
+ error:
   MALLOC_CHECK;
   syscall_printf ("%d =3D (%s, %p)", res, name, buf);
   return res;
@@ -1158,9 +1167,12 @@ access (const char *fn, int flags)
     set_errno (EINVAL);
   else
     {
-      fhandler_base *fh =3D build_fh_name (fn, NULL, PC_SYM_FOLLOW | PC_FU=
LL, stat_suffixes);
-      res =3D  fh->fhaccess (flags);
-      delete fh;
+      fhandler_base *fh =3D build_fh_name (fn, NULL, PC_SYM_FOLLOW, stat_s=
uffixes);
+      if (fh)
+        {
+	  res =3D  fh->fhaccess (flags);
+	  delete fh;
+	}
     }
   debug_printf ("returning %d", res);
   return res;

--=====================_1082392095==_--
