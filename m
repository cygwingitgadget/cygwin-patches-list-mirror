Return-Path: <cygwin-patches-return-1958-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12893 invoked by alias); 9 Mar 2002 06:53:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12872 invoked from network); 9 Mar 2002 06:53:28 -0000
Message-ID: <20020309065328.40363.qmail@web20002.mail.yahoo.com>
Date: Sat, 09 Mar 2002 10:37:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: dumper.exe help/version patch 
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-783677398-1015656808=:39753"
X-SW-Source: 2002-q1/txt/msg00315.txt.bz2

--0-783677398-1015656808=:39753
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 807

Here is the next in the series of patches to standardize the help and
version options in the utils. This also adds GNUish options to dumper.
I left the "Compiled on __DATE__" out of
print_version since there is a #ifdef __GNUC__ in the file and I don't
know whether that trick works with all compilers.

2002-03-09  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
* dumper.cc (usage) Standardize usage output. Generalize to allow use for help.
            (longopts) New struct. Added longopts for all options.
            (print_version) New function. 
            (main) Change getopt to getopt_long. Accommodate new help and 
            version options. 

__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
--0-783677398-1015656808=:39753
Content-Type: text/plain; name="dumper.cc-patch"
Content-Description: dumper.cc-patch
Content-Disposition: inline; filename="dumper.cc-patch"
Content-length: 2509

--- dumper.cc-orig	Sun Feb 24 19:33:06 2002
+++ dumper.cc	Sat Mar  9 00:34:02 2002
@@ -1,6 +1,6 @@
 /* dumper.cc
 
-   Copyright 1999,2001 Red Hat Inc.
+   Copyright 1999, 2001, 2002 Red Hat Inc.
 
    Written by Egor Duda <deo@logos-m.ru>
 
@@ -36,6 +36,8 @@ __attribute__ ((packed))
 #endif
   note_header;
 
+static const char version[] = "$Revision: 1.8 $";
+
 BOOL verbose = FALSE;
 
 int deb_printf (const char *format,...)
@@ -770,14 +772,46 @@ dumper::write_core_dump ()
 }
 
 static void
-usage ()
+usage (FILE * stream, int status)
 {
-  fprintf (stderr, "Usage: dumper [options] filename pid\n");
-  fprintf (stderr, "filename -- dump core to filename.core\n");
-  fprintf (stderr, "pid      -- win32-pid of process to dump\n\n");
-  fprintf (stderr, "Possible options are:\n");
-  fprintf (stderr, "-d       -- be verbose while dumping\n");
-  fprintf (stderr, "-q       -- be quite while dumping (default)\n");
+  fprintf (stream, "\
+Usage: dumper [OPTION] FILENAME WIN32PID\n\
+Dump core from WIN32PID to FILENAME.core\n\
+ -d, --verbose  be verbose while dumping\n\
+ -h, --help     output help information and exit\n\
+ -q, --quiet    be quiet while dumping (default)\n\
+ -v, --version  output version information and exit\n\
+");
+  exit (status);
+}
+
+struct option longopts[] = {
+  {"verbose", no_argument, NULL, 'd'},
+  {"help", no_argument, NULL, 'h'},
+  {"quiet", no_argument, NULL, 'q'},
+  {"version", no_argument, 0, 'v'},
+  {0, no_argument, NULL, 0}
+};
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
+dumper (cygwin) %.*s\n\
+Core Dumper for Cygwin\n\
+Copyright 1999, 2001, 2002 Red Hat, Inc.\n", len, v);
 }
 
 int
@@ -788,7 +822,7 @@ main (int argc, char **argv)
   DWORD pid;
   char win32_name [MAX_PATH];
 
-  while ((opt = getopt (argc, argv, "dq")) != EOF)
+  while ((opt = getopt_long (argc, argv, "dqhv", longopts, NULL) ) != EOF)
     switch (opt)
       {
       case 'd':
@@ -797,8 +831,13 @@ main (int argc, char **argv)
       case 'q':
 	verbose = FALSE;
 	break;
+      case 'h':
+	usage (stdout, 0);
+      case 'v':
+       print_version ();
+       exit (0);
       default:
-	usage ();
+	usage (stderr, 1);
 	break;
       }
 
@@ -814,7 +853,7 @@ main (int argc, char **argv)
     }
   else
     {
-      usage ();
+      usage (stderr, 1);
       return -1;
     }
 

--0-783677398-1015656808=:39753--
