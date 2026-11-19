Return-Path: <SRS0=0Jyu=JI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 3EEEF4BA2E1A
	for <cygwin-patches@cygwin.com>; Thu, 19 Nov 2026 04:53:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3EEEF4BA2E1A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3EEEF4BA2E1A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795064008; cv=none;
	b=p3Y7wJzyuy5fw81ixqaPzZ+yUXMyYMa8Od1x/HkphB7cCh5SrgnjQy+b8G2kXHeWdsd4lPRpfcHzMhA9Rjqriq647xWS6JLpUU7eqwnJoEJy5rIdITderElDtYxOl0+KqIZDcNG4N82i4OlPnQjA55PuFIrf1ZmNHfPFsXZ98+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795064008; c=relaxed/simple;
	bh=YDOcIdIbMaUmjWUbsZ62kyHkaCws7TgbIkOEJtFTLQI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=pNGXe/TSxdAIojIyirAEQoIjWBS6hfgK5EnFM0HNY6qZ5mlECOPSY1TsGxeg30iO+QQ/hnj8QYnBe6TyoCGHNpit1bbFQzQxRm5W5T7FYW86IYGiuimIemKV7uiQhxSJ19yhjwZVXHp92QO8oAWyflhbYH5N7vg0nN4/HvkYiHM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aJhdv9tO
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3EEEF4BA2E1A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aJhdv9tO
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20261119045324557.KYKG.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 19 Nov 2026 13:53:24 +0900
Date: Thu, 19 Nov 2026 13:53:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Modify atomic_wchar_t reference to use __wchar_t
Message-Id: <20261119135323.34f6744bf1c7fddcf074c0ed@nifty.ne.jp>
In-Reply-To: <34318506-3527-458B-B7E4-6CAE9F57931A@gmx.de>
References: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com>
	<pull.16.v2.cygwin.1794999354705.gitgitgadget@gmail.com>
	<20261119085040.bf372ecdc870471e428b8826@nifty.ne.jp>
	<34318506-3527-458B-B7E4-6CAE9F57931A@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1795064004;
 bh=0F8b8IHx/h1hngj7e1+k6HTTdLxCiMOjJ53U53kLmaQ=;
 h=Date:From:To:Subject:In-Reply-To;
 b=aJhdv9tO4NOTWK9Yn04wTr3sikpz2Xwlfnqgy5KmAsipxswM/bTlIrajjCFdYX/lvnolnRYd
 rea+uH4dthPY6kOLDLut0uKdq5AeLG1BUl0IHom7CstZ1GqLypAALAOcoYhNBgOWx+HrYCPSJt
 HsUJ0mkuFSa/dVbBdFawC0UT3zvgnSXnZ7Bl3aVNyUDqjVfeNNQWZb18sKDHvNTH56x9x5Xnys
 lPW1uX2HZ4oWHAvFcyZ7yvqSq7vAta7Wc7lZXA5Ve9mbNmr4bF2bXejYq6TRFHmYGwmb8u0fnw
 NnWj5F09gZ6PYWaQKoo247V1vsOywqygfQ6enuzkeat1thIA==
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Thu, 19 Nov 2026 03:56:18 +0100
Johannes Schindelin wrote:
> Hi Takashi,
> 
> of course! That's all this patch is, really: a backport, a cherry-pick...

Done.
Thanks!

