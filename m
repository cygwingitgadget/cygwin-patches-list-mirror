Return-Path: <cygwin-patches-return-8456-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108823 invoked by alias); 21 Mar 2016 18:09:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108810 invoked by uid 89); 21 Mar 2016 18:09:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.1 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,URI_NOVOWEL autolearn=ham version=3.3.2 spammy=Hx-languages-length:1384, claims, H*R:D*cygwin.com, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 18:09:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3C355A803F7; Mon, 21 Mar 2016 19:09:03 +0100 (CET)
Date: Mon, 21 Mar 2016 18:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 09/11] Add c++14 sized deallocation operator
Message-ID: <20160321180903.GB14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-9-git-send-email-pefoley2@pefoley.com> <20160320112837.GO25241@calimero.vinschen.de> <CAOFdcFPP79BaO=KTpF5oB3ewdYCh6GmfaxoJr03kKY7dSOjrKw@mail.gmail.com> <20160321171314.GA14892@calimero.vinschen.de> <CAOFdcFM1D17HSiLdeNv=S6zim6wOcqY41Ud-iTtiDLrN_YRYOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <CAOFdcFM1D17HSiLdeNv=S6zim6wOcqY41Ud-iTtiDLrN_YRYOg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00162.txt.bz2


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1389

On Mar 21 13:46, Peter Foley wrote:
> On Mon, Mar 21, 2016 at 1:13 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > But we export these functions as fallback functions to the applications.
> > See libstdcxx_wrapper.cc and the end of cxx.cc.  While the comment in
> > cxx.cc claims that this should "not be used in practice", there might be
> > c++14 code ending up with undefined references to the new delete
> > operator, isn't it?
> >
> > https://cygwin.com/ml/cygwin-patches/2009-q3/msg00010.html outlines
> > why these exports were necessary in the first place.
>=20
> Ah, I'll look into updating those files as well then.

I realized that your orignal patch isn't invalidated by this so I tried
to apply it and we could then add the other stuff later.  However, it
doesn't compile due to a warning, and since we're always building with
-Werror...

[...]/cxx.cc:33:1: error: =E2=80=98void operator delete(void*, size_t)=E2=
=80=99 is a usual (non-placement) deallocation function in C++14 (or with -=
fsized-deallocation) [-Werror=3Dc++14-compat]
 operator delete (void *p, size_t)
 ^
cc1plus: all warnings being treated as errors

I'm not sure it's the right thing to switch to C++14 by default using
gcc 5.3 yet.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8Di/AAoJEPU2Bp2uRE+gwR0P/1MR+UWepnLvYVJJmUs/1/vH
/8z1kIzA5CRFT53XQss2F5thjWh+NG+96VQzZcrFXAEnEx/JG3OYTbwVUkZ5otsu
eQsIMFsuXzLJ5m55t/BrKRBVSpAqPCksnQyWO6tNiwtrr9ITGrG8mBoJc8jrmxd8
tvt1NrvYRj/nuwZWpxE6gn1w/DnHC9AD9IlnUu7zsLhUgtmy9Qah3a/r5mMh//y/
RNPEM8J3t5+W4qjn9qIxNl4NbxRYL4BXuVJESvgeMrUtt6vAgma+YrYyU/ugIyUI
tnlAjCSkmoUpsCom5Y7UxFe+zcBPU3RpScuIPNH1L0tcR0US67HvttxJFHBMTK+Q
YPcLtGopKkeV0RznSeG997xV2XXCm1lIBM61ijizTxEBNTrpbT6/H4s7357z1Ns9
qpOt5Rbiu6mhEtoTH2UO2YcjH+/aMl2ldK9myhrW1dWb4dHSJA+ExoXbi6slwTlv
uW6i2Ni53TKI9KSlM/LbRHgSsLKnb2Nfg9+3QQm7dDgNY80GGA6xKDeKATxX4Qzk
YsYqKMcPcpNkO1GaEg7nsECDHETiGqbzpRbCLENa2w932SWJpjjyjUe8x2YoJV6v
8sn3kZhfWCzAYgAjiZKp/wDCMVXRCswrYNT7LMx9Z8/gvjhyA72JS47KkT9sTJTJ
XUP+2dQlMGanqmOkhmZr
=ZHbg
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
