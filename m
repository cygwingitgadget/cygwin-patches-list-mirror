Return-Path: <SRS0=nBAb=RK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 62DBC3858C56
	for <cygwin-patches@cygwin.com>; Mon, 14 Oct 2024 05:38:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 62DBC3858C56
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 62DBC3858C56
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728884330; cv=none;
	b=lbY/uWKBjlTLZ4wU50vMIwGEcUwCrcStb9OQY+XX4Kd8sRswpHXXQQreqLu1y+HLwggkX5tfSHWsRRmUtrTSIQwXoDMZhyCMqeL2vTtI9mNiB8WEFZ7I0/y0AeiTlDrplFen+sngwzzZC41orJdJCbabBZ/12DLfTA4TP5rSZx0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728884330; c=relaxed/simple;
	bh=5sTymZ+TRpqglIcHaD/b93vAsbxXwhcFmqtdZ24bS0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=M7CLuHM+zVqxySwyBDyLbDTcM/ABQG0qkDS0f6RTahdkbbc0xDxtDYjqV40L/xEufxedH/ewsRNeeGOdf49szOAY23OUL9aZpsMDYXwTsPcbMsl1NoxY02PYvp6DI9XSG8WTe7c85P8B8ixj00bn2jk9LLBnKS5ehkkFN3AavPM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w10.mail.nifty.com
          with ESMTP
          id <20241014053845765.ZBYA.17412.localhost.localdomain@nifty.com>;
          Mon, 14 Oct 2024 14:38:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v2] Cygwin: sigfe: Fix a bug that signal handler destroys fpu states
Date: Mon, 14 Oct 2024 14:38:21 +0900
Message-ID: <20241014053829.1010-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1728884325;
 bh=N41A1U5F7drbN26A+SxHPYyvKgnIzyPGxGV9lPAWJT0=;
 h=From:To:Cc:Subject:Date;
 b=Ff9/eU53hs/HPp5pzAcTJxI6fiUisNkP6AslNg5225TU8tDciSyZMwxDGvG5Mg1coKnzsjI7
 5cqt8+ttCQhuvQxWr7+z85le/cVv2F8YG+l1JpTMuSkco82h0TgJCpQtrwo8YB+U3BDo4YNpvs
 PfFSxpHWgQ2GRWql2WQufpAFAQyyzI4XT/0g/NKgw76nON3KUGvcDJL3qXZHvnedjt+GCXo7wH
 MSWdnfEWBzN4XmH2J8ehjjyGB0BJULbzrqUo6i7TIDuRKkTAwgT9La3JtL4cqKztFnBu+YHOz6
 z8jf+TP3yRKpKkOwLjDUkBOe9UiXvDhmbfZ0YKicWTVX7wBQ==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, sigfe had a bug that the signal handler destroys fpu state.
This is caused by fninit instruction in sigdelayed. With this patch,
saving/restoring the FPU/SIMD state is done using fxsave/fxrstor or
xsave/xrstor rather than fnstcw/fldcw, stmxcsr/ldmxcsr and push/pop
xmm0-xmm15. Since xsave/xrstor is used, not only x87/MMX/SSE states
but also AVX/AVX2/AVX-512 states can be maintained unlike before.
Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256503.html

