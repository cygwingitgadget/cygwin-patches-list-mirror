Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2F03C3858D32; Mon,  3 Jul 2023 10:56:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2F03C3858D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688381766;
	bh=MqLLAgXw3W201wfWo6FRXTqB9IHYKZxKhP3dsQXR+bM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Apc81wLBYxFBuyUzLwhxggAt6UWiUMH8YLdCZdlVSRxOe/683mozniES7XrqI3lfv
	 +p4A4Z18mxZTAhgpNbLIa+MO5peJwy7Yq3/pRnoHjkkdmcwvlC4ZIY4bz9+7GFA0Ha
	 0J/OgtoCooUQOtTKpHpD+ysfS3tMTMhgLZ8zblgg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 68EF6A80F77; Mon,  3 Jul 2023 12:56:04 +0200 (CEST)
Date: Mon, 3 Jul 2023 12:56:04 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make <sys/cpuset.h> safe for c89 compilations
Message-ID: <ZKKpRHhq1K27hnAh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20230703061730.5147-1-mark@maxrnd.com>
 <b5d4a958-cab1-ab8f-d268-0be51e4ebf34@Shaw.ca>
 <ec36ad41-7a70-b0bb-83fe-12fb6e905b3c@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec36ad41-7a70-b0bb-83fe-12fb6e905b3c@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Jul  3 02:27, Mark Geisert wrote:
> Hi Brian,
> 
> Brian Inglis wrote:
> > On 2023-07-03 00:17, Mark Geisert wrote:
> > > Three modifications to include/sys/cpuset.h:
> > > * Change C++-style comments to C-style also supported by C++
> > > * Change "inline" to "__inline" on code lines
> > > * Don't declare loop variables on for-loop init clauses
> > > 
> > > Tested by first reproducing the reported issue with home-grown test
> > > programs by compiling with gcc option "-std=c89", then compiling again
> > > using the modified <sys/cpuset.h>. Other "-std=" options tested too.
> > > 
> > > Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
> > > Fixes: 315e5fbd99ec ("Cygwin: Fix type mismatch on sys/cpuset.h")

Signed-off-by?

> > Does this patch need __inline defined e.g.
> > 
> >    +#include <sys/cdefs.h>
> > 
> > did you perhaps include this directly in your test cases?
> > 
> > > -static inline size_t
> > > +static __inline size_t
> > ...
> 
> No, not directly.  The test case with the shortest list of #includes has:
> #define _GNU_SOURCE
> #include <assert.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/cpuset.h>
> #include <sched.h>
> 
> So it's apparently defined by one of those or some sub-include.  But indeed
> it's not safe to depend on that so I will try harder to figure out what
> other occurrences of __inline in the Cygwin source tree are depending on for
> the definition.
> Thanks,

Great.


Thanks,
Corinna
