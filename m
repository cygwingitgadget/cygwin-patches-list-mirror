Return-Path: <cygwin-patches-return-4183-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29725 invoked by alias); 9 Sep 2003 00:47:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29701 invoked from network); 9 Sep 2003 00:47:20 -0000
Message-Id: <3.0.5.32.20030908204606.00816d10@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 09 Sep 2003 00:47:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Fixing a security hole in mount table.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1063082766==_"
X-SW-Source: 2003-q3/txt/msg00199.txt.bz2

--=====================_1063082766==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 4260

This is the first in a series of patches fixing security holes
associated with the file mappings in the core of Cygwin.
I hope the explanations below are clear!
 
Background on the mount table:

  System and user mounts are kept in a FileMapping, shared by all programs
  started from Windows by a given user, and their descendants, even after
seteuid.
 
  User mounts are stored permanently under the HKCU registry.
  The user pointed to by HKCU depends on the user SID in the current
  thread access token. It changes during the seteuid call.

  So a seteuid'ed user creating a user mount will make an entry in the
  mount file mapping of its ancestor, and will also store it in its own
  user registry. That makes for a weird combination.
  For consistency the mount file mapping should be recreated following
seteuid.
  The file mapping should be named after the SID (on NT), not the user
name, to
  avoid name aliasing.
  To make sure HKCU is meaningful loaded, load_registry_hive should be
called in 
  seteuid, calling it in spawn is too late.

  The current code also creates a security gap that is easy to exploit: 
  Telnet in as a non-privileged user. 
  Create a $HOME/etc directory and cp -R /etc to it, give 777 access.
  Edit $HOME/etc/passwd and remove all the passwords.
  mount -u `cygpath -m "$HOME/etc"` /etc
  Bingo, all the programs running as SYSTEM will now switch to the new
  mapping for /etc. One can telnet in as any user without a password.
  (FWIW, here are two extra observations:
   - programs running as SYSTEM cannot umount -u /etc [because it's 
   not under their HKCU], but they can mount -f -u over it.
   - programs running as SYSTEM use the user mounts of the .Default user,
   at least on NT4.)

  This simple attack would not work with the change described above, but
  the SYSTEM file mapping could still be manipulated by writing a program
  that directly accesses it.
  The solution is to specify appropriate security attributes when creating 
  the file mapping. Using sec_none is fine, don't worry about the name.

When initially testing the patch I found that the user mounts
were set correctly from sshd but not from telnetd (with or without passwd).
Telnetd (login) was producing the following error when reading HKCU:

255 1183303 [main] a 266 mount_table_initialize: initializing mount table
432 1183735 [main] a 266 reg_key::build_reg: failed to create key SOFTWARE
in the registry
422 1184157 [main] a 266 reg_key::build_reg: failed to create key SOFTWARE
in the registry
772 1184929 [main] a 266 mount_info::read_mounts: RegEnumKeyEx failed,
error 6!
778 1185707 [main] a 266 mount_info::add_item: e:\[e:], /[/], 0xA   <= XXX
system mounts OK

reg_key::build_reg does not print %E, but gdb reveals it is 5.

I then found out that HKCU can behave weirdly 
<http://support.microsoft.com/default.aspx?scid=kb;en-us;199190>
and implemented the short term workaround outlined therein.
According to MS we should not use HKCU if several thread access it.

The attached patch is the minimum that fixes the problem.
A follow up patch, touching more files, will cleanup some details.
Including it at this stage would be needlessly confusing.

In summary this patch:
1) moves load_registry_hive from spawn_guts() to seteuid().
2) moves all the mount table initialization from memory_init
   into a new function, user_shared_initialize [this choice of
   name will become clear later], which is then called from
   both memory_init and seteuid.
3) Adds an optional security attributes argument to open_shared.
4) fixes an unrelated (and currently non exposed) bug in 
   security.h (sec_user).

Pierre

2003-09-08  Pierre Humblet <pierre.humblet@ieee.org>

	* shared_info.h: Include security.h.
	(open_shared): Add psa argument.
	(user_shared_initialize): New declaration.
	* security.h: Add _SECURITY_H guard.
	(sec_user): Use sec_none in the no ntsec case.
	* spawn.cc (spawn_guts): Remove call to load_registry_hive.
	* syscalls (seteuid32): If warranted, call load_registry_hive,  
	user_shared_initialize and RegCloseKey(HKEY_CURRENT_USER).
	* shared.cc (user_shared_initialize): New.
	(open_shared): Add and use psa argument.
	(memory_init): Move mount table initialization to 
	user_shared_initialize. Call it.
--=====================_1063082766==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shared.diff"
Content-length: 9197

Index: shared_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
retrieving revision 1.30
diff -u -p -r1.30 shared_info.h
--- shared_info.h	3 Sep 2003 14:15:55 -0000	1.30
+++ shared_info.h	9 Sep 2003 00:38:28 -0000
@@ -9,6 +9,7 @@ Cygwin license.  Please consult the file
 details. */

 #include "tty.h"
