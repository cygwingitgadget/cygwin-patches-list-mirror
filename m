Return-Path: <SRS0=P0RP=ZA=redhat.com=vinschen@sourceware.org>
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by sourceware.org (Postfix) with ESMTP id 849B63889FB2
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 15:00:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 849B63889FB2
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=redhat.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 849B63889FB2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750172455; cv=none;
	b=FHJnHn+FEkOR3+TUMqihiDIgWVzcYArd+sIkJOnf/BH45+6abSpDvB2Tg2Dspf1oH+S/c2yECiXmdfslpmEq6oaDpHCiNY8g+4X6cLfZtV01YQ23VVCnAfqJyJwxl3cDsfCAglJ3OwSFTBZq/Ll6+iqIzUUXSvZnsr55FhCppDU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750172455; c=relaxed/simple;
	bh=C075WHfGUhuQ/1PVE2+uh25+OG7oqcJej5uWksxsPz0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=tjd9FqxkA2HFE51vigS7jLczGiPMWuH+uE5NrvzMaPwXBDCTOvatiMbh0WIKr8wjYzTsDptpcXAmpxImYZUVMwkW0BTuKCLfmF4Eo/PJBjSH+lEd/XK8ao1q0kWbLuILvq/VQP5f6yN2Q3TKTrwJVFQsm8r4HwFt05mDVmy7s84=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 849B63889FB2
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IgxBud3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750172455;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/oK7SMMksWBmMu3LTMJOA+Z1hvT6Rf7sL2DrjMz9VI=;
	b=IgxBud3Aa8M3PrlS6PvffNYfdQCCt3N5l11u7TvnSrS8AkPGMFxQaHrB8B3qZPFabK2W92
	s7c52+8ZrEuqQi/U2+rmoL7/UdLdGHNsvyXtQcS19cJmx615tbgMnGd9rsH6oKwlaRDB+v
	+z7j2ct5j4UR+AGMlizD/djYCmsYTVA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-Nox41-QSO2qHLTYMB3BZOw-1; Tue,
 17 Jun 2025 11:00:50 -0400
X-MC-Unique: Nox41-QSO2qHLTYMB3BZOw-1
X-Mimecast-MFC-AGG-ID: Nox41-QSO2qHLTYMB3BZOw_1750172449
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D670E19540FC;
	Tue, 17 Jun 2025 15:00:48 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.45.226.189])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25F9B19560A3;
	Tue, 17 Jun 2025 15:00:48 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8A9B3A80961; Tue, 17 Jun 2025 17:00:45 +0200 (CEST)
Date: Tue, 17 Jun 2025 17:00:45 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Radek Barton <radek.barton@microsoft.com>,
	Richard Earnshaw <rearnsha@arm.com>
Cc: Newlib <newlib@sourceware.org>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH/QUESTION] newlib: fenv: AArch64 Cygwin linking fixes
Message-ID: <aFGDHW9PxpZCJBt_@calimero.vinschen.de>
Reply-To: newlib@sourceware.org
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	Richard Earnshaw <rearnsha@arm.com>, Newlib <newlib@sourceware.org>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <GV4PR83MB0941761524523870C31AC5BD9270A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <GV4PR83MB0941761524523870C31AC5BD9270A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t6tqmq71qDFsNoMhILIrXl_Km3ZjWPMeXICWJBxKrAY_1750172449
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jun 16 11:31, Radek Barton wrote:
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

This would be a question for our ARM guys.  Richard?


Thanks,
Corinna


> 
> Thank you,
> 
> Radek
> 
> ---
> >From 17fd8e16061ab199d111b303a44c042ea43c4018 Mon Sep 17 00:00:00 2001
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
> -- 
> 2.49.0.vfs.0.3
> 


