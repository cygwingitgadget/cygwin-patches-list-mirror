Return-Path: <cygwin-patches-return-3676-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17724 invoked by alias); 8 Mar 2003 03:07:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17714 invoked from network); 8 Mar 2003 03:07:47 -0000
Message-Id: <3.0.5.32.20030307220508.007d2d50@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Sat, 08 Mar 2003 03:07:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: utmp
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1047110708==_"
X-SW-Source: 2003-q1/txt/msg00325.txt.bz2

--=====================_1047110708==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 536

Chris,

Here is GetComputerName replacing cygwin_gethostname.
When testing I found an old bug: ut_id wasn't set although 
login() uses it in getutid(), called from pututline().

utmp is now closed with endutent() (that's what sshd does too)
and I optimized setutent.

Please review & apply.

Pierre


2003-03-07  Pierre Humblet  <pierre.humblet@ieee.org>

	* tty.cc (create_tty_master): Call GetComputerName instead of
	cygwin_gethostname. Set ut_id.
	* syscalls.cc (login): Call endutent.
	(setutent): Do not seek after a fresh open.


--=====================_1047110708==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="utmp.diff"
Content-length: 2163

Index: tty.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v
retrieving revision 1.50
diff -u -p -r1.50 tty.cc
--- tty.cc	26 Nov 2002 20:32:39 -0000	1.50
+++ tty.cc	8 Mar 2003 02:45:09 -0000
@@ -81,12 +81,18 @@ create_tty_master (int ttynum)
     {
       /* Log utmp entry */
       struct utmp our_utmp;
+      DWORD len =3D sizeof our_utmp.ut_host;

       bzero ((char *) &our_utmp, sizeof (utmp));
       (void) time (&our_utmp.ut_time);
       strncpy (our_utmp.ut_name, getlogin (), sizeof (our_utmp.ut_name));
-      cygwin_gethostname (our_utmp.ut_host, sizeof (our_utmp.ut_host));
+      GetComputerName (our_utmp.ut_host, &len);
       __small_sprintf (our_utmp.ut_line, "tty%d", ttynum);
+      if ((len =3D strlen (our_utmp.ut_line)) >=3D UT_IDLEN)
+	len -=3D UT_IDLEN;
+      else
+	len =3D 0;
+      strncpy (our_utmp.ut_id, our_utmp.ut_line + len, UT_IDLEN);
       our_utmp.ut_type =3D USER_PROCESS;
       our_utmp.ut_pid =3D myself->pid;
       myself->ctty =3D ttynum;
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.249
diff -u -p -r1.249 syscalls.cc
--- syscalls.cc	7 Mar 2003 16:35:56 -0000	1.249
+++ syscalls.cc	8 Mar 2003 02:45:23 -0000
@@ -2472,6 +2472,7 @@ login (struct utmp *ut)
   register int fd;

   pututline (ut);
+  endutent ();
   if ((fd =3D open (_PATH_WTMP, O_WRONLY | O_APPEND | O_BINARY, 0)) >=3D 0)
     {
       (void) write (fd, (char *) ut, sizeof (struct utmp));
@@ -2551,10 +2552,9 @@ setutent ()
 {
   sigframe thisframe (mainthread);
   if (utmp_fd =3D=3D -2)
-    {
-      utmp_fd =3D open (utmp_file, O_RDWR);
-    }
-  lseek (utmp_fd, 0, SEEK_SET);
+    utmp_fd =3D open (utmp_file, O_RDWR);
+  else
+    lseek (utmp_fd, 0, SEEK_SET);
 }

 extern "C" void

--=====================_1047110708==_--
