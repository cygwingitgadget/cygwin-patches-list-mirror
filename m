Return-Path: <cygwin-patches-return-3646-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10702 invoked by alias); 28 Feb 2003 05:51:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10693 invoked from network); 28 Feb 2003 05:51:21 -0000
Message-Id: <3.0.5.32.20030228004959.007ff8b0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Fri, 28 Feb 2003 05:51:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: access () and path.cc
In-Reply-To: <20030228051131.GB23995@redhat.com>
References: <3.0.5.32.20030227235437.0080a480@incoming.verizon.net>
 <3.0.5.32.20030227230453.007d3a60@mail.attbi.com>
 <3.0.5.32.20030227230453.007d3a60@mail.attbi.com>
 <3.0.5.32.20030227235437.0080a480@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00295.txt.bz2

OK, following Chris' remarks here is a much smaller set
of changes.

Pierre


2003-02-28  Pierre Humblet  <pierre.humblet@ieee.org>

	* syscalls.cc (fstat64): Pass get_name () to pc.
	(access): Pass fn to stat_worker. 

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.246
diff -u -p -r1.246 syscalls.cc
--- syscalls.cc 21 Feb 2003 14:29:18 -0000      1.246
+++ syscalls.cc 28 Feb 2003 05:46:09 -0000
@@ -1013,7 +1013,7 @@ fstat64 (int fd, struct __stat64 *buf)
     res = -1;
   else
     {
-      path_conv pc (cfd->get_win32_name (), PC_SYM_NOFOLLOW);
+      path_conv pc (cfd->get_name (), PC_SYM_NOFOLLOW);
       memset (buf, 0, sizeof (struct __stat64));
       res = cfd->fstat (buf, &pc);
       if (!res && cfd->get_device () != FH_SOCKET)
@@ -1200,7 +1200,7 @@ access (const char *fn, int flags)
     return check_file_access (real_path, flags);
 
   struct __stat64 st;
-  int r = stat_worker (real_path, &st, 0);
+  int r = stat_worker (fn, &st, 0);
   if (r)
     return -1;
   r = -1;


