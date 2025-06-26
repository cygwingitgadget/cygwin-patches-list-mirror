Return-Path: <SRS0=1xMm=ZJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 9D632385B51A
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 13:59:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9D632385B51A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9D632385B51A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750946376; cv=none;
	b=GiwXfAhV/DxAZk5CxHOqx+UWC7chtbUYUYmR2ag+95p0uB3D7fpMRs/OBtgsv16nnUQLXyH0sOq0alebliq2pjlU8shhlawD3CSypS1bSjcrq5umfKUkSt1DbSQ+8baoGsxBBwC3mQHJymek2FYgPDA4TBjVpK4l7wLbv0VDfmQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750946376; c=relaxed/simple;
	bh=LLYoNoogs8en9VFxgNgQvNcs2VAe7ybdQwzDXvxX9Rw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=hTlp+YKk4WHeKicIVtieYdK78V+82ic73UlYYiq6VNnQ6wJItu/oCt5f6/J4ic9y5FiLuzMXEaNr2o5sEU4pVV1wnezZs9rdIEEMOQOY/AV9NRf7VUPs4JxVAfpv8k5GbFm4jlnVsyTX2Dq1Y3r+lNYONUL9oWzNuNtoulr7jio=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9D632385B51A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LnC84t/8
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20250626135927163.VTL.86286.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 22:59:27 +0900
Date: Thu, 26 Jun 2025 22:59:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-Id: <20250626225926.ab18bbe2324b53b4335a35bb@nifty.ne.jp>
In-Reply-To: <20250626142249.9a4d7378ec9fd68a7b2b8cb7@nifty.ne.jp>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
	<62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
	<20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
	<701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
	<4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
	<20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
	<20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp>
	<20250625211754.c9b38091a64362f2d28da1f8@nifty.ne.jp>
	<934bc894-d2c4-2a7a-e236-abec9e1717fb@gmx.de>
	<20250626142249.9a4d7378ec9fd68a7b2b8cb7@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750946367;
 bh=JwBKbfrPaFz+WKofAU39gBb6WZrkWD0n3vScOBcDK+0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=LnC84t/8aC0XzmtOXz2jpDJGq0NTc1ICZqlt/qkfWQLtIxMAcKZPHlTbwC+2IcABDXXMmxDZ
 VEUYCyiPjy0Qgcb2ppcRXcjsiFLk/5CC3LQA0Mg+dQ5eYhxugj1w6f8P+JGmq+wuHaWjcCemPV
 ABqDA/xeHuU7VRKy/cloyiIgn4OyCKgqGUUBOfQBvfIdSfkbiq1Wox2rvy0vnxvfW13vNjOzM/
 nq87QiRXXrbcTIzm7guoZfAj5nxV1toFWpwEiehO1kRR9/WjOmkv2AjcNViIa3lWejU/Png0mH
 B2DxXBAQkM33JRiBTEh+vaO8OWvW5S2FYuCJWYnwErfdSp5w==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 26 Jun 2025 14:22:49 +0900
Takashi Yano wrote:
> On Wed, 25 Jun 2025 17:57:56 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> > 
> > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > 
> > > On Wed, 25 Jun 2025 20:51:02 +0900
> > > Takashi Yano wrote:
> > > > On Wed, 25 Jun 2025 19:55:34 +0900
> > > > Takashi Yano wrote:
> > > > > Hi Johannes,
> > > > > 
> > > > > On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> > > > > Johannes Schindelin wrote:
> > > > > > Hi Takashi,
> > > > > > 
> > > > > > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > > > > > 
> > > > > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > > > > > 
> > > > > > > > I'd revise the patch as follows. Could you please test if the
> > > > > > > > following patch also solves the issue?
> > > > > > > 
> > > > > > > Will do.
> > > > > > 
> > > > > > For the record, in my tests, this fixed the hangs, too.
> > > > > 
> > > > > Thanks for testing.
> > > > > However, I noticed that this patch changes the behavior Corinna was
> > > > > concerned about.
> > > > 
> > > > The behaviour change can be checked using attached test case.
> > > 
> > > Hmm, then, nga888(Andrew Ng @github)'s solution seems to be
> > > the best one.
> > > https://github.com/git-for-windows/git/issues/5688#issuecomment-2995952882
> > 
> > "Best" by what rationale? That it passes the attached test case (which is
> > not a test case, by the way, as there are no assertions that can fail, and
> > it is not integrated into the test case, please fix both aspects before
> > you call it a test case).
> 
> The "bug fix" should not change the current code intent. nga888's patch
> keeps the code intent regarding write size for non-blocking write, while
> other patches do not.

No! I was wrong.
nga888's patch trys to write more than available space just like blocking
write.

Let me consider.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
