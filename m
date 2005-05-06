Return-Path: <cygwin-patches-return-5424-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26524 invoked by alias); 6 May 2005 03:00:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25752 invoked from network); 6 May 2005 03:00:06 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.193.151)
  by sourceware.org with SMTP; 6 May 2005 03:00:06 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id IG1S7A-00012C-I8
	for cygwin-patches@cygwin.com; Thu, 05 May 2005 22:57:10 -0400
Message-Id: <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 06 May 2005 03:00:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: mkdir -p and network drives
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1115362628==_"
X-SW-Source: 2005-q2/txt/msg00020.txt.bz2

--=====================_1115362628==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1413


Here is a patch to allow mkdir -p to easily work with network
drives and to allow future enumeration of computers and of
network drives by ls -l.

It works by defining a new FH_NETDRIVE virtual handler for
names such as // and //machine.
This also makes chdir work without additional change.

The code for the new handler is currently in fhandler_virtual.cc, for
simplicity (not an expert on Makefile and fomit-frame-pointer).
It should eventually be placed in fhandler_netdrive.cc

The code should handle "//" correctly, but path.cc still transforms it
into "/", because of the bash bug.

I have directly edited devices.cc instead of using the devices.in
magic.

About implementing readdir: PTC...

Pierre


2005-05-05  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.h (class fhandler_netdrive): New class.
	* fhandler_virtual.cc (fhandler_netdrive::fhandler_netdrive): New
constructor.
	(fhandler_netdrive::exists): New method.
	(fhandler_netdrive::fstat): Ditto.
	(fhandler_netdrive::readdir): Ditto.
	(fhandler_netdrive::open): Ditto.
	(fhandler_netdrive::fill_filebuf): Ditto.
	* dtable.cc (build_fh_pc): Handle case FH_NETDRIVE.
	* path.cc (isvirtual_dev): Add FH_NETDRIVE.
	(mount_info::conv_to_win32_path): Detect netdrive device.
	* devices.h (enum fh_devices): Add FH_NETDRIVE and renumber FH_FS.
	Declare dev_netdrive_storage and define netdrive_dev.
	* devices.cc: Define dev_netdrive_storage.
--=====================_1115362628==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="netdrive.diff"
Content-length: 6598

Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.243
diff -u -p -r1.243 fhandler.h
--- fhandler.h	22 Apr 2005 17:03:37 -0000	1.243
+++ fhandler.h	6 May 2005 02:42:37 -0000
@@ -1203,6 +1203,17 @@ class fhandler_proc: public fhandler_vir
   bool fill_filebuf ();
 };

+class fhandler_netdrive: public fhandler_virtual
+{
+ public:
+  fhandler_netdrive ();
+  int exists();
+  struct dirent *readdir (DIR *);
+  int open (int flags, mode_t mode =3D 0);
+  int __stdcall fstat (struct __stat64 *buf) __attribute__ ((regparm (2)));
+  bool fill_filebuf ();
+};
+
 class fhandler_registry: public fhandler_proc
 {
  private:
Index: fhandler_virtual.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v
retrieving revision 1.33
diff -u -p -r1.33 fhandler_virtual.cc
--- fhandler_virtual.cc	16 Mar 2005 21:20:56 -0000	1.33
+++ fhandler_virtual.cc	6 May 2005 02:42:37 -0000
@@ -258,3 +258,75 @@ fhandler_virtual::facl (int cmd, int nen
     }
   return res;
 }
+
+
+/* FIXME: put in fhandler_netdrive.cc */
+
+
+/* Returns 0 if path doesn't exist, >0 if path is a directory,
+   -1 if path is a file, -2 if it's a symlink.  */
+int
+fhandler_netdrive::exists ()
+{
+  return 1;
+}
+
+fhandler_netdrive::fhandler_netdrive ():
+  fhandler_virtual ()
+{
+}
+
+int
+fhandler_netdrive::fstat (struct __stat64 *buf)
+{
+  const char *path =3D get_name ();
+  debug_printf ("fstat (%s)", path);
+
+  (void) fhandler_base::fstat (buf);
+
+  buf->st_mode =3D S_IFDIR | S_IXUSR | S_IXGRP | S_IXOTH;
+
+  return 0;
+}
+
+struct dirent *
+fhandler_netdrive::readdir (DIR * dir)
+{
+  return NULL;
+}
+
+int
+fhandler_netdrive::open (int flags, mode_t mode)
+{
+  int res =3D fhandler_virtual::open (flags, mode);
+  if (!res)
+    goto out;
+
+  nohandle (true);
+
+  if ((flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))
+    {
+      set_errno (EEXIST);
+      res =3D 0;
+      goto out;
+    }
+  else if (flags & O_WRONLY)
+    {
+      set_errno (EISDIR);
+      res =3D 0;
+      goto out;
+    }
+
+  res =3D 1;
+  set_flags ((flags & ~O_TEXT) | O_BINARY | O_DIROPEN);
+  set_open_status ();
+out:
+  syscall_printf ("%d =3D fhandler_netdrive::open (%p, %d)", res, flags, m=
ode);
+  return res;
+}
+
+bool
+fhandler_netdrive::fill_filebuf ()
+{
+  return false;
+}
Index: dtable.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.149
diff -u -p -r1.149 dtable.cc
--- dtable.cc	5 Apr 2005 04:30:58 -0000	1.149
+++ dtable.cc	6 May 2005 02:42:38 -0000
@@ -454,6 +454,9 @@ build_fh_pc (path_conv& pc)
 	  case FH_PROCESS:
 	    fh =3D cnew (fhandler_process) ();
 	    break;
