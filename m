Return-Path: <cygwin-patches-return-1986-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 542 invoked by alias); 13 Mar 2002 21:26:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 409 invoked from network); 13 Mar 2002 21:26:33 -0000
Message-ID: <20020313212632.11925.qmail@web20008.mail.yahoo.com>
Date: Thu, 14 Mar 2002 04:43:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: mkgroup usage/version patch
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-28123385-1016054792=:5189"
X-SW-Source: 2002-q1/txt/msg00343.txt.bz2

--0-28123385-1016054792=:5189
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 810

This patch generalizes the usage function to allow output to stdout in
addition to stderr, and fixes an apparent typo where the help option
is listed as -?,--help, while in reality the code supports -h,--help.
It also adds a -v,--version option with Chris' print_version function.

2002-03-13  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

	* mkgroup.c (usage): Simplify usage output.  Generalize to allow use
	for help. Correct '?' typo to 'h'.
	(longopts): Add version option.
	(opts): Add 'v' version option.
	(print_version): New function.
	(main): Accommodate new version option.  Accommodate usage parameter
	changes.  Use usage to output help message.

__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
--0-28123385-1016054792=:5189
Content-Type: text/plain; name="mkgroup.c-patch"
Content-Description: mkgroup.c-patch
Content-Disposition: inline; filename="mkgroup.c-patch"
Content-length: 3732

--- mkgroup.c-orig	Sun Feb 24 13:28:27 2002
+++ mkgroup.c	Wed Mar 13 15:17:49 2002
@@ -18,6 +18,8 @@
 #include <lmaccess.h>
 #include <lmapibuf.h>
 
+static const char version[] = "$Revision: 1.9 $";
+
 SID_IDENTIFIER_AUTHORITY sid_world_auth = {SECURITY_WORLD_SID_AUTHORITY};
 SID_IDENTIFIER_AUTHORITY sid_nt_auth = {SECURITY_NT_AUTHORITY};
 
@@ -399,24 +401,27 @@ print_special (int print_sids,
     }
 }
 
-int
-usage ()
+static void
+usage (FILE *stream, int status)
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
+fprintf(stream, "\
+Usage: mkgroup [OPTION]... [domain]\n\n\
+Print a /etc/group file to stdout\n\
+Options:\n\
+   -l,--local             print local group information\n\
+   -d,--domain            print global group information from the domain\n\
+                          specified (or from the current domain if there is\n\
+                          no domain specified)\n\
+   -o,--id-offset offset  change the default offset (10000) added to uids\n\
+                          in domain accounts.\n\
+   -s,--no-sids           don't print SIDs in pwd field\n\
+                          (this affects ntsec)\n\
+   -u,--users             print user list in gr_mem field\n\
+   -h,--help              print this message\n\
+   -v,--version           output version information and exit\n\
+One of `-l' or `-d' must be given on NT/W2K.\n\
+");
+  exit (status);
 }
 
 struct option longopts[] = {
@@ -426,10 +431,32 @@ struct option longopts[] = {
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
+Copyright 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.\n\
+Compiled on %s", len, v, __DATE__);
+}
 
 int
 main (int argc, char **argv)
@@ -453,7 +480,7 @@ main (int argc, char **argv)
   if (GetVersion () < 0x80000000)
     {
       if (argc == 1)
-	return usage ();
+	usage (stderr, 1);
       else
 	{
 	  while ((i = getopt_long (argc, argv, opts, longopts, NULL)) != EOF)
@@ -475,7 +502,10 @@ main (int argc, char **argv)
 		print_users = 1;
 		break;
 	      case 'h':
-		return usage ();
+		usage (stdout, 0);
+	      case 'v':
+	        print_version ();
+                exit (0);
 	      default:
 		fprintf (stderr, "Try `%s --help' for more information.\n", argv[0]);
 		return 1;

--0-28123385-1016054792=:5189--
