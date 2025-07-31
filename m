Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CD69E3858C78; Thu, 31 Jul 2025 10:06:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD69E3858C78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753956400;
	bh=CXgG5t81ZOnNhSm+OdK2Y3dIoCrJJHVu2KXIyiEssz8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JUoA40ytmyx3yFB9r3vs7rHNnS80tng1cjVGN+1yut33LpdWGQqqLspUle12JQLzv
	 Z/GE8XUEg1ItzC8FKQGSorKZsvi2H2rW4NPWeq993mc8o2OE2eZXdAxUEc6z6Qkhtg
	 ilEw17hx/Th50mZo/HDA6xVTYHK6m9dyCzyXvImU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DDC20A80B7A; Thu, 31 Jul 2025 12:06:38 +0200 (CEST)
Date: Thu, 31 Jul 2025 12:06:38 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
Message-ID: <aItALodM1WC7KP_C@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com>
 <aIoOKpzb557bX0cE@calimero.vinschen.de>
 <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 30 11:27, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 30 Jul 2025, Corinna Vinschen wrote:
> 
> > On Jul 25 16:10, Jeremy Drake via Cygwin-patches wrote:
> > > A sized delete (with a std::size_t parameter) was added in C++14 (but
> > > doesn't combine with nothrow_t)
> > >
> > > An aligned new/delete (with a std::align_val_t parameter) was added in
> > > C++17, and combinations with the sized delete and nothrow_t variants.
> > >
> > > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > > ---
> > > I added #pragma GCC diagnostic ignored "-Wc++17-compat" preemptively to
> > > cxx.cc to match what was done with c++14-compat with the one sized delete
> > > that was already present (presumably because it broke things when GCC
> > > started to emit that instead of the non-sized delete).
> > >
> > > The default new implementation uses calloc, so I'm not sure if it's
> > > expected that the aligned new call memset to zero the returned memory.
> > > It'd be easy enough to add if necessary.
> > >
> > > GCC will need to be updated circa
> > > https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/i386/cygwin-w64.h;h=160a290a03d00f6408252f5d8751fea7cd44e1be;hb=HEAD#l27
> > > but only after this change is stable because it will cause linker errors
> > > if the new __wrap symbols are not exported.
> > >
> > > Does there need to be a version bump somewhere to make sure a module
> > > linked against a new libcygwin.a doesn't run against an old cygwin1.dll,
> > > resulting in _cygwin_crt0_common.cc writing too much data to
> > > default_cygwin_cxx_malloc?
> > >
> > >  winsup/cygwin/cxx.cc                      | 120 +++++++++++++++++++++-
> > >  winsup/cygwin/cygwin.din                  |  12 +++
> > >  winsup/cygwin/lib/_cygwin_crt0_common.cc  |  59 +++++++++++
> > >  winsup/cygwin/libstdcxx_wrapper.cc        |  99 ++++++++++++++++++
> > >  winsup/cygwin/local_includes/cygwin-cxx.h |  14 +++
> > >  5 files changed, 299 insertions(+), 5 deletions(-)
> >
> > LGTM.  Please push (to main only, at least for now)
> 
> Done.  I was figuring this was a 3.7-only change.
> 
> I was thinking, in _cygwin_crt0_common.cc where the __cygwin_cxx_malloc
> struct is handled, perhaps it could "CONDITIONALLY_OVERRIDE" into the
> newu->cxx_malloc struct (from the dll) directly instead of merging into
> the local __cygwin_cxx_malloc struct and copying the entire struct over
> the dll struct.  This might allow a binary built against a newer
> libcygwin.a to not crash (or corrupt memory) if run against an older dll,
> as long as the newer C++ new/delete operators were not defined.

As I said, newer apps against older DLL is not exactly supported,
vice versa should be.

But I see what you mean and I'm sorry I didn't notice this before, but
your patch introduces an API change.  So you should definitely bump
CYGWIN_VERSION_API_MINOR in version.h.

The problem is that the usual approach of API checking as in
CYGWIN_VERSION_CHECK_FOR_EXTRA_TM_MEMBERS (we had more of these macros
in the past, we got rid of them with the switch to 64 bit-only) doesn't
work from inside the application, only from inside the DLL.  While
_cygwin_crt0_common is running, the version and api fields are filled
with the values from the time the application has been built.  The
values of the currently loaded DLL are not accessible.  We could add
another cygwin_internal macro to return a pointer to the DLL's
version info for this purpose.

Otherwise I don't see how a new app is supposed to know the size of
per_process_cxx_malloc of an old DLL.

> The sticking point would be libstdc++-6.dll once it is rebuilt with
> the additional --wrap arguments in GCC, because it would define all
> the operators and thus be incompatbile with older dll versions.

Well, the SO version of the new libstdc++ would have to be bumped to 7,
i. e., libstdc++-7.dll, that would solve half the problem.


Corinna
