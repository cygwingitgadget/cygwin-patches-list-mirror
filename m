Return-Path: <cygwin-patches-return-1996-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28768 invoked by alias); 20 Mar 2002 01:33:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28730 invoked from network); 20 Mar 2002 01:33:28 -0000
Message-ID: <20020320013328.44270.qmail@web20002.mail.yahoo.com>
Date: Fri, 22 Mar 2002 22:52:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: mkpasswd patch
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-350142815-1016588008=:44233"
X-SW-Source: 2002-q1/txt/msg00353.txt.bz2

--0-350142815-1016588008=:44233
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 885

Here is a patch for mkpasswd that is very similar to the one for 
mkgroup just checked in. It uses string concatenation similar to the current
CVS of mkgroup, maintaining spacing. 

Also, do I need to resubmit the kill.cc long-options patch from:

http://cygwin.com/ml/cygwin-patches/2002-q1/msg00339.html

I forgot the attachment the first time and never heard anything more...
Thanks.

Changelog:

2001-03-19  Joshua Daniel Franklin  <joshuadfranklin@yahoo.com>
	* mkpasswd.c (usage): Simplify usage output.  Generalize to allow use
	for help. Correct '?' typo to 'h'.
	(longopts): Add version option.
	(opts): Add 'v' version option.
	(print_version): New function.
	(main): Accommodate new version option.  Accommodate usage parameter
	changes. 

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
--0-350142815-1016588008=:44233
Content-Type: text/plain; name="mkpasswd.c-patch"
Content-Description: mkpasswd.c-patch
Content-Disposition: inline; filename="mkpasswd.c-patch"
Content-length: 4825

--- mkpasswd.c-orig	Sun Feb 24 13:28:27 2002
+++ mkpasswd.c	Tue Mar 19 19:21:32 2002
@@ -1,6 +1,6 @@
 /* mkpasswd.c:
 
-   Copyright 1997, 1998, 1999, 2000, 2001 Red Hat, Inc.
+   Copyright 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.
 
    This file is part of Cygwin.
 
@@ -21,6 +21,8 @@
 #include <sys/fcntl.h>
 #include <lmerr.h>
 
+static const char version[] = "$Revision: 1.20 $";
+
 SID_IDENTIFIER_AUTHORITY sid_world_auth = {SECURITY_WORLD_SID_AUTHORITY};
 SID_IDENTIFIER_AUTHORITY sid_nt_auth = {SECURITY_NT_AUTHORITY};
 
@@ -393,26 +395,27 @@ print_special (int print_sids,
 }
 
 int
-usage ()
+usage (FILE * stream, int status)
 {
-  fprintf (stderr, "Usage: mkpasswd [OPTION]... [domain]\n\n");
-  fprintf (stderr, "This program prints a /etc/passwd file to stdout\n\n");
-  fprintf (stderr, "Options:\n");
-  fprintf (stderr, "   -l,--local              print local user accounts\n");
-  fprintf (stderr, "   -d,--domain             print domain accounts (from current domain\n");
-  fprintf (stderr, "                           if no domain specified)\n");
-  fprintf (stderr, "   -o,--id-offset offset   change the default offset (10000) added to uids\n");
-  fprintf (stderr, "                           in domain accounts.\n");
-  fprintf (stderr, "   -g,--local-groups       print local group information too\n");
-  fprintf (stderr, "                           if no domain specified\n");
-  fprintf (stderr, "   -m,--no-mount           don't use mount points for home dir\n");
-  fprintf (stderr, "   -s,--no-sids            don't print SIDs in GCOS field\n");
-  fprintf (stderr, "                           (this affects ntsec)\n");
-  fprintf (stderr, "   -p,--path-to-home path  use specified path instead of user account home dir\n");
-  fprintf (stderr, "   -u,--username username  only return information for the specified user\n");
-  fprintf (stderr, "   -?,--help               displays this message\n\n");
-  fprintf (stderr, "One of `-l', `-d' or `-g' must be given on NT/W2K.\n");
-  return 1;
+  fprintf (stream, "Usage: mkpasswd [OPTION]... [domain]\n\n"
+                   "This program prints a /etc/passwd file to stdout\n\n"
+                   "Options:\n"
+                   "   -l,--local              print local user accounts\n"
+                   "   -d,--domain             print domain accounts (from current domain\n"
+                   "                           if no domain specified)\n"
+                   "   -o,--id-offset offset   change the default offset (10000) added to uids\n"
+                   "                           in domain accounts.\n"
+                   "   -g,--local-groups       print local group information too\n"
+                   "                           if no domain specified\n"
+                   "   -m,--no-mount           don't use mount points for home dir\n"
+                   "   -s,--no-sids            don't print SIDs in GCOS field\n"
+                   "                           (this affects ntsec)\n"
+                   "   -p,--path-to-home path  use specified path instead of user account home dir\n"
+                   "   -u,--username username  only return information for the specified user\n"
+                   "   -h,--help               displays this message\n"
+                   "   -v,--version            version information and exit\n\n"
+                   "One of `-l', `-d' or `-g' must be given on NT/W2K.\n");
+  return status;
 }
 
 struct option longopts[] = {
@@ -425,10 +428,33 @@ struct option longopts[] = {
   {"path-to-home", required_argument, NULL, 'p'},
   {"username", required_argument, NULL, 'u'},
   {"help", no_argument, NULL, 'h'},
+  {"version", no_argument, NULL, 'v'},
   {0, no_argument, NULL, 0}
 };
 
-char opts[] = "ldo:gsmhp:u:";
+char opts[] = "ldo:gsmhp:u:v";
+
+static void
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
+mkpasswd (cygwin) %.*s\n\
+passwd File Generator\n\
+Copyright 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.\n\
+Compiled on %s", len, v, __DATE__);
+}
 
 int
 main (int argc, char **argv)
@@ -455,7 +481,7 @@ main (int argc, char **argv)
   if (GetVersion () < 0x80000000)
     {
       if (argc == 1)
-	return usage ();
+	return usage (stderr, 1);
       else
 	{
 	  while ((i = getopt_long (argc, argv, opts, longopts, NULL)) != EOF)
@@ -494,7 +520,10 @@ main (int argc, char **argv)
 		disp_username = optarg;
 		break;
 	      case 'h':
-		return usage ();
+		return usage (stdout, 0);
+	      case 'v':
+                print_version ();
+		exit (0);
 	      default:
 		fprintf (stderr, "Try `%s --help' for more information.\n", argv[0]);
 		return 1;

--0-350142815-1016588008=:44233--
