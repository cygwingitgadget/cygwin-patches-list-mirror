Return-Path: <SRS0=nBAb=RK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 3A736385734D
	for <cygwin-patches@cygwin.com>; Mon, 14 Oct 2024 06:39:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3A736385734D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3A736385734D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728887976; cv=none;
	b=SW/7aVJ4cEJsGuEVk5K/u4Txg92gjkRDs/P/hEDgD7w9xnP87hPDBFCcxMiMlEe/A8jNkdOvihWzGdh+cKXClGcprQRAwr8vvhpcf39RLqHSY0Rr7XypRElxJSU8HbMtTcxIRV0IQMq82MN9iU1fUVxASe/uG38XbiqGT/BU5Q8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728887976; c=relaxed/simple;
	bh=RlczD35A21Mux3nRWky17xfuRE3nFwAo2fSaA1HFjNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=p7FqCRLwVwyWUFhUV4gwySa7m6VoD1moAeIFCNwcuLchYfTLzIr583ekrkDsSlbPV/Cmu98Pb8cpr3sv4BHPi8ha0f+fIBoV66VaKymkPDfGU577VsKGRPXqZTab+qrVEL6pOCgQ/NDlokxLHpqfAOLnJQFRrz/oKtbJPfcbdK8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20241014063930292.JDZO.41146.localhost.localdomain@nifty.com>;
          Mon, 14 Oct 2024 15:39:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3] Cygwin: sigfe: Fix a bug that signal handler destroys fpu states
Date: Mon, 14 Oct 2024 15:39:05 +0900
Message-ID: <20241014063914.6061-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1728887970;
 bh=uY36Jip0oZkHVxx/19UEqtSUN30QvaTn+vv2cNKBI/U=;
 h=From:To:Cc:Subject:Date;
 b=FySAhprwy8v2Mi/FsVCs+JLLZExIvdpH/UMFlUog0HKA/iZHjYOLnYCV1Tn3so9tE0s844Ny
 Y6FmaqufEPKddaQ8dfDbpeiBKbDkp95qbM37G3cK5iQtqsETzHcQglkuysZqm5KlhCAqkElLvx
 z80s0QLDiT9CCHHABp4601YsxcqVBdfnigUV9IjtTYFXdGvbRROnNPGLxWPp53rCPsCNji2ZXq
 8iMEk6HUaBa86mo7JdhW0t33bCy1X9/YL3KvuMspgUw1DbbgoKnwng8f01a9EacId/UGnyv9ez
 O0UXUqDDzvYE06C6QhQPeHR3LDwa3wgp0tTO0SLPi8zH42aA==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/scripts/gendef | 91 ++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 3b1f8b9da..04350f1cb 100755
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
@@ -213,26 +213,41 @@ sigdelayed:
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
+	fxsave64 0x30(%rsp) # x86 CPU with 64-bit mode has fxsave64/fxrstor64
+	jmp	2f
+1:
+	movl	\$0x0d,%eax
+	xorl	%ecx,%ecx
+	cpuid	# get necessary space for xsave
+	movq	%rbx,%rcx
+	addq	\$0x48,%rbx # 0x18 for alignment, 0x30 for additinal space
+	subq	%rbx,%rsp
+	movl	%ebx,0x24(%rsp)
+	xorq	%rax,%rax
+	shrq	\$3,%rcx
+	leaq	0x30(%rsp),%rdi
+	rep	stosq
+	xgetbv	# get XCR0 (ecx is 0 after rep)
+	movl	%eax,0x28(%rsp)
+	movl	%edx,0x2c(%rsp)
+	notl	%ecx # set ecx non-zero
+	movl	%ecx,0x20(%rsp)
+	xsave64	0x30(%rsp)
+2:
 	.seh_endprologue
 
 	movq	%gs:8,%r12			# get tls
@@ -259,26 +274,20 @@ sigdelayed:
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

