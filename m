Return-Path: <SRS0=eY+i=JH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 98C034BA2E13
	for <cygwin-patches@cygwin.com>; Wed, 18 Nov 2026 23:50:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 98C034BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 98C034BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795045847; cv=none;
	b=LySrYkSUFAhqX9RcvNSA+hBcQ7BtxFGhfByy9uge1rqgkJRd0NXeW9N5ym/ssZEzAJezDAhGg+R4TDgl2haOt7RaTaXR4YL2O0YFa4h6qdRjf9t7eTtImQNuhE2IXNWU5LmuU59IX3SaBIsZwu+y4qgJspms5Q7ueiqwH0L4l+0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795045847; c=relaxed/simple;
	bh=bZPcV14WvmGlPnIqJN4PxI8ECLFHVsODR/Hyst6v7YQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=B7ILLWOkkwOGvCxiYBgRdxBXpf52giUj6wiga4nJdRSCyGq2Ffq5+X0nTseMG2clneYpNI22xPy0f4D48Xg9q2hoAe3jnMVuKyiWYzj31QG0/q7WRJyBBDgMnTgwWaaPR/yjnMy/hznvJFighLFY3DRSLKuA8cbhBTnWEAHFoxo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=I3F1/UhR
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 98C034BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=I3F1/UhR
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20261118235041540.SCBX.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 19 Nov 2026 08:50:41 +0900
Date: Thu, 19 Nov 2026 08:50:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Modify atomic_wchar_t reference to use __wchar_t
Message-Id: <20261119085040.bf372ecdc870471e428b8826@nifty.ne.jp>
In-Reply-To: <pull.16.v2.cygwin.1794999354705.gitgitgadget@gmail.com>
References: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com>
	<pull.16.v2.cygwin.1794999354705.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1795045841;
 bh=9g0OrxXoOsF5GSLmq0X7OkC/4CrifTaMNW1yeTRfB/U=;
 h=Date:From:To:Subject:In-Reply-To;
 b=I3F1/UhRMmrOu9Eni9CuY1Je+lqKF6jL8jSBgY7i54gIGFfYXKd2jjKhFCxgOzVisVXDIUro
 F9N5qT8q4ha8hbfbnX2zsBsOzACKhsSPc/xxyuDLhuJTFoW8zAQOSoxeuAe2L+IbLUumbCCJ83
 tEc9QGz5QgmV8wGyE1On6C5NYA+vh0o1KHxLIihch712GioIdms0Qb6lRl7R0U64bGsthbaFnY
 o4Jpwz1poCkn+taVFCw2rY/Bt+UEZI9b6PNR16zWh492apY/ce4mQc3PaUMMMOiN0wsPK/QqQs
 SWIlkFJPDsrknL7n850OLfq0Z9P/SZax8eSgfSAgmJVZ5uAg==
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Wed, 18 Nov 2026 10:55:54 +0000
"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> wrote:

> From: Jeff Johnston <jjohnstn@redhat.com>
> 
> This is a backport of 209858c89d (Modify atomic_wchar_t reference to use
> __wchar_t, 2026-06-09) to the `cygwin-3_6-branch`.
> 
> Fixes: https://github.com/msys2/msys2-runtime/issues/399
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     stdatomic.h: fix the type used for atomic_wchar_t
>     
>     Including <stdatomic.h> currently fails because atomic_wchar_t refers to
>     the undefined type ___wchar_t (note the triple underscore). This
>     spelling was introduced by the update to the FreeBSD header, which tried
>     to avoid conflicts with clang in
>     https://cgit.freebsd.org/src/commit/sys/sys/stdatomic.h?id=0a4c54d6060ab057c86d65be24cf6032e7436670
>     (Rename __wchar_t so it no longer conflicts with __wchar_t from clang
>     3.4, 2014-04-01) by using the triple underscore.
>     
>     The intended internal wide-character type in Cygwin is __wchar_t (note
>     the double underscore, not triple), which is already available through
>     <sys/_types.h>. Backport 209858c89d4feb342857255be8c10862c1ad9d8b that
>     is already on main to use that existing type so applications can include
>     the header again.
>     
>     Changes since v1:
>     
>      * Clarified that this is actually a straight backport of a commit from
>        main onto the cygwin-3_6-branch, and therefore no re-route via the
>        newlib mailing list is needed at all.
> 
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-16%2Fdscho%2Ffix-stdatomic-header-v2
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-16/dscho/fix-stdatomic-header-v2
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/16
> 
> Range-diff vs v1:
> 
>  1:  cf2b7f207 ! 1:  5b85515fe stdatomic.h: fix the type used for atomic_wchar_t
>      @@
>        ## Metadata ##
>      -Author: Johannes Schindelin <johannes.schindelin@gmx.de>
>      +Author: Jeff Johnston <jjohnstn@redhat.com>
>       
>        ## Commit message ##
>      -    stdatomic.h: fix the type used for atomic_wchar_t
>      +    Modify atomic_wchar_t reference to use __wchar_t
>       
>      -    Including <stdatomic.h> fails because atomic_wchar_t refers to the undefined
>      -    type `___wchar_t` (note the triple underscore). This spelling was introduced by
>      -    the update to the FreeBSD header, which tried to avoid conflicts with clang in
>      -    https://cgit.freebsd.org/src/commit/sys/sys/stdatomic.h?id=0a4c54d6060ab057c86d65be24cf6032e7436670
>      -    (Rename __wchar_t so it no longer conflicts with __wchar_t from clang 3.4,
>      -    2014-04-01) by using the triple underscore.
>      +    This is a backport of 209858c89d (Modify atomic_wchar_t reference to use
>      +    __wchar_t, 2026-06-09) to the `cygwin-3_6-branch`.
>       
>      -    The intended internal wide-character type in Cygwin is `__wchar_t` (note the
>      -    double underscore, not triple), which is already available through
>      -    `<sys/_types.h>`. Use that existing type so applications can include the header
>      -    again.
>      -
>      -    This was reported in https://github.com/msys2/msys2-runtime/issues/399.
>      -
>      -    Assisted-by: GPT-6.1 Sol
>      -    Fixes: af393fdf89a7 ("stdatomic.h: use latest FreeBSD file verbatim")
>      +    Fixes: https://github.com/msys2/msys2-runtime/issues/399
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>        ## newlib/libc/include/stdatomic.h ##
> 
> 
>  newlib/libc/include/stdatomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/newlib/libc/include/stdatomic.h b/newlib/libc/include/stdatomic.h
> index 67107f47e..40f2d269c 100644
> --- a/newlib/libc/include/stdatomic.h
> +++ b/newlib/libc/include/stdatomic.h
> @@ -207,7 +207,7 @@ typedef _Atomic(unsigned char)		atomic_char8_t;
>  #endif
>  typedef _Atomic(__char16_t)		atomic_char16_t;
>  typedef _Atomic(__char32_t)		atomic_char32_t;
> -typedef _Atomic(___wchar_t)		atomic_wchar_t;
> +typedef _Atomic(__wchar_t)		atomic_wchar_t;
>  typedef _Atomic(__int_least8_t)		atomic_int_least8_t;
>  typedef _Atomic(__uint_least8_t)	atomic_uint_least8_t;
>  typedef _Atomic(__int_least16_t)	atomic_int_least16_t;
> 
> base-commit: af6327c35c85a7c5376a47d980bbade5f40eb5bc
> -- 
> cygwingitgadget

Would it be okay with you if I cherry-pick commit 209858c89d?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
