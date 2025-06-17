Return-Path: <SRS0=8XWn=ZA=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 4BDF838907AF
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 05:12:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4BDF838907AF
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4BDF838907AF
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750137124; cv=none;
	b=q74fW6o+7FXFWDLn9w48Vh2Ccwqlh3X8neHL6HslQ+E4+jEwtXJYA5v6EgsrnKFsaTR4putvQHse335rHbiQpn9XrXtnv3vRLWrqVkafjzsX3rTWHNm9sMTsSXxW6rLnPbx+jjvBmyFv79npQ/35j/H/Q1jSlsbuq0phElkB/64=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750137124; c=relaxed/simple;
	bh=+QmQct0u9X+g22BdBNaOzB25ihi9i3WVFDBppY8JnRo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Rqka6IOxNp/EqTmgzLxngj6Z2PJ6QF7bfX2GHaRl6TfTkXokQdgdOrXH0tkYV/MQB6C79eyBmwp2jG7cNeHYslvGcaVsMaq2b844/7dhVPlL0fNk55WyJWp0elFXjxWRlIHfODMOIwLncndzK37xYcYTSEShBdUqXuLZt5wQl08=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4BDF838907AF
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=hIi9FCuo
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D735E45D52
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 01:12:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Bm9PgutA/kt7XhFPzVjzWxA36Vw=; b=hIi9F
	CuonYTeJvTL+LnMgWc9w7iy+GEZcVXxrJZdBh4n8zM0UuVIorEvyBYa9J6p6O6tH
	bXDlyALkooQQUGKSkxSqtQTFeQGAXb+Ksxut6vTQEmf0iI7+YVjSMxnYbHSMlaMZ
	RqlbxdQioHWncB8C7Z0MrzBWWKkVDkzEXIBOzA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B886245D51
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 01:12:03 -0400 (EDT)
Date: Mon, 16 Jun 2025 22:12:03 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: make pthread initializer macros constinit
 compliant
In-Reply-To: <1277a22d-9beb-52b3-c9ea-7980f54fb84b@jdrake.com>
Message-ID: <9f2971ca-114a-cfec-646a-a32eabfc3ac3@jdrake.com>
References: <1277a22d-9beb-52b3-c9ea-7980f54fb84b@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 16 Jun 2025, Jeremy Drake via Cygwin-patches wrote:

> In order to avoid a restriction on any reinterpret_cast-like behavior in
> constinit expressions, use assembly and the linker to define symbols
> with the not-valid-address addresses.
>
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> This is gross, but I couldn't come up with a way to make this both source
> and ABI (including C++ name mangling) compatible.  I'd be happy to be
> shown a cleaner way.  I built libc++ without a patch to remove constinit,
> and I'm working on building gcc/libstdc++ to confirm it didn't break
> anything there.

gcc 13.4.0 rebuilt successfully too.  The thing to watch out for with this
is "relocation truncated to fit" link errors.  Oddly enough, I saw this
when using the absolute symbols from the C++ inside the Cygwin DLL build,
but have not seen it building either DLLs or EXEs using clang or gcc, even
when trying to recreate the scenario (comparing a pthread_mutex_t to
PTHREAD_MUTEX_INITIALIZER).

