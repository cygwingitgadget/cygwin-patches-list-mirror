Return-Path: <cygwin-patches-return-4264-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5566 invoked by alias); 30 Sep 2003 02:08:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5555 invoked from network); 30 Sep 2003 02:08:22 -0000
Message-Id: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 30 Sep 2003 02:08:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part 1).
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1064901325==_"
X-SW-Source: 2003-q3/txt/msg00280.txt.bz2

--=====================_1064901325==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 921

Here is a patch that allows to open master ttys without giving
full access to the process, at least for access to the ctty. 

It works by snooping the ctty pipe handles and duplicating them
on the cygheap, for use by future opens in descendant processes.

It passes all the tests I tried, but considering my lack of knowledge
about ttys, everything is possible.

Pierre


2003-09-29  Pierre Humblet <pierre.humblet@ieee.org>

	* cygheap.h (class cygheap_ctty): Create.
	(struct init_cygheap): Add inherited_ctty member.
	* cygheap.cc: Include pinfo.h.
	(cygheap_ctty::acquire): Create.
	(cygheap_ctty::pass): Ditto.
	(cygheap_ctty::close): Ditto.
	* fhandler_tty.cc (fhandler_tty_slave::open): Call
	cygheap->inherited_ctty.pass and cygheap->inherited_ctty.acquire.
	* tty.cc (tty::common_init): Remove call to SetKernelObjectSecurity
	and edit some comments.
	* syscalls.cc (setsid): Call cygheap->inherited_ctty.close.

--=====================_1064901325==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="tty.diff"
Content-length: 9358

Index: cygheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.67
diff -u -p -r1.67 cygheap.h
--- cygheap.h	27 Sep 2003 01:56:36 -0000	1.67
+++ cygheap.h	30 Sep 2003 01:53:07 -0000
@@ -241,12 +241,22 @@ struct user_heap_info
   unsigned chunk;
 };

