From: Earnie Boyd <earnie_boyd@yahoo.com>
To: CP List <Cygwin-Patches@Cygwin.Com>
Subject: winsup/cygwin/lib/getopt.c -mno-cygwin
Date: Fri, 21 Sep 2001 06:57:00 -0000
Message-id: <3BAB474A.36883B32@yahoo.com>
X-SW-Source: 2001-q3/msg00171.html

I would like to propose the following patch.  If someone has time to
figure out how to not cause Dr. Watson it would be appreciated.  Else,
the error will live until I can get a round tuit.  This patch allows
getopt.c -mno-cygwin to build and link into strace.
2001-09-21  Earnie Boyd  <earnie@SF.net>

	* lib/getopt.c (__progname): Handle special case declaration for 
	__MINGW32__.

Index: lib/getopt.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/lib/getopt.c,v
retrieving revision 1.6
diff -u -3 -p -r1.6 getopt.c
--- getopt.c	2001/09/19 16:24:10	1.6
+++ getopt.c	2001/09/21 13:54:51
@@ -68,10 +68,17 @@ char    *optarg;		/* argument associated
 __weak_alias(getopt_long,_getopt_long)
 #endif
 
-#ifndef __CYGWIN__
-#define __progname __argv[0]
-#else
+#if defined (__CYGWIN__)
 extern char __declspec(dllimport) *__progname;
+#elif defined (__MINGW32__)
+/*FIXME: This still causes Dr. Watson but this change allows getopt.c to build
+  for MinGW so Cygwin can continue to build normally.  Note, the Dr. Watson
+  is normal for Cygwin 1.3.3.
+*/
+extern char **_argv;
+#define __progname _argv[0]
+#else
+#define __progname __argv[0]
 #endif
 
 #define IGNORE_FIRST	(*options == '-' || *options == '+')
