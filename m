Return-Path: <SRS0=J/el=FK=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id B18B04BA540B
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 22:12:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B18B04BA540B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B18B04BA540B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784239933; cv=none;
	b=nE3DMZqpXu5FmRRBp/R5OhlrIUTYtFFOZz/nebtnvza25L7w1AU3fTcbIy7nBeMElwsJgw9mwVxmG0LBiYnT+CpY0UARnNbna8UT78Qwg5QMc0mWIuzweouxAhV2PBCLGPi+rPb80/5Oh58qKGv2yRaIcyMtGKCJpco5S602ugE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784239933; c=relaxed/simple;
	bh=cTaRsrKo7xwLsF9RhMJeIIWQoaWSZhxAkruYMmZOm8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=HDn4BZhnyj/ySZKmg1oFjLCGwcdtcYxFasNF3rsf0HXemsxqKXulVFC4+51tKaznnWblRdNvFHanrhNKeHbsC6zs4N4GYIFVPqvcTxp8GP9otLknAPXDbheRwYWuKI+NwrIpbrk/1Ujk2oLAGLBwDpLVqO/I9j1nTXW5NTwCpFw=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B18B04BA540B
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A08C1FD0501B6BE
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTGXDJPmvOLxyMZ9oUmiX41ReUeOFOhs7X0e5Hd44I+/750d5OxuTSlps8eLKKt8IC4Kss0YJOoCX9AYf7T76doibn7chJ37d7e36wGOgAvBdEcAYi93oglttRbml9TEWZJWHfya7jq9iSRjmndzWz0bOkFcv3PNMckAOsKGBAayNpmovDdAWUxOtcMkAetDkS7+kSHBeckQm6OeJzont5Vj6hSkMztoaXs1bPcZ/bgNFe0BEHgcuZaNsKaFIQ7+ipslB6uGAeyr2tI7aDpbvEPDjJMYxrmBxB5El82ZqZmusao1Rgl3hW8chGolheY/PxAmefLwIyNsTSpc4GwV8VMaPcGWCJcd62Zr1vNy7JrqPVPHNi2IGbSiZaBaBVhH6FLVsa29OkDIU+cJuzBx0Haw5dJum0cLiAY2a3vC7F8fpevkuqmm043PpuPmbJORBQMD47fpFPEfv18Lmawr2uEstXpLui3kzXQN+ZYB70mfPztpZ4tfV3TnLPftkhdIq6EgcH9JswUlxhdfcKDEusDD00ISx+8SkxnTg0JfhDby3L8helf07a2xKYkyNvgJqVfQvtqmn2N6mv0HXAXjenzriM142Rw+KXi9VzIU/jwGWBNf6KPZAiVZE9TnM3UGA7EZlIK0C6DPkrjH5LDEC6KOPW+9PECGMgZlNwfIs3+XbQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A08C1FD0501B6BE; Thu, 16 Jul 2026 23:12:01 +0100
Message-ID: <1938820d-556f-49a2-8ffb-6c89dadad650@dronecode.org.uk>
Date: Thu, 16 Jul 2026 23:12:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Add AArch64 support for signal handling and
 ucontext
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
References: <PN0P287MB029504FE0939EFA34AEC78E592FD2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN0P287MB029504FE0939EFA34AEC78E592FD2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 10/07/2026 12:55, Chandru Kumaresan wrote:
> Hi Everyone,
> 
> I've added inline comments to the AArch64 assembly implementation.
> 
> Thanks and Regards,
> 

Thanks.

In the patch commentary, this is described as implementing "signal 
handling", but this just seems to be implementing the use of an 
alternate signal stack in signal handling, so maybe that could be clarified.

I guess I should ask how you've been testing get/set/swap/makecontext, 
since I'm not sure we have anything currently in the testsuite that 
covers that?

A few more comments below.

