Return-Path: <cygwin-patches-return-2576-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7494 invoked by alias); 2 Jul 2002 02:57:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7478 invoked from network); 2 Jul 2002 02:57:39 -0000
Message-Id: <3.0.5.32.20020701225143.00820590@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 01 Jul 2002 19:57:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Any ideas with xterm/xfree problem?
In-Reply-To: <3D20DA17.7B521B43@ieee.org>
References: <20020701204140.GA25217@redhat.com>
 <3D20C1DA.26509E01@ieee.org>
 <20020701212139.GE25306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00024.txt.bz2

Chris,

Here is a better patch taking care of both uid and gid.
It was tested against the situations created by Harold
for xterm. AFAIK proper passwd/group are needed for ssh.

The goal is to allow seteuid/gid to itself even when passwd
and/or group are not properly setup.
Please revert the previous one.

Pierre


2002-07-01  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.c (seteuid32): Return immediately if the program is
	not impersonated and both uid and gid are original.
	(setegid32): Return immediately if the new gid is the current egid.

--- syscalls.cc.orig    2002-07-01 22:00:30.000000000 -0400
+++ syscalls.cc 2002-07-01 22:11:12.000000000 -0400
@@ -1955,11 +1955,16 @@
 extern "C" int
 seteuid32 (__uid32_t uid)
 {
-  if (!wincap.has_security ()) return 0;
 
-  if (uid == ILLEGAL_UID)
+  debug_printf ("uid: %d myself->gid: %d", uid, myself->gid);
+
+  if (!wincap.has_security () ||
+      (!cygheap->user.issetuid () && 
+       uid == myself->uid &&
+       myself->gid == cygheap->user.orig_gid) ||
+      uid == ILLEGAL_UID)
     {
-      debug_printf ("new euid == illegal euid, nothing happens");
+      debug_printf ("Nothing happens");
       return 0;
     }
 
@@ -1971,8 +1976,6 @@
   struct passwd * pw_new;
   PSID origpsid, psid2 = NO_SID;
 
-  debug_printf ("uid: %d myself->gid: %d", uid, myself->gid);
-
   pw_new = getpwuid32 (uid);
   if (!usersid.getfrompw (pw_new) ||
       (!pgrpsid.getfromgr (getgrgid32 (myself->gid))))
@@ -2134,6 +2137,7 @@
 setegid32 (__gid32_t gid)
 {
   if ((!wincap.has_security ()) ||
+      (gid == myself->gid) ||
       (gid == ILLEGAL_GID))
     return 0;
