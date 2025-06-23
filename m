Return-Path: <SRS0=61RX=ZG=arm.com=Richard.Earnshaw@sourceware.org>
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by sourceware.org (Postfix) with ESMTP id 971063868F5A
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 15:36:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 971063868F5A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 971063868F5A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750692986; cv=none;
	b=RYWK/tCs1w1IGEBd0CKD7v7vXdr80rLDLhIdbkeh/4JtLPJlQbuJMZ5z9ju++G8iSYS67qnVU9Wo0c+fhxcNWgy7uilYXT4QZkMgOkHpL5/7uVgshBlz6HV8CtwSyI6T3j4VM7FbcZI9AHTOZPEClXV5+YchcF55KgqQ8SzEBDo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750692986; c=relaxed/simple;
	bh=sRTgP3PMpcKpnlzw088MGoengT3m0z4xu8VHs3i/ocE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=qG1/LoaPYn1nUJu0B1q40eNNc5oUJjBWFdiMxpR4AvRP0AXyR1PBtqarNshyPlwnlF6IGmIYcAZub2Nv4TsyfIfs33i7KqWXONI/8wLDZLsGomJx7HO8kXIDqKpfYtkWn5qeE7cdDdYXYbtNGNh1TiL/ETQsyAZNdAhp/Z/iU2k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 971063868F5A
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53D8C113E;
	Mon, 23 Jun 2025 08:36:08 -0700 (PDT)
Received: from [10.2.78.71] (e120077-lin.cambridge.arm.com [10.2.78.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB8F63F58B;
	Mon, 23 Jun 2025 08:36:25 -0700 (PDT)
Message-ID: <91bf97b2-383c-44a8-a2f3-9c38dfddcfb2@arm.com>
Date: Mon, 23 Jun 2025 16:36:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/QUESTION] newlib: fenv: AArch64 Cygwin linking fixes
To: Radek Barton <radek.barton@microsoft.com>, Newlib
 <newlib@sourceware.org>,
 "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <GV4PR83MB0941761524523870C31AC5BD9270A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
From: "Richard Earnshaw (lists)" <Richard.Earnshaw@arm.com>
Content-Language: en-GB
In-Reply-To: <GV4PR83MB0941761524523870C31AC5BD9270A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3495.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_NONE,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 16/06/2025 12:31, Radek Barton wrote:
> Hello.
> 
> This is more a question than patch submission: Without the attached changes, the Cygwin cannot be linked for AArch64 failing on:
> ```
> ld: cannot export _fe_nomask_env: symbol not defined
> ld: cannot export fedisableexcept: symbol not defined
> ld: cannot export fegetexcept: symbol not defined
> ld: cannot export fegetprec: symbol not defined
> ld: cannot export fesetprec: symbol not defined
> ```
> Can anybody share some insights why are those changes needed and whether there is a better way how to overcome this issue?
> 
> Note that the `feenableexcept`, `fedisableexcept`, `fegetexcept` implementations are similarly defined in `newlib/libc/machine/mips/machine/fenv-fp.h` for MIPS architecture as well.
> 
> Thank you,
> 
> Radek
> 

Ugh, this is a real rat's nest of code...

I may be on completely the wrong track, but I think the clue is in the comment:

 +/* We currently provide no external definitions of the functions below. */

So it is expected that these functions have no definition in a file, but will be inlined into the calling code when needed.  This is why they are provided in fenv.h.  fenv-fp.h seems to be the internal header that is used for code that will create the non-inlined versions; the header file fenv-fp.h isn't exported from the library though (it's only used while building it), so anything defined there will never be inlined into user code.

I suspect that the underlying issue is that coff libraries rely on explicitly exporting symbols, while ELF libraries do that implicitly (unless something is explicitly marked hidden).

