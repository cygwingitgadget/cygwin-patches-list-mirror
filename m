Return-Path: <cygwin-patches-return-6595-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4002 invoked by alias); 12 Aug 2009 21:19:11 -0000
Received: (qmail 3885 invoked by uid 22791); 12 Aug 2009 21:19:09 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_32,J_CHICKENPOX_52,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f217.google.com (HELO mail-ew0-f217.google.com) (209.85.219.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 12 Aug 2009 21:18:58 +0000
Received: by ewy17 with SMTP id 17so347452ewy.2         for <cygwin-patches@cygwin.com>; Wed, 12 Aug 2009 14:18:54 -0700 (PDT)
Received: by 10.211.194.9 with SMTP id w9mr680206ebp.57.1250111934692;         Wed, 12 Aug 2009 14:18:54 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm1140200eyb.20.2009.08.12.14.18.53         (version=SSLv3 cipher=RC4-MD5);         Wed, 12 Aug 2009 14:18:54 -0700 (PDT)
Message-ID: <4A8334E6.8010808@gmail.com>
Date: Wed, 12 Aug 2009 21:19:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix dlopen vs cxx malloc bug.
Content-Type: multipart/mixed;  boundary="------------070904040908000602010204"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00049.txt.bz2

This is a multi-part message in MIME format.
--------------070904040908000602010204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 921


    Hey gang,

  Here's the patch for the dlopen problem.  I've added perhaps more commenting
than is strictly necessary but this is hairy stuff and we want it to be
comprehensible in the future.  (I've also spent some time writing how-*
documentation and that'll follow shortly.)

winsup/cygwin/ChangeLog:

	* cxx.cc (default_cygwin_cxx_malloc): Enhance commenting.
	* dll_init.cc (dll_dllcrt0_1): Likewise.
	* dlfcn.cc (dlopen): Prevent dlopen()'d DLL from installing any
	cxx malloc overrides.
	* include/cygwin/cygwin_dll.h (__dynamically_loaded): New variable.
	* lib/_cygwin_crt0_common.cc (_cygwin_crt0_common): Check it and only
	install cxx malloc overrides when statically loaded.  Extend comments.

  Tested against a big chunk of the g++ testsuite, and specifically the
malloc-related tests that verify function replacement, and against old testcases
and the dlopen testcase.  Ok?

    cheers,
      DaveK



--------------070904040908000602010204
Content-Type: text/x-c;
 name="cxx-overrides-dlopen-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cxx-overrides-dlopen-fix.diff"
Content-length: 7512

Index: cxx.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cxx.cc,v
retrieving revision 1.6
diff -p -u -r1.6 cxx.cc
--- cxx.cc	4 Aug 2009 04:20:36 -0000	1.6
+++ cxx.cc	12 Aug 2009 21:12:11 -0000
@@ -87,7 +87,10 @@ __cxa_guard_release ()
 }
 
 /* These routines are made available as last-resort fallbacks
-   for the application.  Should not be used in practice.  */
+   for the application.  Should not be used in practice; the
+   entries in this struct get overwritten by each DLL as it
+   is loaded, and libstdc++ will override the whole lot first
+   thing of all.   */
 
 struct per_process_cxx_malloc default_cygwin_cxx_malloc =
 {
Index: dlfcn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dlfcn.cc,v
retrieving revision 1.41
diff -p -u -r1.41 dlfcn.cc
--- dlfcn.cc	16 Apr 2009 16:17:58 -0000	1.41
+++ dlfcn.cc	12 Aug 2009 21:12:11 -0000
@@ -93,7 +93,28 @@ dlopen (const char *name, int)
 	  wchar_t *path = tp.w_get ();
 
 	  pc.get_wide_win32_path (path);
+
+	  /* Workaround for broken DLLs built against Cygwin versions 1.7.0-49
+	     up to 1.7.0-57.  They override the cxx_malloc pointer in their
+	     DLL initialization code even if loaded dynamically.  This is a
+	     no-no since a later dlclose lets cxx_malloc point into nirvana.
+	     The below kludge "fixes" that by reverting the original cxx_malloc
+	     pointer after LoadLibrary.  This implies that their overrides
+	     won't be applied; that's OK.  All overrides should be present at
+	     final link time, as Windows doesn't allow undefined references;
+	     it would actually be wrong for a dlopen'd DLL to opportunistically
+	     override functions in a way that wasn't known then.  We're not
+	     going to try and reproduce the full ELF dynamic loader here!  */
+
+	  /* Store original cxx_malloc pointer. */
+	  struct per_process_cxx_malloc *tmp_malloc;
+	  tmp_malloc = __cygwin_user_data.cxx_malloc;
+
 	  ret = (void *) LoadLibraryW (path);
+
+	  /* Restore original cxx_malloc pointer. */
+	  __cygwin_user_data.cxx_malloc = tmp_malloc;
+
 	  if (ret == NULL)
 	    __seterrno ();
 	}
Index: dll_init.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dll_init.cc,v
retrieving revision 1.64
diff -p -u -r1.64 dll_init.cc
--- dll_init.cc	17 Jul 2009 18:17:11 -0000	1.64
+++ dll_init.cc	12 Aug 2009 21:12:11 -0000
@@ -328,6 +328,26 @@ dll_dllcrt0_1 (VOID *x)
 
   bool linked = !in_forkee && !cygwin_finished_initializing;
 
+  /* Broken DLLs built against Cygwin versions 1.7.0-49 up to 1.7.0-57
+     override the cxx_malloc pointer in their DLL initialization code,
+     when loaded either statically or dynamically.  Because this leaves
+     a stale pointer into demapped memory space if the DLL is unloaded
+     by a call to dlclose, we prevent this happening for dynamically
+     loaded DLLS in dlopen by saving and restoring cxx_malloc around
+     the call to LoadLibrary, which invokes the DLL's startup sequence.
+     Modern DLLs won't even attempt to override the pointer when loaded
+     statically, but will write their overrides directly into the
+     struct it points to.  With all modern DLLs, this will remain the
+     default_cygwin_cxx_malloc struct in cxx.cc, but if any broken DLLs
+     are in the mix they will have overridden the pointer and subsequent
+     overrides will go into their embedded cxx_malloc structs.  This is
+     almost certainly not a problem as they can never be unloaded, but
+     if we ever did want to do anything about it, we could check here to
+     see if the pointer had been altered in the early parts of the DLL's
+     startup, and if so copy back the new overrides and reset it here.
+     However, that's just a note for the record; at the moment, we can't
+     see any need to worry about this happening.  */
+
   /* Partially initialize Cygwin guts for non-cygwin apps. */
   if (dynamically_loaded && user_data->magic_biscuit == 0)
     dll_crt0 (p);
cvs diff: how-cxx-abi.txt is a new entry, no comparison available
Index: include/cygwin/cygwin_dll.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/cygwin_dll.h,v
retrieving revision 1.8
diff -p -u -r1.8 cygwin_dll.h
--- include/cygwin/cygwin_dll.h	11 Sep 2001 20:01:01 -0000	1.8
+++ include/cygwin/cygwin_dll.h	12 Aug 2009 21:12:12 -0000
@@ -33,6 +33,7 @@ CDECL_END								      \
 static HINSTANCE storedHandle;						      \
 static DWORD storedReason;						      \
 static void* storedPtr;							      \
+int __dynamically_loaded;						      \
 									      \
 static int __dllMain (int a, char **b, char **c)			      \
 {									      \
@@ -53,6 +54,7 @@ int WINAPI _cygwin_dll_entry (HINSTANCE 
       storedHandle = h;							      \
       storedReason = reason;						      \
       storedPtr = ptr;							      \
+      __dynamically_loaded = (ptr == NULL);				      \
       dll_index = cygwin_attach_dll (h, &__dllMain);			      \
       if (dll_index == (DWORD) -1)					      \
 	ret = 0;							      \
Index: lib/_cygwin_crt0_common.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/lib/_cygwin_crt0_common.cc,v
retrieving revision 1.17
diff -p -u -r1.17 _cygwin_crt0_common.cc
--- lib/_cygwin_crt0_common.cc	7 Jul 2009 20:12:44 -0000	1.17
+++ lib/_cygwin_crt0_common.cc	12 Aug 2009 21:12:12 -0000
@@ -40,6 +40,9 @@ extern WEAK void operator delete[](void 
 /* Avoid an info message from linker when linking applications.  */
 extern __declspec(dllimport) struct _reent *_impure_ptr;
 
+/* Initialised in _cygwin_dll_entry. */
+extern int __dynamically_loaded;
+
 #undef environ
 
 extern "C"
@@ -70,11 +73,13 @@ _cygwin_crt0_common (MainFunc f, per_pro
   per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
   int uwasnull;
 
+  /* u is non-NULL if we are in a DLL, and NULL in the main exe.
+     newu is the Cygwin DLL's internal per_process and never NULL.  */
   if (u != NULL)
     uwasnull = 0;	/* Caller allocated space for per_process structure.  */
   else
     {
-      u = newu;	/* Using DLL built-in per_process.  */
+      u = newu;		/* Using DLL built-in per_process.  */
       uwasnull = 1;	/* Remember for later.  */
     }
 
@@ -114,8 +119,10 @@ _cygwin_crt0_common (MainFunc f, per_pro
   u->realloc = &realloc;
   u->calloc = &calloc;
 
-  /* Likewise for the C++ memory operators - if any.  */
-  if (newu && newu->cxx_malloc)
+  /* Likewise for the C++ memory operators, if any, but not if we
+     were dlopen()'d, as we might get dlclose()'d and that would
+     leave stale function pointers behind.    */
+  if (newu && newu->cxx_malloc && !__dynamically_loaded)
     {
       /* Inherit what we don't override.  */
 #define CONDITIONALLY_OVERRIDE(MEMBER) \
@@ -129,12 +136,10 @@ _cygwin_crt0_common (MainFunc f, per_pro
       CONDITIONALLY_OVERRIDE(oper_new___nt);
       CONDITIONALLY_OVERRIDE(oper_delete_nt);
       CONDITIONALLY_OVERRIDE(oper_delete___nt);
+      /* Now update the resulting set into the global redirectors.  */
+      *newu->cxx_malloc = __cygwin_cxx_malloc;
     }
 
-  /* Now update the resulting set into the global redirectors.  */
-  if (newu)
-    newu->cxx_malloc = &__cygwin_cxx_malloc;
-
   /* Setup the module handle so fork can get the path name.  */
   u->hmodule = GetModuleHandle (0);
 

--------------070904040908000602010204--
