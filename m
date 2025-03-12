Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EB3973858408; Wed, 12 Mar 2025 11:16:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EB3973858408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741778174;
	bh=TaytL3Ec/SmpwgGPcYRRzq4NCgWV3eyxzEWd+8DRdsU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ZREI1NLKTf9lZgSy/q1l9H7dWBxLNwmcX/bDRvpkMX0FDHXGxcRYwhMUZJfUwWZbV
	 8cAmxuLXS7w/y5EUt8Qfm24+hAemWzUxPHFuWn/IRm4ra7OnaIupgzIhygjxM63fVa
	 AdX65A/Iymc5wbTFt5QDoPwz9/EJMsZOeqrN8t3g=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DFEBEA8066D; Wed, 12 Mar 2025 12:16:12 +0100 (CET)
Date: Wed, 12 Mar 2025 12:16:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/6] Cygwin: signal: Redesign signal queue handling
Message-ID: <Z9Fs_Dyagj26Jszv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
 <20250312032748.233077-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312032748.233077-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mar 12 12:27, Takashi Yano wrote:
> The previous implementation of the signal queue behaves as:
> 1) Signals in the queue are processed in a disordered manner.
> 2) If the same signal is already in the queue, new signal is discarded.
> 
> Strictly speaking, these behaviours do not violate POSIX. However,
> these could be a cause of unexpected behaviour in some software. In
> Linux, some important signals such as SIGSTOP/SIGCONT do not seem to
> behave like that.
> This patch prevents SIGKILL, SIGSTOP, SIGCONT, and SIGRT* from that
> issue. Moreover, if SA_SIGINFO is set in sa_flags, the signal is
> treated almost as the same.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
> Fixes: 7ac6173643b1 ("(pending_signals): New class.")
> Reported by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Christian Franke <Christian.Franke@t-online.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 128 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 106 insertions(+), 22 deletions(-)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 8739f18f5..ab3acfd24 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -21,6 +21,7 @@ details. */
>  #include "cygtls.h"
>  #include "ntdll.h"
>  #include "exception.h"
> +#include <assert.h>
>  
>  /*
>   * Convenience defines
> @@ -28,6 +29,10 @@ details. */
>  #define WSSC		  60000	// Wait for signal completion
>  #define WPSP		  40000	// Wait for proc_subproc mutex
>  
> +#define PIPE_DEPTH _NSIG /* Historically, the pipe size is _NSIG packet */
> +#define SIGQ_ROOM 4
> +#define SIGQ_DEPTH (PIPE_DEPTH + SIGQ_ROOM)

I'm missing a comment here.  Why adding SIGQ_ROOM?

Other than that, LGTM.

In terms of the queue size, I wonder if we really have to restrict the
queue to a small number of queued signals, 69 right now.  The pipe used
for communication will take 64K, one allocation granularity slot, anyway.
Linux, for instance, queues more than 60K signals.

So, wouldn't it make sense to raise the queu depth to some higher
value and the pipe size so that it it's <= 64K?

While looking into your patch, it occured to me that we have a
long-standing bug: We never changed __SIGQUEUE_MAX/SIGQUEUE_MAX in
include/cygwin/limits.h when we started to support 64 signals (we only
did that for 64 bit Cygwin).

We can't change that for existing binaries actually referring the
SIGQUEUE_MAX macro, but we should change this, so that
sysconf( _SC_SIGQUEUE_MAX) returns the right value, isn't it?


Thanks,
Corinna
