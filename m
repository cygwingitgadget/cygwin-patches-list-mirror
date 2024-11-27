Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 92E943858D37; Wed, 27 Nov 2024 17:02:54 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8DBF5A80E4D; Wed, 27 Nov 2024 18:02:52 +0100 (CET)
Date: Wed, 27 Nov 2024 18:02:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 8/8] Cygwin: signal: Fix another deadlock between main
 and sig thread
Message-ID: <Z0dQvJ-kenF_8q7I@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241127112308.6958-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127112308.6958-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 20:22, Takashi Yano wrote:
> In _cygtls::handle_SIGCONT(), the sig thread waits for the main thread
> processing the signal without unlocking tls area. This causes a deadlock
> if the main thread tries to acquire a lock for the tls area meanwhile.
> With this patch, unlock tls before calling yield() in handle_SIGCONT().
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: 26158dc3e9c2("* exceptions.cc (sigpacket::process): Lock _cygtls area of thread before accessing it.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/exceptions.cc           | 10 +++++++---
>  winsup/cygwin/local_includes/cygtls.h |  4 +++-
>  2 files changed, 10 insertions(+), 4 deletions(-)

LGTM.

Thanks,
Corinna
