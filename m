Return-Path: <cygwin-patches-return-6482-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 498 invoked by alias); 6 Apr 2009 20:19:26 -0000
Received: (qmail 485 invoked by uid 22791); 6 Apr 2009 20:19:25 -0000
X-SWARE-Spam-Status: No, hits=-2.8 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from aglcosbs01.cos.agilent.com (HELO aglcosbs01.cos.agilent.com) (192.25.218.35)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 06 Apr 2009 20:19:20 +0000
Received: from mppd (localhost.localdomain [127.0.0.1]) 	by aglcosbs01.cos.agilent.com (Postfix) with ESMTP id 94D44299B6 	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2009 20:19:18 +0000 (GMT)
Received: from cos-us-bh01.cos.agilent.com (cos-us-bh01.cos.agilent.com [130.29.152.243]) 	by aglcosbs01.cos.agilent.com (Postfix) with ESMTP id 8CBB4299B3 	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2009 20:19:18 +0000 (GMT)
Received: from [127.0.0.1] ([141.184.122.176]) by cos-us-bh01.cos.agilent.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Mon, 6 Apr 2009 14:20:01 -0600
Message-ID: <49DA641F.8070901@agilent.com>
Date: Mon, 06 Apr 2009 20:19:00 -0000
From: Earl Chew <earl_chew@agilent.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] fstat() problem in libc/rexec.cc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00024.txt.bz2

The current implementation of rexec() uses fstat() and it seems
to pick up the wrong values for st_mode. As a consequence
the code keeps complaining about the permissions for ~/.netrc
and won't complete successfully.

I don't know enough about the how the re-mapping of stat/stat64
works within cygwin1.dll itself, but changing to fstat64()
like libc/iruserok.c resolves the problem.




winsup/cygwin/Changlog

     * libc/rexec.cc: Use fstat64() instead of fstat().


--- winsup/cygwin/libc/rexec.cc.orig    2009-04-06 12:11:02.046875000 -0700
+++ winsup/cygwin/libc/rexec.cc 2009-04-06 12:12:31.578125000 -0700
@@ -159,7 +159,7 @@
         char myname[INTERNET_MAX_HOST_NAME_LENGTH + 1];
         const char *mydomain;
         int t, i, c, usedefault = 0;
-       struct stat stb;
+       struct __stat64 stb;

         hdir = getenv("HOME");
         if (hdir == NULL)
@@ -218,7 +218,7 @@
                         break;
                 case PASSWD:
                         if ((*aname == 0 || strcmp(*aname, "anonymous")) &&
-                           fstat(fileno(cfile), &stb) >= 0 &&
+                           fstat64(fileno(cfile), &stb) >= 0 &&
                             (stb.st_mode & 077) != 0) {
         warnx("Error: .netrc file is readable by others.");
         warnx("Remove password or make file unreadable by others.");
@@ -230,7 +230,7 @@
                         }
                         break;
                 case ACCOUNT:
-                       if (fstat(fileno(cfile), &stb) >= 0
+                       if (fstat64(fileno(cfile), &stb) >= 0
                             && (stb.st_mode & 077) != 0) {
         warnx("Error: .netrc file is readable by others.");
         warnx("Remove account or make file unreadable by others.");



