Return-Path: <SRS0=QYF2=IX=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by sourceware.org (Postfix) with ESMTPS id 0A9A94B99F7E
	for <cygwin-patches@cygwin.com>; Mon,  2 Nov 2026 10:43:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0A9A94B99F7E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0A9A94B99F7E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::c32
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793616239; cv=none;
	b=VUfdIT9XtqzSwywOHv6yvozz2soew9wcpu6RELJHSe1BarSUgLx2y2TMjAVU6bIURfFNFr5MBaU0vM/XV803uF5tvzalCGPQldzm1i47Rh6E443Ad6agz4imss8Bo2Vlai5i+P5nltjUHQUeM1yOUpspdkGb7+EHokQz8XwROAk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793616239; c=relaxed/simple;
	bh=H+fgM6wPsdVXdfw0URTnowIEIcpEIG7rRbhXYw3wrKA=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=M5TiCzmkO5h14glIxtWTQ7ZIqxqjH9wlxDUdjHYRZJ40/Sn90N8BdO83UQFtiwmGtFt0/IF9K3fndR2H0Pv/8STLdYdlMRz8gtjfz1seNe2SAWv/jjfbVHMeDKiHV53KE7F0vECc+Xfd19uLZe28BLDcX6mNgj8DGDuLIvUjjU4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbWybKDn
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0A9A94B99F7E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbWybKDn
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-6f5a0893610so2372184eaf.1
        for <cygwin-patches@cygwin.com>; Mon, 02 Nov 2026 02:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616238; x=1794221038; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PCd3ECrZknDIpBQtH6qw7/bM9eDA2x8rN3eHbW7xTiE=;
        b=cbWybKDntOSlzi73QJOuwrBjcROy34Y1nhSd2NlHAnDlLwD9z0hyxx9kpuATn95hE3
         hRGp/uehX4jDsEP63UtLwbun802LWiuSfhE1vMH0QpOHTy8aMjK1Q5Nv4dK8hfgnQpMx
         cCrPyIkVRu0XsmB6UFiQvaigzS/0B+OocHBYMwXkIF66cLMQmePtkB3PKicsuGE+4Kn8
         eR2M0zBt0lDd3wOWm7ZMSmKtPfSIdiSiJwk02Z7Pbju5Hr5SzswOmlsjK4R90m8bp5Nb
         kgeRAiQunOhsdn2Ocur8hTjk+2jhPcZaqHkjx7YDAucXSgwaSZ1VGlQAX9S9HQ3EEIJk
         5taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616238; x=1794221038;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PCd3ECrZknDIpBQtH6qw7/bM9eDA2x8rN3eHbW7xTiE=;
        b=d15pYz/11ZqEEo4Y39yMtF80Oogy3TiWMHTEMK2TAxNk+3MT3/aDjxHvttiX6s61Iw
         ks51FsxnjU0TTBBjt/w9vkvMJYYLRJSQ6+JUcvIehu6xx59ZWy8FFvviIGnEWWLxXqkf
         SDosPW8Mi0137mF2p3R5VYTLvS0Q74ym1KHEj7pqAd37rOeul77KC4bz9fcR5ON47op9
         gwC4rCC7k1/Xd1vDlMH4UCg4XULIRtCHb0FeJ1CC+KGKsx/azycnmqmfDwMsWueGzYii
         IMMksBJPFflpocOip4dHLYUmcSKZ8IDuGV5pn6/iFH24dHlsvSy0C58kZZUIHDDgyuVA
         WlJg==
X-Gm-Message-State: AFq9FYKJmKvLvb2nmTLe43EkSOcqUlxHYH5rh1aIE30CDMEZgadk4I0G
	Ttzyt2742HVty49FmvtPepXZkdoJM6WzHnRKZ7Iw5CSm15OaQk8KKO5jlHHIT2im
