Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id D573B4BA2E27
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:29:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D573B4BA2E27
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D573B4BA2E27
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042994; cv=none;
	b=VGVanPAbNubeoJYtAHPiZ3EHq1+MObO3hbgEUPKtAR7UT+KSOnhtUJSQBC4I94qtMuJgcGBYqm0EEpCPzOn8/Fs4JcZH0mG5xT+Ia7TeWfJ68xPfGnvD4O1fxl8PawIoV/SIORORVTMVuVHnynHdXoQx4PbPTp7aKAQCPv3Aeuk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042994; c=relaxed/simple;
	bh=TDpW63fXKuSFz0dsNBkfokYbpu+DZ4mZEawUtBKsu7Y=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ZGdUsixGborjKJ/bqsLwrSsDw24nQNR2VDB75tgL4INk8kWkJ5S4H0n6dSRNEns+F/D0bx1EmxKp2ekILNeKNG1LQJPL2Ao02m5UbZur1mhG0sjsQbDk0fceEI41mNDWJgga7z4XWhZ31B3uYsoL3ZbwDvzq1qRLTQahTq7SbLg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D573B4BA2E27
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L/aJIUHC
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20251218072946944.LLBR.48098.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 16:29:46 +0900
Date: Thu, 18 Dec 2025 16:29:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
Message-Id: <20251218162945.cf6aa8ed85d2366a0a74b44a@nifty.ne.jp>
In-Reply-To: <7c03a948-c8fb-079c-a2e1-99e8626366a7@gmx.de>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
	<aUAoxVEKMpj6xNjM@calimero.vinschen.de>
	<18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
	<aUAxwTZcfZ9qecW2@calimero.vinschen.de>
	<f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de>
	<20251216173957.fa9571466a8bced55924884f@nifty.ne.jp>
	<4ac88404-a8c3-3d21-6460-6941fb8dff4a@gmx.de>
	<20251217182931.c4dd8a2ea1569fc11b9a675e@nifty.ne.jp>
	<7c03a948-c8fb-079c-a2e1-99e8626366a7@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042987;
 bh=bpIuas3CTjRGtAEs0wdBEKbFYIFRWnWmBTM/JhnVlEw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=L/aJIUHCYSF+Tdf/8Gl0mW/J8Fl0IM1J1wRkTty3AQ1YOr1fntDDkjan8natZBrtxhkwjtj8
 ZW8XL6zLl1lr8lzeoAVGHUZRZtHu+lDdlmLP9Dd1e3wZYGV/AoCtkRzQkFmchjZJ0mE39tRdFg
 jxnOrU+ouRF6zlIktjRBtiBK1hX+fTOCArJb8b0En5/ykRxkPVDdkl5a7O049tXjsXWfBHXQBa
 uotlUmqAjzk8zK6rImhszjHLhY01zkIP4v+BrwVDbHi+JPIyxDhgusPXyZLhPiSeg1ATY1pHMm
 1W29mLZU2gQu2UqDU3dTUJ0r1cMdSa548ZBlJU4O2yVguawg==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

I'll respond to your comment based on v4 patch series, in which my patches
are intended to be merged into your patch series. The changes to your
patches are:
- is_console_app() returns true rather than false on errors. (The reason
  is described bellow.)
- Replace your patch 2/2 with my v3 patch.

If you think your solution (call CreateFile() twice) is still better than
mine, please feel free to say that.

On Wed, 17 Dec 2025 16:50:28 +0100 (CET)
Johannes Schindelin wrote:
> I did. It still leaves a lot to be desired from my side:
> 
> - It does not start with a clear statement of what is broken.

"After the commit f74dc93c6359, WSL cannot start by distribution name
such as debian.exe, which has '.exe' extention but actually is an app
execution alias."

> - It leaves a huge gap between mentioning the added `PC_SYM_NOFOLLOW_REP`
>   flag and the `is_console_app()` function, leaving it as a lengthy
>   homework assignment to each and every reader to figure out what possible
>   connection there is between those two: At first sight they seem rather
>   unrelated.

"This is because the commit f74dc93c6359 disabled to
follow windows reparse point by adding PC_SYM_NOFOLLOW_REP flag in
spawn.cc, that path is used for sapwning a process. As a result, the
path, that is_console_app () received, had been the reparse point of
app execution alias, then it returned false for the the path due to
open-failure because CreateFileW() cannot open an app execution alias,
while it can open normal reparse point.  If is_console_app() returns
false, standard handles for console app (such as WSL) would not be
setup. This causes that the console input cannot be transfered to the
non-cygwin app."

