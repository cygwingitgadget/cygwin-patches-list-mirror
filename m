Return-Path: <cygwin-patches-return-4783-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30143 invoked by alias); 24 May 2004 04:16:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30132 invoked from network); 24 May 2004 04:16:23 -0000
From: John Paul Wallington <jpw@gnu.org>
To: cygwin-patches@cygwin.com
Subject: ssp.c (usage): Add missing linefeed.
X-Attribution: jpw
Message-Id: <E1BS6oZ-00009G-00@sol.shootybangbang.com>
Date: Mon, 24 May 2004 04:16:00 -0000
X-SW-Source: 2004-q2/txt/msg00135.txt.bz2

2004-05-24  John Paul Wallington  <jpw@gnu.org>

	* ssp.c (usage): Add missing linefeed.

--- ssp.c	14 Feb 2004 19:43:07 +0000	1.8
+++ ssp.c	24 May 2004 05:09:52 +0100	
@@ -801,7 +801,7 @@ usage (FILE * stream)
     "	ssp -v -s -l -d 0x61001000 0x61080000 hello.exe\n"
     "\n");
   if (stream == stderr)
-    fprintf (stream, "Try '%s --help' for more information.", prog_name);
+    fprintf (stream, "Try '%s --help' for more information.\n", prog_name);
   exit (stream == stderr ? 1 : 0);
 }
