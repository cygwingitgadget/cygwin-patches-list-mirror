Return-Path: <SRS0=rKhI=RI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 0696D3858D20
	for <cygwin-patches@cygwin.com>; Sat, 12 Oct 2024 23:09:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0696D3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0696D3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728774544; cv=none;
	b=Ji0tvQUdhX/nhR8SDjGS3I+z8UFkAv8mzyMyMb/nqGnhcwjSrhcqNICn1LgEXId21lC4xFyHDLV30ywTVzqzsNnA7qt2AOo51ZJzMKzcOoTFo+9ZNPc9YUpkw8ypurGF5WuvLJYsLMFz8Cug9oEK7OIrfNijrQqXd9oU+OHLbqA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728774544; c=relaxed/simple;
	bh=w3owZnEqzx309IzjtBek1t+IDCoMUFyYOKrFjkU3In4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=gIW6eV45twJTk5Yc9F5OmqYC+L+lXuqJLA3cXRt5kluPzqooJgEuGI6xJUyfe+13PhFfOXqUj7uG5o1zQgdW4lpLZP1dVGrVTNSuHhZTj3eMmnvum2ZGpH8ts9mNcRS9m+SMPSXsg9o6JxRuDsrZBYvRMeR+hRFSmVc8Kda/Agg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20241012230858736.ZINL.69727.localhost.localdomain@nifty.com>;
          Sun, 13 Oct 2024 08:08:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] Cygwin: sigfe: Fix a bug that signal handler destroys fpu states
Date: Sun, 13 Oct 2024 08:08:34 +0900
Message-ID: <20241012230843.1906-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1728774538;
 bh=QE2hZf7ZiPFkzvJ+NJfhxLsBox8n4yVcnBM2ZE8MoOE=;
 h=From:To:Cc:Subject:Date;
 b=Bff6RHCA5EkwyPu3FUXJK7WTtneLMIcLUwDMiqrJeiPFkLf26qR4jW929uvCOKWdHLUEvsXY
 MIH3MX6M8hgQPUjwKYiHVvTWCOWrfVLboNyRJ3xd2ierPmqxp9zTnwWHU5g/Tdoef9bw4eVPyc
 Prhu6AbHnKw8NcolefelGxm95ww5/6IEQ+R8zojaCe4XLrmKXUbJOgPDesBkIaajtY+qjNBQvR
 RpZ9HfuoqAeCWm3zBkGN1/K7VODAaf7iqbh7HYVRG5u1uyAubtLwZVj+3ux6+BOamsD+A1bltn
 5QAOzLzxJ/x5gw99t91apX7Rq34pvduSxQQKKo2gTaWMUGJg==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, sigfe has a bug that signal handler destroys fpu sate.
This is caused by fninit instruction in sigdelayed. With this patch,
saving/restoring the FPU/SIMD state is done using fxsave/fxrstor or
xsave/xrstor rather than fnstcw/fldcw, stmxcsr/ldmxcsr and push/pop
xmm0-xmm15.
Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256503.html

Fixes: ed89fbc3ff11 ("* gendef (sigdelayed (x86_64)): Save and restore FPU control word.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Suggested-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/scripts/gendef | 93 ++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 3b1f8b9da..cd9d2a2f0 100755
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
@@ -213,28 +213,43 @@ sigdelayed:
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
-	.seh_endprologue
 
+	# +0x20: indicates if xsave is available
+	# +0x24: decrement of the stack to allocate space
+	# +0x28: %eax returnd by cpuid (0x0d, 0x00)
+	# +0x2c: %edx returnd by cpuid (0x0d, 0x00)
+	# +0x30: state save area
+	movl	\$1,%eax
+	cpuid
+	andl	\$0x04000000,%ecx # xsave available?
+	jnz	1f
+	movl	\$0x238,%ebx # 0x08 for alibnment, 0x30 for additinal space
+	subq	%rbx,%rsp
+	movl	%ecx,0x20(%rsp)
+	movl	%ebx,0x24(%rsp)
+	fxsave	0x30(%rsp)
+	jmp	2f
+1:
+	movl	\$0x0d,%eax
+	xorl	%ecx,%ecx
+	cpuid # get necessary space for xsave
+	movq	%rbx,%rcx
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
+	xsave	0x30(%rsp)
+
+2:
 	movq	%gs:8,%r12			# get tls
 	movl	_cygtls.saved_errno(%r12),%r15d	# temporarily save saved_errno
 	movq	\$_cygtls.start_offset,%rcx	# point to beginning of tls block
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
+	fxrstor	0x30(%rsp)
+	jmp	2f
+1:
+	movl	0x28(%rsp),%eax
+	movl	0x2c(%rsp),%edx
+	xrstor	0x30(%rsp)
+2:
+	movl	0x24(%rsp),%ebx
+	addq	%rbx,%rsp
+
 	popq	%rax
 	popq	%rbx
 	popq	%rcx
-- 
2.45.1

