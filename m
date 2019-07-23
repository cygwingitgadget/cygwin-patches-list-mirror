Return-Path: <cygwin-patches-return-9512-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20095 invoked by alias); 23 Jul 2019 16:59:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20084 invoked by uid 89); 23 Jul 2019 16:59:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Jul 2019 16:59:31 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MmlCY-1iEokn2UPm-00jrlV; Tue, 23 Jul 2019 18:59:23 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 85479A80872; Tue, 23 Jul 2019 18:59:21 +0200 (CEST)
Date: Tue, 23 Jul 2019 16:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>,	Jon TURNEY <jon.turney@dronecode.org.uk>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 1/1] Cygwin: don't allow getpgrp() to fail
Message-ID: <20190723165921.GN21169@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	Jon TURNEY <jon.turney@dronecode.org.uk>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190723161100.1045-1-kbrown@cornell.edu> <20190723161100.1045-2-kbrown@cornell.edu> <20190723165458.GM21169@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6Mt39TZj+HFMr11E"
Content-Disposition: inline
In-Reply-To: <20190723165458.GM21169@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00032.txt.bz2


--6Mt39TZj+HFMr11E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1059

On Jul 23 18:54, Corinna Vinschen wrote:
> Hi Ken,
>=20
> On Jul 23 16:12, Ken Brown wrote:
> > According to POSIX, "The getpgrp() function shall always be successful
> > and no return value is reserved to indicate an error."  Cygwin's
> > getpgrp() is defined in terms of getpgid(), which is allowed to fail.
>=20
> But it shouldn't fail for the current process.  Why should pinfo::init
> fail for myself if it begins like this?
>=20
>   if (myself && n =3D=3D myself->pid)
>     {
>       procinfo =3D myself;
>       destroy =3D 0;
>       return;
>     }
>=20
> I fear this patch would only cover up the problem still persisting
> under the hood.
>=20
> > Change getpgrp() so that it doesn't fail even if getpgid() fails.
>=20
> Instead of calling getpgid(0), we could just as well return
> myself->pgid.  This never fails for sure.

Just a hunch: The only reason for pinfo::init failing in GDB I can think
of is if the call is too early in the lifetime of the process.  Myself
might not be set up yet.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--6Mt39TZj+HFMr11E
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl03POkACgkQ9TYGna5E
T6CpcA/+O4mt14Z6nDDPwcrP7ruViHbU60bSFhEKEyjWoMX7xY3ZLpGTJHzOdRac
Ivi6YRSxpvbyZvbQQaKlaYRJ6zHcXtft9O1qdWvSf8ZkEwjHv/+b/E+rxwKx6meh
ketXq854X1JUBhAKjVxAprqMR0nijLbQ7gZuh+htI/bDdqfoKizj/MJAEk/ERFpC
V038A+YHbpbR0/wkb+PQoCyXz3bzuSkpWcJk8g3olKVinvP2dhbowpSYYmnjZ2M0
jQK51bTzoWArKAz9EUkW3dCtIxoQKs+iCvRf/IA+LmIGjU58oeXhi8hv19GyEwh3
lyI+gFbWUjA8KZtHw8CPI/c091SFZLXKng9ApZ4zQS8BOyHurcN2HKtjBC9359Vc
UgVn1ri5VrxDk+ZaAZaJmkyMnypsntQn73U1ESGy11ZmNAqAmBJ/rmrXzC4HwsdH
iOFM2RaiiTWEEngSv7PnX9wnvCBXGIqZFCtptqKjUiR2hoiLDM37RvgvxHKtkWs1
tJRDKdalqybsrTAIda40bu4k4aIsDTo9pzMR2EGH1WOVN4rZQLAUsFmYdMNQQyup
VYEORaKeCGqAyfXyZys0KXaKh5KYofNWqhc5YfZqZZhqcf9rhGM9bcIG/1lmvCEU
dBwZ3g1JBC0gOt4cPjEmvOhEfOwus8qsOeYG0/AQHKXwcKBO3HE=
=ZKw/
-----END PGP SIGNATURE-----

--6Mt39TZj+HFMr11E--
