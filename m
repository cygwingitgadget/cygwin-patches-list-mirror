Return-Path: <cygwin-patches-return-1923-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 870 invoked by alias); 27 Feb 2002 20:56:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 837 invoked from network); 27 Feb 2002 20:56:35 -0000
Message-ID: <20020227205634.45738.qmail@web20003.mail.yahoo.com>
Date: Wed, 27 Feb 2002 14:27:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: cygpath copyright/version patch
To: cygwin-patches@cygwin.com
In-Reply-To: <20020227162528.GA2205@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-354990715-1014843394=:42318"
X-SW-Source: 2002-q1/txt/msg00280.txt.bz2

--0-354990715-1014843394=:42318
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1208

--- Christopher Faylor <cgf@redhat.com> wrote:
> I've checked in a modified version of your patch.  I cleaned up some of
> the non-GNU formatting, added a ChangeLog, and added a "print_version"
> function which parses the 'version' array for version info.
> 
Your patch looks much cleaner. I will try to read up on GNU formatting to avoid
this in the future. I assume my indenting was off. 

Here is a patch for cygpath that fixes the copyright dates I changed
incorrectly. It also uses cgf's print_version() instead of the previous
hard-coded and wrong version. (The current cygpath.exe outputs version 1.2,
while in reality the CVS version is 1.13.) The first line of the new version
output is in the GNU standard "file (package) #.##", i.e. "cygpath (cygwin)
1.13" or "ls (fileutils) 4.1". It also initializes the variable 'o' to prevent
a compiler warning.

Changelog:

2002-02-27 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

* cygpath.cc (print_version): New function.
(main): Accommodate new version function. Initialize 'o' to prevent warning.

__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com
--0-354990715-1014843394=:42318
Content-Type: text/plain; name="cygpath.cc-patch"
Content-Description: cygpath.cc-patch
Content-Disposition: inline; filename="cygpath.cc-patch"
Content-length: 1469

--- cygpath.cc-orig	Sun Feb 24 13:28:27 2002
+++ cygpath.cc	Wed Feb 27 14:32:51 2002
@@ -1,5 +1,5 @@
 /* cygpath.cc -- convert pathnames between Windows and Unix format
-   Copyright 1998-2002 Red Hat, Inc.
+   Copyright 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -21,6 +21,8 @@ details. */
 #include <sys/cygwin.h>
 #include <ctype.h>
 
+static const char version[] = "$Revision: 1.13 $";
+
 static char *prog_name;
 static char *file_arg;
 static char *close_arg;
@@ -231,6 +233,28 @@ doit (char *filename)
   puts (buf);
 }
 
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
+cygpath (cygwin) %.*s\n\
+Path Conversion Utility\n\
+Copyright 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.\n\
+Compiled on %s", len, v, __DATE__);
+}
+
 int
 main (int argc, char **argv)
 {
@@ -257,6 +281,7 @@ main (int argc, char **argv)
   options_from_file_flag = 0;
   allusers_flag = 0;
   output_flag = 0;
+  o=0;
   while ((c = getopt_long (argc, argv, (char *) "hac:f:opsSuvwWiDPA", long_options, (int *) NULL))
 	 != EOF)
     {
@@ -341,8 +366,7 @@ main (int argc, char **argv)
 	  break;
 
 	case 'v':
-	  printf ("Cygwin path conversion version 1.2\n");
-	  printf ("Copyright 1998-2002 Red Hat, Inc.\n");
+          print_version();
 	  exit (0);
 
 	default:

--0-354990715-1014843394=:42318--
