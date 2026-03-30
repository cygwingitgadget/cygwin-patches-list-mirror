Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ADF354BA2E3B; Mon, 30 Mar 2026 08:33:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ADF354BA2E3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774859599;
	bh=NorbSmZLK0LjgPWe31wlnTr866YUNA6GKlo3uSV1Ueo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fumAz21h+736PaQjq9GZFdCCUefJ7+mI7LwYgwxGWanvXyWSU5hmHr0CSy5v6kQWY
	 qrikLgV5EDILJ+AZJzVjZu9Z8aDfFYKKn2YNfpqRrdQUKPOXNQZ4wS5YYPUGgDP8M+
	 LoqhuLOnrRNUF0+SxP6E1/yoDZ/WZwOY8T1fZrLc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 77C5AA80B7C; Mon, 30 Mar 2026 10:33:17 +0200 (CEST)
Date: Mon, 30 Mar 2026 10:33:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
Subject: Re: [PATCH 0/1] Cygwin: Fix SEH and signal handling on AArch64
Message-ID: <aco1TU7r-Y2C13iR@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
References: <cover.1774613608.git.igor.podgainoi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774613608.git.igor.podgainoi@arm.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Igor,

On Mar 27 12:41, Igor Podgainoi wrote:
> Hello,
> 
> The following patch is one of two additions that extends the two
> patches posted on 2026-03-24 by
> Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
> which fills in the missing EXCEPTION_HANDLER_DATA definition for
> AArch64 as well as performs other modifications. Please refer to
> the commit message for more information about what those are.
> 
> URL to base patches:
> https://cygwin.com/pipermail/cygwin-patches/2026q1/014825.html
> 
> This patch should apply cleanly on top of the base patches and
> current main as of 2026-03-27.

All patches pushed.


Thanks,
Corinna
