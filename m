Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 25E96385782C; Wed, 22 Jan 2025 10:20:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 25E96385782C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737541257;
	bh=YNH0oYJ0cnn4G2R/tV8u2WGyaxHyuwVo+47bfPGblbg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=YqHNUrJAL+RaSqNPmIMkWguiRsp3NeWvSEgpapXBpo71aHl7sseIfHclU8mTOzDHY
	 lUkqxaJxDfdeGcRf7ggnYwAwlWJvNeMJbQxLE/sramyOBp+BA+33+z/zZjLbkd29L/
	 wXYU8W0evj5KoOzYXt1GR8SfkHehk2nztVULwB4c=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7DF2BA80D1D; Wed, 22 Jan 2025 11:20:55 +0100 (CET)
Date: Wed, 22 Jan 2025 11:20:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
Message-ID: <Z5DGh4SHpkK6fyXv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
 <Z4TzRLHGdvcxfT_y@calimero.vinschen.de>
 <20250115221730.4b1ce8becbd1060ffb0373da@nifty.ne.jp>
 <8f026ac1-d628-4723-983f-953275ea4329@cornell.edu>
 <Z4fpeXlmjOVu-u1A@calimero.vinschen.de>
 <Z4fw48L9OmD9eMr1@calimero.vinschen.de>
 <67b40edb-6719-474c-bf05-a3fffc8b782e@cornell.edu>
 <Z444U3s1KgpspGd2@calimero.vinschen.de>
 <b9d17873-d3c3-496e-b1f4-f2ace2054414@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9d17873-d3c3-496e-b1f4-f2ace2054414@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan 20 10:36, Ken Brown wrote:
> On 1/20/2025 6:49 AM, Corinna Vinschen wrote:
> > Nice idea, but this may not do what is expected if the mapping is an
> > anonymous mapping, leaving the protection or mapping of trailing pages
> > in a wrong state, isn't it?
> > 
> > Can we easily make sure the type of mapping (file vs anon) is known
> > at the time of rounding, so the rounding is performed differently?
> I hadn't thought of that.  Actually, I *think* the record length is already
> a multiple of 64K for an anonymous mapping.

You're right, of course.  For an anonymous mapping, mmap() forces len to
be a multiple of wincap.allocation_granularity() anyway.

So yeah, looks like your previous patch does the trick.  Feel free to
push it, but I would love to see a comment in mmap_record::match() to
explain why we do it this way.


Thanks,
Corinna
