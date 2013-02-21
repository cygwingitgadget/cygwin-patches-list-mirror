Return-Path: <cygwin-patches-return-7822-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7637 invoked by alias); 21 Feb 2013 02:38:55 -0000
Received: (qmail 7429 invoked by uid 22791); 21 Feb 2013 02:38:53 -0000
X-SWARE-Spam-Status: No, hits=-4.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f172.google.com (HELO mail-ie0-f172.google.com) (209.85.223.172)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 21 Feb 2013 02:38:48 +0000
Received: by mail-ie0-f172.google.com with SMTP id c10so10680518ieb.17        for <cygwin-patches@cygwin.com>; Wed, 20 Feb 2013 18:38:47 -0800 (PST)
X-Received: by 10.50.163.37 with SMTP id yf5mr11212331igb.102.1361414327662;        Wed, 20 Feb 2013 18:38:47 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id wo8sm17892192igb.6.2013.02.20.18.38.44        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Wed, 20 Feb 2013 18:38:47 -0800 (PST)
Date: Thu, 21 Feb 2013 02:38:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Missing dllimport's in <error.h>
Message-ID: <20130220203828.5216c525@YAAKOV04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/a0w1n/yXsFlnU8Y7Jzrd=+J"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00033.txt.bz2


--MP_/a0w1n/yXsFlnU8Y7Jzrd=+J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 120

The attached patch for HEAD is required for compiling code which uses
<error.h> and -Wl,--disable-auto-import.


Yaakov

--MP_/a0w1n/yXsFlnU8Y7Jzrd=+J
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=cygwin-error-dllimport.patch
Content-length: 993

2013-02-20  Yaakov Selkowitz  <yselkowitz@...>

	* include/error.h (error_message_count): Declare as dllimport.
	(error_one_per_line): Ditto.
	(error_print_progname): Ditto.

Index: include/error.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/error.h,v
retrieving revision 1.1
diff -u -p -r1.1 error.h
--- include/error.h	18 May 2011 01:25:41 -0000	1.1
+++ include/error.h	21 Feb 2013 02:33:32 -0000
@@ -19,9 +19,15 @@ extern "C"
 void error (int, int, const char *, ...);
 void error_at_line (int, int, const char *, unsigned int, const char *, ...);
 
+#ifdef  __INSIDE_CYGWIN__
 extern unsigned int error_message_count;
 extern int error_one_per_line;
 extern void (*error_print_progname) (void);
+#else
+extern __declspec(dllimport) unsigned int error_message_count;
+extern __declspec(dllimport) int error_one_per_line;
+extern __declspec(dllimport) void (*error_print_progname) (void);
+#endif
 
 #ifdef __cplusplus
 }

--MP_/a0w1n/yXsFlnU8Y7Jzrd=+J--
