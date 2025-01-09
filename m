Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D2D293858D34; Thu,  9 Jan 2025 17:17:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D2D293858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736443075;
	bh=fW+4VgTAF8lWc3emph1VvmC/P802CY+7bv9xO1BNpLA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=sRMNqcpVTEMZ2nlbONNKlr8WZ9gXjIgM27LdaHc5HGWpUIp9bFh22rwV7y7Ztk1Q0
	 gFfLMJo/QlW0QQiQigrUX/3SnyjI418RjFk//P6FmNLVfoDmpopIUGSxwgcMAvAWrl
	 qMZ8wiNM/KbFPyyznRoa6yqsiEf/HvERBltJdUpE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DC4D8A80C65; Thu,  9 Jan 2025 18:17:51 +0100 (CET)
Date: Thu, 9 Jan 2025 18:17:51 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: mmap: refactor mmap_record::match
Message-ID: <Z4AEv4Sen6VqT-pz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9d64113d-0355-4df3-b477-952c4f315292@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d64113d-0355-4df3-b477-952c4f315292@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

On Jan  8 18:03, Ken Brown wrote:
> From 4387a73d5593ddad4cf7592865b5b257e6a9d6de Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Fri, 27 Dec 2024 15:30:12 -0500
> Subject: [PATCH 1/5] Cygwin: mmap: refactor mmap_record::match
> 
> Slightly simplify the code and add comments to explain what the
> function does.  Add a new reference parameter "contains" that is set
> to true if the chunk of this mmap_record contains the given address
> range.
> 
> Signed-off-by: Ken Brown <kbrown@cornell.edu>
> ---
>  winsup/cygwin/mm/mmap.cc | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
> index 0224779458ef..acab85d19cf0 100644
> --- a/winsup/cygwin/mm/mmap.cc
> +++ b/winsup/cygwin/mm/mmap.cc
> @@ -338,7 +338,8 @@ class mmap_record
>      void init_page_map (mmap_record &r);
>  
>      SIZE_T find_unused_pages (SIZE_T pages) const;
> -    bool match (caddr_t addr, SIZE_T len, caddr_t &m_addr, SIZE_T &m_len);
> +    bool match (caddr_t addr, SIZE_T len, caddr_t &m_addr, SIZE_T &m_len,
> +                bool &contains);

What about keeping

  bool match (caddr_t addr, SIZE_T len, caddr_t &m_addr, SIZE_T &m_len);

available as inline method just calling the new match() method with
a local "contains" variable?  This way, you don't have to define dummy
"contains" where the value is unused...

Other than that, LGTM.


Thanks,
Corinna
