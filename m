From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: [PATCH] Add three new INTERNET_* options for setup.exe
Date: Sat, 01 Apr 2000 17:53:00 -0000
Message-id: <20000401205342.A19737@cygnus.com>
X-SW-Source: 2000-q2/msg00001.html

Ron Parker's setup program needed a couple of new INTERNET_OPTION* defines.
I've added them to w32api/include/wininet.h.

cgf

Index: include/wininet.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/wininet.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 wininet.h
--- wininet.h	2000/02/17 19:38:32	1.1.1.1
+++ wininet.h	2000/04/02 01:51:41
@@ -114,6 +114,9 @@ INTERNET_FLAG_NO_COOKIES|INTERNET_FLAG_N
 #define INTERNET_OPTION_SETTINGS_CHANGED 39
 #define INTERNET_OPTION_VERSION 40
 #define INTERNET_OPTION_USER_AGENT 41
+#define INTERNET_OPTION_END_BROWSER_SESSION 42
+#define INTERNET_OPTION_PROXY_USERNAME 43
+#define INTERNET_OPTION_PROXY_PASSWORD 44
 #define INTERNET_FIRST_OPTION INTERNET_OPTION_CALLBACK
 #define INTERNET_LAST_OPTION INTERNET_OPTION_USER_AGENT
 #define INTERNET_PRIORITY_FOREGROUND 1000
