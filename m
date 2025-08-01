Return-Path: <SRS0=KgIy=2N=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 02B6B3858D1E
	for <cygwin-patches@cygwin.com>; Fri,  1 Aug 2025 17:31:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 02B6B3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 02B6B3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1754069482; cv=none;
	b=ZFrM3qmubAkb5ln+/30Mp4aBmkOxqSAfayzYYFhVDHHitekvImVv5UK3PGKPdR47lc3Ih4J3YuXrHevwIvixo1fvUt4oZxEsZqQOzsD6dBxwqqiDvII5VdX7NiaDr3wdke/Hi70cftybcQflkCaIiBzAK5c0naHdhkLziSx4E4A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1754069482; c=relaxed/simple;
	bh=m1qi5JmIwER1WlQ2EJw3JfUbZMkT1LuiRn6I49cxxpE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=h4WkQ3L4PC1El0ywf/xN5Dx4IRi1hw4odkuadUHdazxonwWpdUsiTvGoFCboytxhTeMagcP6mEiwPDfZpHbU7YSW4xThCp/gEFEEf8O4tx1+PUgYRsV96mCgVs/IS2ROfVT1sqdT74nIZZRzF5xCevHyCJrPcYpPnUx3Ilv8MmY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 02B6B3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=NswU6JJY
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9EDD045CE5
	for <cygwin-patches@cygwin.com>; Fri, 01 Aug 2025 13:31:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=8R4bFFjvdDfAB11jHIBYStb15yw=; b=NswU6
	JJYdm/cnm/Eo8jpr1do7gA1OhkL02ftgsh0JLImhcfx/B9evc0VjoFMsACSJFMGN
	x8MDQNWNG205r6Id4QM+sEBrdjI/i/zsUJBfTHKxCJ4mIH3CeCol8Yqg6gg50rcg
	4gTSShIOBmkvBt6HbzMCYFoMOgaiaiAswCc39A=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 840D045CE1
	for <cygwin-patches@cygwin.com>; Fri, 01 Aug 2025 13:31:21 -0400 (EDT)
Date: Fri, 1 Aug 2025 10:31:21 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
In-Reply-To: <aIyOTd5ANkQdDjwz@calimero.vinschen.de>
Message-ID: <a69fc7a1-0dd9-5f86-8b50-c5b3785cd2c6@jdrake.com>
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com> <aIoOKpzb557bX0cE@calimero.vinschen.de> <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com> <aItALodM1WC7KP_C@calimero.vinschen.de> <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
 <aIvTxi4eB6kmuT-j@calimero.vinschen.de> <a5299499-c6ee-598a-dca4-f7a6bbedeb07@jdrake.com> <aIx0IV_Nl2DboOTS@calimero.vinschen.de> <aIyOTd5ANkQdDjwz@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 1 Aug 2025, Corinna Vinschen wrote:

> On Aug  1 10:00, Corinna Vinschen wrote:
> > On Jul 31 14:05, Jeremy Drake via Cygwin-patches wrote:
> > > 3) running from dynamically loaded DLL's startup
> > >   newu would contain values from exe's startup, not zero, so would always
> > >   write the new pointers to cxx_malloc, memory corruption.
> >

