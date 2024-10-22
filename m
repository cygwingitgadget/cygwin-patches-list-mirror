Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 611BA3858D20; Tue, 22 Oct 2024 15:58:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 611BA3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729612684;
	bh=7B3SJ6umMV9qLHoAvlbF3dGYpglCpn+8aN6EjbYLj/4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ojaAMvDokcmi8Z2XIDd+t73PEu4q+d0W6jr3OSXZcjP40d7oOULGaeUgbu/ak+b9e
	 1CEgdvHXDUeIiQFzmJJ5N9LUqisILmmNAW8gS2UarlyB4+XCvdJzVQtEhcRZJ7O2S1
	 rfXGuQzgDswTv2dR1U4uyD25lkTh+IDTmkYojZLU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 54250A80D67; Tue, 22 Oct 2024 17:58:02 +0200 (CEST)
Date: Tue, 22 Oct 2024 17:58:02 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: sigfe: Fix a bug that signal handler destroys
 fpu states
Message-ID: <ZxfLig9716RXtWLu@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,
	cygwin-patches@cygwin.com
References: <20241014063914.6061-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014063914.6061-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

big change, so, honest question: Do you think this is safe for 3.5.5?

This certainly also requires an entry in the release text and there
are just a few minor typos in comments, see below.


Thanks,
Corinna


