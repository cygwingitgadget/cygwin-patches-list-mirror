Return-Path: <cygwin-patches-return-4158-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27475 invoked by alias); 4 Sep 2003 00:32:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27457 invoked from network); 4 Sep 2003 00:32:14 -0000
Message-ID: <20030904003201.65133.qmail@web10007.mail.yahoo.com>
Date: Thu, 04 Sep 2003 00:32:00 -0000
From: AJ Reins <reinsaj@yahoo.com>
Subject: Patch 2: fix for mount -m command
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1560545519-1062635521=:64745"
X-SW-Source: 2003-q3/txt/msg00174.txt.bz2

--0-1560545519-1062635521=:64745
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline
Content-length: 249

2003-09-01  AJ Reins  <reinsaj@yahoo.com>

	* mount.cc (mount_commands): Add handling of option
managed.


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
--0-1560545519-1062635521=:64745
Content-Type: text/plain; name="changelog.2"
Content-Description: changelog.2
Content-Disposition: inline; filename="changelog.2"
Content-length: 105

2003-09-01  AJ Reins  <reinsaj@yahoo.com>

	* mount.cc (mount_commands): Add handling of option managed.

--0-1560545519-1062635521=:64745
Content-Type: text/plain; name="patch2.txt"
Content-Description: patch2.txt
Content-Disposition: inline; filename="patch2.txt"
Content-length: 448

--- mount1.cc	2003-09-01 08:34:00.000000000 -0500
+++ mount2.cc	2003-09-01 08:37:00.000000000 -0500
@@ -422,6 +422,8 @@
         strcat (opts, " -x");
       if (strstr (p->mnt_opts, ",noexec"))
         strcat (opts, " -E");
+      if (strstr (p->mnt_opts, ",managed"))
+        strcat (opts, " -o managed");
       while ((c = strchr (p->mnt_fsname, '\\')) != NULL)
         *c = '/';
       printf (format_mnt, opts, p->mnt_fsname, p->mnt_dir);

--0-1560545519-1062635521=:64745--
