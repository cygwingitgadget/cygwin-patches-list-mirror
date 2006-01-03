Return-Path: <cygwin-patches-return-5691-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23586 invoked by alias); 3 Jan 2006 15:32:55 -0000
Received: (qmail 23569 invoked by uid 22791); 3 Jan 2006 15:32:54 -0000
X-Spam-Check-By: sourceware.org
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 03 Jan 2006 15:31:06 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43) 	id 1Eto7e-0006gr-GY 	for cygwin-patches@cygwin.com; Tue, 03 Jan 2006 16:30:51 +0100
Received: from eblake.csw.L-3com.com ([128.170.36.44])         by main.gmane.org with esmtp (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Tue, 03 Jan 2006 16:30:50 +0100
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Tue, 03 Jan 2006 16:30:50 +0100
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  Fix readdir version 2
Date: Tue, 03 Jan 2006 15:32:00 -0000
Message-ID:  <loom.20060103T162947-375@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00000.txt.bz2

2006-01-03  Eric Blake  <ebb9@byu.net>

	* dir.cc (readdir_worker): Update saw_dot* flags in version 2.

Index: cygwin/dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.99
diff -u -r1.99 dir.cc
--- cygwin/dir.cc       19 Dec 2005 04:00:41 -0000      1.99
+++ cygwin/dir.cc       3 Jan 2006 15:29:32 -0000
@@ -1,6 +1,6 @@
 /* dir.cc: Posix directory-related routines
 
-   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2006 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -105,6 +105,13 @@
       {
        de->__invalid_d_ino = 0;
        de->__ino32 = 0;
+       if (de->d_name[0] == '.')
+         {
+           if (de->d_name[1] == '\0')
+              dir->__flags |= dirent_saw_dot;
+            else if (de->d_name[1] == '.' && de->d_name[2] == '\0')
+              dir->__flags |= dirent_saw_dot_dot;
+          }
       }
     else
       {



