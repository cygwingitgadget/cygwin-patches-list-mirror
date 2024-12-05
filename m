Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3950B3858CD9; Thu,  5 Dec 2024 10:51:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3950B3858CD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733395879;
	bh=mhkL2ZxH5ANSthfCq3KD30txhntFW5M8IO2RljA5wYc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ZU0njnrceoXdmHrKcnNyVxMsw5rgVaQH/wPw0c1bWxTsmFT9dVUqYWcSvxr3gnmXc
	 4CFJ5HjMFw5iI32k/FwfWoeODhaVwp/GLOWcuiFfh/3XLu2ck6dhj+B7A8kluR2qas
	 5shLCfskP8xjkVY84Ny5lFN1/kROAA3eTHHwvorI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2E844A80659; Thu,  5 Dec 2024 11:51:17 +0100 (CET)
Date: Thu, 5 Dec 2024 11:51:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: setjmp/longjmp: decrement incyg after signal
 handling
Message-ID: <Z1GFpWUYpJHKah23@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241204125447.316279-1-corinna-cygwin@cygwin.com>
 <20241205101422.ef6a17a0e3b8f313c1f76638@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205101422.ef6a17a0e3b8f313c1f76638@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Dec  5 10:14, Takashi Yano wrote:
> Hi Corinna,
> 
> On Wed,  4 Dec 2024 13:54:47 +0100
> Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > Commit 0b6fbd396ca2f ("* exceptions.cc (_cygtls::interrupt_now): Revert
> > to checking for "spinning" when choosing to defer signal.") introduced
> > a bug in the loop inside the stabilize_sig_stack subroutine:
> > 
> > First, stabilize_sig_stack grabs the stacklock. The _cygtls::incyg
> > flag is then incremented before checking if a signal has to be handled
> > for the current thread.
> > 
> > If no signal waits, the code simply jumps out, decrements _cygtls::incyg
> > and returns to the caller, which eventually releases the stacklock.
> > 
> > However, if a signal is waiting, stabilize_sig_stack releases the
> > stacklock, calls _cygtls::call_signal_handler(), and returns to
> > the start of the subroutine, trying to grab the lock.
> > 
> > After grabbing the lock, it increments _cygtls::incyg... wait...
> > again?
> > 
> > The loop does not decrement _cygtls::incyg after
> > _cygtls::call_signal_handler(), which returns with _cygtls::incyg
> > set to 1.  So it increments incyg to 2.  If no other signal is
> > waiting, stabilize_sig_stack jumps out and decrements _cygtls::incyg
> > to 1.  Eventually, setjmp or longjmp both will return to user
> > code with _cygtls::incyg set to 1.  This *may* be fixed at some later
> > point when signals arrive, but there will be a time when the application
> > runs in user code with broken signal handling.
> > 
> > Fixes: 0b6fbd396ca2f ("* exceptions.cc (_cygtls::interrupt_now): Revert to checking for "spinning" when choosing to defer signal.")
> > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> > ---
> >  winsup/cygwin/scripts/gendef | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> > index 7e14f69cf71c..377ceb59b2c8 100755
> > --- a/winsup/cygwin/scripts/gendef
> > +++ b/winsup/cygwin/scripts/gendef
> > @@ -344,6 +344,7 @@ stabilize_sig_stack:
> >  	movq	\$_cygtls.start_offset,%rcx	# point to beginning
> >  	addq	%r12,%rcx			#  of tls block
> >  	call	_ZN7_cygtls19call_signal_handlerEv
> > +	decl	_cygtls.incyg(%r12)
> >  	jmp	1b
> >  3:	decl	_cygtls.incyg(%r12)
> >  	addq	\$0x20,%rsp
> > -- 
> > 2.47.0
> > 
> 
> I tested this patch with Christian's longjmp test case, but
> the problem does not seem to be fixed.

That was not the intention.  It was just something I found while looking
into the assembler code.  This looks like a long-standing bug, which,
if my description above is right, might result in threads missing
signals, too.  Or at least, signals being defered, because user-space
is running partially with the "iscyg" flag being set.

It would be nice if you could check this, too, to be sure I'm not
totally wrong here.

> However, if additional patch attached as well as this patch are
> applied, the problem does not happen anymore. The additional
> patch removes the spinning flag completely.
> 
> What do you think?

Yeah, that's missing yet.  We don't have any documentation what exactly
the spinning flag is supposed to accomplish.  There's just this little
comment in _cygtls::interrupt_now:

  Delay the interrupt if we are
  [...]
  2) in _sigfe (spinning is true) and about to enter cygwin DLL

