Return-Path: <SRS0=Jx4T=G6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 589A74BB3B93
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 19:22:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 589A74BB3B93
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 589A74BB3B93
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788722567; cv=none;
	b=gc9dIm6DHYpGQveyYUyy5SgI4aOKZ744LrM9+4V/goWUpobmCS0LVugZN892BgowusRLeRefVlslUmu+mn0gLjdDZDjl0eB65BJQbWXtkK/6SsadFLVLOinRBNkGFUcqZHZNNJUR/8MhZqTbYsEaPLWVMxwVt8W/eQSbtPre8Mk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788722567; c=relaxed/simple;
	bh=bOX3CxUeThl3jzxrn2tk6E7ggwBzvyrOuESpa/MQt+k=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=CeLJb8snse4FkAM65fv3RGg79IZXhl1Fak3/n++fKFwhHHlAx+MU9NyJN6QVwT/LT10x4+B0bTw+FbrQJv15mtrTx+t+BoGCQfZ0C09GlWoQKQe1j4JV481zP1ZBwJLx+WBaBTYHchwWC9AtkRAImZpgglgsqWrYDEEr85O2RiI=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 589A74BB3B93
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715D810614F0B2
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEsobNzThzRilAT/5YmcFjMmt7o9zzlCGUHu1VSlCKHotvcgHcuAiwTLhWGYoiRUtbIseZzry1nx/wTf3jE0q1un91mkHruFcNcRk/NSc71zWmbfizHHXXYxyhuWDLIoLRfpUwQFHY2v4yHS5Z57G09vP5LJGPueuZ/3tsTb16IgA/ZZHghwFh86hiUZnQy11J8UQpza77L6JZibc+5ky/r9pHurY+fQ1LHhHsT/XOGcqeli3S/X4+WUt0N+c5ep8xumXrLnAfvk7fVS048FeWYdKk8YegaB04RYojxN3vzcDOWgS9XEVwJCg42DKrtltVuDaSyEDcZYyUwvXh0bK7TQ2JUPWRlT/gj81Dm1yogOC1onysKMv+XYy36czGhcaWBLvCaS135YkBiLIjBVbWWumNGgG3Naxwg/PJp13n4hB7KcQ0TH3MGIhxR3A98vdZmYReAs/bR+nhgWTGe2gvmksiWWGuUsZvGPD/3CI0646LhdhgNRjAJcsxctYbFHg9D+LQCsTLvRMTSJmRkscK8DnJCNbe7cPw5NMbXoMVZE0LdQ8uiy7rAmwHxGtz7+jktLi8FuvNIv728HG2ttDa7LD8AHQZiUH1NnoHPgRbcVfDRkdgFQ+/6zWxAa7TU4LDnn0lXBWjIB8nVzYIXWz7IGf74cpoE/aJqyo9Pt3SCKA
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715D810614F0B2; Sun, 6 Sep 2026 20:22:45 +0100
Message-ID: <9b40d35d-1641-4bf5-81a7-1b46a771d987@dronecode.org.uk>
Date: Sun, 6 Sep 2026 20:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: Add AArch64 support for signal handling and
 ucontext
References: <PN3P287MB132037F714481EAD3C475C65F7C12@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
In-Reply-To: <PN3P287MB132037F714481EAD3C475C65F7C12@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/07/2026 13:51, Aswin Kalies Ramkumar Mangayarkarasi wrote:
> Hi Jon,
> Thanks for the review.

No problem! Apologies again for the long delay in getting around to 
looking at this.

