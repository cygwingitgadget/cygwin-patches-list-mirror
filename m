Return-Path: <cygwin-patches-return-4015-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15455 invoked by alias); 17 Jul 2003 04:07:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15445 invoked from network); 17 Jul 2003 04:07:35 -0000
Message-Id: <3.0.5.32.20030717000711.008162b0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Thu, 17 Jul 2003 04:07:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: mmsystem.h patch
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00031.txt.bz2

As per

<http://www.winehq.com/hypermail/wine-patches/2003/01/0033.html>
and (slight difference)
<http://csislabs.palomar.edu/Student/dx81/DXSDK/samples/Multimedia/DirectSho
w/BaseClasses/readme.txt>
and thread
<http://www.aewnet.com/newsgroups/rnews.asp?newsid=105001&group=9>


2003-07-17  Pierre Humblet  <pierre.humblet@ieee.org>

	* include/mmsystem.h: Add TIME_KILL_SYNCHRONOUS.

 

Index: mmsystem.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/mmsystem.h,v
retrieving revision 1.4
diff -u -p -r1.4 mmsystem.h
--- mmsystem.h  27 Jan 2003 23:11:13 -0000      1.4
+++ mmsystem.h  17 Jul 2003 03:51:51 -0000
@@ -382,6 +382,7 @@ extern "C" {
 #define TIME_CALLBACK_FUNCTION 0
 #define TIME_CALLBACK_EVENT_SET 16
 #define TIME_CALLBACK_EVENT_PULSE 32
+#define TIME_KILL_SYNCHRONOUS 0x0100
 #define JOYERR_NOERROR (0)
 #define JOYERR_PARMS (JOYERR_BASE+5)
 #define JOYERR_NOCANDO (JOYERR_BASE+6)
