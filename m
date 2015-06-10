Return-Path: <cygwin-patches-return-8147-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76157 invoked by alias); 10 Jun 2015 14:18:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76146 invoked by uid 89); 10 Jun 2015 14:18:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.7 required=5.0 tests=AWL,BAYES_05,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Jun 2015 14:18:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BFF31A8093B; Wed, 10 Jun 2015 16:18:27 +0200 (CEST)
Date: Wed, 10 Jun 2015 14:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Improve strace to log most Windows debug events
Message-ID: <20150610141827.GH31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1433937922-16492-1-git-send-email-jon.turney@dronecode.org.uk> <20150610141120.GG31537@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <20150610141120.GG31537@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00048.txt.bz2


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1112

On Jun 10 16:11, Corinna Vinschen wrote:
> Hi Jon,
>=20
> On Jun 10 13:05, Jon TURNEY wrote:
> > Not sure if this is wanted, but on a couple of occasions recently I hav=
e been
> > presented with strace output which contains an exception at an address =
in an
> > unknown module (i.e. not in the cygwin DLL or the main executable), so =
here is a
> > patch which adds some more information, including DLL load addresses, t=
o help
> > interpret such straces.
>=20
> That's a nice addition.  Two points, though:
>=20
> - Do we *always* want that output or do we want a way to switch it on
>   and off?  If the latter, we can simply add another _STRACE_foo option
>   for it.=20=20
>=20
> - The GetFileNameFromHandle function could be much simpler.  Rather than
>   opening a mapping object for ev.u.LoadDll.hFile, just use the existing
>   mapping object from ev.u.LoadDll.lpBaseOfDll.

    ...with the process handle taken from get_child(ev.dwProcessId).


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeEczAAoJEPU2Bp2uRE+gCsIP/im5fj6CO0SiV4QSWC6YFvbF
IQh9Z7hkpyobvPmkLvSwxCmkKuv5XFcFpM3ZEKtbOV8nDEUSSvx/6Mno/dAaj7F2
r2as+v0vxrgDxIU2fo1MX/+HPsPzJOhxJYRUXVRDWS9Z5iAwMKovDAdFOnToMh7e
HCG1F1yH+UW6NdTfPxzTmQYBoS4/C8X0P9M2MVqykHS4OsGvIK+p9rKiT53x7k+X
X4glJU4v762/K6xJ0WdBbDdmiyyadS9tGgLobm6IUI/7rnHDEosDf4KOOfdA55T6
DmQHctwVn8yFm+wjBHHDVqz7mZn2qv972OqrESIDpCkK0Bio/cbdpMZi64d7OPSE
YTKljGK6ZgweZYac8hPNy2TjbTS0XOITAH/t5wdf2o/zTpq8ess0LKn6iFLw910v
ZXxIP7t5XEIZ3WjS+xIVFz5ALMsYmXGJcyrumBN4rLtK7DYvFfblu31cBNKYoQu2
apk9BrsPzSpu312ocjUYvw95+ZZxvGbtARGOiYEFQMcSdHsgHLbj6YqnYTvuyNyi
BvMZ0S1D/gKeLGZz63IsuvjQEcqWPyVvhmByngEnk9JnHr/PJsGkQe0AUdzOkraZ
q2zBuqpDQa+T07ujoxlEG6lQrVu/uEXWRHCeYvDmY9KQtYQ1QBiTCBY8bmDz+/mK
UspSDX1MdEtaCkUGMYfM
=J/Xr
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
