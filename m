Return-Path: <cygwin-patches-return-4893-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1746 invoked by alias); 13 Aug 2004 23:17:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1726 invoked from network); 13 Aug 2004 23:17:29 -0000
Message-Id: <3.0.5.32.20040813191326.00810100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 13 Aug 2004 23:17:00 -0000
To: Rob Walker <rob@tenfoot.org.uk>,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Re: CVS commit under windows 98
In-Reply-To: <200408131749.03224.rob@tenfoot.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00045.txt.bz2


A feature present in open was missing from open9x.

Pierre

2004-08-14  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.cc (fhandler_base::open_9x): Set file attributes
	for new files.


Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.201
diff -u -p -r1.201 fhandler.cc
--- fhandler.cc 17 Jun 2004 15:25:09 -0000      1.201
+++ fhandler.cc 13 Aug 2004 23:12:42 -0000
@@ -480,9 +480,14 @@ fhandler_base::open_9x (int flags, mode_
     }
 #endif
 
-  /* If mode has no write bits set, we set the R/O attribute. */
-  if (!(mode & (S_IWUSR | S_IWGRP | S_IWOTH)))
-    file_attributes |= FILE_ATTRIBUTE_READONLY;
+  if (flags & O_CREAT && get_device () == FH_FS)
+    {
+      /* If mode has no write bits set, we set the R/O attribute. */
+      if (!(mode & (S_IWUSR | S_IWGRP | S_IWOTH)))
+        file_attributes |= FILE_ATTRIBUTE_READONLY;
+      /* The file attributes are needed for later use in, e.g. fchmod. */
+      pc.file_attributes (file_attributes & FILE_ATTRIBUTE_VALID_SET_FLAGS);
+    } 
 
   x = CreateFile (get_win32_name (), access, shared, &sa,
creation_distribution,
                  file_attributes, 0);
