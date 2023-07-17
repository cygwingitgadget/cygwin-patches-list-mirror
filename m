Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B7BFC3858D28; Mon, 17 Jul 2023 14:02:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B7BFC3858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689602567;
	bh=0UV/HyFHKewPE7i68pF7HiPoz9kO4gkFj7Vr9R+n+LQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=B8/BF6D6zVU84jOReQFFJ7N0dHKB5Gefpb6YhMGZSelhmy4U9Y+VGtE5pOa8sUvrv
	 6dYU1Xl7iaGu4XJnUhYvCXEwBQ3T3srzsVZfNfFUb2pb/CT6M4/5vJzgCw/TZq8913
	 tqa2ChLBP6IMvhR9WfbI8Gfa/3X/3AW5ySu43bAE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BBE7CA80BB0; Mon, 17 Jul 2023 16:02:45 +0200 (CEST)
Date: Mon, 17 Jul 2023 16:02:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/11] More testsuite fixes
Message-ID: <ZLVKBcPUlt18BQoJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <0a9d6f10-f26c-faf2-6fa1-c6a055570f5a@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a9d6f10-f26c-faf2-6fa1-c6a055570f5a@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On Jul 17 12:58, Jon Turney wrote:
> On 13/07/2023 12:38, Jon Turney wrote:
> > 
> > cancel11: some funkiness I can't work out, causing the save/restoring signal handlers around system() to not
> > work correctly
> 
> So, the test here: is the SIGINT handle restored correctly if the thread
> executing system() is cancelled. This test fails, because it's not.
> 
> It seems like that scenario was explicitly considered when this test was
> added in https://cygwin.com/pipermail/cygwin-patches/2003q1/003378.html
> 
> I think maybe this is a regression introduced in https://cygwin.com/cgit/newlib-cygwin/commit/?id=3cb9da14617c58c2821c80d48f0bd80a2deb5fdf
> 
> child_info_spawn::worker calls waitpid() which ultimately calls cygwait()
> which notices the thread's cancel event is signalled and acts as a
> cancellation point.
> 
> Attached is a patch which adds back the restoration of signal handlers on
> thread cancellation.
> 
> I can't find any hints in the mailing lists around 2013-04 about what
> problem that change is fixing, but given the commentary, this might be
> reintroducing another problem, though.

Maybe, but the patch is slim enough so we might get away with it.

> From a798750d271e20402a0a5efc4ac073f5948ad5b7 Mon Sep 17 00:00:00 2001
> From: Jon Turney <jon.turney@dronecode.org.uk>
> Date: Sun, 16 Jul 2023 14:46:00 +0100
> Subject: [PATCH] Cygwin: Restore pthread cleanup of signal handlers during
>  system()
> 
> Removed in 3cb9da14 which describes it as 'ill-advised' (additional
> context doesn't appear to be available).

Actually, "ill-conceived".  Beats my why, though.

> We can't neatly tuck the pthread_cleanup_push/pop inside the object, as
> they are implemented as macros which must appear in the same lexical
> scope.

You could do it if you call the underlying functions instead.
pthread_cleanup_push is just a convenience macro which initializes a
local __pthread_cleanup_handler, see include/pthread.h.  If you add a
__pthread_cleanup_handler to system_call_handle, you could use it the
same way as the macro and encapsulate the whole thing inside the object.
If you want to...

Fixes and Signed-off-by tags?


Thanks,
Corinna
