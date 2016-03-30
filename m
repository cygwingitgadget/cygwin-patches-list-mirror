Return-Path: <cygwin-patches-return-8510-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80714 invoked by alias); 30 Mar 2016 18:54:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80578 invoked by uid 89); 30 Mar 2016 18:54:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=Search, UD:cygwin1.dll, cygwin1.dll, cygwin1dll
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 30 Mar 2016 18:54:10 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLFl-0002Fi-VM; Wed, 30 Mar 2016 20:54:06 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLFk-00025F-IN; Wed, 30 Mar 2016 20:54:05 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 30 Mar 2016 20:54:04 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 2/6] forkables: Track main executable and cygwin1.dll.
Date: Wed, 30 Mar 2016 18:54:00 -0000
Message-Id: <1459364024-24891-3-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q1/txt/msg00216.txt.bz2

In preparation to protect fork() against dll- and exe-updates, even for
the main executable and cygwin1.dll store the file name as full NT path,
and keep handles to the files open for subsequent hardlink creation.
Create the child process using the main executable's file name converted
from the full NT path stored before.

	* dll_init.cc (dll_list::alloc): Search for DLL_SELF type entry
	with module name like for DLL_LINK, use full NT path to search
	for DLL_LOAD type only.  For DLL_SELF type do not indicate
	having a destructor to be called.
	(dll_list::find): Ignore DLL_SELF type entries.
	(dll_list::init): Ditto.  Call track_self method.
	(dll_list::track_self): New.
	(dll_list::load_after_fork): Call track_self method.
	* dll_init.h (enum dll_type): Add DLL_SELF, for the main
	executable and cygwin1.dll.
	(struct dll_list): Declare method track_self.  Declare member
	variable main_executable.
	* fork.cc (frok::parent): Use ntname from dlls.main_executable
	to create child process, converted to short path using
	dll_list::buffered_shortname.
---
 winsup/cygwin/dll_init.cc | 26 ++++++++++++++++++++------
 winsup/cygwin/dll_init.h  |  3 +++
 winsup/cygwin/fork.cc     | 15 ++++++++++++---
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 0494297..fd807c9 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -343,8 +343,9 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
   guard (true);
   /* Already loaded?  For linked DLLs, only compare the basenames.  Linked
      DLLs are loaded using just the basename and the default DLL search path.
-     The Windows loader picks up the first one it finds.  */
-  dll *d = (type == DLL_LINK) ? dlls.find_by_modname (modname) : dlls[ntname];
+     The Windows loader picks up the first one it finds.
+     This also applies to cygwin1.dll and the main-executable (DLL_SELF).  */
+  dll *d = (type != DLL_LOAD) ? dlls.find_by_modname (modname) : dlls[ntname];
   if (d)
     {
       if (!in_forkee)
@@ -380,7 +381,8 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
       wcscpy (d->ntname, ntname);
       d->modname = d->ntname + (modname - ntname);
       d->handle = h;
-      d->has_dtors = true;
+      /* DLL_SELF dtors (main-executable, cygwin1.dll) are run elsewhere */
+      d->has_dtors = type != DLL_SELF;
       d->p = p;
       d->ndeps = 0;
       d->deps = NULL;
@@ -529,7 +531,7 @@ dll_list::find (void *retaddr)
 
   dll *d = &start;
   while ((d = d->next))
-    if (d->handle == h)
+    if (d->type != DLL_SELF && d->handle == h)
       break;
   return d;
 }
@@ -579,11 +581,22 @@ dll_list::detach (void *retaddr)
 void
 dll_list::init ()
 {
+  track_self ();
+
   /* Walk the dll chain, initializing each dll */
   dll *d = &start;
   dll_global_dtors_recorded = d->next != NULL;
   while ((d = d->next))
-    d->init ();
+    if (d->type != DLL_SELF) /* linked and early loaded dlls */
+      d->init ();
+}
+
+void
+dll_list::track_self ()
+{
+  /* for cygwin1.dll and main-executable: maintain hardlinks only */
+  alloc (cygwin_hmodule, user_data, DLL_SELF);
+  main_executable = alloc (GetModuleHandle (NULL), user_data, DLL_SELF);
 }
 
 #define A64K (64 * 1024)
@@ -650,7 +663,7 @@ dll_list::reserve_space ()
 
 /* Reload DLLs after a fork.  Iterates over the list of dynamically loaded
    DLLs and attempts to load them in the same place as they were loaded in the
-   parent. */
+   parent.  Updates main-executable and cygwin1.dll tracking. */
 void
 dll_list::load_after_fork (HANDLE parent)
 {
@@ -662,6 +675,7 @@ dll_list::load_after_fork (HANDLE parent)
   in_load_after_fork = true;
   if (reload_on_fork)
     load_after_fork_impl (parent, dlls.istart (DLL_LOAD), 0);
+  track_self ();
   in_load_after_fork = false;
 }
 
diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
index d4cbd3d..c50f889 100644
--- a/winsup/cygwin/dll_init.h
+++ b/winsup/cygwin/dll_init.h
@@ -43,6 +43,7 @@ struct per_module
 typedef enum
 {
   DLL_NONE,
+  DLL_SELF, /* main-program.exe, cygwin1.dll */
   DLL_LINK,
   DLL_LOAD,
   DLL_ANY
@@ -82,6 +83,7 @@ struct dll
 
 class dll_list
 {
+  void track_self ();
   void set_forkables_inheritance (bool);
 
   dll *end;
@@ -92,6 +94,7 @@ class dll_list
   static WCHAR NO_COPY nt_max_path_buffer[NT_MAX_PATH];
 public:
   /* forkables */
+  dll *main_executable;
   void request_forkables ();
   void release_forkables ();
 
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 4361f58..7bc3dec 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -188,7 +188,7 @@ frok::child (volatile char * volatile here)
 
   MALLOC_CHECK;
 
-  /* load dynamic dlls, if any */
+  /* load dynamic dlls, if any, re-track main-executable and cygwin1.dll */
   dlls.load_after_fork (hParent);
 
   cygheap->fdtab.fixup_after_fork (hParent);
@@ -354,11 +354,20 @@ frok::parent (volatile char * volatile stack_here)
     {
       dlls.request_forkables ();
 
+      PCWCHAR forking_progname = NULL;
+      if (dlls.main_executable)
+        forking_progname = dll_list::buffered_shortname
+			   (dlls.main_executable->ntname);
+      if (!forking_progname || !*forking_progname)
+	forking_progname = myself->progname;
+
       debug_printf ("CreateProcessW (%W, %W, 0, 0, 1, %y, 0, 0, %p, %p)",
-		    myself->progname, myself->progname, c_flags, &si, &pi);
+		    forking_progname, myself->progname, c_flags, &si, &pi);
 
       hchild = NULL;
-      rc = CreateProcessW (myself->progname,	/* image to run */
+      /* cygwin1.dll - linked to shortname dll - may reuse the forking_progname
+	 buffer, even in case of failure: don't reuse forking_progname later */
+      rc = CreateProcessW (forking_progname,	/* image to run */
 			   GetCommandLineW (),	/* Take same space for command
 						   line as in parent to make
 						   sure child stack is allocated
-- 
2.7.3
