Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9E13D38515E1; Fri,  4 Jul 2025 09:31:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9E13D38515E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751621473;
	bh=NmVUuzigLbHWvbOwQLnzeftnCTwFouQluLWg5o4h1I8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=mjAEnWoVr04jS45hletTHtIBPnIr9fzHq6R10b2bInPM2le1TqPZp8SZEPJc3dSlA
	 FHmpUYBs6417pILQQdetvXKKWN3yacuhOHVbFb2jtVhtZ6CpA3PuiXggWXMMCbTm8Z
	 xBKZq0FcNlJ6Z5dYnZ7fRw0y4B1+6FaJ6cms0le8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6C7B3A80858; Fri, 04 Jul 2025 11:31:07 +0200 (CEST)
Date: Fri, 4 Jul 2025 11:31:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] install: add Q&A: What packages are available
Message-ID: <aGefW5_dLx3E5ipY@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250627214545.221-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627214545.221-1-johnhaugabook@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 27 17:45, johnhaugabook@gmail.com wrote:
> From: John Haugabook <johnhaugabook@gmail.com>
> 
> This patch adds a Q&A regarding finding available packages, linking to the
> package search and cygcheck page, and includes a tip on performing a
> command-line search with cygcheck so that existing tools are more accessible
> and visible to users.
> 
> ---
>  install.html | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/install.html b/install.html
> index 85c1cb49..ff07fc81 100755
> --- a/install.html
> +++ b/install.html
> @@ -100,6 +100,19 @@ installation.  Be advised that this will download and install tens of gigabytes
>  of files to your computer.
>  </p>
>  
> +<h2 class="cartouche" id="packages">Q: What packages are available?</h2>
> +
> +<p>
> +A: To find available packages, and view what package contains <i>X</i> see the
> +<a href=" https://cygwin.com/packages/">package search</a> page.
> +</p>
> +
> +<p>
> +<b>Tip:</b> Perform a search from the command-line using
> +<a href="https://cygwin.com/cygwin-ug-net/cygcheck.html"><code>cygcheck</code></a>
> +using <code>-p package</code> or <code>-e package1 package2 ...</code> options.
> +</p>
> +
>  <h2 class="cartouche" id="verify-sig">Q: How do I verify the signature of setup?</h2>
>  
>  <p>A: e.g.</p>
> -- 
> 2.49.0.windows.1
> 

Pushed.

Thanks,
Corinna
