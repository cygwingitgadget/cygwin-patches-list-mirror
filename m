Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 96AE53858D29; Tue, 18 Mar 2025 09:34:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 96AE53858D29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742290488;
	bh=mJIpcWDulZiyE0ywYPTR6jBVuYdZpmajeHW8hXh5eN8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=bPggRcqdmcNAJthWLqRzMU8UZxh8nyLRdkJ2EK4gIh0hI7E4PX6w+pn9S0HcSGrxY
	 3bXEvlMWLslWFWW06OelBVEwjjTIz8G42pZ12g+jFB14o6lUCjFwbpvF11Gs+W87cU
	 Fe8iMU5fZPJDUowNjbJk86pYBp3lgp06CH1vX/3U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8DEE7A804DA; Tue, 18 Mar 2025 10:34:46 +0100 (CET)
Date: Tue, 18 Mar 2025 10:34:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Carry process affinity through to result
Message-ID: <Z9k-Nn_Z7lYxWqKx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013499.html>
 <20250318075423.565-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318075423.565-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 18 00:53, Mark Geisert wrote:
> Due to deficient testing, the current code doesn't return a valid result
> to users of sched_getaffinity().  The updated code carries the determined
> procmask through to the generation of result cpu mask.
> 
> Recognize Windows' limitation that if the process is multi-group (i.e.,
> has threads in multiple cpu groups) there is no visibility to which
> processors in other groups are being used.  One could remedy this by
> looping through all the process' threads, but that could be expensive
> so is left for future contemplation.  In addition, we'd have to maintain
> our own copy of each thread's current group and mask in internal overhead.
> (By the way, multi-group processes are only possible on Windows systems
> with more than 64 hardware threads.)
> 
> A release note for 3.6.0 is included.
> 
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257616.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 641ecb07533e ("Cygwin: Implement sched_[gs]etaffinity()")
> 
> ---
>  winsup/cygwin/release/3.6.0 |  4 ++++
>  winsup/cygwin/sched.cc      | 11 +++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)

Pushed.


Thanks,
Corinna
