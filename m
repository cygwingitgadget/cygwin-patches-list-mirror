Return-Path: <cygwin-patches-return-4254-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1695 invoked by alias); 27 Sep 2003 02:18:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1682 invoked from network); 27 Sep 2003 02:18:47 -0000
Message-Id: <3.0.5.32.20030926221700.008209b0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 27 Sep 2003 02:18:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Turning pinfo security on
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1064643420==_"
X-SW-Source: 2003-q3/txt/msg00270.txt.bz2

--=====================_1064643420==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 738

Following Chris' new signal handling approach and the previous
patch "Giving access to pinfo after seteuid and exec", we can
now turn pinfo security on.

It's just a matter of removing the FILE_MAP_WRITE permission for
Everybody, and a couple of useless PID_MAP_WRITE in pinfo constructors.
I have left the PID_MAP_WRITE in the winpids constructors for now,
they will be removed later.

Pierre

2003-09-26  Pierre Humblet <pierre.humblet@ieee.org>

	* pinfo.cc (pinfo::init): Do not give FILE_MAP_WRITE access to Everybody.
	* exceptions.cc (sig_handle_tty_stop): Do not create pinfo parent with
	PID_MAP_WRITE.
	* fhandler_process.cc (fhandler_process::fill_filebuf): Ditto for pinfo p.
	* signal.cc (kill_worker): Ditto for pinfo dest.

--=====================_1064643420==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pinfo3.diff"
Content-length: 2850

Index: pinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.89
diff -u -p -r1.89 pinfo.cc
--- pinfo.cc	27 Sep 2003 01:58:23 -0000	1.89
+++ pinfo.cc	27 Sep 2003 02:11:08 -0000
@@ -170,7 +170,7 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
 	  char sa_buf[1024];
 	  PSECURITY_ATTRIBUTES sec_attribs =3D
 	    sec_user_nih (sa_buf, cygheap->user.sid(), well_known_world_sid,
-			  FILE_MAP_READ | FILE_MAP_WRITE); /* FIXME */
+			  FILE_MAP_READ);
 	  h =3D CreateFileMapping (INVALID_HANDLE_VALUE, sec_attribs,
 				 PAGE_READWRITE, 0, mapsize, mapname);
 	  created =3D h && GetLastError () !=3D ERROR_ALREADY_EXISTS;
Index: exceptions.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.170
diff -u -p -r1.170 exceptions.cc
--- exceptions.cc	25 Sep 2003 00:37:16 -0000	1.170
+++ exceptions.cc	27 Sep 2003 02:11:11 -0000
@@ -616,7 +616,7 @@ sig_handle_tty_stop (int sig)
      its list of subprocesses.  */
   if (my_parent_is_alive ())
     {
-      pinfo parent (myself->ppid, PID_MAP_RW);
+      pinfo parent (myself->ppid);
       if (ISSTATE (parent, PID_NOCLDSTOP))
 	sig_send (parent, SIGCHLD);
     }
Index: fhandler_process.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v
retrieving revision 1.38
diff -u -p -r1.38 fhandler_process.cc
--- fhandler_process.cc	25 Sep 2003 00:37:16 -0000	1.38
+++ fhandler_process.cc	27 Sep 2003 02:11:12 -0000
@@ -245,8 +245,7 @@ out:
 bool
 fhandler_process::fill_filebuf ()
 {
-  pinfo p (pid, PID_MAP_RW);	// PID_MAP_RW for cmdline since it
-  				// needs to signal the other process
+  pinfo p (pid);

   if (!p)
     {
Index: signal.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.52
diff -u -p -r1.52 signal.cc
--- signal.cc	25 Sep 2003 03:51:51 -0000	1.52
+++ signal.cc	27 Sep 2003 02:11:12 -0000
@@ -173,7 +173,7 @@ kill_worker (pid_t pid, int sig)
   sig_dispatch_pending ();

   int res =3D 0;
-  pinfo dest (pid, PID_MAP_RW);
+  pinfo dest (pid);
   BOOL sendSIGCONT;

   if (!dest)

--=====================_1064643420==_--