Yeah, nice... but *why*?  The fact that we're inside the DLL is guarded
by the "iscyg" flag anyway.  So what does "spinning" really accomplish,
which "incyg" doesn't?

I think for fixing this issue we can try to remove setting the spinning
flag from stabilize_sig_stack.  setjmp/longjmp only enter the DLL in
case of a waiting signal and then only via call_signal_handler(), not
via some exported entry point.  "incyg" should be really sufficient for
that.  This we could cherry-pick into 3.5.5.

In case of _sigfe/_sigbe, I'm not so sure yet. 3.6 might take some
more time anyway, so we could do a followup patch along the lines
of your patch below and see what happens.  I really hope we don't
get another, hard to debug fallout there...


Thanks,
Corinna

> 
> -- 
> Takashi Yano <takashi.yano@nifty.ne.jp>

> diff --git a/winsup/cygwin/cygtls.cc b/winsup/cygwin/cygtls.cc
> index 2842c2733..bfaa19867 100644
> --- a/winsup/cygwin/cygtls.cc
> +++ b/winsup/cygwin/cygtls.cc
> @@ -81,7 +81,7 @@ _cygtls::fixup_after_fork ()
>        pop ();
>        current_sig = 0;
>      }
> -  stacklock = spinning = 0;
> +  stacklock = 0;
>    signal_arrived = NULL;
>    locals.select.sockevt = NULL;
>    locals.cw_timer = NULL;
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 35a4a0b47..4dc4be278 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -920,9 +920,8 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
>  
>    /* Delay the interrupt if we are
>       1) somehow inside the DLL
> -     2) in _sigfe (spinning is true) and about to enter cygwin DLL
> -     3) in a Windows DLL.  */
> -  if (incyg || spinning || inside_kernel (cx))
> +     2) in a Windows DLL.  */
> +  if (incyg || inside_kernel (cx))
>      interrupted = false;
>    else
>      {
> diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
> index efbd557b1..2d490646a 100644
> --- a/winsup/cygwin/local_includes/cygtls.h
> +++ b/winsup/cygwin/local_includes/cygtls.h
> @@ -196,7 +196,6 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
>    waitq wq;
>    int current_sig;
>    unsigned incyg;
> -  unsigned spinning;
>    volatile unsigned stacklock;
>    __tlsstack_t *stackptr;
>    __tlsstack_t stack[TLS_STACK_SIZE];
> diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> index 377ceb59b..521550175 100755
> --- a/winsup/cygwin/scripts/gendef
> +++ b/winsup/cygwin/scripts/gendef
> @@ -134,7 +134,6 @@ _sigfe:						# stack is aligned on entry!
>  	movq	%gs:8,%r10			# location of bottom of stack
>  1:	movl	\$1,%r11d
>  	xchgl	%r11d,_cygtls.stacklock(%r10)	# try to acquire lock
> -	movl	%r11d,_cygtls.spinning(%r10)	# flag if we are waiting for lock
>  	testl	%r11d,%r11d			# it will be zero
>  	jz	2f				#  if so
>  	pause
> @@ -158,7 +157,6 @@ _sigbe:						# return here after cygwin syscall
>  	movq	%gs:8,%r10			# address of bottom of tls
>  1:	movl	\$1,%r11d
>  	xchgl	%r11d,_cygtls.stacklock(%r10)	# try to acquire lock
> -	movl	%r11d,_cygtls.spinning(%r10)	# flag if we are waiting for lock
>  	testl	%r11d,%r11d			# it will be zero
>  	jz	2f				#  if so
>  	pause
> @@ -258,7 +256,6 @@ sigdelayed:
>  
>  1:	movl	\$1,%r11d
>  	xchgl	%r11d,_cygtls.stacklock(%r12)	# try to acquire lock
> -	movl	%r11d,_cygtls.spinning(%r12)	# flag if we are waiting for lock
>  	testl	%r11d,%r11d			# it will be zero
>  	jz	2f				#  if so
>  	pause
> @@ -332,7 +329,6 @@ stabilize_sig_stack:
>  	movq	%gs:8,%r12
>  1:	movl	\$1,%r10d
>  	xchgl	%r10d,_cygtls.stacklock(%r12)	# try to acquire lock
> -	movl	%r10d,_cygtls.spinning(%r12)	# flag if we are waiting for lock
>  	testl	%r10d,%r10d
>  	jz	2f
>  	pause

