Return-Path: <cygwin-patches-return-6656-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5940 invoked by alias); 29 Sep 2009 20:51:02 -0000
Received: (qmail 5916 invoked by uid 22791); 29 Sep 2009 20:51:01 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f183.google.com (HELO mail-qy0-f183.google.com) (209.85.221.183)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 29 Sep 2009 20:50:56 +0000
Received: by qyk13 with SMTP id 13so4284540qyk.18         for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2009 13:50:54 -0700 (PDT)
Received: by 10.224.106.207 with SMTP id y15mr4453610qao.14.1254257454705;         Tue, 29 Sep 2009 13:50:54 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 4sm29352qwe.55.2009.09.29.13.50.53         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Tue, 29 Sep 2009 13:50:53 -0700 (PDT)
Message-ID: <4AC2732D.5090304@users.sourceforge.net>
Date: Tue, 29 Sep 2009 20:51:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] --std=c89 error in sys/signal.h
Content-Type: multipart/mixed;  boundary="------------060801000904020301010207"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00110.txt.bz2

This is a multi-part message in MIME format.
--------------060801000904020301010207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1153

Compiling a file which #include's <sys/signal.h> in C89 mode fails:

$ echo "#include <sys/signal.h>" > test.c
$ gcc -c test.c
$ gcc -c -std=c89 test.c
In file included from /usr/include/sys/signal.h:107,
                  from test.c:1:
/usr/include/cygwin/signal.h:74: error: expected 
specifier-qualifier-list before 'pthread_attr_t'
/usr/include/cygwin/signal.h:80: error: expected 
specifier-qualifier-list before '__uint32_t'
/usr/include/cygwin/signal.h:96: error: expected 
specifier-qualifier-list before 'pid_t'
/usr/include/cygwin/signal.h:270: error: expected ')' before 'int'
In file included from test.c:1:
/usr/include/sys/signal.h:152: error: expected ')' before 'int'

The problem is that both <cygwin/signal.h> and an #ifdef __CYGWIN__ 
section of <sys/signal.h> need those typedefs from <sys/types.h>, but 
the latter is only #include'd #ifdef _POSIX_THREADS, which is off in C89 
mode.

I see two possible solutions:

1) Unconditionally #include <sys/types.h> in <sys/signal.h> (newlib), OR
2) #include <sys/types.h> in <cygwin/signal.h>.

Since this appears to be Cygwin specific, I went for the latter.  Patch 
attached.


Yaakov


--------------060801000904020301010207
Content-Type: text/x-patch;
 name="cygwin-sys-signal-c89.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-sys-signal-c89.patch"
Content-length: 609

2009-09-29  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/cygwin/signal.h: #include <sys/types.h> to fix compilation
	with --std=c89.

Index: include/cygwin/signal.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/signal.h,v
retrieving revision 1.17
diff -u -r1.17 signal.h
--- include/cygwin/signal.h	11 Sep 2008 06:22:31 -0000	1.17
+++ include/cygwin/signal.h	29 Sep 2009 19:28:10 -0000
@@ -14,6 +14,9 @@
 #ifdef __cplusplus
 extern "C" {
 #endif
+
+#include <sys/types.h>
+
 struct _fpstate
 {
   unsigned long cw;

--------------060801000904020301010207--
