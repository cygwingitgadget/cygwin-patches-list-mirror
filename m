Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C169C4BA2E08; Wed, 11 Mar 2026 20:08:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C169C4BA2E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773259690;
	bh=xzknFUtMycsCYqi9lVU2z6fOoelUcdr20knLvaC1Qms=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hD6kMJfDmIIH4X0WZ/OXmCKoXfyQi3wS2SvW8KUYpnkNHN3oNEPnud0wo6hCLx3dc
	 r1gqxhx0AezELIB/blBhTnJl8SNr5hS96GYbOOXjjbw/WuSa/t/QESfhC1kHmIwmey
	 AePElAOIDqSMgMqe2X8oyXUovMDwOH69sNTnFTr8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id ABF87A80902; Wed, 11 Mar 2026 21:08:07 +0100 (CET)
Date: Wed, 11 Mar 2026 21:08:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: Adapt math functions to use 64bit long double on
 aarch64
Message-ID: <abHLpybECZPbwOn4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB3082742D4D0C170079EF9B7A9F74A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB3082742D4D0C170079EF9B7A9F74A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,


the long double math functions are taken from mingw-w64 and only
slightly changed to fit into Cygwin.

Ideally, all changes to make aarch64 work, too, are also taken
right from mingw-w64.

Are the below changes the only ones required to make long double
arithmetic work on aarch64?  Are they in line with the upstream
changes in mingw-w64?


Thanks,
Corinna


On Feb 24 08:38, Thirumalai Nagalingam wrote:
> Hi,
> 
> On Cygwin AArch64, long double has the same representation and precision
> as double (64-bit), unlike x86 extended precision.
> 
> This patch updates math functions to correctly handle this case by avoiding
> assumptions about extended precision in nextafterl and related functions.
> It also updates rintl to use the generic implementation on AArch64 and
> adjusts constants in cephes_mconf.h and lgammal.c accordingly.
> 
> Thanks & regards
> Thiru
> 
> In-lined patch:
> ---
>  winsup/cygwin/math/cephes_mconf.h | 4 ++--
>  winsup/cygwin/math/lgammal.c      | 4 ++--
>  winsup/cygwin/math/nextafterl.c   | 4 ++++
>  winsup/cygwin/math/rintl.c        | 2 +-
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/cygwin/math/cephes_mconf.h b/winsup/cygwin/math/cephes_mconf.h
> index 832fae0df..654de88bf 100644
> --- a/winsup/cygwin/math/cephes_mconf.h
> +++ b/winsup/cygwin/math/cephes_mconf.h
> @@ -66,7 +66,7 @@ extern double __QNAN;
>  #endif
> 
>  /*long double*/
> -#if defined(__arm__) || defined(_ARM_)
> +#if defined(__arm__) || defined(_ARM_) || defined(__aarch64__)
>  #define MAXNUML        1.7976931348623158E308
>  #define MAXLOGL        7.09782712893383996843E2
>  #define MINLOGL        -7.08396418532264106224E2
> @@ -84,7 +84,7 @@ extern double __QNAN;
>  #define PIL    3.1415926535897932384626L
>  #define PIO2L  1.5707963267948966192313L
>  #define PIO4L  7.8539816339744830961566E-1L
> -#endif /* defined(__arm__) || defined(_ARM_) */
> +#endif /* defined(__arm__) || defined(_ARM_)  || defined(__aarch64__) */
> 
>  #define isfinitel isfinite
>  #define isinfl isinf
> diff --git a/winsup/cygwin/math/lgammal.c b/winsup/cygwin/math/lgammal.c
> index 022a16acf..961eec280 100644
> --- a/winsup/cygwin/math/lgammal.c
> +++ b/winsup/cygwin/math/lgammal.c
> @@ -198,11 +198,11 @@ static uLD C[] = {
> 
>  /* log( sqrt( 2*pi ) ) */
>  static const long double LS2PI  =  0.91893853320467274178L;
> -#if defined(__arm__) || defined(_ARM_)
> +#if defined(__arm__) || defined(_ARM_) || defined(__aarch64__)
>  #define MAXLGM 2.035093e36
>  #else
>  #define MAXLGM 1.04848146839019521116e+4928L
> -#endif /* defined(__arm__) || defined(_ARM_) */
> +#endif /* defined(__arm__) || defined(_ARM_) || defined(__aarch64__) */
> 
>  /* Logarithm of gamma function */
>  /* Reentrant version */
> diff --git a/winsup/cygwin/math/nextafterl.c b/winsup/cygwin/math/nextafterl.c
> index b1e479a95..80c9c3c4d 100644
> --- a/winsup/cygwin/math/nextafterl.c
> +++ b/winsup/cygwin/math/nextafterl.c
> @@ -16,6 +16,9 @@
>  long double
>  nextafterl (long double x, long double y)
>  {
> +#if defined(__aarch64__) && (LDBL_MANT_DIG == DBL_MANT_DIG)
> +  return (long double) nexttoward (x, y);
> +# else
>    union {
>        long double ld;
>        struct {
> @@ -63,6 +66,7 @@ nextafterl (long double x, long double y)
>      u.parts.mantissa |=  normal_bit;
> 
>    return u.ld;
> +# endif /* defined(__aarch64__) */
>  }
> 
>  /* nexttowardl is the same function with a different name.  */
> diff --git a/winsup/cygwin/math/rintl.c b/winsup/cygwin/math/rintl.c
> index 9ec159d17..1e30de069 100644
> --- a/winsup/cygwin/math/rintl.c
> +++ b/winsup/cygwin/math/rintl.c
> @@ -9,7 +9,7 @@ long double rintl (long double x) {
>    long double retval = 0.0L;
>  #if defined(_AMD64_) || defined(__x86_64__) || defined(_X86_) || defined(__i386__)
>    __asm__ __volatile__ ("frndint;": "=t" (retval) : "0" (x));
> -#elif defined(__arm__) || defined(_ARM_)
> +#elif defined(__arm__) || defined(_ARM_)|| defined(__aarch64__)
>      retval = rint(x);
>  #endif
>    return retval;
> --
> 


