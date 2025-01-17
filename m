Return-Path: <SRS0=eDVj=UJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id AE8CA384A45D
	for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2025 09:52:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AE8CA384A45D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AE8CA384A45D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737107566; cv=none;
	b=bqdJT2QuauBilRynAxfV3jFXqk6UgNOPgcVzXffPQ24KGHPD7w0zHg6JZFghJ/+Bu/b0R2jKoW8tEzaPW2TzWI4SWDd8iMysbbru+agrvRW3kSccelZsG7t3ALob5kMB4EI6tVqmhLF6eB6T5lkdTEgqD4rsbIG+DOQHcfoamc0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737107566; c=relaxed/simple;
	bh=CXZxXPjMypsi+5x33V1rLMkk/CO6UJVT0yf1IUsMzXU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LeqggNZlcI0h15fTmR86s3jxQCGb8p8c6rN/K1r9OMMqUYFUOnrBqlMott4hR24jdXDYVsfpnDCFRvqyZeLfdJVrlv4A8BHJApWdJbXEXOKuDK2b3Z84gmI5YymEHoJh1yvfMS+Xo+oXEAj8FDyvnW/TU6pWLYW1DpI1Tx0++Oo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AE8CA384A45D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UCageO6S
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20250117095243390.LQVV.4660.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2025 18:52:43 +0900
Date: Fri, 17 Jan 2025 18:52:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250117185241.34202389178435578f251727@nifty.ne.jp>
In-Reply-To: <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737107563;
 bh=SHhAuHZ2O7dpDepGSy8q0ViNyVGpMf+NbQXyC1RBjTE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=UCageO6SEFWebzI0CDndiwNcMhPoF/fUgwZd8wXsJLY3PVDecMFxCYqgEHoPRqGa21RwzKUl
 X4+bz6z22thUKH9wSZeghCuV1PogT47uJuExRNaUS5FPDG92nrM1elxznFyXL7WfJeoJ9eQUob
 pHcAr441q5vZOWDhMk6dpUmtrWuEME92idl04oEDqE+Oi1/4sOLrgA1w1DFHwohCN1HmnOyDpS
 oqmCbkeB6UT5fNbvckva5bqIHdc1viyaiTnSCtjj0Nhmye36SNzVFgsXsAr9Ux35ksgyVp0Fn4
 2jA+WaehlPHMtjwcAyv82iaVWcJ5CHMlKW+E1hdW+dIUL+FA==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 8 Jan 2025 18:05:53 -0800 (PST)
Jeremy Drake wrote:
> On Thu, 9 Jan 2025, Takashi Yano wrote:
> 
> > On Wed, 8 Jan 2025 16:48:41 +0100
> > Corinna Vinschen wrote:
> > > Does this patch fix Bruno's bash issue as well?
> >
> > I'm not sure because it is not reproducible as he said.
> > I also could not reproduce that.
> >
> > However, at least this fixes the issue that Jeremy encountered:
> > https://cygwin.com/pipermail/cygwin/2024-December/256977.html
> >
> > But, even with this patch, Jeremy reported another hang issue
> > that also is not reproducible:
> > https://cygwin.com/pipermail/cygwin/2024-December/256987.html
> 
> Yes, this patch helped the hangs I was seeing on Windows on ARM64.
> However, there is still some hang issue in 3.5.5 (which occurs on
> native x86_64) that is not there in 3.5.4.  Git for Windows' test suite
> seems to be somewhat reliable at triggering this, but it's hardly a
> minimal test case ;).
> 
> Because of this issue, MSYS2 has been keeping 3.5.5 in its 'staging' state
> (rather than deploying it to normal users), and Git for Windows rolled
> back to 3.5.4 before the release of the latest Git RC.

I might have successfully reproduced this issue. I tried building
cygwin1.dll repeatedly for some of my machines, and one of them
hung in fhandler_pipe::raw_read() as lazka's case:
https://github.com/msys2/msys2-runtime/pull/251#issuecomment-2571338429

The call:
L358:         waitret = cygwait (select_sem, select_sem_timeout);
never returned even with select_sem_timeout == 1 until a signal
(such as SIGTERM, SIGKILL) arrives. In this situation, attaching
gdb to the process hanging and issuing 'si' command do not return.
Something (stack?) seems to be completely broken.

I'll try to bisect which commit causes this issue. Please wait
a while.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
