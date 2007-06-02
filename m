Return-Path: <cygwin-patches-return-6107-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29579 invoked by alias); 2 Jun 2007 14:51:46 -0000
Received: (qmail 29563 invoked by uid 22791); 2 Jun 2007 14:51:46 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout02.sul.t-online.com (HELO mailout02.sul.t-online.com) (194.25.134.17)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 02 Jun 2007 14:51:44 +0000
Received: from fwd33.aul.t-online.de  	by mailout02.sul.t-online.com with smtp  	id 1HuUxA-0003Bd-02; Sat, 02 Jun 2007 16:51:40 +0200
Received: from [10.3.2.2] (TDMXTMZaZe2Rw8hkONhhZqN-EC+Pm4ASq8xgLnZkiqMmf1vrbVQwZ9@[217.235.219.152]) by fwd33.sul.t-online.de 	with esmtp id 1HuUww-0WBGs40; Sat, 2 Jun 2007 16:51:26 +0200
Message-ID: <466183F3.5020900@t-online.de>
Date: Sat, 02 Jun 2007 14:51:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [Patch] "strace ./app.exe" probably runs application from /bin
Content-Type: multipart/mixed;  boundary="------------020100080400070901090600"
X-ID: TDMXTMZaZe2Rw8hkONhhZqN-EC+Pm4ASq8xgLnZkiqMmf1vrbVQwZ9
X-TOI-MSGID: eca7910c-4759-421b-a190-206ef30284dc
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00053.txt.bz2

This is a multi-part message in MIME format.
--------------020100080400070901090600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 757

Running an application with strace from current directory may not work 
as expected.
The "./" is not passed to CreateProcess() and the default app search 
rules apply
(1. strace.exe directory,  2. cwd, ..., 6. PATH)

Therefore, an old version of the same app already installed in /bin may 
be run instead.


Testcase:

$ cd /tmp

$ cp /bin/date.exe ./uname.exe

$ date
Sat Jun  2 16:34:23     2007

$ uname
CYGWIN_NT-5.1

$ ./uname
Sat Jun  2 16:34:24     2007

$ strace -o nul ./uname
CYGWIN_NT-5.1

Workaround:

$ strace -o nul ././uname
Sat Jun  2 16:34:25     2007


The attached patch should fix this.

2007-06-02  Christian Franke <franke@computer.org>

	* strace.cc (create_child): Don't remove current directory
	from application path.


Christian


--------------020100080400070901090600
Content-Type: text/plain;
 name="cygwin-1.5.24-2-strace-path.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.5.24-2-strace-path.patch.txt"
Content-length: 735

--- cygwin-1.5.24-2.orig/winsup/utils/strace.cc	2006-05-24 18:50:50.001000000 +0200
+++ cygwin-1.5.24-2/winsup/utils/strace.cc	2007-06-02 16:04:39.281250000 +0200
@@ -313,7 +313,19 @@ create_child (char **argv)
   BOOL ret;
   DWORD flags;
 
-  *argv = cygpath (*argv, NULL);
+  if (strncmp(*argv, "./", 2) == 0)
+    {
+      // cygpath() removes "./". Add another to avoid that
+      // CreateProcess() uses its application search rules
+      // (1. app dir, 2. cwd, ..., 6. PATH).
+      char arg0[2 + strlen(*argv) + 1];
+      strcpy (arg0, "./");
+      strcpy (arg0+2, *argv);
+      *argv = cygpath (arg0, NULL);
+    }
+  else
+    *argv = cygpath (*argv, NULL);
+
   memset (&si, 0, sizeof (si));
   si.cb = sizeof (si);
 

--------------020100080400070901090600--
