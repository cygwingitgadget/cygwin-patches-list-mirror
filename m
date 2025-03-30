Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 71FED3858D33; Sun, 30 Mar 2025 21:30:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 71FED3858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743370216;
	bh=ch2Y67hHQp9jghQjInVSg+kKBi1RpDAn/pBHk+uZelk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=P2+K3uhSazkbp/P4O563SihOX4gWXWqDQw5uUrrGsn5m2tC06L+P5eTq7ftoKO6TX
	 /c/nUiBK4JJLZxIytwOpOYvS+csnrQXSP9mEhhbAnLahYsWm27mxGsn5Qe+ZeL7mFO
	 V6gqz5yJVIZX5BtzX2DpyFvpymkJ4/m4k6nOAV/s=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5C814A80C9C; Sun, 30 Mar 2025 23:30:14 +0200 (CEST)
Date: Sun, 30 Mar 2025 23:30:14 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: faq: add test of fork/exec slowdown by anti-virus
Message-ID: <Z-m35noIjFk-_cef@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <03c6bc1f-8426-1c9c-aa72-29c52d58c803@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03c6bc1f-8426-1c9c-aa72-29c52d58c803@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Mar 29 16:45, Christian Franke wrote:
> Occasionally useful to see one significant effect of anti-virus software.
> 
> BTW, the documentation still uses C:\cygwin as the default install
> directory. This is no longer the case since the retirement of the 32-bit
> version.
> 
> -- 
> Regards,
> Christian
> 

> From a9438be956dc81ac237ef70f9c07934ba4906dae Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Sat, 29 Mar 2025 16:34:33 +0100
> Subject: [PATCH] Cygwin: faq: add test of fork/exec slowdown by anti-virus
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/doc/faq-using.xml | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Nice, please push.

Thanks,
Corinna

