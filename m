Return-Path: <cygwin-patches-return-3627-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28271 invoked by alias); 26 Feb 2003 05:09:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28261 invoked from network); 26 Feb 2003 05:09:39 -0000
Message-Id: <3.0.5.32.20030226000807.007f4ba0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Wed, 26 Feb 2003 05:09:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: printing owner and group SIDs
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00276.txt.bz2

Corinna,

this patch makes it easy to view owner and group SIDS, e.g.

/> strace ls test3 | fgrep SID
  394  243946 [main] ls 319 cygpsid::debug_print: get_sids_info: 
	group SID = S-1-5-21-1391547877-877281485-1846952604-2655
  293  244239 [main] ls 319 cygpsid::debug_print: get_sids_info: 
	owner SID = S-1-5-21-1391547877-877281485-1846952604-1054

Pierre


2003-02-26  Pierre Humblet  <pierre.humblet@ieee.org>

	* sec_helper.cc (get_sids_info): debug_print owner_sid and group_sid.



Index: sec_helper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.36
diff -u -p -r1.36 sec_helper.cc
--- sec_helper.cc       6 Feb 2003 14:01:54 -0000       1.36
+++ sec_helper.cc       26 Feb 2003 04:03:50 -0000
@@ -193,6 +193,7 @@ get_sids_info (cygpsid owner_sid, cygpsi
   struct __group32 *gr = NULL;
   bool ret = false;
 
+  group_sid.debug_print ("get_sids_info: group SID =");
   if (group_sid == cygheap->user.groups.pgsid)
     *gidret = myself->gid;
   else if ((gr = internal_getgrsid (group_sid)))
@@ -200,6 +201,7 @@ get_sids_info (cygpsid owner_sid, cygpsi
   else
     *gidret = ILLEGAL_GID;
 
+  owner_sid.debug_print ("get_sids_info: owner SID =");
   if (owner_sid == cygheap->user.sid ())
     {
       *uidret = myself->uid;
