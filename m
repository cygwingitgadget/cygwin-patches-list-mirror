Return-Path: <cygwin-patches-return-5023-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6616 invoked by alias); 6 Oct 2004 13:12:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6434 invoked from network); 6 Oct 2004 13:12:49 -0000
Message-ID: <n2m-g.ck100t.3vvcra7.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: warn about trailing (back)slash on mount entries
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Wed, 06 Oct 2004 13:12:00 -0000
X-SW-Source: 2004-q4/txt/msg00024.txt.bz2

Another (hopefully trivial) patch, to help in trouble-shooting.


ChangeLog-entry:

2004-10-06  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (dump_sysinfo): Warn about trailing (back)slash on mount
	entries.


--- src/winsup/utils/cygcheck.cc	6 Oct 2004 09:46:40 -0000	1.45
+++ src/winsup/utils/cygcheck.cc	6 Oct 2004 11:59:58 -0000
@@ -1165,19 +1165,25 @@ dump_sysinfo ()
   printf ("\n");
 
   unsigned ml_fsname = 4, ml_dir = 7, ml_type = 6;
+  bool ml_trailing = false;
 
   struct mntent *mnt;
   setmntent (0, 0);
   while ((mnt = getmntent (0)))
     {
       unsigned n = (int) strlen (mnt->mnt_fsname);
+      ml_trailing |= (n > 1 && strchr ("\\/", mnt->mnt_fsname[n - 1]));
       if (ml_fsname < n)
 	ml_fsname = n;
       n = (int) strlen (mnt->mnt_dir);
+      ml_trailing |= (n > 1 && strchr ("\\/", mnt->mnt_dir[n - 1]));
       if (ml_dir < n)
 	ml_dir = n;
     }
 
+  if (ml_trailing)
+    puts ("Warning: Mount entries should not have a trailing (back)slash\n");
+
   if (givehelp)
     {
       printf

L8r,

Buzz (by special request).
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
