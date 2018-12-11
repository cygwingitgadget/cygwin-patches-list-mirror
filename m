Return-Path: <cygwin-patches-return-9189-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86976 invoked by alias); 11 Dec 2018 22:08:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86352 invoked by uid 89); 11 Dec 2018 22:08:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS,TIME_LIMIT_EXCEEDED autolearn=unavailable version=3.3.2 spammy=H*Ad:U*cygwin-patches, variety, trademark, 976
X-HELO: mail-wm1-f66.google.com
Received: from mail-wm1-f66.google.com (HELO mail-wm1-f66.google.com) (209.85.128.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 11 Dec 2018 22:08:12 +0000
Received: by mail-wm1-f66.google.com with SMTP id y185so10002662wmd.1        for <cygwin-patches@cygwin.com>; Tue, 11 Dec 2018 14:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=mittosystems.com; s=google;        h=date:from:to:cc:subject:message-id:mime-version;        bh=ejErkTBImWfNmrHfopi53VRRB4giXCcMO+b6X5GTbMA=;        b=Mo6+wgoFuuuTXVRJ/r5oqAqJlqPZ8y6+UeEUw+2VC5RpAMlAXiQspYsYpobGZWkMY+         u7gK+YoToBaJwq1UIFf/8M/CbuH2wWDO9ju+viuXAYtGrHirdHYp6HOG4ahm10R75pSt         vbmQU+qKl6lb78hT6WgZLBmmRhMu1dRwzbMIPoLUKT6fPftYwIXWmCuTq7HEQEwZDQFW         P3+sQ7jgXnGdcgt8IGgESFV5YIvgG9DMjwlUO2ypKxSifgaDYvc9f3RqDSTwqC14Pfs1         ctgoKxgrLYCANUjcudntTekwAOR2tlvNe9Sdquduvqf+7+N+AGUyQ4CPoRpH6yW5m88O         g5gA==
Return-Path: <jozef.l@mittosystems.com>
Received: from jozef-Aspire-VN7-793G ([88.98.204.243])        by smtp.gmail.com with ESMTPSA id h127sm1635038wmd.31.2018.12.11.14.08.09        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Tue, 11 Dec 2018 14:08:09 -0800 (PST)
Date: Tue, 11 Dec 2018 22:08:00 -0000
From: Jozef Lawrynowicz <jozef.l@mittosystems.com>
To: newlib@sourceware.org
Cc: cygwin-patches@cygwin.com
Subject: [PATCH] Remove matherr, and SVID and X/Open math library configurations
Message-ID: <20181211220807.72718758@jozef-Aspire-VN7-793G>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/tRU0BSmUl6FO2szvAH/5/=l"
X-IsSubscribed: yes
X-SW-Source: 2018-q4/txt/msg00005.txt.bz2


--MP_/tRU0BSmUl6FO2szvAH/5/=l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 2344

The attached patch removes support for the "matherr" error handling function
from the floating-point arithmetic routines in libm.

matherr is a relic of SVID and has been obsolete in glibc for a while (at least
a few years as far as I can tell), and was removed completely earlier this
year.

With the removal of matherr, "struct exception" (defined in
libc/include/math.h) can also be removed, along with the enums for exception
types (DOMAIN, SING, OVERFLOW etc.). Furthermore, the SVID and X/Open math
library configurations are now redundant, so these have also been removed.
IEEE and POSIX are now the two choices for the math library configuration, with
IEEE being the default.
I've updated the documentation in libm.texinfo and math.tex accordingly.

In addition to simplified wrapper functions for floating-point arithmetic in
libm, the changes also significantly reduce code size for the single-precision
float versions of the arithmetic functions. Members of "struct exception" were
defined as doubles, so casting from the float values in the artihmetic
function to the double values in "struct exception" required double conversion
routines to be linked in.

For example, in a simple C program calling
  powf (float_var, 2.42f)
the following size reductions were observed:

msp430-elf text size
before: 11448
after: 9256

arm cortex-m4 text size
before: 13188
after: 11348

(flags used were -Os -Wl,-gc-sections)

A further trivial change I made in some of the math functions was to replace
instances of floating-point constants being cast to float, with the float
version of the constant e.g.
-       if (float_var <= (float)0.0)
+       if (float_var <= 0.0f)
Also fixed double divides in float arithmetic functions e.g.
-       return 0.0/0.0;
+       return 0.0f/0.0f;

There are further cases of double constants being used in float functions (e.g.
HUGE_VAL instead of HUGE_VALF) which I'll try and fix soon.

Successfully regtested the GCC, G++, libstdc++-v3 and Newlib testsuites for
arm-unknown-eabi and msp430-elf.
Successfully regtested the Newlib testsuite for Cygwin also.

If this patch is acceptable I would appreciate if someone would apply it for
me, as I do not have write access. I guess the body of this email would suffice
for the commit message, but let me know if a more concise one is required.

Thanks,
Jozef

--MP_/tRU0BSmUl6FO2szvAH/5/=l
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-Newlib-Remove-matherr-and-SVID-and-X-Open-math-libra.patch
Content-length: 137878

From 4a97ca305f4ba59f25a878ebc70d5592d2180d23 Mon Sep 17 00:00:00 2001
From: Jozef Lawrynowicz <jozef.l@mittosystems.com>
Date: Thu, 6 Dec 2018 16:14:01 +0000
Subject: [PATCH] [Newlib] Remove matherr, and SVID and X/Open math library
 configurations

Default math library configuration is now IEEE
---
 newlib/libc/include/math.h            |  39 ---
 newlib/libc/machine/necv70/necv70.tex |   2 +-
 newlib/libc/saber                     |   1 -
 newlib/libm/common/Makefile.am        |   4 +-
 newlib/libm/common/Makefile.in        |  43 +--
 newlib/libm/common/fdlibm.h           |   3 -
 newlib/libm/common/hypotl.c           |  30 +-
 newlib/libm/common/s_exp10.c          |   3 -
 newlib/libm/common/s_lib_ver.c        |   4 +-
 newlib/libm/common/s_log2.c           |   7 +-
 newlib/libm/common/s_matherr.c        | 118 -------
 newlib/libm/common/s_pow10.c          |   3 -
 newlib/libm/complex/Makefile.in       |   1 -
 newlib/libm/libm.texinfo              |  18 +-
 newlib/libm/math/k_standard.c         | 609 +++++-----------------------------
 newlib/libm/math/math.tex             |  58 +---
 newlib/libm/math/w_acos.c             |  28 +-
 newlib/libm/math/w_acosh.c            |  25 +-
 newlib/libm/math/w_asin.c             |  30 +-
 newlib/libm/math/w_atan2.c            |   2 -
 newlib/libm/math/w_atanh.c            |  37 +--
 newlib/libm/math/w_cosh.c             |  22 +-
 newlib/libm/math/w_exp.c              |  37 +--
 newlib/libm/math/w_exp2.c             |   3 -
 newlib/libm/math/w_fmod.c             |  24 +-
 newlib/libm/math/w_gamma.c            |  36 +-
 newlib/libm/math/w_hypot.c            |  22 +-
 newlib/libm/math/w_j0.c               |  50 +--
 newlib/libm/math/w_j1.c               |  50 +--
 newlib/libm/math/w_jn.c               |  53 +--
 newlib/libm/math/w_lgamma.c           |  39 +--
 newlib/libm/math/w_log.c              |  35 +-
 newlib/libm/math/w_log10.c            |  35 +-
 newlib/libm/math/w_pow.c              | 120 +------
 newlib/libm/math/w_remainder.c        |  17 +-
 newlib/libm/math/w_scalb.c            |  35 +-
 newlib/libm/math/w_sinh.c             |  21 +-
 newlib/libm/math/w_sqrt.c             |  21 +-
 newlib/libm/math/wf_acos.c            |  18 +-
 newlib/libm/math/wf_acosh.c           |  20 +-
 newlib/libm/math/wf_asin.c            |  18 +-
 newlib/libm/math/wf_atanh.c           |  38 +--
 newlib/libm/math/wf_cosh.c            |  21 +-
 newlib/libm/math/wf_exp.c             |  34 +-
 newlib/libm/math/wf_fmod.c            |  22 +-
 newlib/libm/math/wf_gamma.c           |  35 +-
 newlib/libm/math/wf_hypot.c           |  20 +-
 newlib/libm/math/wf_j0.c              |  50 +--
 newlib/libm/math/wf_j1.c              |  52 +--
 newlib/libm/math/wf_jn.c              |  55 +--
 newlib/libm/math/wf_lgamma.c          |  33 +-
 newlib/libm/math/wf_log.c             |  32 +-
 newlib/libm/math/wf_log10.c           |  36 +-
 newlib/libm/math/wf_pow.c             | 136 ++------
 newlib/libm/math/wf_remainder.c       |  21 +-
 newlib/libm/math/wf_scalb.c           |  37 +--
 newlib/libm/math/wf_sinh.c            |  19 +-
 newlib/libm/math/wf_sqrt.c            |  23 +-
 newlib/libm/math/wr_gamma.c           |  35 +-
 newlib/libm/math/wr_lgamma.c          |  36 +-
 newlib/libm/math/wrf_gamma.c          |  32 +-
 newlib/libm/math/wrf_lgamma.c         |  33 +-
 newlib/libm/mathfp/e_acosh.c          |   9 +-
 newlib/libm/mathfp/e_atanh.c          |   3 -
 newlib/libm/mathfp/e_hypot.c          |   2 -
 newlib/libm/mathfp/er_lgamma.c        |   2 -
 newlib/libm/mathfp/s_acos.c           |   9 +-
 newlib/libm/mathfp/s_atan2.c          |   2 -
 newlib/libm/mathfp/s_cosh.c           |   3 -
 newlib/libm/mathfp/s_fmod.c           |   2 -
 newlib/libm/mathfp/s_logarithm.c      |   3 +-
 newlib/libm/mathfp/s_pow.c            |   2 -
 newlib/libm/mathfp/w_jn.c             |  53 +--
 newlib/libm/mathfp/wf_jn.c            |  55 +--
 newlib/libm/test/math.c               |  17 +-
 winsup/cygwin/common.din              |   1 -
 winsup/cygwin/i686.din                |   1 -
 winsup/cygwin/math/acosh.def.h        |   4 +-
 winsup/cygwin/math/complex_internal.h |  31 --
 winsup/cygwin/math/cos.def.h          |   4 +-
 winsup/cygwin/math/exp.def.h          |   6 +-
 winsup/cygwin/math/expm1.def.h        |   2 +-
 winsup/cygwin/math/log.def.h          |   4 +-
 winsup/cygwin/math/pow.def.h          |   8 +-
 winsup/cygwin/math/powi.def.h         |   2 +-
 winsup/cygwin/math/sin.def.h          |   4 +-
 winsup/cygwin/math/sqrt.def.h         |   2 +-
 87 files changed, 423 insertions(+), 2349 deletions(-)
 delete mode 100644 newlib/libm/common/s_matherr.c

diff --git a/newlib/libc/include/math.h b/newlib/libc/include/math.h
index 893a5d0..1efc5b9 100644
--- a/newlib/libc/include/math.h
+++ b/newlib/libc/include/math.h
@@ -568,41 +568,6 @@ extern int *__signgam (void);
 #define __signgam_r(ptr) _REENT_SIGNGAM(ptr)
 #endif /* __MISC_VISIBLE || __XSI_VISIBLE */
 
-#if __SVID_VISIBLE
-/* The exception structure passed to the matherr routine.  */
-/* We have a problem when using C++ since `exception' is a reserved
-   name in C++.  */
-#ifdef __cplusplus
-struct __exception
-#else
-struct exception
-#endif
-{
-  int type;
-  char *name;
-  double arg1;
-  double arg2;
-  double retval;
-  int err;
-};
-
-#ifdef __cplusplus
-extern int matherr (struct __exception *e);
-#else
-extern int matherr (struct exception *e);
-#endif
-
-/* Values for the type field of struct exception.  */
-
-#define DOMAIN 1
-#define SING 2
-#define OVERFLOW 3
-#define UNDERFLOW 4
-#define TLOSS 5
-#define PLOSS 6
-
-#endif /* __SVID_VISIBLE */
-
 /* Useful constants.  */
 
 #if __BSD_VISIBLE || __XSI_VISIBLE
@@ -642,8 +607,6 @@ extern int matherr (struct exception *e);
 enum __fdlibm_version
 {
   __fdlibm_ieee = -1,
-  __fdlibm_svid,
-  __fdlibm_xopen,
   __fdlibm_posix
 };
 
@@ -653,8 +616,6 @@ enum __fdlibm_version
 extern __IMPORT _LIB_VERSION_TYPE _LIB_VERSION;
 
 #define _IEEE_  __fdlibm_ieee
-#define _SVID_  __fdlibm_svid
-#define _XOPEN_ __fdlibm_xopen
 #define _POSIX_ __fdlibm_posix
 
 #endif /* __BSD_VISIBLE */
diff --git a/newlib/libc/machine/necv70/necv70.tex b/newlib/libc/machine/necv70/necv70.tex
index 9c15304..c7858c2 100644
--- a/newlib/libc/machine/necv70/necv70.tex
+++ b/newlib/libc/machine/necv70/necv70.tex
@@ -35,7 +35,7 @@ double x;
 
 The library has an entry @code{fast_sin} which uses the machine
 instruction @code{fsin.l} to perform the operation.  Note that the
-built-in instructions cannot call @code{matherr} or set @code{errno}
+built-in instructions cannot set @code{errno}
 in the same way that the C coded functions do.  Refer to a V70
 instruction manual to see how errors are generated and handled.
 
diff --git a/newlib/libc/saber b/newlib/libc/saber
index 4f16f97..154eddf 100644
--- a/newlib/libc/saber
+++ b/newlib/libc/saber
@@ -173,7 +173,6 @@ load math/log10.c
 load math/log1p.c
 load math/log2.c
 load math/log__L.c
-load math/matherr.c
 load math/modf.c
 load math/pow.c
 load math/scalb.c
diff --git a/newlib/libm/common/Makefile.am b/newlib/libm/common/Makefile.am
index b085671..1eef023 100644
--- a/newlib/libm/common/Makefile.am
+++ b/newlib/libm/common/Makefile.am
@@ -8,7 +8,7 @@ src = 	s_finite.c s_copysign.c s_modf.c s_scalbn.c \
 	s_cbrt.c s_exp10.c s_expm1.c s_ilogb.c \
 	s_infinity.c s_isinf.c s_isinfd.c s_isnan.c s_isnand.c \
 	s_log1p.c s_nan.c s_nextafter.c s_pow10.c \
-	s_rint.c s_logb.c s_log2.c s_matherr.c s_lib_ver.c \
+	s_rint.c s_logb.c s_log2.c s_lib_ver.c \
 	s_fdim.c s_fma.c s_fmax.c s_fmin.c s_fpclassify.c \
 	s_lrint.c s_llrint.c \
 	s_lround.c s_llround.c s_nearbyint.c s_remquo.c s_round.c s_scalbln.c \
@@ -62,7 +62,7 @@ endif # USE_LIBTOOL
 include $(srcdir)/../../Makefile.shared
 
 CHEWOUT_FILES =	s_cbrt.def s_copysign.def s_exp10.def s_expm1.def s_ilogb.def \
-	s_infinity.def s_isnan.def s_log1p.def s_matherr.def s_modf.def \
+	s_infinity.def s_isnan.def s_log1p.def s_modf.def \
 	s_nan.def s_nextafter.def s_pow10.def s_scalbn.def \
 	s_fdim.def s_fma.def s_fmax.def s_fmin.def \
 	s_logb.def s_log2.def s_lrint.def s_lround.def s_nearbyint.def \
diff --git a/newlib/libm/common/Makefile.in b/newlib/libm/common/Makefile.in
index a777a34..2caf7dd 100644
--- a/newlib/libm/common/Makefile.in
+++ b/newlib/libm/common/Makefile.in
@@ -85,20 +85,19 @@ am__objects_1 = lib_a-s_finite.$(OBJEXT) lib_a-s_copysign.$(OBJEXT) \
 	lib_a-s_nan.$(OBJEXT) lib_a-s_nextafter.$(OBJEXT) \
 	lib_a-s_pow10.$(OBJEXT) lib_a-s_rint.$(OBJEXT) \
 	lib_a-s_logb.$(OBJEXT) lib_a-s_log2.$(OBJEXT) \
-	lib_a-s_matherr.$(OBJEXT) lib_a-s_lib_ver.$(OBJEXT) \
-	lib_a-s_fdim.$(OBJEXT) lib_a-s_fma.$(OBJEXT) \
-	lib_a-s_fmax.$(OBJEXT) lib_a-s_fmin.$(OBJEXT) \
-	lib_a-s_fpclassify.$(OBJEXT) lib_a-s_lrint.$(OBJEXT) \
-	lib_a-s_llrint.$(OBJEXT) lib_a-s_lround.$(OBJEXT) \
-	lib_a-s_llround.$(OBJEXT) lib_a-s_nearbyint.$(OBJEXT) \
-	lib_a-s_remquo.$(OBJEXT) lib_a-s_round.$(OBJEXT) \
-	lib_a-s_scalbln.$(OBJEXT) lib_a-s_signbit.$(OBJEXT) \
-	lib_a-s_trunc.$(OBJEXT) lib_a-exp.$(OBJEXT) \
-	lib_a-exp2.$(OBJEXT) lib_a-exp_data.$(OBJEXT) \
-	lib_a-math_err.$(OBJEXT) lib_a-log.$(OBJEXT) \
-	lib_a-log_data.$(OBJEXT) lib_a-log2.$(OBJEXT) \
-	lib_a-log2_data.$(OBJEXT) lib_a-pow.$(OBJEXT) \
-	lib_a-pow_log_data.$(OBJEXT)
+	lib_a-s_lib_ver.$(OBJEXT) lib_a-s_fdim.$(OBJEXT) \
+	lib_a-s_fma.$(OBJEXT) lib_a-s_fmax.$(OBJEXT) \
+	lib_a-s_fmin.$(OBJEXT) lib_a-s_fpclassify.$(OBJEXT) \
+	lib_a-s_lrint.$(OBJEXT) lib_a-s_llrint.$(OBJEXT) \
+	lib_a-s_lround.$(OBJEXT) lib_a-s_llround.$(OBJEXT) \
+	lib_a-s_nearbyint.$(OBJEXT) lib_a-s_remquo.$(OBJEXT) \
+	lib_a-s_round.$(OBJEXT) lib_a-s_scalbln.$(OBJEXT) \
+	lib_a-s_signbit.$(OBJEXT) lib_a-s_trunc.$(OBJEXT) \
+	lib_a-exp.$(OBJEXT) lib_a-exp2.$(OBJEXT) \
+	lib_a-exp_data.$(OBJEXT) lib_a-math_err.$(OBJEXT) \
+	lib_a-log.$(OBJEXT) lib_a-log_data.$(OBJEXT) \
+	lib_a-log2.$(OBJEXT) lib_a-log2_data.$(OBJEXT) \
+	lib_a-pow.$(OBJEXT) lib_a-pow_log_data.$(OBJEXT)
 am__objects_2 = lib_a-sf_finite.$(OBJEXT) lib_a-sf_copysign.$(OBJEXT) \
 	lib_a-sf_modf.$(OBJEXT) lib_a-sf_scalbn.$(OBJEXT) \
 	lib_a-sf_cbrt.$(OBJEXT) lib_a-sf_exp10.$(OBJEXT) \
@@ -164,9 +163,9 @@ am__objects_5 = s_finite.lo s_copysign.lo s_modf.lo s_scalbn.lo \
 	s_cbrt.lo s_exp10.lo s_expm1.lo s_ilogb.lo s_infinity.lo \
 	s_isinf.lo s_isinfd.lo s_isnan.lo s_isnand.lo s_log1p.lo \
 	s_nan.lo s_nextafter.lo s_pow10.lo s_rint.lo s_logb.lo \
-	s_log2.lo s_matherr.lo s_lib_ver.lo s_fdim.lo s_fma.lo \
-	s_fmax.lo s_fmin.lo s_fpclassify.lo s_lrint.lo s_llrint.lo \
-	s_lround.lo s_llround.lo s_nearbyint.lo s_remquo.lo s_round.lo \
+	s_log2.lo s_lib_ver.lo s_fdim.lo s_fma.lo s_fmax.lo s_fmin.lo \
+	s_fpclassify.lo s_lrint.lo s_llrint.lo s_lround.lo \
+	s_llround.lo s_nearbyint.lo s_remquo.lo s_round.lo \
 	s_scalbln.lo s_signbit.lo s_trunc.lo exp.lo exp2.lo \
 	exp_data.lo math_err.lo log.lo log_data.lo log2.lo \
 	log2_data.lo pow.lo pow_log_data.lo
@@ -355,7 +354,7 @@ src = s_finite.c s_copysign.c s_modf.c s_scalbn.c \
 	s_cbrt.c s_exp10.c s_expm1.c s_ilogb.c \
 	s_infinity.c s_isinf.c s_isinfd.c s_isnan.c s_isnand.c \
 	s_log1p.c s_nan.c s_nextafter.c s_pow10.c \
-	s_rint.c s_logb.c s_log2.c s_matherr.c s_lib_ver.c \
+	s_rint.c s_logb.c s_log2.c s_lib_ver.c \
 	s_fdim.c s_fma.c s_fmax.c s_fmin.c s_fpclassify.c \
 	s_lrint.c s_llrint.c \
 	s_lround.c s_llround.c s_nearbyint.c s_remquo.c s_round.c s_scalbln.c \
@@ -406,7 +405,7 @@ DOCBOOK_OUT_FILES = $(CHEWOUT_FILES:.def=.xml)
 DOCBOOK_CHAPTERS = $(CHAPTERS:.tex=.xml)
 CLEANFILES = $(CHEWOUT_FILES) $(DOCBOOK_OUT_FILES)
 CHEWOUT_FILES = s_cbrt.def s_copysign.def s_exp10.def s_expm1.def s_ilogb.def \
-	s_infinity.def s_isnan.def s_log1p.def s_matherr.def s_modf.def \
+	s_infinity.def s_isnan.def s_log1p.def s_modf.def \
 	s_nan.def s_nextafter.def s_pow10.def s_scalbn.def \
 	s_fdim.def s_fma.def s_fmax.def s_fmin.def \
 	s_logb.def s_log2.def s_lrint.def s_lround.def s_nearbyint.def \
@@ -603,12 +602,6 @@ lib_a-s_log2.o: s_log2.c
 lib_a-s_log2.obj: s_log2.c
 	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(lib_a_CFLAGS) $(CFLAGS) -c -o lib_a-s_log2.obj `if test -f 's_log2.c'; then $(CYGPATH_W) 's_log2.c'; else $(CYGPATH_W) '$(srcdir)/s_log2.c'; fi`
 
-lib_a-s_matherr.o: s_matherr.c
-	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(lib_a_CFLAGS) $(CFLAGS) -c -o lib_a-s_matherr.o `test -f 's_matherr.c' || echo '$(srcdir)/'`s_matherr.c
-
-lib_a-s_matherr.obj: s_matherr.c
-	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(lib_a_CFLAGS) $(CFLAGS) -c -o lib_a-s_matherr.obj `if test -f 's_matherr.c'; then $(CYGPATH_W) 's_matherr.c'; else $(CYGPATH_W) '$(srcdir)/s_matherr.c'; fi`
-
 lib_a-s_lib_ver.o: s_lib_ver.c
 	$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(lib_a_CFLAGS) $(CFLAGS) -c -o lib_a-s_lib_ver.o `test -f 's_lib_ver.c' || echo '$(srcdir)/'`s_lib_ver.c
 
diff --git a/newlib/libm/common/fdlibm.h b/newlib/libm/common/fdlibm.h
index 2155f51..8dfff24 100644
--- a/newlib/libm/common/fdlibm.h
+++ b/newlib/libm/common/fdlibm.h
@@ -16,9 +16,6 @@
 #include <sys/types.h>
 #include <machine/ieeefp.h>
 
-/* REDHAT LOCAL: Default to XOPEN_MODE.  */
-#define _XOPEN_MODE
-
 /* Most routines need to check whether a float is finite, infinite, or not a
    number, and many need to know whether the result of an operation will
    overflow.  These conditions depend on whether the largest exponent is
diff --git a/newlib/libm/common/hypotl.c b/newlib/libm/common/hypotl.c
index cf67ccf..a0dcdc3 100644
--- a/newlib/libm/common/hypotl.c
+++ b/newlib/libm/common/hypotl.c
@@ -52,36 +52,14 @@ hypotl (long double x, long double y)
   if ((! finitel (z)) && finitel (x) && finitel (y))
     {
       /* hypot (finite, finite) overflow.  */
-      struct exception exc;
-
-      exc.type = OVERFLOW;
-      exc.name = "hypotl";
-      exc.err = 0;
-      exc.arg1 = x;
-      exc.arg2 = y;
-
-      if (_LIB_VERSION == _SVID_)
-	exc.retval = HUGE;
-      else
-	{
 #ifndef HUGE_VAL 
 #define HUGE_VAL inf
-	  double inf = 0.0;
+      double inf = 0.0;
 
-	  SET_HIGH_WORD (inf, 0x7ff00000);	/* Set inf to infinite.  */
+      SET_HIGH_WORD (inf, 0x7ff00000);	/* Set inf to infinite.  */
 #endif
-	  exc.retval = HUGE_VAL;
-	}
-
-      if (_LIB_VERSION == _POSIX_)
-	errno = ERANGE;
-      else if (! matherr (& exc))
-	errno = ERANGE;
-
-      if (exc.err != 0)
-	errno = exc.err;
-
-      return (long double) exc.retval; 
+      errno = ERANGE;
+      return (long double) HUGE_VAL;
     }
 
   return z;
