Return-Path: <cygwin-patches-return-4967-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13086 invoked by alias); 16 Sep 2004 05:26:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13064 invoked from network); 16 Sep 2004 05:26:26 -0000
Message-ID: <n2m-g.cibek2.3vvfqsr.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] Trailing spaces in cygcheck -cd or -s output.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.0 (Win32) Hamster/2.0.5.5
To: cygwin-patches@cygwin.com
Date: Thu, 16 Sep 2004 05:26:00 -0000
X-SW-Source: 2004-q3/txt/msg00119.txt.bz2

Hi,

This (trivial again, IMO) patch avoids trailing spaces in the output
of cygheck's package-list. (This will reduce the size of
`cygcheck.out's somewhat, as well.)


ChangeLog enty:

2004-09-16  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* dump_setup.cc (dump_setup): Avoid trailing spaces on package-list.


--- src/winsup/utils/dump_setup.cc	8 Sep 2003 02:50:02 -0000	1.14
+++ src/winsup/utils/dump_setup.cc	16 Sep 2004 04:41:25 -0000
@@ -392,12 +392,14 @@ dump_setup (int verbose, char **argv, bo
 	puts ("");
     }
 
-  printf ("%-*s %-*s     %s\n", package_len, "Package", version_len, "Version", check_files?"Status":"");
+  printf ("%-*s %-*s%s\n", package_len, "Package",
+    check_files ? version_len : 7, "Version",
+    check_files ? "     Status" : "");
   for (int i = 0; packages[i].name; i++)
     {
-      printf ("%-*s %-*s     %s\n", package_len, packages[i].name, version_len,
-	      packages[i].ver, check_files ?
-	      (check_package_files (verbose, packages[i].name) ? "OK" : "Incomplete") : "");
+      printf ("%-*s %-*s%s\n", package_len, packages[i].name,
+	      check_files ? version_len : strlen(packages[i].ver), packages[i].ver, check_files ?
+	      (check_package_files (verbose, packages[i].name) ? "     OK" : "     Incomplete") : "");
       fflush(stdout);
     }
 

L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
