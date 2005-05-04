Return-Path: <cygwin-patches-return-5421-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15555 invoked by alias); 4 May 2005 00:17:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15516 invoked from network); 4 May 2005 00:17:33 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 4 May 2005 00:17:33 -0000
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DT7T1-0002lZ-4I
	for cygwin-patches@cygwin.com; Wed, 04 May 2005 02:10:19 +0200
Received: from nat.electric-cloud.com ([63.82.0.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Wed, 04 May 2005 02:10:19 +0200
Received: from foo by nat.electric-cloud.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Wed, 04 May 2005 02:10:19 +0200
To: cygwin-patches@cygwin.com
From:  "Usman Muzaffar" <foo@muzaffar.org>
Subject:  [PATCH] fix startup race in shared.cc
Date: Wed, 04 May 2005 00:17:00 -0000
Message-ID: <d593nc$uam$1@sea.gmane.org>
Reply-To:  "Usman Muzaffar" <foo@muzaffar.org>
X-SW-Source: 2005-q2/txt/msg00017.txt.bz2


Still seeing incorrect "version mismatch" messages for processes
starting simultaneously on dual-processor systems; I believe this
patch to the recent locking work in shared.cc fixes the "user shared
memory version" errors I'm seeing.

Thanks,
-Usman



2005-05-03  Usman Muzaffar <foo@muzaffar.org>

* shared.cc (user_shared_initialize): Check for mismatched user
  shared memory version with result from InterlockedExchange to
  avoid startup race.


Index: cygwin/shared.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.94
diff -u -p -r1.94 shared.cc
--- cygwin/shared.cc 30 Apr 2005 17:07:05 -0000 1.94
+++ cygwin/shared.cc 3 May 2005 23:20:02 -0000
@@ -199,8 +199,8 @@ user_shared_initialize (bool reinit)
       /* Initialize the queue of deleted files.  */
       user_shared->delqueue.init ();
     }
-  else if (user_shared->version != USER_VERSION_MAGIC)
-    multiple_cygwin_problem ("user shared memory version", user_shared->version, USER_VERSION_MAGIC);
+  else if (sversion != USER_VERSION_MAGIC)
+    multiple_cygwin_problem ("user shared memory version", sversion, USER_VERSION_MAGIC);
   else if (user_shared->cb != sizeof (*user_shared))
     multiple_cygwin_problem ("user shared memory size", user_shared->cb, sizeof (*user_shared));
   else


