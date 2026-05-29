Return-Path: <SRS0=Aef5=D2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:2a])
	by sourceware.org (Postfix) with ESMTPS id 502D14BA2E2C
	for <cygwin-patches@cygwin.com>; Fri, 29 May 2026 02:38:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 502D14BA2E2C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 502D14BA2E2C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780022284; cv=none;
	b=VFNWuKm6IQONHZNmYW57nmJGgLRl09AOI0Ky4j8VNCClq1ms6c4AOp1MvwOVi/Tm0nF7URZG77kB8vIANIJ7C3j1xWhrXe3kmXGxSBc5uTsgF7P31BtqR5YhNwBdUxYdMKSXCmXw7zZDJjeuP60LquWGSXsqa+gK9/GriThcfDU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780022284; c=relaxed/simple;
	bh=OUuEgVeywJbOm2soJdHsiUk2fo9nb3RdLnloCLGPmWA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=mbiH0LmAy2sIiKalH2tizRBpH7kAuSaXhsZgIRQdPrwblIet1WaU+c2l9Vnu7pwq7R6/ZQoGuDzLEZp2JyZuwBxdJ6znACtFDrmfRjs75dfDWXEqyL3fNDxxFtrmaPIJyEdX4DcWTj/fWBP29Axa+eqXaQUIW3VeW0+2ozNZgGY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G8UqqvkX
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 502D14BA2E2C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G8UqqvkX
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260529023802516.IFOP.3198.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 29 May 2026 11:38:02 +0900
Date: Fri, 29 May 2026 11:38:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: fork: Call pthread::atforkprepare() in
 lock_pthread()
Message-Id: <20260529113801.756e13383a946d2983f4d849@nifty.ne.jp>
In-Reply-To: <42c9c420-416a-d532-af07-4e37d81f8a35@gmx.de>
References: <20260519235133.19276-1-takashi.yano@nifty.ne.jp>
	<42c9c420-416a-d532-af07-4e37d81f8a35@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780022282;
 bh=XIpsukmVM4sIUUDkOV/y0Sbbr0LrgdlPqTUE0sWXACA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=G8UqqvkXCo+Ab0ldlGRPU4Pt5WHbdzYBfynHM233SxOMvqmTBZSiehEY0GoR/5klEPoVGiPW
 w8YSneOtdYc5cVgS+ro0ce8slkGBaQ+2aLtJUUqPe+7h6QUVYIXed1zmxTWNijA2tP1CV/49vR
 1JKvKAJ4J6oF6qPuhKPaYbgPxYJbtT8dMXQ7RNj/lov6Ybgw7peMuBH5Raf0rdR+f62m9P4F5q
 ilMDzuh0Z9IU8aM2yV1dnKhtiTgSuFv7X8U7uEDlqoGyMvBXyF11xErPKpseiSr3yg/hNAJyU0
 Ua8PEAAV0HsYqG+GYoKGmb9aXj6wN3FvFKRbInSH5C8qSO8w==
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 28 May 2026 15:43:37 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 20 May 2026, Takashi Yano wrote:
> 
> > Since the commit 5f515cf3d6e3, if one thread calls fclose() while
> > another thread calls fork(), a deadlock can occur. The mechanism
> > is as follows.
> >   1) fclose() first calls __sfp_lock_acquire() and, then calls
> >      lock_process::locker.acquire() via cygheap_fdget().
> >   2) fork() first calls lock_process::locker.acuire() via the
> >      constructor of the lock_process class in the hold_everything
> >      class, and then calls __sfp_lock_acquire() via __fp_lock_all()
> >      in atforkprepare().
> >   3) As a result, the thread calling fclose() tries to acquire the
> >      lock_process lock while holding __sfp_lock, and the thread
> >      calling fork() tries to acquire __sfp_lock while holding the
> >      lock_process lock.
> > This leads to a deadlock. Before the commit 5f515cf3d6e3, __sfp_lock
> > was acquired in the constructor of the lock_pthread class in the
> > hold_everything class, and since lock_pthread is defined before
> > lock_process, this deadlock did not occur.
> > 
> > This patch moves the atforkprepare() call back into the constructor
> > of the lock_pthread class, restoring the previous lock qcquisition
> > order.
> 
> I am not super familiar with this part of the code, which is why this
> commit message is really helpful. From my point of view, this patch is
> good to go.

Pushed.

> P.S.: You may want to s/qcquisition/qcquisition/ before applying, even if
> this typo cannot harm the clarity of the commit message.

Oops! Fixed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
