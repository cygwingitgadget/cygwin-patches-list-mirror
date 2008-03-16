Return-Path: <cygwin-patches-return-6298-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11335 invoked by alias); 16 Mar 2008 07:24:16 -0000
Received: (qmail 11322 invoked by uid 22791); 16 Mar 2008 07:24:15 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 16 Mar 2008 07:23:46 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JanDc-00007z-Ai 	for cygwin-patches@cygwin.com; Sun, 16 Mar 2008 07:23:44 +0000
Message-ID: <47DCCAFF.36C14CB@dessent.net>
Date: Sun, 16 Mar 2008 07:24:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] normalize_posix_path and c:/foo/bar
Content-Type: multipart/mixed;  boundary="------------73DFA302D33BC70F1FB2471E"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00072.txt.bz2

This is a multi-part message in MIME format.
--------------73DFA302D33BC70F1FB2471E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 401


There's a small buglet in normalize_posix_path in that it doesn't see
c:/foo/bar type paths as being win32 and so it treats them as a relative
path and prepends cwd.  Things go downhill from there.  The testcase
that exposed this was insight failing to load because some of the tcl
parts use win32 paths, but really a reduced testcase is simply
open("c:/cygwin/bin/ls.exe", O_RDONLY) = ENOENT.

Brian
--------------73DFA302D33BC70F1FB2471E
Content-Type: text/plain; charset=us-ascii;
 name="recognise_win32_in_normalize_posix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="recognise_win32_in_normalize_posix.patch"
Content-length: 803

2008-03-16  Brian Dessent  <brian@dessent.net>

	* path.cc (normalize_posix_path): Correctly identify a win32
	path beginning with a drive letter and forward slashes.

 path.cc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.479
diff -u -p -r1.479 path.cc
--- path.cc	12 Mar 2008 16:07:04 -0000	1.479
+++ path.cc	16 Mar 2008 07:18:41 -0000
@@ -253,7 +253,7 @@ normalize_posix_path (const char *src, c
   char *dst_start = dst;
   syscall_printf ("src %s", src);
 
-  if ((isdrive (src) && src[2] == '\\') || *src == '\\')
+  if ((isdrive (src) && (src[2] == '\\' || isslash (src[2]))) || *src == '\\')
     goto win32_path;
 
   tail = dst;

--------------73DFA302D33BC70F1FB2471E--