X-Gm-Gg: AYBFou2ZK9FDQxp2YFUHwp+szA2bjbWFPXutkGp9Y+WmHwY7DFP1bunfZ4i+MiJ8+pu
	d7aZcGuoBF1+BH9ie1Os3XejuCAct5dS1qqizjGuI3kZzRsa6oNC9+w9uR2Qwal0QiqZRLLlI7h
	3HjDmY8/Yl9z0RKRC5Q79OOsS1WVvz2A7vjDOxs4CBCI9RncA7jGSh8ICSLmnx7qvXX6R5o8q+q
	snpc1hOWzGuAylt6yxuDAHerJRLdJVD+h0PY7jhHVF6FIkhoXxm/UPu3Tti0rN0Q2E348Yekazn
	nBdnTuSwz/R+h/Kc6UduURP8ld7OM3FN15Ntja03DXEKhZnjraXeUVtBZY8TSRsjgoSZs7WW+f7
	3SLVOu+l/fqFY5ovs5kh28zU1nW8Qyk5kfRsoaZPFUSXX+bhDLxv30f8vnl64DCt7lY7vnjoB8F
	kUQUY3R9DA1pO/xZDZiz1wog0f2P+AvLVHuI/dba+OgEFZNlIa9IkbyB1mNtjfyVN/xErmSdc8s
	u9TKzx0XM6Z92h8hwZWjP9mdxSexd9+CXEqOYg4dNDSVvYmcmDK1El5cenWh8nbtXms4bUBmR6x
	dKbWXWUDVX9oS4+Tmism8RnvjOrRB6xEHQVriKJSXXc00gRAFxgUqg==
X-Received: by 2002:a05:6820:55c4:10b0:6ce:5383:3648 with SMTP id 006d021491bc7-714f2a7ed70mr3534911eaf.68.1793616238294;
        Mon, 02 Nov 2026 02:43:58 -0800 (PST)
Received: from [127.0.0.1] ([20.98.140.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2e5b450sm8396486eaf.11.2026.11.02.02.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:43:57 -0800 (PST)
Message-Id: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 10:43:55 +0000
Subject: [PATCH] stdatomic.h: fix the type used for atomic_wchar_t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Including <stdatomic.h> fails because atomic_wchar_t refers to the undefined
type `___wchar_t` (note the triple underscore). This spelling was introduced by
the update to the FreeBSD header, which tried to avoid conflicts with clang in
https://cgit.freebsd.org/src/commit/sys/sys/stdatomic.h?id=0a4c54d6060ab057c86d65be24cf6032e7436670
(Rename __wchar_t so it no longer conflicts with __wchar_t from clang 3.4,
2014-04-01) by using the triple underscore.

The intended internal wide-character type in Cygwin is `__wchar_t` (note the
double underscore, not triple), which is already available through
`<sys/_types.h>`. Use that existing type so applications can include the header
again.

This was reported in https://github.com/msys2/msys2-runtime/issues/399.

Assisted-by: GPT-6.1 Sol
Fixes: af393fdf89a7 ("stdatomic.h: use latest FreeBSD file verbatim")
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    stdatomic.h: fix the type used for atomic_wchar_t

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-16%2Fdscho%2Ffix-stdatomic-header-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-16/dscho/fix-stdatomic-header-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/16

 newlib/libc/include/stdatomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/newlib/libc/include/stdatomic.h b/newlib/libc/include/stdatomic.h
index 67107f47e..40f2d269c 100644
--- a/newlib/libc/include/stdatomic.h
+++ b/newlib/libc/include/stdatomic.h
@@ -207,7 +207,7 @@ typedef _Atomic(unsigned char)		atomic_char8_t;
 #endif
 typedef _Atomic(__char16_t)		atomic_char16_t;
 typedef _Atomic(__char32_t)		atomic_char32_t;
-typedef _Atomic(___wchar_t)		atomic_wchar_t;
+typedef _Atomic(__wchar_t)		atomic_wchar_t;
 typedef _Atomic(__int_least8_t)		atomic_int_least8_t;
 typedef _Atomic(__uint_least8_t)	atomic_uint_least8_t;
 typedef _Atomic(__int_least16_t)	atomic_int_least16_t;

base-commit: af6327c35c85a7c5376a47d980bbade5f40eb5bc
-- 
cygwingitgadget