> This is a follow-up patch to: https://cygwin.com/pipermail/cygwin-patches/2026q3/015206.html
> Responses inline below; v3 addresses all of the review points.
> For testing, we built a standalone ucontext/altstack test suite and ran it against a freshly built cygwin1.dll on Windows ARM64. The tests cover getcontext/setcontext/swapcontext/makecontext round-trips, odd argument counts (9–13), NULL uc_link exit behaviour, a 5000-iteration swapcontext loop, and an SA_ONSTACK signal handler.
> We also ran a four-way isolation matrix where each branch reverted exactly one of the three fixes to verify that each change is independently required. Reverting the setcontext hand-restore causes every makecontext/swapcontext test to crash with STATUS_STACK_BUFFER_OVERRUN, matching the pre-port baseline. Reverting the trampoline (including the sp,x19 fix and mov w0,#0xff) causes the odd-argc tests to fail with STATUS_DATATYPE_MISALIGNMENT, and the NULL uc_link test exits with 0 instead of 0xff.
> I agree there's nothing in the upstream testsuite covering this yet. I'm happy to contribute these tests as a follow-up if that would be useful.

Great! That's very impressive work.

Yes, please! It would be good to have these in our testsuite. Please ask 
if you have any questions about doing that.

> Regarding the clobber list in call_signal_handler, the previous comment was misleading. The clobber list is serving two distinct purposes, and I've rewritten the comment to explain that. x0-x7, x9, x10, and x29 are explicitly used by the assembly as scratch/argument registers and are listed as clobbers to prevent GCC from allocating "r" input operands into registers that the assembly overwrites before reading. The x86_64 version doesn't need this because its inputs are "o" memory operands. x8, x11-x17, x30 (clobbered by blr), and v0-v7/v16-v31 are the normal caller-saved registers clobbered by the C call to altstack_wrapper. x18 (TEB) and v8-v15 (callee-saved on Windows) are preserved and therefore omitted.>   So the registers you pointed out aren't redundant with the explicit 
save/restore sequence. Removing them would allow GCC to place an input 
operand into a register that the assembly overwrites before reading it. 
That said, I'm also happy to convert this path to "o" memory operands 
like the x86_64 implementation if you think that's the cleaner approach. 
I kept "r" operands simply to minimise churn in the already-tested assembly.

No, that's fine. I hadn't considered the input registers at all. So it 
makes sense now.

>   For RtlRestoreContext, unfortunately I haven't found any Microsoft documentation describing this behaviour. The STATUS_ILLEGAL_INSTRUCTION failure on a synthetic context was discovered empirically. I also tried setting ContextFlags = CONTEXT_FULL on the makecontext-generated context in case RtlRestoreContext required a particular flag mask, but it made no difference. The hand-restore is genuinely required. I've added a comment noting this.>   For the 272 constant, I've added a comment explaining that it's the 
byte offset of the V-register array within struct __mcontext, whose 
layout mirrors the Windows ARM64 CONTEXT structure. The comment now also 
documents all offsets used by the routine.

Thanks.

>   Regarding x17 and CPSR not being restored in setcontext, this is the same asymmetry as in the earlier incyg fix, but you're right that it should be documented explicitly rather than left implicit. The omission is intentional. x16 (IP0) and x17 (IP1) are the ABI-defined intra-procedure-call scratch registers. This implementation uses x16 as the base register and x17 as the branch target, and the ABI already permits linker-inserted veneers to clobber both registers, so a ucontext consumer cannot rely on either surviving a setcontext() regardless. Their saved values are therefore intentionally not restored. CPSR is likewise not restored because there is no EL0 instruction that restores the entire register, and the only architecturally visible state that user code could reasonably care about (NZCV) is caller-clobbered across the makecontext()/swapcontext() boundary that this code serves. glibc and musl take the same approach on AArch64. I've added comments explaining this.
>   Finally, I've fixed both the "return address on the stack" comment and the missing makecontext #error cases. The header comment now states that the continuation trampoline is reached via a stack return slot on x86_64 but via lr on AArch64. I also added the missing #else / #error unimplemented for this target to each of the four #if defined(x86_64) / #elif defined(aarch64) blocks in makecontext.
Great. Thanks for addressing all my little quibbles!

I applied this patch.