Duh,
  /* Likewise for the C++ memory operators, if any, but not if we
     were dlopen()'d, as we might get dlclose()'d and that would
     leave stale function pointers behind.    */
  if (newu && newu->cxx_malloc && !__dynamically_loaded)
    {

> Ah, ok, but then again, in this case a check against the actual version
> instead of checking just against != 0 should do it, shouldn't it?

That's better for readability I think.  I'll prepare a patch based on your
suggestion


> Like this:
>
> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index 69c233c24759..a272208139ab 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -724,6 +724,14 @@ dll_crt0_0 ()
>    lock_process::init ();
>    user_data->impure_ptr = _impure_ptr;
>    user_data->impure_ptr_ptr = &_impure_ptr;
> +  /* DLL version info is used by newer _cygwin_crt0_common to handle
> +     certain issues in a forward compatible way.  _cygwin_crt0_common
> +     overwrites these values with the application's version info at the
> +     time of building the app, as usual. */
> +  user_data->dll_major = cygwin_version.dll_major;
> +  user_data->dll_minor = cygwin_version.dll_minor;
> +  user_data->api_major = cygwin_version.api_major;
> +  user_data->api_minor = cygwin_version.api_minor;
>
>    DuplicateHandle (GetCurrentProcess (), GetCurrentThread (),
>  		   GetCurrentProcess (), &hMainThread,
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
> index f3321020f72e..00eedeb27ab4 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -36,6 +36,9 @@ details. */
>  #define CYGWIN_VERSION_CHECK_FOR_EXTRA_TM_MEMBERS \
>    (CYGWIN_VERSION_USER_API_VERSION_COMBINED >= 272)
>
> +#define CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS(u) \
> +  (CYGWIN_VERSION_PER_PROCESS_API_VERSION_COMBINED (u) >= 359)
> +
>  /* API_MAJOR 0.0: Initial version.  API_MINOR changes:
>      1: Export cygwin32_ calls as cygwin_ as well.
>      2: Export j1, jn, y1, yn.
> diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
> index 5900e6315dbe..312cba5756c0 100644
> --- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
> +++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
> @@ -124,6 +124,9 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
>  {
>    per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
>    bool uwasnull;
> +  bool new_dll_with_additional_operators =
> +	newu ? CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS (newu)
> +	     : false;
>
>    /* u is non-NULL if we are in a DLL, and NULL in the main exe.
>       newu is the Cygwin DLL's internal per_process and never NULL.  */
> @@ -190,18 +193,21 @@ _cygwin_crt0_common (MainFunc f, per_process *u)


>        CONDITIONALLY_OVERRIDE(oper_new___nt);
>        CONDITIONALLY_OVERRIDE(oper_delete_nt);
>        CONDITIONALLY_OVERRIDE(oper_delete___nt);
> -      CONDITIONALLY_OVERRIDE(oper_delete_sz);
> -      CONDITIONALLY_OVERRIDE(oper_delete___sz);
> -      CONDITIONALLY_OVERRIDE(oper_new_al);
> -      CONDITIONALLY_OVERRIDE(oper_new___al);
> -      CONDITIONALLY_OVERRIDE(oper_delete_al);
> -      CONDITIONALLY_OVERRIDE(oper_delete___al);
> -      CONDITIONALLY_OVERRIDE(oper_delete_sz_al);
> -      CONDITIONALLY_OVERRIDE(oper_delete___sz_al);
> -      CONDITIONALLY_OVERRIDE(oper_new_al_nt);
> -      CONDITIONALLY_OVERRIDE(oper_new___al_nt);
> -      CONDITIONALLY_OVERRIDE(oper_delete_al_nt);
> -      CONDITIONALLY_OVERRIDE(oper_delete___al_nt);
> +      if (new_dll_with_additional_operators)
> +	{
> +	  CONDITIONALLY_OVERRIDE(oper_delete_sz);
> +	  CONDITIONALLY_OVERRIDE(oper_delete___sz);
> +	  CONDITIONALLY_OVERRIDE(oper_new_al);
> +	  CONDITIONALLY_OVERRIDE(oper_new___al);
> +	  CONDITIONALLY_OVERRIDE(oper_delete_al);
> +	  CONDITIONALLY_OVERRIDE(oper_delete___al);
> +	  CONDITIONALLY_OVERRIDE(oper_delete_sz_al);
> +	  CONDITIONALLY_OVERRIDE(oper_delete___sz_al);
> +	  CONDITIONALLY_OVERRIDE(oper_new_al_nt);
> +	  CONDITIONALLY_OVERRIDE(oper_new___al_nt);
> +	  CONDITIONALLY_OVERRIDE(oper_delete_al_nt);
> +	  CONDITIONALLY_OVERRIDE(oper_delete___al_nt);
> +	}
>        /* Now update the resulting set into the global redirectors.  */
>        *newu->cxx_malloc = __cygwin_cxx_malloc;

CONDITIIONALLY_OVERRIDE macro would need to be adjusted also so that
these are assigned into the newu->cxx_malloc directly, and the wholesale
copy of the struct is not done anymore since that depends on how large the
compiler thinks the struct is.

