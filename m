Return-Path: <SRS0=C3iS=2M=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C58463858C78
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 19:05:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C58463858C78
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C58463858C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753988736; cv=none;
	b=aRAryEF26Q0lmQZXW+aBMz1kjbAAF8TDIDqV9kNNJ/SGLJ4fRX2RXh85KQpXmBwykrGoTIUAohevaTkeI8BQ0KMi+ovMH6KHU9s/7OJ+S4Sjlwrlj0VuEfC/6Em1Pu4cwcKjRlJbxfe+kro5ZRWrfoq4qq4Cm8t0o/u2xgzbHtk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753988736; c=relaxed/simple;
	bh=edf3R3XAViRPEh/OkgrNaRQpmXtC7Mvdjv/gGqr5nSw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=IXPpbpX0OsqSMRwCXg43T24I76HM5E+VGASSB+ujmJKU34AuNVwzmqCjvXjL2aC17K3NbfSgG9hBXUEuhLHFiq5CgUy14FZuQK+/DbTMFxryM0X6SxPo6wrIxiFXepXNjJVNNPS7Yv+M1erbd7tJaGzPic6IL+A9LDMksT+gS9E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C58463858C78
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=FNXO6Miu
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2FD8845CE7
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 15:05:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=U34w34+B+hN2BUipXRY20T5PfwE=; b=FNXO6
	MiuujwwZfeY/zvHf6O2XitSIrBViCeWWL1Mq7lCWIJQxUaZMMhTeFBLLI9QFGLD2
	CBGuQfLQB3uhFDTJcA7Q7WZauIuFzwyrRpmW9DQ6QnCLDs9XKkb/LedRJS7TmM66
	hdxUJhExtvPGHH8GUtBqnZAoAkzjZzPKXP4NZ0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 005C445CE5
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 15:05:35 -0400 (EDT)
Date: Thu, 31 Jul 2025 12:05:35 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
In-Reply-To: <aItALodM1WC7KP_C@calimero.vinschen.de>
Message-ID: <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com> <aIoOKpzb557bX0cE@calimero.vinschen.de> <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com> <aItALodM1WC7KP_C@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 31 Jul 2025, Corinna Vinschen wrote:

> On Jul 30 11:27, Jeremy Drake via Cygwin-patches wrote:
> > On Wed, 30 Jul 2025, Corinna Vinschen wrote:
> >
> > > On Jul 25 16:10, Jeremy Drake via Cygwin-patches wrote:
> > > > A sized delete (with a std::size_t parameter) was added in C++14 (but
> > > > doesn't combine with nothrow_t)
> > > >
> > > > An aligned new/delete (with a std::align_val_t parameter) was added in
> > > > C++17, and combinations with the sized delete and nothrow_t variants.
> > > >
> > > > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > > > ---
> > > > I added #pragma GCC diagnostic ignored "-Wc++17-compat" preemptively to
> > > > cxx.cc to match what was done with c++14-compat with the one sized delete
> > > > that was already present (presumably because it broke things when GCC
> > > > started to emit that instead of the non-sized delete).
> > > >
> > > > The default new implementation uses calloc, so I'm not sure if it's
> > > > expected that the aligned new call memset to zero the returned memory.
> > > > It'd be easy enough to add if necessary.
> > > >
> > > > GCC will need to be updated circa
> > > > https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/i386/cygwin-w64.h;h=160a290a03d00f6408252f5d8751fea7cd44e1be;hb=HEAD#l27
> > > > but only after this change is stable because it will cause linker errors
> > > > if the new __wrap symbols are not exported.
> > > >
> > > > Does there need to be a version bump somewhere to make sure a module
> > > > linked against a new libcygwin.a doesn't run against an old cygwin1.dll,
> > > > resulting in _cygwin_crt0_common.cc writing too much data to
> > > > default_cygwin_cxx_malloc?
> > > >
> > > >  winsup/cygwin/cxx.cc                      | 120 +++++++++++++++++++++-
> > > >  winsup/cygwin/cygwin.din                  |  12 +++
> > > >  winsup/cygwin/lib/_cygwin_crt0_common.cc  |  59 +++++++++++
> > > >  winsup/cygwin/libstdcxx_wrapper.cc        |  99 ++++++++++++++++++
> > > >  winsup/cygwin/local_includes/cygwin-cxx.h |  14 +++
> > > >  5 files changed, 299 insertions(+), 5 deletions(-)
> > >
> > > LGTM.  Please push (to main only, at least for now)
> >
> > Done.  I was figuring this was a 3.7-only change.
> >
> > I was thinking, in _cygwin_crt0_common.cc where the __cygwin_cxx_malloc
> > struct is handled, perhaps it could "CONDITIONALLY_OVERRIDE" into the
> > newu->cxx_malloc struct (from the dll) directly instead of merging into
> > the local __cygwin_cxx_malloc struct and copying the entire struct over
> > the dll struct.  This might allow a binary built against a newer
> > libcygwin.a to not crash (or corrupt memory) if run against an older dll,
> > as long as the newer C++ new/delete operators were not defined.
>
> As I said, newer apps against older DLL is not exactly supported,
> vice versa should be.
>
> But I see what you mean and I'm sorry I didn't notice this before, but
> your patch introduces an API change.  So you should definitely bump
> CYGWIN_VERSION_API_MINOR in version.h.

OK.  Should I list all the __wrap functions that are now exported in the
comment explicitly, or is "Export wrappers for C++14 and C++17 new and
delete overloads." sufficient?

> The problem is that the usual approach of API checking as in
> CYGWIN_VERSION_CHECK_FOR_EXTRA_TM_MEMBERS (we had more of these macros
> in the past, we got rid of them with the switch to 64 bit-only) doesn't
> work from inside the application, only from inside the DLL.  While
> _cygwin_crt0_common is running, the version and api fields are filled
> with the values from the time the application has been built.  The
> values of the currently loaded DLL are not accessible.  We could add
> another cygwin_internal macro to return a pointer to the DLL's
> version info for this purpose.

I noticed that dll_crt0_1 calls check_sanity_and_sync which performs some
checking on the per_process struct from the application, including if the
application's api_major is greater than the dll's.  However, this is after
_cygwin_crt0_common already runs.  I tested by downgrading to
3.7.0-0.266 and running an executable that I had built with 267 (but not
using the new wrappers).  It didn't crash during startup, but it did seem
to crash after forking (it was doing a posix_spawn).  So maybe the
api_major check could catch this after the fact but before the corruption
caused any more issues.

> Otherwise I don't see how a new app is supposed to know the size of
> per_process_cxx_malloc of an old DLL.

I think it's just unsupported.

> > The sticking point would be libstdc++-6.dll once it is rebuilt with
> > the additional --wrap arguments in GCC, because it would define all
> > the operators and thus be incompatbile with older dll versions.
>
> Well, the SO version of the new libstdc++ would have to be bumped to 7,
> i. e., libstdc++-7.dll, that would solve half the problem.

I hope not.  The SO version of libstdc++ is 6 everywhere, and has been for
some time.  It's ABI hasn't changed.
