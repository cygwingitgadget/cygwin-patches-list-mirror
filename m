Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 88B0C3858429; Mon, 20 Jan 2025 11:49:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 88B0C3858429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737373781;
	bh=eProqst6MFc6fL6EDhvXMS+z7LwU2pKqvWbDGH3IkHY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=IkIr0KW0tYE+/3tScnY5A9Q/1WSjrYJCS0gmfHl9Z0ST5K5B6N/F56M7S4aVaLEOx
	 skgDhFX6Ak4qdidxzieQWRH41WWZj4czgWZMDtzwoXGvjY/DSLO+MRGK2Qs7pR15DP
	 DlhDE8T9H2jqNe+/F8i754ttlAxoWqLORUiIIpGE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9286FA80D3F; Mon, 20 Jan 2025 12:49:39 +0100 (CET)
Date: Mon, 20 Jan 2025 12:49:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
Message-ID: <Z444U3s1KgpspGd2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
 <Z4TzRLHGdvcxfT_y@calimero.vinschen.de>
 <20250115221730.4b1ce8becbd1060ffb0373da@nifty.ne.jp>
 <8f026ac1-d628-4723-983f-953275ea4329@cornell.edu>
 <Z4fpeXlmjOVu-u1A@calimero.vinschen.de>
 <Z4fw48L9OmD9eMr1@calimero.vinschen.de>
 <67b40edb-6719-474c-bf05-a3fffc8b782e@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67b40edb-6719-474c-bf05-a3fffc8b782e@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan 17 18:22, Ken Brown wrote:
> On 1/15/2025 12:31 PM, Corinna Vinschen wrote:
> > > Ouch.  It looks like we can't go to 64K bookkeeping.  Windows files are
> > > not length-aligned to 64K allocation granularity, but to 4K pagesize.
> > > Thus, if we align the length to 64K in mprotect or
> > > mmap_record::unmap_pages, it tries to access the unallocatd area from
> > > the EOF page to the last page in the 64K area, which, obviously fails.
> > 
> > Alternatively it has to be faked in the affected functions, which then
> > stealthily only access the pages up to EOF under the hood...
> It's possible that the following simple patch (on top of the previous patch)
> solves the problem:
> 
> --- a/winsup/cygwin/mm/mmap.cc
> +++ b/winsup/cygwin/mm/mmap.cc
> @@ -409,16 +409,28 @@ mmap_record::find_unused_pages (SIZE_T pages) const
> 
>  /* Return true if the interval I from addr to addr + len intersects
>     the interval J of this mmap_record.  The endpoint of the latter is
> -   first rounded up to a page boundary.  If there is an intersection,
> -   then it is the interval from m_addr to m_addr + m_len.  The
> -   variable 'contains' is set to true if J contains I.
> +   first rounded up to a Windows page boundary.  If there is an
> +   intersection, then it is the interval from m_addr to
> +   m_addr + m_len.  The variable 'contains' is set to true if J contains I.
> +
> +   It is necessary to use a 4K Windows page boundary above because
> +   Windows files are length-aligned to 4K pages, not to the 64K
> +   allocation granularity.  If we were to align the record length to
> +   64K, then callers of this function might try to access the
> +   unallocated memory from the EOF page to the last page in the 64K
> +   area.  See
> +
> +     https://cygwin.com/pipermail/cygwin-patches/2025q1/013240.html
> +
> +   for an example in which mprotect and mmap_record::unmap_pages both
> +   fail when we align the record length to 64K.
>  */
>  bool
>  mmap_record::match (caddr_t addr, SIZE_T len, caddr_t &m_addr, SIZE_T
> &m_len,
>                     bool &contains)
>  {
>    contains = false;
> -  SIZE_T rec_len = PAGE_CNT (get_len ()) * wincap.allocation_granularity
> ();
> +  SIZE_T rec_len = roundup2 (get_len (), wincap.page_size ());
>    caddr_t low = MAX (addr, get_address ());
>    caddr_t high = MIN (addr + len, get_address () + rec_len);
>    if (low < high)
> 
> I've checked that gdb functions normally after this patch, but I can't claim
> to have thought through all possible situations where an mmap-related
> function might fail as a result of switching to 64K bookkeeping.

Nice idea, but this may not do what is expected if the mapping is an
anonymous mapping, leaving the protection or mapping of trailing pages
in a wrong state, isn't it?

Can we easily make sure the type of mapping (file vs anon) is known
at the time of rounding, so the rounding is performed differently?


Thanks,
Corinna
