Return-Path: <cygwin-patches-return-2507-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7617 invoked by alias); 24 Jun 2002 23:49:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7597 invoked from network); 24 Jun 2002 23:48:58 -0000
Message-Id: <3.0.5.32.20020624194543.00802da0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 24 Jun 2002 16:59:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: uinfo.cc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00490.txt.bz2

Looks like I had introduced a bug. A child had the wrong 
uid/gid (but the right token), following setEuid(). This fixes it. 
Sorry about that.

Pierre

2002-06-24  Pierre Humblet <pierre.humblet@ieee.org>

	* uinfo.cc (internal_getlogin): Save uid & gid in myself, not in user.
	(uinfo_init): Propagate uid & gid from myself to user, partially
	reverting 2002-06-12.

--- uinfo.cc.orig       2002-06-24 18:48:44.000000000 -0400
+++ uinfo.cc    2002-06-24 18:50:14.000000000 -0400
@@ -88,13 +88,13 @@
 
   if (pw)
     {
-      user.real_uid = pw->pw_uid;
-      user.real_gid = pw->pw_gid;
+      myself->uid = pw->pw_uid;
+      myself->gid = pw->pw_gid;
     }
   else
     {
-      user.real_uid = DEFAULT_UID;
-      user.real_gid = DEFAULT_GID;
+      myself->uid = DEFAULT_UID;
+      myself->gid = DEFAULT_GID;
     }
 
   (void) cygheap->user.ontherange (CH_HOME, pw);
@@ -109,8 +109,8 @@
     internal_getlogin (cygheap->user); /* Set the cygheap->user. */
 
   /* Real and effective uid/gid are identical on process start up. */
-  myself->uid = cygheap->user.orig_uid = cygheap->user.real_uid;
-  myself->gid = cygheap->user.orig_gid = cygheap->user.real_gid;
+  cygheap->user.orig_uid = cygheap->user.real_uid = myself->uid;
+  cygheap->user.orig_gid = cygheap->user.real_gid = myself->gid;
   cygheap->user.set_orig_sid();      /* Update the original sid */
 
   cygheap->user.token = INVALID_HANDLE_VALUE; /* No token present */
