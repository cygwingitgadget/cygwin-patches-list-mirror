Return-Path: <cygwin-patches-return-4561-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28814 invoked by alias); 6 Feb 2004 15:10:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28804 invoked from network); 6 Feb 2004 15:10:44 -0000
Message-ID: <4023AE70.9B445DFE@phumblet.no-ip.org>
Date: Fri, 06 Feb 2004 15:10:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: [Patch]: sys_mount_table_counters
References: <3.0.5.32.20040204221719.007ce3f0@incoming.verizon.net> <20040205103858.GB9090@cygbert.vinschen.de> <402268A4.243CE18E@phumblet.no-ip.org> <20040206103727.GP26148@cygbert.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------2226A56ABA3EA6AD28BCF65C"
X-SW-Source: 2004-q1/txt/msg00051.txt.bz2

This is a multi-part message in MIME format.
--------------2226A56ABA3EA6AD28BCF65C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1046

This patch implements a more secure method to signal that
the system mounts have changed. Instead of writing to the
cygwin shared, a flag is set directly in the mount tables
of the active users (which requires the previous patch).
It eliminates a source of DOS attack and takes a step toward
the demise of the cygwin shared.

Pierre

2004-02-06  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (mount_info::conv_to_win32_path): Use
	sys_mount_table_update instead of the sys_mount_table_counters.
	(mount_info::send_update_sys_mounts): New.
	(mount_info::add_reg_mount): Call send_update_sys_mounts 
	instead of updating the sys_mount_table_counters.
	(mount_info::del_reg_mount): Ditto.
	(mount_info::write_cygdrive_info_to_registry): Ditto.
	(mount_info::remove_cygdrive_info_from_registry): Ditto.
	* shared_info.h (class_mountinfo::sys_mount_table_counter): Delete.
	(class_mountinfo::sys_mount_table_update): New member.
	(class_mountinfo::send_update_sys_mounts): New declaration.
	(class_mountinfo::got_update_sys_mounts): New method.
--------------2226A56ABA3EA6AD28BCF65C
Content-Type: text/plain; charset=us-ascii;
 name="mounttable.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mounttable.diff"
Content-length: 5624

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.286
diff -u -p -r1.286 path.cc
--- path.cc	26 Dec 2003 18:26:17 -0000	1.286
+++ path.cc	6 Feb 2004 01:42:08 -0000
@@ -74,6 +74,7 @@ details. */
 #include "registry.h"
 #include "cygtls.h"
 #include <assert.h>
+#include "pwdgrp.h"
 
 static int normalize_win32_path (const char *src, char *dst);
 static void slashify (const char *src, char *dst, int trailing_slash_p);
@@ -1321,10 +1322,10 @@ mount_info::conv_to_win32_path (const ch
 				unsigned *flags, bool no_normalize)
 {
   bool chroot_ok = !cygheap->root.exists ();
-  while (sys_mount_table_counter < cygwin_shared->sys_mount_table_counter)
+  while (sys_mount_table_update)
     {
+      sys_mount_table_update = false;
       init ();
-      sys_mount_table_counter++;
     }
   int src_path_len = strlen (src_path);
   MALLOC_CHECK;
@@ -1763,6 +1764,47 @@ mount_info::from_registry ()
   read_mounts (r1);
 }
 
+void
+mount_info::send_update_sys_mounts (unsigned int flags)
+{
+  if (!(flags & MOUNT_SYSTEM) || !wincap.has_security ())
+    return;
+
+  char map_buf[CYG_MAX_PATH], sid_string[128];
+  user_info * uid_info;
+  winpids pids;
+  cygsid sid;
+  HANDLE h;
+
+  for (unsigned i = 0; i < pids.npids; i++)
+    {
+      if (pids[i]->uid == myself->uid)
+	goto next;
+      for (unsigned j = 0; j < i; j++)
+	if (pids[i]->uid == pids[j]->uid)
+	  goto next;
+      sid.getfrompw (internal_getpwuid (pids[i]->uid));
+      if (!(sid.string (sid_string)))
+	goto next;
+      
+      if ((h = OpenFileMapping (FILE_MAP_READ|FILE_MAP_WRITE, FALSE,
+				shared_name (map_buf, sid_string, USER_VERSION)))
+	  && (uid_info = (user_info *) MapViewOfFileEx (h, 
+							FILE_MAP_READ|FILE_MAP_WRITE,
+							0, 0, 0, 0))) 
+	{
+	  debug_printf("Telling %u", pids[i]->uid);
+	  uid_info->mountinfo.got_update_sys_mounts ();
+	  UnmapViewOfFile (uid_info);
+	}
+      else
+	debug_printf("Open file mapping uid %u: %E", pids[i]->uid);
+      if (h)
+	CloseHandle (h);
+    next: ;
+    }
+}
+
 /* add_reg_mount: Add mount item to registry.  Return zero on success,
    non-zero on failure. */
 /* FIXME: Need a mutex to avoid collisions with other tasks. */