+#include "security.h"

 /* Mount table entry */

@@ -189,4 +190,7 @@ struct console_state
 #endif

 char *__stdcall shared_name (char *, const char *, int);
-void *__stdcall open_shared (const char *name, int n, HANDLE &shared_h, DW=
ORD size, shared_locations);
+void *__stdcall open_shared (const char *name, int n, HANDLE &shared_h, DW=
ORD size,
+			     shared_locations, PSECURITY_ATTRIBUTES psa =3D &sec_all);
+extern void user_shared_initialize ();
+
Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.43
diff -u -p -r1.43 security.h
--- security.h	2 Jul 2003 03:16:00 -0000	1.43
+++ security.h	9 Sep 2003 00:38:28 -0000
@@ -8,6 +8,9 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */

+#ifndef _SECURITY_H
+#define _SECURITY_H
+
 #include <accctrl.h>

 #define DEFAULT_UID DOMAIN_USER_RID_ADMIN
@@ -271,5 +274,6 @@ sec_user_nih (char sa_buf[], PSID sid =3D
 extern inline SECURITY_ATTRIBUTES *
 sec_user (char sa_buf[], PSID sid =3D NULL)
 {
-  return allow_ntsec ? __sec_user (sa_buf, sid, TRUE) : &sec_none_nih;
+  return allow_ntsec ? __sec_user (sa_buf, sid, TRUE) : &sec_none;
 }
+#endif /*_SECURITY_H*/
Index: spawn.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.125
diff -u -p -r1.125 spawn.cc
--- spawn.cc	30 Jun 2003 13:07:36 -0000	1.125
+++ spawn.cc	9 Sep 2003 00:38:30 -0000
@@ -654,9 +654,6 @@ spawn_guts (const char * prog_arg, const
       /* Set security attributes with sid */
       PSECURITY_ATTRIBUTES sec_attribs =3D sec_user_nih (sa_buf, sid);

-      /* Load users registry hive. */
-      load_registry_hive (sid);
-
       /* allow the child to interact with our window station/desktop */
       HANDLE hwst, hdsk;
       SECURITY_INFORMATION dsi =3D DACL_SECURITY_INFORMATION;
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.283
diff -u -p -r1.283 syscalls.cc
--- syscalls.cc	8 Sep 2003 20:08:52 -0000	1.283
+++ syscalls.cc	9 Sep 2003 00:38:34 -0000
@@ -2076,9 +2076,9 @@ seteuid32 (__uid32_t uid)
   user_groups &groups =3D cygheap->user.groups;
   HANDLE ptok, new_token =3D INVALID_HANDLE_VALUE;
   struct passwd * pw_new;
-  PSID origpsid, psid2 =3D NO_SID;
-  BOOL token_is_internal;
-
+  cygpsid origpsid, psid2 (NO_SID);
+  BOOL token_is_internal, issamesid;
+
   pw_new =3D internal_getpwuid (uid);
   if (!wincap.has_security () && pw_new)
     goto success_9x;
@@ -2154,6 +2154,9 @@ seteuid32 (__uid32_t uid)
     }
   else if (new_token !=3D ptok)
     {
+      /* Avoid having HKCU use default user */
+      load_registry_hive (usersid);
+
       /* Try setting owner to same value as user. */
       if (!SetTokenInformation (new_token, TokenOwner,
 				&usersid, sizeof usersid))
@@ -2168,10 +2171,16 @@ seteuid32 (__uid32_t uid)
     }

   CloseHandle (ptok);
+  issamesid =3D (usersid =3D=3D (psid2 =3D cygheap->user.sid ()));
   cygheap->user.set_sid (usersid);
   cygheap->user.current_token =3D new_token =3D=3D ptok ? INVALID_HANDLE_V=
ALUE
-						  : new_token;
+                                                  : new_token;
+  if (!issamesid) /* MS KB 199190 */
+    RegCloseKey(HKEY_CURRENT_USER);
   cygheap->user.reimpersonate ();
+  if (!issamesid)
+    user_shared_initialize ();
+
 success_9x:
   cygheap->user.set_name (pw_new->pw_name);
   myself->uid =3D uid;
Index: shared.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.70
diff -u -p -r1.70 shared.cc
--- shared.cc	3 Sep 2003 14:15:55 -0000	1.70
+++ shared.cc	9 Sep 2003 00:38:35 -0000
@@ -67,7 +67,8 @@ static char *offsets[] =3D
 };

 void * __stdcall
