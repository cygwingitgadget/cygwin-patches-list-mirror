Return-Path: <cygwin-patches-return-4157-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25873 invoked by alias); 4 Sep 2003 00:30:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25853 invoked from network); 4 Sep 2003 00:30:13 -0000
Message-ID: <20030904003012.6705.qmail@web10009.mail.yahoo.com>
Date: Thu, 04 Sep 2003 00:30:00 -0000
From: AJ Reins <reinsaj@yahoo.com>
Subject: Patch1: fix for mount -m command.
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1213952878-1062635412=:6637"
X-SW-Source: 2003-q3/txt/msg00173.txt.bz2

--0-1213952878-1062635412=:6637
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline
Content-length: 290

2003-09-01  AJ Reins  <reinsaj@yahoo.com>

	* mount.cc (mount_commands): Ensure user mode is
actually user
	mode and not the default system mode.


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
--0-1213952878-1062635412=:6637
Content-Type: text/plain; name="changelog.1"
Content-Description: changelog.1
Content-Disposition: inline; filename="changelog.1"
Content-length: 146

2003-09-01  AJ Reins  <reinsaj@yahoo.com>

	* mount.cc (mount_commands): Ensure user mode is actually user
	mode and not the default system mode.

--0-1213952878-1062635412=:6637
Content-Type: text/plain; name="patch1.txt"
Content-Description: patch1.txt
Content-Disposition: inline; filename="patch1.txt"
Content-length: 391

--- mount.cc	2003-07-26 00:38:51.000000000 -0500
+++ mount1.cc	2003-09-01 08:34:00.000000000 -0500
@@ -433,7 +433,7 @@
   cygwin_internal (CW_GET_CYGDRIVE_INFO, user, system, user_flags,
 		   system_flags);
   if (strlen (user) > 0) {
-    strcpy (opts, "   ");
+    strcpy (opts, " -u");
     if      (user_flags[0] == 'b')
       strcat (opts, " -b");
     else if (user_flags[0] == 't')

--0-1213952878-1062635412=:6637--