> Chandru
> 
> Inline Patch
> ---
>   winsup/cygwin/exceptions.cc | 318 +++++++++++++++++++++++++++++++-----
>   1 file changed, 276 insertions(+), 42 deletions(-)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 1e129b319..cb5f1dc1d 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -1892,7 +1892,7 @@ _cygtls::call_signal_handler ()
> 
>       /* In assembler: Save regs on new stack, move to alternate stack,
>          call thisfunc, revert stack regs. */
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>       /* Clobbered regs: rcx, rdx, r8, r9, r10, r11, rbp, rsp */
>       __asm__ ("\n\
>           movq  %[NEW_SP], %%rax  # Load alt stack into rax  \n\
> @@ -1930,6 +1930,60 @@ _cygtls::call_signal_handler ()
>               [FUNC]  "o" (thisfunc),
>               [WRAPPER] "o" (altstack_wrapper)
>           : "memory");
> +#elif defined(__aarch64__)
> +    __asm__ ("\n\
> +        mov   x9, %[NEW_SP]     // Load alt stack into x9  \n\
> +        sub   x9, x9, #0x60     // Make room on alt stack  \n\
> +                 // for clobbered regs      \n\
> +        str   x0, [x9, #0x00]      // Save clobbered regs     \n\
> +        str   x1, [x9, #0x08]                  \n\
> +        str   x2, [x9, #0x10]                  \n\
> +        str   x3, [x9, #0x18]                  \n\
> +        str   x4, [x9, #0x20]                  \n\
> +        str   x5, [x9, #0x28]                  \n\
> +        str   x6, [x9, #0x30]                  \n\
> +        str   x7, [x9, #0x38]                  \n\
> +        str   fp, [x9, #0x40]                  \n\
> +        mov   x10, sp        // Copy sp into x10 for saving   \n\
> +        str   x10, [x9, #0x48]              \n\
> +        str   x30, [x9, #0x50]  // Save link register      \n\
> +        mov   x0, %[SIG]     // thissig to 1st arg reg  \n\
> +        mov   x1, %[SI]      // &thissi to 2nd arg reg  \n\
> +        mov   x2, %[CTX]     // thiscontext to 3rd arg reg \n\
> +        mov   x3, %[FUNC]    // thisfunc to x3    \n\
> +        mov   x4, %[WRAPPER]    // wrapper address to x4   \n\
> +        mov   sp, x9         // Move alt stack into sp  \n\
> +        blr   x4       // Call wrapper         \n\
> +        mov   x9, sp         // Restore clobbered regs  \n\
> +        ldr   x30, [x9, #0x50]  // Restore link register   \n\
> +        ldr   x10, [x9, #0x48]              \n\
> +        ldr   fp,  [x9, #0x40]              \n\
> +        ldr   x7,  [x9, #0x38]              \n\
> +        ldr   x6,  [x9, #0x30]              \n\
> +        ldr   x5,  [x9, #0x28]              \n\
> +        ldr   x4,  [x9, #0x20]              \n\
> +        ldr   x3,  [x9, #0x18]              \n\
> +        ldr   x2,  [x9, #0x10]              \n\
> +        ldr   x1,  [x9, #0x08]              \n\
> +        ldr   x0,  [x9, #0x00]              \n\
> +        mov   sp,  x10    // Restore stack pointer   \n"
> +        : : [NEW_SP]    "r" (new_sp),
> +            [SIG]    "r" (thissig),
> +            [SI]  "r" (&thissi),
> +            [CTX]    "r" (thiscontext),
> +            [FUNC]   "r" (thisfunc),
> +            [WRAPPER] "r" (altstack_wrapper)
> +       /* altstack_wrapper is an ordinary C call, so every
> +         caller-saved register may be clobbered.  x18 (the Windows
> +         TEB pointer) and v8-v15 (callee-saved on Windows) are
> +         preserved and thus omitted.  */
> +        : "memory", "cc",
> +          "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
> +          "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
> +          "x16", "x17", "x29", "x30",
> +          "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
> +          "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
> +          "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");

So, this clobber list doesn't make a lot of sense to me: We're 
explicitly saving and restoring x0-x7, etc. so also telling gcc that 
they've been trampled on doesn't seem right.

