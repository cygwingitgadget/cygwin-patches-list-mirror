Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1ED9D385840D; Thu, 31 Jul 2025 20:36:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1ED9D385840D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753994184;
	bh=gXB3XvRW4IQ6MAA7naopP4nGVjlNnGTOjbxeLI6OrX0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=l3tJt52rZFPPS8q53u+50CFfHkaZ4FyXWR9oW0omgkPuaXvPqeS4Cy4oevSIMNPMv
	 cniB9kMsCq1NNSRj+adZV/LbuREhiHhHdZqtqum/Srhtw4N1nn3cBCzTC/PO0nMMFX
	 Bs4LbK11Kle+5mEbQ+mteZyAZQX3yvPAtRooUkgc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 430E6A80B7A; Thu, 31 Jul 2025 22:36:22 +0200 (CEST)
Date: Thu, 31 Jul 2025 22:36:22 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
Message-ID: <aIvTxi4eB6kmuT-j@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com>
 <aIoOKpzb557bX0cE@calimero.vinschen.de>
 <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com>
 <aItALodM1WC7KP_C@calimero.vinschen.de>
 <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 31 12:05, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 31 Jul 2025, Corinna Vinschen wrote:
> > But I see what you mean and I'm sorry I didn't notice this before, but
> > your patch introduces an API change.  So you should definitely bump
> > CYGWIN_VERSION_API_MINOR in version.h.
> 
> OK.  Should I list all the __wrap functions that are now exported in the
> comment explicitly, or is "Export wrappers for C++14 and C++17 new and
> delete overloads." sufficient?

Yes, that should suffice.

> I noticed that dll_crt0_1 calls check_sanity_and_sync which performs some
> checking on the per_process struct from the application, including if the
> application's api_major is greater than the dll's.  However, this is after
> _cygwin_crt0_common already runs.  I tested by downgrading to
> 3.7.0-0.266 and running an executable that I had built with 267 (but not
> using the new wrappers).  It didn't crash during startup, but it did seem
> to crash after forking (it was doing a posix_spawn).  So maybe the
> api_major check could catch this after the fact but before the corruption
> caused any more issues.

How so?  That would be in the DLL, but you're running an old DLL which
you can't change retroactively.  OTOH, _cygwin_crt0_common already
overwrites memory.

> > Otherwise I don't see how a new app is supposed to know the size of
> > per_process_cxx_malloc of an old DLL.
> 
> I think it's just unsupported.

Yeah, and we should leave it at that.  As long as an old app runs with the
new Cygwin DLL...

> > > The sticking point would be libstdc++-6.dll once it is rebuilt with
> > > the additional --wrap arguments in GCC, because it would define all
> > > the operators and thus be incompatbile with older dll versions.

...and the new libstdc++-6.dll, we're fine.  You wrote that the current
libstdc++-6.dll already uses the newer new/delete calls, right?  Looks
like this works with old DLLs except overloading the operators will have
no result because these operators are unused in libstdc++-6.dll?

I do hope I got that right...

> > Well, the SO version of the new libstdc++ would have to be bumped to 7,
> > i. e., libstdc++-7.dll, that would solve half the problem.
> 
> I hope not.  The SO version of libstdc++ is 6 everywhere, and has been for
> some time.  It's ABI hasn't changed.

Yeah, but the DLL version number doesn't *have* to be the same as the ABI
of the DLL.  If there's a good reason to bump, we can do that and IIRC
(but fuzzy), it wouldn't be the first time.

Oh, wait!  It just occured to me...

We know that old DLLs don't write a value into __cygwin_user_data.api_major
and __cygwin_user_data.api_minor.

But what if the new Cygwin DLL does just that?

Assuming dll_crt0_0 (definitely called prior to _cygwin_crt0_common)
writes the current DLL CYGWIN_VERSION_API_MAJOR and
CYGWIN_VERSION_API_MINOR values into __cygwin_user_data.api_major/minor.

Then _cygwin_crt0_common could check this before api_major/minor are
overwritten with the app version, and then use this info when
performing the CONDITIONALLY_OVERRIDEs.

I created a POC.  Testing is left to the reader ;)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 69c233c24759..82ec8ea9b860 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -724,6 +724,12 @@ dll_crt0_0 ()
   lock_process::init ();
   user_data->impure_ptr = _impure_ptr;
   user_data->impure_ptr_ptr = &_impure_ptr;
+  /* This info is used by newer _cygwin_crt0_common (>= API version
+     0.359) to overwrite the C++ operator wrappers conditionally.
+     _cygwin_crt0_common overwrites the values with the application's
+     version info, as usual. */
+  user_data->api_major = cygwin_version.api_major;
+  user_data->api_minor = cygwin_version.api_minor;
 
   DuplicateHandle (GetCurrentProcess (), GetCurrentThread (),
 		   GetCurrentProcess (), &hMainThread,
diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
index 5900e6315dbe..6b43e5f3d905 100644
--- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
+++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
@@ -124,6 +124,7 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
 {
   per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
   bool uwasnull;
+  bool new_dll_with_additional_operators = false;
 
   /* u is non-NULL if we are in a DLL, and NULL in the main exe.
      newu is the Cygwin DLL's internal per_process and never NULL.  */
@@ -135,6 +136,10 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
       uwasnull = true;	/* Remember for later.  */
     }
 
+  if (newu)
+    new_dll_with_additional_operators = newu->api_major != 0
+					|| newu->api_minor != 0;
+
   /* The version numbers are the main source of compatibility checking.
      As a backup to them, we use the size of the per_process struct.  */
   u->magic_biscuit = sizeof (per_process);
@@ -190,18 +195,21 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
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

Corinna
