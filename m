Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5FB7B385DDD3; Mon,  2 Sep 2024 10:54:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5FB7B385DDD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1725274486;
	bh=IcKRqZRdPc+Wu5KI8jtIG0dhtVNQSqkeDnS7gdPzfmI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Qj77tSyeO6W9HZRevIj5PFhhVGif1nmO9N8a0L+VisgFSqOCP/4Jl/d28wtqVBvAa
	 ivAjT/9ngiauXMRF08LDdcSilx7ZdoCNrKrZUQstcNrctMktaI42tjaZyqTj/12DMI
	 NcXot+pf/3R0+/sx0M1J3kDW8JrZw7JYVw35UPhU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4478AA80B9C; Mon,  2 Sep 2024 12:54:44 +0200 (CEST)
Date: Mon, 2 Sep 2024 12:54:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Fix a regression that raw_write() slows
 down
Message-ID: <ZtWZdDvoAQkvfg5i@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240831194655.1555-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240831194655.1555-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Sep  1 04:46, Takashi Yano wrote:
> After the commit 7f3c22532577, writing to pipe extremely slows down.
> This is because cygwait(select_sem, 10, cw_cancel) is called even
> when write operation is already completed. With this patch, the
> cygwait() is called only if the write operation is not completed.

Ouch, yes, please push.

Thanks,
Corinna
