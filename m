Return-Path: <cygwin-patches-return-4200-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 801 invoked by alias); 11 Sep 2003 04:08:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 788 invoked from network); 11 Sep 2003 04:08:12 -0000
Message-Id: <3.0.5.32.20030911000542.00818340@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 11 Sep 2003 14:08:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Fixing a security hole in pinfo.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1063267542==_"
X-SW-Source: 2003-q3/txt/msg00217.txt.bz2

--=====================_1063267542==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1575

Each Cygwin process publishes information about itself 
(e.g. pid, ppid, uid, gid, ...) in a _pinfo file mapping. 

Currently Everyone has write access to the _pinfo file mapping.
Thus Everyone can change a process uid and gid.
By changing its uid and gid, one can trick a daemon into 
logging in a user with a SYSTEM access token.
I have not examined the security risk involved in being able to 
change the other members of _pinfo.

As for the mount file mapping, a safe solution relies on protecting
the mapping with appropriate security attributes. 
Everyone should have Read access while RW access should only be
given to the current user, Administrators and System.
Processes that only need to read information will open the _pinfo
mapping in read only mode.

It will take several incremental patches to reach this goal.

This patch accomplishes a first step: pinfo::init will open a
_pinfo mapping in RW mode only if it would create the mapping
or if the new flag PID_MAP_RW is set.
The flag PID_MAP_RW is added in the few pinfo constructors
that need to be write into _pinfo if it exists. 
I hope not to have forgotten any.

2003-09-11  Pierre Humblet <pierre.humblet@ieee.org>

	* include/sys/cygwin.h: Rename PID_UNUSED to PID_MAP_RW.
	* pinfo.cc (pinfo_init): Initialize myself->gid.
	(pinfo::init): Create the "access" variable, set it appropriately
	and use it to specify the requested access.
	* exceptions.cc (sig_handle_tty_stop): Add PID_MAP_RW in pinfo parent.
	* signal.cc (kill_worker): Ditto for pinfo dest.
	* syscalls.cc (setpgid): Ditto for pinfo p.

	
--=====================_1063267542==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pinfo.diff"
Content-length: 4602

Index: include/sys/cygwin.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/include/sys/cygwin.h,v
retrieving revision 1.46
diff -u -p -r1.46 cygwin.h
--- include/sys/cygwin.h	9 Sep 2003 03:11:31 -0000	1.46
+++ include/sys/cygwin.h	11 Sep 2003 03:40:54 -0000
@@ -89,7 +89,7 @@ enum
   PID_ORPHANED	       =3D 0x0020, /* Member of an orphaned process group. =
*/
   PID_ACTIVE	       =3D 0x0040, /* Pid accepts signals. */
   PID_CYGPARENT	       =3D 0x0080, /* Set if parent was a cygwin app. */
-  PID_UNUSED	       =3D 0x0100, /* ... */
+  PID_MAP_RW	       =3D 0x0100, /* Flag to open map rw. */
   PID_MYSELF	       =3D 0x0200, /* Flag that pid is me. */
   PID_NOCLDSTOP	       =3D 0x0400, /* Set if no SIGCHLD signal on stop. */
   PID_INITIALIZING     =3D 0x0800, /* Set until ready to receive signals. =
*/
Index: pinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.83
diff -u -p -r1.83 pinfo.cc
--- pinfo.cc	5 Sep 2003 01:55:01 -0000	1.83
+++ pinfo.cc	11 Sep 2003 03:40:54 -0000
@@ -89,7 +89,7 @@ pinfo_init (char **envp, int envc)
       myself->pgid =3D myself->sid =3D myself->pid;
       myself->ctty =3D -1;
       myself->uid =3D ILLEGAL_UID;
-
+      myself->gid =3D UNKNOWN_GID;
       environ_init (NULL, 0);	/* call after myself has been set up */
     }

@@ -138,6 +138,8 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
     }

   int createit =3D flag & (PID_IN_USE | PID_EXECED);
+  DWORD access =3D FILE_MAP_READ
+                 | (flag & (PID_IN_USE | PID_EXECED | PID_MAP_RW) ? FILE_M=
AP_WRITE : 0);
   for (int i =3D 0; i < 10; i++)
     {
       int created;
@@ -157,7 +159,7 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
 	}
       else if (!createit)
 	{
-	  h =3D OpenFileMappingA (FILE_MAP_READ | FILE_MAP_WRITE, FALSE, mapname);
+	  h =3D OpenFileMappingA (access, FALSE, mapname);
 	  created =3D 0;
 	}
       else
@@ -175,8 +177,7 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
 	  return;
 	}

-      procinfo =3D (_pinfo *) MapViewOfFileEx (h, FILE_MAP_READ | FILE_MAP=
_WRITE,
-					     0, 0, 0, mapaddr);
+      procinfo =3D (_pinfo *) MapViewOfFileEx (h, access, 0, 0, 0, mapaddr=
);
       ProtectHandle1 (h, pinfo_shared_handle);

       if ((procinfo->process_state & PID_INITIALIZING) && (flag & PID_NORE=
DIR)
Index: exceptions.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.166
diff -u -p -r1.166 exceptions.cc
--- exceptions.cc	10 Sep 2003 17:26:12 -0000	1.166
+++ exceptions.cc	11 Sep 2003 03:40:57 -0000
@@ -610,7 +610,7 @@ sig_handle_tty_stop (int sig)
      its list of subprocesses.  */
   if (my_parent_is_alive ())
     {
-      pinfo parent (myself->ppid);
+      pinfo parent (myself->ppid, PID_MAP_RW);
       if (NOTSTATE (parent, PID_NOCLDSTOP))
 	sig_send (parent, SIGCHLD);
     }
Index: signal.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.48
diff -u -p -r1.48 signal.cc
--- signal.cc	7 Sep 2003 05:18:01 -0000	1.48
+++ signal.cc	11 Sep 2003 03:40:57 -0000
@@ -173,7 +173,7 @@ kill_worker (pid_t pid, int sig)
   sig_dispatch_pending ();

   int res =3D 0;
-  pinfo dest (pid);
+  pinfo dest (pid, PID_MAP_RW);
   BOOL sendSIGCONT;

   if (!dest)
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.287
diff -u -p -r1.287 syscalls.cc
--- syscalls.cc	10 Sep 2003 19:13:04 -0000	1.287
+++ syscalls.cc	11 Sep 2003 03:41:01 -0000
@@ -1961,7 +1961,7 @@ setpgid (pid_t pid, pid_t pgid)
     }
   else
     {
-      pinfo p (pid);
+      pinfo p (pid, PID_MAP_RW);
       if (!p)
 	{
 	  set_errno (ESRCH);

--=====================_1063267542==_--
