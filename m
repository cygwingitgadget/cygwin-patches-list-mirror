Return-Path: <cygwin-patches-return-4219-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9387 invoked by alias); 16 Sep 2003 01:19:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9372 invoked from network); 16 Sep 2003 01:19:40 -0000
Message-Id: <3.0.5.32.20030915211808.0081d6d0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 16 Sep 2003 01:19:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Fixing the delete queue security
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1063689488==_"
X-SW-Source: 2003-q3/txt/msg00235.txt.bz2

--=====================_1063689488==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2021

Cygwin uses a "delete queue" in a shared file mapping to hold
the names of files that could not be deleted on unlink, usually
because they were still opened. The queue is scanned by all
processes so that the files eventually get deleted after they 
are closed.

Because Everyone has write access to the file mapping, any user
can add names to the delete queue, and thus any user can trick
other processes into deleting any and all files on a PC where a cygwin 
daemon is running as SYSTEM.

The solution is simple: create per user delete queues. They are
placed in the same mapping as the mount table. So the change
is extremely straightforward. The length of the change log comes
from renaming many variable to have names reflect functions.

There will be a follow up patch with the following cleanup:
remove now unneeded fields from the mount_info and shared_info and 
run the "magic" on the new/modified structures.

Pierre


2003-09-15  Pierre Humblet <pierre.humblet@ieee.org>

	* shared_info.h (class user_info): New.
	(cygwin_user_h): New.
	(user_shared): New.
	(enum shared_locations): Replace SH_MOUNT_TABLE by SH_USER_SHARED;
	(mount_table): Change from variable to macro.
	* shared.cc: Use sizeof(user_info) in "offsets".
	(user_shared_initialize): Add "reinit" argument to indicate need
	to reinitialize the mapping. Replace "mount_table" by "user_shared"
	throughout. Call user_shared->mountinfo.init and 
	user_shared->delqueue.init.
	(shared_info::initialize): Do not call delqueue.init.
	(memory_init): Add argument to user_shared_initialize.
	* child_info.h (child_info::mount_h): Delete. 
	(child_info::user_h): New.	
	* sigpproc.cc (init_child_info): Use user_h instead of mount_h.
	* dcrt0.cc (_dll_crt0): Ditto.
	* fhandler_disk_file.cc (fhandler_disk_file::close): Use 
	user_shared->delqueue instead of cygwin_shared->delqueue.
	* fhandler_virtual.cc (fhandler_virtual::close): Ditto.
	* syscalls.cc (close_all_files): Ditto.
	(unlink): Ditto.
	(seteuid32): Add argument to user_shared_initialize.

--=====================_1063689488==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="delqueue.diff"
Content-length: 11994

Index: shared_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
retrieving revision 1.32
diff -u -p -r1.32 shared_info.h
--- shared_info.h	10 Sep 2003 21:01:40 -0000	1.32
+++ shared_info.h	16 Sep 2003 01:05:06 -0000
@@ -42,10 +42,9 @@ class mount_item
    scheme should be satisfactory for a long while yet.  */
 #define MAX_MOUNTS 30

-#define MOUNT_VERSION	27	// increment when mount table changes and
-#define MOUNT_VERSION_MAGIC CYGWIN_VERSION_MAGIC (MOUNT_MAGIC, MOUNT_VERSI=
ON)
-#define CURR_MOUNT_MAGIC 0x4fe431cdU
-#define MOUNT_INFO_CB 16488
+#define USER_VERSION	1	// increment when mount table changes and
+#define USER_VERSION_MAGIC CYGWIN_VERSION_MAGIC (MOUNT_MAGIC, USER_VERSION)
+#define CURR_MOUNT_MAGIC 0x4fe431cdU    /* FIXME */

 class reg_key;

@@ -132,6 +131,14 @@ public:
   void process_queue ();
 };

+class user_info
+{
+public:
+  DWORD version;
+  DWORD cb;
+  delqueue_list delqueue;
+  mount_info mountinfo;
+};
 /******** Shared Info ********/
 /* Data accessible to all tasks */

@@ -161,13 +168,14 @@ class shared_info
 };

 extern shared_info *cygwin_shared;
