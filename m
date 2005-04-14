Return-Path: <cygwin-patches-return-5408-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12030 invoked by alias); 14 Apr 2005 04:59:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12011 invoked from network); 14 Apr 2005 04:59:42 -0000
Received: from unknown (HELO mailproxy-in2.jaist.ac.jp) (150.65.5.23)
  by sourceware.org with SMTP; 14 Apr 2005 04:59:42 -0000
Received: from mailproxy-in2-prvt (localhost [127.0.0.1])
 by mailproxy-in2.jaist.ac.jp (JAIST-MAIL)
 with ESMTP id <0IEX0020R77DCS@mailproxy-in2.jaist.ac.jp> for
 cygwin-patches@cygwin.com; Thu, 14 Apr 2005 13:59:38 +0900 (JST)
Received: from NFORCE1 (nforce1.jaist.ac.jp [150.65.191.58])
 by mailproxy-in2.jaist.ac.jp (JAIST-MAIL)
 with ESMTP id <0IEX000B377DOI@mailproxy-in2.jaist.ac.jp> for
 cygwin-patches@cygwin.com; Thu, 14 Apr 2005 13:59:37 +0900 (JST)
Date: Thu, 14 Apr 2005 04:59:00 -0000
From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
Subject: Correct debugging output in seteuid32
To: cygwin-patches@cygwin.com
Message-id: <uoeci3qdv.fsf@jaist.ac.jp>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.1 (windows-nt)
X-SW-Source: 2005-q2/txt/msg00004.txt.bz2

I'd submit a trivial patch after a long time.

2005-04-14  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* syscalls.cc (setuid32): Correct debugging output.

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.372
diff -u -u -r1.372 syscalls.cc
--- syscalls.cc	11 Apr 2005 21:54:54 -0000	1.372
+++ syscalls.cc	14 Apr 2005 04:45:38 -0000
@@ -1959,7 +1959,7 @@
 extern "C" int
 seteuid32 (__uid32_t uid)
 {
-  debug_printf ("uid: %u myself->gid: %u", uid, myself->gid);
+  debug_printf ("uid: %u myself->uid: %u", uid, myself->uid);
 
   if (uid == myself->uid && !cygheap->user.groups.ischanged)
     {

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