+	  case FH_NETDRIVE:
+	    fh =3D cnew (fhandler_netdrive) ();
+	    break;
 	  case FH_TTY:
 	    {
 	      if (myself->ctty =3D=3D TTY_CONSOLE)
Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.367
diff -u -p -r1.367 path.cc
--- path.cc	2 May 2005 03:50:07 -0000	1.367
+++ path.cc	6 May 2005 02:42:39 -0000
@@ -154,7 +154,8 @@ struct win_shortcut_hdr
   (path_prefix_p (proc, (path), proc_len))

 #define isvirtual_dev(devn) \
-  (devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_PROC || devn =3D=3D FH_REGIST=
RY || devn =3D=3D FH_PROCESS)
+  (devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_PROC || devn =3D=3D FH_REGIST=
RY \
+   || devn =3D=3D FH_PROCESS || devn =3D=3D FH_NETDRIVE )

 /* Return non-zero if PATH1 is a prefix of PATH2.
    Both are assumed to be of the same path style and / vs \ usage.
@@ -1519,6 +1520,13 @@ mount_info::conv_to_win32_path (const ch
   /* Check if the cygdrive prefix was specified.  If so, just strip
      off the prefix and transform it into an MS-DOS path. */
   MALLOC_CHECK;
+  if (src_path[1] =3D=3D '/' && !strchr (src_path + 2, '/'))
+    {
+      dev =3D *netdrive_dev;
+      set_flags (flags, PATH_BINARY);
+      strcpy (dst, src_path);
+      goto out;
+    }
   if (isproc (src_path))
     {
       dev =3D *proc_dev;
Index: devices.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/devices.h,v
retrieving revision 1.16
diff -u -p -r1.16 devices.h
--- devices.h	23 Feb 2005 12:30:31 -0000	1.16
+++ devices.h	6 May 2005 02:42:39 -0000
@@ -46,8 +46,9 @@ enum fh_devices
   FH_PROC    =3D FHDEV (0, 250),
   FH_REGISTRY=3D FHDEV (0, 249),
   FH_PROCESS =3D FHDEV (0, 248),
+  FH_NETDRIVE=3D FHDEV (0, 247),

-  FH_FS      =3D FHDEV (0, 247),	/* filesystem based device */
+  FH_FS      =3D FHDEV (0, 246),	/* filesystem based device */

   DEV_FLOPPY_MAJOR =3D 2,
   FH_FLOPPY  =3D FHDEV (DEV_FLOPPY_MAJOR, 0),
@@ -169,6 +170,8 @@ extern const device dev_pipew_storage;
 #define pipew_dev (&dev_pipew_storage)
 extern const device dev_proc_storage;
 #define proc_dev (&dev_proc_storage)
+extern const device dev_netdrive_storage;
+#define netdrive_dev (&dev_netdrive_storage)
 extern const device dev_cygdrive_storage;
 #define cygdrive_dev (&dev_cygdrive_storage)
 extern const device dev_fh_storage;
Index: devices.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/devices.cc,v
retrieving revision 1.17
diff -u -p -r1.17 devices.cc
--- devices.cc	19 Mar 2005 21:45:14 -0000	1.17
+++ devices.cc	6 May 2005 02:42:40 -0000
@@ -25,6 +25,9 @@ const device dev_fs_storage =3D
 const device dev_proc_storage =3D
   {"", {FH_PROC}, ""};

+const device dev_netdrive_storage =3D
+  {"", {FH_NETDRIVE}, ""};
+
 const device dev_registry_storage =3D
   {"", {FH_REGISTRY}, ""};


--=====================_1115362628==_--
