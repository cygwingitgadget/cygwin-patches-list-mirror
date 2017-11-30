Return-Path: <cygwin-patches-return-8951-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110750 invoked by alias); 30 Nov 2017 09:49:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110739 invoked by uid 89); 30 Nov 2017 09:49:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 30 Nov 2017 09:49:32 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 14EC371A3A991	for <cygwin-patches@cygwin.com>; Thu, 30 Nov 2017 10:49:29 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id F24E95E0055	for <cygwin-patches@cygwin.com>; Thu, 30 Nov 2017 10:49:25 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6825DA8074C; Thu, 30 Nov 2017 10:49:28 +0100 (CET)
Date: Thu, 30 Nov 2017 09:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: export wmempcpy
Message-ID: <20171130094928.GJ547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171130014829.19408-1-yselkowi@redhat.com> <20171130014857.4668-1-yselkowi@redhat.com> <20171130092723.GI547@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gMqNd2jlyJQcupG/"
Content-Disposition: inline
In-Reply-To: <20171130092723.GI547@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00081.txt.bz2


--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 5827

On Nov 30 10:27, Corinna Vinschen wrote:
> On Nov 29 19:48, Yaakov Selkowitz wrote:
> > Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> > ---
> > Obviously this depends on the newlib implementation patch.
> >=20
> >  winsup/cygwin/common.din               | 1 +
> >  winsup/cygwin/include/cygwin/version.h | 3 ++-
> >  winsup/doc/posix.xml                   | 1 +
> >  3 files changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
> > index a482cf2b7..14b9c2c18 100644
> > --- a/winsup/cygwin/common.din
> > +++ b/winsup/cygwin/common.din
> > @@ -1609,6 +1609,7 @@ wmemchr NOSIGFE
> >  wmemcmp NOSIGFE
> >  wmemcpy NOSIGFE
> >  wmemmove NOSIGFE
> > +wmempcpy NOSIGFE
> >  wmemset NOSIGFE
> >  wordexp NOSIGFE
> >  wordfree NOSIGFE
> > diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/inc=
lude/cygwin/version.h
> > index d8bb3ee44..7510f42b0 100644
> > --- a/winsup/cygwin/include/cygwin/version.h
> > +++ b/winsup/cygwin/include/cygwin/version.h
> > @@ -489,12 +489,13 @@ details. */
> >         __stack_chk_fail, __stack_chk_guard, __stpcpy_chk, __stpncpy_ch=
k,
> >         __strcat_chk, __strcpy_chk, __strncat_chk, __strncpy_chk,
> >         __vsnprintf_chk, __vsprintf_chk.
> > +  321: Export wmempcpy.
> >=20=20
> >    Note that we forgot to bump the api for ualarm, strtoll, strtoull,
> >    sigaltstack, sethostname. */
> >=20=20
> >  #define CYGWIN_VERSION_API_MAJOR 0
> > -#define CYGWIN_VERSION_API_MINOR 320
> > +#define CYGWIN_VERSION_API_MINOR 321
> >=20=20
> >  /* There is also a compatibity version number associated with the shar=
ed memory
> >     regions.  It is incremented when incompatible changes are made to t=
he shared
> > diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> > index c99e003ba..ab574300f 100644
> > --- a/winsup/doc/posix.xml
> > +++ b/winsup/doc/posix.xml
> > @@ -1396,6 +1396,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
> >      wcstoll_l
> >      wcstoul_l
> >      wcstoull_l
> > +    wmempcpy
> >  </screen>
> >=20=20
> >  </sect1>
> > --=20
> > 2.15.0
>=20
> Basically ok, but shouldn't we use the assembler implementation of
> memcpy/wmemcpy in miscfuncs.cc for x86_64 mempcpy/wmempcpy as well?

Kind of like the below patch.  Can you test the mempcpy and wmempcy
return values for correctness?

Thanks,
Corinna


commit 243cbdf45cc48d885d821fdcda438101ff209bc0
Author:     Corinna Vinschen <corinna@vinschen.de>
AuthorDate: Thu Nov 30 10:47:38 2017 +0100
Commit:     Corinna Vinschen <corinna@vinschen.de>
CommitDate: Thu Nov 30 10:47:38 2017 +0100

    cygwin: x86_64: implement mempcpy/wmempcpy in assembler
=20=20=20=20
    * change memcpy to internal _memcpy not setting the return value in %rax

    * implement all memcpy-like functions as caller to _memcpy, setting %rax
      to correct return value beforehand.  This is possible because _memcpy
      does not use %rax at all
=20=20=20=20
    Signed-off-by: Corinna Vinschen <corinna@vinschen.de>

diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index a6404c85e808..923556d1f4cc 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -824,16 +824,8 @@ asm volatile ("								\n\
  * DAMAGE.								\n\
  */									\n\
 									\n\
-	.globl  memmove							\n\
-	.seh_proc memmove						\n\
-memmove:								\n\
-	.seh_endprologue						\n\
-	nop			/* FALLTHRU */				\n\
-	.seh_endproc							\n\
-									\n\
-	.globl  memcpy							\n\
-	.seh_proc memcpy						\n\
-memcpy:									\n\
+	.seh_proc _memcpy						\n\
+_memcpy:								\n\
 	movq	%rsi,8(%rsp)						\n\
 	movq	%rdi,16(%rsp)						\n\
 	.seh_endprologue						\n\
