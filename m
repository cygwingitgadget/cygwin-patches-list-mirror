Return-Path: <SRS0=3baR=B5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id E7E0D4BA23C2
	for <cygwin-patches@cygwin.com>; Sun, 29 Mar 2026 00:47:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E7E0D4BA23C2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E7E0D4BA23C2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774745276; cv=none;
	b=tlVDXR5Ivgl463oWZHJUM6lZetAKO5hExQXPvXuxI5RThBko7ugCrkpYZZOhc6cYPNSI/ftvEwGe6hf0dzc2vv7jlu38hIP5MMI9tISYgYU/I1V+WcCPNIIaPWes0gTRkWXOibAAZcc7ZyTYOlSHYrIdSAUTAMRnTceQKZDwaZk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774745276; c=relaxed/simple;
	bh=/YJG0sIsV/+ZHe7n1sln0fjwZY2p7Y3RDfJgJWKEEGU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=S5Ls9XoBjUFfZ9bGas+s3v87kwoiIiGapeZFPAFoEiXaPCxGRddKFm3B4M/dYTvDQlLcWgjXfa5XFcBbV5TmxUEH1exFa/4c5DLHWwmpvkdKAQ7j0nftE5cx+71fqstO6hLcoVPjRE1wnyRAOH5Uut8aULHzvjxxBZA+Kj0jK7A=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E7E0D4BA23C2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WR9Aer5I
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260329004753091.FXNA.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 29 Mar 2026 09:47:53 +0900
Date: Sun, 29 Mar 2026 09:47:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8 0/7] Fix out-of-order keystrokes
Message-Id: <20260329094751.0a7b3c52f6e12c2587393a63@nifty.ne.jp>
In-Reply-To: <4cd2d39a-9f31-de6f-1929-2f261a5a1a80@gmx.de>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
	<20260328105632.1916-1-takashi.yano@nifty.ne.jp>
	<4cd2d39a-9f31-de6f-1929-2f261a5a1a80@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774745273;
 bh=yWjVOibUch7w2eONAvd6FbwRg0KoSi6oMELOqFFsEo0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=WR9Aer5I4neTi7L9jg0h1T0LhQVFUskTGQjb/0w2Z26HEls0FCAEc2lECUDdV99HksAFqQE+
 ejReHgZkP341PND+XupvCiZlmP/nJlaOczCsRsVYIy7xG1UO59lW+odME3ZErBGOhMEvoUJKpT
 JdyW3raYb28PBnlSa9Tb9d/I7H1Zo+/M7i1fQuq4v5JNTMn1Ol39xNZjAeqDWlgkKDpjUR6k/y
 wJWOI/X46PMFW9lMmgq5nERokYDDnf4FFeSV2t82rNJWKeFwOpnOu+t0Hr/CK7vjg1J3131Pjg
 JFjoTxiReUr6Ntc2yQnV171vDJ9c1CvHVe3le9i9hYbPTKCg==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 28 Mar 2026 15:40:54 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sat, 28 Mar 2026, Takashi Yano wrote:
> 
> > The reproducer that uses AutoHotKey provided by Johannes:
> > https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
> > uncovered several issues regarding input transfer between nat-
> > pipe and cyg-pipe. Most of the issues happen when non-cygwin
> > shell start cygwin-app. This patch series addresses these issues.
> > 
> > v8: (changes from v7)
> >   PATCH 1/7: Replace the commit message.
> >   PATCH 2/7: Replace the commit message.
> >              The handle h_pcon_in to retrieve console mode is
> >              cached now to prevent calling OpenProcess() everytime.
> >   PATCH 3/7: Replace the commit message.
> >              Add NULL check for parent_pty_input_mutex.
> >   PATCH 4/7: Replace the commit message.
> >              Use tmp_pathbuf for the buffer to applying line_edit().
> 
> It's a bit of a strange thing to use a path buffer (that is meant to hold
> an absolute path) in `line_edit()` (where it consumes input events instead
> of a path), but hey, it works ;-)
> 
> >   PATCH 5/7: Replace the commit message. Add short comment as suggested.
> >   PATCH 6/7: Replace the commit message.
> >   PATCH 7/7: Replace the commit message.
> 
> Once again: Thank you for your hard work. I have spent quite the dozens of
> hours pouring over the code (and that's nothing compared to the time I let
> Claude Opus spend with it to guide me and to test hypotheses), so I know
> how much work this was. I am thoroughly grateful!

I truly appreciate your thorough and thoughtful review!
I look forward to continuing our collaboration.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