(I guess the comment before the x86_64 implementation above is a bit 
unhelpful: I think that it's saying that "this code uses these regs in 
the course of doing what it does, so those are the ones we preserve")

>   #else
>   #error unimplemented for this target
>   #endif
> @@ -2009,10 +2063,78 @@ setcontext (const ucontext_t *ucp)
>   {
>     PCONTEXT ctx = (PCONTEXT) &ucp->uc_mcontext;
>     set_signal_mask (_my_tls.sigmask, ucp->uc_sigmask);
> +#if defined(__aarch64__)
> +  /* On ARM64 Windows, RtlRestoreContext may fail (STATUS_ILLEGAL_INSTRUCTION)
> +     when restoring a synthetic CONTEXT that was constructed by makecontext
> +     rather than captured by RtlCaptureContext / GetThreadContext.  This is
> +     because RtlRestoreContext may perform validation or use internal
> +     mechanisms (e.g. stack unwinding hints) that don't work with synthetic
> +     contexts pointing to arbitrary PC addresses and non-thread stacks.

Nice :(.  I suppose it's too much to ask for that this behaviour is 
documented somwhere.

> +
> +     Instead, we manually restore all registers and branch to the saved PC.
> +     This mirrors what glibc/musl do in their setcontext implementations
> +     for aarch64-linux.  */
> +  register PCONTEXT base __asm__ ("x16") = ctx;
> +  __asm__ __volatile__ ("\n\
> +  add   x17, x16, #272             \n\

A comment explaining what the constant 272 corresponds to here 
(presumably the offset of V registers inside CONTEXT) might be nice.

> +  ldp   q0, q1, [x17, #0]          \n\
> +  ldp   q2, q3, [x17, #32]            \n\
> +  ldp   q4, q5, [x17, #64]            \n\
> +  ldp   q6, q7, [x17, #96]            \n\
> +  ldp   q8, q9, [x17, #128]           \n\
> +  ldp   q10, q11, [x17, #160]            \n\
> +  ldp   q12, q13, [x17, #192]            \n\
> +  ldp   q14, q15, [x17, #224]            \n\
> +  ldp   q16, q17, [x17, #256]            \n\
> +  ldp   q18, q19, [x17, #288]            \n\
> +  ldp   q20, q21, [x17, #320]            \n\
> +  ldp   q22, q23, [x17, #352]            \n\
> +  ldp   q24, q25, [x17, #384]            \n\
> +  ldp   q26, q27, [x17, #416]            \n\
> +  ldp   q28, q29, [x17, #448]            \n\
> +  ldp   q30, q31, [x17, #480]            \n\
> +  /* Restore FPCR and FPSR */            \n\
> +  ldr   w17, [x16, #784]           \n\
> +  msr   fpcr, x17               \n\
> +  ldr   w17, [x16, #788]           \n\
> +  msr   fpsr, x17               \n\
> +  /* Load PC into x17 (branch target, offset 264) */ \n\
> +  ldr   x17, [x16, #264]           \n\
> +  /* Restore callee-saved GPRs x18..x28, fp, lr */   \n\
> +  ldp   x18, x19, [x16, #152]            \n\
> +  ldp   x20, x21, [x16, #168]            \n\
> +  ldp   x22, x23, [x16, #184]            \n\
> +  ldp   x24, x25, [x16, #200]            \n\
> +  ldp   x26, x27, [x16, #216]            \n\
> +  ldp   x28, x29, [x16, #232]            \n\
> +  ldr   x30, [x16, #248]           \n\
> +  /* Restore caller-saved GPRs x2..x15 */         \n\
> +  ldp   x2, x3, [x16, #24]            \n\
> +  ldp   x4, x5, [x16, #40]            \n\
> +  ldp   x6, x7, [x16, #56]            \n\
> +  ldp   x8, x9, [x16, #72]            \n\
> +  ldp   x10, x11, [x16, #88]          \n\
> +  ldp   x12, x13, [x16, #104]            \n\
> +  ldp   x14, x15, [x16, #120]            \n\
> +  /* Restore x0, x1 */             \n\
> +  ldp   x0, x1, [x16, #8]          \n\
> +  /* Set SP from context (last use of x16 as base) */   \n\
> +  ldr   x16, [x16, #256]           \n\
> +  mov   sp, x16                 \n\
> +  /* Branch to saved PC */            \n\
> +  br x17                  \n\

So, this just seems to suffer from the same problem that's been 
laboriously explained to me in "exceptions: Fix AArch64 non-incyg signal 
handling", except from the opposite side.

The value of x17 in the context provided is not restored correctly.

(This also doesn't restore CPSR, which would seem incorrect).

Or maybe this is all OK, because callee-saved registers in a ucontext 
are irrelevant. But if that's the case, maybe some comment and analysis 
to that effect would be a good idea.

> +"
> +  : /* no outputs (noreturn) */
> +  : "r" (base)
> +  : "memory"
> +  );
> +  __builtin_unreachable ();
> +#else
>     RtlRestoreContext (ctx, NULL);
>     /* If we got here, something was wrong. */
>     set_errno (EINVAL);
>     return -1;
> +#endif
>   }
> 
>   extern "C" int
> @@ -2049,7 +2171,7 @@ swapcontext (ucontext_t *oucp, const ucontext_t *ucp)
>   /* Trampoline function to set the context to uc_link.  The pointer to the
>      address of uc_link is stored in a callee-saved register, referenced by
>      _MC_uclinkReg from the C code.  If uc_link is NULL, call exit. */
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>   /* _MC_uclinkReg == %rbx */
>   __asm__ ("          \n\
>     .global  __cont_link_context  \n\
> @@ -2070,7 +2192,26 @@ __cont_link_context:        \n\
>     nop            \n\
>     .seh_endproc         \n\
>     ");
> -
> +#elif defined(__aarch64__)
> +/*   _MC_uclinkReg == x19.  x19 holds the address of the uc_link slot but is
> +  only 8-byte aligned, so read through it and mask into SP in one step
> +  rather than moving the unaligned value into SP first.  setcontext and
> +  cygwin_exit are noreturn, so tail-call them with 'b': this leaves x30
> +  untouched and keeps the frame leaf, matching the empty SEH prologue. */
> +__asm__ ("             \n\
> +  .global  __cont_link_context     \n\
> +  .seh_proc __cont_link_context    \n\
> +__cont_link_context:            \n\
> +  .seh_endprologue        \n\
> +  ldr   x0, [x19]         \n\
> +  and   sp, x19, #~0xf       \n\
> +  cbnz  x0, 1f            \n\
> +  mov   w0, #0xff         \n\
> +  b  cygwin_exit       \n\
> +1:                  \n\
> +  b  setcontext        \n\
> +  .seh_endproc            \n"
> +  );
>   #else
>   #error unimplemented for this target
>   #endif
> @@ -2078,11 +2219,19 @@ __cont_link_context:       \n\
>   /* makecontext is modelled after GLibc's makecontext.  The stack from uc_stack
>      is prepared so that it starts with a pointer to the linked context uc_link,
>      followed by the arguments to func, and finally at the bottom the "return"
> -   address set to __cont_link_context.  In the ucp context, rbx/ebx is set to
> -   point to the stack address where the pointer to uc_link is stored.  The
> -   requirement to make this work is that rbx/ebx are callee-saved registers
> -   per the ABI.  If any function is called which doesn't follow the ABI
> -   conventions, e.g. assembler code, this method will break.  But that's ok. */
> +   address set to __cont_link_context.

It seems that this sentence about the address of __cont_link_context 
being on the stack also only applies to x86_64, since aarch64 uses lr.

> +
> +   x86_64: In the ucp context, rbx is set to point to the stack address where
> +   the pointer to uc_link is stored.  The requirement to make this work is that
> +   rbx is a callee-saved register per the ABI.
> +
> +   ARM64: In the ucp context, x19 is set to point to the stack address where
> +   the pointer to uc_link is stored.  The requirement is that x19 is a
> +   callee-saved register per the ARM64 ABI.
> +
> +   If any function is called which doesn't follow the ABI conventions, e.g.
> +   assembler code, this method will break.  But that's ok. */
> +
>   extern "C" void
>   makecontext (ucontext_t *ucp, void (*func) (void), int argc, ...)
>   {
> @@ -2090,65 +2239,150 @@ makecontext (ucontext_t *ucp, void (*func) (void), int argc, ...)
>     uintptr_t *sp;
>     va_list ap;
> 
> +#if defined(__x86_64__)
> +  /* x86_64: Arguments beyond the first 4 go on the stack.
> +     However, we allocate shadow space for all args including register args. */
> +  int stack_args = argc;
> +
> +#elif defined(__aarch64__)
> +  /* ARM64: Arguments beyond the first 8 go on the stack.
> +     We only allocate stack space for args beyond registers. */
> +  int stack_args = (argc > 8) ? (argc - 8) : 0;
> +
> +#else
> +#error unimplemented for this target
> +#endif
> +
>     /* Initialize sp to the top of the stack. */
>     sp = (uintptr_t *) ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss_size);
> -  /* Subtract slots required for arguments and the pointer to uc_link. */
> -  sp -= (argc + 1);
> -  /* Align. */
> -  sp = (uintptr_t *) ((uintptr_t) sp & ~0xf);
> -  /* Subtract one slot for setting the return address. */
> +
> +#if defined(__x86_64__)
> +  /* x86_64: Subtract slots for all arguments + uc_link pointer
> +     and return address.  */
> +  sp -= (stack_args + 1);  /* argc + 1 for uc_link */
> +  /* Align to 16 bytes. */
> +  sp = (uintptr_t *) ((uintptr_t) sp & ~0xfUL);
> +  /* Subtract one more slot for the return address. */
>     --sp;
> -  /* Set return address to the trampolin function __cont_link_context. */
> +  /* Set return address to the trampoline function __cont_link_context. */
>     sp[0] = (uintptr_t) __cont_link_context;
> -  /* Fetch arguments and store them on the stack.
> 
> -     x86_64:
> +#elif defined(__aarch64__)
> +  /* ARM64: Subtract slots for stack arguments + uc_link pointer. */
> +  sp -= (stack_args + 1);  /* stack_args + 1 for uc_link */
> +  /* ARM64 requires 16-byte alignment at public interfaces. */
> +  sp = (uintptr_t *) ((uintptr_t) sp & ~0xfUL);
> 
> -     - Store first four args in the AMD64 ABI arg registers.
> +#endif
> 
> +  /* Fetch arguments and store them.
> +     x86_64:
> +     - Store first four args in the AMD64 ABI arg registers (rcx, rdx, r8, r9).
>        - Note that the stack is not short by these four register args.  The
>          reason is the shadow space for these regs required by the AMD64 ABI.
> -
>        - The definition of makecontext only allows for "int" sized arguments to
>          func, 32 bit, likely for historical reasons.  However, the argument
>          slots on x86_64 are 64 bit anyway, so we can fetch and store the args
>          as 64 bit values, and func can request 64 bit args without violating
>          the definition.  This potentially allows porting 32 bit applications
> -       providing pointer values to func without additional porting effort. */
> +       providing pointer values to func without additional porting effort.
> +
> +     ARM64:
> +     - Store first eight args in ARM64 ABI arg registers (x0-x7).
> +     - Arguments beyond 8 go on the stack.
> +     - Similar to x86_64, we store as uintptr_t for pointer compatibility. */
> +
>     va_start (ap, argc);
>     for (int i = 0; i < argc; ++i)
> -#ifdef __x86_64__
> -    switch (i)
> -      {
> -      case 0:
> -  ucp->uc_mcontext.rcx = va_arg (ap, uintptr_t);
> -  break;
> -      case 1:
> -  ucp->uc_mcontext.rdx = va_arg (ap, uintptr_t);
> -  break;
> -      case 2:
> -  ucp->uc_mcontext.r8 = va_arg (ap, uintptr_t);
> -  break;
> -      case 3:
> -  ucp->uc_mcontext.r9 = va_arg (ap, uintptr_t);
> -  break;
> -      default:
> -  sp[i + 1] = va_arg (ap, uintptr_t);
> -  break;
> -      }
> -#else
> -#error unimplemented for this target
> +    {
> +#if defined(__x86_64__)
> +      switch (i)
> +        {
> +        case 0:
> +          ucp->uc_mcontext.rcx = va_arg (ap, uintptr_t);
> +          break;
> +        case 1:
> +          ucp->uc_mcontext.rdx = va_arg (ap, uintptr_t);
> +          break;
> +        case 2:
> +          ucp->uc_mcontext.r8 = va_arg (ap, uintptr_t);
> +          break;
> +        case 3:
> +          ucp->uc_mcontext.r9 = va_arg (ap, uintptr_t);
> +          break;
> +        default:
> +          /* Stack arguments start at sp[i + 1] because sp[0] is return address */
> +          sp[i + 1] = va_arg (ap, uintptr_t);
> +          break;
> +        }
> +
> +#elif defined(__aarch64__)
> +      switch (i)
> +        {
> +        case 0:
> +          ucp->uc_mcontext.x0 = va_arg (ap, uintptr_t);
> +          break;
> +        case 1:
> +          ucp->uc_mcontext.x1 = va_arg (ap, uintptr_t);
> +          break;
> +        case 2:
> +          ucp->uc_mcontext.x2 = va_arg (ap, uintptr_t);
> +          break;
> +        case 3:
> +          ucp->uc_mcontext.x3 = va_arg (ap, uintptr_t);
> +          break;
> +        case 4:
> +          ucp->uc_mcontext.x4 = va_arg (ap, uintptr_t);
> +          break;
> +        case 5:
> +          ucp->uc_mcontext.x5 = va_arg (ap, uintptr_t);
> +          break;
> +        case 6:
> +          ucp->uc_mcontext.x6 = va_arg (ap, uintptr_t);
> +          break;
> +        case 7:
> +          ucp->uc_mcontext.x7 = va_arg (ap, uintptr_t);
> +          break;
> +        default:
> +          /* Stack arguments beyond the first 8 registers. */
> +          sp[i - 8] = va_arg (ap, uintptr_t);
> +          break;
> +        }

Please also put an

#else
#error unimplemented for this target

here (and in the other places it's missing)

>   #endif
> +    }
>     va_end (ap);
> -  /* Store pointer to uc_link at the top of the stack. */
> +
> +#if defined(__x86_64__)
> +  /* Store pointer to uc_link at sp[argc + 1], after return address
> +     and args.  */
>     sp[argc + 1] = (uintptr_t) ucp->uc_link;
> +
> +#elif defined(__aarch64__)
> +  /* Store pointer to uc_link at the top of our allocated area. */
> +  sp[stack_args] = (uintptr_t) ucp->uc_link;
> +
> +#endif
> +
>     /* Last but not least set the register in the context at ucp so that a
>        subsequent setcontext or swapcontext picks up the right values:
>        - Set instruction pointer to the target function.
>        - Set stack pointer to the just computed stack pointer value.
>        - Set Cygwin-specific uclink register to the address of the pointer
> -       to uc_link. */
> +       to uc_link.
> +
> +     x86_64: uclink register is rbx (callee-saved)
> +     ARM64:  uclink register is x19 (callee-saved) */
> +
>     ucp->uc_mcontext._MC_instPtr = (uint64_t) func;
>     ucp->uc_mcontext._MC_stackPtr = (uint64_t) sp;
> +
> +#if defined(__x86_64__)
>     ucp->uc_mcontext._MC_uclinkReg = (uint64_t) (sp + argc + 1);
> +
> +#elif defined(__aarch64__)
> +  /* Set LR to __cont_link_context for ARM64 (used as return address). */
> +  ucp->uc_mcontext.lr = (uint64_t) __cont_link_context;
> +  ucp->uc_mcontext._MC_uclinkReg = (uint64_t) (sp + stack_args);
> +
> +#endif
>   }
> --
