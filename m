Return-Path: <cygwin-patches-return-9294-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12498 invoked by alias); 1 Apr 2019 14:57:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12471 invoked by uid 89); 1 Apr 2019 14:57:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 01 Apr 2019 14:57:03 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MaIGB-1hPaxi1aez-00WBta; Mon, 01 Apr 2019 16:56:59 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7F9FEA806B0; Mon,  1 Apr 2019 16:56:58 +0200 (CEST)
Date: Mon, 01 Apr 2019 14:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190401145658.GA6331@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	cygwin-patches@cygwin.com
References: <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00001.txt.bz2


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1791

On Apr  1 16:28, Michael Haubenwallner wrote:
> Hi Corinna,
>=20
> On 3/28/19 9:30 PM, Corinna Vinschen wrote:
> > can you please collect the base addresses of all DLLs generated during
> > the build, plus their size and make a sorted list?  It would be
> > interesting to know if the hash algorithm in ld is actually as bad
> > as I conjecture.
>=20
> Please find attached the output of rebase -i for the dlls after bootstrap
> on Cygwin 3.0.4, each built with ld from binutils-2.31.1.
>=20
> > If we can improve on the distribution within the 8 Gigs area by changing
> > ld's address generation(*), we may improve situations like these without
> > too much hassle.  As always, not a foolproof way out, but heck, 8 Gigs
> > is a lot of space for a couple 100 DLLs.
>=20
> Feels like I need some Cygwin rebase step in Gentoo Prefix anyway, as the=
re
> are ~250 dlls right after bootstrap - without any application yet.

For comparison, I have 1835 system DLLs installed, and they only take
a bit less than 30% of the 8 Gigs.

I'm surprised to see 7 collisions, one of them even using the exact
same address.  So the hash algorithm might be improvable.

In hindsight, we also might have been better off with a bit more space
for DLLs than 8 + 8 Gigs, I guess, given the size of the 64 bit address
space.  We can still get to that by updating Cygwin, rebase and
binutils.  For instance, assuming 32 Gigs + 32 Gigs, rebased DLLs would
start at 0x2:00000000, non-rebased DLLs would start at 0xa:00000000 and
the heap would start at 0x12:00000000.  Still lots of room in the VM.

However, that would probably not fix the exact collision between
usr/bin/cygncurses++6.dll and
usr/lib/python3.6/lib-dynload/_sha512.cpython-36m-x86_64-cygwin.dll


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyiJroACgkQ9TYGna5E
T6DNyg//ZW1o424QSc07PU1acMumIQmH9ErdJxElKSB0MwA1b1g6XZKu6rfiej2H
XUrRCnsqJaVzzpckkYMKO0cmebGn/Vpa3jkyAczjPHXCM5Seajk5pUOazZiLyEuK
y5frS3AJROmjuOtH064vFXCO2a1Z8Kfgx1m6w/6cFwbbSKOdTXIkfaRQ7vw/bEeq
VVOvPvAuphp8hpqNimb8uU7d2Myw4UXuiA67CuXljUUhjajoNVD/W0WYitkX1exF
XABvIGTC3bIhj7I5yyflaIntIaLS0o2l6QPFCHlguvaqua2GDiJnEzrntfuWFGDf
hxZvllEe6yc4waq/3gDsAkWdb4vkAr1ntfutNbAjsuUjlSN+9CLc01yLl4rKp4ZP
mr3Db3amzPQInlCtT+cLPk1qleh3N3C8VfcHKlUYUwS59SXRDpknjjoIV5ykGVW8
qrsg9uHKppdKV0L1iZfFFWrqGjzHB5PSGxrvNwBGylYztsNg0u540olfl627nvJ1
6p6OBnPK1SMvZO9PHK1/wPSdjbJaXIENpn9Plzioc2d/MKb2Jf90UM7ZUs/4r+IH
WtAUVxEG0NRppVcZpd1hv59ovQ66U+xzuxpRGARI6sAOxTC96R5/QulLi2EmizK9
+XQIDtwr1YRmKP7iKDr9MFNamWiB84bm8diQ91RzE3c32e34NKM=
=uNmW
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
