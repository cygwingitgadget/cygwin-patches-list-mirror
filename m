Return-Path: <SRS0=RZgb=JP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 6D49A438C5EB
	for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2026 00:57:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6D49A438C5EB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6D49A438C5EB
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795654632; cv=none;
	b=J7t125oGdiyM0aaTLzAYQI0MlH372HcozkM5m2VvUACgyw9BMLuNxogHc3Sqc3BNaf8KtEbaKJaGID4qAcfkOuqdUog8qsmktF+z5APRNRSHUrzPf3Es5TBWbCCqYD9VwfoFYMMFmIQny4b1wQKTzC2v9AXmz9PSnEzf2ziVHVo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795654632; c=relaxed/simple;
	bh=FaDdLq0FJBaA0frkcNke0C5sdO3uj2+we9DEh4L2Tic=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=WlYyIHgSzw3V3a8e5uIGgZYpEunDUZsVMjABHpGOEQgiAXbPySmcrFi4BPJLT6SWWURKEdN+7p2EseVn2u9JQEoH7UwWXsMyI9GY+ZkqfG+MYUaCcLNNvJmu7nZN6CaO0E8OLwiMnvfBuk0fwJ5pCB/W5xotQGLhHtkGCFUp9WU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VAC+UJZg
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6D49A438C5EB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VAC+UJZg
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20261126005707488.VRIO.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2026 09:57:07 +0900
Date: Thu, 26 Nov 2026 09:57:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: pthread: Improve the performance of the
 destructor
Message-Id: <20261126095706.4dae07ccf98a12ac8bc9bcc2@nifty.ne.jp>
In-Reply-To: <abdd00fc-22af-4d70-9bac-aa27113d16dc@maxrnd.com>
References: <20261124031736.1926-1-takashi.yano@nifty.ne.jp>
	<abdd00fc-22af-4d70-9bac-aa27113d16dc@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1795654627;
 bh=K8r47Tg0E9hUJzGIg2GP88k0lfRGO+UOchFyYr3yqLo=;
 h=Date:From:To:Subject:In-Reply-To;
 b=VAC+UJZgNZ775kKu/c4gfSq619lfZz74yrXiGf4vsIfoZH0LqTrvCk5TELFdHf55t+dO+CB0
 8DSNyiOE9Om/QsKrNxAZNEmAKM5+yf3AcLWq0PzQO72KoBiErdlgzV5LZI97W/3CeVIn2/rGfH
 YASeLYOR8VUnHNH8j101USqpYcj3yHSAYI468wal56LPmCs3SztglR+0mirvW0CdiTRAe0n71N
 4lhD/evVIWl8k0mbVaDi7aUHBfRI3JtAXmgE16aABUQag/QiGTwrjdIjmuiiC5imV1uk6fNSP/
 XdPqvaPvyY5TCAgVRTLPwqtHcgejs17iNyTJ/amLehX13opQ==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for reviewing. Applied.

On Wed, 25 Nov 2026 01:58:06 -0800
Mark Geisert <mark@maxrnd.com> wrote:

> Hi Takashi,
> 
> This patch LGTM.  Nice catch, and nicely done fix.
> Thanks & Regards,
> 
> ..mark
> 
> On 11/23/2026 7:17 PM, Takashi Yano wrote:
> > Deleting pthread-related objects, such as pthread_mutex, becomes very
> > slow when the number of the objects is large. Currently, these objects
> > are managed in a singly linked list, where deletion requires O(n) time.
> > As a result, deleting all objects takes O(n^2) time overall. Due to
> > this issue, freeing a decoder in libde265 can sometime take several
> > tens of seconds, because libde265 uses around 100,000 pthread_mutex
> > objects depending on the video being decoded.
> > 
> > This patch changes the list to a doubly linked, reducing the overall
> > deletion comlexity from O(n^2) to O(n).
> > 
> > Fixes: 5c83f260b87b ("(pthread_key_destructor_list::Remove): New function.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:[...]


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