What I don't fully understand is what role __BSD_VISIBLE might have here.  If that's not defined (which I'd think is possible in CYGWIN), then I can't see how your changes would resolve this.

I'm guessing (somewhat) that libm/.../fenv.c should perhaps define __BSD_VISIBLE before including fenv.h to force the inline functions to become visible. 

The other alternative might be to remove the list of functions scoped by the ifdef from libm/machine/aarch64/fenv.c so that the functions that file exports matches the comment I mentioned above.

Perhaps you could try this patch instead of yours and let me know if it resolves the issue:

diff --git a/newlib/libm/machine/aarch64/fenv.c b/newlib/libm/machine/aarch64/fenv.c
index 3ffe23441..fb6a67dcc 100644
--- a/newlib/libm/machine/aarch64/fenv.c
+++ b/newlib/libm/machine/aarch64/fenv.c
@@ -27,6 +27,9 @@
  * $FreeBSD$
  */
 
+/* Enable all fenv-related functions.  */
+#define __BSD_VISIBLE
+
 #define        __fenv_static
 #include <fenv.h>
 #include <machine/fenv-fp.h>



R.
> ---
> From 17fd8e16061ab199d111b303a44c042ea43c4018 Mon Sep 17 00:00:00 2001
> From: Radek Barton <radek.barton@microsoft.com>
> Date: Mon, 9 Jun 2025 08:55:18 +0200
> Subject: [PATCH/QUESTION] newlib: fenv: AArch64 Cygwin linking fixes
> 
> ---
>  newlib/libc/machine/aarch64/machine/fenv-fp.h | 64 +++++++++++++++++++
>  newlib/libc/machine/aarch64/sys/fenv.h        | 40 ------------
>  newlib/libm/machine/aarch64/fenv.c            |  7 ++
>  winsup/cygwin/fenv.c                          | 10 +++
>  4 files changed, 81 insertions(+), 40 deletions(-)
> 
> diff --git a/newlib/libc/machine/aarch64/machine/fenv-fp.h b/newlib/libc/machine/aarch64/machine/fenv-fp.h
> index d8ec3fc76..e42e2d873 100644
> --- a/newlib/libc/machine/aarch64/machine/fenv-fp.h
> +++ b/newlib/libc/machine/aarch64/machine/fenv-fp.h
> @@ -154,3 +154,67 @@ feupdateenv(const fenv_t *__envp)
>  	return (0);
>  }
>  
> +#if __BSD_VISIBLE
> +
> +/* We currently provide no external definitions of the functions below. */
> +
> +__fenv_static inline int
> +feenableexcept(int __mask)
> +{
> +	fenv_t __old_r, __new_r;
> +
> +	__mrs_fpcr(__old_r);
> +	__new_r = __old_r | ((__mask & FE_ALL_EXCEPT) << _FPUSW_SHIFT);
> +	__msr_fpcr(__new_r);
> +	return ((__old_r >> _FPUSW_SHIFT) & FE_ALL_EXCEPT);
> +}
> +
> +__fenv_static inline int
> +fedisableexcept(int __mask)
> +{
> +	fenv_t __old_r, __new_r;
> +
> +	__mrs_fpcr(__old_r);
> +	__new_r = __old_r & ~((__mask & FE_ALL_EXCEPT) << _FPUSW_SHIFT);
> +	__msr_fpcr(__new_r);
> +	return ((__old_r >> _FPUSW_SHIFT) & FE_ALL_EXCEPT);
> +}
> +
> +__fenv_static inline int
> +fegetexcept(void)
> +{
> +	fenv_t __r;
> +
> +	__mrs_fpcr(__r);
> +	return ((__r & _ENABLE_MASK) >> _FPUSW_SHIFT);
> +}
> +
> +#endif /* __BSD_VISIBLE */
> +
> +#if defined(__CYGWIN__)
> +
> +/*  Returns the currently selected precision, represented by one of the
> +   values of the defined precision macros.  */
> +__fenv_static inline int
> +fegetprec (void)
> +{
> +  return 0;
> +}
> +
> +/* http://www.open-std.org/jtc1/sc22//WG14/www/docs/n752.htm:
> +
> +   The fesetprec function establishes the precision represented by its
> +   argument prec.  If the argument does not match a precision macro, the
> +   precision is not changed.
> +
> +   The fesetprec function returns a nonzero value if and only if the
> +   argument matches a precision macro (that is, if and only if the requested
> +   precision can be established). */
> +__fenv_static inline int
> +fesetprec (int prec)
> +{
> +  /* Indicate success.  */
> +  return 1;
> +}
> +
> +#endif /* __CYGWIN__ */
> diff --git a/newlib/libc/machine/aarch64/sys/fenv.h b/newlib/libc/machine/aarch64/sys/fenv.h
> index 6b0879269..1cfbeaaf4 100644
> --- a/newlib/libc/machine/aarch64/sys/fenv.h
> +++ b/newlib/libc/machine/aarch64/sys/fenv.h
> @@ -77,44 +77,4 @@ extern const fenv_t	*_fe_dfl_env;
>  #define	__mrs_fpsr(__r)	__asm __volatile("mrs %0, fpsr" : "=r" (__r))
>  #define	__msr_fpsr(__r)	__asm __volatile("msr fpsr, %0" : : "r" (__r))
>  
> -
> -#if __BSD_VISIBLE
> -
> -/* We currently provide no external definitions of the functions below. */
> -
> -static inline int
> -feenableexcept(int __mask)
> -{
> -	fenv_t __old_r, __new_r;
> -
> -	__mrs_fpcr(__old_r);
> -	__new_r = __old_r | ((__mask & FE_ALL_EXCEPT) << _FPUSW_SHIFT);
> -	__msr_fpcr(__new_r);
> -	return ((__old_r >> _FPUSW_SHIFT) & FE_ALL_EXCEPT);
> -}
> -
> -static inline int
> -fedisableexcept(int __mask)
> -{
> -	fenv_t __old_r, __new_r;
> -
> -	__mrs_fpcr(__old_r);
> -	__new_r = __old_r & ~((__mask & FE_ALL_EXCEPT) << _FPUSW_SHIFT);
> -	__msr_fpcr(__new_r);
> -	return ((__old_r >> _FPUSW_SHIFT) & FE_ALL_EXCEPT);
> -}
> -
> -static inline int
> -fegetexcept(void)
> -{
> -	fenv_t __r;
> -
> -	__mrs_fpcr(__r);
> -	return ((__r & _ENABLE_MASK) >> _FPUSW_SHIFT);
> -}
> -
> -#endif /* __BSD_VISIBLE */
> -
> -
> -
>  #endif	/* !_FENV_H_ */
> diff --git a/newlib/libm/machine/aarch64/fenv.c b/newlib/libm/machine/aarch64/fenv.c
> index 3ffe23441..86f8cd5aa 100644
> --- a/newlib/libm/machine/aarch64/fenv.c
> +++ b/newlib/libm/machine/aarch64/fenv.c
> @@ -55,3 +55,10 @@ extern inline int feupdateenv(const fenv_t *__envp);
>  extern inline int feenableexcept(int __mask);
>  extern inline int fedisableexcept(int __mask);
>  extern inline int fegetexcept(void);
> +
> +#if defined(__CYGWIN__)
> +
> +extern inline int fegetprec(void);
> +extern inline int fesetprec(int prec);
> +
> +#endif /* CYGWIN */
> diff --git a/winsup/cygwin/fenv.c b/winsup/cygwin/fenv.c
> index 80f7cc52c..1558f76c2 100644
> --- a/winsup/cygwin/fenv.c
> +++ b/winsup/cygwin/fenv.c
> @@ -3,3 +3,13 @@
>     being called from mainCRTStartup in crt0.o. */
>  void _feinitialise (void)
>  {}
> +
> +#if defined(__aarch64__)
> +
> +#include <fenv.h>
> +#include <stddef.h>
> +
> +/* _fe_nomask_env is exported by cygwin.din but not used at all for AArch64. */
> +const fenv_t *_fe_nomask_env = NULL;
> +
> +#endif /* __aarch64__ */

