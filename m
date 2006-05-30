Return-Path: <cygwin-patches-return-5882-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 792 invoked by alias); 30 May 2006 21:12:28 -0000
Received: (qmail 782 invoked by uid 22791); 30 May 2006 21:12:28 -0000
X-Spam-Check-By: sourceware.org
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 30 May 2006 21:12:25 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.37]) 	(authenticated bits=0) 	by main.electric-cloud.com (8.13.1/8.13.1) with ESMTP id k4ULCNq8012447 	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO) 	for <cygwin-patches@cygwin.com>; Tue, 30 May 2006 14:12:23 -0700
Subject: [Patch] Updating cygwin_dll_init()
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain
Date: Tue, 30 May 2006 21:12:00 -0000
Message-Id: <1149023542.4152.29.camel@fulgurite>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27)
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00070.txt.bz2

The recent change (on 2006-05-24) to _dll_crt0() calls dll_crt0_1()
via _cygtls::call() instead of calling it directly.  The call in
_cygtls::call2() to ExitThread() means that anyone using
cygwin_dll_init() will find that their main thread suddenly exits
instead of returning control to the caller of cygwin_dll_init().

This fix unrolls _dll_crt0 into cygwin_dll_init() and leaves it up
to the caller of cygwin_dll_init() to provide a pointer to the
padding.

ChangeLog for winsup/cygwin:

2006-05-30  Max Kaehn  <slothman@electric-cloud.com>

	* dcrt0.cc (cygwin_dll_init):  unroll _dll_crt0() into the
	function and call _cygtls::init_thread() and dll_crt0_1()
	directly, to avoid the ExitThread() call in _cygtls::call2().


ChangeLog for winsup/testsuite:

2006-05-30      Max Kaehn <slothman@electric-cloud.com>

        * winsup.api/cygload.h:
        * winsup.api/cygload.cc:  Add get() method for a pointer
        to the padding data, and pass that pointer to
         cygwin_dll_init().

2006-05-24      Max Kaehn <slothman@electric-cloud.com>

        * winsup.api/cygload.h:  Increase padding size to
        16384 bytes.


Index: winsup/cygwin/dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.307
diff -u -p -r1.307 dcrt0.cc
--- winsup/cygwin/dcrt0.cc      28 May 2006 15:50:13 -0000      1.307
+++ winsup/cygwin/dcrt0.cc      30 May 2006 19:54:17 -0000
@@ -984,10 +984,10 @@ dll_crt0 (per_process *uptr)
    unload cygwin1.dll, as it is used for _my_tls.  It is best to load
    cygwin1.dll before spawning any additional threads in your process.

-   See winsup/testsuite/cygload for an example of how to use cygwin1.dll
-   from MSVC and non-cygwin MinGW applications.  */
+   See winsup/testsuite/winsup.api/cygload for an example of how to use
+   cygwin1.dll from MSVC and non-cygwin MinGW applications.  */
 extern "C" void
-cygwin_dll_init ()
+cygwin_dll_init (void *padding)
 {
   static char **envp;
   static int _fmode;
@@ -997,7 +997,20 @@ cygwin_dll_init ()
   user_data->envptr = &envp;
   user_data->fmode_ptr = &_fmode;

-  _dll_crt0 ();
+  if (padding == NULL) {
+    /* Don't break code from 1.5.18 and 1.5.19. */
+    padding = &_my_tls;
+  }
+
+  /* Everything from this point onward needs to mirror _dll_crt0(), but must
+   * call dll_crt0_1() directly.
+   */
+  main_environ = user_data->envptr;
+  __sinit (_impure_ptr);
+
+  _main_tls = &_my_tls;
+  _main_tls->init_thread(padding, NULL);
+  dll_crt0_1(NULL, padding);
 }

 extern "C" void

Index: winsup/testsuite/winsup.api/cygload.cc
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/cygload.cc,v
retrieving revision 1.1
diff -u -p -r1.1 cygload.cc
--- winsup/testsuite/winsup.api/cygload.cc      2 Jan 2006 06:15:58 -0000      1.1
+++ winsup/testsuite/winsup.api/cygload.cc      30 May 2006 19:54:18 -0000
@@ -126,6 +126,12 @@ cygwin::padding::check ()
          << ".  Stack variables could be overwritten!" << endl;
 }

+void *
+cygwin::padding::get()
+{
+    return _main->_padding;
+}
+
 cygwin::connector::connector (const char *dll)
 {
   // This will throw if padding is not in place.
@@ -145,9 +151,9 @@ cygwin::connector::connector (const char
   // * spawn the cygwin signal handling thread from sigproc_init()
   // * initialize the thread-local storage for this thread and overwrite
   //   the first 4K of the stack
-  void (*cyginit) ();
+  void (*cyginit) (void *);
   get_symbol ("cygwin_dll_init", cyginit);
-  (*cyginit) ();
+  (*cyginit) (cygwin::padding::get());

   *out << "Loading symbols..." << endl;

Index: winsup/testsuite/winsup.api/cygload.h
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/cygload.h,v
retrieving revision 1.1
diff -u -p -r1.1 cygload.h
--- winsup/testsuite/winsup.api/cygload.h       2 Jan 2006 06:15:58 -0000      1.1
+++ winsup/testsuite/winsup.api/cygload.h       30 May 2006 19:54:18 -0000
@@ -59,14 +59,17 @@ namespace cygwin
     // Verifies that padding has been declared.
     static void check ();

+    static void *get ();
+
   private:
     std::vector< char > _backup;
     char *_stackbase, *_end;

-    // gdb reports sizeof(_cygtls) == 3964 at the time of this writing.
+    // gdb reports sizeof(_cygtls) == 4212 at the time of this writing,
+    // and CYGTLS_PADSIZE = 3 * sizeof(_cygtls).
     // This is at the end of the object so it'll be toward the bottom
     // of the stack when it gets declared.
-    char _padding[8192];
+    char _padding[16384];

     static padding *_main;
     static DWORD _mainTID;

