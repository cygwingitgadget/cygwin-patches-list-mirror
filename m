Return-Path: <cygwin-patches-return-4911-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6740 invoked by alias); 21 Aug 2004 22:40:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6730 invoked from network); 21 Aug 2004 22:40:36 -0000
Message-Id: <3.0.5.32.20040821183627.008186a0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 21 Aug 2004 22:40:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Truncate
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00063.txt.bz2


This fixes ftruncate64 on 9x.
It now passes all truncate tests in the testsuite.

Pierre

2004-08-22  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (ftruncate64): On 9x, call write with a zero length
	to zero fill when the file is extended.

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.342
diff -u -p -r1.342 syscalls.cc
--- syscalls.cc 3 Aug 2004 14:37:26 -0000       1.342
+++ syscalls.cc 21 Aug 2004 22:28:28 -0000
@@ -1692,6 +1692,9 @@ ftruncate64 (int fd, _off64_t length)
              _off64_t prev_loc = cfd->lseek (0, SEEK_CUR);
 
              cfd->lseek (length, SEEK_SET);
+             /* Fill the space with 0, if needed */
+             if (wincap.has_lseek_bug ())
+               cfd->write (&res, 0);
              if (!SetEndOfFile (h))
                __seterrno ();
              else