diff --git a/newlib/libm/common/s_exp10.c b/newlib/libm/common/s_exp10.c
index 08fa5ff..6bd027f 100644
--- a/newlib/libm/common/s_exp10.c
+++ b/newlib/libm/common/s_exp10.c
@@ -34,9 +34,6 @@ DESCRIPTION
 	$10^x$
 	@end tex
 
-	You can use the (non-ANSI) function <<matherr>> to specify
-	error handling for these functions.
-
 RETURNS
 	On success, <<exp10>> and <<exp10f>> return the calculated value.
 	If the result underflows, the returned value is <<0>>.  If the
diff --git a/newlib/libm/common/s_lib_ver.c b/newlib/libm/common/s_lib_ver.c
index 15c8b41..8da03b7 100644
--- a/newlib/libm/common/s_lib_ver.c
+++ b/newlib/libm/common/s_lib_ver.c
@@ -24,10 +24,10 @@
 _LIB_VERSION_TYPE _LIB_VERSION = _POSIX_;
 #else
 #ifdef _XOPEN_MODE
-_LIB_VERSION_TYPE _LIB_VERSION = _XOPEN_;
+#error _XOPEN_MODE is unsupported
 #else
 #ifdef _SVID3_MODE
-_LIB_VERSION_TYPE _LIB_VERSION = _SVID_;
+#error _SVID3_MODE is unsupported
 #else					/* default _IEEE_MODE */
 _LIB_VERSION_TYPE _LIB_VERSION = _IEEE_;
 #endif
diff --git a/newlib/libm/common/s_log2.c b/newlib/libm/common/s_log2.c
index 0b1ec1d..724148c 100644
--- a/newlib/libm/common/s_log2.c
+++ b/newlib/libm/common/s_log2.c
@@ -38,10 +38,6 @@ macros defined in math.h:
 . #define log2f(x) (logf (x) / (float) _M_LN2)
 To use the functions instead, just undefine the macros first.
 
-You can use the (non-ANSI) function <<matherr>> to specify error
-handling for these functions, indirectly through the respective <<log>>
-function. 
-
 RETURNS
 The <<log2>> functions return
 @ifnottex
@@ -54,8 +50,7 @@ on success.
 When <[x]> is zero, the
 returned value is <<-HUGE_VAL>> and <<errno>> is set to <<ERANGE>>.
 When <[x]> is negative, the returned value is NaN (not a number) and
-<<errno>> is set to <<EDOM>>.  You can control the error behavior via
-<<matherr>>.
+<<errno>> is set to <<EDOM>>.
 
 PORTABILITY
 C99, POSIX, System V Interface Definition (Issue 6).
diff --git a/newlib/libm/common/s_matherr.c b/newlib/libm/common/s_matherr.c
deleted file mode 100644
index 00d2caa..0000000
--- a/newlib/libm/common/s_matherr.c
+++ /dev/null
@@ -1,118 +0,0 @@
-
-/* @(#)s_matherr.c 5.1 93/09/24 */
-/*
- * ====================================================
- * Copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
- *
- * Developed at SunPro, a Sun Microsystems, Inc. business.
- * Permission to use, copy, modify, and distribute this
- * software is freely granted, provided that this notice 
- * is preserved.
- * ====================================================
- */
-
-/*
-
-FUNCTION
-	<<matherr>>---modifiable math error handler
-
-INDEX 
-	matherr
-
-SYNOPSIS
-	#include <math.h>
-	int matherr(struct exception *<[e]>);
-
-DESCRIPTION
-<<matherr>> is called whenever a math library function generates an error.
-You can replace <<matherr>> by your own subroutine to customize
-error treatment.  The customized <<matherr>> must return 0 if
-it fails to resolve the error, and non-zero if the error is resolved.
-
-When <<matherr>> returns a nonzero value, no error message is printed
-and the value of <<errno>> is not modified.  You can accomplish either
-or both of these things in your own <<matherr>> using the information
-passed in the structure <<*<[e]>>>.
-
-This is the <<exception>> structure (defined in `<<math.h>>'):
-.	struct exception {
-.	        int type;
-.	        char *name;
-.	        double arg1, arg2, retval;
-.		int err;
-.	};
-
-The members of the exception structure have the following meanings:
-o+
-o type
-The type of mathematical error that occured; macros encoding error
-types are also defined in `<<math.h>>'.
-
-o name
-a pointer to a null-terminated string holding the
-name of the math library function where the error occurred.
-
-o arg1, arg2
-The arguments which caused the error.
-
-o retval
-The error return value (what the calling function will return).
-
-o err
-If set to be non-zero, this is the new value assigned to <<errno>>.
-o-
-
-The error types defined in `<<math.h>>' represent possible mathematical
-errors as follows:
-
-o+
-o DOMAIN
-An argument was not in the domain of the function; e.g. <<log(-1.0)>>.
-
-o SING
-The requested calculation would result in a singularity; e.g. <<pow(0.0,-2.0)>>
-
-o OVERFLOW
-A calculation would produce a result too large to represent; e.g.
-<<exp(1000.0)>>. 
-
-o UNDERFLOW
-A calculation would produce a result too small to represent; e.g.
-<<exp(-1000.0)>>. 
-
-o TLOSS
-Total loss of precision.  The result would have no significant digits;
-e.g. <<sin(10e70)>>. 
-
-o PLOSS
-Partial loss of precision.
-o-
-
-
-RETURNS
-The library definition for <<matherr>> returns <<0>> in all cases.
-
-You can change the calling function's result from a customized <<matherr>>
-by modifying <<e->retval>>, which propagates backs to the caller.
-
-If <<matherr>> returns <<0>> (indicating that it was not able to resolve
-the error) the caller sets <<errno>> to an appropriate value, and prints
-an error message.
-
-PORTABILITY
-<<matherr>> is not ANSI C.  
-*/
-
-#include "fdlibm.h"
-
-#ifdef __STDC__
-	int matherr(struct exception *x)
-#else
-	int matherr(x)
-	struct exception *x;
-#endif
-{
-	int n=0;
-	if(x->arg1!=x->arg1) return 0;
-	return n;
-}
diff --git a/newlib/libm/common/s_pow10.c b/newlib/libm/common/s_pow10.c
index 46645c7..a9e7284 100644
--- a/newlib/libm/common/s_pow10.c
+++ b/newlib/libm/common/s_pow10.c
@@ -34,9 +34,6 @@ DESCRIPTION
 	$10^x$
 	@end tex
 
-	You can use the (non-ANSI) function <<matherr>> to specify
-	error handling for these functions.
-
 RETURNS
 	On success, <<pow10>> and <<pow10f>> return the calculated value.
 	If the result underflows, the returned value is <<0>>.  If the
diff --git a/newlib/libm/complex/Makefile.in b/newlib/libm/complex/Makefile.in
index f812899..20b3b17 100644
--- a/newlib/libm/complex/Makefile.in
+++ b/newlib/libm/complex/Makefile.in
@@ -271,7 +271,6 @@ pdfdir = @pdfdir@
 prefix = @prefix@
 program_transform_name = @program_transform_name@
 psdir = @psdir@
-runstatedir = @runstatedir@
 sbindir = @sbindir@
 sharedstatedir = @sharedstatedir@
 srcdir = @srcdir@
diff --git a/newlib/libm/libm.texinfo b/newlib/libm/libm.texinfo
index f55ad72..a579a17 100644
--- a/newlib/libm/libm.texinfo
+++ b/newlib/libm/libm.texinfo
@@ -107,23 +107,13 @@ into another language, under the above conditions for modified versions.
 @cindex reentrancy
 @cindex @code{matherr} and reentrancy
 When a libm function detects an exceptional case, @code{errno} may be
-set, the @code{matherr} function may be called, and a error message 
-may be written to the standard error stream.  This behavior may not
-be reentrant.
+set.
 
 @c The exact behavior depends on the currently selected error handling 
-@c mode (IEEE, POSIX, X/Open, or SVID).
+@c mode (IEEE or POSIX).
 
-With reentrant C libraries like the Red Hat newlib C library, @code{errno} is
-a macro which expands to the per-thread error value.  This makes it thread
-safe.
-
-When the user provides his own @code{matherr} function it must be
-reentrant for the math library as a whole to be reentrant.
-
-In normal debugged programs, there are usually no math subroutine
-errors---and therefore no assignments to @code{errno} and no @code{matherr}
-calls; in that situation, the math functions behave reentrantly.
+@code{errno} is a macro which expands to the per-thread error value.
+This makes it thread safe, and therefore reentrant.
 
 @node Long Double Functions
 @chapter The long double function support of @code{libm}
diff --git a/newlib/libm/math/k_standard.c b/newlib/libm/math/k_standard.c
index 0d72f1a..91fd6c3 100644
--- a/newlib/libm/math/k_standard.c
+++ b/newlib/libm/math/k_standard.c
@@ -31,7 +31,7 @@ static double zero = 0.0;	/* used as const */
 #endif
 
 /* 
- * Standard conformance (non-IEEE) on exception cases.
+ * POSIX Standard conformance on exception cases.
  * Mapping:
  *	1 -- acos(|x|>1)
  *	2 -- asin(|x|>1)
@@ -85,7 +85,7 @@ static double zero = 0.0;	/* used as const */
 	double x,y; int type;
 #endif
 {
-	struct exception exc;
+	double retval = 0.0;
 #ifndef HUGE_VAL	/* this is the only routine that uses HUGE_VAL */ 
 #define HUGE_VAL inf
 	double inf = 0.0;
@@ -96,689 +96,264 @@ static double zero = 0.0;	/* used as const */
 #ifdef _USE_WRITE
         /* (void) fflush(_stdout_r(p)); */        
 #endif
-	exc.arg1 = x;
-	exc.arg2 = y;
-	exc.err = 0;
 	switch(type) {
 	    case 1:
 	    case 101:
 		/* acos(|x|>1) */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "acos" : "acosf";
-		exc.retval = zero;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if(_LIB_VERSION == _SVID_) {
-		    (void) WRITE2("acos: DOMAIN error\n", 19);
-		  } */
-		  errno = EDOM;
-		}
+		retval = zero;
+		errno = EDOM;
 		break;
 	    case 2:
 	    case 102:
 		/* asin(|x|>1) */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "asin" : "asinf";
-		exc.retval = zero;
-		if(_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if(_LIB_VERSION == _SVID_) {
-		    	(void) WRITE2("asin: DOMAIN error\n", 19);
-		  } */
-		  errno = EDOM;
-		}
+		retval = zero;
+		errno = EDOM;
 		break;
 	    case 3:
 	    case 103:
 		/* atan2(+-0,+-0) */
-		exc.arg1 = y;
-		exc.arg2 = x;
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "atan2" : "atan2f";
-		exc.retval = zero;
-		if(_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if(_LIB_VERSION == _SVID_) {
-			(void) WRITE2("atan2: DOMAIN error\n", 20);
-		      } */
-		  errno = EDOM;
-		}
+		retval = zero;
+		errno = EDOM;
 		break;
 	    case 4:
 	    case 104:
 		/* hypot(finite,finite) overflow */
-		exc.type = OVERFLOW;
-		exc.name = type < 100 ? "hypot" : "hypotf";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = HUGE;
-		else
-		  exc.retval = HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
+		retval = HUGE_VAL;
+		errno = ERANGE;
 		break;
 	    case 5:
 	    case 105:
 		/* cosh(finite) overflow */
-		exc.type = OVERFLOW;
-		exc.name = type < 100 ? "cosh" : "coshf";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = HUGE;
-		else
-		  exc.retval = HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
+		retval = HUGE_VAL;
+		errno = ERANGE;
 		break;
 	    case 6:
 	    case 106:
 		/* exp(finite) overflow */
-		exc.type = OVERFLOW;
-		exc.name = type < 100 ? "exp" : "expf";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = HUGE;
-		else
-		  exc.retval = HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
+		retval = HUGE_VAL;
+		errno = ERANGE;
 		break;
 	    case 7:
 	    case 107:
 		/* exp(finite) underflow */
-		exc.type = UNDERFLOW;
-		exc.name = type < 100 ? "exp" : "expf";
-		exc.retval = zero;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
+		retval = zero;
+		errno = ERANGE;
 		break;
 	    case 8:
 	    case 108:
 		/* y0(0) = -inf */
-		exc.type = DOMAIN;	/* should be SING for IEEE */
-		exc.name = type < 100 ? "y0" : "y0f";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("y0: DOMAIN error\n", 17);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 9:
 	    case 109:
 		/* y0(x<0) = NaN */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "y0" : "y0f";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /*if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("y0: DOMAIN error\n", 17);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 10:
 	    case 110:
 		/* y1(0) = -inf */
-		exc.type = DOMAIN;	/* should be SING for IEEE */
-		exc.name = type < 100 ? "y1" : "y1f";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("y1: DOMAIN error\n", 17);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 11:
 	    case 111:
 		/* y1(x<0) = NaN */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "y1" : "y1f";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("y1: DOMAIN error\n", 17);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 12:
 	    case 112:
 		/* yn(n,0) = -inf */
-		exc.type = DOMAIN;	/* should be SING for IEEE */
-		exc.name = type < 100 ? "yn" : "ynf";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("yn: DOMAIN error\n", 17);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 13:
 	    case 113:
 		/* yn(x<0) = NaN */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "yn" : "ynf";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("yn: DOMAIN error\n", 17);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 14:
 	    case 114:
 		/* lgamma(finite) overflow */
-		exc.type = OVERFLOW;
-		exc.name = type < 100 ? "lgamma" : "lgammaf";
-                if (_LIB_VERSION == _SVID_)
-                  exc.retval = HUGE;
-                else
-                  exc.retval = HUGE_VAL;
-                if (_LIB_VERSION == _POSIX_)
-			errno = ERANGE;
-                else if (!matherr(&exc)) {
-                        errno = ERANGE;
-		}
+		retval = HUGE_VAL;
+		errno = ERANGE;
 		break;
 	    case 15:
 	    case 115:
 		/* lgamma(-integer) or lgamma(0) */
-		exc.type = SING;
-		exc.name = type < 100 ? "lgamma" : "lgammaf";
-                if (_LIB_VERSION == _SVID_)
-                  exc.retval = HUGE;
-                else
-                  exc.retval = HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("lgamma: SING error\n", 19);
-		      } */
-		  errno = EDOM;
-		}
+		retval = HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 16:
 	    case 116:
 		/* log(0) */
