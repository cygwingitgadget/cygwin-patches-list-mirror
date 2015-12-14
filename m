Return-Path: <cygwin-patches-return-8286-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79481 invoked by alias); 14 Dec 2015 15:06:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79461 invoked by uid 89); 14 Dec 2015 15:06:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=3.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from ipbcc02fe8.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.47.232) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 14 Dec 2015 15:06:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DB24EA80645; Mon, 14 Dec 2015 16:06:19 +0100 (CET)
Date: Mon, 14 Dec 2015 15:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Trivial fix to last change
Message-ID: <20151214150619.GA2386@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <566B4AB2.1000905@cornell.edu> <20151214092507.GD3507@calimero.vinschen.de> <566EC64D.5060802@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <566EC64D.5060802@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00039.txt.bz2


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2195

On Dec 14 08:38, cyg Simple wrote:
> On 12/14/2015 4:25 AM, Corinna Vinschen wrote:
> > On Dec 11 17:14, Ken Brown wrote:
> >> cygwin1.dll doesn't build on x86 after the last commit (eed35ef).  The
> >> trivial patch attached fixes it.
> >>
> >> Ken
> >=20
> >> From 1cd61c54994b2ba6c6ec1d1f8f1249f5f8fd4af3 Mon Sep 17 00:00:00 2001
> >> From: Ken Brown <kbrown@cornell.edu>
> >> Date: Fri, 11 Dec 2015 17:08:28 -0500
> >> Subject: [PATCH] Fix regparm attribute of fhandler_base::fstat_helper
> >>
> >> * winsup/cygwin/fhandler_disk_file.cc (fhandler_base::fstat_helper):
> >> Align regparm attribute to declaration in fhandler.h.
> >> ---
> >>  winsup/cygwin/ChangeLog             | 5 +++++
> >>  winsup/cygwin/fhandler_disk_file.cc | 2 +-
> >>  2 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
> >> index 3c9804b..7079baa 100644
> >> --- a/winsup/cygwin/ChangeLog
> >> +++ b/winsup/cygwin/ChangeLog
> >> @@ -1,3 +1,8 @@
> >> +2015-12-11  Ken Brown  <kbrown@cornell.edu>
> >> +
> >> +	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Align
> >> +	regparm attribute to declaration in fhandler.h.
> >> +
> >>  2015-12-10  Corinna Vinschen  <corinna@vinschen.de>
> >>=20=20
> >>  	* path.h (class path_conv_handle): Use FILE_ALL_INFORMATION instead =
of
> >> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhand=
ler_disk_file.cc
> >> index fe9dd03..1dd1b8c 100644
> >> --- a/winsup/cygwin/fhandler_disk_file.cc
> >> +++ b/winsup/cygwin/fhandler_disk_file.cc
> >> @@ -428,7 +428,7 @@ fhandler_base::fstat_fs (struct stat *buf)
> >>    return res;
> >>  }
> >>=20=20
> >> -int __reg3
> >> +int __reg2
> >>  fhandler_base::fstat_helper (struct stat *buf)
> >>  {
> >>    IO_STATUS_BLOCK st;
> >> --=20
> >> 2.6.2
> >>
> >=20
> > Applied.  I really should build on *both* architectures before applying
> > a patch :-P
> >=20
>=20
> Would it have made more sense to test for architecture target?

I don't understand the question here.  -v, please?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWbtrrAAoJEPU2Bp2uRE+gi8gQAItahSLc1WEh7YOlZ7qKaeNG
jV7An9pEkMb68YXlZxPWJCC5jFdUgRuCo2Otq/i7xL4thzM9X0xj8DvK3BPU6M2K
hZRhSnKEDAV3lwy06YIfXnjA+Iv74pJO8+l9pmdmtsWEefmiN8IS0lypDqFm1ZZE
3ozyLj89WmU0nBgGLV3E8/QuirapQZKCrhie6zlCgAtoDrtfT0MsaR5IpzHI4p6p
f0M247KG57+eVXepRBaRbVTZFwW60NXIEyeoXLZ1SWhTem2sXxcDatXTilkmwFU2
JnXKSuEdoZijNWnXx9wF8ARD0b/FfhDjZuThVrRORg9RF39FH2gGdSVZKvZt10iI
laeqs5PGXn/H5NBem1C2cO81c5yXJVrRK239ao/G5GFF4vIlV259ZeoLpTT6BwV2
6ej1wpScRs/1/A4YfILWw7fLywiRh/At/5Kluv0CAVN1mDcG4+faY3V/al0FeOxo
EpUEjNkHApOsJ6KgMVKi2Iyn/b0FP7xiq1pI96+WfV/RL2Wa5fq92nJrghySF1DJ
7Xn2yS4ctQ0IVDTZZvN40DC5YA4uKUCGNIbnl9BcCzcNl40O97dfYndB6/Om2rFg
FPuio5AcSPKhJ7LNYZRtaojreMnXBBbP1mko1fXETN2zWGo8SR1vZI2a0M5ARtIJ
gKqJIgI/2GVnpOv47Gwa
=OVCg
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
