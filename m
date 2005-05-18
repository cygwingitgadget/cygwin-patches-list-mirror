Return-Path: <cygwin-patches-return-5463-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31995 invoked by alias); 18 May 2005 12:24:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31369 invoked from network); 18 May 2005 12:24:07 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.140.130)
  by sourceware.org with SMTP; 18 May 2005 12:24:07 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.51)
	id IGOQCR-0002N8-NU
	for cygwin-patches@cygwin.com; Wed, 18 May 2005 08:22:04 -0400
Message-Id: <3.0.5.32.20050518082203.00b5ea78@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 18 May 2005 12:24:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: mkdir -p and network drives
In-Reply-To: <20050513195902.GA23129@trixie.casa.cgf.cx>
References: <loom.20050513T164025-465@post.gmane.org>
 <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
 <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
 <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
 <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net>
 <20050511085307.GA2805@calimero.vinschen.de>
 <007b01c5572b$b3925890$3e0010ac@wirelessworld.airvananet.com>
 <20050512200222.GD5569@trixie.casa.cgf.cx>
 <20050513135745.GD10577@trixie.casa.cgf.cx>
 <loom.20050513T164025-465@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1116433323==_"
X-SW-Source: 2005-q2/txt/msg00059.txt.bz2

--=====================_1116433323==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1202

Here is the implementation of mkdir and rmdir with fhandlers.

