Return-Path: <cygwin-patches-return-2854-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3477 invoked by alias); 22 Aug 2002 03:02:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3463 invoked from network); 22 Aug 2002 03:02:41 -0000
Message-ID: <3D645438.D18ECE5@netstd.com>
Date: Wed, 21 Aug 2002 20:02:00 -0000
From: Wu Yongwei <adah@netstd.com>
Organization: Kingnet Security, Inc.
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: timezonevar in time.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00302.txt.bz2

The current /usr/include/time.h requires people to use
"#define timezonevar 1" instead of just "#define timezonevar" before
including <time.h>:

--- time.h.orig	2002-07-06 14:19:00.000000000 +0800
+++ time.h	2002-08-21 21:34:32.000000000 +0800
@@ -109,7 +109,7 @@
 #ifndef daylight
 #define daylight _daylight
 #endif
-#if timezonevar
+#ifdef timezonevar
 #ifndef timezone
 #define timezone ((long int) _timezone)
 #endif

Change Log:

2002-8-21  Wu Yongwei <adah@netstd.com>

	* time.h (timezonevar): Change "#if" to "#ifdef".


Maybe I still have something wrong here, say, not diffing from the CVS
version (but I really did not find it). I am already struggling to do things
right. :-)

Best regards,

Wu Yongwei
