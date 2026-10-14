Return-Path: <SRS0=G8rF=IE=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by sourceware.org (Postfix) with ESMTPS id 5B29C4BA2E15
	for <cygwin-patches@cygwin.com>; Wed, 14 Oct 2026 07:14:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5B29C4BA2E15
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5B29C4BA2E15
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::f32
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791962055; cv=none;
	b=Hvoj6EFFpOelcOqfMm7j6uCG6ZqsK+miyVv7UTXmOeV8F6OjvHd5MWGD0z3iVApCKgk/kTl1q3Hd4Z+g2W/96dtZHLGm/6S35ZG47N1dOUF0MI289v4WcCmjno8dvzjOPVSnqYxsk3uCyRsSFhTrhxNiKknBsOmwncVD+ZCwdic=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791962055; c=relaxed/simple;
	bh=lmmeVYtg4yGqFZVStyvXET81L68O6rgyg+EB0UA2qCc=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=DY4nAsQU+pix6brILH22XD1FMfR/Yo33LhERRpiO6Mv7YGyzk2jGmVf4hcNX/fgnJYpeFsA3odD32RvFA0tBjDdMwtbLpPMfFMz7B+Y7BoM4d6mz/aYwGk8LtgC2Akydt00tOiTIzsLjqLJFz19pClnzVVFGlZpwu3lNEs9SCbY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JUKj+3U5
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5B29C4BA2E15
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JUKj+3U5
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-91b64fb6010so47302126d6.1
        for <cygwin-patches@cygwin.com>; Wed, 14 Oct 2026 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962055; x=1792566855; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IF7XcmIzH8ylV7wRAcOh9TnvMoKCjI0zIG0vow9sSQU=;
        b=JUKj+3U5W6GY5XGL1UZZHp4W25LgJTW6wxgYgsIh1QkRDIps8Gm+zUCOUqUpBL8xMG
         izoS+BCd1ibjJAt3dIDRuNGxMQIB+icfQjW7I4oJVATSQA+3o6xhHo1rOviRHOHwXODg
         bRVgmR1Nij9S86GHWaM+JJMxg36lT1P9uCeTokNoQ4i0aqOt+diGg7VARJy5W8K1enJV
         ooh8A9a/Vbi0mCir9zljzWypVrAU/AnA4JRdGGxN5ISnSNmvDzB+1c2Xa0OJeiR1Gkkl
         vjDGsV5lvAnfnb6vV6ujADO6unjLiDpVEIOmuPbAjErAeyI9gJ3OTQsP89GazWDSeCxd
         fijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962055; x=1792566855;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IF7XcmIzH8ylV7wRAcOh9TnvMoKCjI0zIG0vow9sSQU=;
        b=UISNXZKB2EkVAKfS/H1i0ZWXzvP/xWAi2Y21QtqlU4vwpKk8prs2i+uGN+vrIBTVIL
         fQkfksGAy1XtWFAJAIe2hpMmeJ76zB4TesN9Sm9aoeQHAk8ExSRZ/gP9vwLjll5rkmXr
         VeUYP2NM9ncTjx1tQWqMxILGWSq3f44hUgC4fGpR8T8QCvlvZ4MqebD7xJFUPJisbCqx
         gG9FITCP6XN87HfOLM6BGpWAzhFo25QgRLVE3yyeJxI+HY3dYTXANSf45F/15J4aVFFS
         qrVaZIYXYYaPWYrgyS60ZBmkeeBCzYbSqaAcSeCZgSgBTu413zYroQpox+DONhGMN5zj
         KJuQ==
X-Gm-Message-State: AFq9FYLHiRdTbinudVN/2Yh7/wVkzPtdIysC8S7lUtV9/xrAbitBV7ga
	9YeFhDyirXtCIuc0u28CSVMpjPAj72FJ84b6PHufAg7vW94SRd3bNSpzIhOZgv9N
