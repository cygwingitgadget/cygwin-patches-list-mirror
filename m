Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1E4B13858D2A; Mon, 24 Nov 2025 16:04:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1E4B13858D2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764000264;
	bh=JBsIAlP8F1XaIRxpB/SLFgOJJtW0k2BsuRcpEXxMBII=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kzVENlEUuq9uCnqwM+06Abia/wT0pWK9V8cjOqTf/mvCFqEmp4fPJNVyUYpEmb9tV
	 PghIy3h2j8Sd58k2F47vtciybgi9TnjedwQIXbMQ3OnijRiJ9SQDomThqulGC3D5td
	 g2dN1XAaIKxz1VOGUOHVAiWHZUONklYOZyQa6jyA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2E49CA8098A; Mon, 24 Nov 2025 17:04:22 +0100 (CET)
Date: Mon, 24 Nov 2025 17:04:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: flock: Do not access tmp_pathbuf already
 released
Message-ID: <aSSCBsYuTlJhYj9z@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251124135634.2264-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124135634.2264-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 24 22:56, Takashi Yano wrote:
> Previously, variable i_all_lf was allocated and released in several
> functions: lf_setlock(), lf_clearlock(), and lf_getlock(), and was
> used only temporarily as noted in flock.cc. This pattern easily leads
> to bugs like those that occurred in flock.cc, such as:
> 
>   lf_setlock()            lf_clearlock()
> 
>        |                       .
>    i_all_lf = tp.w_get()       .
>        |                       .
>        +---------------------->+
>                                |
>                            i_all_lf = tp.wget()
>                                |
>                            do something
>                                |
>                            (release i_all_lf implicitly)
>                                |
>        +<----------------------+
>        |
>    accessing i_all_lf (may destroy tmp_pathbuf area)
>        |
> 
> With this patch, to fix and prevent the bugs, move i_all_lf from
> each function that uses it to fhaldler_base::lock(). Moreover, move
> get_all_locks_list() call in lf_clearlock() to fhandler_base::lock()
> to avoid calling the function twice. Furthermore, make i_all_lf local
> variable rather than inode_t member to prevent reentrant(?) problem.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258914.html
> Fixes: e181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too many locks")

         ae181b0ff122


Corinna
