Return-Path: <cygwin-patches-return-7979-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7582 invoked by alias); 2 May 2014 13:40:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7559 invoked by uid 89); 2 May 2014 13:40:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: smtp.smtpout.orange.fr
Received: from smtp02.smtpout.orange.fr (HELO smtp.smtpout.orange.fr) (80.12.242.124) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 02 May 2014 13:40:37 +0000
Received: from [192.168.1.2] ([92.155.186.238])	by mwinf5d49 with ME	id x1gZ1n00A592dTw031gaji; Fri, 02 May 2014 15:40:35 +0200
X-ME-Helo: [192.168.1.2]
X-ME-Auth: em9zcm90aGtvQHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 May 2014 15:40:35 +0200
X-ME-IP: 92.155.186.238
Message-ID: <5363A041.50704@orange.fr>
Date: Fri, 02 May 2014 13:40:00 -0000
From: zosrothko <zosrothko@orange.fr>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: stdio.h patches for g++ -std=c++11
Content-Type: multipart/mixed; boundary="------------060106050908050306030202"
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00002.txt.bz2

This is a multi-part message in MIME format.
--------------060106050908050306030202
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-length: 588

Hi

This is a patch for exposing the new stdio functions added by the c++11 
standard. Without this patch the snprintf for example is not exposed as

$ cat hello.cpp
#include <cstdio>

int main(int argc, char** argv) {
char buf[24];
snprintf(buf, 2, "", 2);
return 0;
}

$ g++ -std=c++11 hello.cpp
hello.cpp: In function int main(int, char**):
hello.cpp:4:30: erreur: snprintf was not declared in this scope
snprintf("", 2, "", 2);

$ g++ -xc++ -std=c++11 -dM -E - < /dev/null | sort | grep ANSI
#define __STRICT_ANSI__ 1

$ g++ -dM -E - < /dev/null | sort | grep ANSI

$

Regards




--------------060106050908050306030202
Content-Type: text/plain; charset=windows-1252;
 name="stdio.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="stdio.h.patch"
Content-length: 1327

Index: newlib/libc/include/stdio.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/stdio.h,v
retrieving revision 1.68
diff -u -r1.68 stdio.h
--- newlib/libc/include/stdio.h	6 Jan 2014 20:59:38 -0000	1.68
+++ newlib/libc/include/stdio.h	2 May 2014 13:18:04 -0000
@@ -232,6 +232,23 @@
 off_t	_EXFUN(ftello, ( FILE *));
 #endif
 #endif
+
+#if !defined(__STRICT_ANSI__) || (__cplusplus >= 201103L)
+#ifndef _REENT_ONLY
+int	_EXFUN(snprintf, (char *__restrict, size_t, const char *__restrict, ...)
+               _ATTRIBUTE ((__format__ (__printf__, 3, 4))));
+int	_EXFUN(vfscanf, (FILE *__restrict, const char *__restrict, __VALIST)
+               _ATTRIBUTE ((__format__ (__scanf__, 2, 0))));
+int	_EXFUN(vscanf, (const char *, __VALIST)
+               _ATTRIBUTE ((__format__ (__scanf__, 1, 0))));
+int	_EXFUN(vsnprintf, (char *__restrict, size_t, const char *__restrict, __VALIST)
+               _ATTRIBUTE ((__format__ (__printf__, 3, 0))));
+int	_EXFUN(vsscanf, (const char *__restrict, const char *__restrict, __VALIST)
+               _ATTRIBUTE ((__format__ (__scanf__, 2, 0))));
+#endif /* !_REENT_ONLY */
+#endif
+
+
 #if !defined(__STRICT_ANSI__) || (__STDC_VERSION__ >= 199901L)
 #ifndef _REENT_ONLY
 int	_EXFUN(asiprintf, (char **, const char *, ...)

--------------060106050908050306030202--
