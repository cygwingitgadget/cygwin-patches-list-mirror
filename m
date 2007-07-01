Return-Path: <cygwin-patches-return-6125-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2896 invoked by alias); 1 Jul 2007 08:11:42 -0000
Received: (qmail 2886 invoked by uid 22791); 1 Jul 2007 08:11:42 -0000
X-Spam-Check-By: sourceware.org
Received: from an-out-0708.google.com (HELO an-out-0708.google.com) (209.85.132.244)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 01 Jul 2007 08:11:40 +0000
Received: by an-out-0708.google.com with SMTP id d14so235327and         for <cygwin-patches@cygwin.com>; Sun, 01 Jul 2007 01:11:38 -0700 (PDT)
Received: by 10.100.8.18 with SMTP id 18mr3064001anh.1183277498754;         Sun, 01 Jul 2007 01:11:38 -0700 (PDT)
Received: by 10.100.135.10 with HTTP; Sun, 1 Jul 2007 01:11:38 -0700 (PDT)
Message-ID: <f062943a0707010111o3cf09fddj846a8d89a568cd1f@mail.gmail.com>
Date: Sun, 01 Jul 2007 08:11:00 -0000
From: "Przemek Czerkas" <pczerkas@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] w32api: added CSIDLs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00000.txt.bz2

2007-07-01  Przemek Czerkas  <pczerkas@gmail.com>

	* include/shlobj.h: Added CSIDL_MYMUSIC
	Added CSIDL_MYVIDEO

Index: shlobj.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/shlobj.h,v
retrieving revision 1.46
diff -u -r1.46 shlobj.h
--- shlobj.h	25 Jul 2006 00:22:19 -0000	1.46
+++ shlobj.h	1 Jul 2007 07:40:06 -0000
@@ -157,6 +157,8 @@
 #define CSIDL_SENDTO	9
 #define CSIDL_BITBUCKET	10
 #define CSIDL_STARTMENU	11
+#define CSIDL_MYMUSIC	13
+#define CSIDL_MYVIDEO	14
 #define CSIDL_DESKTOPDIRECTORY	16
 #define CSIDL_DRIVES	17
 #define CSIDL_NETWORK	18