@@ -1820,11 +1862,9 @@ mount_info::add_reg_mount (const char *n
       if (res != ERROR_SUCCESS)
 	goto err;
       res = subkey.set_int ("flags", mountflags);
-
-      sys_mount_table_counter++;
-      cygwin_shared->sys_mount_table_counter++;
     }
 
+  send_update_sys_mounts (mountflags);
   return 0; /* Success */
  err:
   __seterrno_from_win_error (res);
@@ -1849,8 +1889,6 @@ mount_info::del_reg_mount (const char * 
     }
   else					/* Delete from system registry */
     {
-      sys_mount_table_counter++;
-      cygwin_shared->sys_mount_table_counter++;
       reg_key reg_sys (HKEY_LOCAL_MACHINE, KEY_ALL_ACCESS, "SOFTWARE",
 		       CYGWIN_INFO_CYGNUS_REGISTRY_NAME, CYGWIN_REGNAME,
 		       CYGWIN_INFO_CYGWIN_MOUNT_REGISTRY_NAME,
@@ -1864,6 +1902,7 @@ mount_info::del_reg_mount (const char * 
       return -1;
     }
 
+  send_update_sys_mounts (flags);
   return 0; /* Success */
 }
 
@@ -1914,12 +1953,6 @@ mount_info::write_cygdrive_info_to_regis
   /* Determine whether to modify user or system cygdrive path prefix. */
   HKEY top = (flags & MOUNT_SYSTEM) ? HKEY_LOCAL_MACHINE : HKEY_CURRENT_USER;
 
-  if (flags & MOUNT_SYSTEM)
-    {
-      sys_mount_table_counter++;
-      cygwin_shared->sys_mount_table_counter++;
-    }
-
   /* reg_key for user path prefix in HKEY_CURRENT_USER or system path prefix in
      HKEY_LOCAL_MACHINE.  */
   reg_key r (top, KEY_ALL_ACCESS, "SOFTWARE",
@@ -1961,6 +1994,7 @@ mount_info::write_cygdrive_info_to_regis
       mount_table->cygdrive_len = strlen (mount_table->cygdrive);
     }
 
+  send_update_sys_mounts (flags);
   return 0;
 }
 
@@ -1970,12 +2004,6 @@ mount_info::remove_cygdrive_info_from_re
   /* Determine whether to modify user or system cygdrive path prefix. */
   HKEY top = (flags & MOUNT_SYSTEM) ? HKEY_LOCAL_MACHINE : HKEY_CURRENT_USER;
 
-  if (flags & MOUNT_SYSTEM)
-    {
-      sys_mount_table_counter++;
-      cygwin_shared->sys_mount_table_counter++;
-    }
-
   /* reg_key for user path prefix in HKEY_CURRENT_USER or system path prefix in
      HKEY_LOCAL_MACHINE.  */
   reg_key r (top, KEY_ALL_ACCESS, "SOFTWARE",
@@ -1991,6 +2019,7 @@ mount_info::remove_cygdrive_info_from_re
      registry. */
   read_cygdrive_info_from_registry ();
 
+  send_update_sys_mounts (flags);
   return (res != ERROR_SUCCESS) ? res : res2;
 }
 
Index: shared_info.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
retrieving revision 1.38
diff -u -p -r1.38 shared_info.h
--- shared_info.h	14 Nov 2003 23:40:05 -0000	1.38
+++ shared_info.h	6 Feb 2004 01:42:08 -0000
@@ -55,7 +55,6 @@ struct device;
 class mount_info
 {
  public:
-  DWORD sys_mount_table_counter;
   int nmounts;
   mount_item mount[MAX_MOUNTS];
 
@@ -68,6 +67,7 @@ class mount_info
  private:
   int posix_sorted[MAX_MOUNTS];
   int native_sorted[MAX_MOUNTS];
+  volatile bool sys_mount_table_update;
 
  public:
   /* Increment when setting up a reg_key if mounts area had to be
@@ -94,6 +94,8 @@ class mount_info
   int remove_cygdrive_info_from_registry (const char *cygdrive_prefix, unsigned flags);
   int get_cygdrive_info (char *user, char *system, char* user_flags,
 			 char* system_flags);
+  void send_update_sys_mounts (unsigned int flags);
+  void got_update_sys_mounts () { sys_mount_table_update = true; }
 
  private:
 

--------------2226A56ABA3EA6AD28BCF65C--