+class cygheap_ctty
+{
+  HANDLE from_master, to_master;
+public:
+  void acquire (fhandler_tty_slave &);
+  void close ();
+  bool pass (fhandler_tty_slave &);
+};
+
 struct init_cygheap
 {
   _cmalloc_entry *chain;
   char *buckets[32];
   cygheap_root root;
   cygheap_user user;
+  cygheap_ctty inherited_ctty;
   user_heap_info user_heap;
   mode_t umask;
   HANDLE shared_h;
Index: cygheap.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygheap.cc,v
retrieving revision 1.86
diff -u -p -r1.86 cygheap.cc
--- cygheap.cc	27 Sep 2003 01:56:36 -0000	1.86
+++ cygheap.cc	30 Sep 2003 01:53:08 -0000
@@ -23,6 +23,7 @@
 #include "sync.h"
 #include "shared_info.h"
 #include "sigproc.h"
+#include "pinfo.h"

 init_cygheap NO_COPY *cygheap;
 void NO_COPY *cygheap_max;
@@ -444,3 +445,76 @@ cygheap_user::set_name (const char *new_
   cfree_and_set (pwinname);
 }

+/* Snoop ctty pipe handles to inheritable handles in the cygheap */
+void
+cygheap_ctty::acquire (fhandler_tty_slave & slave)
+{
+
+  if (slave.tc->ntty !=3D myself->ctty || from_master)
+    {
+      debug_printf ("Nothing to do");
+      return;
+    }
+
+  if (!DuplicateHandle (hMainProc, slave.get_io_handle (),
+			hMainProc, &from_master, 0, TRUE,
+			DUPLICATE_SAME_ACCESS))
+    debug_printf ("can't duplicate input, %E");
+  else if (!DuplicateHandle (hMainProc, slave.get_output_handle (),
+			     hMainProc, &to_master, 0, TRUE,
+			     DUPLICATE_SAME_ACCESS))
+    {
+      CloseHandle (from_master);
+      from_master =3D NULL;
+      debug_printf ("can't duplicate output, %E");
+    }
+  else
+    {
+      debug_printf("Got them");
+      ProtectHandle1INH(from_master, cygheap_from_master);
+      ProtectHandle1INH(to_master, cygheap_to_master);
+    }
+}
+
+/* Pass duplicated ctty pipe handles to slave tty */
+bool
+cygheap_ctty::pass (fhandler_tty_slave & slave)
+{
+  if (slave.tc->ntty !=3D myself->ctty || !from_master)
+    return false;
+
+  HANDLE from_master_local =3D NULL, to_master_local =3D NULL;
+
+  if (!DuplicateHandle (hMainProc, from_master,
+			hMainProc, &from_master_local, 0, TRUE,
+			DUPLICATE_SAME_ACCESS))
+    debug_printf ("can't duplicate input, %E");
+  else if (!DuplicateHandle (hMainProc, to_master,
+			hMainProc, &to_master_local, 0, TRUE,
+			DUPLICATE_SAME_ACCESS))
+    {
+      debug_printf ("can't duplicate output, %E");
+      CloseHandle (from_master_local);
+    }
+  else
+    {
+      debug_printf("OK");
+      slave.set_io_handle (from_master_local);
+      slave.set_output_handle (to_master_local);
+      return true;
+    }
+  return false;
+}
+
+void
+cygheap_ctty::close()
+{
+  if (to_master)
+    ForceCloseHandle1 (to_master, cygheap_to_master);
+  if (from_master)
+    ForceCloseHandle1 (from_master, cygheap_from_master);
+
+  to_master =3D from_master =3D NULL;
+
+  debug_printf ("OK");
+}
Index: fhandler_tty.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.110
diff -u -p -r1.110 fhandler_tty.cc
--- fhandler_tty.cc	27 Sep 2003 03:14:07 -0000	1.110
+++ fhandler_tty.cc	30 Sep 2003 01:53:10 -0000
@@ -509,54 +509,61 @@ fhandler_tty_slave::open (int flags, mod
       return 0;
     }

-  HANDLE from_master_local, to_master_local;
+  /* Try inherited handles, if we are the ctty */
+  if (!cygheap->inherited_ctty.pass (*this))
+    {
+      HANDLE from_master_local, to_master_local;

 #ifdef USE_SERVER
-  if (!wincap.has_security ()
-      || cygserver_running =3D=3D CYGSERVER_UNAVAIL
-      || !cygserver_attach_tty (&from_master_local, &to_master_local))
+      if (!wincap.has_security ()
+	  || cygserver_running =3D=3D CYGSERVER_UNAVAIL
+	  || !cygserver_attach_tty (&from_master_local, &to_master_local)) {}
 #endif
-    {
-      termios_printf ("cannot dup handles via server. using old method.");
+      {
+	termios_printf ("cannot dup handles via server. using old method.");

-      HANDLE tty_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
-				      get_ttyp ()->master_pid);
-      termios_printf ("tty own handle %p",tty_owner);
-      if (tty_owner =3D=3D NULL)
-	{
-	  termios_printf ("can't open tty (%d) handle process %d",
-			  get_unit (), get_ttyp ()->master_pid);
-	  __seterrno ();
-	  return 0;
-	}
+
+	HANDLE tty_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					get_ttyp ()->master_pid);
+	termios_printf ("tty own handle %p",tty_owner);
+	if (tty_owner =3D=3D NULL)
+	  {
+	    termios_printf ("can't open tty (%d) handle process %d",
+			    get_unit (), get_ttyp ()->master_pid);
+	    __seterrno ();
+	    return 0;
+	  }
+
+	if (!DuplicateHandle (tty_owner, get_ttyp ()->from_master,
+			      hMainProc, &from_master_local, 0, TRUE,
+			      DUPLICATE_SAME_ACCESS))
+	  {
+	    termios_printf ("can't duplicate input, %E");
+	    __seterrno ();
+	    return 0;
+	  }

-      if (!DuplicateHandle (tty_owner, get_ttyp ()->from_master,
-			    hMainProc, &from_master_local, 0, TRUE,
-			    DUPLICATE_SAME_ACCESS))
-	{
-	  termios_printf ("can't duplicate input, %E");
-	  __seterrno ();
-	  return 0;
-	}
+	if (!DuplicateHandle (tty_owner, get_ttyp ()->to_master,
+			      hMainProc, &to_master_local, 0, TRUE,
+			      DUPLICATE_SAME_ACCESS))
+	  {
+	    termios_printf ("can't duplicate output, %E");
+	    __seterrno ();
+	    return 0;
+	  }
+	CloseHandle (tty_owner);
+      }

-      if (!DuplicateHandle (tty_owner, get_ttyp ()->to_master,
-			  hMainProc, &to_master_local, 0, TRUE,
-			  DUPLICATE_SAME_ACCESS))
-	{
-	  termios_printf ("can't duplicate output, %E");
-	  __seterrno ();
-	  return 0;
-	}
-      CloseHandle (tty_owner);
-    }
+      termios_printf ("duplicated from_master %p->%p from tty_owner",
+		      get_ttyp ()->from_master, from_master_local);
+      termios_printf ("duplicated to_master %p->%p from tty_owner",
+		      get_ttyp ()->to_master, to_master_local);

