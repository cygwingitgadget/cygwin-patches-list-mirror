Return-Path: <cygwin-patches-return-5451-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17225 invoked by alias); 17 May 2005 22:50:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16660 invoked from network); 17 May 2005 22:50:04 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 17 May 2005 22:50:04 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DYAsw-00079j-7k
	for cygwin-patches@cygwin.com; Tue, 17 May 2005 22:49:58 +0000
Message-ID: <428A7520.7FD9925C@dessent.net>
Date: Tue, 17 May 2005 22:50:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] gcc4 fixes
Content-Type: multipart/mixed;
 boundary="------------95319D3EDC1CD4E1C4D739AA"
X-SW-Source: 2005-q2/txt/msg00047.txt.bz2

This is a multi-part message in MIME format.
--------------95319D3EDC1CD4E1C4D739AA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 750


This is just a trivial change of argument to execl() testcases, which
supresses the warning 'missing sentinel in function call' in gcc4 that
causes the tests to fail.

winsup/testsuite
2005-05-17  Brian Dessent  <brian@dessent.net>

	* winsup.api/signal-into-win32-api.c (main): Use 'NULL' instead
	of '0' in argument list to avoid compiler warning with gcc4.
	* winsup.api/ltp/execle01.c (main): Ditto.
	* winsup.api/ltp/execlp01.c (main): Ditto.
	* winsup.api/ltp/fcntl07.c (do_exec): Ditto.
	* winsup.api/ltp/fcntl07B.c (do_exec): Ditto.

This fixes the problem of mmap() not working with gcc4.

winsup/cygwin
2005-05-17  Brian Dessent  <brian@dessent.net>

	* mmap.cc (mmap64): Move 'granularity' into file scope so that
	it will be initialized.
--------------95319D3EDC1CD4E1C4D739AA
Content-Type: text/plain; charset=us-ascii;
 name="testsuite-warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testsuite-warnings.patch"
Content-length: 3374

Index: winsup.api/signal-into-win32-api.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/signal-into-win32-api.c,v
retrieving revision 1.3
diff -u -p -r1.3 signal-into-win32-api.c
--- winsup.api/signal-into-win32-api.c	23 Jan 2003 21:21:28 -0000	1.3
+++ winsup.api/signal-into-win32-api.c	17 May 2005 20:12:57 -0000
@@ -37,7 +37,7 @@ main (int argc, char** argv)
       return 2;
     }
   else if (pid == 0)
-    execl ( argv[0], argv[0], "child", 0 );
+    execl ( argv[0], argv[0], "child", (char *)NULL );
   else
     {
       sleep_stage = 0;
Index: winsup.api/ltp/execle01.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/execle01.c,v
retrieving revision 1.3
diff -u -p -r1.3 execle01.c
--- winsup.api/ltp/execle01.c	24 Jan 2003 01:09:39 -0000	1.3
+++ winsup.api/ltp/execle01.c	17 May 2005 20:12:57 -0000
@@ -172,7 +172,7 @@ main(int ac, char **av)
 	 */
 	switch(pid=fork()) {
 	case 0: 	/* CHILD - Call execle(2) */
-	    execle("test", "test", 0, environ);
+	    execle("test", "test", (char *)NULL, environ);
 	    /* should not get here!! if we do, the parent will fail the Test Case */
 	    exit(errno);	
 	case -1:	/* ERROR!!! exit now!!*/
Index: winsup.api/ltp/execlp01.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/execlp01.c,v
retrieving revision 1.3
diff -u -p -r1.3 execlp01.c
--- winsup.api/ltp/execlp01.c	24 Jan 2003 01:09:39 -0000	1.3
+++ winsup.api/ltp/execlp01.c	17 May 2005 20:12:57 -0000
@@ -171,7 +171,7 @@ main(int ac, char **av)
 	 */
 	switch(pid=fork()) {
 	case 0: 	/* CHILD - Call execlp(2) */
-	    execlp("/usr/bin/test", "/usr/bin/test", 0);
+	    execlp("/usr/bin/test", "/usr/bin/test", (char *)NULL);
 	    /* should not get here!! if we do, the parent will fail the Test Case */
 	    exit(errno);	
 	case -1:	/* ERROR!!! exit now!!*/
Index: winsup.api/ltp/fcntl07.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/fcntl07.c,v
retrieving revision 1.3
diff -u -p -r1.3 fcntl07.c
--- winsup.api/ltp/fcntl07.c	24 Jan 2003 01:09:39 -0000	1.3
+++ winsup.api/ltp/fcntl07.c	17 May 2005 20:12:57 -0000
@@ -375,7 +375,7 @@ do_exec(const char *prog, int fd, const 
     case -1:
 	return(-1);
     case 0:				/* child */
-	execlp(prog, openck, "-T", pidname, 0);
+	execlp(prog, openck, "-T", pidname, (char *)NULL);
 
 	/* the ONLY reason to do this is to get the errno printed out */
 	fprintf(stderr, "exec(%s, %s, -T, %s) failed.  Errno %s [%d]\n",
Index: winsup.api/ltp/fcntl07B.c
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/ltp/fcntl07B.c,v
retrieving revision 1.3
diff -u -p -r1.3 fcntl07B.c
--- winsup.api/ltp/fcntl07B.c	24 Jan 2003 01:09:39 -0000	1.3
+++ winsup.api/ltp/fcntl07B.c	17 May 2005 20:12:57 -0000
@@ -374,7 +374,7 @@ do_exec(const char *prog, int fd, const 
     case -1:
 	return(-1);
     case 0:				/* child */
-	execlp(prog, openck, "-T", pidname, 0);
+	execlp(prog, openck, "-T", pidname, (char *)NULL);
 
 	/* the ONLY reason to do this is to get the errno printed out */
 	fprintf(stderr, "exec(%s, %s, -T, %s) failed.  Errno %s [%d]\n",



--------------95319D3EDC1CD4E1C4D739AA
Content-Type: text/plain; charset=us-ascii;
 name="mmap-gcc4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmap-gcc4.patch"
Content-length: 732

Index: mmap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mmap.cc,v
retrieving revision 1.109
diff -u -r1.109 mmap.cc
--- mmap.cc	2 May 2005 03:50:07 -0000	1.109
+++ mmap.cc	17 May 2005 22:40:14 -0000
@@ -500,14 +500,14 @@
     }
 }
 
+static DWORD granularity = getshmlba ();
+
 extern "C" void *
 mmap64 (void *addr, size_t len, int prot, int flags, int fd, _off64_t off)
 {
   syscall_printf ("addr %x, len %u, prot %x, flags %x, fd %d, off %D",
 		  addr, len, prot, flags, fd, off);
 
-  static DWORD granularity = getshmlba ();
-
   /* Error conditions according to SUSv2 */
   if (off % getpagesize ()
       || (!(flags & MAP_SHARED) && !(flags & MAP_PRIVATE))


--------------95319D3EDC1CD4E1C4D739AA--