-extern mount_info *mount_table;
-extern HANDLE cygwin_mount_h;
+extern user_info *user_shared;
+#define mount_table (&(user_shared->mountinfo))
+extern HANDLE cygwin_user_h;

 enum shared_locations
 {
   SH_CYGWIN_SHARED,
-  SH_MOUNT_TABLE,
+  SH_USER_SHARED,
   SH_SHARED_CONSOLE,
   SH_MYSELF,
   SH_TOTAL_SIZE
@@ -192,5 +200,5 @@ struct console_state
 char *__stdcall shared_name (char *, const char *, int);
 void *__stdcall open_shared (const char *name, int n, HANDLE &shared_h, DW=
ORD size,
 			     shared_locations, PSECURITY_ATTRIBUTES psa =3D &sec_all);
-extern void user_shared_initialize ();
+extern void user_shared_initialize (bool reinit);

Index: shared.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.73
diff -u -p -r1.73 shared.cc
--- shared.cc	11 Sep 2003 07:57:39 -0000	1.73
+++ shared.cc	16 Sep 2003 01:05:06 -0000
@@ -28,8 +28,8 @@ details. */
 #include "child_info.h"

 shared_info NO_COPY *cygwin_shared;
-mount_info NO_COPY *mount_table;
-HANDLE NO_COPY cygwin_mount_h;
+user_info NO_COPY *user_shared;
+HANDLE NO_COPY cygwin_user_h;

 char * __stdcall
 shared_name (char *ret_buf, const char *str, int num)
@@ -54,14 +54,14 @@ static char *offsets[] =3D
     + pround (sizeof (shared_info)),
   (char *) cygwin_shared_address
     + pround (sizeof (shared_info))
-    + pround (sizeof (mount_info)),
+    + pround (sizeof (user_info)),
   (char *) cygwin_shared_address
     + pround (sizeof (shared_info))
-    + pround (sizeof (mount_info))
+    + pround (sizeof (user_info))
     + pround (sizeof (console_state)),
   (char *) cygwin_shared_address
     + pround (sizeof (shared_info))
-    + pround (sizeof (mount_info))
+    + pround (sizeof (user_info))
     + pround (sizeof (console_state))
     + pround (sizeof (_pinfo))
 };
@@ -146,50 +146,54 @@ open_shared (const char *name, int n, HA
 }

 void
-user_shared_initialize ()
+user_shared_initialize (bool reinit)
 {
-  char name[UNLEN + 1] =3D "";
+  char name[UNLEN + 1] =3D ""; /* Large enough for SID */

-  if (wincap.has_security ())
+  if (reinit)
     {
-      cygsid tu (cygheap->user.sid ());
-      tu.string (name);
+      if (!UnmapViewOfFile (user_shared))
+	debug_printf("UnmapViewOfFile %E");
+      if (!ForceCloseHandle (cygwin_user_h))
+	debug_printf("CloseHandle %E");
+      cygwin_user_h =3D NULL;
     }
-  else
-    strcpy (name, cygheap->user.name ());

-  if (cygwin_mount_h) /* Reinit */
+  if (!cygwin_user_h)
     {
-      if (!UnmapViewOfFile (mount_table))
-	debug_printf("UnmapViewOfFile %E");
-      if (!ForceCloseHandle (cygwin_mount_h))
-	debug_printf("CloseHandle %E");
-      cygwin_mount_h =3D NULL;
+      if (wincap.has_security ())
+        {
+	  cygsid tu (cygheap->user.sid ());
+	  tu.string (name);
+	}
+      else
+	strcpy (name, cygheap->user.name ());
     }

-  mount_table =3D (mount_info *) open_shared (name, MOUNT_VERSION,
-					    cygwin_mount_h, sizeof (mount_info),
-					    SH_MOUNT_TABLE, &sec_none);
-  debug_printf ("opening mount table for '%s' at %p", name,
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
+  user_shared =3D (user_info *) open_shared (name, USER_VERSION,
+					    cygwin_user_h, sizeof (user_info),
+					    SH_USER_SHARED, &sec_none);
+  debug_printf ("opening user shared for '%s' at %p", name, user_shared);
+  ProtectHandleINH (cygwin_user_h);
+  debug_printf ("user shared version %x", user_shared->version);
+
+  /* Initialize the Cygwin per-user shared, if necessary */
+  if (!user_shared->version)
+    {
+      user_shared->version =3D USER_VERSION_MAGIC;
+      debug_printf ("initializing user shared");
+      user_shared->cb =3D  sizeof (*user_shared);
+      if (user_shared->cb !=3D sizeof (*user_shared))
+	system_printf ("size of user shared region changed from %u to %u",
+		       sizeof (*user_shared), user_shared->cb);
+      user_shared->mountinfo.init ();	/* Initialize the mount table.  */
+      /* Initialize the queue of deleted files.  */
+      user_shared->delqueue.init ();
+    }
+  else if (user_shared->version !=3D USER_VERSION_MAGIC)
+    multiple_cygwin_problem ("user", user_shared->version, USER_VERSION_MA=
GIC);
+  else if (user_shared->cb !=3D sizeof (*user_shared))
+    multiple_cygwin_problem ("user shared size", user_shared->cb, sizeof (=
*user_shared));
 }

 void
@@ -198,9 +202,6 @@ shared_info::initialize ()
   DWORD sversion =3D (DWORD) InterlockedExchange ((LONG *) &version, SHARE=
D_VERSION_MAGIC);
   if (!sversion)
     {
-      /* Initialize the queue of deleted files.  */
-      delqueue.init ();
-
       /* Initialize tty table.  */
       tty.init ();
     }
@@ -249,7 +250,7 @@ memory_init ()
   cygheap->shared_h =3D shared_h;
   ProtectHandleINH (cygheap->shared_h);

-  user_shared_initialize ();
+  user_shared_initialize (false);
 }

 unsigned