-  termios_printf ("duplicated from_master %p->%p from tty_owner",
-      get_ttyp ()->from_master, from_master_local);
-  termios_printf ("duplicated to_master %p->%p from tty_owner",
-      get_ttyp ()->to_master, to_master_local);
+      set_io_handle (from_master_local);
+      set_output_handle (to_master_local);

-  set_io_handle (from_master_local);
-  set_output_handle (to_master_local);
+      cygheap->inherited_ctty.acquire (*this);
+    }

   set_open_status ();
   if (fhandler_console::open_fhs++ =3D=3D 0 && !GetConsoleCP ()
@@ -1377,3 +1384,4 @@ fhandler_tty_master::init_console ()
   console->set_r_no_interrupt (1);
   return 0;
 }
+
Index: tty.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v
retrieving revision 1.57
diff -u -p -r1.57 tty.cc
--- tty.cc	25 Sep 2003 00:37:17 -0000	1.57
+++ tty.cc	30 Sep 2003 01:53:11 -0000
@@ -408,27 +408,17 @@ tty::common_init (fhandler_pty_master *p

   master_pid =3D GetCurrentProcessId ();

-  /* Allow the others to open us (for handle duplication) */
+  /* We do not open allow the others to open us (for handle duplication)
+     but rely on cygheap->inherited_ctty for descendant processes.
+     In the future the cygserver may allow access by others. */

-  /* FIXME: we shold NOT set the security wide open when the
-     daemon is running
-   */
+#ifdef USE_SERVER
   if (wincap.has_security ())
     {
-#ifdef USE_SERVER
       if (cygserver_running =3D=3D CYGSERVER_UNKNOWN)
 	cygserver_init ();
-#endif
-
-      if (
-#ifdef USE_SERVER
-	  cygserver_running !=3D CYGSERVER_OK &&
-#endif
-	  !SetKernelObjectSecurity (hMainProc,
-				       DACL_SECURITY_INFORMATION,
-				       get_null_sd ()))
-	system_printf ("Can't set process security, %E");
     }
+#endif

   /* Create synchronisation events */

Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.295
diff -u -p -r1.295 syscalls.cc
--- syscalls.cc	27 Sep 2003 05:44:58 -0000	1.295
+++ syscalls.cc	30 Sep 2003 01:53:15 -0000
@@ -312,6 +312,7 @@ setsid (void)
 	  syscall_printf ("freeing console");
 	  FreeConsole ();
 	}
+      cygheap->inherited_ctty.close ();
       myself->ctty =3D -1;
       myself->sid =3D getpid ();
       myself->pgid =3D getpid ();

--=====================_1064901325==_--
