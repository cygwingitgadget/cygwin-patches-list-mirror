Return-Path: <cygwin-patches-return-5956-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8607 invoked by alias); 19 Aug 2006 21:35:15 -0000
Received: (qmail 8597 invoked by uid 22791); 19 Aug 2006 21:35:14 -0000
X-Spam-Check-By: sourceware.org
Received: from smaster4.hi-ho.ne.jp (HELO smaster4.hi-ho.ne.jp) (202.224.159.141)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 19 Aug 2006 21:35:08 +0000
Received: from kit.hi-ho.ne.jp (sproxy35 [192.168.125.211])  by smaster4.hi-ho.ne.jp (hi-ho Mail Server)  with ESMTP id <0J49007CFBV99H@smaster4.hi-ho.ne.jp> for  cygwin-patches@cygwin.com; Sun, 20 Aug 2006 03:11:33 +0900 (JST)
Received: from k7.kit.hi-ho.ne.jp (osk15-p96.flets.hi-ho.ne.jp [220.156.51.96])  by kit.hi-ho.ne.jp	id DSUJ72D0; Sun, 20 Aug 2006 03:11:32 +0900 (JST)
Date: Sat, 19 Aug 2006 21:35:00 -0000
From: Hideki IWAMOTO <h-iwamoto@kit.hi-ho.ne.jp>
Subject: [PATCH] pread bug fix
To: cygwin-patches@cygwin.com
Message-id: <200608191811.AA01438@k7.kit.hi-ho.ne.jp>
MIME-version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00051.txt.bz2

When current file offset is not zero, pread from disk file always fails.


2006-08-20 Hideki Iwamoto  <h-iwamoto@kit.hi-ho.ne.jp>

	* fhandler_disk_file.cc (fhandler_disk_file::pread): Fix comparison
	of return value of lseek.

Index: cygwin/fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.187
diff -u -p -r1.187 fhandler_disk_file.cc
--- cygwin/fhandler_disk_file.cc	10 Aug 2006 08:44:43 -0000	1.187
+++ cygwin/fhandler_disk_file.cc	19 Aug 2006 17:41:53 -0000
@@ -1216,7 +1216,7 @@ fhandler_disk_file::pread (void *buf, si
     {
       size_t tmp_count = count;
       read (buf, tmp_count);
-      if (lseek (curpos, SEEK_SET) == 0)
+      if (lseek (curpos, SEEK_SET) >= 0)
 	res = (ssize_t) tmp_count;
       else
 	res = -1;


----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
