Return-Path: <SRS0=SG5m=GM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id A53694BA23E2
	for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 07:02:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A53694BA23E2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A53694BA23E2
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1787122925; cv=none;
	b=PawcoJ04Xs4o9taxWCa/9AosAQP2+MgNygBfoaUec2ESaLxD92xSs0msqxvxl07d4YaR9mYZeH5IdmyzrJJp6ad3I4Xiirnvm0BEr9f1VasRLhO2uhsX2uCmNxe0esOniWgWZdBcRQi8Bay8Qf9QWtG/FSo49VjPIQWADB20aFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787122925; c=relaxed/simple;
	bh=Nj2ZiADgZVzsofDe8+TxQazgt8FS94H3YApaiNcNGPQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EFJEyYIRn3KGdO+a0HqXUf5jNhB5tgz+ws3cDKJuSWF0oxRSV2B+sb/DcoOw2I8beAzY1p93OOdry7afRfWbplxPBopEpwDXv8nZMaRE3OM1H6LcXuzZkwqFn6l0SloSS9SmcQzGQYwiYlq5YwYGoFt98zELN/Z/F1+o6gZUksc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=P8WN9yzS
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A53694BA23E2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=P8WN9yzS
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260819070202976.DDQS.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 16:02:02 +0900
Date: Wed, 19 Aug 2026 16:02:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH/RFC] console: avoid master-thread suspend request from
 non-master processes
Message-Id: <20260819160201.1ad93c8205b9ce115ffa7650@nifty.ne.jp>
In-Reply-To: <CAD8hRBMi6qaH8xP4Zw0j0VpTz0CFLRRU2cb--H4FCZcpQ=nhEA@mail.gmail.com>
References: <CAD8hRBMi6qaH8xP4Zw0j0VpTz0CFLRRU2cb--H4FCZcpQ=nhEA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1787122923;
 bh=X5Mcjf/rFwMx4BEypOw3O14+7HdSHyw01Kje7Md7WpM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=P8WN9yzScWg6dkdCJjAdOVsjQs4nFzoJY9DqY6EYZaL2jz5xfvJyUjN+OFCBoUcTqjzvzaOP
 7XSrhVWImDmlbDBdooRX52YbvFCVq2LWlDVwWxEMXKpATcMZKON2Zn6czOSsUJj49hHZwtszFm
 DKXcoT1SsrOtQPGfllEMR1sqEy/mu8uaD6Wxn/jOeeHIo6TN7N5dPzFaBLh2unbAu0og4CPzV7
 Tg5wxIbxGKYy4znuy/+9vMoI3eopvvOh7jJXt6tVcp49eMa3rjKVab80nbQ1lxq9uN9Gb9xLzk
 Dzv+SUfKaTDKOGWfUEzyn2+NSgUGA368FcMqlBIN39NUzupg==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 13 Aug 2026 08:50:17 +0800
飛飛飛 wrote:
> Hi,
> I have been investigating a reproducible hang in highly parallel builds on
> Windows 11, especially while building LibreOffice with multiple jobs.
> The hang appears to involve fhandler_console::close() calling:
> 
> set_disable_master_thread (true, this);
> 
> 
> even from processes that do not have a local console master thread.
> 
> set_disable_master_thread() updates the shared disable_master_thread state
> and then waits for:
> 
> while (con.master_thread_suspended != x)
>   Sleep (1);
> 
> During testing I captured a case where one process published a suspend
> request (true) and started waiting for
> 
>  master_thread_suspended == true,
> 
> but another process later published false into the same shared state before
> the first request had completed.
> 
> The first process was then left waiting indefinitely.
> In the captured trace, both requesting processes had:
> 
> master_thread_started = 0

Thank you for the report and for investigating this.
Could you please check if the patch:
    https://cygwin.com/pipermail/cygwin-patches/2026q3/015277.html
helps?

> while the actual console owner/master-thread process was a different
> process.
> A minimal guard in
>  fhandler_console::close() avoids this:
> 
> if (master_thread_started)
>   set_disable_master_thread (true, this);
> 
> This prevents processes without a local master thread from entering the
> master-thread suspend request/wait path.
> The intent is not to change Windows process/thread scheduling. It only
> restricts Cygwin's shared console master-thread control to a process which
> actually has a local master thread.
> This also avoids non-master processes entering a wait loop whose completion
> condition may be invalidated by another process modifying the same shared
> state.
> Test results:
> 
> Windows 11
> AMD Ryzen 7 9800X3D
> Intel i7-13620
> parallel LibreOffice builds
> 
> repeated high-parallelism testing
> full LibreOffice build completed successfully with the guard applied
> Without the guard, I was able to reproduce the hang and capture the request
> overwrite described above.
> With the guard restored, the full LibreOffice build completed successfully
> with exit code 0.
> 
> One possible trade-off is that processes without a local master thread can
> no longer request suspension of the console master thread through this
> path. So this narrows some existing cross-process master-thread control
> behavior.
> 
> So far I have not observed a functional regression from this restriction on
> the tested Windows 11 systems.
> My current understanding is that the important behavioral change is very
> small: processes without master_thread_started no longer enter the
> potentially unbounded set_disable_master_thread() wait path.
> I would appreciate feedback on whether this ownership restriction is
> consistent with the intended console master-thread design.
> Thanks.
> 
> 
> 
> 
> 🫆Trace Process Log🫆
> 
> Process A:
>   started=0
>   publish disable=1
>   wait for suspended=1
> 
> Process B:
>   started=0
>   publish disable=0
>   completes immediately
> 
> Process A:
>   never completes


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