To prepare the day where proc_registry will allow writes,
I have removed setting PATH_RO and an error return from path.cc
(it's all handled in the fhandlers).

I have also removed obsolete code about fhandler_cygdrive.
There is another patch coming with minor corner case fixes.

Pierre
 
2005-05-18  Pierre Humblet <pierre.humblet@ieee.org>

	* devices.h: Delete FH_CYGDRIVE_A and FH_CYGDRIVE_Z.
	* fhandler.h (fhandler_base::mkdir): New virtual method.
	(fhandler_base::rmdir): Ditto.
	(fhandler_disk_file:mkdir): New method.
	(fhandler_disk_file:rmdir): Ditto.
	(fhandler_cygdrive::iscygdrive_root): Delete method.
	(fhandler_cygdrive::telldir): Delete declaration.
	* dir.cc (mkdir): Implement with fhandlers.
	(rmdir): Ditto.
	* fhandler.cc (fhandler_base::mkdir): New virtual method.
	(fhandler_base::rmdir): Ditto.
	* fhandler_disk_file.cc: Remove all uses of fhandler_cygdrive::iscygdrive_root.
	(fhandler_disk_file::mkdir): New method.
	(fhandler_disk_file::rmdir): Ditto.
	(fhandler_cygdrive::telldir): Delete.
	* path.cc (path_conv::check): For virtual devices, do not set PATH_RO and
	do not set error in case of non-existence.
--=====================_1116433323==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="netdrive.diff"
Content-length: 15131

Index: devices.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/devices.h,v
retrieving revision 1.18
diff -u -p -r1.18 devices.h
--- devices.h	10 May 2005 20:56:06 -0000	1.18
+++ devices.h	18 May 2005 04:22:41 -0000
@@ -106,8 +106,6 @@ enum fh_devices

   DEV_CYGDRIVE_MAJOR =3D 98,
   FH_CYGDRIVE=3D FHDEV (DEV_CYGDRIVE_MAJOR, 0),
-  FH_CYGDRIVE_A=3D FHDEV (DEV_CYGDRIVE_MAJOR, 'a'),
-  FH_CYGDRIVE_Z=3D FHDEV (DEV_CYGDRIVE_MAJOR, 'z'),

   DEV_TCP_MAJOR =3D 30,
   FH_TCP =3D FHDEV (DEV_TCP_MAJOR, 36),
Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.247
diff -u -p -r1.247 fhandler.h
--- fhandler.h	17 May 2005 20:34:15 -0000	1.247
+++ fhandler.h	18 May 2005 04:22:42 -0000
@@ -346,6 +346,8 @@ class fhandler_base
   void operator delete (void *);
   virtual HANDLE get_guard () const {return NULL;}
   virtual void set_eof () {}
+  virtual int mkdir (mode_t mode);
+  virtual int rmdir ();
   virtual DIR *opendir ();
   virtual dirent *readdir (DIR *);
   virtual _off64_t telldir (DIR *);
@@ -664,6 +666,8 @@ class fhandler_disk_file: public fhandle
   int msync (HANDLE h, caddr_t addr, size_t len, int flags);
   bool fixup_mmap_after_fork (HANDLE h, DWORD access, int flags,
 			      _off64_t offset, DWORD size, void *address);
+  int mkdir (mode_t mode);
+  int rmdir ();
   DIR *opendir ();
   struct dirent *readdir (DIR *);
   _off64_t telldir (DIR *);
@@ -678,11 +682,9 @@ class fhandler_cygdrive: public fhandler
   const char *pdrive;
   void set_drives ();
  public:
-  bool iscygdrive_root () { return !dev ().minor; }
   fhandler_cygdrive ();
   DIR *opendir ();
   struct dirent *readdir (DIR *);
-  _off64_t telldir (DIR *);
   void seekdir (DIR *, _off64_t);
   void rewinddir (DIR *);
   int closedir (DIR *);
Index: dir.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.86
diff -u -p -r1.86 dir.cc
--- dir.cc	13 May 2005 15:46:05 -0000	1.86
+++ dir.cc	18 May 2005 04:22:42 -0000
@@ -221,39 +221,21 @@ extern "C" int
 mkdir (const char *dir, mode_t mode)
 {
   int res =3D -1;
-  SECURITY_ATTRIBUTES sa =3D sec_none_nih;
-  security_descriptor sd;
+  fhandler_base *fh =3D NULL;

-  path_conv real_dir (dir, PC_SYM_NOFOLLOW | PC_WRITABLE);
+  if (!(fh =3D build_fh_name (dir, NULL, PC_SYM_NOFOLLOW | PC_WRITABLE)))
+    goto done;   /* errno already set */;

-  if (real_dir.error)
+  if (fh->error ())
     {
-      set_errno (real_dir.case_clash ? ECASECLASH : real_dir.error);
-      goto done;
+      debug_printf ("got %d error from build_fh_name", fh->error ());
+      set_errno (fh->error ());
     }
+  else if (!fh->mkdir (mode))
+    res =3D 0;
+  delete fh;

-  nofinalslash (real_dir.get_win32 (), real_dir.get_win32 ());
-
-  if (allow_ntsec && real_dir.has_acls ())
-    set_security_attribute (S_IFDIR | ((mode & 07777) & ~cygheap->umask),
-			    &sa, sd);
-
-  if (CreateDirectoryA (real_dir.get_win32 (), &sa))
-    {
-      if (!allow_ntsec && allow_ntea)
-	set_file_attribute (false, NULL, real_dir.get_win32 (),
-			    S_IFDIR | ((mode & 07777) & ~cygheap->umask));
-#ifdef HIDDEN_DOT_FILES
-      char *c =3D strrchr (real_dir.get_win32 (), '\\');
-      if ((c && c[1] =3D=3D '.') || *real_dir.get_win32 () =3D=3D '.')
-	SetFileAttributes (real_dir.get_win32 (), FILE_ATTRIBUTE_HIDDEN);
-#endif
-      res =3D 0;
-    }
-  else
-    __seterrno ();
-
-done:
+ done:
   syscall_printf ("%d =3D mkdir (%s, %d)", res, dir, mode);
   return res;
 }
@@ -263,80 +245,21 @@ extern "C" int
 rmdir (const char *dir)
 {
   int res =3D -1;
+  fhandler_base *fh =3D NULL;

-  path_conv real_dir (dir, PC_SYM_NOFOLLOW | PC_WRITABLE);
+  if (!(fh =3D build_fh_name (dir, NULL, PC_SYM_NOFOLLOW | PC_WRITABLE)))
+    goto done;   /* errno already set */;

-  if (real_dir.error)
-    set_errno (real_dir.error);
-  else if (!real_dir.exists ())
-    set_errno (ENOENT);
-  else if  (!real_dir.isdir ())
-    set_errno (ENOTDIR);
-  else
+  if (fh->error ())
     {
-      /* Even own directories can't be removed if R/O attribute is set. */
-      if (real_dir.has_attribute (FILE_ATTRIBUTE_READONLY))
-	SetFileAttributes (real_dir,
-			   (DWORD) real_dir & ~FILE_ATTRIBUTE_READONLY);
-
-      for (bool is_cwd =3D false; ; is_cwd =3D true)
-	{
-	  DWORD err;
-	  int rc =3D RemoveDirectory (real_dir);
-	  DWORD att =3D GetFileAttributes (real_dir);
-
-	  /* Sometimes smb indicates failure when it really succeeds, so check for
-	     this case specifically. */
-	  if (rc || att =3D=3D INVALID_FILE_ATTRIBUTES)
-	    {
-	      /* RemoveDirectory on a samba drive doesn't return an error if the
-		 directory can't be removed because it's not empty. Checking for
-		 existence afterwards keeps us informed about success. */
-	      if (att =3D=3D INVALID_FILE_ATTRIBUTES)
-		{
-		  res =3D 0;
-		  break;
-		}
-	      err =3D ERROR_DIR_NOT_EMPTY;
-	    }
-	  else
-	    err =3D GetLastError ();
-
-	  /* This kludge detects if we are attempting to remove the current worki=
ng
-	     directory.  If so, we will move elsewhere to potentially allow the
-	     rmdir to succeed.  This means that cygwin's concept of the current w=
orking
-	     directory !=3D Windows concept but, hey, whaddaregonnado?
-	     Note that this will not cause something like the following to work:
-		     $ cd foo
-		     $ rmdir .
-	     since the shell will have foo "open" in the above case and so Window=
s will
-	     not allow the deletion. (Actually it does on 9X.)
-	     FIXME: A potential workaround for this is for cygwin apps to *never*=
 call
-	     SetCurrentDirectory. */
-
-	  if (strcasematch (real_dir, cygheap->cwd.win32)
-	      && !strcasematch ("c:\\", cygheap->cwd.win32)
-	      && !is_cwd
-	      && SetCurrentDirectory ("c:\\"))
-	    continue;
-
-	  /* On 9X ERROR_ACCESS_DENIED is returned
-	     if you try to remove a non-empty directory. */
-	  if (err =3D=3D ERROR_ACCESS_DENIED
-	      && wincap.access_denied_on_delete ())
-	    err =3D ERROR_DIR_NOT_EMPTY;
-
-	  __seterrno_from_win_error (err);
-
-	  /* Directory still exists, restore its characteristics. */
-	  if (real_dir.has_attribute (FILE_ATTRIBUTE_READONLY))
-	    SetFileAttributes (real_dir, real_dir);
-	  if (is_cwd)
-	    SetCurrentDirectory (real_dir);
-	  break;
-	}
+      debug_printf ("got %d error from build_fh_name", fh->error ());
+      set_errno (fh->error ());
     }
+  else if (!fh->rmdir ())
+    res =3D 0;
+  delete fh;

+ done:
   syscall_printf ("%d =3D rmdir (%s)", res, dir);
   return res;
 }
Index: fhandler.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.233
diff -u -p -r1.233 fhandler.cc
--- fhandler.cc	28 Apr 2005 03:41:09 -0000	1.233
+++ fhandler.cc	18 May 2005 04:22:42 -0000
@@ -1509,6 +1509,28 @@ fhandler_base::set_nonblocking (int yes)
   openflags =3D (openflags & ~O_NONBLOCK_MASK) | new_flags;
 }

