Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1B6C23858429; Mon, 20 Jan 2025 11:43:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1B6C23858429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737373389;
	bh=8nNqie9wHfTN4vUr31I0X4byzzXoFk+frlhxPtaL1zE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VJEJuo74htu5O7keVj/g8ApxpW/q01cAtVCkdI86PVzTwr0eNxRizaiRCWzl9g4TG
	 z7s0offvCDIUlbg5wmjl+ioEkR86E7iOf1KIRv+TARSIbYPVY8aZmqVL5rGtRrXtT5
	 at81E4v/ScoAwJw9SfO3YCF6dT1G+QAGVn29TS6w=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6C074A80D3F; Mon, 20 Jan 2025 12:43:07 +0100 (CET)
Date: Mon, 20 Jan 2025 12:43:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-ID: <Z442y6VhRE7IHVXo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
 <Z36eWXU8Q__9fUhr@calimero.vinschen.de>
 <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
 <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
 <20250117185241.34202389178435578f251727@nifty.ne.jp>
 <20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
 <8bdee3d3-1200-b70d-5829-d0a081323562@jdrake.com>
 <20250119114958.82129e29fae9093f38dac53c@nifty.ne.jp>
 <20250119194206.862aecab375cb03c7143c22e@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250119194206.862aecab375cb03c7143c22e@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jan 19 19:42, Takashi Yano wrote:
> Hi Corinna,
> 
> On Sun, 19 Jan 2025 11:49:58 +0900
> Takashi Yano wrote:
> > On Sat, 18 Jan 2025 17:06:50 -0800 (PST)
> > Jeremy Drake wrote:
> > > On Sat, 18 Jan 2025, Takashi Yano wrote:
> > > 
> > > > While debugging this problem, I encountered another hang issue,
> > > > which is fixed by:
> > > > 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> > > 
> > > I'm concerned about this patch.  There's a window where current_sig could
> > > be changed after exiting the while, before the lock is acquired by
> > > cygheap->find_tls (_main_tls);  Should current_sig be rechecked after the
> > > lock is acquired to make sure that hasn't happened?  Also, does
> > > current_sig need to be volatile, or is yield a sufficient fence for the
> > > compiler to know other threads may have changed the value?
> > 
> > Thanks for pointing out this. You are right if othre threads may
> > set current_sig to non-zero value. Current cygwin sets current_sig
> > to non-zero only in 
> > _cygtls::interrupt_setup()
> > and
> > _cygtls::handle_SIGCONT()
> > both are called from sigpacket::process() as follows.
> > 
> > wait_sig()->
> >  sigpacket::process() +-> sigpacket::setup_handler() -> _cygtls::interrupt_setup()
> >                       \-> _cygtls::handle_SIGCONT()
> > 
> > wait_sig() is a thread which handle received signals, so other
> > threads than wait_sig() thread do not set the current_sig to non-zero.
> > That is, other threads set current_sig only to zero. Therefore,
> > I think we don't have to guard checking current_sig value by lock.
> > The only thing we shoud guard is the following case.
> > 
> > [wait_sig()]               [another thread]
> > current_sig = SIGCONT;
> >                            current_sig = 0;
> > set_signal_arrived();
> > 
> > So, we should place current_sig = SIGCONT and set_signal_arrived()
> > inside the lock.
> 
> I think the lock necessary here is _cygtls::lock(), isn't it?
> Because the _cygtls::call_signal_handler() uses _cygtls::locl().
> I'm asking you because you introduced the find_tls() lock first
> in the commit:

Yeah, _cygtls::lock() of the target thread should be right.
The mutex in find_tls was for guarding threadlist_t, not the
thread's _cygtls.


Corinna
