Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E8D594BA2E04; Mon, 15 Dec 2025 15:22:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E8D594BA2E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765812161;
	bh=l5eAR+0Wu3KojFi/FCFNeE44Q5p52q/9sJkw+YQ5Hhs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=iOfd9x9IHiTsErwkU5v/AOw1D4iswMsK1yri7O3IHBBbT/jKwepzgNljbXFmPC54c
	 1YdShRRExVO/BbPOGFe1sPqiguxw7eYHwV5jWaEqW5S9Z57lJzq07tRmtWngVzYXnU
	 2ec/6l9nizzuWtTui2Ly4Ww8oWyPjq97lCYYRB8U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2A780A80CA4; Mon, 15 Dec 2025 16:22:40 +0100 (CET)
Date: Mon, 15 Dec 2025 16:22:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
Message-ID: <aUAnwAavInn39Gm2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
 <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Dec 15 14:37, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 0a9ee3ea23 (Allow executing Windows Store's "app execution aliases",
> 2021-03-12), I introduced support for calling Microsoft Store
> applications.
> 
> However, it was reported several times (first in
> https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=jUHL_pShff+aRv9P1Eiug@mail.gmail.com
> and then also in
> https://github.com/msys2/MSYS2-packages/issues/1943#issuecomment-3467583078)
> that there is something amiss: The standard handles are not working as
> expected, as they are not connected to the terminal at all (and hence
> the application seems to "hang").
> 
> The culprit is the `is_console_app()` function which assumes that it can
> simply open the first few bytes of the `.exe` file to read the PE header
> in order to determine whether it is a console application or not.
> 
> For app execution aliases, already creating a regular file handle for
> reading will fail. Let's introduce some special handling for the exact
> error code returned in those instances, and try to read the symlink
> target instead (taking advantage of the code I introduced in 0631c6644e
> (Cygwin: Treat Windows Store's "app execution aliases" as symbolic
> links, 2021-03-22) to treat app execution aliases like symbolic links).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

  Fixes: <12-digit-SHA1> ("commit message headline")


Thanks,
Corinna