>
>  winsup/cygwin/Makefile.am        |  4 +++-
>  winsup/cygwin/include/pthread.h  | 27 ++++++++++++++++++++-------
>  winsup/cygwin/lib/pthreadconst.S | 17 +++++++++++++++++
>  3 files changed, 40 insertions(+), 8 deletions(-)
>  create mode 100644 winsup/cygwin/lib/pthreadconst.S
>
> diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
> index 6438a41487..31747ac98c 100644
> --- a/winsup/cygwin/Makefile.am
> +++ b/winsup/cygwin/Makefile.am
> @@ -78,7 +78,8 @@ LIB_FILES= \
>  	lib/premain1.c \
>  	lib/premain2.c \
>  	lib/premain3.c \
> -	lib/pseudo-reloc-dummy.c
> +	lib/pseudo-reloc-dummy.c \
> +	lib/pthreadconst.S
>
>  FHANDLER_FILES= \
>  	fhandler/base.cc \
> @@ -315,6 +316,7 @@ DLL_FILES= \
>  	ipc.cc \
>  	kernel32.cc \
>  	ldap.cc \
> +	lib/pthreadconst.S \
>  	libstdcxx_wrapper.cc \
>  	loadavg.cc \
>  	lsearch.cc \
> diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
> index 8e296303d7..6910a5a886 100644
> --- a/winsup/cygwin/include/pthread.h
> +++ b/winsup/cygwin/include/pthread.h
> @@ -31,8 +31,6 @@ extern "C"
>  #define PTHREAD_CANCEL_DEFERRED 0
>  #define PTHREAD_CANCEL_DISABLE 1
>  #define PTHREAD_CANCELED ((void *)-1)
> -/* this should be a value that can never be a valid address */
> -#define PTHREAD_COND_INITIALIZER (pthread_cond_t)21
>  #define PTHREAD_CREATE_DETACHED 1
>  /* the default : joinable */
>  #define PTHREAD_CREATE_JOINABLE 0
> @@ -42,10 +40,6 @@ extern "C"
>  #define PTHREAD_MUTEX_ERRORCHECK 1
>  #define PTHREAD_MUTEX_NORMAL 2
>  #define PTHREAD_MUTEX_DEFAULT PTHREAD_MUTEX_NORMAL
> -/* this should be too low to ever be a valid address */
> -#define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP (pthread_mutex_t)18
> -#define PTHREAD_NORMAL_MUTEX_INITIALIZER_NP (pthread_mutex_t)19
> -#define PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP (pthread_mutex_t)20
>  #define PTHREAD_MUTEX_INITIALIZER PTHREAD_NORMAL_MUTEX_INITIALIZER_NP
>  #define PTHREAD_ONCE_INIT { PTHREAD_MUTEX_INITIALIZER, 0 }
>  #if defined(_POSIX_THREAD_PRIO_INHERIT) && _POSIX_THREAD_PRIO_INHERIT >= 0
> @@ -55,12 +49,31 @@ extern "C"
>  #endif
>  #define PTHREAD_PROCESS_SHARED 1
>  #define PTHREAD_PROCESS_PRIVATE 0
> -#define PTHREAD_RWLOCK_INITIALIZER (pthread_rwlock_t)22
>  /* process is the default */
>  #define PTHREAD_SCOPE_PROCESS 0
>  #define PTHREAD_SCOPE_SYSTEM 1
>  #define PTHREAD_BARRIER_SERIAL_THREAD (-1)
>
> +#if !defined(__INSIDE_CYGWIN__) || !defined(__cplusplus)
> +/* Constants for initializer macros */
> +extern struct __pthread_mutex_t __pthread_recursive_mutex_initializer_np;
> +extern struct __pthread_mutex_t __pthread_normal_mutex_initializer_np;
> +extern struct __pthread_mutex_t __pthread_errorcheck_mutex_initializer_np;
> +extern struct __pthread_cond_t __pthread_cond_initializer;
> +extern struct __pthread_rwlock_t __pthread_rwlock_initializer;
> +#define PTHREAD_COND_INITIALIZER (&__pthread_cond_initializer)
> +#define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP (&__pthread_recursive_mutex_initializer_np)
> +#define PTHREAD_NORMAL_MUTEX_INITIALIZER_NP (&__pthread_normal_mutex_initializer_np)
> +#define PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP (&__pthread_errorcheck_mutex_initializer_np)
> +#define PTHREAD_RWLOCK_INITIALIZER (&__pthread_rwlock_initializer)
> +#else
> +#define PTHREAD_COND_INITIALIZER (pthread_cond_t)21
> +#define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP (pthread_mutex_t)18
> +#define PTHREAD_NORMAL_MUTEX_INITIALIZER_NP (pthread_mutex_t)19
> +#define PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP (pthread_mutex_t)20
> +#define PTHREAD_RWLOCK_INITIALIZER (pthread_rwlock_t)22
> +#endif
> +
>  /* Register Fork Handlers */
>  int pthread_atfork (void (*)(void), void (*)(void), void (*)(void));
>
> diff --git a/winsup/cygwin/lib/pthreadconst.S b/winsup/cygwin/lib/pthreadconst.S
> new file mode 100644
> index 0000000000..6e55a832a4
> --- /dev/null
> +++ b/winsup/cygwin/lib/pthreadconst.S
> @@ -0,0 +1,17 @@
> +#if defined(__i386__)
> +#  define SYM(x) _##x
> +#else
> +#  define SYM(x) x
> +#endif
> +
> +/* these should all be too low to ever be valid addresses */
> +.globl SYM(__pthread_recursive_mutex_initializer_np)
> +.set __pthread_recursive_mutex_initializer_np, 18
> +.globl SYM(__pthread_normal_mutex_initializer_np)
> +.set __pthread_normal_mutex_initializer_np, 19
> +.globl SYM(__pthread_errorcheck_mutex_initializer_np)
> +.set __pthread_errorcheck_mutex_initializer_np, 20
> +.globl SYM(__pthread_cond_initializer)
> +.set __pthread_cond_initializer, 21
> +.globl SYM(__pthread_rwlock_initializer)
> +.set __pthread_rwlock_initializer, 22
>

