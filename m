Return-Path: <cygwin-patches-return-5132-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12632 invoked by alias); 16 Nov 2004 03:59:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12573 invoked from network); 16 Nov 2004 03:59:27 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 16 Nov 2004 03:59:27 -0000
Received: from buzzy-box (hmm-dca-ap02-d01-019.dial.freesurf.nl [195.18.74.19])
	by green.qinip.net (Postfix) with SMTP
	id 41FE54286; Tue, 16 Nov 2004 04:59:25 +0100 (MET)
Message-ID: <n2m-g.cnbvsp.3vvbkun.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: Unset show_error and print_failed in some places.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
Date: Tue, 16 Nov 2004 03:59:00 -0000
X-SW-Source: 2004-q4/txt/msg00133.txt.bz2

Hi,

More trivia, I'd say.

This sets print_failed to false in places where printing "failed"
makes no sense. In some of those places show_error is also cleared.


ChangeLog-entry.

2004-11-16  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (find_on_path): Clear show_error and/or print_failed
	parameters to display_error.
	(rva_to_offset): Ditto.
	(dll_info): Ditto.
	(track_down): Ditto.


--- src/winsup/utils/cygcheck.cc	11 Nov 2004 01:56:02 -0000	1.62
+++ src/winsup/utils/cygcheck.cc	16 Nov 2004 02:52:08 -0000
@@ -190,13 +190,13 @@ find_on_path (char *file, char *default_
 
   if (!file)
     {
-      display_error ("find_on_path: NULL pointer for file");
+      display_error ("find_on_path: NULL pointer for file", false, false);
       return 0;
     }
 
   if (default_extension == NULL)
     {
-      display_error ("find_on_path: NULL pointer for default_extension");
+      display_error ("find_on_path: NULL pointer for default_extension", false, false);
       return 0;
     }
 
@@ -305,7 +305,7 @@ rva_to_offset (int rva, char *sections, 
 
   if (sections == NULL)
     {
-      display_error ("rva_to_offset: NULL passed for sections");
+      display_error ("rva_to_offset: NULL passed for sections", true, false);
       return 0;
     }
 
@@ -437,7 +437,7 @@ dll_info (const char *path, HANDLE fh, i
 
   if (path == NULL)
     {
-      display_error ("dll_info: NULL passed for path");
+      display_error ("dll_info: NULL passed for path", true, false);
       return;
     }
 
@@ -542,13 +542,13 @@ track_down (char *file, char *suffix, in
 {
   if (file == NULL)
     {
-      display_error ("track_down: NULL passed for file");
+      display_error ("track_down: NULL passed for file", true, false);
       return;
     }
 
   if (suffix == NULL)
     {
-      display_error ("track_down: NULL passed for suffix");
+      display_error ("track_down: NULL passed for suffix", false, false);
       return;
     }
 


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
