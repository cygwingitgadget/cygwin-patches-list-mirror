Return-Path: <cygwin-patches-return-4826-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19562 invoked by alias); 4 Jun 2004 00:51:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19528 invoked from network); 4 Jun 2004 00:51:36 -0000
Message-Id: <3.0.5.32.20040603204818.00806dd0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 04 Jun 2004 00:51:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: fchdir
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00178.txt.bz2

2004-06-04  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (fchdir): Pass the Posix path to chdir.



Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.315
diff -u -p -r1.315 path.cc
--- path.cc     2 Jun 2004 21:20:53 -0000       1.315
+++ path.cc     4 Jun 2004 00:50:05 -0000
@@ -3358,7 +3358,7 @@ fchdir (int fd)
   int res;
   cygheap_fdget cfd (fd);
   if (cfd >= 0)
-    res = chdir (cfd->get_win32_name ());
+    res = chdir (cfd->get_name ());
   else
     res = -1;
 
