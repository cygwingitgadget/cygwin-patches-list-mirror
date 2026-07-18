Return-Path: <SRS0=7Ga2=FM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 2FDC14BA2E39
	for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 13:27:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2FDC14BA2E39
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2FDC14BA2E39
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784381259; cv=none;
	b=BpZ8EdeNSKabm231Ds173M715xfpKYSEIIBTpnQReyCx/TXb58bfB54oAsv8Lm5sPpESmJ6WvN62Zlf+Ov414/XZBuaUZtWRfUGXmbL+EsebIruf7rocpbpxGRoo0QTEXmzKGSBxGm015e921RrjxaEyWF2vtCTSNm8rc+6vFCo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784381259; c=relaxed/simple;
	bh=QH4znOw6yTcDudi4bsMfPR84S9Y+i7gduR8qXsEptl8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YwLf5UIQFA44T4G089khIG7tDTPglAO0aCR7HwtFM/LY42sEgka85nJCkHHrtDJSNaAd0RtKHj3OAlV4uTR1DN/dslILxHSTmed1nA44SEEyu7Kps8ZjdSHEFWu2yGQLVcqsNozEjUwfL4pgvAdfm8Lh29Jt+XXT4C9lasTLV0U=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bHyxDrPm
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2FDC14BA2E39
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bHyxDrPm
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260718132736784.BLWT.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 22:27:36 +0900
Date: Sat, 18 Jul 2026 22:27:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260718222734.c8eaf3a9cb855f3d23d89fe7@nifty.ne.jp>
In-Reply-To: <20260718131226.1350-1-takashi.yano@nifty.ne.jp>
References: <20260718131226.1350-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784381256;
 bh=XcTeNNwnI6O0J0tP7JSYZDqDIj22nhJbFepKFlOYerQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=bHyxDrPm6o8MoYU6Ne2vmN30PkRei+10tQEPi/E2GbVO4fYka7Z5P8ExW9k8fbJP1h1DBtQx
 u7Hsyz/6uhTmIc7Yqm6qG8DuzW61GSqjIU3wT/UalWPezC1MF3egFxpG3+uNOdOHwTHJoFreEI
 58+a6ER/YRPZ8PXWbZNORv65QA9kNlYpwBVRTqop0ZI6Aq1MZJH49BZof2m8Ad9b65uClMlxS9
 f8ouW4I7w/8VrdX3Bco1bjrNnyvSQPkWfbvpd/QRePYQLtv5lx7+7fVyW46F+mzc8rSTLtlk00
 q6ULCS9hte6HxEbs995+brryA5aYQ10CqiBqzJvq1TxPVr9g==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Sorry, I forgot to add cleanup() on CreateProcess() failure.

On Sat, 18 Jul 2026 22:12:14 +0900
Takashi Yano wrote:
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> index ee576a0a8..f8269cc4f 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -826,6 +826,17 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
>      }
>  }
>  
> +void
> +fhandler_termios::spawn_worker::notify_spawned (bool success)
> +{
> +  if (cygheap->ctty && cygheap->ctty->get_major () == DEV_CONS_MAJOR
> +      && cygheap->ctty->tc ()->getpgid () == myself->pgid)
> +    {
> +      fhandler_console *cons = (fhandler_console *) cygheap->ctty;
> +      cons->set_non_cygwin_app_setup_ongoing (false);
> +    }

+  if (!success && need_cleanup ())
+    cleanup ();

> +}
> +
>  void
>  fhandler_termios::spawn_worker::cleanup ()
>  {

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
