Return-Path: <cygwin-patches-return-1990-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12106 invoked by alias); 17 Mar 2002 05:44:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12070 invoked from network); 17 Mar 2002 05:44:00 -0000
Message-ID: <20020317054400.4671.qmail@web20008.mail.yahoo.com>
Date: Mon, 18 Mar 2002 19:15:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: new mkgroup patch
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1384063771-1016343840=:3113"
X-SW-Source: 2002-q1/txt/msg00347.txt.bz2

--0-1384063771-1016343840=:3113
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 665

Here is a new patch that retains the multiple fprintf's instead of 
using a multiline one in the usage function. Also adds version option, etc.:

2002-03-16  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

	* mkgroup.c (usage): Simplify usage output.  Generalize to allow use
	for help. Correct '?' typo to 'h'.
	(longopts): Add version option.
	(opts): Add 'v' version option.
	(print_version): New function.
	(main): Accommodate new version option.  Accommodate usage parameter
	changes.  Use usage to output help message.


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
--0-1384063771-1016343840=:3113
Content-Type: text/plain; name="mkgroup.c-patch"
Content-Description: mkgroup.c-patch
Content-Disposition: inline; filename="mkgroup.c-patch"
Content-length: 4177

--- mkgroup.c-orig	Sat Mar 16 23:31:49 2002
+++ mkgroup.c	Sat Mar 16 23:36:19 2002
@@ -1,6 +1,6 @@
 /* mkgroup.c:
 
-   Copyright 1997, 1998 Cygnus Solutions.
+   Copyright 1997, 1998, 2002 Cygnus Solutions.
 
    This file is part of Cygwin.
 
@@ -20,6 +20,8 @@
 #include <ntsecapi.h>
 #include <ntdef.h>
 
+static const char version[] = "$Revision: 1.10 $";
+
 SID_IDENTIFIER_AUTHORITY sid_world_auth = {SECURITY_WORLD_SID_AUTHORITY};
 SID_IDENTIFIER_AUTHORITY sid_nt_auth = {SECURITY_NT_AUTHORITY};
 
@@ -402,23 +404,24 @@ print_special (int print_sids,
 }
 
 int
-usage ()
+usage (FILE * stream, int status)
 {
-  fprintf (stderr, "Usage: mkgroup [OPTION]... [domain]\n\n");
-  fprintf (stderr, "This program prints a /etc/group file to stdout\n\n");
-  fprintf (stderr, "Options:\n");
-  fprintf (stderr, "   -l,--local             print local group information\n");
-  fprintf (stderr, "   -d,--domain            print global group information from the domain\n");
-  fprintf (stderr, "                          specified (or from the current domain if there is\n");
-  fprintf (stderr, "                          no domain specified)\n");
-  fprintf (stderr, "   -o,--id-offset offset  change the default offset (10000) added to uids\n");
-  fprintf (stderr, "                          in domain accounts.\n");
-  fprintf (stderr, "   -s,--no-sids           don't print SIDs in pwd field\n");
-  fprintf (stderr, "                          (this affects ntsec)\n");
-  fprintf (stderr, "   -u,--users             print user list in gr_mem field\n");
-  fprintf (stderr, "   -?,--help              print this message\n\n");
-  fprintf (stderr, "One of `-l' or `-d' must be given on NT/W2K.\n");
-  return 1;
+  fprintf (stream, "Usage: mkgroup [OPTION]... [domain]\n\n");
+  fprintf (stream, "This program prints a /etc/group file to stdout\n\n");
+  fprintf (stream, "Options:\n");
+  fprintf (stream, "   -l,--local             print local group information\n");
+  fprintf (stream, "   -d,--domain            print global group information from the domain\n");
+  fprintf (stream, "                          specified (or from the current domain if there is\n");
+  fprintf (stream, "                          no domain specified)\n");
+  fprintf (stream, "   -o,--id-offset offset  change the default offset (10000) added to uids\n");
+  fprintf (stream, "                          in domain accounts.\n");
+  fprintf (stream, "   -s,--no-sids           don't print SIDs in pwd field\n");
+  fprintf (stream, "                          (this affects ntsec)\n");
+  fprintf (stream, "   -u,--users             print user list in gr_mem field\n");
+  fprintf (stream, "   -h,--help              print this message\n\n");
+  fprintf (stream, "   -v,--version           print version information and exit\n\n");
+  fprintf (stream, "One of `-l' or `-d' must be given on NT/W2K.\n");
+  return status;
 }
 
 struct option longopts[] = {
@@ -428,10 +431,32 @@ struct option longopts[] = {
   {"no-sids", no_argument, NULL, 's'},
   {"users", no_argument, NULL, 'u'},
   {"help", no_argument, NULL, 'h'},
+  {"version", no_argument, NULL, 'v'},
   {0, no_argument, NULL, 0}
 };
 
-char opts[] = "ldo:suh";
+char opts[] = "ldo:suhv";
+
+print_version ()
+{
+  const char *v = strchr (version, ':');
+  int len;
+  if (!v)
+    {
+      v = "?";
+      len = 1;
+    }
+  else
+    {
+      v += 2;
+      len = strchr (v, ' ') - v;
+    }
+  printf ("\
+mkgroup (cygwin) %.*s\n\
+group File Generator\n\
+Copyright 1997, 1998, 2002 Red Hat, Inc.\n\
+Compiled on %s", len, v, __DATE__);
+}
 
 int
 main (int argc, char **argv)
@@ -461,7 +486,7 @@ main (int argc, char **argv)
   if (GetVersion () < 0x80000000)
     {
       if (argc == 1)
-	return usage ();
+	return usage(stderr, 1);
       else
 	{
 	  while ((i = getopt_long (argc, argv, opts, longopts, NULL)) != EOF)
@@ -483,7 +508,10 @@ main (int argc, char **argv)
 		print_users = 1;
 		break;
 	      case 'h':
-		return usage ();
+		return usage (stdout, 0);
+	      case 'v':
+		print_version ();
+		exit (0);
 	      default:
 		fprintf (stderr, "Try `%s --help' for more information.\n", argv[0]);
 		return 1;

--0-1384063771-1016343840=:3113--
