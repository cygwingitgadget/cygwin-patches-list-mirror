Return-Path: <cygwin-patches-return-5069-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29416 invoked by alias); 20 Oct 2004 20:20:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29406 invoked from network); 20 Oct 2004 20:20:16 -0000
Message-ID: <n2m-g.cl6d0r.3vsg1ph.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: Allow for larger drives. ``Used'', not ``Free''.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Wed, 20 Oct 2004 20:20:00 -0000
X-SW-Source: 2004-q4/txt/msg00070.txt.bz2

Hi,

Another (trivial, IMO) patch:

I noticed the format for ``Size'' in the drive-list is 5 digits long.
This overflows for drives >= 100 gigabytes. This patch allows for drives
< 10 terabytes. While at this, I spotted, in the help-text, where the
title reads ``Free'', it should read ``Used''.


ChangeLog-entry:

2004-10-20  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (dump_sysinfo): Allow for larger drives in drive-list.
	Change ``Used'' to ``Free'' in helptext-title for drive-list.


--- src/winsup/utils/cygcheck.cc	18 Oct 2004 10:25:38 -0000	1.53
+++ src/winsup/utils/cygcheck.cc	20 Oct 2004 15:25:16 -0000
@@ -1064,7 +1064,7 @@ dump_sysinfo ()
   if (givehelp)
     {
       printf ("Listing available drives...\n");
-      printf ("Drv Type        Size   Free Flags              Name\n");
+      printf ("Drv Type          Size   Used Flags              Name\n");
     }
   int prev_mode =
     SetErrorMode (SEM_FAILCRITICALERRORS | SEM_NOOPENFILEERRORBOX);
@@ -1135,9 +1135,9 @@ dump_sysinfo ()
 
       printf ("%.2s  %s %-6s ", drive, drive_type, fsname);
       if (capacity_mb >= 0)
-	printf ("%5dMb %3d%% ", (int) capacity_mb, (int) percent_full);
+	printf ("%7dMb %3d%% ", (int) capacity_mb, (int) percent_full);
       else
-	printf ("  N/A    N/A ");
+	printf ("    N/A    N/A ");
       printf ("%s %s %s %s %s %s  %s\n",
 	      flags & FS_CASE_IS_PRESERVED ? "CP" : "  ",
 	      flags & FS_CASE_SENSITIVE ? "CS" : "  ",


BTW: Should not dump_sysinfo be split up into a number of smaller
functions?

L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
