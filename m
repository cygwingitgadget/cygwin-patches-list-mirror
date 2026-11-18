Return-Path: <SRS0=TgIJ=JH=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by sourceware.org (Postfix) with ESMTPS id 9A5DE4BA2E22
	for <cygwin-patches@cygwin.com>; Wed, 18 Nov 2026 10:55:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9A5DE4BA2E22
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9A5DE4BA2E22
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::32b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794999357; cv=none;
	b=ZXxUOwzI/Ug/k+k8eEG5SkmgQljczQVyi5KdidSB5/8sJyuUCvHr0vqDOn0Y9lMG1IfTTwOOdUp6VlF6ghskW1jVtjEzsMKDz+V9VgbNIzINaD3oUmTqNZFRWNVLhI/k2BnGKv8SVhxq5kSX2KqZ7SRoCjWGWUi7371oON3TKZ0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794999357; c=relaxed/simple;
	bh=kC9gOvsFuJmABEvrGYjUc+O29sGRHsSj1h+0br5nLww=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=E0clgO++7lx7Do0ihgxrSZXq2jP6VEtQrSqKipHP5HDfDcXckA0vWH9mcSZpenSEv8tW9wspd3330GNIcoW07F6FZTB/F7PmRbQAB+vmdmtbg/jHTgC1tUPwPaiz7BA0wZ9cj9+OzpWZdqVKY6F/dc7eglhnPbJduvpGhYafEaQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n49keNKr
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9A5DE4BA2E22
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n49keNKr
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-8629fc8ad64so416929a34.1
        for <cygwin-patches@cygwin.com>; Wed, 18 Nov 2026 02:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794999357; x=1795604157; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hVUPINV9OqDXLoZ7k9Ljv2+udwu3vsfunS9sYvZa19A=;
        b=n49keNKrXLKa4caH7uLhjzqY2UoaS4Pt+qeJ7pJJ+HRm84TwzaD0XSAfKLihGmHFg6
         3PAXvN5O9ecMMI96Yk+Z+JMovdZ2TJ0i/mj3491x8+XRbeUBCqB7c2tAJWQ5TkZMq+EU
         h5f+4yuKp1JoedR8xDcrNhzsGsc+j3GnNwsRgn7zKMpUwsnavezBHPJRVx2bKRBuTLi1
         f8Rcbbjwzz0Imkgf5Xthw+yE0MJ1vjPVCpthps4vZcTIHNbpS5lcOVkdwZ2OxVYGEWRd
         vGUVYvsXe+31XDFJaT75iFNa9zgliH8/BEPdnWNGIaQAk3CgFOh8zWU2R+SPtqVCstfD
         /kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999357; x=1795604157;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVUPINV9OqDXLoZ7k9Ljv2+udwu3vsfunS9sYvZa19A=;
        b=GfMb1b8BplN4aKiAE+zWtkxjLbjcveviNrORVB+4HUX6vMPCaRGe0chD8KS7yQNO71
         Lh45QH21hiuQ2YKdm4kn8+2SEIEHr2hGHXfjpI35Z53fYQyY+JheI85J+X6yFy33RtmP
         rv1eBD4N9Rl6JZvADY8SNxM5Wqkgg18KCppo4ezhd5HJaM9UwQye2gcFXIpoOqNBGgBO
         iLqMqzWlUVMJ1XqKtrD1J3irLdHKGgEGLV8jCCbUCOSckSEATfZ6dCbvxfdRJESMXMmT
         Ndc3a59lucAGV4WF09nOxIEftEyikUIYXYBn/aCJeIpKUjAs+15yStt2mojcj+HP/W83
         KmjA==
X-Gm-Message-State: APuU4Z829QVgQnASgZhvMP9jSvoC/V/HUNjuIGjyFd2j8BRgC3Ain1Gy
	kJDg9M1RVsMOfsFF9V7s05cd9OmVd9ZeGpH4Z489bGdFc1pZwuCKkOVfCwo3qg==
X-Gm-Gg: AYBFou3qDxAlqCtJjFegmhgrlf2HGkGN+dtE/mXANJo3F61Vw/6KtoGD55pi9Jp/D5U
	9B/VtL5mzVtUmwZAmupXsEeDKe1SEIchmq43BtpKZ6rxPj3MMhk3DvpIu2dtMNVDtrr4BxMAK5F
	Ae46KDW6sOD9NCSP1ipRU+WpfrblG1Kj10ANrpiGW9U0u/GOT4SrYdE4y3rS/i7jUdLgnUSYseC
	+M5EX/i1E08vGRKHj8xd2DigoGTwj29cRc4SVmEHrRq8YjY10MaMvKy49pjSX1+cPBTCPf3QjMH
	EK/2adOQaq8Jf69zFlJt3guDPAq82MBk2Qcv6a1yDZ6Bov7ypevjChPoJodmSIV1IpcM248cKlA
	QyCXbPiNzZgl3P64K+M8OR/xO9kJ3oafwC0ow/hOXP+MH7mv52yphoBUd6RN9FyHeafR0OkKy56
	jFlAOrc1EWfjrVCfqMNAtW1PaurE23jyco7MP1y0gFFiPVHb+ayDaIbOU6v2Mpj6oKsLuXc/Clw
	1VodGPoREDZpnAC8fY5r/BIlgS3QDCDjzfy217zZZBTt9MB23PULy5Qtefg3WQnnHylP7iI5S1+
	WnYfNrvWdDp12cU+A3iahtHhHc5uySMgYpY=