-		exc.type = SING;
-		exc.name = type < 100 ? "log" : "logf";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("log: SING error\n", 16);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 17:
 	    case 117:
 		/* log(x<0) */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "log" : "logf";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("log: DOMAIN error\n", 18);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 18:
 	    case 118:
 		/* log10(0) */
-		exc.type = SING;
-		exc.name = type < 100 ? "log10" : "log10f";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("log10: SING error\n", 18);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 19:
 	    case 119:
 		/* log10(x<0) */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "log10" : "log10f";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = -HUGE;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("log10: DOMAIN error\n", 20);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 20:
 	    case 120:
 		/* pow(0.0,0.0) */
-		/* error only if _LIB_VERSION == _SVID_ */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "pow" : "powf";
-		exc.retval = zero;
-		if (_LIB_VERSION != _SVID_) exc.retval = 1.0;
-		else if (!matherr(&exc)) {
-		  /* (void) WRITE2("pow(0,0): DOMAIN error\n", 23); */
-			errno = EDOM;
-		}
+		/* Not an error.  */
+		retval = 1.0;
 		break;
 	    case 21:
 	    case 121:
 		/* pow(x,y) overflow */
-		exc.type = OVERFLOW;
-		exc.name = type < 100 ? "pow" : "powf";
-		if (_LIB_VERSION == _SVID_) {
-		  exc.retval = HUGE;
-		  y *= 0.5;
-		  if(x<zero&&rint(y)!=y) exc.retval = -HUGE;
-		} else {
-		  exc.retval = HUGE_VAL;
-		  y *= 0.5;
-		  if(x<zero&&rint(y)!=y) exc.retval = -HUGE_VAL;
-		}
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
+		retval = HUGE_VAL;
+		y *= 0.5;
+		if(x<zero&&rint(y)!=y)
+		  retval = -HUGE_VAL;
+		errno = ERANGE;
 		break;
 	    case 22:
 	    case 122:
 		/* pow(x,y) underflow */
-		exc.type = UNDERFLOW;
-		exc.name = type < 100 ? "pow" : "powf";
-		exc.retval =  zero;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
+		retval =  zero;
+		errno = ERANGE;
 		break;
 	    case 23:
 	    case 123:
 		/* 0**neg */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "pow" : "powf";
-		if (_LIB_VERSION == _SVID_) 
-		  exc.retval = zero;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("pow(0,neg): DOMAIN error\n", 25);
-		      } */
-		  errno = EDOM;
-		}
+		retval = -HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 24:
 	    case 124:
 		/* neg**non-integral */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "pow" : "powf";
-		if (_LIB_VERSION == _SVID_) 
-		    exc.retval = zero;
-		else 
-		    exc.retval = zero/zero;	/* X/Open allow NaN */
-		if (_LIB_VERSION == _POSIX_) 
-		   errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("neg**non-integral: DOMAIN error\n", 32);
-		      } */
-		  errno = EDOM;
-		}
+		retval = zero/zero;
+		errno = EDOM;
 		break;
 	    case 25:
 	    case 125:
 		/* sinh(finite) overflow */
-		exc.type = OVERFLOW;
-		exc.name = type < 100 ? "sinh" : "sinhf";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = ( (x>zero) ? HUGE : -HUGE);
-		else
-		  exc.retval = ( (x>zero) ? HUGE_VAL : -HUGE_VAL);
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
+		retval = ( (x>zero) ? HUGE_VAL : -HUGE_VAL);
+		errno = ERANGE;
 		break;
 	    case 26:
 	    case 126:
 		/* sqrt(x<0) */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "sqrt" : "sqrtf";
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = zero;
-		else
-		  exc.retval = zero/zero;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("sqrt: DOMAIN error\n", 19);
-		      } */
-		  errno = EDOM;
-		}
+		retval = zero/zero;
+		errno = EDOM;
 		break;
             case 27:
 	    case 127:
-                /* fmod(x,0) */
-                exc.type = DOMAIN;
-                exc.name = type < 100 ? "fmod" : "fmodf";
-                if (_LIB_VERSION == _SVID_)
-                    exc.retval = x;
-		else
-		    exc.retval = zero/zero;
-                if (_LIB_VERSION == _POSIX_)
-                  errno = EDOM;
-                else if (!matherr(&exc)) {
-                  /* if (_LIB_VERSION == _SVID_) {
-                    (void) WRITE2("fmod:  DOMAIN error\n", 20);
-                  } */
-                  errno = EDOM;
-                }
+		/* fmod(x,0) */
+		retval = zero/zero;
+		errno = EDOM;
                 break;
             case 28:
 	    case 128:
                 /* remainder(x,0) */
-                exc.type = DOMAIN;
-                exc.name = type < 100 ? "remainder" : "remainderf";
-                exc.retval = zero/zero;
-                if (_LIB_VERSION == _POSIX_)
-                  errno = EDOM;
-                else if (!matherr(&exc)) {
-                  /* if (_LIB_VERSION == _SVID_) {
-                    (void) WRITE2("remainder: DOMAIN error\n", 24);
-                  } */
-                  errno = EDOM;
-                }
+		retval = zero/zero;
+		errno = EDOM;
                 break;
             case 29:
 	    case 129:
                 /* acosh(x<1) */
-                exc.type = DOMAIN;
-                exc.name = type < 100 ? "acosh" : "acoshf";
-                exc.retval = zero/zero;
-                if (_LIB_VERSION == _POSIX_)
-                  errno = EDOM;
-                else if (!matherr(&exc)) {
-                  /* if (_LIB_VERSION == _SVID_) {
-                    (void) WRITE2("acosh: DOMAIN error\n", 20);
-                  } */
-                  errno = EDOM;
-                }
+		retval = zero/zero;
+		errno = EDOM;
                 break;
             case 30:
 	    case 130:
                 /* atanh(|x|>1) */
-                exc.type = DOMAIN;
-                exc.name = type < 100 ? "atanh" : "atanhf";
-                exc.retval = zero/zero;
-                if (_LIB_VERSION == _POSIX_)
-                  errno = EDOM;
-                else if (!matherr(&exc)) {
-                  /* if (_LIB_VERSION == _SVID_) {
-                    (void) WRITE2("atanh: DOMAIN error\n", 20);
-                  } */
-                  errno = EDOM;
-                }
+		retval = zero/zero;
+		errno = EDOM;
                 break;
             case 31:
 	    case 131:
                 /* atanh(|x|=1) */
-                exc.type = SING;
-                exc.name = type < 100 ? "atanh" : "atanhf";
-		exc.retval = x/zero;	/* sign(x)*inf */
-                if (_LIB_VERSION == _POSIX_)
-                  errno = EDOM;
-                else if (!matherr(&exc)) {
-                  /* if (_LIB_VERSION == _SVID_) {
-                    (void) WRITE2("atanh: SING error\n", 18);
-                  } */
-                  errno = EDOM;
-                }
+		retval = x/zero;	/* sign(x)*inf */
+		errno = EDOM;
                 break;
 	    case 32:
 	    case 132:
-		/* scalb overflow; SVID also returns +-HUGE_VAL */
-		exc.type = OVERFLOW;
-		exc.name = type < 100 ? "scalb" : "scalbf";
-		exc.retval = x > zero ? HUGE_VAL : -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
+		/* scalb overflow */
+		retval = x > zero ? HUGE_VAL : -HUGE_VAL;
+		errno = ERANGE;
 		break;
 	    case 33:
 	    case 133:
 		/* scalb underflow */
-		exc.type = UNDERFLOW;
-		exc.name = type < 100 ? "scalb" : "scalbf";
-		exc.retval = copysign(zero,x);
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
+		retval = copysign(zero,x);
+		errno = ERANGE;
 		break;
 	    case 34:
 	    case 134:
 		/* j0(|x|>X_TLOSS) */
-                exc.type = TLOSS;
-                exc.name = type < 100 ? "j0" : "j0f";
-                exc.retval = zero;
-                if (_LIB_VERSION == _POSIX_)
-                        errno = ERANGE;
-                else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-                                (void) WRITE2(exc.name, 2);
-                                (void) WRITE2(": TLOSS error\n", 14);
-                        } */
-                        errno = ERANGE;
-                }        
+		retval = zero;
+		errno = ERANGE;
 		break;
 	    case 35:
 	    case 135:
 		/* y0(x>X_TLOSS) */
-                exc.type = TLOSS;
-                exc.name = type < 100 ? "y0" : "y0f";
-                exc.retval = zero;
-                if (_LIB_VERSION == _POSIX_)
-                        errno = ERANGE;
-                else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-                                (void) WRITE2(exc.name, 2);
-                                (void) WRITE2(": TLOSS error\n", 14);
-                        } */
-                        errno = ERANGE;
-                }        
+		retval = zero;
+		errno = ERANGE;
 		break;
 	    case 36:
 	    case 136:
 		/* j1(|x|>X_TLOSS) */
-                exc.type = TLOSS;
-                exc.name = type < 100 ? "j1" : "j1f";
-                exc.retval = zero;
-                if (_LIB_VERSION == _POSIX_)
-                        errno = ERANGE;
-                else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-                                (void) WRITE2(exc.name, 2);
-                                (void) WRITE2(": TLOSS error\n", 14);
-                        } */
-                        errno = ERANGE;
-                }        
+		retval = zero;
+		errno = ERANGE;
 		break;
 	    case 37:
 	    case 137:
 		/* y1(x>X_TLOSS) */
-                exc.type = TLOSS;
-                exc.name = type < 100 ? "y1" : "y1f";
-                exc.retval = zero;
-                if (_LIB_VERSION == _POSIX_)
-                        errno = ERANGE;
-                else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-                                (void) WRITE2(exc.name, 2);
-                                (void) WRITE2(": TLOSS error\n", 14);
-                        } */
-                        errno = ERANGE;
-                }        
+		retval = zero;
+		errno = ERANGE;
 		break;
 	    case 38:
 	    case 138:
 		/* jn(|x|>X_TLOSS) */
-                exc.type = TLOSS;
-                exc.name = type < 100 ? "jn" : "jnf";
-                exc.retval = zero;
-                if (_LIB_VERSION == _POSIX_)
-                        errno = ERANGE;
-                else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-                                (void) WRITE2(exc.name, 2);
-                                (void) WRITE2(": TLOSS error\n", 14);
-                        } */
-                        errno = ERANGE;
-                }        
+		retval = zero;
+		errno = ERANGE;
 		break;
 	    case 39:
 	    case 139:
 		/* yn(x>X_TLOSS) */
-                exc.type = TLOSS;
-                exc.name = type < 100 ? "yn" : "ynf";
-                exc.retval = zero;
-                if (_LIB_VERSION == _POSIX_)
-                        errno = ERANGE;
-                else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-                                (void) WRITE2(exc.name, 2);
-                                (void) WRITE2(": TLOSS error\n", 14);
-                        } */
-                        errno = ERANGE;
-                }        
+		retval = zero;
+		errno = ERANGE;
 		break;
 	    case 40:
 	    case 140:
 		/* gamma(finite) overflow */
-		exc.type = OVERFLOW;
-		exc.name = type < 100 ? "gamma" : "gammaf";
-                if (_LIB_VERSION == _SVID_)
-                  exc.retval = HUGE;
-                else
-                  exc.retval = HUGE_VAL;
-                if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-                else if (!matherr(&exc)) {
-                  errno = ERANGE;
-                }
+		retval = HUGE_VAL;
+		errno = ERANGE;
 		break;
 	    case 41:
 	    case 141:
 		/* gamma(-integer) or gamma(0) */
-		exc.type = SING;
-		exc.name = type < 100 ? "gamma" : "gammaf";
-                if (_LIB_VERSION == _SVID_)
-                  exc.retval = HUGE;
-                else
-                  exc.retval = HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  /* if (_LIB_VERSION == _SVID_) {
-			(void) WRITE2("gamma: SING error\n", 18);
-		      } */
-		  errno = EDOM;
-		}
+		retval = HUGE_VAL;
+		errno = EDOM;
 		break;
 	    case 42:
 	    case 142:
 		/* pow(NaN,0.0) */
-		/* error only if _LIB_VERSION == _SVID_ & _XOPEN_ */
-		exc.type = DOMAIN;
-		exc.name = type < 100 ? "pow" : "powf";
-		exc.retval = x;
-		if (_LIB_VERSION == _IEEE_ ||
-		    _LIB_VERSION == _POSIX_) exc.retval = 1.0;
-		else if (!matherr(&exc)) {
-			errno = EDOM;
-		}
+		/* Not an error.  */
+		retval = 1.0;
 		break;
 	}
-	if (exc.err != 0)
-	    errno = exc.err;
-	return exc.retval; 
+	return retval;
 }
 
 
diff --git a/newlib/libm/math/math.tex b/newlib/libm/math/math.tex
index a6f931b..92b384f 100644
--- a/newlib/libm/math/math.tex
+++ b/newlib/libm/math/math.tex
@@ -3,33 +3,15 @@
 
 This chapter groups a wide variety of mathematical functions.  The
 corresponding definitions and declarations are in @file{math.h}.  
-Two definitions from @file{math.h} are of particular interest.  
+The definition of HUGE_VAL from @file{math.h} is of particular interest.
 
 @enumerate
 @item
 The representation of infinity as a @code{double} is defined as
 @code{HUGE_VAL}; this number is returned on overflow by many functions.
 The macro @code{HUGE_VALF} is a corresponding value for @code{float}.
-
-@item
-The structure @code{exception} is used when you write customized error
-handlers for the mathematical functions.  You can customize error
-handling for most of these functions by defining your own version of
-@code{matherr}; see the section on @code{matherr} for details.
 @end enumerate
 
-@cindex system calls
-@cindex support subroutines
-@cindex stubs
-@cindex OS stubs
-Since the error handling code calls @code{fputs}, the mathematical
-subroutines require stubs or minimal implementations for the same list
-of OS subroutines as @code{fputs}: @code{close}, @code{fstat},
-@code{isatty}, @code{lseek}, @code{read}, @code{sbrk}, @code{write}.
-@xref{syscalls,,System Calls, libc.info, The Red Hat newlib C Library},
-for a discussion and for sample minimal implementations of these support
-subroutines.
-
 Alternative declarations of the mathematical functions, which exploit
 specific machine capabilities to operate faster---but generally have
 less error checking and may reflect additional limitations on some
@@ -76,7 +58,6 @@ machines---are available when you include @file{fastmath.h} instead of
 * logb::	Get exponent
 * lrint::	Round to integer
 * lround::	Round to integer, away from zero (lround, llround)
-* matherr::	Modifiable math error handler
 * modf::	Split fractional and integer parts
 * nan::		Floating Not a Number
 * nearbyint::	Round to integer
@@ -101,40 +82,23 @@ machines---are available when you include @file{fastmath.h} instead of
 @node version
 @section Error Handling
 
-There are four different versions of the math library routines: IEEE,
-POSIX, X/Open, or SVID.  The version may be selected at runtime by
+There are two different versions of the math library routines: IEEE
+and POSIX.  The version may be selected at runtime by
 setting the global variable @code{_LIB_VERSION}, defined in
 @file{math.h}.  It may be set to one of the following constants defined
-in @file{math.h}: @code{_IEEE_}, @code{_POSIX_}, @code{_XOPEN_}, or
-@code{_SVID_}.  The @code{_LIB_VERSION} variable is not specific to any
+in @file{math.h}: @code{_IEEE_} or @code{_POSIX_}.
+The @code{_LIB_VERSION} variable is not specific to any
 thread, and changing it will affect all threads.
 
-The versions of the library differ only in how errors are handled.
-
-In IEEE mode, the @code{matherr} function is never called, no warning
-messages are printed, and @code{errno} is never set.
+The versions of the library differ only in the setting of @code{errno}.
 
-In POSIX mode, @code{errno} is set correctly, but the @code{matherr}
-function is never called and no warning messages are printed.
+In IEEE mode, @code{errno} is never set.
 
-In X/Open mode, @code{errno} is set correctly, and @code{matherr} is
-called, but warning message are not printed.
+In POSIX mode, @code{errno} is set correctly.
 
-In SVID mode, functions which overflow return 3.40282346638528860e+38,
-the maximum single-precision floating-point value, rather than infinity.
-Also, @code{errno} is set correctly, @code{matherr} is called, and, if
-@code{matherr} returns 0, warning messages are printed for some errors.
-For example, by default @samp{log(-1.0)} writes this message on standard
-error output:
+The library is set to IEEE mode by default.
 
-@example
-log: DOMAIN error
-@end example
-
-The library is set to X/Open mode by default.
-
-The aforementioned error reporting is the supported Newlib libm error
-handling method.  However, the majority of the functions are written
+The majority of the floating-point math functions are written
 so as to produce the floating-point exceptions (e.g. "invalid",
 "divide-by-zero") as required by the C and POSIX standards, for
 floating-point implementations that support them.  Newlib does not provide