@@ -841,7 +833,6 @@ memcpy:									\n\
 	movq	%rdx,%rsi						\n\
 	movq	%r8,%rdx						\n\
 									\n\
-	movq	%rdi,%rax	/* return dst */			\n\
 	movq    %rdx,%rcx						\n\
 	movq    %rdi,%r8						\n\
 	subq    %rsi,%r8						\n\
@@ -873,14 +864,39 @@ memcpy:									\n\
 	movq	16(%rsp),%rdi						\n\
 	ret								\n\
 	.seh_endproc							\n\
-");
-
-asm volatile ("								\n\
+									\n\
+	.globl  memmove							\n\
+	.seh_proc memmove						\n\
+memmove:								\n\
+	.seh_endprologue						\n\
+	movq	%rcx,%rax	/* return dst */			\n\
+	jmp	_memcpy							\n\
+	.seh_endproc							\n\
+									\n\
+	.globl  memcpy							\n\
+	.seh_proc memcpy						\n\
+memcpy:									\n\
+	.seh_endprologue						\n\
+	movq	%rcx,%rax	/* return dst */			\n\
+	jmp	_memcpy							\n\
+	.seh_endproc							\n\
+									\n\
+	.globl  memcpy							\n\
+	.seh_proc memcpy						\n\
+mempcpy:									\n\
+	.seh_endprologue						\n\
+	movq	%rcx,%rax	/* return dst  */			\n\
+	addq	%r8,%rax	/*         + n */			\n\
+	jmp	_memcpy							\n\
+	.seh_endproc							\n\
+									\n\
 	.globl  wmemmove						\n\
 	.seh_proc wmemmove						\n\
 wmemmove:								\n\
 	.seh_endprologue						\n\
-	nop			/* FALLTHRU */				\n\
+	shlq	$1,%r8		/* cnt * sizeof (wchar_t) */		\n\
+	movq	%rcx,%rax	/* return dst */			\n\
+	jmp	_memcpy							\n\
 	.seh_endproc							\n\
 									\n\
 	.globl  wmemcpy							\n\
@@ -888,9 +904,21 @@ wmemmove:								\n\
 wmemcpy:								\n\
 	.seh_endprologue						\n\
 	shlq	$1,%r8		/* cnt * sizeof (wchar_t) */		\n\
-	jmp	memcpy							\n\
+	movq	%rcx,%rax	/* return dst */			\n\
+	jmp	_memcpy							\n\
+	.seh_endproc							\n\
+									\n\
+	.globl  wmemcpy							\n\
+	.seh_proc wmemcpy						\n\
+wmempcpy:								\n\
+	.seh_endprologue						\n\
+	shlq	$1,%r8		/* cnt * sizeof (wchar_t) */		\n\
+	movq	%rcx,%rax	/* return dst */			\n\
+	addq	%r8,%rax	/*         + n */			\n\
+	jmp	_memcpy							\n\
 	.seh_endproc							\n\
 ");
+
 #endif
=20
 /* Signal the thread name to any attached debugger



--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--gMqNd2jlyJQcupG/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaH9QoAAoJEPU2Bp2uRE+gp3oP/2jnb1yLm88nuSD3lUrJ7ZyP
JK1j6+FOv5KnL/ejCAYOm0276tRi8qlyaN3+eJXh7vE781DyYKYsJG2gsUL1p0Qj
aoxY6XvNWM10WrBvFUKTurUGbQLyqMjx2W6O/88siOVjbOBGHANk3G13x0KHnNY0
pjpLbBq9iwV2jWiB6ZXBX5c5U8WoPXIC0anT9/LXE2IDgM+c1eQ/tVGm2tMhh/Yo
H8KBCEkVnezB5PL5iJR8/0C5jdoyjlA4eLQlQZ1w+1j3/x+M5p6ZQFxe/zZip8sR
9i2ZctOiRViVq09PR8Y8avFgcUKZnjUcM7BNxliDxnmGy+tZ02dz0G1szSsik6s6
VM3XckF7MxeNoP7ri2JoqxN8CYDzhF9vjJqbmQs1eY+oEnS/VWwXOTb+PFJNzx+j
WHe0vGQQQRDjsXbixGtIxqDB5ObFCwiLwcaVZj3F+iuZus9RVUqX1TvCIVxJ9U1H
9F57zrv2FzOMoY2bQferM2vmWkIldgZlGze7FNFUe1mkFJBBRLQFJIqcuWr55AmU
TzoQ6HrY10OqKL+mMA80LYx4Ov8BZH2JXGqmqsQdW7SKa2wN7BvTFTXy1T9R2ZrM
XlW6XK17goYQMF3PxpG6+XuBY8vAY3+gUSthEXlWZnDx0E7C/vUArscOalz4Xsgm
jFvDGGJmYEOtcCl3qZoH
=Qxc8
-----END PGP SIGNATURE-----

--gMqNd2jlyJQcupG/--
