Return-Path: <cygwin-patches-return-4237-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12060 invoked by alias); 26 Sep 2003 01:56:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12050 invoked from network); 26 Sep 2003 01:56:34 -0000
Message-Id: <3.0.5.32.20030925214748.0081f330@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 26 Sep 2003 01:56:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: {Patch]: Giving access to pinfo after seteuid and exec
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1064555268==_"
X-SW-Source: 2003-q3/txt/msg00253.txt.bz2

--=====================_1064555268==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 557

This patch sets the _pinfo acl in order to allow access after 
seteuid and exec.

While looking at spawn.cc I also noticed oddities in pinfo related
error handling, and reworked them. I also restored impersonation in
case of CreateProcessAsUser failure.

Pierre

2003-09-25  Pierre Humblet <pierre.humblet@ieee.org>

	* pinfo.h (pinfo::set_acl): Declare.
	* pinfo.cc (pinfo_fixup_after_fork): Duplicate with no rights.
	(pinfo::set_acl): New.
	* spawn.cc (spawn_guts): Call myself.set_acl. Always reimpersonate
	after errors. Fix pinfo related error cases. 
--=====================_1064555268==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pinfo.diff"
Content-length: 4138

Index: pinfo.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pinfo.h,v
retrieving revision 1.52
diff -u -p -r1.52 pinfo.h
--- pinfo.h	25 Sep 2003 00:37:17 -0000	1.52
+++ pinfo.h	26 Sep 2003 00:57:08 -0000
@@ -176,6 +176,7 @@ public:
   }
 #endif
   HANDLE shared_handle () {return h;}
+  void set_acl();
 };

 #define ISSTATE(p, f)	(!!((p)->process_state & f))
Index: pinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.88
diff -u -p -r1.88 pinfo.cc
--- pinfo.cc	25 Sep 2003 00:37:17 -0000	1.88
+++ pinfo.cc	26 Sep 2003 00:57:09 -0000
@@ -30,6 +30,7 @@ details. */
 #include "shared_info.h"
 #include "cygheap.h"
 #include "fhandler.h"
+#include <aclapi.h>

 static char NO_COPY pinfo_dummy[sizeof (_pinfo)] =3D {0};

@@ -42,9 +43,9 @@ pinfo_fixup_after_fork ()
 {
   if (hexec_proc)
     CloseHandle (hexec_proc);
-
+  /* Keeps the cygpid from being reused. No rights required */
   if (!DuplicateHandle (hMainProc, hMainProc, hMainProc, &hexec_proc, 0,
-			TRUE, DUPLICATE_SAME_ACCESS))
+			TRUE, 0))
     {
       system_printf ("couldn't save current process handle %p, %E", hMainP=
roc);
       hexec_proc =3D NULL;
@@ -236,6 +237,22 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
       break;
     }
   destroy =3D 1;
+}
+
+void
+pinfo::set_acl()
+{
+  char sa_buf[1024];
+  SECURITY_DESCRIPTOR sd;
+
+  sec_acl ((PACL) sa_buf, true, true, cygheap->user.sid (),
+	   well_known_world_sid, FILE_MAP_READ | FILE_MAP_READ); /* FIXME */
+  if (!InitializeSecurityDescriptor( &sd, SECURITY_DESCRIPTOR_REVISION))
+    debug_printf("InitializeSecurityDescriptor %E");
+  else if (!SetSecurityDescriptorDacl(&sd, TRUE, (PACL) sa_buf, FALSE))
+    debug_printf("SetSecurityDescriptorDacl %E");
+  else if (!SetKernelObjectSecurity(h, DACL_SECURITY_INFORMATION, &sd))
+    debug_printf ("SetKernelObjectSecurity %E");
 }

 bool
Index: spawn.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.132
diff -u -p -r1.132 spawn.cc
--- spawn.cc	25 Sep 2003 13:49:21 -0000	1.132
+++ spawn.cc	26 Sep 2003 00:57:11 -0000
@@ -672,7 +672,9 @@ spawn_guts (const char * prog_arg, const
   else
     {
       PSID sid =3D cygheap->user.sid ();
-
+      /* Give access to myself */
+      if (mode =3D=3D _P_OVERLAY)
+	myself.set_acl();
       /* Set security attributes with sid */
       PSECURITY_ATTRIBUTES sec_attribs =3D sec_user_nih (sa_buf, sid);

@@ -711,7 +713,7 @@ spawn_guts (const char * prog_arg, const

   /* Restore impersonation. In case of _P_OVERLAY this isn't
      allowed since it would overwrite child data. */
-  if (mode !=3D _P_OVERLAY)
+  if (mode !=3D _P_OVERLAY || !rc)
       cygheap->user.reimpersonate ();

   MALLOC_CHECK;
@@ -788,16 +790,20 @@ spawn_guts (const char * prog_arg, const
     {
       myself->set_has_pgid_children ();
       ProtectHandle (pi.hThread);
-      pinfo child (cygpid, 1);
+      pinfo child (cygpid, PID_IN_USE);
       if (!child)
 	{
-	  set_errno (EAGAIN);
-	  syscall_printf ("-1 =3D spawnve (), process table full");
+	  syscall_printf ("-1 =3D spawnve (), failed pinfo");
 	  return -1;
 	}
       child->dwProcessId =3D pi.dwProcessId;
       child->hProcess =3D pi.hProcess;
-      child.remember ();
+      if (!child.remember ())
+	{
+	  set_errno (EAGAIN);
+	  syscall_printf ("-1 =3D spawnve (), process table full");
+	  return -1;
+	}
       strcpy (child->progname, real_path);
       /* FIXME: This introduces an unreferenced, open handle into the chil=
d.
 	 The purpose is to keep the pid shared memory open so that all of

--=====================_1064555268==_--