@@ -241,8 +205,6 @@ registered trademark of The IEEE.
 @page
 @include common/s_lround.def
 @page
-@include common/s_matherr.def
-@page
 @include common/s_modf.def
 @page
 @include common/s_nan.def
diff --git a/newlib/libm/math/w_acos.c b/newlib/libm/math/w_acos.c
index eb3e201..c0a86a9 100644
--- a/newlib/libm/math/w_acos.c
+++ b/newlib/libm/math/w_acos.c
@@ -42,16 +42,12 @@ RETURNS
 	@end tex
 
 	If <[x]> is not between @minus{}1 and 1, the returned value is NaN
-	(not a number) the global variable <<errno>> is set to <<EDOM>>, and a
-	<<DOMAIN error>> message is sent as standard error output.
-
-	You can modify error handling for these functions using <<matherr>>.
-
+	(not a number), and the global variable <<errno>> is set to <<EDOM>>.
 
 QUICKREF
- ansi svid posix rentrant
- acos	 y,y,y,m
- acosf   n,n,n,m
+ ansi posix rentrant
+ acos	 y,y,m
+ acosf   n,n,m
 
 MATHREF  
  acos, [-1,1], acos(arg),,,
@@ -83,24 +79,12 @@ MATHREF
 	return __ieee754_acos(x);
 #else
 	double z;