+int
+fhandler_base::mkdir (mode_t)
+{
+  if (exists ())
+    set_errno (EEXIST);
+  else
+    set_errno (EROFS);
+  return -1;
+}
+
+int
+fhandler_base::rmdir ()
+{
+  if (!exists ())
+    set_errno (ENOENT);
+  else if (!pc.isdir ())
+    set_errno (ENOTDIR);
+  else
+    set_errno (EROFS);
+  return -1;
+}
+
 DIR *
 fhandler_base::opendir ()
 {
Index: fhandler_disk_file.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.125
diff -u -p -r1.125 fhandler_disk_file.cc
--- fhandler_disk_file.cc	14 May 2005 21:12:10 -0000	1.125
+++ fhandler_disk_file.cc	18 May 2005 04:22:43 -0000
@@ -1138,6 +1138,114 @@ fhandler_disk_file::lock (int cmd, struc
   return 0;
 }

+int
+fhandler_disk_file::mkdir (mode_t mode)
+{
+  int res =3D -1;
+  SECURITY_ATTRIBUTES sa =3D sec_none_nih;
+  security_descriptor sd;
+
+  if (allow_ntsec && has_acls ())
+    set_security_attribute (S_IFDIR | ((mode & 07777) & ~cygheap->umask),
+			    &sa, sd);
+
+  if (CreateDirectoryA (get_win32_name (), &sa))
+    {
+      if (!allow_ntsec && allow_ntea)
+	set_file_attribute (false, NULL, get_win32_name (),
+			    S_IFDIR | ((mode & 07777) & ~cygheap->umask));
+#ifdef HIDDEN_DOT_FILES
+      char *c =3D strrchr (real_dir.get_win32 (), '\\');
+      if ((c && c[1] =3D=3D '.') || *get_win32_name () =3D=3D '.')
+	SetFileAttributes (get_win32_name (), FILE_ATTRIBUTE_HIDDEN);
+#endif
+      res =3D 0;
+    }
+  else
+    __seterrno ();
+
+  return res;
+}
+
+int
+fhandler_disk_file::rmdir ()
+{
+  int res =3D -1;
+
+  /* Even own directories can't be removed if R/O attribute is set. */
+  if (pc.has_attribute (FILE_ATTRIBUTE_READONLY))
+    SetFileAttributes (get_win32_name (),
+		       (DWORD) pc & ~FILE_ATTRIBUTE_READONLY);
+
+  for (bool is_cwd =3D false; ; is_cwd =3D true)
+    {
+      DWORD err, att =3D 0;
+      int rc =3D RemoveDirectory (get_win32_name ());
+
+      if (isremote () && exists ())
+	att =3D GetFileAttributes (get_win32_name ());
+
+      /* Sometimes smb indicates failure when it really succeeds, so check=
 for
+	 this case specifically. */
+      if (rc || att =3D=3D INVALID_FILE_ATTRIBUTES)
+	{
+	  /* RemoveDirectory on a samba drive doesn't return an error if the
+	     directory can't be removed because it's not empty. Checking for
+	     existence afterwards keeps us informed about success. */
+	  if (!isremote () || att =3D=3D INVALID_FILE_ATTRIBUTES)
+	    {
+	      res =3D 0;
+	      break;
+	    }
+	  err =3D ERROR_DIR_NOT_EMPTY;
+	}
+      else
+	err =3D GetLastError ();
+
+      /* This kludge detects if we are attempting to remove the current wo=
rking
+	 directory.  If so, we will move elsewhere to potentially allow the
+	 rmdir to succeed.  This means that cygwin's concept of the current worki=
ng
+	 directory !=3D Windows concept but, hey, whaddaregonnado?
+	 Note that this will not cause something like the following to work:
+	 $ cd foo
+	 $ rmdir .
+	 since the shell will have foo "open" in the above case and so Windows wi=
ll
+	 not allow the deletion. (Actually it does on 9X.)
+	 FIXME: A potential workaround for this is for cygwin apps to *never* call
+	 SetCurrentDirectory. */
+
+      extern char windows_system_directory[];
+      if (strcasematch (get_win32_name (), cygheap->cwd.win32)
+	  && !strcasematch (windows_system_directory, cygheap->cwd.win32)
+	  && !is_cwd
+	  && SetCurrentDirectory (windows_system_directory))
+	continue;
+
+      /* On 9X ERROR_ACCESS_DENIED is returned
+	 if you try to remove a non-empty directory. */
+      if (err =3D=3D ERROR_ACCESS_DENIED
+	  && wincap.access_denied_on_delete ())
+	err =3D ERROR_DIR_NOT_EMPTY;
+
+      __seterrno_from_win_error (err);
+
+      /* Directory still exists, restore its characteristics. */
+      if (pc.has_attribute (FILE_ATTRIBUTE_READONLY))
+	SetFileAttributes (get_win32_name (), (DWORD) pc);
+      if (is_cwd)
+	SetCurrentDirectory (get_win32_name ());
+      break;
+    }
+
+  return res;
+}
+
+_off64_t
+fhandler_disk_file::telldir (DIR *dir)
+{
+  return dir->__d_position;
+}
+
 DIR *
 fhandler_disk_file::opendir ()
 {
@@ -1268,12 +1376,6 @@ fhandler_disk_file::readdir (DIR *dir)
   return res;
 }

-_off64_t
-fhandler_disk_file::telldir (DIR *dir)
-{
-  return dir->__d_position;
-}
-
 void
 fhandler_disk_file::seekdir (DIR *dir, _off64_t loc)
 {
@@ -1326,8 +1428,6 @@ fhandler_cygdrive::set_drives ()
 int
 fhandler_cygdrive::fstat (struct __stat64 *buf)
 {
-  if (!iscygdrive_root ())
-    return fhandler_disk_file::fstat (buf);
   buf->st_mode =3D S_IFDIR | 0555;
   if (!ndrives)
     set_drives ();
@@ -1341,7 +1441,7 @@ fhandler_cygdrive::opendir ()
   DIR *dir;

   dir =3D fhandler_disk_file::opendir ();
-  if (dir && iscygdrive_root () && !ndrives)
+  if (dir && !ndrives)
     set_drives ();

   return dir;
@@ -1350,8 +1450,6 @@ fhandler_cygdrive::opendir ()
 struct dirent *
 fhandler_cygdrive::readdir (DIR *dir)
 {
-  if (!iscygdrive_root ())
-    return fhandler_disk_file::readdir (dir);
   if (!pdrive || !*pdrive)
     return NULL;
   if (GetFileAttributes (pdrive) =3D=3D INVALID_FILE_ATTRIBUTES)
@@ -1369,12 +1467,6 @@ fhandler_cygdrive::readdir (DIR *dir)
   return dir->__d_dirent;
 }

-_off64_t
-fhandler_cygdrive::telldir (DIR *dir)
-{
-  return fhandler_disk_file::telldir (dir);
-}
-
 void
 fhandler_cygdrive::seekdir (DIR *dir, _off64_t loc)
 {
@@ -1384,8 +1476,6 @@ fhandler_cygdrive::seekdir (DIR *dir, _o
 void
 fhandler_cygdrive::rewinddir (DIR *dir)
 {
-  if (!iscygdrive_root ())
-    return fhandler_disk_file::rewinddir (dir);
   pdrive =3D get_win32_name ();
   dir->__d_position =3D 0;
   return;
@@ -1394,8 +1484,6 @@ fhandler_cygdrive::rewinddir (DIR *dir)
 int
 fhandler_cygdrive::closedir (DIR *dir)
 {
-  if (!iscygdrive_root ())
-    return fhandler_disk_file::closedir (dir);
   pdrive =3D get_win32_name ();
   return 0;
 }
Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.376
diff -u -p -r1.376 path.cc
--- path.cc	17 May 2005 01:29:27 -0000	1.376
+++ path.cc	18 May 2005 04:22:45 -0000
@@ -671,7 +671,6 @@ path_conv::check (const char *src, unsig
 		      fileattr =3D INVALID_FILE_ATTRIBUTES;
 		    goto virtual_component_retry;
 		}
-	      path_flags |=3D PATH_RO;
 	      goto out;
 	    }
 	  /* devn should not be a device.  If it is, then stop parsing now. */
@@ -877,21 +876,16 @@ virtual_component_retry:

 out:
   bool strip_tail =3D false;
-  /* If the user wants a directory, do not return a symlink */
   if ((opt & PC_WRITABLE) && (path_flags & PATH_RO))
     {
       debug_printf ("%s is on a read-only filesystem", path);
       error =3D EROFS;
       return;
     }
-  else if (isvirtual_dev (dev.devn) && fileattr =3D=3D INVALID_FILE_ATTRIB=
UTES)
-    {
-      error =3D dev.devn =3D=3D FH_NETDRIVE ? ENOSHARE : ENOENT;
-      return;
-    }
   else if (!need_directory || error)
     /* nothing to do */;
   else if (fileattr & FILE_ATTRIBUTE_DIRECTORY)
+    /* If the user wants a directory, do not return a symlink */
     path_flags &=3D ~PATH_SYMLINK;
   else
     {

--=====================_1116433323==_--
