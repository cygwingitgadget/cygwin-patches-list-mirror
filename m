Return-Path: <cygwin-patches-return-1877-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25984 invoked by alias); 24 Feb 2002 03:06:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25919 invoked from network); 24 Feb 2002 03:05:58 -0000
Message-ID: <20020224030557.62368.qmail@web20003.mail.yahoo.com>
Date: Sat, 23 Feb 2002 23:28:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: version information for cygcheck
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1264186979-1014519957=:61643"
X-SW-Source: 2002-q1/txt/msg00234.txt.bz2

--0-1264186979-1014519957=:61643
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1107

Here is a patch for cygcheck that adds an option:
 -z, --version      output version information and exit

I used -z since -v is --verbose. It could also have no character 
option if that would be better. Current output is:

$ ./cygcheck.exe --version
cygcheck (Cygwin) System checker 1.2
Copyright 1998-2002 Red Hat, Inc.

I used 1.2 since 1.0 would probably confuse people (as cygcheck has been
around a long time) and there is no real version infomation available AFAIK.

This patch also changes the usage() function to accept a stream and
exit value, so that if only the --help option is specified usage will
be output to stdout instead of stderr, which is more standard behaviour.

I hope to provide similar patches for the other utils if there
are no objections.

Changelog:

2001-02-23 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

* cygcheck.cc (main): added a --version option
* cygcheck.cc (usage): added parameters to accept a stream and exit value

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
--0-1264186979-1014519957=:61643
Content-Type: text/plain; name="cygcheck.cc-patch"
Content-Description: cygcheck.cc-patch
Content-Disposition: inline; filename="cygcheck.cc-patch"
Content-length: 2437

--- cygcheck.cc-orig	Sat Feb 23 20:24:25 2002
+++ cygcheck.cc	Sat Feb 23 20:52:06 2002
@@ -1216,17 +1216,19 @@ check_keys ()
 }
 
 void
-usage ()
+usage (FILE *stream, int status)
 {
-  fprintf (stderr, "Usage: cygcheck [OPTIONS] [program ...]\n");
-  fprintf (stderr, "  -c, --check-setup = check packages installed via setup.exe\n");
-  fprintf (stderr, "  -s, --sysinfo     = system information (not with -k)\n");
-  fprintf (stderr, "  -v, --verbose     = verbose output (indented) (for -s or programs)\n");
-  fprintf (stderr, "  -r, --registry    = registry search (requires -s)\n");
-  fprintf (stderr, "  -k, --keycheck    = perform a keyboard check session (not with -s)\n");
-  fprintf (stderr, "  -h, --help        = give help about the info (not with -c)\n");
-  fprintf (stderr, "You must at least give either -s or -k or a program name\n");
-  exit (1);
+  fprintf (stream, "\
+Usage: cygcheck [OPTIONS] [program ...]\n\
+ -c, --check-setup  check packages installed via setup.exe\n\
+ -s, --sysinfo      system information (not with -k)\n\
+ -v, --verbose      verbose output (indented) (for -s or programs)\n\
+ -r, --registry     registry search (requires -s)\n\
+ -k, --keycheck     perform a keyboard check session (not with -s)\n\
+ -h, --help         give help about the info (not with -c)\n\
+ -z, --version      output version information and exit\n\
+You must at least give either -s or -k or a program name\n");
+  exit (status);
 }
 
 struct option longopts[] = {
@@ -1236,6 +1238,7 @@ struct option longopts[] = {
   {"verbose", no_argument, NULL, 'v'},
   {"keycheck", no_argument, NULL, 'k'},
   {"help", no_argument, NULL, 'h'},
+  {"version", no_argument, 0, 'z'},
   {0, no_argument, NULL, 0}
 };
 
@@ -1267,17 +1270,25 @@ main (int argc, char **argv)
       case 'h':
 	givehelp = 1;
 	break;
+      case 'z':
+        printf ("cygcheck (Cygwin) System checker 1.2\n");
+        printf ("Copyright 1998-2002 Red Hat, Inc.\n");
+        exit (0);
       default:
-	usage ();
+	usage (stderr, 1);
        /*NOTREACHED*/}
   argc -= optind;
   argv += optind;
 
-  if (argc == 0 && !sysinfo && !keycheck && !check_setup)
-    usage ();
+  if (argc == 0 && !sysinfo && !keycheck && !check_setup) {
+     if (givehelp)
+	usage (stdout, 0);
+     else
+	usage (stderr, 1);
+     }
 
   if ((check_setup || sysinfo) && keycheck)
-    usage ();
+	usage (stderr, 1);
 
   if (keycheck)
     return check_keys ();

--0-1264186979-1014519957=:61643--
