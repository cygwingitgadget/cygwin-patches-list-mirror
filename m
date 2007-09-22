Return-Path: <cygwin-patches-return-6147-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20838 invoked by alias); 22 Sep 2007 12:48:29 -0000
Received: (qmail 20828 invoked by uid 22791); 22 Sep 2007 12:48:29 -0000
X-Spam-Check-By: sourceware.org
Received: from wish.cooper.edu (HELO wish.cooper.edu) (199.98.16.74)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 22 Sep 2007 12:48:23 +0000
Received: from wish.cooper.edu (farley2.cooper.edu [199.98.16.43]) 	by localhost (Postfix) with SMTP id DBD9613602E5 	for <cygwin-patches@cygwin.com>; Sat, 22 Sep 2007 08:48:21 -0400 (EDT)
Received: from wish.cooper.edu (localhost.localdomain [127.0.0.1]) 	by wish.cooper.edu (Postfix) with ESMTP id B1C9213602E4 	for <cygwin-patches@cygwin.com>; Sat, 22 Sep 2007 08:48:21 -0400 (EDT)
Received: from 71.190.219.188         (SquirrelMail authenticated user lent)         by wish.cooper.edu with HTTP;         Sat, 22 Sep 2007 08:48:21 -0400 (EDT)
Message-ID: <4043.71.190.219.188.1190465301.squirrel@wish.cooper.edu>
Date: Sat, 22 Sep 2007 12:48:00 -0000
Subject: setup.exe's README patched to mention needed packages bison and       flex.
From: lent@cooper.edu
To: cygwin-patches@cygwin.com
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
References:
In-Reply-To:
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00022.txt.bz2

To successfully build setup.exe, after downloading the files via:

$ cvs -z3 -d :pserver:anoncvs@sources.redhat.com:/cvs/cygwin-apps co setup

two additional packages are required.
These packages are bison and flex.

I made a patch to the README.

$ cvs -z3 -d :pserver:anoncvs@sources.redhat.com:/cvs/cygwin-apps diff -uN
>patch.20070922

and the patch is included below.

Hope this helps,
Chris Lent
<lent@cooper.edu>
Adjunct Associate Professor of Computer Science,
Advisor to First-Year Engineering Students,
Manager, Louis and Jeanette Brooks Engineering Design Center (BEDC) Tel:
+1.212.353.4350
---------------------------------------------------------------------------------------------------------


Index: setup/README
=================================================================== RCS
file: /cvs/cygwin-apps/setup/README,v
retrieving revision 2.39
diff -u -r2.39 README
--- setup/README        21 Feb 2007 07:05:18 -0000      2.39
+++ setup/README        22 Sep 2007 11:20:46 -0000
@@ -6,6 +6,8 @@
 -------------
 Setup should build out-of-the-box on any Cygwin environment that has all
the
 required packages installed:
+  - bison
+  - flex
   - gcc-mingw-g++
   - make
   - mingw-zlib






