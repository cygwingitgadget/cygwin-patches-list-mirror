From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sources.redhat.com
Subject: Anyone can't read the system cygdrive prefix without the priviledge.
Date: Fri, 24 Nov 2000 09:07:00 -0000
Message-id: <s1spujls3hy.fsf@jaist.ac.jp>
X-SW-Source: 2000-q4/msg00020.html

Anyone can't read the system cygdrive prefix without the
priviledge of Administrator.

ChangeLog:
Sat Nov 25 01:57:42 2000  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* path.cc (mount_info::read_cygdrive_info_from_registry): Read system 
	cygdrive prefix with KEY_READ.
	* path.cc (mount_info::get_cygdrive_info): Ditto.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.83
diff -u -p -r1.83 path.cc
--- path.cc	2000/11/17 18:39:47	1.83
+++ path.cc	2000/11/24 16:54:07
@@ -1517,7 +1517,7 @@ mount_info::read_cygdrive_info_from_regi
       /* Didn't find the user path prefix so check the system path prefix. */
 
       /* reg_key for system path prefix in HKEY_LOCAL_MACHINE.  */
-      reg_key r2 (HKEY_LOCAL_MACHINE, KEY_ALL_ACCESS, "SOFTWARE",
+      reg_key r2 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
 		 CYGWIN_INFO_CYGNUS_REGISTRY_NAME,
 		 CYGWIN_INFO_CYGWIN_REGISTRY_NAME,
 		 CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
@@ -1647,7 +1647,7 @@ mount_info::get_cygdrive_info (char *use
     }
 
   /* Get the system path prefix from HKEY_LOCAL_MACHINE. */
-  reg_key r2 (HKEY_LOCAL_MACHINE, KEY_ALL_ACCESS, "SOFTWARE",
+  reg_key r2 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
 	      CYGWIN_INFO_CYGNUS_REGISTRY_NAME,
 	      CYGWIN_INFO_CYGWIN_REGISTRY_NAME,
 	      CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
