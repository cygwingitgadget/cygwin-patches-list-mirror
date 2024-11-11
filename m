Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 416363858D21; Mon, 11 Nov 2024 12:44:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 416363858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1731329091;
	bh=ZYqRn6zYjTiHtharE9S/Zv5u9xUK9tRCSlKjXOrPDOY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cNrEsCtG3z5r/sghaI95HXTFAirQp/Fsbx6VQSZp7P7NLXalsrKzOM+cYWrpa0yzD
	 ko5VBneYyycE6OsaE6U1CsIrVHU940A0dscIy557FvgNLSO5r5yo0R0Z7272lxYggv
	 Jqhf9RpDNSxT+zatBeoFidi3KpEql+Px91tzWLCk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 21C27A80E9C; Mon, 11 Nov 2024 13:44:49 +0100 (CET)
Date: Mon, 11 Nov 2024 13:44:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Shaobo Song <shnusongshaobo@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: pthread: Correct pthread_cleanup macros to
 avoid potential syntax errors
Message-ID: <ZzH8QYSz6c34ZZle@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Shaobo Song <shnusongshaobo@gmail.com>,
	cygwin-patches@cygwin.com
References: <20241110041504.16520-1-shnusongshaobo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241110041504.16520-1-shnusongshaobo@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Shaobo,

On Nov 10 12:15, Shaobo Song wrote:
> This commit revises `pthread_cleanup_push` and `pthread_cleanup_pop` macros to
> use a `do { ... } while(0)` wrapper, preventing syntax errors when used in
> certain contexts. The original code could fail when they are wrapped within a
> `do { ... } while(0)`, causing unintended behavior or compilation issues.
> Example of error:
> 
>   #include <pthread.h>
> 
>   #define pthread_cleanup_push_wrapper(_fn, _arg) do { \
>     pthread_cleanup_push(_fn, _arg); \
>   } while (0)
> 
>   #define pthread_cleanup_pop_wrapper(_execute) do { \
>     pthread_cleanup_pop(_execute); \
>   } while (0)
> 
>   void cleanup_fn (void *arg) {}
> 
>   void *thread_func (void *arg)
>   {
>     pthread_cleanup_push_wrapper(cleanup_fn, NULL);
>     pthread_cleanup_pop_wrapper(1);
>     return NULL;
>   }
> 
>   int main (int argc, char **argv) {
>     pthread_t thread_id;
>     pthread_create(&thread_id, NULL, thread_func, NULL);
>   }
> 
> This would fail due to unmatched braces in the macro expansion. The new
> structure ensures the macro expands correctly in all cases.
> 
> Signed-off-by: Shaobo Song <shnusongshaobo@gmail.com>

Thanks for the patch. Pushed with an extra "Fixes" line in the
commit message to main and cygwin-3_5-branch.


Corinna
