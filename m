Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0BA5C3858D26; Tue,  7 Jan 2025 20:18:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0BA5C3858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736281097;
	bh=3UITBwFeg1Uuh9lO53Z7WXmER+230bQjRnFhOibvBxI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=igFEfMHorcU+FTZURnn/D0rBZW2GuRDPpSTem8YyKPtKfXF9D23ea0EyVQETpFwwq
	 i7lkvl+JpYzGcar9FRNG1jgqXQxVl7LgAhyxia84kWxMCC3uMYho5d+ieK9n4DKhX1
	 47TWoT8fwaHuROS5y88zcl+pAE4GMUWfGMyBKGSU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 15EE5A80B76; Tue,  7 Jan 2025 21:18:15 +0100 (CET)
Date: Tue, 7 Jan 2025 21:18:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: allow remapping part of an existing
 anonymous, mapping
Message-ID: <Z32MB5VR4vCszv9J@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
 <9b717926-06fb-4d34-a473-a709316de429@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b717926-06fb-4d34-a473-a709316de429@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

On Jan  2 16:42, Ken Brown wrote:
> From 625c77a82925185805ad57d5ef3f0d0d90dc9b57 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Fri, 27 Dec 2024 16:09:40 -0500
> Subject: [PATCH v2] Cygwin: mmap: allow remapping part of an existing
>  anonymous mapping
> 
> Previously mmap with MAP_FIXED would fail with EINVAL on an attempt to
> map an address range contained in the chunk of an existing mapping.
> With this commit, mmap will succeed, provided the mappings are
> anonymous, the MAP_SHARED/MAP_PRIVATE flags agree, and MAP_NORESERVE
> is not set for either mapping.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256901.html
> Signed-off-by: Ken Brown <kbrown@cornell.edu>
> ---
>  winsup/cygwin/mm/mmap.cc    | 45 ++++++++++++++++++++++---------------
>  winsup/cygwin/release/3.6.0 |  6 +++++
>  2 files changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
> index fc126a87072a..0224779458ef 100644
> --- a/winsup/cygwin/mm/mmap.cc
> +++ b/winsup/cygwin/mm/mmap.cc
> @@ -494,18 +494,24 @@ mmap_record::map_pages (caddr_t addr, SIZE_T len, int new_prot)
>    off_t off = addr - get_address ();
>    off /= wincap.page_size ();
>    len = PAGE_CNT (len);
> -  /* First check if the area is unused right now. */
> -  for (SIZE_T l = 0; l < len; ++l)
> -    if (MAP_ISSET (off + l))
> -      {
> -	set_errno (EINVAL);
> -	return false;
> -      }
> -  if (!noreserve ()
> -      && !VirtualProtect (get_address () + off * wincap.page_size (),
> -			  len * wincap.page_size (),
> -			  ::gen_protect (new_prot, get_flags ()),
> -			  &old_prot))
> +  /* VirtualProtect can only be called on committed pages, so it's not
> +     clear how to change protection in the noreserve case.  In this
> +     case we will therefore require that the pages are unmapped, in
> +     order to keep the behavior the same as it was before new_prot was
> +     introduced.  FIXME: Is there a better way to handle this? */
> +  if (noreserve ())
> +    {
> +      for (SIZE_T l = 0; l < len; ++l)
> +	if (MAP_ISSET (off + l))
> +	  {
> +	    set_errno (EINVAL);
> +	    return false;
> +	  }
> +    }

I think this is ok for the time being.  But since you're asking...

When we talked about this last month, I already felt that the
implementation is lacking.  Actually, it's missing two things which
would improve MAP_NORESERVE mappings considerably:


- mmap_record::prot flag, should be an array of protection bits per page
  (POSIX page i e., 64K, not Windows page).  Right now we only store the
  first protection set at mmap time for the entire map, rather than the
  requested protection of every single page.  Consider this scenario:

    addr = mmap (NULL, 4 * PAGESIZE, PROT_READ | PROT_WRITE,
		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0L);

    /* At this point, mmap_record::prot is PROT_READ | PROT_WRITE */

    mprotect (addr + 2 * PAGESIZE, PAGESIZE, PROT_READ);

    /* At this point, mmap_record::prot *still* is PROT_READ | PROT_WRITE */

    /* This write to the memory region will commit page 3... */
    addr[2 * PAGE_SIZE + 42] = 1;

    /* ...but should have raised a SIGSEGV because the page is supposedly
       non-writable! */

  The reason is obvious: We only store the start protection PROT_READ |
  PROT_WRITE.  So if we access the page, mmap_is_attached_or_noreserve()
  calls VirtualAlloc() with the start protection bits.
  If we store the protection per page, mmap_is_attached_or_noreserve()
  can call VirtualAlloc with the correct page protection and we receive
  the deserved SIGSEGV.


- For mprotect() it doesn't in fact matter if a page is MAP_NORESERVE or
  not.  It only matters if the page has been written to (that is, it has
  been committed) or not (that is, it's still reserved).

  If the page is still only reserved map_pages() can just change the
  protection bits in mmap_record::prot[page].  If the page was already
  commited, it can additionally call VirtualProtect() with the new
  per-page protection.

  We don't even need to keep track of reserved vs. commited, because
  VirtualQuery() already does that for us.


Thanks,
Corinna
