Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6CA583858D20; Tue, 12 Nov 2024 12:10:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6CA583858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1731413457;
	bh=MIFfXtIXw1N2DTjh8EdCMWJpsECUj2bDpuidKwzzYms=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=UpDnX37rIR6HUSZUfNPY+Glh+yaU5esCzX0mzWw1CaP3NPmVQxfm0pZepmhhgx9qQ
	 30BZKLV615T2SFfRyQ5twm3UnzJw2DiSnTfxgnPKrrfElPznibAeu9I62iOy7Qtnst
	 aBHf/9Ox8DU+sPRgbkBYfv7oSZ5CmAaoMH56Cvjg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3D7E1A805D5; Tue, 12 Nov 2024 13:10:55 +0100 (CET)
Date: Tue, 12 Nov 2024 13:10:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: Change pthread_sigqueue() to accept thread id
Message-ID: <ZzNFzwzq9wRsYjVM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241112063844.1990-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112063844.1990-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 11 22:38, Mark Geisert wrote:
> Change the first parameter of pthread_sigqueue() to be a thread id rather
> than a thread pointer. The change is to match the Linux implementation of
> this function.
> 
> The user-visible function prototype is changed in include/pthread.h.
> The pthread_sigqueue() function is modified to work with a passed-in thread
> id rather than an indirect thread pointer as before.  (It used to be
> "pthread_t *thread", i.e., class pthread **.)  The release note for Cygwin
> 3.5.5 is updated.
> 
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-September/256439.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 50350cafb375 ("* cygwin.din (pthread_sigqueue): Export.")
> 
> ---
>  winsup/cygwin/include/pthread.h | 2 +-
>  winsup/cygwin/release/3.5.5     | 3 +++
>  winsup/cygwin/thread.cc         | 8 ++++----
>  3 files changed, 8 insertions(+), 5 deletions(-)

Pushed to main and cygwin-3_5-branch.

Thanks,
Corinna