Index: child_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/child_info.h,v
retrieving revision 1.37
diff -u -p -r1.37 child_info.h
--- child_info.h	25 Jan 2003 10:36:46 -0000	1.37
+++ child_info.h	16 Sep 2003 01:05:06 -0000
@@ -44,7 +44,7 @@ public:
   unsigned short type;	// type of record, exec, spawn, fork
   int cygpid;		// cygwin pid of child process
   HANDLE subproc_ready;	// used for synchronization with parent
-  HANDLE mount_h;
+  HANDLE user_h;
   HANDLE parent;
   HANDLE pppid_handle;
   init_cygheap *cygheap;
Index: dcrt0.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.182
diff -u -p -r1.182 dcrt0.cc
--- dcrt0.cc	16 Sep 2003 00:45:50 -0000	1.182
+++ dcrt0.cc	16 Sep 2003 01:05:08 -0000
@@ -900,7 +900,7 @@ _dll_crt0 ()
 	      multiple_cygwin_problem ("fhandler size", child_proc_info->fhandler=
_union_cb, sizeof (fhandler_union));
 	    else
 	      {
-		cygwin_mount_h =3D child_proc_info->mount_h;
+		cygwin_user_h =3D child_proc_info->user_h;
 		mypid =3D child_proc_info->cygpid;
 		break;
 	      }
Index: sigproc.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v
retrieving revision 1.154
diff -u -p -r1.154 sigproc.cc
--- sigproc.cc	9 Sep 2003 03:11:31 -0000	1.154
+++ sigproc.cc	16 Sep 2003 01:05:11 -0000
@@ -844,7 +844,7 @@ init_child_info (DWORD chtype, child_inf
   ch->subproc_ready =3D subproc_ready;
   ch->pppid_handle =3D myself->ppid_handle;
   ch->fhandler_union_cb =3D sizeof (fhandler_union);
-  ch->mount_h =3D cygwin_mount_h;
+  ch->user_h =3D cygwin_user_h;
 }

 /* Check the state of all of our children to see if any are stopped or
Index: fhandler_disk_file.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.64
diff -u -p -r1.64 fhandler_disk_file.cc
--- fhandler_disk_file.cc	14 Sep 2003 00:07:50 -0000	1.64
+++ fhandler_disk_file.cc	16 Sep 2003 01:05:12 -0000
@@ -427,7 +427,7 @@ fhandler_disk_file::close ()
 {
   int res =3D fhandler_base::close ();
   if (!res)
-    cygwin_shared->delqueue.process_queue ();
+    user_shared->delqueue.process_queue ();
   return res;
 }

Index: fhandler_virtual.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v
retrieving revision 1.19
diff -u -p -r1.19 fhandler_virtual.cc
--- fhandler_virtual.cc	8 Sep 2003 04:04:18 -0000	1.19
+++ fhandler_virtual.cc	16 Sep 2003 01:05:12 -0000
@@ -167,7 +167,7 @@ fhandler_virtual::close ()
     free (filebuf);
   filebuf =3D NULL;
   bufalloc =3D (size_t) -1;
-  cygwin_shared->delqueue.process_queue ();
+  user_shared->delqueue.process_queue ();
   return 0;
 }

Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.289
diff -u -p -r1.289 syscalls.cc
--- syscalls.cc	16 Sep 2003 00:45:50 -0000	1.289
+++ syscalls.cc	16 Sep 2003 01:05:16 -0000
@@ -92,7 +92,7 @@ close_all_files (void)
       }

   ReleaseResourceLock (LOCK_FD_LIST, WRITE_LOCK | READ_LOCK, "close_all_fi=
les");
-  cygwin_shared->delqueue.process_queue ();
+  user_shared->delqueue.process_queue ();
 }

 int
@@ -216,7 +216,7 @@ unlink (const char *ourname)
   syscall_printf ("couldn't delete file, err %d", lasterr);

   /* Add file to the "to be deleted" queue. */
-  cygwin_shared->delqueue.queue_file (win32_name);
+  user_shared->delqueue.queue_file (win32_name);

  /* Success condition. */
  ok:
@@ -2176,7 +2176,7 @@ seteuid32 (__uid32_t uid)
     RegCloseKey(HKEY_CURRENT_USER);
   cygheap->user.reimpersonate ();
   if (!issamesid)
-    user_shared_initialize ();
+    user_shared_initialize (true);

 success_9x:
   cygheap->user.set_name (pw_new->pw_name);

--=====================_1063689488==_--