> - Saying "This patch fixes the issue by converting the path again" cannot
>   do anything but cause utter confusion because the path "conversion"
>   happens at a totally different place than it used to happen before, and
>   there is not the slightest assistance in that commit message to help
>   anybody understand

"This patch fixes the issue by locally converting the path, which is
a path to the app execution alias, once again using PC_SYM_FOLLOW
(without PC_SYM_NOFOLLOW_REP) option path_conv for using inside of
is_console_app() to resolve the reparse point here, if the path is
an app execution alias."

>     - how the code path is getting from that `perhaps_suffix()` function
>       (which is not even mentioned _once_ in that commit message), where
>       the `PC_SYM_NOFOLLOW_REP` flag is newly set, to the
>       `is_console_app()` function, which is in a totally different file.

"This is because the commit f74dc93c6359 disabled to
follow windows reparse point by adding PC_SYM_NOFOLLOW_REP flag in
spawn.cc, that path is used for sapwning a process. As a result, the
path, that is_console_app () received, had been the reparse point of
app execution alias, then it returned false for the the path due to
open-failure because CreateFileW() cannot open an app execution alias,
while it can open normal reparse point."

>     - what guarantee this patch makes that the touched code doesn't miss
>       anything else that was broken by the "fix native symlink spawn"
>       commit (or for that matter, whether there even has been given _any_
>       thought to unintended side effects or unwanted gaps in the fix).

"This patch fixes the issue by locally converting the path, which is
a path to the app execution alias, once again using PC_SYM_FOLLOW
(without PC_SYM_NOFOLLOW_REP) option path_conv for using inside of
is_console_app() to resolve the reparse point here, if the path is
an app execution alias."

> - The commit message freely admits that the `is_console_app()` code
>   blatantly ignores errors  when calling `CreateFileW()`, and leaves
>   things at that. The missing error checks (also for `ReadFile()`) are
>   still as missing as before.

Because I assumed that my v3 patch would be mearged with your patch series.

> - The commit message says that the fix is to use `PC_SYM_FOLLOW` again,
>   instead of `PC_SYM_NOFOLLOW_REP`. But the diff mentions neither of those
>   constants. I don't know which reader would find this helpful, as I
>   don't.

+  if (pc.is_app_execution_alias ())
+    {
+      UNICODE_STRING upath;
+      RtlInitUnicodeString (&upath, native_path);
+      path_conv target (&upath, PC_SYM_FOLLOW); <<<============
+      target.get_wide_win32_path (native_path);
+    }

> - One particularly irritating gap is the question why app execution
>   aliases aren't simply special-cased such that their `argv[0]` is set to
>   the symlink _target_, as it used to be when app execution alias support
>   was introduced to `spawn()`. That would be quite an interesting
>   discussion, in particular when the somewhat surprising fact is conveyed
>   that app execution aliases are tied to a package identity, and executing
>   them instead of the reparse point target path quite potentially equips
>   the spawned process with permissions it would not otherwise have.

In v4 patch series, is_console_app() returns true when an error occurs.
This is for fail-safe if the app is actually a non-cygwin console app.
In this case, standard handles is not setup for non-cygwin app if it
returns false. Therefore, it is safer to return true for unknown case.
Setting-up standard handles for GUI apps by an error due to permission
issue, is poinless, but not unsafe.

> This is not the first time I have pointed out this class of problem in
> commit messages. When a bug fix is quite involved, it pays a disservice to
> any reader when the commit message just rushes through the words without
> even trying to do a good job of explaining the problem, the context, the
> approach taken to address the problem, and considerations what
> (potantially unintended) consequences the patch might lead to.
> 
> I don't actually know how I can impress on you how crucial the skill of
> commit message writing is, how essential it is to practice it well until
> you do a better job. I have tried several times, and I am approaching my
> wits' end.
> 
> If the author of a commit message would have trouble, after reading it as
> little as half a year in the future, to understand the reasoning behind
> their own patch (and there is not the slightest doubt in my mind that v3's
> commit message would fall into that exact category), then that commit
> message is in need of some work.
> 
> Writing commit messages is a craft as much as writing code, and if you
> love your craft, you devote passion to honing that craft. It shows in the
> results whether you do that.

Noted. When I read the commit message I wrote several years ago,
I often do not remember how the problem was solved. Obviously,
it is due to unappropriate commit message. I've been trying to be
careful in recent years, but it seems I'm still not quite there.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
