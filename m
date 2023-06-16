Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6BAA03858035; Fri, 16 Jun 2023 19:51:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6BAA03858035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1686945064;
	bh=o9VuBb0fF5S6KQDEM7IlD2lCm2P8nC58lmULzfbqLfY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=A2rq4pPiBjeFu9pIZwGXuDTRTy+7PBIL1dfVIjt5qjyTLlp8bMNCCGnOAXuV/NHfV
	 MEoP3ZOUzQs02Bu4gHXwd9+jl4yIXg+UhhbdMx/u/HDqtnff/AGn0XsYVAQUUOJnQ+
	 +jut5K5LQGlnq2Os22rbBUORW2PToamJkX6StksM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B0260A80B72; Fri, 16 Jun 2023 21:51:02 +0200 (CEST)
Date: Fri, 16 Jun 2023 21:51:02 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/3] use wincap in format_proc_cpuinfo for user_shstk
Message-ID: <ZIy9JuA2wxH4i37A@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

On Jun 16 11:17, Brian Inglis wrote:
> Fixes: 41fdb869f998 "fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo"
> 
> In test for for AMD/Intel Control flow Enforcement Technology user mode
> shadow stack support replace Windows version tests with test of wincap
> member addition has_user_shstk with Windows version dependent value
> 
> Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>
> 
> Brian Inglis (3):
>   wincap.h: add wincap member has_user_shstk
>   wincap.cc: set wincap member has_user_shstk true for 2004+
>   fhandler/proc.cc: use wincap.has_user_shstk
> 
>  winsup/cygwin/fhandler/proc.cc        |  8 ++++----
>  winsup/cygwin/local_includes/wincap.h |  2 ++
>  winsup/cygwin/wincap.cc               | 10 ++++++++++
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> -- 
> 2.39.0

Is that actually the final version?  It's still missing the commit
message text explaining things and the "Fixes" line...


Thanks,
Corinna
