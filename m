From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Export rand48 functions.
Date: Wed, 14 Feb 2001 23:08:00 -0000
Message-id: <s1slmr8toe2.fsf@jaist.ac.jp>
X-SW-Source: 2001-q1/msg00076.html

The following patch enables rand48 functions provided by newlib.
I've changed the way of initializing the reentrant structure so
other members than _stdin, _stdout and _stderr are initialized
to other than zero as well.

ChangeLog:
2001-02-15  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* cygwin.din: Export rand48 functions.
	* thread.cc (MTinterface::Init): Remove the initialization of
	`reent_data'.
	* dcrt0.cc: Add the initalizer to the declaration of `reent_data'.
	* include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR to 35.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.19
diff -u -p -r1.19 cygwin.din
--- cygwin.din	2001/01/22 15:55:34	1.19
+++ cygwin.din	2001/02/15 06:03:26
@@ -866,6 +866,24 @@ y1
 y1f
 yn
 ynf
+drand48
+_drand48 = drand48
+erand48
+_erand48 = erand48
+jrand48
+_jrand48 = jrand48
+lcong48
+_lcong48 = lcong48
+lrand48
+_lrand48 = lrand48
+mrand48
+_lrand48 = lrand48
+nrand48
+_nrand48 = nrand48
+seed48
+_seed48 = seed48
+srand48
+_srand48 = srand48
 setmode
 _setmode = setmode
 __assertfail
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.15
diff -u -p -r1.15 thread.cc
--- thread.cc	2001/01/08 04:02:01	1.15
+++ thread.cc	2001/02/15 06:03:26
@@ -301,14 +301,6 @@ MTinterface::Init (int forked)
   item->sigmask = NULL;
   item->sigtodo = NULL;
 #endif
-
-  struct _reent *r = _REENT;
-  memset (r, 0, sizeof (struct _reent));
-
-  r->_errno = 0;
-  r->_stdin = &r->__sf[0];
-  r->_stdout = &r->__sf[1];
-  r->_stderr = &r->__sf[2];
 }
 
 ThreadItem *
Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.85
diff -u -p -r1.85 dcrt0.cc
--- dcrt0.cc	2001/01/29 00:46:25	1.85
+++ dcrt0.cc	2001/02/15 06:03:27
@@ -85,7 +85,7 @@ extern "C"
   char ***main_environ;
   /* __progname used in getopt error message */
   char *__progname = NULL;
-  struct _reent reent_data;
+  struct _reent reent_data = _REENT_INIT(reent_data);
   struct per_process __cygwin_user_data =
   {/* initial_sp */ 0, /* magic_biscuit */ 0,
    /* dll_major */ CYGWIN_VERSION_DLL_MAJOR,
@@ -764,6 +764,9 @@ dll_crt0_1 ()
 
   if (!old_title && GetConsoleTitle (title_buf, TITLESIZE))
       old_title = title_buf;
+
+  /* Initialize locale */
+  locale_init ();
 
   /* Allocate fdtab */
   dtable_init ();
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.30
diff -u -p -r1.30 version.h
--- version.h	2001/01/30 23:19:19	1.30
+++ version.h	2001/02/15 06:03:27
@@ -125,10 +125,12 @@ details. */
        32: Export getrlimit/setrlimit
        33: Export setlogmask
        34: Separated out mount table
+       35: Export drand48, erand48, jrand48, lcong48, lrand48,
+           mrand48, nrand48, seed48, and srand48.
      */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 34
+#define CYGWIN_VERSION_API_MINOR 35
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
