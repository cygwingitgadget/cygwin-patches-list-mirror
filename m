Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 33A333858D20; Wed,  4 Dec 2024 12:53:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 33A333858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733316798;
	bh=FsUyjRouK8cqHma+GprKyv370Y+RW2VrxcraZh2Lvk4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Yz50QUr0dNgYumakhl6/pwxe0hyGFJnijIqvhtgzl80cx60vdfsuYSDsRX7bgKm0F
	 WBq/Np9J/ovOqbo5JL6Nvay3oOPBwoCGfSn8bgj+OvMOjeGxHGW8SNJMNOVJLU7ZE6
	 mqWC7EExOODtU1HOAtWDccpNtJKUxZpajEALFikI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B52DFA80659; Wed,  4 Dec 2024 13:53:14 +0100 (CET)
Date: Wed, 4 Dec 2024 13:53:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Introduce a lock for the signal queue
Message-ID: <Z1BQuouCzDF9tSrK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241204114124.1246-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204114124.1246-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  4 20:41, Takashi Yano wrote:
> Currently, the signal queue is touched by the thread sig as well as
> other threads that call sigaction_worker(). This potentially has
> a possibility to destroy the signal queue chain. A possible worst
> result may be a self-loop chain which causes infinite loop. With
> this patch, lock()/unlock() are introduce to avoid such a situation.

I was hoping for a lockfree solution, but never mind that for now.
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 7e02e61f7..cc3113b88 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -106,12 +106,27 @@ class pending_signals
>  {
>    sigpacket sigs[_NSIG + 1];
>    sigpacket start;
> +  volatile unsigned locked;
>    bool retry;
> +  void lock ()
> +  {
> +    while (InterlockedExchange (&locked, 1))
> +      {
> +#ifdef __x86_64__
> +	__asm__ ("pause");
> +#else
> +#error unimplemented for this target
> +#endif
> +	yield ();
> +      }
> +    }
> +  void unlock () { locked = 0; }
>  
>  public:
> +  pending_signals (): locked(0) {}
>    void add (sigpacket&);
>    bool pending () {retry = !!start.next; return retry;}
> -  void clear (int sig);
> +  void clear (int sig, bool need_lock);
>    void clear (_cygtls *tls);
>    friend void sig_dispatch_pending (bool);
>    friend void wait_sig (VOID *arg);

Given this is used in C-code only, what about just using SRWLocks
in Exclusive-only mode, rather than a spinlock?


Thanks,
Corinna
