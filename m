Return-Path: <cygwin-patches-return-5110-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20958 invoked by alias); 3 Nov 2004 02:17:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20942 invoked from network); 3 Nov 2004 02:17:07 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.203.248)
  by sourceware.org with SMTP; 3 Nov 2004 02:17:07 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I6KZSX-0082E7-0B
	for cygwin-patches@cygwin.com; Tue, 02 Nov 2004 21:19:45 -0500
Message-Id: <3.0.5.32.20041102211220.00827d50@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 03 Nov 2004 02:17:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [PATCH] kill -f
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1099465940==_"
X-SW-Source: 2004-q4/txt/msg00111.txt.bz2

--=====================_1099465940==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 294

This patch allows kill.exe -f to deal with Win9x pids.

Pierre

2004-11-03  Pierre Humblet <pierre.humblet@ieee.org>

	* kill.cc (forcekill): Do not pass negative pids to 
	cygwin_internal.
	(main): Make pid a long long and distinguish between pids,
	gpids (i.e. negative pids) and Win9x pids.

--=====================_1099465940==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="kill.diff"
Content-length: 2364

Index: kill.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/utils/kill.cc,v
retrieving revision 1.24
diff -u -p -b -r1.24 kill.cc
--- kill.cc	27 May 2004 15:15:51 -0000	1.24
+++ kill.cc	2 Nov 2004 16:05:44 -0000
@@ -17,6 +17,7 @@ details. */
 #include <windows.h>
 #include <sys/cygwin.h>
 #include <getopt.h>
+#include <limits.h>

 static const char version[] =3D "$Revision: 1.14 $";
 static char *prog_name;
@@ -157,7 +158,10 @@ forcekill (int pid, int sig, int wait)
   // try to acquire SeDebugPrivilege
   get_debug_priv();

-  external_pinfo *p =3D (external_pinfo *) cygwin_internal (CW_GETPINFO_FU=
LL, pid);
+  external_pinfo *p =3D NULL;
+  /* cygwin_internal misinterprets negative pids (Win9x pids) */
+  if (pid > 0)
+    p =3D (external_pinfo *) cygwin_internal (CW_GETPINFO_FULL, pid);
   DWORD dwpid =3D p ? p->dwProcessId : (DWORD) pid;
   HANDLE h =3D OpenProcess (PROCESS_TERMINATE, FALSE, (DWORD) dwpid);
   if (!h)
@@ -195,7 +199,7 @@ main (int argc, char **argv)
   opterr =3D 0;

   char *p;
-  int pid =3D 0;
+  long long int pid =3D 0;

   for (;;)
     {
@@ -235,7 +239,7 @@ main (int argc, char **argv)
 	case '?':
 	  if (gotasig)
 	    {
-	      pid =3D strtol (argv[optind], &p, 10);
+	      pid =3D strtoll (argv[optind], &p, 10);
 	      if (pid < 0)
 		goto out;
 	      usage ();
@@ -258,23 +262,23 @@ out:
   while (*argv !=3D NULL)
     {
       if (!pid)
-	pid =3D strtol (*argv, &p, 10);
-      if (*p !=3D '\0')
+	pid =3D strtoll (*argv, &p, 10);
+      if (pid < LONG_MIN || pid > ULONG_MAX || *p !=3D '\0')
 	{
 	  fprintf (stderr, "%s: illegal pid: %s\n", prog_name, *argv);
 	  ret =3D 1;
 	}
-      else if (kill (pid, sig) =3D=3D 0)
+      else if (pid <=3D LONG_MAX && kill ((pid_t) pid, sig) =3D=3D 0)
 	{
 	  if (force)
-	    forcekill (pid, sig, 1);
+	    forcekill ((pid_t) pid, sig, 1);
 	}
-      else if (force && sig !=3D 0)
-	forcekill (pid, sig, 0);
+      else if (pid > 0 && (force || pid > LONG_MAX) && sig !=3D 0)
+	forcekill ((pid_t) pid, sig, 0);
       else
 	{
 	  char buf[1000];
-	  sprintf (buf, "%s %d", prog_name, pid);
+	  sprintf (buf, "%s %lld", prog_name, pid);
 	  perror (buf);
 	  ret =3D 1;
 	}

--=====================_1099465940==_--