X-Received: by 2002:a05:6830:441e:b0:862:a0ce:f556 with SMTP id 46e09a7af769-862f0793f8bmr2360852a34.2.1794999356758;
        Wed, 18 Nov 2026 02:55:56 -0800 (PST)
Received: from [127.0.0.1] ([135.232.177.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01381f5sm1702234a34.3.2026.11.18.02.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:55:55 -0800 (PST)
Message-Id: <pull.16.v2.cygwin.1794999354705.gitgitgadget@gmail.com>
In-Reply-To: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com>
References: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Nov 2026 10:55:54 +0000
Subject: [PATCH v2] Modify atomic_wchar_t reference to use __wchar_t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: ASSI <Stromeko@nexgo.de>,
    Jon Turney <jon.turney@dronecode.org.uk>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Jeff Johnston <jjohnstn@redhat.com>
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeff Johnston <jjohnstn@redhat.com>

This is a backport of 209858c89d (Modify atomic_wchar_t reference to use
__wchar_t, 2026-06-09) to the `cygwin-3_6-branch`.

Fixes: https://github.com/msys2/msys2-runtime/issues/399
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    stdatomic.h: fix the type used for atomic_wchar_t
    
    Including <stdatomic.h> currently fails because atomic_wchar_t refers to
    the undefined type ___wchar_t (note the triple underscore). This
    spelling was introduced by the update to the FreeBSD header, which tried
    to avoid conflicts with clang in
    https://cgit.freebsd.org/src/commit/sys/sys/stdatomic.h?id=0a4c54d6060ab057c86d65be24cf6032e7436670
    (Rename __wchar_t so it no longer conflicts with __wchar_t from clang
    3.4, 2014-04-01) by using the triple underscore.
    
    The intended internal wide-character type in Cygwin is __wchar_t (note
    the double underscore, not triple), which is already available through
    <sys/_types.h>. Backport 209858c89d4feb342857255be8c10862c1ad9d8b that
    is already on main to use that existing type so applications can include
    the header again.
    
    Changes since v1:
    
     * Clarified that this is actually a straight backport of a commit from
       main onto the cygwin-3_6-branch, and therefore no re-route via the
       newlib mailing list is needed at all.

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-16%2Fdscho%2Ffix-stdatomic-header-v2
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-16/dscho/fix-stdatomic-header-v2
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/16

Range-diff vs v1:

 1:  cf2b7f207 ! 1:  5b85515fe stdatomic.h: fix the type used for atomic_wchar_t
     @@
       ## Metadata ##
     -Author: Johannes Schindelin <johannes.schindelin@gmx.de>
     +Author: Jeff Johnston <jjohnstn@redhat.com>
      
       ## Commit message ##
     -    stdatomic.h: fix the type used for atomic_wchar_t
     +    Modify atomic_wchar_t reference to use __wchar_t
      
     -    Including <stdatomic.h> fails because atomic_wchar_t refers to the undefined
     -    type `___wchar_t` (note the triple underscore). This spelling was introduced by
     -    the update to the FreeBSD header, which tried to avoid conflicts with clang in
     -    https://cgit.freebsd.org/src/commit/sys/sys/stdatomic.h?id=0a4c54d6060ab057c86d65be24cf6032e7436670
     -    (Rename __wchar_t so it no longer conflicts with __wchar_t from clang 3.4,
     -    2014-04-01) by using the triple underscore.
     +    This is a backport of 209858c89d (Modify atomic_wchar_t reference to use
     +    __wchar_t, 2026-06-09) to the `cygwin-3_6-branch`.
      
     -    The intended internal wide-character type in Cygwin is `__wchar_t` (note the
     -    double underscore, not triple), which is already available through
     -    `<sys/_types.h>`. Use that existing type so applications can include the header
     -    again.
     -
     -    This was reported in https://github.com/msys2/msys2-runtime/issues/399.
     -
     -    Assisted-by: GPT-6.1 Sol
     -    Fixes: af393fdf89a7 ("stdatomic.h: use latest FreeBSD file verbatim")
     +    Fixes: https://github.com/msys2/msys2-runtime/issues/399
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## newlib/libc/include/stdatomic.h ##


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
