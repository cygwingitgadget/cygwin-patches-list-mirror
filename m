Return-Path: <cygwin-patches-return-2194-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9535 invoked by alias); 18 May 2002 14:33:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9510 invoked from network); 18 May 2002 14:33:03 -0000
Message-ID: <15590.26146.494851.534995@bea.com>
Date: Sat, 18 May 2002 07:33:00 -0000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: "Philip Aston" <paston@bea.com>
To: cygwin-patches@cygwin.com
Subject: Correction to w32api/include/pbt.h
X-SW-Source: 2002-q2/txt/msg00178.txt.bz2


2002-05-15  Philip Aston  <phlipa@mail.com>

	* include/pbt.h (PBT_APMRESUMESUSPEND): Correct value is 7.


Index: w32api/include/pbt.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/pbt.h,v
retrieving revision 1.2
diff -u -p -u -r1.2 pbt.h
--- w32api/include/pbt.h	9 Mar 2002 09:04:09 -0000	1.2
+++ w32api/include/pbt.h	15 May 2002 20:18:47 -0000
@@ -11,7 +11,7 @@
 #define PBT_APMSUSPEND 4
 #define PBT_APMSTANDBY 5
 #define PBT_APMRESUMECRITICAL 6
-#define PBT_APMRESUMESUSPEND 8
+#define PBT_APMRESUMESUSPEND 7
 #define PBT_APMRESUMESTANDBY 8
 #define PBTF_APMRESUMEFROMFAILURE 1
 #define PBT_APMBATTERYLOW 9


