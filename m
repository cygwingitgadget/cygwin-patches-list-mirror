Return-Path: <cygwin-patches-return-3554-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30912 invoked by alias); 13 Feb 2003 00:36:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30902 invoked from network); 13 Feb 2003 00:36:46 -0000
Date: Thu, 13 Feb 2003 00:36:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Produce beeps using soundcard
Message-ID: <20030213012822.A20310-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=1.1 required=5.0
	tests=CARRIAGE_RETURNS,SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: *
X-SW-Source: 2003-q1/txt/msg00203.txt.bz2


Hi,
this small patch adds an ability to produce beeps (\a) using soundcard by
MessageBeep() call. It can be enabled by new CYGWIN option winbeep.

Vaclav Haisman

2003-02-13  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
	* environ.cc (windows_beep): New variable declaration.
	(parse_thing): New CYGWIN option.
	* fhandler_console.cc (windows_beep): New variable definition.
	(fhandler_console::write_normal):  Handle the new option.
	* Makefile.in (DLL_IMPORTS): Add libuser32.a for MessageBeep.

Index: cygwin/environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.90
diff -p -U1 -r1.90 environ.cc
--- cygwin/environ.cc	30 Sep 2002 03:05:13 -0000	1.90
+++ cygwin/environ.cc	13 Feb 2003 00:11:23 -0000
@@ -38,2 +38,3 @@ extern int pcheck_case;
 extern int subauth_id;
+extern BOOL windows_beep;
 BOOL reset_com = FALSE;
@@ -523,2 +525,3 @@ static struct parse_thing
   {"tty", {NULL}, set_process_state, NULL, {{0}, {PID_USETTY}}},
+  {"winbeep", {&windows_beep}, justset, NULL, {{FALSE}, {TRUE}}},
   {"winsymlinks", {&allow_winsymlinks}, justset, NULL, {{FALSE}, {TRUE}}},
Index: cygwin/fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.103
diff -p -u -r1.103 fhandler_console.cc
--- cygwin/fhandler_console.cc	4 Feb 2003 03:01:17 -0000	1.103
+++ cygwin/fhandler_console.cc	13 Feb 2003 00:11:38 -0000
@@ -33,6 +33,8 @@ details. */

 #define CONVERT_LIMIT 4096

+BOOL windows_beep;
+
 static BOOL
 cp_convert (UINT destcp, char *dest, UINT srccp, const char *src, DWORD size)
 {
@@ -1406,7 +1408,10 @@ fhandler_console::write_normal (const un
       switch (base_chars[*src])
 	{
 	case BEL:
-	  Beep (412, 100);
+	  if (windows_beep)
+	    MessageBeep ((unsigned)-1);
+	  else
+	    Beep (412, 100);
 	  break;
 	case ESC:
 	  dev_state->state_ = gotesc;
Index: cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.114
diff -p -u -r1.114 Makefile.in
--- cygwin/Makefile.in	24 Jan 2003 03:53:46 -0000	1.114
+++ cygwin/Makefile.in	13 Feb 2003 00:16:14 -0000
@@ -141,7 +141,7 @@ EXTRA_OFILES=$(bupdir1)/libiberty/random

 MALLOC_OFILES=@MALLOC_OFILES@

-DLL_IMPORTS:=$(w32api_lib)/libkernel32.a
+DLL_IMPORTS:=$(w32api_lib)/libkernel32.a $(w32api_lib)/libuser32.a

 # Please maintain this list in sorted order, with maximum files per 80 col line
 DLL_OFILES:=assert.o autoload.o cxx.o cygheap.o cygserver_client.o \
