Return-Path: <SRS0=SG5m=GM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 487CF4BA79A3
	for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 06:51:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 487CF4BA79A3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 487CF4BA79A3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1787122289; cv=none;
	b=ZtW6q55iFU2WqipCaKJ3eEGPL8qhqp46qkhNjeUniL0gxumJRXJq4Fge8lsItXOM8NaHZ2iq4rOwRD28GV4aLr0Nkv8wXhB5yCxLtAh0jWD3FrMpyngRyBVpHdBdkbj7TsEs69+hgCnuUS9U2zOjHnftKSIrdbIbX/vAgz9i1qc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787122289; c=relaxed/simple;
	bh=A3OweqKyBw88WM0/TvrORUHxkAC+RsHnJ5sgBJ/tnHU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=wa/xS8/ip/VY1T5mQ0SSCopK40cqUsj7HNajuaY/APr4M9aEqiMIK2++sUOZZmOZ702OpVk9dcmj+7LaJ8TuyjLyQwwRd7JMFXyHFJIcxC99eBBv2e9DnkHBhAmGp3+KjTC9hr2/LdF0dqLjWZSKWkkyBKGpKPl/iJlWoiOAvk8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qmacQyVf
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 487CF4BA79A3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qmacQyVf
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260819065127532.CZEY.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 15:51:27 +0900
Date: Wed, 19 Aug 2026 15:51:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup: console: validate duplicated handle set for
 master thread
Message-Id: <20260819155125.5b311d2426202962fece5721@nifty.ne.jp>
In-Reply-To: <CAD8hRBMNcuh+k0btNomyhcmn=yuNyn-Hh1bkC7gBKEiT=9kT0Q@mail.gmail.com>
References: <CAD8hRBMNcuh+k0btNomyhcmn=yuNyn-Hh1bkC7gBKEiT=9kT0Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1787122287;
 bh=lL2k/B4Q+w3SfKNcgI37ePp4ViQQgv5CtT37g8xPqzg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=qmacQyVfSWxzqE8EDfV96e6U71xhdJoIqyygYWimpBX4UE8Ga9SwtyznixBQOkif1T7AuPLv
 SlXSq/uQsD/fNdjZjXd8DsNPqrQvB/PFL7W/VuqxlDZE0Up8ZDDQWQU2mmXZEhKfBJftUMOzUs
 YVvxYlTrLjHi59ow3JZRXEPZKP9EzdJkQnz57meMLnIbOzgmDKtyNbkP9sVxDG9zlwMgNkLF79
 1OK7rN0dKwgQXahVWouOJRBvNBSRCj0dwNcHehrM6f1zerfqyR7lIYXHV6EcxeBWFJ+I41/0d/
 /97mSej8MepwcraB82bTzeGlmvxKm6uZLy/H5JHk43jGbYWw==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 11 Aug 2026 14:03:04 +0800
飛飛飛 wrote:
> Hi Cygwin maintainers,
> 
> I originally came across this issue while working on LibreOffice development
> on Windows.
> 
> My main development environment is:
> 
>   CPU: AMD Ryzen 7 9800X3D, 8 cores / 16 hardware threads
>   OS: Windows
>   Visual Studio: Visual Studio 2022
>   Windows SDK / UCRT: 10.0.26100.0
>   Cygwin runtime: E:\LibreOfficeDev\cygwin64
>   LibreOffice source tree: E:\LibreOfficeDev\src
> 
> While developing LibreOffice, I found that parallel builds could become
> unreliable in my environment, and I often had to reduce the parallelism
> significantly to avoid a stuck build.
> 
> Out of curiosity, I started reading the Cygwin source to understand what was
> happening under parallel workloads. I used ChatGPT as an assistant while
> inspecting logs, dumps, source code and synchronization paths, but I
> reproduced,
> built and validated the changes locally myself.
> 
> During the investigation, I reproduced a console-related failure path:
> 
>   close_handle: CloseHandle(p->input_handle<0x0>) failed, Win32 error 6
> 
> Reviewing the console master-thread handle setup showed that
> get_duplicated_handle_set() assumed that all DuplicateHandle() calls
> succeeded, while cleanup could later attempt to close members of a partially
> initialized handle set.
> 
> The attached patch makes handle acquisition all-or-nothing.
> 
> It:
> 
>   * initializes handle_set_t before duplication;
>   * changes get_duplicated_handle_set() to return bool;
>   * checks every DuplicateHandle() result;
>   * cleans up already duplicated handles if a later duplication fails;
>   * avoids starting the console master thread with an incomplete handle set;
>   * releases duplicated console handles if thread_sync_event duplication
> fails;
>   * makes close_handle_set() tolerate partially initialized handle sets.
> 
> The patch does not intentionally change console synchronization semantics.
> 
> I tested this against the current official newlib-cygwin source.
> 
> Upstream base:
> 
>   81f45549e771fd4da7b88ad04bd9e6ec5c765d50
> 
> Patch commit:
> 
>   1d5fbfa8e
>   winsup: console: validate duplicated handle set for master thread
> 
> The patch was also verified in both directions:
> 
>   reverse apply against the patched HEAD: PASS
>   forward apply against the upstream parent: PASS
> 
> The resulting current-master Cygwin DLL was built and tested locally.
> 
> Runtime smoke tests:
> 
>   true.exe   PASS
>   uname.exe  PASS
> 
> I then installed the resulting DLL into the Cygwin runtime used by my actual
> LibreOffice development environment and tested real parallel LibreOffice
> builds:
> 
>   make -j4   PASS, exit status 0, elapsed time 25 seconds
>   make -j8   PASS, exit status 0
> 
> The -j8 run exercised the normal LibreOffice gbuild process tree, including
> make, sh, touch, cp and other Cygwin utilities.
> 
> I am submitting this because I believe that when an open-source failure path
> can be reproduced and hardened without changing intended behavior, it is
> worth
> trying to fix it rather than only working around it.
> 
> I am not a Cygwin maintainer, so I would be grateful for review and any
> corrections needed to better match Cygwin conventions.
> 
> Thank you for maintaining Cygwin.

Thanks for the patch.

Indeed, the lack of error handling for DuplicateHandle() is a defect.
However, I wonder why the DuplicateHandle() fails. Two questions.

(1) Did you check the return value of GetLastError()?
(2) Does the patch:
    https://cygwin.com/pipermail/cygwin-patches/2026q3/015277.html
    help?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