Fixes: ed89fbc3ff11 ("* gendef (sigdelayed (x86_64)): Save and restore FPU control word.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Suggested-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/scripts/gendef | 92 ++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 41 deletions(-)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 3b1f8b9da..1b2e41559 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -185,7 +185,7 @@ sigdelayed:
 	# make sure it is aligned from here on
 	# We could be called from an interrupted thread which doesn't know
 	# about his fate, so save and restore everything and the kitchen sink.
-	andq	\$0xfffffffffffffff0,%rsp
+	andq	\$0xffffffffffffffc0,%rsp
 	.seh_setframe %rbp,0
 	pushq	%r15
 	.seh_pushreg %r15
@@ -213,26 +213,42 @@ sigdelayed:
 	.seh_pushreg %rbx
 	pushq	%rax
 	.seh_pushreg %rax
-	subq	\$0x128,%rsp
-	.seh_stackalloc 0x128
-	stmxcsr	0x124(%rsp)
-	fnstcw	0x120(%rsp)
-	movdqa	%xmm15,0x110(%rsp)
-	movdqa	%xmm14,0x100(%rsp)
-	movdqa	%xmm13,0xf0(%rsp)
-	movdqa	%xmm12,0xe0(%rsp)
-	movdqa	%xmm11,0xd0(%rsp)
-	movdqa	%xmm10,0xc0(%rsp)
-	movdqa	%xmm9,0xb0(%rsp)
-	movdqa	%xmm8,0xa0(%rsp)
-	movdqa	%xmm7,0x90(%rsp)
-	movdqa	%xmm6,0x80(%rsp)
-	movdqa	%xmm5,0x70(%rsp)
-	movdqa	%xmm4,0x60(%rsp)
-	movdqa	%xmm3,0x50(%rsp)
-	movdqa	%xmm2,0x40(%rsp)
-	movdqa	%xmm1,0x30(%rsp)
-	movdqa	%xmm0,0x20(%rsp)
+
+	# +0x20: indicates if xsave is available
+	# +0x24: decrement of the stack to allocate space
+	# +0x28: %eax returnd by cpuid (0x0d, 0x00)
+	# +0x2c: %edx returnd by cpuid (0x0d, 0x00)
+	# +0x30: state save area
+	movl	\$1,%eax
+	cpuid
+	andl	\$0x04000000,%ecx # xsave available?
+	jnz	1f
+	movl	\$0x248,%ebx # 0x18 for alibnment, 0x30 for additinal space
+	subq	%rbx,%rsp
+	movl	%ecx,0x20(%rsp)
+	movl	%ebx,0x24(%rsp)
+	fxsave64 0x30(%rsp) # x86 CPU in 64-bit mode has fxsave64/fxrstor64
+	jmp	2f
+1:
+	movl	\$0x0d,%eax
+	xorl	%ecx,%ecx
+	cpuid	# get necessary space for xsave
+	movq	%rcx,%rbx
+	addq	\$0x48,%rbx # 0x18 for alignment, 0x30 for additinal space
+	subq	%rbx,%rsp
+	movl	%ebx,0x24(%rsp)
+	movl	%eax,0x28(%rsp)
+	movl	%edx,0x2c(%rsp)
+	xorq	%rax,%rax
+	shrq	\$3,%rcx
+	leaq	0x30(%rsp),%rdi
+	rep	stosq
+	notl	%ecx # set ecx non-zero
+	movl	%ecx,0x20(%rsp)
+	movl	0x28(%rsp),%eax
+	movl	0x2c(%rsp),%edx
+	xsave64	0x30(%rsp)
+2:
 	.seh_endprologue
 
 	movq	%gs:8,%r12			# get tls
@@ -259,26 +275,20 @@ sigdelayed:
 	xorl	%r11d,%r11d
 	movl	%r11d,_cygtls.incyg(%r12)
 	movl	%r11d,_cygtls.stacklock(%r12)	# unlock
-	movdqa	0x20(%rsp),%xmm0
-	movdqa	0x30(%rsp),%xmm1
-	movdqa	0x40(%rsp),%xmm2
-	movdqa	0x50(%rsp),%xmm3
-	movdqa	0x60(%rsp),%xmm4
-	movdqa	0x70(%rsp),%xmm5
-	movdqa	0x80(%rsp),%xmm6
-	movdqa	0x90(%rsp),%xmm7
-	movdqa	0xa0(%rsp),%xmm8
-	movdqa	0xb0(%rsp),%xmm9
-	movdqa	0xc0(%rsp),%xmm10
-	movdqa	0xd0(%rsp),%xmm11
-	movdqa	0xe0(%rsp),%xmm12
-	movdqa	0xf0(%rsp),%xmm13
-	movdqa	0x100(%rsp),%xmm14
-	movdqa	0x110(%rsp),%xmm15
-	fninit
-	fldcw	0x120(%rsp)
-	ldmxcsr	0x124(%rsp)
-	addq	\$0x128,%rsp
+
+	movl	0x20(%rsp),%ecx
+	testl	%ecx,%ecx # xsave available?
+	jnz	1f
+	fxrstor64 0x30(%rsp)
+	jmp	2f
+1:
+	movl	0x28(%rsp),%eax
+	movl	0x2c(%rsp),%edx
+	xrstor64 0x30(%rsp)
+2:
+	movl	0x24(%rsp),%ebx
+	addq	%rbx,%rsp
+
 	popq	%rax
 	popq	%rbx
 	popq	%rcx
-- 
2.45.1

