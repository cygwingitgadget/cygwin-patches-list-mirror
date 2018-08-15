Return-Path: <cygwin-patches-return-9179-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119924 invoked by alias); 15 Aug 2018 15:26:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119911 invoked by uid 89); 15 Aug 2018 15:26:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Aug 2018 15:26:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M1WmX-1gA7Ai1Y5J-00tRqe for <cygwin-patches@cygwin.com>; Wed, 15 Aug 2018 17:26:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 96211A805A5; Wed, 15 Aug 2018 17:26:36 +0200 (CEST)
Date: Wed, 15 Aug 2018 15:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Keep the denormal-operand exception masked; modify FE_ALL_EXCEPT accordingly.
Message-ID: <20180815152636.GL3747@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1534330763-2755-1-git-send-email-houder@xs4all.nl> <20180815145449.GJ3747@calimero.vinschen.de> <f0f0756f46ab11e243b9f17e069a2788@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NxDiCysn+RCvdoZt"
Content-Disposition: inline
In-Reply-To: <f0f0756f46ab11e243b9f17e069a2788@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00074.txt.bz2


--NxDiCysn+RCvdoZt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2579

On Aug 15 17:01, Houder wrote:
> On 2018-08-15 16:54, Corinna Vinschen wrote:
> > On Aug 15 12:59, J.H. van de Water wrote:
> > > By excluding the denormal-operand exception from FE_ALL_EXCEPT, it
> > > will not
> > > be possible anymore to UNmask this exception by means of the API
> > > defined by
> > > /usr/include/fenv.h
> > >=20
> > > Note: terminology has changed since IEEE Std 854-1987; denormalized
> > > numbers
> > > are called subnormal numbers nowadays.
> > >=20
> > > This modification has basically been motivated by the fact that it
> > > is also
> > > not possible on Linux to manipulate the denormal-operand exception
> > > by means
> > > of the interface as defined by /usr/include/fenv.h. This has been
> > > the state
> > > of affairs on Linux since 2001 (Andreas Jaeger).
> > >=20
> > > The exceptions required by the standard (IEEE Std 754), in case they
> > > can be
> > > supported by the implementation, are:
> > > FE_INEXACT, FE_UNDERFLOW, FE_OVERFLOW, FE_DIVBYZERO and FE_INVALID.
> > >=20
> > > Although it is allowed to define additional exceptions, there is no
> > > reason
> > > to support the "denormal-operand exception" in this case (fenv.h),
> > > because
> > > the subnormal numbers can be handled almost as fast the normalized
> > > numbers
> > > by the hardware of the x86/x86_64 architecture. Said differently, a
> > > reason
> > > to trap on the input of subnormal numbers does not exist. At least
> > > that is
> > > what William Kahan and others at Intel asserted around 2000.
> > > (that is William Kahan of the K-C-S draft, the precursor to the
> > > standard)
> > >=20
> > > This commit modifies winsup/cygwin/include/fenv.h as follows:
> > >  - redefines FE_ALL_EXCEPT from 0x3f to 0x3d
> > >  - removes the definition for FE_DENORMAL
> > >  - introduces __FE_DENORM (0x2) (enum in Linux also uses __FE_DENORM)
> > >  - introduces FE_ALL_EXCEPT_X86 (0x3f), i.e. ALL x86/x86_64 FP
> > > exceptions
> >=20
> > Shouldn't FE_ALL_EXCEPT_X86 be defined locally in fenv.cc only?
> > I don't see that Linux exports that definition.
>=20
> Ah, Sorry. Do I have to resubmit my patch? Or is it easy enough for you to
> make this modification?

It's easy enough but I'm still mulling over __FE_DENORM.  The glibc
fenv.h header defines it, so I guess we should stick to it.  In that
case it might make sense to revert the original comment and just move
__FE_ALL_EXCEPT_X86.

Ok?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NxDiCysn+RCvdoZt
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlt0RiwACgkQ9TYGna5E
T6CERw//ZUHt/jXiKKKfbqSDVMCCv6pAKs6WPqsoJizi6XTbsTrwN7VK0ISHDlCj
vV26kAxJ8SESbmVpRpNBoZx5MjfMWcxKrbG4F38FML01m47QIPGEOHwgOSk+pu0Y
8IEeLlM+b3ZfO5uUQHtz4sxdEOfc9Wh46piyJk7TouNy3BIuz7O/YCI7lsuEsaZ/
ksfu5TegdvSgi/EioTwTBD2d1bnHed7n42arvrBe4fSAkyl1P3BcX6pe/Eo2oU/1
u/kodNFDE7xg2I0y7rWKAghyr863BzZpmbODGxxPREdPGefTz4wMCGSLQYFymemB
vab/Z0m81t9nj6hM95QwbkyOhp+PwHld6ymL3nLSu4rlfDn0IxbCjz87FvvZP6z+
XMDuZqhPfIQJp4SYxAWPUAvPmZeqqVijI4p+TT77yWakhWPq/67lykWohQT8iCPr
Qg3P9whPgifa2NpVLr2oGbzaZviElFj4VFYnBtT5YaZwlxK2WC4jVXO4VyEPLaK5
Q2xSYV6rD/vw+mmOgU3+PhUOAaMO1FD2o8/Fag+7+iA+04TZeTkD+We9/4ddC17Y
TPc1EBFIkc/TDEbGjjPIoSYCC63wl4B76DHKbZBOsOGokGRxuZ6Z3H50NCwoqoOz
gLLI8536+2NU3FeNpDcxiY06ryCZIt6nsEQZcwMtkm1hkfyCNfw=
=bKnt
-----END PGP SIGNATURE-----

--NxDiCysn+RCvdoZt--
