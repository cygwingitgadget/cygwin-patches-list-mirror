From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Added another INTERNET_OPTION
Date: Wed, 26 Apr 2000 08:06:00 -0000
Message-id: <20000426110550.A24633@cygnus.com>
X-SW-Source: 2000-q2/msg00035.html

I've made the following change to w32api/include/wininet.h.

cgf

Wed Apr 26 11:04:18 2000  Christopher Faylor <cgf@cygnus.com>

	* include/wininet.h: Add another "INTERNET_OPTIONS".


--- wininet.h.orig	Sat Apr  1 00:59:31 2000
+++ wininet.h	Tue Apr 25 16:45:14 2000
@@ -47,6 +47,7 @@ extern "C" {
 #define INTERNET_FLAG_RESYNCHRONIZE 0x800
 #define INTERNET_FLAG_HYPERLINK 0x400
 #define INTERNET_FLAG_NO_UI 0x200
+#define INTERNET_FLAG_PRAGMA_NOCACHE 0x100
 #define INTERNET_FLAG_TRANSFER_ASCII FTP_TRANSFER_TYPE_ASCII
 #define INTERNET_FLAG_TRANSFER_BINARY FTP_TRANSFER_TYPE_BINARY
 #define SECURITY_INTERNET_MASK (INTERNET_FLAG_IGNORE_CERT_CN_INVALID|INTERNET_FLAG_IGNORE_CERT_DATE_INVALID|INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS|INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP)
