Return-Path: <cygwin-patches-return-5553-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25249 invoked by alias); 5 Jul 2005 20:50:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25191 invoked by uid 22791); 5 Jul 2005 20:50:31 -0000
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 05 Jul 2005 20:50:31 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DpuMZ-0007fY-Pp
	for cygwin-patches@cygwin.com; Tue, 05 Jul 2005 22:49:53 +0200
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 05 Jul 2005 22:49:51 +0200
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 05 Jul 2005 22:49:51 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  cygcheck exit status
Date: Tue, 05 Jul 2005 20:50:00 -0000
Message-ID:  <loom.20050705T224501-8@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-SW-Source: 2005-q3/txt/msg00008.txt.bz2

As mentioned on cygwin (hopefully I'm not falling afoul of trivial patch size, 
since I don't have assignment; and hopefully gmane didn't kill this):

2005-07-05  Eric Blake  <ebb9@byu.net>

	* cygcheck.cc (track_down, cygcheck): Return true on success.
	(main): Reflect cygcheck failures in exit status.

Index: winsup/utils/cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.74
diff -u -b -p -r1.74 cygcheck.cc
--- winsup/utils/cygcheck.cc    30 May 2005 15:49:31 -0000      1.74
+++ winsup/utils/cygcheck.cc    5 Jul 2005 20:46:38 -0000
@@ -364,7 +364,7 @@ struct ImpDirectory
 };
 
 
-static void track_down (char *file, char *suffix, int lvl);
+static bool track_down (char *file, char *suffix, int lvl);
 
 #define CYGPREFIX (sizeof ("%%% Cygwin ") - 1)
 static void
@@ -554,26 +554,27 @@ dll_info (const char *path, HANDLE fh, i
     cygwin_info (fh);
 }
 
-static void
+// Return true on success, false if error printed
+static bool
 track_down (char *file, char *suffix, int lvl)
 {
   if (file == NULL)
     {
       display_error ("track_down: NULL passed for file", true, false);
-      return;
+      return false;
     }
 
   if (suffix == NULL)
     {
       display_error ("track_down: NULL passed for suffix", false, false);
-      return;
+      return false;
     }
 
   char *path = find_on_path (file, suffix, 0, 1);
   if (!path)
     {
       printf ("Error: could not find %s\n", file);
-      return;
+      return false;
     }
 
   Did *d = already_did (file);
@@ -589,7 +590,7 @@ track_down (char *file, char *suffix, in
          printf ("%s", path);
          printf (" (recursive)\n");
        }
-      return;
+      return true;
     case DID_INACTIVE:
       if (verbose)
        {
@@ -598,7 +599,7 @@ track_down (char *file, char *suffix, in
          printf ("%s", path);
          printf (" (already done)\n");
        }
-      return;
+      return true;
     default:
       break;
     }
@@ -609,7 +610,7 @@ track_down (char *file, char *suffix, in
   if (!path)
     {
       printf ("%s not found\n", file);
-      return;
+      return false;
     }
 
   printf ("%s", path);
@@ -620,7 +621,7 @@ track_down (char *file, char *suffix, in
   if (fh == INVALID_HANDLE_VALUE)
     {
       printf (" - Cannot open\n");
-      return;
+      return false;
     }
 
   d->state = DID_ACTIVE;
@@ -629,6 +630,7 @@ track_down (char *file, char *suffix, in
   d->state = DID_INACTIVE;
   if (!CloseHandle (fh))
     display_error ("track_down: CloseHandle()");
+  return true;
 }
 
 static void
@@ -653,14 +655,15 @@ ls (char *f)
     display_error ("ls: CloseHandle()");
 }
 
-static void
+// Return true on success, false if error printed
+static bool
 cygcheck (char *app)
 {
   char *papp = find_on_path (app, (char *) ".exe", 1, 0);
   if (!papp)
     {
       printf ("Error: could not find %s\n", app);
-      return;
+      return false;
     }
   char *s = strdup (papp);
   char *sl = 0, *t;
@@ -675,7 +678,7 @@ cygcheck (char *app)
       paths[0] = s;
     }
   did = 0;
-  track_down (papp, (char *) ".exe", 0);
+  return track_down (papp, (char *) ".exe", 0);
 }
 
 
@@ -1590,6 +1593,7 @@ int
 main (int argc, char **argv)
 {
   int i;
+  bool ok = true;
   load_cygwin (argc, argv);
 
   (void) putenv("POSIXLY_CORRECT=1");
@@ -1677,7 +1681,7 @@ main (int argc, char **argv)
       {
        if (i)
          puts ("");
-       cygcheck (argv[i]);
+       ok &= cygcheck (argv[i]);
       }
 
   if (sysinfo)
@@ -1693,5 +1697,5 @@ main (int argc, char **argv)
        puts ("Use -h to see help about each section");
     }
 
-  return 0;
+  return ok ? EXIT_SUCCESS : EXIT_FAILURE;
 }