X-Gm-Gg: AYBFou29T1UkYRS91pYYnJpGCrjU+pd0jy6D1J5HarwjXKknSbQOhXX7KcjqXs/e1Oe
	s6HpmLlzi0+tzFKrGlNie+1PrZjo1RE1ZN6Ayld9+a9XFmn/EG0AWIooKDKP2wvqgQg/7uTYlRi
	crjpcuPGb3i5L0qSItYLHj6G8/zCbpyjqNI4vIZXVky36NH1O26HqKIIOb4/Zq+GUAAaM95Cxyg
	bZZukRRIA8AaQyLfPZIWRlk68fv99tgbwlXKSE8ux6Kb5OVLYlInGuLTUXEfX9w9aNWfMd/U4zd
	kGre+uCX9RaCc475H8ikRAOsSvmb/LTJ3qYmCQ6DpVXeP1+eJ9ylcN+afisCD1jQ66HlFlIiy7N
	IQ/FTM3oQHs4HgpKIobK8GF2OmsLvSvoh9Q7xMROI9FMrUMvT244p6cwzSwqapuEQEPeN82yCom
	yesyKEoM/X4x0CxZVIeeHbiAkoFlmDrekxqtTN3XF5dlPvhOhiAoZWpuHw/46XUUPlXZCMeofN5
	Q==
X-Received: by 2002:a05:620a:1a23:b0:93e:5ff9:a8f4 with SMTP id af79cd13be357-93ec121d237mr2162765985a.0.1791962054679;
        Wed, 14 Oct 2026 00:14:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.198.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50947e6sm428008985a.42.2026.10.14.00.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:14:14 -0700 (PDT)
Message-Id: <pull.14.cygwin.1791962053716.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 07:14:13 +0000
Subject: [PATCH] Cygwin: sigdelayed: guard XSAVE allocation against broken
 CPUID emulation
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Lars Dammann <lars.dammann@coherent.com>
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Lars Dammann <lars.dammann@coherent.com>

`CPUID(0xD, 0)` returns the XSAVE area size in the low 32 bits of RBX. A
conforming implementation clears the upper 32 bits, but broken CPUID
emulation may leave the upper half of the register stale.

This was observed when TwinCAT eXtended Automation Runtime (XAR) was
running. Its kernel-level real-time component appears to intercept CPUID
and restore only the lower half of a saved register, allowing stale
upper bits to leak into unrelated processes. Obviously, it is a bug and
it has been reported to Beckhoff (the developer of TwinCAT), and at time
of writing it is unclear what they are doing about it.

Cygwin's `sigdelayed` uses the full-width RBX value both for XSAVE stack
allocation and, after copying it to RCX, for clearing the XSAVE buffer.
Stale upper bits can therefore turn a small allocation into a
multi-gigabyte stack adjustment and cause an access violation.

Let's zero-extend EBX immediately after CPUID, before using RBX as a
64-bit value. This has no effect on conforming implementations and
protects against broken CPUID emulation even if Beckhoff should take
their sweet little time to fix their bug.

Addresses: https://github.com/msys2/msys2-runtime/issues/363
Signed-off-by: Lars Dammann <lars.dammann@coherent.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Cygwin: Guard XSAVE allocation against broken CPUID emulation
    
    This is a work-around, fair and square, for a bug in TwinCAT Standard
    XAR
    (https://www.beckhoff.com/en-en/support/download-finder/search-result/?download_group=97028364).
    They evidently override the CPUID call, incorrectly, as
    https://intel.github.io/SDM/instruction/CPUID.html clearly states:
    
    On Intel 64 processors, CPUID clears the high 32 bits of the
    RAX/RBX/RCX/RDX registers in all modes.
    
    However, it is unclear when (or whether!) they will acknowledge that
    bug, let alone fix it, and in the meantime TwinCAT users are
    experiencing Access Violations for benign invocations such v=$(echo
    Hello). So here is a work-around that does not do any harm but helps
    TwinCAT users.
    
    This patch upstreams https://github.com/msys2/msys2-runtime/pull/378.

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-14%2Fdscho%2Fprotect-from-broken-cpuid-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-14/dscho/protect-from-broken-cpuid-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/14

 winsup/cygwin/scripts/gendef | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 861a2405b..f66165d40 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -232,6 +232,7 @@ sigdelayed:
 	movl	\$0x0d,%eax
 	xorl	%ecx,%ecx
 	cpuid	# get necessary space for xsave
+	movl	%ebx,%ebx # clear upper 32 bits from a faulty CPUID implementation
 	movq	%rbx,%rcx
 	addq	\$0x48,%rbx # 0x18 for alignment, 0x30 for additional space
 	subq	%rbx,%rsp

base-commit: af6327c35c85a7c5376a47d980bbade5f40eb5bc
-- 
cygwingitgadget
