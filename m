Return-Path: <cygwin-patches-return-2289-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10875 invoked by alias); 2 Jun 2002 23:46:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10859 invoked from network); 2 Jun 2002 23:46:12 -0000
Message-Id: <3.0.5.32.20020602194017.007e5ca0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 02 Jun 2002 16:46:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: getgrgid() and setegid()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00272.txt.bz2

Corinna.

This is not related to your group 32 changes, they are fine.

getgrgid32 (gid) returns the default grp if the gid does not
exist and allow_ntsec is FALSE. As a result, calling setegid()
with a non-existent gid can put a user in the admins group
when allow_ntsec is FALSE.

If you think it's undesirable, apply the following patch.

Pierre

P.S.: There was an earlier patch on 2002-01-21 to take care of the 
same problem when ntsec is on. With the recent changes, it also 
occurs when ntsec is off...

2002-05-30  Pierre Humblet <pierre.humblet@ieee.org>

	syscalls.cc (setegid32): Verify the correctness of the gid 
	of the group returned by getgrgid32.

--- syscalls.cc.orig    2002-05-30 18:15:24.000000000 -0400
+++ syscalls.cc 2002-05-30 18:50:32.000000000 -0400
@@ -2169,7 +2169,8 @@
   cygsid gsid;
   HANDLE ptok;
 
-  if (!(gsid.getfromgr (getgrgid32 (gid))))
+  struct __group32 * gr = getgrgid32 (gid);
+  if (!gr || gr->gr_gid != gid || !gsid.getfromgr (gr))
     {
       set_errno (EINVAL);
       return -1;
