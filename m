Return-Path: <cygwin-patches-return-8199-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 71561 invoked by alias); 19 Jun 2015 08:20:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71538 invoked by uid 89); 19 Jun 2015 08:20:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.7 required=5.0 tests=AWL,BAYES_05,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jun 2015 08:20:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4895DA80908; Fri, 19 Jun 2015 10:20:48 +0200 (CEST)
Date: Fri, 19 Jun 2015 08:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Hide sethostname() in unistd.h
Message-ID: <20150619082048.GA2731@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55804E7D.3060504@t-online.de> <20150616174551.GF31537@calimero.vinschen.de> <558107F2.3030809@t-online.de> <20150617084626.GI31537@calimero.vinschen.de> <5581D7C4.1000207@t-online.de> <1434574654.11212.4.camel@cygwin.com> <5581E384.9030608@redhat.com> <20150618082638.GQ31537@calimero.vinschen.de> <5583A85E.5010907@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <5583A85E.5010907@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00100.txt.bz2


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2286

On Jun 19 07:27, Christian Franke wrote:
> Corinna Vinschen wrote:
> >On Jun 17 15:15, Eric Blake wrote:
> >>On 06/17/2015 02:57 PM, Yaakov Selkowitz wrote:
> >>>On Wed, 2015-06-17 at 22:25 +0200, Christian Franke wrote:
> >>>>Busybox does not use autoconf or similar. It requires manual platform
> >>>>specific configuration which does not yet support a missing
> >>>>sethostname(). After adding HAVE_SETHOSTNAME manually and some other
> >>>>minor additions, busybox (which many commands enabled) compiles and
> >>>>works reasonably.
> >>>>Would ITP make sense ?
> >>>TBH I'm not sure.  Presuming you're discussing the single-executable
> >>>build (so as not to clobber coreutils etc.), there is still the questi=
on
> >>>of (not) matching the heavily-patched coreutils wrt .exe handling etc.
> >>>What do you think the use case would be?
> >>Portability testing is one thing - I often compare how
> >>bash/dash/zsh/mksh handle a shell construct, and adding busybox sh into
> >>the mix adds another perspective.  But yeah, I don't see busybox
> >>becoming the default source of these apps, so much as an alternative
> >>implementation.
> >If it's called "busybox" and the package doesn't try to create shortcuts
> >/bin/sh -> /bin/busybox, etc, I don't see a problem to ITP it.
>=20
> Symlinks in standard places should not be created, of course.
> The shell and other commands could still be started by: busybox COMMAND .=
.."
>=20
> >If those symlinks are required for busybox to work, they should be
> >encapsulated in their own subdir, something like /usr/libexec/busybox
> >or so.  Users just need to set $PATH correctly then.  Or maybe that
> >could be done by busybox as well.
> Yes: busybox --install -s /some/where
>=20
> Busybox may occasionally be useful because it provides lightweight versio=
ns
> of various commands (including daemons) not part of the Cygwin base
> installation and a few commands not available in any package.
>=20
> It could also be used to build a minimalistic Cygwin (busybox.exe,
> mintty.exe, cygwin1.dll). If build with standalone option enabled, symlin=
ks
> are not needed then.

Neat.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVg9DgAAoJEPU2Bp2uRE+gbwkQAIDWDGeugC2qhrBTTlNf/IKN
GihC9qvP+4Vk/eCjmoekZNFxwTob1p2qXOLv1wfEMMXzmCHMFLDd/49flDY4jBQE
Kft3ZW1R5XWMuQSRbMebPrzJU5mtvi2JqHoFP9imWQHcxxIKve6Erz43mxF++1sh
15Et3XTmHHTSIK53c7O263B0/WJJSxzh5tNRSQDrleBh3ubnD3Rtk3bNMbn7HWSD
5+dVxVygjjhulUD1HBBC9zPAt4khLfFEbZ977WeIq2+BhUizvWSQD+aTA2AxVPGA
FrdCeub3nUXuAZ+ZDcrpmN+IzPE20p19F39cbV3ZMnkdV0pWyx8QI5PjxRkJwf6z
2KbFKM+jU+LqxQSI1w4RFvgaRNhc/cPMViFb+a7ikJK9JuD4DQNQmtW4dnol/xYY
HOmFBkv2CU2KJDqFZGgOlh1eCYa3i4BM8Y1UUQ7pYYygaLc1Z7dyRFued1OTjT9l
yadx6H+m5m5pDUQTsG3UqZN2NdbydhrgVunb4umDugZYa5pBEWWioYu8IACFnnYF
VQwKIW/0FYNv5uN6RJqdxtcJ8wSKO5IT3SwKoVPYSi7/Z5JzsDPyAYrnh8zDnjDx
8DiUC7u4dRwsHqi3DAnhLPZ615hO2J8NpFdIGR5MlR+GAI1UK1HTv7hV9G02m2x9
AsJB453pd8nYhHgdXMMb
=A53Q
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
