Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CACA13858405; Fri,  1 Aug 2025 09:52:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CACA13858405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1754041935;
	bh=gw0AaJTERLsyEmF3J8sgXO+HXQK7PhRbn5lECwhCNFg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=sk/7GzrKuyxJj4gBXkoIxSZHcMb74Vk7PzABoLSphOzFAgxN5yk2X+lo0iBeV0rgo
	 vwBmLsBFkC4ptQ8Q9uHPZ22ADFRvOIwlQLUFu/5ipIcJOE4YO73pqsbvh3hDTofsMV
	 txkxGqQNevrCPx8+9FdtRI5fZSywKoasiI0/GZ/M=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C976CA805B2; Fri, 01 Aug 2025 11:52:13 +0200 (CEST)
Date: Fri, 1 Aug 2025 11:52:13 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
Message-ID: <aIyOTd5ANkQdDjwz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com>
 <aIoOKpzb557bX0cE@calimero.vinschen.de>
 <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com>
 <aItALodM1WC7KP_C@calimero.vinschen.de>
 <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
 <aIvTxi4eB6kmuT-j@calimero.vinschen.de>
 <a5299499-c6ee-598a-dca4-f7a6bbedeb07@jdrake.com>
 <aIx0IV_Nl2DboOTS@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIx0IV_Nl2DboOTS@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Aug  1 10:00, Corinna Vinschen wrote:
> On Jul 31 14:05, Jeremy Drake via Cygwin-patches wrote:
> > 3) running from dynamically loaded DLL's startup
> >   newu would contain values from exe's startup, not zero, so would always
> >   write the new pointers to cxx_malloc, memory corruption.
> 
> Ah, ok, but then again, in this case a check against the actual version
> instead of checking just against != 0 should do it, shouldn't it?
> 
> E.g.
> 
>   new_dll_with_additional_operators = newu->api_major != 0
>                                       || newu->api_minor >= 359;
> 
> That should be rewritten to a version check macro eventually, but
> it would disable wrapping the new functions depending on the
> executable being too old, even if the just loaded DLL is new enough.
> But that should be ok.  Better than crashing methinks.

Like this:

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 69c233c24759..a272208139ab 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -724,6 +724,14 @@ dll_crt0_0 ()
   lock_process::init ();
   user_data->impure_ptr = _impure_ptr;
   user_data->impure_ptr_ptr = &_impure_ptr;
+  /* DLL version info is used by newer _cygwin_crt0_common to handle
+     certain issues in a forward compatible way.  _cygwin_crt0_common
+     overwrites these values with the application's version info at the
+     time of building the app, as usual. */
+  user_data->dll_major = cygwin_version.dll_major;
+  user_data->dll_minor = cygwin_version.dll_minor;
+  user_data->api_major = cygwin_version.api_major;
+  user_data->api_minor = cygwin_version.api_minor;
 
   DuplicateHandle (GetCurrentProcess (), GetCurrentThread (),
 		   GetCurrentProcess (), &hMainThread,
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index f3321020f72e..00eedeb27ab4 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -36,6 +36,9 @@ details. */
 #define CYGWIN_VERSION_CHECK_FOR_EXTRA_TM_MEMBERS \
   (CYGWIN_VERSION_USER_API_VERSION_COMBINED >= 272)
 
+#define CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS(u) \
+  (CYGWIN_VERSION_PER_PROCESS_API_VERSION_COMBINED (u) >= 359)
+
 /* API_MAJOR 0.0: Initial version.  API_MINOR changes:
     1: Export cygwin32_ calls as cygwin_ as well.
     2: Export j1, jn, y1, yn.
diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
index 5900e6315dbe..312cba5756c0 100644
--- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
+++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
@@ -124,6 +124,9 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
 {
   per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
   bool uwasnull;
+  bool new_dll_with_additional_operators =
+	newu ? CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS (newu)
+	     : false;
 
   /* u is non-NULL if we are in a DLL, and NULL in the main exe.
      newu is the Cygwin DLL's internal per_process and never NULL.  */
@@ -190,18 +193,21 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
       CONDITIONALLY_OVERRIDE(oper_new___nt);
       CONDITIONALLY_OVERRIDE(oper_delete_nt);
       CONDITIONALLY_OVERRIDE(oper_delete___nt);
-      CONDITIONALLY_OVERRIDE(oper_delete_sz);
-      CONDITIONALLY_OVERRIDE(oper_delete___sz);
-      CONDITIONALLY_OVERRIDE(oper_new_al);
-      CONDITIONALLY_OVERRIDE(oper_new___al);
-      CONDITIONALLY_OVERRIDE(oper_delete_al);
-      CONDITIONALLY_OVERRIDE(oper_delete___al);
-      CONDITIONALLY_OVERRIDE(oper_delete_sz_al);
-      CONDITIONALLY_OVERRIDE(oper_delete___sz_al);
-      CONDITIONALLY_OVERRIDE(oper_new_al_nt);
-      CONDITIONALLY_OVERRIDE(oper_new___al_nt);
-      CONDITIONALLY_OVERRIDE(oper_delete_al_nt);
-      CONDITIONALLY_OVERRIDE(oper_delete___al_nt);
+      if (new_dll_with_additional_operators)
+	{
+	  CONDITIONALLY_OVERRIDE(oper_delete_sz);
+	  CONDITIONALLY_OVERRIDE(oper_delete___sz);
+	  CONDITIONALLY_OVERRIDE(oper_new_al);
+	  CONDITIONALLY_OVERRIDE(oper_new___al);
+	  CONDITIONALLY_OVERRIDE(oper_delete_al);
+	  CONDITIONALLY_OVERRIDE(oper_delete___al);
+	  CONDITIONALLY_OVERRIDE(oper_delete_sz_al);
+	  CONDITIONALLY_OVERRIDE(oper_delete___sz_al);
+	  CONDITIONALLY_OVERRIDE(oper_new_al_nt);
+	  CONDITIONALLY_OVERRIDE(oper_new___al_nt);
+	  CONDITIONALLY_OVERRIDE(oper_delete_al_nt);
+	  CONDITIONALLY_OVERRIDE(oper_delete___al_nt);
+	}
       /* Now update the resulting set into the global redirectors.  */
       *newu->cxx_malloc = __cygwin_cxx_malloc;
     }
