Return-Path: <cygwin-patches-return-1757-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31901 invoked by alias); 22 Jan 2002 16:36:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31883 invoked from network); 22 Jan 2002 16:36:12 -0000
Date: Tue, 22 Jan 2002 08:36:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: danny_r_smith_2001@yahoo.co.nz
Subject: [apa3a@yahoo.com: winuser.h Missing macros]
Message-ID: <20020122163646.GG14458@redhat.com>
Mail-Followup-To: cygwin-patches@cygwin.com, danny_r_smith_2001@yahoo.co.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00114.txt.bz2

----- Forwarded message from Andriy Palamarchuk <apa3a@yahoo.com> -----

From: Andriy Palamarchuk <apa3a@yahoo.com>
To: cygwin <cygwin@cygwin.com>
Subject: winuser.h Missing macros
Date: Tue, 22 Jan 2002 07:45:37 -0800 (PST)

I found a few defines which are in Windows docs, but
not in the header file.
I *believe* these defs should exist in the header
file.

I use cygwin v1.3.3 under NT 4.0.

Regards,
Andriy Palamarchuk

----- End forwarded message -----

--- winuser.h.orig	Fri Sep 14 12:06:28 2001
+++ winuser.h	Wed Dec 26 14:36:47 2001
@@ -11,6 +11,7 @@
 #define FVIRTKEY	1
 #define ATF_TIMEOUTON	1
 #define ATF_ONOFFFEEDBACK	2
+#define ATF_AVAILABLE	4
 #define WH_MIN	(-1)
 #define WH_MSGFILTER	(-1)
 #define WH_JOURNALRECORD	0
@@ -1477,6 +1478,7 @@
 #define MKF_MOUSEKEYSON 1
 #define MKF_MODIFIERS 64
 #define MKF_REPLACENUMBERS 128
+#define SERKF_ACTIVE 8
 #define SERKF_AVAILABLE 2
 #define SERKF_INDICATOR 4
 #define SERKF_SERIALKEYSON 1
@@ -1882,7 +1884,7 @@
 	UINT cbSize;
 	DWORD dwFlags;
 	DWORD iTimeOutMSec;
-} ACCESSTIMEOUT;
+} ACCESSTIMEOUT, *LPACCESSTIMEOUT;
 typedef struct tagANIMATIONINFO {
 	UINT cbSize;
 	int iMinAnimate;
