Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9C7094BA2E31; Mon, 26 Jan 2026 20:46:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9C7094BA2E31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769460388;
	bh=laDml4xYOCZXVZpSDU7uA5xi8rBtgSxgBHoRSYCvO6k=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=hwWxRy8c5hL/sPYn/7a7s6XgmxT9098wp3+3Bx9bpgXbCbUfIQXbDgutLdHHXdbB3
	 qLkQ4alJhg2wNkZkAFtuXqv6d3TvOh6pS74dLQc8Ua80TEqZ2XeS9aYVfLjNhfD1Oz
	 Q7FUC/lHBLOI02zz0FCWqh9gJdMTNxKXceRXz008=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A63DCA81CF5; Mon, 26 Jan 2026 21:46:26 +0100 (CET)
Date: Mon, 26 Jan 2026 21:46:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: gencat: fix handling of \<oct> expressions
Message-ID: <aXfSos1tGR_sY7u9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260126120611.392483-1-corinna-cygwin@cygwin.com>
 <20260126120611.392483-2-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126120611.392483-2-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Jan 26 13:06, Corinna Vinschen wrote:
> The code handling \<oct> expressions (backslash with 3 octal digits)
> neglects to increment the pointer to the target string afterwards,
> thus the next character simply overwrites the character created from
> the \<oct> expression.
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/utils/gencat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/utils/gencat.c b/winsup/utils/gencat.c
> index f86b17b4a922..5b9e149739db 100644
> --- a/winsup/utils/gencat.c
> +++ b/winsup/utils/gencat.c
> @@ -448,6 +448,7 @@ getmsg(int fd, char *cptr, char quote)
>  							*tptr += (*cptr - '0');
>  							++cptr;
>  						}
> +						++tptr;
>  					} else {
>  						warning(cptr, "unrecognized escape sequence");
>  					}
> -- 
> 2.52.0

In the meantime, this patch has gone upstream:
https://gnats.netbsd.org/59946
https://cvsweb.netbsd.org/bsdweb.cgi/src/usr.bin/gencat/gencat.c.diff?r1=1.36;r2=1.37

I also built the tcsh message catalog files successfully with this
version of gencat, which was especially interesting due the problem
fixed by this patch: the string "\040hard" resulted in "hard" instead of
in " hard" with leading space in the catalog file.

This bug affects our current version of gencat as well, btw., so I'd
like to push these patches to the 3.6 branch, too, just like the patch
from "Cygwin: fhandler_socket::fchown: fix check for admin user"
https://sourceware.org/pipermail/cygwin-patches/2026q1/014589.html.

Please review.


Thanks,
Corinna
