Return-Path: <cygwin-patches-return-5876-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24878 invoked by alias); 24 May 2006 19:59:13 -0000
Received: (qmail 24857 invoked by uid 22791); 24 May 2006 19:59:12 -0000
X-Spam-Check-By: sourceware.org
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 19:59:10 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.37]) 	(authenticated bits=0) 	by main.electric-cloud.com (8.13.1/8.13.1) with ESMTP id k4OJx7B2024390 	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO) 	for <cygwin-patches@cygwin.com>; Wed, 24 May 2006 12:59:07 -0700
Subject: Updating cygload for new CYGTLS_PADSIZE
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain
Date: Wed, 24 May 2006 19:59:00 -0000
Message-Id: <1148500747.4166.7.camel@fulgurite>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27)
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00064.txt.bz2

Some of my coworkers ran into mysterious problems when working
with the latest snapshots of the Cygwin DLL, and I discovered that
CYGTLS_PADSIZE recently grew beyond the expectations of the cygload
test utility.  This should fix it:


2006-05-24	Max Kaehn <slothman@electric-cloud.com>

	* winsup.api/cygload.h:  Increase padding size to
	16384 bytes.



Index: cygload.h
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/cygload.h,v
retrieving revision 1.1
diff -u -p -r1.1 cygload.h
--- cygload.h   2 Jan 2006 06:15:58 -0000       1.1
+++ cygload.h   24 May 2006 19:46:21 -0000
@@ -63,10 +63,11 @@ namespace cygwin
     std::vector< char > _backup;
     char *_stackbase, *_end;

-    // gdb reports sizeof(_cygtls) == 3964 at the time of this writing.
+    // gdb reports sizeof(_cygtls) == 4212 at the time of this writing,
+    // and CYGTLS_PADSIZE = 3 * sizeof(_cygtls).
     // This is at the end of the object so it'll be toward the bottom
     // of the stack when it gets declared.
-    char _padding[8192];
+    char _padding[16384];

     static padding *_main;
     static DWORD _mainTID;

