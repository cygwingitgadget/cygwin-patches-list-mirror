Return-Path: <cygwin-patches-return-2131-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6774 invoked by alias); 1 May 2002 20:09:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6748 invoked from network); 1 May 2002 20:08:57 -0000
Date: Wed, 01 May 2002 13:09:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: cygwin/types.h includes sys/sysmacros.h patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20020501201444.GA3364@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_nFgdwP/i8+JKti8KjpFIvA)"
User-Agent: Mutt/1.3.24i
X-SW-Source: 2002-q2/txt/msg00115.txt.bz2


--Boundary_(ID_nFgdwP/i8+JKti8KjpFIvA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 161

See the following thread for motivation:

    http://cygwin.com/ml/cygwin-developers/2002-05/msg00000.html

See attached for patch and ChangeLog.

Thanks,
Jason

--Boundary_(ID_nFgdwP/i8+JKti8KjpFIvA)
Content-type: text/plain; charset=us-ascii; NAME=types.h.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=types.h.diff
Content-length: 474

Index: types.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/types.h,v
retrieving revision 1.5
diff -u -p -r1.5 types.h
--- types.h	25 Feb 2002 17:47:51 -0000	1.5
+++ types.h	1 May 2002 19:49:15 -0000
@@ -17,6 +17,8 @@ extern "C"
 #ifndef _CYGWIN_TYPES_H
 #define _CYGWIN_TYPES_H
 
+#include <sys/sysmacros.h>
+
 typedef long __off32_t;
 typedef long long __off64_t;
 #ifdef __CYGWIN_USE_BIG_TYPES__

--Boundary_(ID_nFgdwP/i8+JKti8KjpFIvA)
Content-type: text/plain; charset=us-ascii; NAME=types.h.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=types.h.ChangeLog
Content-length: 115

Wed May  1 16:06:02 2002  Jason Tishler <jason@tishler.net>

	* include/cygwin/types.h: Include <sys/sysmacros.h>.

--Boundary_(ID_nFgdwP/i8+JKti8KjpFIvA)--
