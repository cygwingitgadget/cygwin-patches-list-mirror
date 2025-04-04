Return-Path: <SRS0=Ctoq=WW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id 2BFF53846466
	for <cygwin-patches@cygwin.com>; Fri,  4 Apr 2025 14:41:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2BFF53846466
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2BFF53846466
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743777692; cv=none;
	b=kAWinbH+KII4lJbDhyjZlYq1A7TZWzKgK3UHh12P5R8K7OS2WjrPhQDLbBFGAHtOhs7Jh+Sh+YuuyW509HnAA16X7Fi4xEZUuN55TtGrKxHPqK5LdUQ7j8Fq62oI2VSiINJ860kleLMOfhtMx2TVh/+WXHJFnWZVpdTeUgPKlWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743777692; c=relaxed/simple;
	bh=KApKY/updC60mWt+FEnHeA+28h0MIOJwS8LydzVSKLA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YG0oDnRSEAajGvOwQs8sG/SCpG4U6Wq1zexnuGpWZU0ktatgmIAfCi5dEKiBlEACxMmZFqDvWKgKqwZH3BNl57XRZ58PZFkBES/Jvcyp036s3dtstfaxz/qyWNPaYmkqGfy2eH46PnDTuv6mWGSEtZgiHJyCP4EiAMebjgVtk20=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2BFF53846466
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bTjj2zah
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20250404144130387.DPJK.84842.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 4 Apr 2025 23:41:30 +0900
Date: Fri, 4 Apr 2025 23:41:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other
 initializations
Message-Id: <20250404234129.144ce273445bab47737cbdeb@nifty.ne.jp>
In-Reply-To: <15ea8e11-bef3-f08e-e0a1-c6c5aaaad519@gmx.de>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp>
	<969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de>
	<ec45497d-a248-1056-4993-da137267b7c5@jdrake.com>
	<20250404105839.6652c8849bfb169d669f3799@nifty.ne.jp>
	<C262E1A5-1B14-4D38-AE47-2EC7709DB6D1@gmx.de>
	<20250404210609.b0d38a4cac7e195ad20a9ced@nifty.ne.jp>
	<57624128-5aa1-b47f-a192-2b342eb2072b@gmx.de>
	<20250404225337.08412ac9089cc9a066cae4da@nifty.ne.jp>
	<15ea8e11-bef3-f08e-e0a1-c6c5aaaad519@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1743777690;
 bh=pI7XeCTQSJ8rjISOlVK2gwgpT9VA27J0ZzJ5cOAlVxU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=bTjj2zah8rrB0jYLKTBYITNrXYPWoU9YZNpRAU3UQZqfowEtlCWPjh9oitp6lKhIkQV7ZPef
 xcQOu9/Y1+bob/jezYDgNbf8bpsYPgiH5YZ6qA4sS2n9/Cgq6TKdHEZyIyIF49abnqdVwGFyb3
 Ng2IZkgavRzSi8FPzgY/fRjfvsK5TmIclgmlvWSkMuGGM6B1/lQ5FFDWH95K1hGachDF1DY3bD
 fv98xMQ3Juewue3kKa+SmmdGICUqpZAifiYFm1xDyhMsXq8Cx2oMyumTZ+UNVHmTp8Bhr9+7yP
 u8ao1lxtsTx5jQhxn9qMEufNmxvyvXU876PJI9XlxXLSA37g==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 4 Apr 2025 16:17:21 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 4 Apr 2025, Takashi Yano wrote:
> 
> > On Fri, 4 Apr 2025 14:13:57 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > On Fri, 4 Apr 2025, Takashi Yano wrote:
> > > > On Fri, 04 Apr 2025 07:27:09 +0200 Johannes Schindelin wrote:
> > > >
> > > > > Is Jeremy's guess "if raw_write doesn't need to wait (ie, there's room
> > > > > in the pipe for the write) it doesn't hit the signal stuff" correct?
> > > > > If so, it would be good to add that part to the commit message because
> > > > > the commit would otherwise still be incomplete.
> > > >
> > > > That's not correct. Indeed, raw_write() waits for room in the pipe,
> > > > however, it does not matter in this case. The probelm occurs at
> > > > cygwait() which waits for pipe mutex as already mentioned in the commit
> > > > message.
> > >
> > > So what is the explanation, then, that this hung only occasionally and not
> > > all the time?
> >
> > As far as I investigated, the event handle signal_arrived was never
> > initialized all the time. Therefore, the its value is just copied from
> > the parent. The event signal_arrived is not inheritable, so, the handle
> > value is basically not a valid one.
> 
> But that means that the `signal_arrived` that is copied from the parent
> process should be invalidated in the child processes, right?

Yes.

The 'value' of the handle is copied by child_copy() because the process
is forked, however, the handle itslef is not validated because the handle
is created by:
      signal_arrived = CreateEvent (NULL, false, false, NULL);
(i.e. lpEventAttributes is NULL)

[in, optional] lpEventAttributes
A pointer to a SECURITY_ATTRIBUTES structure. If this parameter is NULL,
the handle cannot be inherited by child processes.

> Again, good material for the commit message, so that others do not have to
> repeat your analysis in its entirety.

OK.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
