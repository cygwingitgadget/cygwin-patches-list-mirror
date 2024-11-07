Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C5D583858D21; Thu,  7 Nov 2024 11:13:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C5D583858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730978001;
	bh=XcCh6rJwC57zSSZItPkGVM0r3qXNjIXnWMfLZU0qPbc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=LQNzo4scJ+3bs1vETo+m/1rikqo3gnWPoDMRF3usFVwQthymCpxCF1LvM7nnSliOH
	 wpVNLqa3RA/CuPqWYP4eU/4dBUJXDEcUVooSxNSNW69TmS/KHENqfJOaz0XPNM6djH
	 vEcJJdGk8UVdFevjYSlto2HHAd2OrMkulGy2qA4E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A8744A808DA; Thu,  7 Nov 2024 12:13:19 +0100 (CET)
Date: Thu, 7 Nov 2024 12:13:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: Change pthread_sigqueue() to accept thread id
Message-ID: <ZyygzyX08grVNe6X@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241107072935.1630-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107072935.1630-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Nov  6 23:29, Mark Geisert wrote:
> Change the first parameter of pthread_sigqueue() to be a thread id rather
> than a thread pointer. The change is to match the Linux implementation of
> this function.
> 
> The user-visible function prototype is changed in include/pthread.h.
> The pthread_sigqueue() function is modified to work with a passed-in thread
> id rather than an indirect thread pointer as before.  (It was
> "pthread_t *thread", i.e., class pthread **.)  The release note for Cygwin
> 3.5.5 is updated.  CYGWIN_VERSION_API_MINOR is bumped to 351.

This patch is against cygwin-3_5-branch.  All patches should go to the
main branch in the first place and only then backported to the 3.5
branch if it's a bugfix.  So the patch sent to cygwin-patches should
always be against main.

That leads to a problem with your patch.  CYGWIN_VERSION_API_MINOR is
already at 355 in the main branch, while it's at 350 in the 3.5 branch.
That means, if your patch bumps CYGWIN_VERSION_API_MINOR, it would have
to bump to 356.  However, 356 doesn't make sense in the 3.5 branch,
and setting it to 351 in the 3.5 branch would collide with the 351
bump in main having a different meaning.

The way out is, your patch should not bump CYGWIN_VERSION_API_MINOR
at all.  Rather, just add a comment to version.h. There's already the
note preceding the definition of CYGWIN_VERSION_API_MAJOR:

  Note that we forgot to bump the api for ualarm, strtoll, strtoull,
  sigaltstack, sethostname. */

Just add the pthread_sigqueue bugfix here if you like, along the lines of

  Note that fixing the first pthread_sigqueue argument did not bump the api.

Alternatively we could just go ahead without touching version.h.

> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-September/256439.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 2041af1a535a (cygwin.din (pthread_sigqueue): Export.)

  $ git show 2041af1a535a
  fatal: ambiguous argument '2041af1a535a': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

Shouldn't that be 50350cafb375?  The Fixes commit message text is
supposed to be set in quotes,btw.:

  Fixes: 50350cafb375 ("* cygwin.din (pthread_sigqueue): Export.")

Other than the above points, the patch itself is fine.


Thanks,
Corinna
