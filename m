Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8EDE13858D21; Tue,  7 Jan 2025 19:15:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8EDE13858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736277338;
	bh=VPgCtRjZlpru7fDh0kwGJTn3KZSKS1k1uCEVsr2ankI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RqqW2glfmUOBELz6gncUhvnB5FM6mNqKmcET1vFvIrpH+9Y/FTgHQQ+qfiL8xIvn5
	 pefsiPP5db79y3cvp1o7pIuKwZL55bh163phwsHVzwv2DFd+SeCPIfJkDko/6vKogs
	 oOxToKQOuxTlnqZuuNmZkqxtLqy2+9KqNdrRDZEQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B1054A80B76; Tue,  7 Jan 2025 20:15:36 +0100 (CET)
Date: Tue, 7 Jan 2025 20:15:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: mmap: fix mmap_is_attached_or_noreserve
Message-ID: <Z319WIrQbXPsOakT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <c1839ef1-b250-4316-8e00-a8e2d73fdcca@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1839ef1-b250-4316-8e00-a8e2d73fdcca@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

Happy New Year!

On Dec 27 11:46, Ken Brown wrote:
> I have a question about the "Fixes" line.  Since the commit in question was
> in the old CVS style, it doesn't have a good one-line summary.  I tried to
> choose the next-best thing, but I'm not sure about it.

Yeah, just a nice approximation of the first line in the old CVS
commit is sufficient.

Your patch looks good, only...

> @@ -784,23 +788,27 @@ mmap_is_attached_or_noreserve (void *addr, size_t len)
>  	  ret = MMAP_RAISE_SIGBUS;
>  	  break;
>  	}
> -      if (!rec->noreserve ())
> -	break;
> +      if (nocover)
> +	/* We need to continue in case we encounter an attached mmap
> +	   later in the list. */
> +	continue;
>  
> -      size_t commit_len = u_len - (start_addr - u_addr);
> -      if (commit_len > len)
> -	commit_len = len;
> +      if (!rec->noreserve ())
> +	{
> +	  nocover = true;
> +	  continue;
> +	}

What about merging the two conditionals into one?  E. g.

  if (nocover || !rec->noreserve ())
    {
      nocover = true;
      continue;
    }

It's a minor style issue, if you like your version better, go for it.


Thanks,
Corinna