On Oct 14 15:39, Takashi Yano wrote:
> Previously, sigfe had a bug that the signal handler destroys fpu state.
> This is caused by fninit instruction in sigdelayed. With this patch,
> saving/restoring the FPU/SIMD state is done using fxsave/fxrstor or
> xsave/xrstor rather than fnstcw/fldcw, stmxcsr/ldmxcsr and push/pop
> xmm0-xmm15. Since xsave/xrstor is used, not only x87/MMX/SSE states
> but also AVX/AVX2/AVX-512 states can be maintained unlike before.
> Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256503.html
> 
> Fixes: ed89fbc3ff11 ("* gendef (sigdelayed (x86_64)): Save and restore FPU control word.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Suggested-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> Reviewed-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/scripts/gendef | 91 ++++++++++++++++++++----------------
>  1 file changed, 50 insertions(+), 41 deletions(-)
> 
> diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> index 3b1f8b9da..04350f1cb 100755
> --- a/winsup/cygwin/scripts/gendef
> +++ b/winsup/cygwin/scripts/gendef
> @@ -185,7 +185,7 @@ sigdelayed:
>  	# make sure it is aligned from here on
>  	# We could be called from an interrupted thread which doesn't know
>  	# about his fate, so save and restore everything and the kitchen sink.
> -	andq	\$0xfffffffffffffff0,%rsp
> +	andq	\$0xffffffffffffffc0,%rsp
>  	.seh_setframe %rbp,0
>  	pushq	%r15
>  	.seh_pushreg %r15
> @@ -213,26 +213,41 @@ sigdelayed:
>  	.seh_pushreg %rbx
>  	pushq	%rax
>  	.seh_pushreg %rax
> -	subq	\$0x128,%rsp
> -	.seh_stackalloc 0x128
> -	stmxcsr	0x124(%rsp)
> -	fnstcw	0x120(%rsp)
> -	movdqa	%xmm15,0x110(%rsp)
> -	movdqa	%xmm14,0x100(%rsp)
> -	movdqa	%xmm13,0xf0(%rsp)
> -	movdqa	%xmm12,0xe0(%rsp)
> -	movdqa	%xmm11,0xd0(%rsp)
> -	movdqa	%xmm10,0xc0(%rsp)
> -	movdqa	%xmm9,0xb0(%rsp)
> -	movdqa	%xmm8,0xa0(%rsp)
> -	movdqa	%xmm7,0x90(%rsp)
> -	movdqa	%xmm6,0x80(%rsp)
> -	movdqa	%xmm5,0x70(%rsp)
> -	movdqa	%xmm4,0x60(%rsp)
> -	movdqa	%xmm3,0x50(%rsp)
> -	movdqa	%xmm2,0x40(%rsp)
> -	movdqa	%xmm1,0x30(%rsp)
> -	movdqa	%xmm0,0x20(%rsp)
> +
> +	# +0x20: indicates if xsave is available
> +	# +0x24: decrement of the stack to allocate space
> +	# +0x28: %eax returnd by cpuid (0x0d, 0x00)
> +	# +0x2c: %edx returnd by cpuid (0x0d, 0x00)
> +	# +0x30: state save area
> +	movl	\$1,%eax
> +	cpuid
> +	andl	\$0x04000000,%ecx # xsave available?
> +	jnz	1f
> +	movl	\$0x248,%ebx # 0x18 for alibnment, 0x30 for additinal space
                                        alignment           additional

> +	subq	%rbx,%rsp
> +	movl	%ecx,0x20(%rsp)
> +	movl	%ebx,0x24(%rsp)
> +	fxsave64 0x30(%rsp) # x86 CPU with 64-bit mode has fxsave64/fxrstor64
> +	jmp	2f
> +1:
> +	movl	\$0x0d,%eax
> +	xorl	%ecx,%ecx
> +	cpuid	# get necessary space for xsave
> +	movq	%rbx,%rcx
> +	addq	\$0x48,%rbx # 0x18 for alignment, 0x30 for additinal space
                                                           additional

> +	subq	%rbx,%rsp
> +	movl	%ebx,0x24(%rsp)
> +	xorq	%rax,%rax
> +	shrq	\$3,%rcx
> +	leaq	0x30(%rsp),%rdi
> +	rep	stosq
> +	xgetbv	# get XCR0 (ecx is 0 after rep)
> +	movl	%eax,0x28(%rsp)
> +	movl	%edx,0x2c(%rsp)
> +	notl	%ecx # set ecx non-zero
> +	movl	%ecx,0x20(%rsp)
> +	xsave64	0x30(%rsp)
> +2:
>  	.seh_endprologue
>  
>  	movq	%gs:8,%r12			# get tls
> @@ -259,26 +274,20 @@ sigdelayed:
>  	xorl	%r11d,%r11d
>  	movl	%r11d,_cygtls.incyg(%r12)
>  	movl	%r11d,_cygtls.stacklock(%r12)	# unlock
> -	movdqa	0x20(%rsp),%xmm0
> -	movdqa	0x30(%rsp),%xmm1
> -	movdqa	0x40(%rsp),%xmm2
> -	movdqa	0x50(%rsp),%xmm3
> -	movdqa	0x60(%rsp),%xmm4
> -	movdqa	0x70(%rsp),%xmm5
> -	movdqa	0x80(%rsp),%xmm6
> -	movdqa	0x90(%rsp),%xmm7
> -	movdqa	0xa0(%rsp),%xmm8
> -	movdqa	0xb0(%rsp),%xmm9
> -	movdqa	0xc0(%rsp),%xmm10
> -	movdqa	0xd0(%rsp),%xmm11
> -	movdqa	0xe0(%rsp),%xmm12
> -	movdqa	0xf0(%rsp),%xmm13
> -	movdqa	0x100(%rsp),%xmm14
> -	movdqa	0x110(%rsp),%xmm15
> -	fninit
> -	fldcw	0x120(%rsp)
> -	ldmxcsr	0x124(%rsp)
> -	addq	\$0x128,%rsp
> +
> +	movl	0x20(%rsp),%ecx
> +	testl	%ecx,%ecx # xsave available?
> +	jnz	1f
> +	fxrstor64 0x30(%rsp)
> +	jmp	2f
> +1:
> +	movl	0x28(%rsp),%eax
> +	movl	0x2c(%rsp),%edx
> +	xrstor64 0x30(%rsp)
> +2:
> +	movl	0x24(%rsp),%ebx
> +	addq	%rbx,%rsp
> +
>  	popq	%rax
>  	popq	%rbx
>  	popq	%rcx
> -- 
> 2.45.1
