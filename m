Return-Path: <cygwin-patches-return-2950-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2077 invoked by alias); 11 Sep 2002 01:35:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2063 invoked from network); 11 Sep 2002 01:35:21 -0000
Message-Id: <3.0.5.32.20020910213124.0080e5a0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Tue, 10 Sep 2002 18:35:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: initgroups
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00398.txt.bz2

Corinna,

when initgroups is called after setgroups, it can't be just a noop.
The patch below clears the groups set by setgroups.

Pierre

P.S.: Why is there a need to define ILLEGAL_GID? It
is never used to set a value.

2002-09-10  Pierre Humblet <pierre.humblet@ieee.org>

	* grp.cc (initgroups): Call groups::clear_supp to free the 
	supplementary group sids that may have been set by setgroups.
	* security.cc (cygsidlist::free_sids): Also zero the class members.
	* security.h (groups::clear_supp): New.
	Rename cygsidlist_unknown to cygsidlist_empty.

--- grp.cc.orig 2002-08-23 18:37:10.000000000 -0400
+++ grp.cc      2002-09-04 19:18:56.000000000 -0400
@@ -449,14 +449,16 @@
 int
 initgroups32 (const char *, __gid32_t)
 {
+  if (wincap.has_security ())
+    cygheap->user.groups.clear_supp ();
   return 0;
 }
 
 extern "C"
 int
-initgroups (const char *, __gid16_t)
+initgroups (const char * name, __gid16_t gid)
 {
-  return 0;
+  return initgroups32 (name, gid16togid32(gid));
 }
 
 /* setgroups32: standards? */
--- security.cc.orig    2002-08-29 23:34:02.000000000 -0400
+++ security.cc 2002-08-31 00:10:34.000000000 -0400
@@ -61,6 +61,9 @@
 {
   if (sids)
     cfree (sids);
+  sids = NULL;
+  count = maxcount = 0;
+  type = cygsidlist_empty;
 }
 
 extern "C" void
--- security.h.orig     2002-08-29 23:32:10.000000000 -0400
+++ security.h  2002-08-30 23:55:26.000000000 -0400
@@ -86,7 +86,7 @@
     }
 };
 
-typedef enum { cygsidlist_unknown, cygsidlist_alloc, cygsidlist_auto }
cygsidlist_type;
+typedef enum { cygsidlist_empty, cygsidlist_alloc, cygsidlist_auto }
cygsidlist_type;
 class cygsidlist {
   int maxcount;
 public:
@@ -167,6 +167,11 @@
       sgsids = newsids;
       ischanged = TRUE;
     }
+  void clear_supp ()
+    {
+      sgsids.free_sids ();
+      ischanged = TRUE;
+    }
   void update_pgrp (const PSID sid)
     {
       pgsid = sid;
