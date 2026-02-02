Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D47F64BA9035; Mon,  2 Feb 2026 23:18:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D47F64BA9035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770074306;
	bh=DTRrDBp3pvz6ekmZyKl5w6yEacX/YhZeX5D6VGTAS9I=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=LhpchYCNLUmBf5dyd5IJCglrNgy2Yj7yESOIv1fqU+ey2Ypjg81eZApNQGGmqreup
	 jbaPOfwlxbRdjIeoDkh7wIak5HSCyN3XLUVj4n1CR+NXvZoruxWtJkb0pZp+CnUP3O
	 q99OOR+Wf1SIogG4bRFLEnqVrbEUgk01lZUnWWKw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 015E5A80492; Tue, 03 Feb 2026 00:18:25 +0100 (CET)
Date: Tue, 3 Feb 2026 00:18:24 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: gencat: define __dead
Message-ID: <aYEwwJoeESCeG0uu@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260126120611.392483-1-corinna-cygwin@cygwin.com>
 <20260127201420.580616-1-corinna-cygwin@cygwin.com>
 <20260127201420.580616-2-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127201420.580616-2-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Jan 27 21:14, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> NetBSD defines __dead as __attribute__((__noreturn__)).  Add a matching
> macro expression.
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/utils/gencat.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/winsup/utils/gencat.c b/winsup/utils/gencat.c
> index b009b77c09b6..430d097cb341 100644
> --- a/winsup/utils/gencat.c
> +++ b/winsup/utils/gencat.c
> @@ -96,6 +96,10 @@ up-to-date.  Many thanks.
>  #define NL_MSGMAX 2048
>  #endif
>  
> +#ifndef __dead
> +#define __dead __attribute__((__noreturn__))
> +#endif
> +
>  struct _msgT {
>  	long    msgId;
>  	char   *str;
> -- 
> 2.52.0

Pushed.