-open_shared (const char *name, int n, HANDLE &shared_h, DWORD size, shared=
_locations m)
+open_shared (const char *name, int n, HANDLE &shared_h, DWORD size,
+	     shared_locations m, PSECURITY_ATTRIBUTES psa)
 {
   void *shared;

@@ -96,7 +97,7 @@ open_shared (const char *name, int n, HA
 				       TRUE, mapname);
 	}
       if (!shared_h &&
-	  !(shared_h =3D CreateFileMapping (INVALID_HANDLE_VALUE, &sec_all,
+	  !(shared_h =3D CreateFileMapping (INVALID_HANDLE_VALUE, psa,
 					  PAGE_READWRITE, 0, size, mapname)))
 	api_fatal ("CreateFileMapping, %E.  Terminating.");
     }
@@ -144,6 +145,71 @@ open_shared (const char *name, int n, HA
   return shared;
 }

+void
+user_shared_initialize ()
+{
+  char name[UNLEN + 1] =3D "";
+
+  /* Temporary code. Will be cleaned up later */
+  if (wincap.has_security ())
+    {
+      HANDLE ptok =3D NULL;
+      DWORD siz;
+      cygsid tu;
+
+      if (cygwin_mount_h) /* Reinit */
+	tu =3D cygheap->user.sid ();
+      else
+        {
+	  if (!OpenProcessToken (hMainProc, TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
+				 &ptok))
+	    system_printf ("OpenProcessToken(): %E");
+	  else if (!GetTokenInformation (ptok, TokenUser, &tu, sizeof tu, &siz))
+	    system_printf ("GetTokenInformation (TokenUser): %E");
+	  else
+	    tu.string (name);
+	  if (ptok)
+	    CloseHandle (ptok);
+	}
+      tu.string (name);
+    }
+  else
+    strcpy (name, cygheap->user.name ());
+
+  if (cygwin_mount_h)
+    {
+      if (!UnmapViewOfFile (mount_table))
+	debug_printf("UnmapViewOfFile %E");
+      if (!ForceCloseHandle (cygwin_mount_h))
+	debug_printf("CloseHandle %E");
+      cygwin_mount_h =3D NULL;
+    }
+
+  mount_table =3D (mount_info *) open_shared (name, MOUNT_VERSION,
+					    cygwin_mount_h, sizeof (mount_info),
+					    SH_MOUNT_TABLE, &sec_none);
+  debug_printf ("opening mount table for '%s' at %p", name,
+		mount_table);
+  ProtectHandleINH (cygwin_mount_h);
+  debug_printf ("mount table version %x at %p", mount_table->version, moun=
t_table);
+
+  /* Initialize the Cygwin per-user mount table, if necessary */
+  if (!mount_table->version)
+    {
+      mount_table->version =3D MOUNT_VERSION_MAGIC;
+      debug_printf ("initializing mount table");
+      mount_table->cb =3D sizeof (*mount_table);
+      if (mount_table->cb !=3D MOUNT_INFO_CB)
+	system_printf ("size of mount table region changed from %u to %u",
+		       MOUNT_INFO_CB, mount_table->cb);
+      mount_table->init ();	/* Initialize the mount table.  */
+    }
+  else if (mount_table->version !=3D MOUNT_VERSION_MAGIC)
+    multiple_cygwin_problem ("mount", mount_table->version, MOUNT_VERSION);
+  else if (mount_table->cb !=3D  MOUNT_INFO_CB)
+    multiple_cygwin_problem ("mount table size", mount_table->cb, MOUNT_IN=
FO_CB);
+}
+
 void
 shared_info::initialize (const char *user_name)
 {
@@ -208,31 +274,7 @@ memory_init ()
   cygheap->shared_h =3D shared_h;
   ProtectHandleINH (cygheap->shared_h);

-  /* Allocate memory for the per-user mount table */
-  mount_table =3D (mount_info *) open_shared (user_name, MOUNT_VERSION,
-					    cygwin_mount_h, sizeof (mount_info),
-					    SH_MOUNT_TABLE);
-  debug_printf ("opening mount table for '%s' at %p", cygheap->user.name (=
),
-		mount_table);
-  ProtectHandleINH (cygwin_mount_h);
-  debug_printf ("mount table version %x at %p", mount_table->version, moun=
t_table);
-
-  /* Initialize the Cygwin per-user mount table, if necessary */
-  if (!mount_table->version)
-    {
-      mount_table->version =3D MOUNT_VERSION_MAGIC;
-      debug_printf ("initializing mount table");
-      mount_table->cb =3D sizeof (*mount_table);
-      if (mount_table->cb !=3D MOUNT_INFO_CB)
-	system_printf ("size of mount table region changed from %u to %u",
-		       MOUNT_INFO_CB, mount_table->cb);
-      mount_table->init ();	/* Initialize the mount table.  */
-    }
-  else if (mount_table->version !=3D MOUNT_VERSION_MAGIC)
-    multiple_cygwin_problem ("mount", mount_table->version, MOUNT_VERSION);
-  else if (mount_table->cb !=3D  MOUNT_INFO_CB)
-    multiple_cygwin_problem ("mount table size", mount_table->cb, MOUNT_IN=
FO_CB);
-
+  user_shared_initialize ();
 }

 unsigned

--=====================_1063082766==_--