-       	struct exception exc;
        	z = __ieee754_acos(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	if(fabs(x)>1.0) { 
 	    /* acos(|x|>1) */
-	    exc.type = DOMAIN;
-	    exc.name = "acos";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-	    exc.retval = nan("");
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = EDOM;
-	    else if (!matherr(&exc)) {
-	       errno = EDOM;
-            }
-            if (exc.err != 0)
-	       errno = exc.err;
-	    return exc.retval; 
+	    errno = EDOM;
+	    return nan("");
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_acosh.c b/newlib/libm/math/w_acosh.c
index ac15bb1..7438266 100644
--- a/newlib/libm/math/w_acosh.c
+++ b/newlib/libm/math/w_acosh.c
@@ -44,18 +44,15 @@ RETURNS
 <<acosh>> and <<acoshf>> return the calculated value.  If <[x]> 
 less than 1, the return value is NaN and <<errno>> is set to <<EDOM>>.
 
-You can change the error-handling behavior with the non-ANSI
-<<matherr>> function.
-
 PORTABILITY
 Neither <<acosh>> nor <<acoshf>> are ANSI C.  They are not recommended
 for portable programs.
 
 
 QUICKREF
- ansi svid posix rentrant
- acos	 n,n,n,m
- acosf   n,n,n,m
+ ansi posix rentrant
+ acos	 n,n,m
+ acosf   n,n,m
 
 MATHREF  
  acosh, NAN,   arg,DOMAIN,EDOM
@@ -89,24 +86,12 @@ MATHREF
 	return __ieee754_acosh(x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_acosh(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	if(x<1.0) {
             /* acosh(x<1) */
-            exc.type = DOMAIN;
-            exc.name = "acosh";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-            exc.retval = 0.0/0.0;
-            if (_LIB_VERSION == _POSIX_)
-               errno = EDOM;
-            else if (!matherr(&exc)) {
-               errno = EDOM;
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-	    return exc.retval; 
+	    errno = EDOM;
+	    return 0.0/0.0;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_asin.c b/newlib/libm/math/w_asin.c
index 9964d75..a94b0d5 100644
--- a/newlib/libm/math/w_asin.c
+++ b/newlib/libm/math/w_asin.c
@@ -34,8 +34,6 @@ Arguments to <<asin>> must be in the range @minus{}1 to 1.
 <<asinf>> is identical to <<asin>>, other than taking and
 returning floats.
 
-You can modify error handling for these routines using <<matherr>>. 
-
 RETURNS
 @ifnottex
 <<asin>> returns values in radians, in the range of -pi/2 to pi/2.
@@ -45,15 +43,13 @@ RETURNS
 @end tex
 
 If <[x]> is not in the range @minus{}1 to 1, <<asin>> and <<asinf>>
-return NaN (not a number), set the global variable <<errno>> to
-<<EDOM>>, and issue a <<DOMAIN error>> message.
-
-You can change this error treatment using <<matherr>>.
+return NaN (not a number), and the global variable <<errno>> is set to
+<<EDOM>>.
 
 QUICKREF
- ansi svid posix rentrant
- asin	 y,y,y,m
- asinf   n,n,n,m
+ ansi posix rentrant
+ asin	 y,y,m
+ asinf   n,n,m
 
 MATHREF  
  asin,  -1<=arg<=1, asin(arg),,,
@@ -87,24 +83,12 @@ MATHREF
 	return __ieee754_asin(x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_asin(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	if(fabs(x)>1.0) {
 	    /* asin(|x|>1) */
-	    exc.type = DOMAIN;
-	    exc.name = "asin";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-	    exc.retval = nan("");
-	    if(_LIB_VERSION == _POSIX_)
-	      errno = EDOM;
-	    else if (!matherr(&exc)) {
-	      errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	      errno = exc.err;
-	    return exc.retval; 
+	    errno = EDOM;
+	    return nan("");
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_atan2.c b/newlib/libm/math/w_atan2.c
index bcf9506..4b2bb6a 100644
--- a/newlib/libm/math/w_atan2.c
+++ b/newlib/libm/math/w_atan2.c
@@ -50,8 +50,6 @@ RETURNS
 $-\pi$ to $\pi$.
 @end tex
 
-You can modify error handling for these functions using <<matherr>>.
-
 PORTABILITY
 <<atan2>> is ANSI C.  <<atan2f>> is an extension.
 
diff --git a/newlib/libm/math/w_atanh.c b/newlib/libm/math/w_atanh.c
index a87e23c..3376aef 100644
--- a/newlib/libm/math/w_atanh.c
+++ b/newlib/libm/math/w_atanh.c
@@ -54,9 +54,6 @@ RETURNS
 	is 1, the global <<errno>> is set to <<EDOM>>; and the result is 
 	infinity with the same sign as <<x>>.  A <<SING error>> is reported.
 
-	You can modify the error handling for these routines using
-	<<matherr>>.
-
 PORTABILITY
 	Neither <<atanh>> nor <<atanhf>> are ANSI C.
 
@@ -87,39 +84,19 @@ QUICKREF
 	return __ieee754_atanh(x);
 #else
 	double z,y;
-	struct exception exc;
 	z = __ieee754_atanh(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	y = fabs(x);
 	if(y>=1.0) {
 	    if(y>1.0) {
-                /* atanh(|x|>1) */
-                exc.type = DOMAIN;
-                exc.name = "atanh";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = x;
-                exc.retval = 0.0/0.0;
-                if (_LIB_VERSION == _POSIX_)
-                  errno = EDOM;
-                else if (!matherr(&exc)) {
-                  errno = EDOM;
-                }
+		/* atanh(|x|>1) */
+		errno = EDOM;
+		return 0.0/0.0;
 	    } else { 
-                /* atanh(|x|=1) */
-                exc.type = SING;
-                exc.name = "atanh";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = x;
-		exc.retval = x/0.0;	/* sign(x)*inf */
-                if (_LIB_VERSION == _POSIX_)
-                  errno = EDOM;
-                else if (!matherr(&exc)) {
-                  errno = EDOM;
-                }
-            }
-	    if (exc.err != 0)
-              errno = exc.err;
-            return exc.retval; 
+		/* atanh(|x|=1) */
+		errno = EDOM;
+		return x/0.0;	/* sign(x)*inf */
+	    }
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_cosh.c b/newlib/libm/math/w_cosh.c
index e5b08df..a264421 100644
--- a/newlib/libm/math/w_cosh.c
+++ b/newlib/libm/math/w_cosh.c
@@ -41,9 +41,6 @@ RETURNS
 	an overflow,  <<cosh>> returns the value <<HUGE_VAL>> with the
 	appropriate sign, and the global value <<errno>> is set to <<ERANGE>>.
 
-	You can modify error handling for these functions using the
-	function <<matherr>>.
-
 PORTABILITY
 	<<cosh>> is ANSI.  
 	<<coshf>> is an extension.
@@ -73,7 +70,6 @@ QUICKREF
 	return __ieee754_cosh(x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_cosh(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	if(fabs(x)>7.10475860073943863426e+02) {	
@@ -84,22 +80,8 @@ QUICKREF
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = OVERFLOW;
-	    exc.name = "cosh";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = HUGE;
-	    else
-	       exc.retval = HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-	    return exc.retval; 
+	    errno = ERANGE;
+	    return HUGE_VAL;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_exp.c b/newlib/libm/math/w_exp.c
index 0c44677..3da6d77 100644
--- a/newlib/libm/math/w_exp.c
+++ b/newlib/libm/math/w_exp.c
@@ -34,9 +34,6 @@ DESCRIPTION
 	@end tex
 	is the base of the natural system of logarithms, approximately 2.71828).
 
-	You can use the (non-ANSI) function <<matherr>> to specify
-	error handling for these functions.
-
 RETURNS
 	On success, <<exp>> and <<expf>> return the calculated value.
 	If the result underflows, the returned value is <<0>>.  If the
@@ -77,7 +74,6 @@ u_threshold= -7.45133219101941108420e+02;  /* 0xc0874910, 0xD52D3051 */
 	return __ieee754_exp(x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_exp(x);
 	if(_LIB_VERSION == _IEEE_) return z;
 	if(finite(x)) {
@@ -89,37 +85,12 @@ u_threshold= -7.45133219101941108420e+02;  /* 0xc0874910, 0xD52D3051 */
 
 	        SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-		exc.type = OVERFLOW;
-		exc.name = "exp";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = x;
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = HUGE;
-		else
-		  exc.retval = HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-	        return exc.retval; 
+		errno = ERANGE;
+		return HUGE_VAL;
 	    } else if(x<u_threshold) {
 		/* exp(finite) underflow */
-		exc.type = UNDERFLOW;
-		exc.name = "exp";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = x;
-		exc.retval = 0.0;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-	        return exc.retval; 
+		errno = ERANGE;
+		return 0.0;
 	    } 
 	} 
 	return z;
diff --git a/newlib/libm/math/w_exp2.c b/newlib/libm/math/w_exp2.c
index c48bdf6..7108654 100644
--- a/newlib/libm/math/w_exp2.c
+++ b/newlib/libm/math/w_exp2.c
@@ -33,9 +33,6 @@ DESCRIPTION
 	$2^x$
 	@end tex
 
-	You can use the (non-ANSI) function <<matherr>> to specify
-	error handling for these functions.
-
 RETURNS
 	On success, <<exp2>> and <<exp2f>> return the calculated value.
 	If the result underflows, the returned value is <<0>>.  If the
diff --git a/newlib/libm/math/w_fmod.c b/newlib/libm/math/w_fmod.c
index df11dc3..6788000 100644
--- a/newlib/libm/math/w_fmod.c
+++ b/newlib/libm/math/w_fmod.c
@@ -43,8 +43,6 @@ magnitude of <[y]>.
 
 <<fmod(<[x]>,0)>> returns NaN, and sets <<errno>> to <<EDOM>>.
 
-You can modify error treatment for these functions using <<matherr>>.
-
 PORTABILITY
 <<fmod>> is ANSI C. <<fmodf>> is an extension.
 */
@@ -69,28 +67,12 @@ PORTABILITY
 	return __ieee754_fmod(x,y);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_fmod(x,y);
 	if(_LIB_VERSION == _IEEE_ ||isnan(y)||isnan(x)) return z;
 	if(y==0.0) {
-            /* fmod(x,0) */
-            exc.type = DOMAIN;
-            exc.name = "fmod";
-	    exc.arg1 = x;
-	    exc.arg2 = y;
-	    exc.err = 0;
-            if (_LIB_VERSION == _SVID_)
-               exc.retval = x;
-	    else
-	       exc.retval = 0.0/0.0;
-            if (_LIB_VERSION == _POSIX_)
-               errno = EDOM;
-            else if (!matherr(&exc)) {
-                  errno = EDOM;
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    /* fmod(x,0) */
+	    errno = EDOM;
+	    return 0.0/0.0;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_gamma.c b/newlib/libm/math/w_gamma.c
index a1f50b5..6de114a 100644
--- a/newlib/libm/math/w_gamma.c
+++ b/newlib/libm/math/w_gamma.c
@@ -121,14 +121,12 @@ When <[x]> is a nonpositive integer, <<gamma>> returns <<HUGE_VAL>>
 and <<errno>> is set to <<EDOM>>.  If the result overflows, <<gamma>>
 returns <<HUGE_VAL>> and <<errno>> is set to <<ERANGE>>.
 
-You can modify this error treatment using <<matherr>>.
-
 PORTABILITY
 Neither <<gamma>> nor <<gammaf>> is ANSI C.  It is better not to use either
 of these; use <<lgamma>> or <<tgamma>> instead.@*
 <<lgamma>>, <<lgammaf>>, <<tgamma>>, and <<tgammaf>> are nominally C standard
-in terms of the base return values, although the <<matherr>> error-handling
-is not standard, nor is the <[signgam]> global for <<lgamma>>.
+in terms of the base return values, although the <[signgam]> global for
+<<lgamma>> is not standard.
 */
 
 /* double gamma(double x)
@@ -154,7 +152,6 @@ is not standard, nor is the <[signgam]> global for <<lgamma>>.
 	return __ieee754_gamma_r(x,&(_REENT_SIGNGAM(_REENT)));
 #else
         double y;
-	struct exception exc;
         y = __ieee754_gamma_r(x,&(_REENT_SIGNGAM(_REENT)));
         if(_LIB_VERSION == _IEEE_) return y;
         if(!finite(y)&&finite(x)) {
@@ -164,33 +161,14 @@ is not standard, nor is the <[signgam]> global for <<lgamma>>.
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.name = "gamma";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-            if (_LIB_VERSION == _SVID_)
-                exc.retval = HUGE;
-            else
-                exc.retval = HUGE_VAL;
 	    if(floor(x)==x&&x<=0.0) {
 		/* gamma(-integer) or gamma(0) */
-		exc.type = SING;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  errno = EDOM;
-		}
-            } else {
+		errno = EDOM;
+	    } else {
 		/* gamma(finite) overflow */
-		exc.type = OVERFLOW;
-                if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-                else if (!matherr(&exc)) {
-                  errno = ERANGE;
-                }
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-	    return exc.retval; 
+		errno = ERANGE;
+	    }
+	    return HUGE_VAL;
         } else
             return y;
 #endif
diff --git a/newlib/libm/math/w_hypot.c b/newlib/libm/math/w_hypot.c
index 5337022..441fc20 100644
--- a/newlib/libm/math/w_hypot.c
+++ b/newlib/libm/math/w_hypot.c
@@ -41,8 +41,6 @@ RETURNS
 	<<hypot>> returns <<HUGE_VAL>> and sets <<errno>> to
 	<<ERANGE>>.
 
-	You can change the error treatment with <<matherr>>.
-
 PORTABILITY
 	<<hypot>> and <<hypotf>> are not ANSI C.  */
 
@@ -66,7 +64,6 @@ PORTABILITY
 	return __ieee754_hypot(x,y);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_hypot(x,y);
 	if(_LIB_VERSION == _IEEE_) return z;
 	if((!finite(z))&&finite(x)&&finite(y)) {
@@ -77,23 +74,8 @@ PORTABILITY
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = OVERFLOW;
-	    exc.name = "hypot";
-	    exc.err = 0;
-	    exc.arg1 = x;
-	    exc.arg2 = y;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = HUGE;
-	    else
-	       exc.retval = HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	     	errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return HUGE_VAL;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_j0.c b/newlib/libm/math/w_j0.c
index ab05dbd..59d17e8 100644
--- a/newlib/libm/math/w_j0.c
+++ b/newlib/libm/math/w_j0.c
@@ -104,24 +104,12 @@ None of the Bessel functions are in ANSI C.
 #ifdef _IEEE_LIBM
 	return __ieee754_j0(x);
 #else
-	struct exception exc;
 	double z = __ieee754_j0(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	if(fabs(x)>X_TLOSS) {
 	    /* j0(|x|>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "j0";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-               errno = ERANGE;
-            else if (!matherr(&exc)) {
-               errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0;
 	} else
 	    return z;
 #endif
@@ -138,7 +126,6 @@ None of the Bessel functions are in ANSI C.
 	return __ieee754_y0(x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_y0(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
         if(x <= 0.0){
@@ -149,38 +136,13 @@ None of the Bessel functions are in ANSI C.
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
 	    /* y0(0) = -inf or y0(x<0) = NaN */
-	    exc.type = DOMAIN;	/* should be SING for IEEE y0(0) */
-	    exc.name = "y0";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = -HUGE;
-	    else
-	       exc.retval = -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = EDOM;
-	    else if (!matherr(&exc)) {
-	       errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = EDOM;
+	    return -HUGE_VAL;
         }
 	if(x>X_TLOSS) {
 	    /* y0(x>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "y0";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-               errno = ERANGE;
-            else if (!matherr(&exc)) {
-               errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-	    return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_j1.c b/newlib/libm/math/w_j1.c
index ba7df15..127324a 100644
--- a/newlib/libm/math/w_j1.c
+++ b/newlib/libm/math/w_j1.c
@@ -31,24 +31,12 @@
 	return __ieee754_j1(x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_j1(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
 	if(fabs(x)>X_TLOSS) {
 	    /* j1(|x|>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "j1";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-                errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0;
 	} else
 	    return z;
 #endif
@@ -65,7 +53,6 @@
 	return __ieee754_y1(x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_y1(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
         if(x <= 0.0){
@@ -76,38 +63,13 @@
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
 	    /* y1(0) = -inf  or y1(x<0) = NaN */
-	    exc.type = DOMAIN;	/* should be SING for IEEE */
-	    exc.name = "y1";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = -HUGE;
-	    else
-	       exc.retval = -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = EDOM;
-	    else if (!matherr(&exc)) {
-	       errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval;              
+	    errno = EDOM;
+	    return -HUGE_VAL;
         }
 	if(x>X_TLOSS) {
 	    /* y1(x>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "y1";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-                errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_jn.c b/newlib/libm/math/w_jn.c
index 6cadc9a..0482fa9 100644
--- a/newlib/libm/math/w_jn.c
+++ b/newlib/libm/math/w_jn.c
@@ -53,25 +53,12 @@
 	return __ieee754_jn(n,x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_jn(n,x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
 	if(fabs(x)>X_TLOSS) {
 	    /* jn(|x|>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "jn";
-	    exc.err = 0;
-	    exc.arg1 = n;
-	    exc.arg2 = x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-               errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0;
 	} else
 	    return z;
 #endif
@@ -88,7 +75,6 @@
 	return __ieee754_yn(n,x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_yn(n,x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
         if(x <= 0.0){
@@ -99,40 +85,13 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = DOMAIN;	/* should be SING for IEEE */
-	    exc.name = "yn";
-	    exc.err = 0;
-	    exc.arg1 = n;
-	    exc.arg2 = x;
-	    if (_LIB_VERSION == _SVID_)
-	        exc.retval = -HUGE;
-	    else
-	        exc.retval = -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	        errno = EDOM;
-	    else if (!matherr(&exc)) {
-	        errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = EDOM;
+	    return -HUGE_VAL;
         }
 	if(x>X_TLOSS) {
 	    /* yn(x>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "yn";
-	    exc.err = 0;
-	    exc.arg1 = n;
-	    exc.arg2 = x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-                errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_lgamma.c b/newlib/libm/math/w_lgamma.c
index e56e477..f848f1c 100644
--- a/newlib/libm/math/w_lgamma.c
+++ b/newlib/libm/math/w_lgamma.c
@@ -35,7 +35,6 @@
 	return __ieee754_lgamma_r(x,&(_REENT_SIGNGAM(_REENT)));
 #else
         double y;
-	struct exception exc;
         y = __ieee754_lgamma_r(x,&(_REENT_SIGNGAM(_REENT)));
         if(_LIB_VERSION == _IEEE_) return y;
         if(!finite(y)&&finite(x)) {
@@ -45,36 +44,14 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.name = "lgamma";
-	    exc.err = 0;
-	    exc.arg1 = x;
-	    exc.arg2 = x;
-            if (_LIB_VERSION == _SVID_)
-               exc.retval = HUGE;
-            else
-               exc.retval = HUGE_VAL;
-	    if(floor(x)==x&&x<=0.0) {
-		/* lgamma(-integer) */
-		exc.type = SING;
-		if (_LIB_VERSION == _POSIX_)
-		   errno = EDOM;
-		else if (!matherr(&exc)) {
-		   errno = EDOM;
-		}
-
-            } else {
-		/* lgamma(finite) overflow */
-		exc.type = OVERFLOW;
-                if (_LIB_VERSION == _POSIX_)
-		   errno = ERANGE;
-                else if (!matherr(&exc)) {
-                   errno = ERANGE;
-		}
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
-        } else
+	    if(floor(x)==x&&x<=0.0)
+	      /* lgamma(-integer) */
+	      errno = EDOM;
+	    else
+	      /* lgamma(finite) overflow */
+	      errno = ERANGE;
+	    return HUGE_VAL;
+	} else
             return y;
 #endif
 }             
diff --git a/newlib/libm/math/w_log.c b/newlib/libm/math/w_log.c
index 5f66d26..37afcac 100644
--- a/newlib/libm/math/w_log.c
+++ b/newlib/libm/math/w_log.c
@@ -30,15 +30,11 @@ Return the natural logarithm of <[x]>, that is, its logarithm base e
 (where e is the base of the natural system of logarithms, 2.71828@dots{}).
 <<log>> and <<logf>> are identical save for the return and argument types.
 
-You can use the (non-ANSI) function <<matherr>> to specify error
-handling for these functions. 
-
 RETURNS
 Normally, returns the calculated value.  When <[x]> is zero, the
 returned value is <<-HUGE_VAL>> and <<errno>> is set to <<ERANGE>>.
 When <[x]> is negative, the returned value is NaN (not a number) and
-<<errno>> is set to <<EDOM>>.  You can control the error behavior via
-<<matherr>>.
+<<errno>> is set to <<EDOM>>.
 
 PORTABILITY
 <<log>> is ANSI. <<logf>> is an extension.
@@ -65,7 +61,6 @@ PORTABILITY
 	return __ieee754_log(x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_log(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) || x > 0.0) return z;
 #ifndef HUGE_VAL 
@@ -74,35 +69,15 @@ PORTABILITY
 
 	SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	exc.name = "log";
-	exc.err = 0;
-	exc.arg1 = x;
-	exc.arg2 = x;
-	if (_LIB_VERSION == _SVID_)
-           exc.retval = -HUGE;
-	else
-	   exc.retval = -HUGE_VAL;
 	if(x==0.0) {
 	    /* log(0) */
-	    exc.type = SING;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
+	    errno = ERANGE;
+	    return -HUGE_VAL;
 	} else { 
 	    /* log(x<0) */
-	    exc.type = DOMAIN;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = EDOM;
-	    else if (!matherr(&exc)) {
-	       errno = EDOM;
-	    }
-            exc.retval = nan("");
+	    errno = EDOM;
+	    return nan("");
         }
-	if (exc.err != 0)
-           errno = exc.err;
-        return exc.retval; 
 #endif
 }
 
diff --git a/newlib/libm/math/w_log10.c b/newlib/libm/math/w_log10.c
index 3b436d5..69ef5f9 100644
--- a/newlib/libm/math/w_log10.c
+++ b/newlib/libm/math/w_log10.c
@@ -61,7 +61,6 @@ PORTABILITY
 	return __ieee754_log10(x);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_log10(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	if(x<=0.0) {
@@ -71,35 +70,15 @@ PORTABILITY
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.name = "log10";
-	    exc.err = 0;
-	    exc.arg1 = x;
-	    exc.arg2 = x;
-	    if (_LIB_VERSION == _SVID_)
-               exc.retval = -HUGE;
-	    else
-	       exc.retval = -HUGE_VAL;
 	    if(x==0.0) {
-	        /* log10(0) */
-	        exc.type = SING;
-	        if (_LIB_VERSION == _POSIX_)
-	           errno = ERANGE;
-	        else if (!matherr(&exc)) {
-	           errno = ERANGE;
-	        }
+		/* log10(0) */
+		errno = ERANGE;
+		return -HUGE_VAL;
 	    } else { 
-	        /* log10(x<0) */
-	        exc.type = DOMAIN;
-	        if (_LIB_VERSION == _POSIX_)
-	           errno = EDOM;
-	        else if (!matherr(&exc)) {
-	           errno = EDOM;
-	        }
-                exc.retval = nan("");
-            }
-	    if (exc.err != 0)
-               errno = exc.err;
-            return exc.retval; 
+		/* log10(x<0) */
+		errno = EDOM;
+		return nan("");
+	    }
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_pow.c b/newlib/libm/math/w_pow.c
index 9d1e396..e9ac370 100644
--- a/newlib/libm/math/w_pow.c
+++ b/newlib/libm/math/w_pow.c
@@ -42,8 +42,6 @@ RETURNS
 	is set to <<EDOM>>.  If <[x]> and <[y]> are both 0, then
 	<<pow>> and <<powf>> return <<1>>.
 
-	You can modify error handling for these functions using <<matherr>>.
-
 PORTABILITY
 	<<pow>> is ANSI C. <<powf>> is an extension.  */
 
@@ -74,134 +72,48 @@ PORTABILITY
 
 	SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	struct exception exc;
 	z=__ieee754_pow(x,y);
 	if(_LIB_VERSION == _IEEE_|| isnan(y)) return z;
 	if(isnan(x)) {
 	    if(y==0.0) { 
 		/* pow(NaN,0.0) */
-		/* error only if _LIB_VERSION == _SVID_ & _XOPEN_ */
-		exc.type = DOMAIN;
-		exc.name = "pow";
-		exc.err = 0;
-		exc.arg1 = x;
-		exc.arg2 = y;
-		exc.retval = 1.0;
-		if (_LIB_VERSION == _IEEE_ ||
-		    _LIB_VERSION == _POSIX_) exc.retval = 1.0;
-		else if (!matherr(&exc)) {
-			errno = EDOM;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-                return exc.retval; 
+		/* Not an error.  */
+                return 1.0;
 	    } else 
 		return z;
 	}
 	if(x==0.0){ 
 	    if(y==0.0) {
 		/* pow(0.0,0.0) */
-		/* error only if _LIB_VERSION == _SVID_ */
-		exc.type = DOMAIN;
-		exc.name = "pow";
-		exc.err = 0;
-		exc.arg1 = x;
-		exc.arg2 = y;
-		exc.retval = 0.0;
-		if (_LIB_VERSION != _SVID_) exc.retval = 1.0;
-		else if (!matherr(&exc)) {
-			errno = EDOM;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-                return exc.retval; 
+		/* Not an error.  */
+		return 1.0;
 	    }
-            if(finite(y)&&y<0.0) {
+	    if(finite(y)&&y<0.0) {
 		/* 0**neg */
-		exc.type = DOMAIN;
-		exc.name = "pow";
-		exc.err = 0;
-		exc.arg1 = x;
-		exc.arg2 = y;
-		if (_LIB_VERSION == _SVID_) 
-		  exc.retval = 0.0;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  errno = EDOM;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-                return exc.retval; 
-            } 
+		errno = EDOM;
+		return -HUGE_VAL;
+	    }
 	    return z;
 	}
 	if(!finite(z)) {
 	    if(finite(x)&&finite(y)) {
 	        if(isnan(z)) {
 		    /* neg**non-integral */
-		    exc.type = DOMAIN;
-		    exc.name = "pow";
-		    exc.err = 0;
-		    exc.arg1 = x;
-		    exc.arg2 = y;
-		    if (_LIB_VERSION == _SVID_) 
-		        exc.retval = 0.0;
-		    else 
-		        exc.retval = 0.0/0.0;	/* X/Open allow NaN */
-		    if (_LIB_VERSION == _POSIX_) 
-		        errno = EDOM;
-		    else if (!matherr(&exc)) {
-		        errno = EDOM;
-		    }
-	            if (exc.err != 0)
-	                errno = exc.err;
-                    return exc.retval; 
+		    errno = EDOM;
+		    return 0.0/0.0;
 	        } else {
 		    /* pow(x,y) overflow */
-		    exc.type = OVERFLOW;
-		    exc.name = "pow";
-		    exc.err = 0;
-		    exc.arg1 = x;
-		    exc.arg2 = y;
-		    if (_LIB_VERSION == _SVID_) {
-		       exc.retval = HUGE;
-		       y *= 0.5;
-		       if(x<0.0&&rint(y)!=y) exc.retval = -HUGE;
-		    } else {
-		       exc.retval = HUGE_VAL;
-                       y *= 0.5;
-		       if(x<0.0&&rint(y)!=y) exc.retval = -HUGE_VAL;
-		    }
-		    if (_LIB_VERSION == _POSIX_)
-		        errno = ERANGE;
-		    else if (!matherr(&exc)) {
-			errno = ERANGE;
-		    }
-	            if (exc.err != 0)
-	                errno = exc.err;
-                    return exc.retval; 
+		    errno = ERANGE;
+		    if(x<0.0&&rint(y)!=y)
+		      return -HUGE_VAL;
+		    return HUGE_VAL;
                 }
 	    }
 	} 
 	if(z==0.0&&finite(x)&&finite(y)) {
 	    /* pow(x,y) underflow */
-	    exc.type = UNDERFLOW;
-	    exc.name = "pow";
-	    exc.err = 0;
-	    exc.arg1 = x;
-	    exc.arg2 = y;
-	    exc.retval =  0.0;
-	    if (_LIB_VERSION == _POSIX_)
-	        errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	     	errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	        errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0;
         } 
 	return z;
 #endif
diff --git a/newlib/libm/math/w_remainder.c b/newlib/libm/math/w_remainder.c
index 5b13390..468e38a 100644
--- a/newlib/libm/math/w_remainder.c
+++ b/newlib/libm/math/w_remainder.c
@@ -57,25 +57,12 @@ PORTABILITY
 	return __ieee754_remainder(x,y);
 #else
 	double z;
-	struct exception exc;
 	z = __ieee754_remainder(x,y);
 	if(_LIB_VERSION == _IEEE_ || isnan(y)) return z;
 	if(y==0.0) { 
             /* remainder(x,0) */
-            exc.type = DOMAIN;
-            exc.name = "remainder";
-	    exc.err = 0;
-	    exc.arg1 = x;
-	    exc.arg2 = y;
-            exc.retval = 0.0/0.0;
-            if (_LIB_VERSION == _POSIX_)
-               errno = EDOM;
-            else if (!matherr(&exc)) {
-               errno = EDOM;
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = EDOM;
+	    return 0.0/0.0;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_scalb.c b/newlib/libm/math/w_scalb.c
index c324968..77fb2af 100644
--- a/newlib/libm/math/w_scalb.c
+++ b/newlib/libm/math/w_scalb.c
@@ -47,42 +47,17 @@
 
 	SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	struct exception exc;
 	z = __ieee754_scalb(x,fn);
 	if(_LIB_VERSION == _IEEE_) return z;
 	if(!(finite(z)||isnan(z))&&finite(x)) {
-	    /* scalb overflow; SVID also returns +-HUGE_VAL */
-	    exc.type = OVERFLOW;
-	    exc.name = "scalb";
-	    exc.err = 0;
-	    exc.arg1 = x;
-	    exc.arg2 = fn;
-	    exc.retval = x > 0.0 ? HUGE_VAL : -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval;
+	    /* scalb overflow */
+	    errno = ERANGE;
+	    return (x > 0.0 ? HUGE_VAL : -HUGE_VAL);
 	}
 	if(z==0.0&&z!=x) {
 	    /* scalb underflow */
-	    exc.type = UNDERFLOW;
-	    exc.name = "scalb";
-	    exc.err = 0;
-	    exc.arg1 = x;
-	    exc.arg2 = fn;
-	    exc.retval = copysign(0.0,x);
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return copysign(0.0,x);
 	} 
 #ifndef _SCALB_INT
 	if(!finite(fn)) errno = ERANGE;
diff --git a/newlib/libm/math/w_sinh.c b/newlib/libm/math/w_sinh.c
index 340a711..0e97e54 100644
--- a/newlib/libm/math/w_sinh.c
+++ b/newlib/libm/math/w_sinh.c
@@ -46,8 +46,6 @@ RETURNS
 	appropriate sign, and sets the global value <<errno>> to
 	<<ERANGE>>. 
 
-	You can modify error handling for these functions with <<matherr>>.
-
 PORTABILITY
 	<<sinh>> is ANSI C.  
 	<<sinhf>> is an extension.
@@ -77,7 +75,6 @@ QUICKREF
 	return __ieee754_sinh(x);
 #else
 	double z; 
-	struct exception exc;
 	z = __ieee754_sinh(x);
 	if(_LIB_VERSION == _IEEE_) return z;
 	if(!finite(z)&&finite(x)) {
@@ -88,22 +85,8 @@ QUICKREF
 	    
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = OVERFLOW;
-	    exc.name = "sinh";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = x;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = ( (x>0.0) ? HUGE : -HUGE);
-	    else
-	       exc.retval = ( (x>0.0) ? HUGE_VAL : -HUGE_VAL);
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval;
+	    errno = ERANGE;
+	    return ((x>0.0) ? HUGE_VAL : -HUGE_VAL);
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/w_sqrt.c b/newlib/libm/math/w_sqrt.c
index 61d42fc..36e9ad7 100644
--- a/newlib/libm/math/w_sqrt.c
+++ b/newlib/libm/math/w_sqrt.c
@@ -27,8 +27,6 @@ SYNOPSIS
 
 DESCRIPTION
 	<<sqrt>> computes the positive square root of the argument.
-	You can modify error handling for this function with
-	<<matherr>>.
 
 RETURNS
 	On success, the square root is returned. If <[x]> is real and
@@ -59,27 +57,12 @@ PORTABILITY
 #ifdef _IEEE_LIBM
 	return __ieee754_sqrt(x);
 #else
-	struct exception exc;
 	double z;
 	z = __ieee754_sqrt(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	if(x<0.0) {
-	  exc.type = DOMAIN;
-	  exc.name = "sqrt";
-	  exc.err = 0;
-	  exc.arg1 = exc.arg2 = x;
-	  if (_LIB_VERSION == _SVID_)
-	    exc.retval = 0.0;
-          else
-            exc.retval = 0.0/0.0;
-          if (_LIB_VERSION == _POSIX_)
-            errno = EDOM;
-          else if (!matherr(&exc)) {
-            errno = EDOM;
-          }
-          if (exc.err != 0)
-	    errno = exc.err;
-	  return exc.retval; 
+	    errno = EDOM;
+	    return 0.0/0.0;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_acos.c b/newlib/libm/math/wf_acos.c
index 8154c79..15d8699 100644
--- a/newlib/libm/math/wf_acos.c
+++ b/newlib/libm/math/wf_acos.c
@@ -26,24 +26,12 @@
 	return __ieee754_acosf(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_acosf(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
-	if(fabsf(x)>(float)1.0) {
+	if(fabsf(x)>1.0f) {
 	    /* acosf(|x|>1) */
-	    exc.type = DOMAIN;
-	    exc.name = "acosf";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-	    exc.retval = nan("");
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = EDOM;
-	    else if (!matherr(&exc)) {
-	       errno = EDOM;
-            }
-            if (exc.err != 0)
-	       errno = exc.err;
-	    return (float)exc.retval; 
+	    errno = EDOM;
+	    return (float) nan("");
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_acosh.c b/newlib/libm/math/wf_acosh.c
index fc8ec3a..6a8000f 100644
--- a/newlib/libm/math/wf_acosh.c
+++ b/newlib/libm/math/wf_acosh.c
@@ -32,24 +32,12 @@
 	return __ieee754_acoshf(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_acoshf(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
-	if(x<(float)1.0) {
-            /* acoshf(x<1) */
-            exc.type = DOMAIN;
-            exc.name = "acoshf";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            exc.retval = 0.0/0.0;
-            if (_LIB_VERSION == _POSIX_)
-               errno = EDOM;
-            else if (!matherr(&exc)) {
-               errno = EDOM;
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-	    return (float)exc.retval; 
+	if(x<1.0f) {
+	    /* acoshf(x<1) */
+	    errno = EDOM;
+	    return 0.0f/0.0f;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_asin.c b/newlib/libm/math/wf_asin.c
index 385de54..2f9ffaf 100644
--- a/newlib/libm/math/wf_asin.c
+++ b/newlib/libm/math/wf_asin.c
@@ -33,24 +33,12 @@
 	return __ieee754_asinf(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_asinf(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
-	if(fabsf(x)>(float)1.0) {
+	if(fabsf(x)>1.0f) {
 	    /* asinf(|x|>1) */
-	    exc.type = DOMAIN;
-	    exc.name = "asinf";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-	    exc.retval = nan("");
-	    if(_LIB_VERSION == _POSIX_)
-	      errno = EDOM;
-	    else if (!matherr(&exc)) {
-	      errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	      errno = exc.err;
-	    return (float)exc.retval; 
+	    errno = EDOM;
+	    return (float)nan("");
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_atanh.c b/newlib/libm/math/wf_atanh.c
index 5656304..31e0490 100644
--- a/newlib/libm/math/wf_atanh.c
+++ b/newlib/libm/math/wf_atanh.c
@@ -30,39 +30,19 @@
 	return __ieee754_atanhf(x);
 #else
 	float z,y;
-	struct exception exc;
 	z = __ieee754_atanhf(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	y = fabsf(x);
-	if(y>=(float)1.0) {
-	    if(y>(float)1.0) {
-                /* atanhf(|x|>1) */
-                exc.type = DOMAIN;
-                exc.name = "atanhf";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = (double)x;
-                exc.retval = 0.0/0.0;
-                if (_LIB_VERSION == _POSIX_)
-                  errno = EDOM;
-                else if (!matherr(&exc)) {
-                  errno = EDOM;
-                }
+	if(y>=1.0f) {
+	    if(y>1.0f) {
+		/* atanhf(|x|>1) */
+		errno = EDOM;
+		return 0.0f/0.0f;
 	    } else { 
-                /* atanhf(|x|=1) */
-                exc.type = SING;
-                exc.name = "atanhf";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = (double)x;
-		exc.retval = x/0.0;	/* sign(x)*inf */
-                if (_LIB_VERSION == _POSIX_)
-                  errno = EDOM;
-                else if (!matherr(&exc)) {
-                  errno = EDOM;
-                }
-            }
-	    if (exc.err != 0)
-              errno = exc.err;
-            return (float)exc.retval; 
+		/* atanhf(|x|=1) */
+		errno = EDOM;
+		return x/0.0f;	/* sign(x)*inf */
+	    }
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_cosh.c b/newlib/libm/math/wf_cosh.c
index 02eb124..1b507b0 100644
--- a/newlib/libm/math/wf_cosh.c
+++ b/newlib/libm/math/wf_cosh.c
@@ -31,10 +31,9 @@
 	return __ieee754_coshf(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_coshf(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
-	if(fabsf(x)>(float)8.9415985107e+01) {	
+	if(fabsf(x)>8.9415985107e+01f) {
 	    /* coshf(finite) overflow */
 #ifndef HUGE_VAL
 #define HUGE_VAL inf
@@ -42,22 +41,8 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = OVERFLOW;
-	    exc.name = "coshf";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = HUGE;
-	    else
-	       exc.retval = HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-	    return (float)exc.retval;
+	    errno = ERANGE;
+	    return (float)HUGE_VAL;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_exp.c b/newlib/libm/math/wf_exp.c
index f16af1d..af1800e 100644
--- a/newlib/libm/math/wf_exp.c
+++ b/newlib/libm/math/wf_exp.c
@@ -40,7 +40,6 @@ u_threshold= -1.0397208405e+02;  /* 0xc2cff1b5 */
 	return __ieee754_expf(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_expf(x);
 	if(_LIB_VERSION == _IEEE_) return z;
 	if(finitef(x)) {
@@ -52,37 +51,12 @@ u_threshold= -1.0397208405e+02;  /* 0xc2cff1b5 */
 
 	        SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-		exc.type = OVERFLOW;
-		exc.name = "expf";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = (double)x;
-		if (_LIB_VERSION == _SVID_)
-		  exc.retval = HUGE;
-		else
-		  exc.retval = HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-	        return exc.retval; 
+		errno = ERANGE;
+	        return HUGE_VAL;
 	    } else if(x<u_threshold) {
 		/* expf(finite) underflow */
-		exc.type = UNDERFLOW;
-		exc.name = "expf";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = (double)x;
-		exc.retval = 0.0;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-		else if (!matherr(&exc)) {
-			errno = ERANGE;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-	        return exc.retval; 
+		errno = ERANGE;
+		return 0.0f;
 	    } 
 	} 
 	return z;
diff --git a/newlib/libm/math/wf_fmod.c b/newlib/libm/math/wf_fmod.c
index 030ca3e..451318e 100644
--- a/newlib/libm/math/wf_fmod.c
+++ b/newlib/libm/math/wf_fmod.c
@@ -31,28 +31,12 @@
 	return __ieee754_fmodf(x,y);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_fmodf(x,y);
 	if(_LIB_VERSION == _IEEE_ ||isnan(y)||isnan(x)) return z;
-	if(y==(float)0.0) {
+	if(y==0.0f) {
             /* fmodf(x,0) */
-            exc.type = DOMAIN;
-            exc.name = "fmodf";
-	    exc.err = 0;
-	    exc.arg1 = (double)x;
-	    exc.arg2 = (double)y;
-            if (_LIB_VERSION == _SVID_)
-               exc.retval = x;
-	    else
-	       exc.retval = 0.0/0.0;
-            if (_LIB_VERSION == _POSIX_)
-               errno = EDOM;
-            else if (!matherr(&exc)) {
-                  errno = EDOM;
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	    errno = EDOM;
+	    return  0.0f/0.0f;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_gamma.c b/newlib/libm/math/wf_gamma.c
index 1204f39..aeaf394 100644
--- a/newlib/libm/math/wf_gamma.c
+++ b/newlib/libm/math/wf_gamma.c
@@ -29,7 +29,6 @@
 	return __ieee754_gammaf_r(x,&(_REENT_SIGNGAM(_REENT)));
 #else
         float y;
-	struct exception exc;
         y = __ieee754_gammaf_r(x,&(_REENT_SIGNGAM(_REENT)));
         if(_LIB_VERSION == _IEEE_) return y;
         if(!finitef(y)&&finitef(x)) {
@@ -39,40 +38,14 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    if(floorf(x)==x&&x<=(float)0.0) {
+	    if(floorf(x)==x&&x<=0.0f) {
 		/* gammaf(-integer) or gammaf(0) */
-		exc.type = SING;
-		exc.name = "gammaf";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = (double)x;
-                if (_LIB_VERSION == _SVID_)
-                  exc.retval = HUGE;
-                else
-                  exc.retval = HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  errno = EDOM;
-		}
+		errno = EDOM;
             } else {
 		/* gammaf(finite) overflow */
-		exc.type = OVERFLOW;
-		exc.name = "gammaf";
-		exc.err = 0;
-		exc.arg1 = exc.arg2 = (double)x;
-                if (_LIB_VERSION == _SVID_)
-                  exc.retval = HUGE;
-                else
-                  exc.retval = HUGE_VAL;
-                if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-                else if (!matherr(&exc)) {
-                  errno = ERANGE;
-                }
+		errno = ERANGE;
             }
-	    if (exc.err != 0)
-	       errno = exc.err;
-	    return (float)exc.retval; 
+	    return (float)HUGE_VAL;
         } else
             return y;
 #endif
diff --git a/newlib/libm/math/wf_hypot.c b/newlib/libm/math/wf_hypot.c
index c04ace1..7a2234c 100644
--- a/newlib/libm/math/wf_hypot.c
+++ b/newlib/libm/math/wf_hypot.c
@@ -31,7 +31,6 @@
 	return __ieee754_hypotf(x,y);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_hypotf(x,y);
 	if(_LIB_VERSION == _IEEE_) return z;
 	if((!finitef(z))&&finitef(x)&&finitef(y)) {
@@ -42,23 +41,8 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = OVERFLOW;
-	    exc.name = "hypotf";
-	    exc.err = 0;
-	    exc.arg1 = (double)x;
-	    exc.arg2 = (double)y;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = HUGE;
-	    else
-	       exc.retval = HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	     	errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval;
+	    errno = ERANGE;
+	    return (float)HUGE_VAL;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_j0.c b/newlib/libm/math/wf_j0.c
index 1f7f5ed..71ea421 100644
--- a/newlib/libm/math/wf_j0.c
+++ b/newlib/libm/math/wf_j0.c
@@ -30,24 +30,12 @@
 #ifdef _IEEE_LIBM
 	return __ieee754_j0f(x);
 #else
-	struct exception exc;
 	float z = __ieee754_j0f(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
 	if(fabsf(x)>(float)X_TLOSS) {
 	    /* j0f(|x|>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "j0f";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-               errno = ERANGE;
-            else if (!matherr(&exc)) {
-               errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	    errno = ERANGE;
+	    return 0.0f;
 	} else
 	    return z;
 #endif
@@ -64,7 +52,6 @@
 	return __ieee754_y0f(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_y0f(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
         if(x <= (float)0.0){
@@ -75,38 +62,13 @@
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
 	    /* y0f(0) = -inf  or y0f(x<0) = NaN */
-	    exc.type = DOMAIN;	/* should be SING for IEEE y0f(0) */
-	    exc.name = "y0f";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = -HUGE;
-	    else
-	       exc.retval = -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = EDOM;
-	    else if (!matherr(&exc)) {
-	       errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	    errno = EDOM;
+	    return (float)-HUGE_VAL;
         }
 	if(x>(float)X_TLOSS) {
 	    /* y0f(x>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "y0f";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-                errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	    errno = ERANGE;
+	    return 0.0f;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_j1.c b/newlib/libm/math/wf_j1.c
index b919628..01c9999 100644
--- a/newlib/libm/math/wf_j1.c
+++ b/newlib/libm/math/wf_j1.c
@@ -32,24 +32,12 @@
 	return __ieee754_j1f(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_j1f(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
 	if(fabsf(x)>(float)X_TLOSS) {
 	    /* j1f(|x|>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "j1f";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-                errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0f;
 	} else
 	    return z;
 #endif
@@ -66,10 +54,9 @@
 	return __ieee754_y1f(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_y1f(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
-        if(x <= (float)0.0){
+        if(x <= 0.0f){
 	    /* y1f(0) = -inf or y1f(x<0) = NaN */
 #ifndef HUGE_VAL 
 #define HUGE_VAL inf
@@ -77,38 +64,13 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = DOMAIN;	/* should be SING for IEEE */
-	    exc.name = "y1f";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = -HUGE;
-	    else
-	       exc.retval = -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = EDOM;
-	    else if (!matherr(&exc)) {
-	       errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval;              
+	    errno = EDOM;
+	    return (float)-HUGE_VAL;
         }
 	if(x>(float)X_TLOSS) {
 	    /* y1f(x>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "y1f";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-                errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	    errno = ERANGE;
+	    return 0.0f;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_jn.c b/newlib/libm/math/wf_jn.c
index 837b6b7..b418372 100644
--- a/newlib/libm/math/wf_jn.c
+++ b/newlib/libm/math/wf_jn.c
@@ -28,25 +28,12 @@
 	return __ieee754_jnf(n,x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_jnf(n,x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
 	if(fabsf(x)>(float)X_TLOSS) {
 	    /* jnf(|x|>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "jnf";
-	    exc.err = 0;
-	    exc.arg1 = (double)n;
-	    exc.arg2 = (double)x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-               errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0f;
 	} else
 	    return z;
 #endif
@@ -63,10 +50,9 @@
 	return __ieee754_ynf(n,x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_ynf(n,x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
-        if(x <= (float)0.0){
+        if(x <= 0.0f){
 	    /* ynf(n,0) = -inf or ynf(x<0) = NaN */
 #ifndef HUGE_VAL 
 #define HUGE_VAL inf
@@ -74,40 +60,13 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = DOMAIN;	/* should be SING for IEEE */
-	    exc.name = "ynf";
-	    exc.err = 0;
-	    exc.arg1 = (double)n;
-	    exc.arg2 = (double)x;
-	    if (_LIB_VERSION == _SVID_)
-	        exc.retval = -HUGE;
-	    else
-	        exc.retval = -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	        errno = EDOM;
-	    else if (!matherr(&exc)) {
-	        errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	    errno = EDOM;
+	    return (float)-HUGE_VAL;
         }
 	if(x>(float)X_TLOSS) {
 	    /* ynf(x>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "ynf";
-	    exc.err = 0;
-	    exc.arg1 = (double)n;
-	    exc.arg2 = (double)x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-                errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	    errno = ERANGE;
+	    return 0.0f;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_lgamma.c b/newlib/libm/math/wf_lgamma.c
index f1bf0c0..574111e 100644
--- a/newlib/libm/math/wf_lgamma.c
+++ b/newlib/libm/math/wf_lgamma.c
@@ -29,7 +29,6 @@
 	return __ieee754_lgammaf_r(x,&(_REENT_SIGNGAM(_REENT)));
 #else
         float y;
-	struct exception exc;
         y = __ieee754_lgammaf_r(x,&(_REENT_SIGNGAM(_REENT)));
         if(_LIB_VERSION == _IEEE_) return y;
         if(!finitef(y)&&finitef(x)) {
@@ -39,34 +38,14 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.name = "lgammaf";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            if (_LIB_VERSION == _SVID_)
-               exc.retval = HUGE;
-            else
-               exc.retval = HUGE_VAL;
-	    if(floorf(x)==x&&x<=(float)0.0) {
+	    if(floorf(x)==x&&x<=0.0f) {
 		/* lgammaf(-integer) */
-		exc.type = SING;
-		if (_LIB_VERSION == _POSIX_)
-		   errno = EDOM;
-		else if (!matherr(&exc)) {
-		   errno = EDOM;
-		}
-
-            } else {
+		errno = EDOM;
+	    } else {
 		/* lgammaf(finite) overflow */
-		exc.type = OVERFLOW;
-                if (_LIB_VERSION == _POSIX_)
-		   errno = ERANGE;
-                else if (!matherr(&exc)) {
-                   errno = ERANGE;
-		}
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+		errno = ERANGE;
+	    }
+            return (float)HUGE_VAL;
         } else
             return y;
 #endif
diff --git a/newlib/libm/math/wf_log.c b/newlib/libm/math/wf_log.c
index 07be8d6..24e6eeb 100644
--- a/newlib/libm/math/wf_log.c
+++ b/newlib/libm/math/wf_log.c
@@ -32,43 +32,23 @@
 	return __ieee754_logf(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_logf(x);
-	if(_LIB_VERSION == _IEEE_ || isnan(x) || x > (float)0.0) return z;
+	if(_LIB_VERSION == _IEEE_ || isnan(x) || x > 0.0f) return z;
 #ifndef HUGE_VAL 
 #define HUGE_VAL inf
 	double inf = 0.0;
 
 	SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	exc.name = "logf";
-	exc.err = 0;
-	exc.arg1 = exc.arg2 = (double)x;
-	if (_LIB_VERSION == _SVID_)
-           exc.retval = -HUGE;
-	else
-	   exc.retval = -HUGE_VAL;
-	if(x==(float)0.0) {
+	if(x==0.0f) {
 	    /* logf(0) */
-	    exc.type = SING;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
+	    errno = ERANGE;
+	    return (float)-HUGE_VAL;
 	} else { 
 	    /* logf(x<0) */
-	    exc.type = DOMAIN;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = EDOM;
-	    else if (!matherr(&exc)) {
-	       errno = EDOM;
-	    }
-            exc.retval = nan("");
+	    errno = EDOM;
+	    return nan("");
         }
-	if (exc.err != 0)
-           errno = exc.err;
-        return (float)exc.retval; 
 #endif
 }
 
diff --git a/newlib/libm/math/wf_log10.c b/newlib/libm/math/wf_log10.c
index 11c5956..3560c5c 100644
--- a/newlib/libm/math/wf_log10.c
+++ b/newlib/libm/math/wf_log10.c
@@ -31,44 +31,24 @@
 	return __ieee754_log10f(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_log10f(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
-	if(x<=(float)0.0) {
+	if(x<=0.0f) {
 #ifndef HUGE_VAL 
 #define HUGE_VAL inf
 	    double inf = 0.0;
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.name = "log10f";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-	    if (_LIB_VERSION == _SVID_)
-               exc.retval = -HUGE;
-	    else
-	       exc.retval = -HUGE_VAL;
-	    if(x==(float)0.0) {
-	        /* log10f(0) */
-	        exc.type = SING;
-	        if (_LIB_VERSION == _POSIX_)
-	           errno = ERANGE;
-	        else if (!matherr(&exc)) {
-	           errno = ERANGE;
-	        }
+	    if(x==0.0f) {
+		/* log10f(0) */
+		errno = ERANGE;
+		return (float)-HUGE_VAL;
 	    } else { 
-	        /* log10f(x<0) */
-	        exc.type = DOMAIN;
-	        if (_LIB_VERSION == _POSIX_)
-	           errno = EDOM;
-	        else if (!matherr(&exc)) {
-	           errno = EDOM;
-	        }
-                exc.retval = nan("");
+		/* log10f(x<0) */
+		errno = EDOM;
+		return nan("");
             }
-	    if (exc.err != 0)
-               errno = exc.err;
-            return (float)exc.retval; 
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_pow.c b/newlib/libm/math/wf_pow.c
index f753b52..2288977 100644
--- a/newlib/libm/math/wf_pow.c
+++ b/newlib/libm/math/wf_pow.c
@@ -32,136 +32,50 @@
 	return  __ieee754_powf(x,y);
 #else
 	float z;
-	struct exception exc;
 	z=__ieee754_powf(x,y);
 	if(_LIB_VERSION == _IEEE_|| isnan(y)) return z;
 	if(isnan(x)) {
-	    if(y==(float)0.0) { 
+	    if(y==0.0f) {
 		/* powf(NaN,0.0) */
-		/* error only if _LIB_VERSION == _SVID_ & _XOPEN_ */
-		exc.type = DOMAIN;
-		exc.name = "powf";
-		exc.err = 0;
-		exc.arg1 = (double)x;
-		exc.arg2 = (double)y;
-		exc.retval = 1.0;
-		if (_LIB_VERSION == _IEEE_ ||
-		    _LIB_VERSION == _POSIX_) exc.retval = 1.0;
-		else if (!matherr(&exc)) {
-			errno = EDOM;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-                return (float)exc.retval; 
+		/* Not an error.  */
+		return 1.0f;
 	    } else 
 		return z;
 	}
-	if(x==(float)0.0){ 
-	    if(y==(float)0.0) {
+	if(x==0.0f){
+	    if(y==0.0f) {
 		/* powf(0.0,0.0) */
-		/* error only if _LIB_VERSION == _SVID_ */
-		exc.type = DOMAIN;
-		exc.name = "powf";
-		exc.err = 0;
-		exc.arg1 = (double)x;
-		exc.arg2 = (double)y;
-		exc.retval = 0.0;
-		if (_LIB_VERSION != _SVID_) exc.retval = 1.0;
-		else if (!matherr(&exc)) {
-			errno = EDOM;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-                return (float)exc.retval; 
+		/* Not an error.  */
+		return 1.0f;
 	    }
-	    if(finitef(y)&&y<(float)0.0) {
+	    if(finitef(y)&&y<0.0f) {
 		/* 0**neg */
-		exc.type = DOMAIN;
-		exc.name = "powf";
-		exc.err = 0;
-		exc.arg1 = (double)x;
-		exc.arg2 = (double)y;
-		if (_LIB_VERSION == _SVID_) 
-		  exc.retval = 0.0;
-		else
-		  exc.retval = -HUGE_VAL;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  errno = EDOM;
-		}
-	        if (exc.err != 0)
-	           errno = exc.err;
-                return (float)exc.retval; 
-            }
+		errno = EDOM;
+		return (float)-HUGE_VAL;
+	    }
 	    return z;
 	}
 	if(!finitef(z)) {
 	    if(finitef(x)&&finitef(y)) {
-	        if(isnan(z)) {
+		if(isnan(z)) {
 		    /* neg**non-integral */
-		    exc.type = DOMAIN;
-		    exc.name = "powf";
-		    exc.err = 0;
-		    exc.arg1 = (double)x;
-		    exc.arg2 = (double)y;
-		    if (_LIB_VERSION == _SVID_) 
-		        exc.retval = 0.0;
-		    else 
-		        /* Use a float divide, to avoid a soft-float double
-			   divide call on single-float only targets.  */
-		        exc.retval = (0.0f/0.0f);	/* X/Open allow NaN */
-		    if (_LIB_VERSION == _POSIX_) 
-		        errno = EDOM;
-		    else if (!matherr(&exc)) {
-		        errno = EDOM;
-		    }
-	            if (exc.err != 0)
-	                errno = exc.err;
-                    return (float)exc.retval; 
-	        } else {
+		    errno = EDOM;
+		    /* Use a float divide, to avoid a soft-float double
+		       divide call on single-float only targets.  */
+		    return 0.0f/0.0f;
+		} else {
 		    /* powf(x,y) overflow */
-		    exc.type = OVERFLOW;
-		    exc.name = "powf";
-		    exc.err = 0;
-		    exc.arg1 = (double)x;
-		    exc.arg2 = (double)y;
-		    if (_LIB_VERSION == _SVID_) {
-		       exc.retval = HUGE;
-		       y *= 0.5;
-		       if(x<0.0f&&rintf(y)!=y) exc.retval = -HUGE;
-		    } else {
-		       exc.retval = HUGE_VAL;
-                       y *= 0.5;
-		       if(x<0.0f&&rintf(y)!=y) exc.retval = -HUGE_VAL;
-		    }
-		    if (_LIB_VERSION == _POSIX_)
-		        errno = ERANGE;
-		    else if (!matherr(&exc)) {
-			errno = ERANGE;
-		    }
-	            if (exc.err != 0)
-	                errno = exc.err;
-                    return (float)exc.retval; 
-                }
+		    errno = ERANGE;
+		    if(x<0.0f&&rintf(y)!=y)
+		      return (float)-HUGE_VAL;
+		    return (float)HUGE_VAL;
+		}
 	    }
 	} 
-	if(z==(float)0.0&&finitef(x)&&finitef(y)) {
+	if(z==0.0f&&finitef(x)&&finitef(y)) {
 	    /* powf(x,y) underflow */
-	    exc.type = UNDERFLOW;
-	    exc.name = "powf";
-	    exc.err = 0;
-	    exc.arg1 = (double)x;
-	    exc.arg2 = (double)y;
-	    exc.retval =  0.0;
-	    if (_LIB_VERSION == _POSIX_)
-	        errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	     	errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	        errno = exc.err;
-            return (float)exc.retval; 
+	    errno = ERANGE;
+	    return 0.0f;
         }
 	return z;
 #endif
diff --git a/newlib/libm/math/wf_remainder.c b/newlib/libm/math/wf_remainder.c
index f38c237..463d1bc 100644
--- a/newlib/libm/math/wf_remainder.c
+++ b/newlib/libm/math/wf_remainder.c
@@ -31,25 +31,12 @@
 	return __ieee754_remainderf(x,y);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_remainderf(x,y);
 	if(_LIB_VERSION == _IEEE_ || isnan(y)) return z;
-	if(y==(float)0.0) { 
-            /* remainderf(x,0) */
-            exc.type = DOMAIN;
-            exc.name = "remainderf";
-	    exc.err = 0;
-	    exc.arg1 = (double)x;
-	    exc.arg2 = (double)y;
-            exc.retval = 0.0/0.0;
-            if (_LIB_VERSION == _POSIX_)
-               errno = EDOM;
-            else if (!matherr(&exc)) {
-               errno = EDOM;
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	if(y==0.0f) {
+	    /* remainderf(x,0) */
+	    errno = EDOM;
+	    return 0.0f/0.0f;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_scalb.c b/newlib/libm/math/wf_scalb.c
index d2c3cd2..acdf8a8 100644
--- a/newlib/libm/math/wf_scalb.c
+++ b/newlib/libm/math/wf_scalb.c
@@ -47,42 +47,17 @@
 
 	SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	struct exception exc;
 	z = __ieee754_scalbf(x,fn);
 	if(_LIB_VERSION == _IEEE_) return z;
 	if(!(finitef(z)||isnan(z))&&finitef(x)) {
-	    /* scalbf overflow; SVID also returns +-HUGE_VAL */
-	    exc.type = OVERFLOW;
-	    exc.name = "scalbf";
-	    exc.err = 0;
-	    exc.arg1 = (double)x;
-	    exc.arg2 = (double)fn;
-	    exc.retval = x > 0.0 ? HUGE_VAL : -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval;
+	    /* scalbf overflow; */
+	    errno = ERANGE;
+	    return (x > 0.0 ? HUGE_VAL : -HUGE_VAL);
 	}
-	if(z==(float)0.0&&z!=x) {
+	if(z==0.0f&&z!=x) {
 	    /* scalbf underflow */
-	    exc.type = UNDERFLOW;
-	    exc.name = "scalbf";
-	    exc.err = 0;
-	    exc.arg1 = (double)x;
-	    exc.arg2 = (double)fn;
-	    exc.retval = copysign(0.0,x);
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return copysign(0.0,x);
 	} 
 #ifndef _SCALB_INT
 	if(!finitef(fn)) errno = ERANGE;
diff --git a/newlib/libm/math/wf_sinh.c b/newlib/libm/math/wf_sinh.c
index 80c7a8e..f7d5a96 100644
--- a/newlib/libm/math/wf_sinh.c
+++ b/newlib/libm/math/wf_sinh.c
@@ -31,7 +31,6 @@
 	return __ieee754_sinhf(x);
 #else
 	float z; 
-	struct exception exc;
 	z = __ieee754_sinhf(x);
 	if(_LIB_VERSION == _IEEE_) return z;
 	if(!finitef(z)&&finitef(x)) {
@@ -42,22 +41,8 @@
 	    
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = OVERFLOW;
-	    exc.name = "sinhf";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-	    if (_LIB_VERSION == _SVID_)
-	       exc.retval = ( (x>0.0) ? HUGE : -HUGE);
-	    else
-	       exc.retval = ( (x>0.0) ? HUGE_VAL : -HUGE_VAL);
-	    if (_LIB_VERSION == _POSIX_)
-	       errno = ERANGE;
-	    else if (!matherr(&exc)) {
-	       errno = ERANGE;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval;
+	    errno = ERANGE;
+	    return ( (x>0.0f) ? HUGE_VAL : -HUGE_VAL);
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wf_sqrt.c b/newlib/libm/math/wf_sqrt.c
index 4536ba0..4107511 100644
--- a/newlib/libm/math/wf_sqrt.c
+++ b/newlib/libm/math/wf_sqrt.c
@@ -31,27 +31,12 @@
 	return __ieee754_sqrtf(x);
 #else
 	float z;
-	struct exception exc;
 	z = __ieee754_sqrtf(x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x)) return z;
-	if(x<(float)0.0) {
-            /* sqrtf(negative) */
-            exc.type = DOMAIN;
-            exc.name = "sqrtf";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            if (_LIB_VERSION == _SVID_)
-              exc.retval = 0.0;
-            else
-              exc.retval = 0.0/0.0;
-            if (_LIB_VERSION == _POSIX_) 
-              errno = EDOM;
-            else if (!matherr(&exc)) {
-              errno = EDOM;
-            }
-            if (exc.err != 0)
-	      errno = exc.err;
-	    return (float)exc.retval; 
+	if(x<0.0f) {
+	    /* sqrtf(negative) */
+	    errno = EDOM;
+	    return 0.0f/0.0f;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/math/wr_gamma.c b/newlib/libm/math/wr_gamma.c
index 0092ed0..f07908c 100644
--- a/newlib/libm/math/wr_gamma.c
+++ b/newlib/libm/math/wr_gamma.c
@@ -31,7 +31,6 @@
 	return __ieee754_gamma_r(x,signgamp);
 #else
         double y;
-	struct exception exc;
         y = __ieee754_gamma_r(x,signgamp);
         if(_LIB_VERSION == _IEEE_) return y;
         if(!finite(y)&&finite(x)) {
@@ -41,33 +40,13 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.name = "gamma";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            if (_LIB_VERSION == _SVID_)
-                exc.retval = HUGE;
-            else
-                exc.retval = HUGE_VAL;
-            if(floor(x)==x&&x<=0.0) {
-		/* gamma(-integer) or gamma(0) */
-		exc.type = SING;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  errno = EDOM;
-		}
-            } else {
-		/* gamma(finite) overflow */
-		exc.type = OVERFLOW;
-                if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-                else if (!matherr(&exc)) {
-                  errno = ERANGE;
-                }
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-	    return exc.retval; 
+	    if(floor(x)==x&&x<=0.0)
+	      /* gamma(-integer) or gamma(0) */
+	      errno = EDOM;
+	    else
+	      /* gamma(finite) overflow */
+	      errno = ERANGE;
+	    return HUGE_VAL;
         } else
             return y;
 #endif
diff --git a/newlib/libm/math/wr_lgamma.c b/newlib/libm/math/wr_lgamma.c
index c59c1cc..8a32a59 100644
--- a/newlib/libm/math/wr_lgamma.c
+++ b/newlib/libm/math/wr_lgamma.c
@@ -31,7 +31,6 @@
 	return __ieee754_lgamma_r(x,signgamp);
 #else
         double y;
-	struct exception exc;
         y = __ieee754_lgamma_r(x,signgamp);
         if(_LIB_VERSION == _IEEE_) return y;
         if(!finite(y)&&finite(x)) {
@@ -41,34 +40,13 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.name = "lgamma";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            if (_LIB_VERSION == _SVID_)
-               exc.retval = HUGE;
-            else
-               exc.retval = HUGE_VAL;
-	    if(floor(x)==x&&x<=0.0) {
-		/* lgamma(-integer) */
-		exc.type = SING;
-		if (_LIB_VERSION == _POSIX_)
-		   errno = EDOM;
-		else if (!matherr(&exc)) {
-		   errno = EDOM;
-		}
-
-            } else {
-		/* lgamma(finite) overflow */
-		exc.type = OVERFLOW;
-                if (_LIB_VERSION == _POSIX_)
-		   errno = ERANGE;
-                else if (!matherr(&exc)) {
-                   errno = ERANGE;
-		}
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    if(floor(x)==x&&x<=0.0)
+	      /* lgamma(-integer) */
+	      errno = EDOM;
+	    else
+	      /* lgamma(finite) overflow */
+	      errno = ERANGE;
+	    return HUGE_VAL;
         } else
             return y;
 #endif
diff --git a/newlib/libm/math/wrf_gamma.c b/newlib/libm/math/wrf_gamma.c
index ae285f5..625ea47 100644
--- a/newlib/libm/math/wrf_gamma.c
+++ b/newlib/libm/math/wrf_gamma.c
@@ -31,7 +31,6 @@
 	return __ieee754_gammaf_r(x,signgamp);
 #else
         float y;
-	struct exception exc;
         y = __ieee754_gammaf_r(x,signgamp);
         if(_LIB_VERSION == _IEEE_) return y;
         if(!finitef(y)&&finitef(x)) {
@@ -41,33 +40,14 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.name = "gammaf";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            if (_LIB_VERSION == _SVID_)
-                exc.retval = HUGE;
-            else
-                exc.retval = HUGE_VAL;
-            if(floorf(x)==x&&x<=(float)0.0) {
+	    if(floorf(x)==x&&x<=0.0f) {
 		/* gammaf(-integer) or gamma(0) */
-		exc.type = SING;
-		if (_LIB_VERSION == _POSIX_)
-		  errno = EDOM;
-		else if (!matherr(&exc)) {
-		  errno = EDOM;
-		}
-            } else {
+		errno = EDOM;
+	    } else {
 		/* gammaf(finite) overflow */
-		exc.type = OVERFLOW;
-                if (_LIB_VERSION == _POSIX_)
-		  errno = ERANGE;
-                else if (!matherr(&exc)) {
-                  errno = ERANGE;
-                }
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-	    return (float)exc.retval; 
+		errno = ERANGE;
+	    }
+	    return (float)HUGE_VAL;
         } else
             return y;
 #endif
diff --git a/newlib/libm/math/wrf_lgamma.c b/newlib/libm/math/wrf_lgamma.c
index 73985e2..e91bffb 100644
--- a/newlib/libm/math/wrf_lgamma.c
+++ b/newlib/libm/math/wrf_lgamma.c
@@ -31,7 +31,6 @@
 	return __ieee754_lgammaf_r(x,signgamp);
 #else
         float y;
-	struct exception exc;
         y = __ieee754_lgammaf_r(x,signgamp);
         if(_LIB_VERSION == _IEEE_) return y;
         if(!finitef(y)&&finitef(x)) {
@@ -41,34 +40,14 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.name = "lgammaf";
-	    exc.err = 0;
-	    exc.arg1 = exc.arg2 = (double)x;
-            if (_LIB_VERSION == _SVID_)
-               exc.retval = HUGE;
-            else
-               exc.retval = HUGE_VAL;
-	    if(floorf(x)==x&&x<=(float)0.0) {
+	    if(floorf(x)==x&&x<=0.0f) {
 		/* lgammaf(-integer) or lgamma(0) */
-		exc.type = SING;
-		if (_LIB_VERSION == _POSIX_)
-		   errno = EDOM;
-		else if (!matherr(&exc)) {
-		   errno = EDOM;
-		}
-
-            } else {
+		errno = EDOM;
+	    } else {
 		/* lgammaf(finite) overflow */
-		exc.type = OVERFLOW;
-                if (_LIB_VERSION == _POSIX_)
-		   errno = ERANGE;
-                else if (!matherr(&exc)) {
-                   errno = ERANGE;
-		}
-            }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+		errno = ERANGE;
+	    }
+	    return (float)HUGE_VAL;
         } else
             return y;
 #endif
diff --git a/newlib/libm/mathfp/e_acosh.c b/newlib/libm/mathfp/e_acosh.c
index 0ad0f06..1146b1d 100644
--- a/newlib/libm/mathfp/e_acosh.c
+++ b/newlib/libm/mathfp/e_acosh.c
@@ -33,18 +33,15 @@ RETURNS
 <<acosh>> and <<acoshf>> return the calculated value.  If <[x]>
 less than 1, the return value is NaN and <<errno>> is set to <<EDOM>>.
 
-You can change the error-handling behavior with the non-ANSI
-<<matherr>> function.
-
 PORTABILITY
 Neither <<acosh>> nor <<acoshf>> are ANSI C.  They are not recommended
 for portable programs.
 
 
 QUICKREF
- ansi svid posix rentrant
- acos    n,n,n,m
- acosf   n,n,n,m
+ ansi posix rentrant
+ acos    n,n,m
+ acosf   n,n,m
 
 MATHREF
  acosh, NAN,   arg,DOMAIN,EDOM
diff --git a/newlib/libm/mathfp/e_atanh.c b/newlib/libm/mathfp/e_atanh.c
index 072c446..d56d502 100644
--- a/newlib/libm/mathfp/e_atanh.c
+++ b/newlib/libm/mathfp/e_atanh.c
@@ -55,9 +55,6 @@ RETURNS
         is 1, the global <<errno>> is set to <<EDOM>>; and the result is
         infinity with the same sign as <<x>>.  A <<SING error>> is reported.
 
-        You can modify the error handling for these routines using
-        <<matherr>>.
-
 PORTABILITY
         Neither <<atanh>> nor <<atanhf>> are ANSI C.
 
diff --git a/newlib/libm/mathfp/e_hypot.c b/newlib/libm/mathfp/e_hypot.c
index 1a59afc..2729eeb 100644
--- a/newlib/libm/mathfp/e_hypot.c
+++ b/newlib/libm/mathfp/e_hypot.c
@@ -41,8 +41,6 @@ RETURNS
         <<hypot>> returns <<HUGE_VAL>> and sets <<errno>> to
         <<ERANGE>>.
 
-        You can change the error treatment with <<matherr>>.
-
 PORTABILITY
         <<hypot>> and <<hypotf>> are not ANSI C.  */
 
diff --git a/newlib/libm/mathfp/er_lgamma.c b/newlib/libm/mathfp/er_lgamma.c
index 915dac7..cb0f2c2 100644
--- a/newlib/libm/mathfp/er_lgamma.c
+++ b/newlib/libm/mathfp/er_lgamma.c
@@ -97,8 +97,6 @@ When <[x]> is a nonpositive integer, <<gamma>> returns <<HUGE_VAL>>
 and <<errno>> is set to <<EDOM>>.  If the result overflows, <<gamma>>
 returns <<HUGE_VAL>> and <<errno>> is set to <<ERANGE>>.
 
-You can modify this error treatment using <<matherr>>.
-
 PORTABILITY
 Neither <<gamma>> nor <<gammaf>> is ANSI C.  */
 
diff --git a/newlib/libm/mathfp/s_acos.c b/newlib/libm/mathfp/s_acos.c
index d0318e1..d43b45c 100644
--- a/newlib/libm/mathfp/s_acos.c
+++ b/newlib/libm/mathfp/s_acos.c
@@ -37,13 +37,10 @@ o $\pi$.
         (not a number) the global variable <<errno>> is set to <<EDOM>>, and a
         <<DOMAIN error>> message is sent as standard error output.
 
-        You can modify error handling for these functions using <<matherr>>.
-
-
 QUICKREF
- ansi svid posix rentrant
- acos    y,y,y,m
- acosf   n,n,n,m
+ ansi posix rentrant
+ acos    y,y,m
+ acosf   n,n,m
 
 MATHREF
  acos, [-1,1], acos(arg),,,
diff --git a/newlib/libm/mathfp/s_atan2.c b/newlib/libm/mathfp/s_atan2.c
index 3952539..d8ba3a2 100644
--- a/newlib/libm/mathfp/s_atan2.c
+++ b/newlib/libm/mathfp/s_atan2.c
@@ -41,8 +41,6 @@ $-\pi$ to $\pi$.
 
 If both <[x]> and <[y]> are 0.0, <<atan2>> causes a <<DOMAIN>> error.
 
-You can modify error handling for these functions using <<matherr>>.
-
 PORTABILITY
 <<atan2>> is ANSI C.  <<atan2f>> is an extension.
 
diff --git a/newlib/libm/mathfp/s_cosh.c b/newlib/libm/mathfp/s_cosh.c
index bfe6650..9d6f8d1 100644
--- a/newlib/libm/mathfp/s_cosh.c
+++ b/newlib/libm/mathfp/s_cosh.c
@@ -31,9 +31,6 @@ RETURNS
         an overflow,  <<cosh>> returns the value <<HUGE_VAL>> with the
         appropriate sign, and the global value <<errno>> is set to <<ERANGE>>.
 
-        You can modify error handling for these functions using the
-        function <<matherr>>.
-
 PORTABILITY
         <<cosh>> is ANSI.
         <<coshf>> is an extension.
diff --git a/newlib/libm/mathfp/s_fmod.c b/newlib/libm/mathfp/s_fmod.c
index d878f00..4197ea8 100644
--- a/newlib/libm/mathfp/s_fmod.c
+++ b/newlib/libm/mathfp/s_fmod.c
@@ -43,8 +43,6 @@ magnitude of <[y]>.
 
 <<fmod(<[x]>,0)>> returns NaN, and sets <<errno>> to <<EDOM>>.
 
-You can modify error treatment for these functions using <<matherr>>.
-
 PORTABILITY
 <<fmod>> is ANSI C. <<fmodf>> is an extension.
 */
diff --git a/newlib/libm/mathfp/s_logarithm.c b/newlib/libm/mathfp/s_logarithm.c
index e8c2420..b9ec637 100644
--- a/newlib/libm/mathfp/s_logarithm.c
+++ b/newlib/libm/mathfp/s_logarithm.c
@@ -38,8 +38,7 @@ RETURNS
 Normally, returns the calculated value.  When <[x]> is zero, the
 returned value is <<-HUGE_VAL>> and <<errno>> is set to <<ERANGE>>.
 When <[x]> is negative, the returned value is <<-HUGE_VAL>> and
-<<errno>> is set to <<EDOM>>.  You can control the error behavior via
-<<matherr>>.
+<<errno>> is set to <<EDOM>>.
 
 PORTABILITY
 <<log>> is ANSI. <<logf>> is an extension.
diff --git a/newlib/libm/mathfp/s_pow.c b/newlib/libm/mathfp/s_pow.c
index 5866dcd..4754cf0 100644
--- a/newlib/libm/mathfp/s_pow.c
+++ b/newlib/libm/mathfp/s_pow.c
@@ -31,8 +31,6 @@ RETURNS
         is set to <<EDOM>>.  If <[x]> and <[y]> are both 0, then
         <<pow>> and <<powf>> return <<1>>.
 
-        You can modify error handling for these functions using <<matherr>>.
-
 PORTABILITY
         <<pow>> is ANSI C. <<powf>> is an extension.  */
 
diff --git a/newlib/libm/mathfp/w_jn.c b/newlib/libm/mathfp/w_jn.c
index 71ea4a0..15b9412 100644
--- a/newlib/libm/mathfp/w_jn.c
+++ b/newlib/libm/mathfp/w_jn.c
@@ -127,25 +127,12 @@ None of the Bessel functions are in ANSI C.
 	return jn(n,x);
 #else
 	double z;
-	struct exception exc;
 	z = jn(n,x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
 	if(fabs(x)>X_TLOSS) {
 	    /* jn(|x|>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "jn";
-	    exc.err = 0;
-	    exc.arg1 = n;
-	    exc.arg2 = x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-               errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0;
 	} else
 	    return z;
 #endif
@@ -162,7 +149,6 @@ None of the Bessel functions are in ANSI C.
 	return yn(n,x);
 #else
 	double z;
-	struct exception exc;
 	z = yn(n,x);
 	if(_LIB_VERSION == _IEEE_ || isnan(x) ) return z;
         if(x <= 0.0){
@@ -173,40 +159,13 @@ None of the Bessel functions are in ANSI C.
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = DOMAIN;	/* should be SING for IEEE */
-	    exc.name = "yn";
-	    exc.err = 0;
-	    exc.arg1 = n;
-	    exc.arg2 = x;
-	    if (_LIB_VERSION == _SVID_)
-	        exc.retval = -HUGE;
-	    else
-	        exc.retval = -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	        errno = EDOM;
-	    else if (!matherr(&exc)) {
-	        errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = EDOM;
+	    return -HUGE_VAL;
         }
 	if(x>X_TLOSS) {
 	    /* yn(x>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "yn";
-	    exc.err = 0;
-	    exc.arg1 = n;
-	    exc.arg2 = x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-                errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/mathfp/wf_jn.c b/newlib/libm/mathfp/wf_jn.c
index ebc886d..5260274 100644
--- a/newlib/libm/mathfp/wf_jn.c
+++ b/newlib/libm/mathfp/wf_jn.c
@@ -28,25 +28,12 @@
 	return jnf(n,x);
 #else
 	float z;
-	struct exception exc;
 	z = jnf(n,x);
 	if(_LIB_VERSION == _IEEE_ || isnanf(x) ) return z;
 	if(fabsf(x)>(float)X_TLOSS) {
 	    /* jnf(|x|>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "jnf";
-	    exc.err = 0;
-	    exc.arg1 = (double)n;
-	    exc.arg2 = (double)x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-               errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return exc.retval; 
+	    errno = ERANGE;
+	    return 0.0f;
 	} else
 	    return z;
 #endif
@@ -63,10 +50,9 @@
 	return ynf(n,x);
 #else
 	float z;
-	struct exception exc;
 	z = ynf(n,x);
 	if(_LIB_VERSION == _IEEE_ || isnanf(x) ) return z;
-        if(x <= (float)0.0){
+        if(x <= 0.0f){
 	    /* ynf(n,0) = -inf or ynf(x<0) = NaN */
 #ifndef HUGE_VAL 
 #define HUGE_VAL inf
@@ -74,40 +60,13 @@
 
 	    SET_HIGH_WORD(inf,0x7ff00000);	/* set inf to infinite */
 #endif
-	    exc.type = DOMAIN;	/* should be SING for IEEE */
-	    exc.name = "ynf";
-	    exc.err = 0;
-	    exc.arg1 = (double)n;
-	    exc.arg2 = (double)x;
-	    if (_LIB_VERSION == _SVID_)
-	        exc.retval = -HUGE;
-	    else
-	        exc.retval = -HUGE_VAL;
-	    if (_LIB_VERSION == _POSIX_)
-	        errno = EDOM;
-	    else if (!matherr(&exc)) {
-	        errno = EDOM;
-	    }
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	    errno = EDOM;
+	    return (float)-HUGE_VAL;
         }
 	if(x>(float)X_TLOSS) {
 	    /* ynf(x>X_TLOSS) */
-            exc.type = TLOSS;
-            exc.name = "ynf";
-	    exc.err = 0;
-	    exc.arg1 = (double)n;
-	    exc.arg2 = (double)x;
-            exc.retval = 0.0;
-            if (_LIB_VERSION == _POSIX_)
-                errno = ERANGE;
-            else if (!matherr(&exc)) {
-                errno = ERANGE;
-            }        
-	    if (exc.err != 0)
-	       errno = exc.err;
-            return (float)exc.retval; 
+	    errno = ERANGE;
+	    return 0.0f;
 	} else
 	    return z;
 #endif
diff --git a/newlib/libm/test/math.c b/newlib/libm/test/math.c
index 0a6389a..cd8441c 100644
--- a/newlib/libm/test/math.c
+++ b/newlib/libm/test/math.c
@@ -33,22 +33,6 @@ char *mname;
 
 int verbose;
 
-/* To test exceptions - we trap them all and return a known value */
-int
-matherr (struct exception *e)
-{
-  if (traperror) 
-  {
-    merror = e->type + 12;
-    mname = e->name;
-    e->retval = mretval;
-    errno = merror + 24;
-    return 1;
-  }
-  return 0;
-}
-
-
 void translate_to (FILE *file,
 	    double r)
 {
@@ -90,6 +74,7 @@ ffcheck (double is,
 #if 0
   if (p->qs[0].merror != merror) 
   {
+    /* Beware, matherr doesn't exist anymore.  */
     printf("testing %s_vec.c:%d, matherr wrong: %d %d\n",
 	   name, p->line, merror, p->qs[0].merror);
   }
diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index d1d9555..0e7fdfb 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -907,7 +907,6 @@ malloc_stats SIGFE
 malloc_trim SIGFE
 malloc_usable_size SIGFE
 mallopt SIGFE
-matherr NOSIGFE
 mblen NOSIGFE
 mbrlen NOSIGFE
 mbrtowc NOSIGFE
diff --git a/winsup/cygwin/i686.din b/winsup/cygwin/i686.din
index 934243b..174e73d 100644
--- a/winsup/cygwin/i686.din
+++ b/winsup/cygwin/i686.din
@@ -366,7 +366,6 @@ _lseek64 = lseek64 SIGFE
 _lstat = lstat SIGFE
 _lstat64 = lstat64 SIGFE
 _malloc = malloc SIGFE
-_matherr = matherr NOSIGFE
 _mblen = mblen NOSIGFE
 _mbstowcs = mbstowcs NOSIGFE
 _mbtowc = mbtowc NOSIGFE
diff --git a/winsup/cygwin/math/acosh.def.h b/winsup/cygwin/math/acosh.def.h
index c039bd8..1fc5deb 100644
--- a/winsup/cygwin/math/acosh.def.h
+++ b/winsup/cygwin/math/acosh.def.h
@@ -52,12 +52,12 @@ __FLT_ABI(acosh) (__FLT_TYPE x)
   int x_class = fpclassify (x);
   if (x_class == FP_NAN || x < __FLT_CST(1.0))
     {
-      __FLT_RPT_DOMAIN ("acosh", x, 0.0, __FLT_NAN);
+      errno = EDOM;
       return __FLT_NAN;
     }
   else if (x_class == FP_INFINITE)
     {
-      __FLT_RPT_DOMAIN ("acosh", x, 0.0, __FLT_NAN);
+      errno = EDOM;
       return __FLT_NAN;
     }
 
diff --git a/winsup/cygwin/math/complex_internal.h b/winsup/cygwin/math/complex_internal.h
index b230b15..83b17b0 100644
--- a/winsup/cygwin/math/complex_internal.h
+++ b/winsup/cygwin/math/complex_internal.h
@@ -120,34 +120,3 @@
 #else
 # error "Unknown complex number type"
 #endif
-
-#define __FLT_RPT_DOMAIN(NAME, ARG1, ARG2, RSLT) \
-	errno = EDOM, \
-	__mingw_raise_matherr (_DOMAIN, __FLT_REPORT(NAME), (double) (ARG1), \
-			       (double) (ARG2), (double) (RSLT))
-#define __FLT_RPT_ERANGE(NAME, ARG1, ARG2, RSLT, OVL) \
-	errno = ERANGE, \
-        __mingw_raise_matherr (((OVL) ? _OVERFLOW : _UNDERFLOW), \
-			       __FLT_REPORT(NAME), (double) (ARG1), \
-                               (double) (ARG2), (double) (RSLT))
-
-#ifdef __CYGWIN__
-inline void __attribute__ ((always_inline))
-__mingw_raise_matherr (int typ, const char *name, double a1, double a2,
-		       double rslt)
-{
-  if (_LIB_VERSION != _POSIX_)
-    {
-      struct exception ex;
-      ex.type = typ;
-      ex.name = (char*)name;
-      ex.arg1 = a1;
-      ex.arg2 = a2;
-      ex.retval = rslt;
-      matherr(&ex);
-    }
-}
-#define _DOMAIN		DOMAIN
-#define _OVERFLOW	OVERFLOW
-#define _UNDERFLOW	UNDERFLOW
-#endif
diff --git a/winsup/cygwin/math/cos.def.h b/winsup/cygwin/math/cos.def.h
index 1058d03..cbb226e 100644
--- a/winsup/cygwin/math/cos.def.h
+++ b/winsup/cygwin/math/cos.def.h
@@ -53,12 +53,12 @@ __FLT_ABI(cos) (__FLT_TYPE x)
   int x_class = fpclassify (x);
   if (x_class == FP_NAN)
     {
-      __FLT_RPT_DOMAIN ("cos", x, 0.0, x);
+      errno = EDOM;
       return x;
     }
   else if (x_class == FP_INFINITE)
     {
-      __FLT_RPT_DOMAIN ("cos", x, 0.0, __FLT_NAN);
+      errno = EDOM;
       return __FLT_NAN;
     }
   return (__FLT_TYPE) __cosl_internal ((long double) x);
diff --git a/winsup/cygwin/math/exp.def.h b/winsup/cygwin/math/exp.def.h
index 2419ef6..678e7c1 100644
--- a/winsup/cygwin/math/exp.def.h
+++ b/winsup/cygwin/math/exp.def.h
@@ -109,13 +109,13 @@ __FLT_ABI(exp) (__FLT_TYPE x)
   int x_class = fpclassify (x);
   if (x_class == FP_NAN)
     {
-      __FLT_RPT_DOMAIN ("exp", x, 0.0, x);
+      errno = EDOM;
       return x;
     }
   else if (x_class == FP_INFINITE)
     {
       __FLT_TYPE r = (signbit (x) ? __FLT_CST (0.0) : __FLT_HUGE_VAL);
-      __FLT_RPT_ERANGE ("exp", x, 0.0, r, signbit (x));
+      errno = ERANGE;
       return r;
     }
   else if (x_class == FP_ZERO)
@@ -124,7 +124,7 @@ __FLT_ABI(exp) (__FLT_TYPE x)
     }
   else if (x > __FLT_MAXLOG)
     {
-      __FLT_RPT_ERANGE ("exp", x, 0.0, __FLT_HUGE_VAL, 1);
+      errno = ERANGE;
       return __FLT_HUGE_VAL;
     }
   else if (x < __FLT_MINLOG)
diff --git a/winsup/cygwin/math/expm1.def.h b/winsup/cygwin/math/expm1.def.h
index 5a2b6f4..64fe428 100644
--- a/winsup/cygwin/math/expm1.def.h
+++ b/winsup/cygwin/math/expm1.def.h
@@ -51,7 +51,7 @@ __FLT_ABI(expm1) (__FLT_TYPE x)
   int x_class = fpclassify (x);
   if (x_class == FP_NAN)
   {
-    __FLT_RPT_DOMAIN ("expm1", x, 0.0, x);
+    errno = EDOM;
     return x;
   }
   else if (x_class == FP_INFINITE)
diff --git a/winsup/cygwin/math/log.def.h b/winsup/cygwin/math/log.def.h
index 94a7700..2ba7421 100644
--- a/winsup/cygwin/math/log.def.h
+++ b/winsup/cygwin/math/log.def.h
@@ -53,12 +53,12 @@ __FLT_ABI(log) (__FLT_TYPE x)
   int x_class = fpclassify (x);
   if (x_class == FP_ZERO)
     {
-      __FLT_RPT_ERANGE ("log", x, 0.0, -__FLT_HUGE_VAL, 1);
+      errno = ERANGE;
       return -__FLT_HUGE_VAL;
     }
   else if (signbit (x))
     {
-      __FLT_RPT_DOMAIN ("log", x, 0.0, __FLT_NAN);
+      errno = EDOM;
       return __FLT_NAN;
     }
   else if (x_class == FP_INFINITE)
diff --git a/winsup/cygwin/math/pow.def.h b/winsup/cygwin/math/pow.def.h
index a5513c1..e1538d9 100644
--- a/winsup/cygwin/math/pow.def.h
+++ b/winsup/cygwin/math/pow.def.h
@@ -122,7 +122,7 @@ __FLT_ABI(pow) (__FLT_TYPE x, __FLT_TYPE y)
   else if (x_class == FP_NAN || y_class == FP_NAN)
     {
       rslt = (signbit(x) ? -__FLT_NAN : __FLT_NAN);
-      __FLT_RPT_DOMAIN ("pow", x, y, rslt);
+      errno = EDOM;
       return rslt;
     }
   else if (x_class == FP_ZERO)
@@ -133,7 +133,7 @@ __FLT_ABI(pow) (__FLT_TYPE x, __FLT_TYPE y)
       if (signbit(x) && internal_modf (y, &d) != 0.0)
 	{
 	  return signbit (y) ? (1.0 / -x) : __FLT_CST (0.0);
-	  /*__FLT_RPT_DOMAIN ("pow", x, y, -__FLT_NAN);
+	  /*errno = EDOM;
 	  return -__FLT_NAN; */
 	}
       odd_y = (internal_modf (__FLT_ABI (ldexp) (y, -1), &d) != 0.0) ? 1 : 0;
@@ -167,7 +167,7 @@ __FLT_ABI(pow) (__FLT_TYPE x, __FLT_TYPE y)
       if (signbit(x) && internal_modf (y, &d) != 0.0)
 	{
 	  return signbit(y) ? 1.0 / -x : -x;
-	  /*__FLT_RPT_DOMAIN ("pow", x, y, -__FLT_NAN);
+	  /*errno = EDOM;
 	  return -__FLT_NAN;*/
 	}
       odd_y = (internal_modf (__FLT_ABI (ldexp) (y, -1), &d) != 0.0) ? 1 : 0;
@@ -195,7 +195,7 @@ __FLT_ABI(pow) (__FLT_TYPE x, __FLT_TYPE y)
     {
       if (signbit (x))
 	{
-	  __FLT_RPT_DOMAIN ("pow", x, y, -__FLT_NAN);
+	  errno = EDOM;
 	  return -__FLT_NAN;
 	}
       if (y == __FLT_CST(0.5))
diff --git a/winsup/cygwin/math/powi.def.h b/winsup/cygwin/math/powi.def.h
index f7fa860..e3840e7 100644
--- a/winsup/cygwin/math/powi.def.h
+++ b/winsup/cygwin/math/powi.def.h
@@ -83,7 +83,7 @@ __FLT_ABI(__powi) (__FLT_TYPE x, int y)
   else if (x_class == FP_NAN)
     {
       rslt = (signbit(x) ? -__FLT_NAN : __FLT_NAN);
-      __FLT_RPT_DOMAIN ("__powi", x, (__FLT_TYPE) y, rslt);
+      errno = EDOM;
       return rslt;
     }
   else if (x_class == FP_ZERO)
diff --git a/winsup/cygwin/math/sin.def.h b/winsup/cygwin/math/sin.def.h
index c9b3b04..dfb1cb4 100644
--- a/winsup/cygwin/math/sin.def.h
+++ b/winsup/cygwin/math/sin.def.h
@@ -53,12 +53,12 @@ __FLT_ABI(sin) (__FLT_TYPE x)
   int x_class = fpclassify (x);
   if (x_class == FP_NAN)
     {
-      __FLT_RPT_DOMAIN ("sin", x, 0.0, x);
+      errno = EDOM;
       return x;
     }
   else if (x_class == FP_INFINITE)
     {
-      __FLT_RPT_DOMAIN ("sin", x, 0.0, __FLT_NAN);
+      errno = EDOM;
       return __FLT_NAN;
     }
   return (__FLT_TYPE) __sinl_internal ((long double) x);
diff --git a/winsup/cygwin/math/sqrt.def.h b/winsup/cygwin/math/sqrt.def.h
index 2690d1d..ee858a7 100644
--- a/winsup/cygwin/math/sqrt.def.h
+++ b/winsup/cygwin/math/sqrt.def.h
@@ -73,7 +73,7 @@ __FLT_ABI (sqrt) (__FLT_TYPE x)
       if (x_class == FP_ZERO)
 	return __FLT_CST (-0.0);
 
-      __FLT_RPT_DOMAIN ("sqrt", x, 0.0, x);
+      errno = EDOM;
       return x;
     }
   else if (x_class == FP_ZERO)
-- 
2.7.4


--MP_/tRU0BSmUl6FO2szvAH/5/=l--
