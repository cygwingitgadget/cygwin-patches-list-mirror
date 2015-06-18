Return-Path: <cygwin-patches-return-8195-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114111 invoked by alias); 18 Jun 2015 08:26:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114094 invoked by uid 89); 18 Jun 2015 08:26:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.5 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Jun 2015 08:26:40 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 72FBDA8084B; Thu, 18 Jun 2015 10:26:38 +0200 (CEST)
Date: Thu, 18 Jun 2015 08:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Hide sethostname() in unistd.h
Message-ID: <20150618082638.GQ31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55804E7D.3060504@t-online.de> <20150616174551.GF31537@calimero.vinschen.de> <558107F2.3030809@t-online.de> <20150617084626.GI31537@calimero.vinschen.de> <5581D7C4.1000207@t-online.de> <1434574654.11212.4.camel@cygwin.com> <5581E384.9030608@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="8JAmzYDSl0Sjbh5d"
Content-Disposition: inline
In-Reply-To: <5581E384.9030608@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00096.txt.bz2


--8JAmzYDSl0Sjbh5d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1603

On Jun 17 15:15, Eric Blake wrote:
> On 06/17/2015 02:57 PM, Yaakov Selkowitz wrote:
> > On Wed, 2015-06-17 at 22:25 +0200, Christian Franke wrote:
> >> Busybox does not use autoconf or similar. It requires manual platform=
=20
> >> specific configuration which does not yet support a missing=20
> >> sethostname(). After adding HAVE_SETHOSTNAME manually and some other=20
> >> minor additions, busybox (which many commands enabled) compiles and=20
> >> works reasonably.
> >> Would ITP make sense ?
> >=20
> > TBH I'm not sure.  Presuming you're discussing the single-executable
> > build (so as not to clobber coreutils etc.), there is still the question
> > of (not) matching the heavily-patched coreutils wrt .exe handling etc.
> > What do you think the use case would be?
>=20
> Portability testing is one thing - I often compare how
> bash/dash/zsh/mksh handle a shell construct, and adding busybox sh into
> the mix adds another perspective.  But yeah, I don't see busybox
> becoming the default source of these apps, so much as an alternative
> implementation.

If it's called "busybox" and the package doesn't try to create shortcuts
/bin/sh -> /bin/busybox, etc, I don't see a problem to ITP it.

If those symlinks are required for busybox to work, they should be
encapsulated in their own subdir, something like /usr/libexec/busybox
or so.  Users just need to set $PATH correctly then.  Or maybe that
could be done by busybox as well.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--8JAmzYDSl0Sjbh5d
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgoC+AAoJEPU2Bp2uRE+gDpAP/jXMrOK2ijA6yYOj96fDEn5L
+Tq1zHvAlL+4zFoy61mfWA8YPNazN9TteJ/TyZX4z8zuigZATLqMXA1iGnyD+tVm
Hl3G/hTXsqR4IxjNpU1QKS+Q8XI3e2emF/3p8sU+cElmcqOmKmXzMHK0jf1Ts5YC
Tw/YRp5gFVT4+SS3dN6TXD3Ym+DLdfQSTr1jn4RDfFczVM9DPTPynR/iJEoMxZIS
65x1Le2tc/k3TjSpLvGiLyKhkKq6cvJmFujm0o2Psnoe93rMr4gZvnSJeyiMF1Ba
MIB89+WI0bD8dciCnZLUiYumGTDYvmtlP2tlmHfEjfcx1PUTCu+09fBdfnwgdryq
dl1z74cDeNX3HHi6ObrkRC4AE8CHcN3N7BWad3FQNGx9P68UE/2i1NLUPxmBFraX
nT/ZrAjJ71wo68jt4+qcwPatTFA+u6T28r2EMoz9QlbPCRcafrpGM/zib4vh3Pxy
5eAzhXfTd7DqPBlHoUAQY9ri/ZaZA9gXlyvCWaVeG+tmX8R6U0uF6GmWB9Z+xDAE
4x6o0CfNQpv4Amc4UcPxwVpznKlJ8195OfN/K/XuF9D87+gANbdyF+ip5Da6cCkG
RyJCmJR5j7Z3xvhu6c2zsQhZcx6tZDudHsfq02kfoWKTMgG5PzppoW/WWPpGXeB6
5jVV40Mi0OEFiXHOBr/i
=OllR
-----END PGP SIGNATURE-----

--8JAmzYDSl0Sjbh5d--