> 
> Thank you,
> Johannes
> 
> 
> 
> -------- Original Message --------
> From: Takashi Yano <takashi.yano@nifty.ne.jp>
> Sent: November 19, 2026 12:50:40 AM GMT+01:00
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH v2] Modify atomic_wchar_t reference to use __wchar_t
> 
> Hi Johannes,
> 
> On Wed, 18 Nov 2026 10:55:54 +0000
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> 
> > From: Jeff Johnston <jjohnstn@redhat.com>
> > 
> > This is a backport of 209858c89d (Modify atomic_wchar_t reference to use
> > __wchar_t, 2026-06-09) to the `cygwin-3_6-branch`.
> > 
> > Fixes: https://github.com/msys2/msys2-runtime/issues/399
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     stdatomic.h: fix the type used for atomic_wchar_t
> >     
> >     Including <stdatomic.h> currently fails because atomic_wchar_t refers to
> >     the undefined type ___wchar_t (note the triple underscore). This
> >     spelling was introduced by the update to the FreeBSD header, which tried
> >     to avoid conflicts with clang in
> >     https://cgit.freebsd.org/src/commit/sys/sys/stdatomic.h?id=0a4c54d6060ab057c86d65be24cf6032e7436670
> >     (Rename __wchar_t so it no longer conflicts with __wchar_t from clang
> >     3.4, 2014-04-01) by using the triple underscore.
> >     
> >     The intended internal wide-character type in Cygwin is __wchar_t (note
> >     the double underscore, not triple), which is already available through
> >     <sys/_types.h>. Backport 209858c89d4feb342857255be8c10862c1ad9d8b that
> >     is already on main to use that existing type so applications can include
> >     the header again.
> >     
> >     Changes since v1:
> >     
> >      * Clarified that this is actually a straight backport of a commit from
> >        main onto the cygwin-3_6-branch, and therefore no re-route via the
> >        newlib mailing list is needed at all.
> > 
> > Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-16%2Fdscho%2Ffix-stdatomic-header-v2
> > Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-16/dscho/fix-stdatomic-header-v2
> > Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/16
> > 
> > Range-diff vs v1:
> > 
> >  1:  cf2b7f207 ! 1:  5b85515fe stdatomic.h: fix the type used for atomic_wchar_t
> >      @@
> >        ## Metadata ##
> >      -Author: Johannes Schindelin <johannes.schindelin@gmx.de>
> >      +Author: Jeff Johnston <jjohnstn@redhat.com>
> >       
> >        ## Commit message ##
> >      -    stdatomic.h: fix the type used for atomic_wchar_t
> >      +    Modify atomic_wchar_t reference to use __wchar_t
> >       
> >      -    Including <stdatomic.h> fails because atomic_wchar_t refers to the undefined
> >      -    type `___wchar_t` (note the triple underscore). This spelling was introduced by
> >      -    the update to the FreeBSD header, which tried to avoid conflicts with clang in
> >      -    https://cgit.freebsd.org/src/commit/sys/sys/stdatomic.h?id=0a4c54d6060ab057c86d65be24cf6032e7436670
> >      -    (Rename __wchar_t so it no longer conflicts with __wchar_t from clang 3.4,
> >      -    2014-04-01) by using the triple underscore.
> >      +    This is a backport of 209858c89d (Modify atomic_wchar_t reference to use
> >      +    __wchar_t, 2026-06-09) to the `cygwin-3_6-branch`.
> >       
> >      -    The intended internal wide-character type in Cygwin is `__wchar_t` (note the
> >      -    double underscore, not triple), which is already available through
> >      -    `<sys/_types.h>`. Use that existing type so applications can include the header
> >      -    again.
> >      -
> >      -    This was reported in https://github.com/msys2/msys2-runtime/issues/399.
> >      -
> >      -    Assisted-by: GPT-6.1 Sol
> >      -    Fixes: af393fdf89a7 ("stdatomic.h: use latest FreeBSD file verbatim")
> >      +    Fixes: https://github.com/msys2/msys2-runtime/issues/399
> >           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >       
> >        ## newlib/libc/include/stdatomic.h ##
> > 
> > 
> >  newlib/libc/include/stdatomic.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/newlib/libc/include/stdatomic.h b/newlib/libc/include/stdatomic.h
> > index 67107f47e..40f2d269c 100644
> > --- a/newlib/libc/include/stdatomic.h
> > +++ b/newlib/libc/include/stdatomic.h
> > @@ -207,7 +207,7 @@ typedef _Atomic(unsigned char)		atomic_char8_t;
> >  #endif
> >  typedef _Atomic(__char16_t)		atomic_char16_t;
> >  typedef _Atomic(__char32_t)		atomic_char32_t;
> > -typedef _Atomic(___wchar_t)		atomic_wchar_t;
> > +typedef _Atomic(__wchar_t)		atomic_wchar_t;
> >  typedef _Atomic(__int_least8_t)		atomic_int_least8_t;
> >  typedef _Atomic(__uint_least8_t)	atomic_uint_least8_t;
> >  typedef _Atomic(__int_least16_t)	atomic_int_least16_t;
> > 
> > base-commit: af6327c35c85a7c5376a47d980bbade5f40eb5bc
> > -- 
> > cygwingitgadget
> 
> Would it be okay with you if I cherry-pick commit 209858c89d?
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
