Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7F7743858C5F; Mon, 18 Mar 2024 15:45:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F7743858C5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1710776748;
	bh=V/2K4mwCTgJY1D2iSn5p3XxGkj6UctjHABOLXtESUag=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rUOaDcx42Azl3Vp1WerAcwJ+I1gAXDgIJxtYJN2xQFyIbENjetBj2yjsyM+321FpN
	 grJE0YWMn71loYtKmF9LWhsz+zJq3WGQWq0SvhkUemf1aJt/3HKPVV5aY6uQcXA0Pd
	 3OThq6N8st3Kk+1mcuofiG7FLkG2gK5oTaPcfSBE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 592A7A80BFE; Mon, 18 Mar 2024 16:45:45 +0100 (CET)
Date: Mon, 18 Mar 2024 16:45:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/cygwin/fhandler/proc.cc: format_proc_cpuinfo()
 Linux 6.8 cpuinfo flags
Message-ID: <ZfhhqUSzxS11qU3n@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <86a84fad25ec3b5c49e9b737dfccbdb2f510556e.1710519553.git.Brian.Inglis@SystematicSW.ab.ca>
 <ZfgKd7GX7o7gCoX7@calimero.vinschen.de>
 <1ebfb5dd-f5b8-4f6c-a6aa-e1b7873d7802@systematicsw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ebfb5dd-f5b8-4f6c-a6aa-e1b7873d7802@systematicsw.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Mar 18 08:10, Brian Inglis wrote:
> On 2024-03-18 03:33, Corinna Vinschen wrote:
> > Hi Brian,
> > 
> > On Mar 16 10:44, Brian Inglis wrote:
> > > add Linux 6.8 cpuinfo flags:
> > > Intel 0x00000007:1 eax:17 fred		Flexible Return and Event Delivery;
> > > AMD   0x8000001f   eax:4  sev_snp	SEV secure nested paging;
> > > document unused and some unprinted bits that could look like omissions;
> > > fix typos and misalignments;
> > 
> > I'm a bit puzzled about the "unused" slots.  You're adding them
> > only in some places.  What makes them "look like omissions"?
> 
> Mainly because single bits are omitted, presumably because they do not want
> to pollute the symbol space with as yet unused features, just as they do not
> output all features as cpuinfo flags, until it indicates something about the
> build and/or system.
> 
> Compare the minimal common standard feature bits defined in the gcc lib
> cpuid.h and gcc cpuinfo.h headers, with Linux cpuinfo cpufeatures.h, and the
> output of the cpuid utility, where almost all bits in older cpuid entries
> are defined.

I see.  I just don't understands the difference between, say,

  ftcprint (features1, 21, "avx512ifma");   /* vec int FMA */
+ /*  ftcprint (features1, 22, ""); */      /* unused */
  ftcprint (features1, 23, "clflushopt");   /* cache line flush opt */

and

  ftcprint (features1,  3, "xsaves");       /* xsaves/xrstors */
+ /*  ftcprint (features1,  4, "xfd"); */   /* eXtended Feature Disabling */

The latter makes sense, of course, but why is the first comment "unused",
rather than something like "PCOMMIT instruction" as in the cpuid output?

Note that I'm not saying that you have to change that, but I would like
to understand it.


Thanks,
Corinna
