Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 27F453858D1E; Sat,  2 Aug 2025 16:01:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 27F453858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1754150508;
	bh=JN+XK2eslT5HshFIhtxiewYoxldLtGzHNu4N9b4hH+8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dK/5QJ/9fUs8wTMj1pRyZDMefQqgWN0Jde6fc+hw+DWICQcie4OuGe+HQVex1TkRq
	 /YjhMnN0bQSuzE9PCklfPdege6pucALftQfFoWwwY0N0qUTC34MewjaTchGeg76LL7
	 5LNwtK2xsaj9cpLcsA9BCD6NyJqT/XE1S22DjcK0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0921FA805B2; Sat, 02 Aug 2025 18:01:46 +0200 (CEST)
Date: Sat, 2 Aug 2025 18:01:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add api version check to c++ malloc struct
 override.
Message-ID: <aI42aRxXOsYFOzpq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ff5e8cb0-205b-4d08-7eba-51f112e9619c@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff5e8cb0-205b-4d08-7eba-51f112e9619c@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Aug  1 12:18, Jeremy Drake via Cygwin-patches wrote:
> This prevents memory corruption if a newer app or dll is used with an
> older cygwin dll.  This is an unsupported scenario, but it's still a
> good idea to avoid corrupting memory if possible.
> 
> Fixes: 7d5c55faa1 ("Cygwin: add wrappers for newer new/delete overloads")
> Co-authored-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> 
> I left out initializing dll_major/dll_minor in dcrt0.cc as these fields
> are initialized in globals.cc already.

Oh, yeah, I didn't check that for my POC.  But that means we can
do the same for api_major/api_minor (setting them in globals.cc,
that is).

> I also continue to update the
> __cygwin_cxx_malloc struct even though I don't think anything should be
> using it (rather the default_cygwin_cxx_malloc via the user_data pointer).
> It's not static for some reason, so something *could* be accessing it I
> guess.

I don't see how anything is supposed to access __cygwin_cxx_malloc.
You'd have to know the symbol name and what it is.  Not even gcc
or libstdc++ use it.

So I wonder... rather than changing CONDITIONALLY_OVERRIDE, why don't
we just write to __cygwin_cxx_malloc and then change the pointer?

There's no good reason that user_data->cxx_malloc points to
default_cygwin_cxx_malloc, other than to prime __cygwin_cxx_malloc.

And then we could just

  newu->cxx_malloc = &__cygwin_cxx_malloc;

This survives fork, but not execve.  Do you see any reason
that we shouldn't just overwrite user_data->cxx_malloc as above?

> diff --git a/winsup/cygwin/lib/_cygwin_crt0_common.cc b/winsup/cygwin/lib/_cygwin_crt0_common.cc
> index 5900e6315d..87f3e8042b 100644
> --- a/winsup/cygwin/lib/_cygwin_crt0_common.cc
> +++ b/winsup/cygwin/lib/_cygwin_crt0_common.cc
> @@ -124,6 +124,9 @@ _cygwin_crt0_common (MainFunc f, per_process *u)
>  {
>    per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
>    bool uwasnull;
> +  bool new_dll_with_additional_operators =
> +       newu ? CYGWIN_VERSION_CHECK_FOR_CXX17_OVERLOADS (newu)
> +            : false;

On second thought, why do we check newu for being not NULL again?
I added a comment to lib/_cygwin_crt0_common.cc back in 2009:

  newu is the Cygwin DLL's internal per_process and never NULL

but never followed up on this.  We can be sure that newu is non-NULL
*and* we can be sure that newu->cxx_malloc is non-NULL.  In contrast
to u and u->cxx_malloc, but those are never referenced.


Thanks,
Corinna
