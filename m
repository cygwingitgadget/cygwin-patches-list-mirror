Return-Path: <cygwin-patches-return-5987-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12079 invoked by alias); 6 Oct 2006 22:32:50 -0000
Received: (qmail 12067 invoked by uid 22791); 6 Oct 2006 22:32:49 -0000
X-Spam-Check-By: sourceware.org
Received: from jetspin.drizzle.com (HELO jetspin.drizzle.com) (216.162.192.5)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 06 Oct 2006 22:32:44 +0000
Received: from mutable2.home.mutable.net (wet193.drizzle.com [216.162.201.193]) 	by jetspin.drizzle.com (8.13.1/8.13.1) with ESMTP id k96MWcgp013633 	for <cygwin-patches@cygwin.com>; Fri, 6 Oct 2006 15:32:38 -0700
Content-class: urn:content-classes:message
Subject: Patch to enable proper handling of Win32 //?/GLOBALROOT/device paths
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Oct 2006 22:32:00 -0000
Message-ID: <5DE1FE5AC2164C4BB6BA31575FF42CDA0A4C7B@mutable2.home.mutable.net>
From: <d3@mutable.net>
To: <cygwin-patches@cygwin.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00005.txt.bz2

This patch is to enable Win32 device paths in the form of:

//?/GLOBALROOT/Device/Harddisk0/Partition1/
//?/GLOBALROOT/Device/Harddiskvolume1/
//?/GLOBALROOT/Device/HarddiskVolumeShadowCopy1/

Etc...=20

This patch to cygwin enables tools like rsync to access Win32 volume
shadow copies that can be created with Win32 tools like vshadow.exe so
that you can access open files, SQL, and Exchange databases.

A note about the change in fhandle_disk_file.cc: The patch enforces
Win32 style paths (i.e. backslashes) because the NT kernal functions do
not like mixed paths when accessing \\?\GLOBALROOT. They will only
accept backslashes.

Here is a rsync test I have been successfully using with this patch
applied:

rsync -av --modify-window=3D2
//?/globalroot/device/harddiskvolume1/testfiles/ server::test/testfiles/


2006-10-06 David Jade <d3@mutable.net>

ChangeLog for winsup/cygwin:

	* path.cc (path_conv::get_nt_native_path): update to properly
detect
	\\?\GLOBALROOT device paths

	(mount_info::conv_to_win32_path): updated	comment to
reflect
	\\?\GLOBALROOT changes

	* fhandler_disk_file.cc (path_conv::ndisk_links): updated to use
	backslashes to make NT kernel functions work for \\?\GLOBALROOT
device
	paths

=09


Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.414
diff -u -p -r1.414 path.cc
--- path.cc     2 Aug 2006 15:11:48 -0000       1.414
+++ path.cc     6 Oct 2006 21:05:56 -0000
@@ -526,13 +526,13 @@ path_conv::get_nt_native_path (UNICODE_S
     }
   else if (path[1] !=3D '\\')            /* \Device\... */
     str2uni_cat (upath, path);
-  else if (path[2] !=3D '.'
+  else if ((path[2] !=3D '.' && path[2] !=3D '?') /* not for \\.\ or \\?\
GLOBALROOT devices */
           || path[3] !=3D '\\')          /* \\server\share\... */
     {
       str2uni_cat (upath, "\\??\\UNC\\");
       str2uni_cat (upath, path + 2);
     }
-  else                                 /* \\.\device */
+  else                                 /* \\?\\ or \\.\ devices */
     {
       str2uni_cat (upath, "\\??\\");
       str2uni_cat (upath, path + 4);
@@ -1661,7 +1661,7 @@ mount_info::conv_to_win32_path (const ch
     }

   MALLOC_CHECK;
-  /* If the path is on a network drive, bypass the mount table.
+  /* If the path is on a network drive or a \\?\ GLOBALROOT device,
bypass the mount table.
      If it's // or //MACHINE, use the netdrive device. */
   if (src_path[1] =3D=3D '/')
     {



Index: fhandler_disk_file.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.190
diff -u -p -r1.190 fhandler_disk_file.cc
--- fhandler_disk_file.cc       20 Aug 2006 12:31:07 -0000      1.190
+++ fhandler_disk_file.cc       6 Oct 2006 21:05:54 -0000
@@ -143,12 +143,12 @@ path_conv::ndisk_links (DWORD nNumberOfL
   __DIR_mounts *dir =3D new __DIR_mounts (normalized_path);
   if (nNumberOfLinks <=3D 1)
     {
-      s =3D "/*";
+      s =3D "\\*";       /*  must be backslash because \\?\GLOBALROOT
doesn't like mixed slashes */
       count =3D 0;
     }
   else
     {
-      s =3D "/..";
+      s =3D "\\..";      /* must be backslash because \\?\GLOBALROOT
doesn't like mixed slashes */
       count =3D nNumberOfLinks;
     }



David Jade
