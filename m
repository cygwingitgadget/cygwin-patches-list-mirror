Return-Path: <cygwin-patches-return-4685-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21278 invoked by alias); 14 Apr 2004 02:19:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21037 invoked from network); 14 Apr 2004 02:19:17 -0000
Message-Id: <3.0.5.32.20040413221632.007ff550@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 14 Apr 2004 02:19:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: st_size for symlinks
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1081923392==_"
X-SW-Source: 2004-q2/txt/msg00037.txt.bz2

--=====================_1081923392==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 416

This patch sets st_size correctly for symlinks.

Pierre

2004-04-14  Pierre Humblet <pierre.humblet@ieee.org>

	* path.h (path_conv::set_symlink): Add argument.
	(path_conv::get_symlink_length): New method. 
	(path_conv::symlink_length): New member.
	* path.cc (path_conv::check): Pass symlen to set_symlink.
	* fhandler_disk_file.cc (fhandler_base::fstat_helper): For symlinks
	set st_size from get_symlink_length.	
--=====================_1081923392==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="symlink.diff"
Content-length: 2781

Index: path.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.62
diff -u -p -r1.62 path.h
--- path.h	13 Apr 2004 09:04:22 -0000	1.62
+++ path.h	14 Apr 2004 01:09:13 -0000
@@ -162,7 +162,7 @@ class path_conv
   }

   void set_binary () {path_flags |=3D PATH_BINARY;}
-  void set_symlink () {path_flags |=3D PATH_SYMLINK;}
+  void set_symlink (DWORD n) {path_flags |=3D PATH_SYMLINK; symlink_length=
 =3D n;}
   void set_has_symlinks () {path_flags |=3D PATH_HAS_SYMLINKS;}
   void set_isdisk () {path_flags |=3D PATH_ISDISK; dev.devn =3D FH_FS;}
   void set_exec (int x =3D 1) {path_flags |=3D x ? PATH_EXEC : PATH_NOTEXE=
C;}
@@ -215,7 +215,9 @@ class path_conv
   char *normalized_path;
   size_t normalized_path_size;
   void set_normalized_path (const char *) __attribute__ ((regparm (2)));
+  DWORD get_symlink_length () { return symlink_length; };
  private:
+  DWORD symlink_length;
   char path[CYG_MAX_PATH];
 };

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.300
diff -u -p -r1.300 path.cc
--- path.cc	13 Apr 2004 20:36:58 -0000	1.300
+++ path.cc	14 Apr 2004 01:09:19 -0000
@@ -705,7 +705,7 @@ path_conv::check (const char *src, unsig
 		  saw_symlinks =3D 1;
 		  if (component =3D=3D 0 && !need_directory && !(opt & PC_SYM_FOLLOW))
 		    {
-		      set_symlink (); // last component of path is a symlink.
+		      set_symlink (symlen); // last component of path is a symlink.
 		      if (opt & PC_SYM_CONTENTS)
 			{
 			  strcpy (path, sym.contents);
Index: fhandler_disk_file.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.83
diff -u -p -r1.83 fhandler_disk_file.cc
--- fhandler_disk_file.cc	13 Apr 2004 20:36:58 -0000	1.83
+++ fhandler_disk_file.cc	14 Apr 2004 01:09:20 -0000
@@ -282,6 +282,7 @@ fhandler_base::fstat_helper (struct __st
     buf->st_mode =3D S_IFDIR;
   else if (pc.issymlink ())
     {
+      buf->st_size =3D pc.get_symlink_length ();
       /* symlinks are everything for everyone! */
       buf->st_mode =3D S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO;
       get_file_attribute (pc.has_acls (), get_io_handle (), get_win32_name=
 (),

--=====================_1081923392==_--
