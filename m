Return-Path: <cygwin-patches-return-9260-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62990 invoked by alias); 28 Mar 2019 15:36:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62977 invoked by uid 89); 28 Mar 2019 15:36:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 15:36:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MKbTo-1hNl730Yma-00L03E for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 16:36:37 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C8073A8057D; Thu, 28 Mar 2019 16:36:36 +0100 (CET)
Date: Thu, 28 Mar 2019 15:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190328153636.GS4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <20190328091507.GM4096@calimero.vinschen.de> <89dc8dca-c97b-ef79-6b90-bebb1b73c388@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="rFUhhEVnhEf/dYhU"
Content-Disposition: inline
In-Reply-To: <89dc8dca-c97b-ef79-6b90-bebb1b73c388@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00070.txt.bz2


--rFUhhEVnhEf/dYhU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2562

On Mar 28 16:02, Michael Haubenwallner wrote:
> On 3/28/19 10:15 AM, Corinna Vinschen wrote:
> > On Mar 28 09:34, Michael Haubenwallner wrote:
> >> Hi Corinna,
> >>
> >> On 3/27/19 10:16 AM, Corinna Vinschen wrote:
> >>> On Mar 27 09:26, Michael Haubenwallner wrote:
> >>>> On 3/26/19 7:28 PM, Corinna Vinschen wrote:
> >>> Wait, let me understand what's going on.  IIUC you're building DLLs
> >>> which are then used during the build job itself, right?
> >>
> >> Exactly.
> >> FWIW, the CI builds also set up a Cygwin instance from scratch,
> >> as I'm also after testing Cygwin (v3) itself to some degree:
> >> https://dev.azure.com/gentoo-prefix/ci-builds/_build
> >>
> >> However, I've not found a commandline option for setup.exe to install
> >> "test" versions...
> >>
> >>> As you know, 64 bit has a defined memory layout.  Binutils ld is
> >>> supposed to base the DLLs to a pseudo-random address in the area betw=
een
> >>> 0x4:00000000 and 0x6:00000000.  This area is occupied by un-rebased D=
LLs
> >>> only.  8 Gigs is a *lot* of space for DLLs.
> >>>
> >>> That also means that the DLLs should not at all collide with windows
> >>> objects (typically reserved in the lesser 2 Gigs area), unless they
> >>> collide with themselves.  At least that's the idea.
> >>>
> >>> Can you check what addresses the freshly built DLLs are based on by L=
D?
> >>> Is there a chance that the algorithm used in LD is too dumb?
> >>
> >> I've also added system_printf to dll_list::reserve_space() when a dynl=
oaded
> >> dll was relocated, and each new address was below 0x0:01000000. The at=
tached
> >> output also contains the preferred address, above 0x4:00000000 each.
> >=20
> > Do they actually collide with each other?  Did you check the addresses?
>=20
> Yes, there is a real collision between installed dlls:
> $ rebase -i /home/haubi/test-20190327/gentoo-prefix/usr/bin/cygcrypto-1.1=
.dll /home/haubi/test-20190327/gentoo-prefix/usr/lib/python2.7/lib-dynload/=
_locale.dll
> /home/haubi/test-20190327/gentoo-prefix/usr/bin/cygcrypto-1.1.dll        =
         base 0x00041c650000 size 0x0027d000 *
> /home/haubi/test-20190327/gentoo-prefix/usr/lib/python2.7/lib-dynload/_lo=
cale.dll base 0x00041c6a0000 size 0x0002c000 *

Oh well, it would be nice if ld's hash algorithm would spread out DLLs
better in the 8 Gigs space.

> Is the cygwin1.dll from master branch available via setup.exe cmdline som=
ehow?

No, only from the snapshot page.  I release a 3.0.5 soon, but 3.1 will
be dev-only for a while.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--rFUhhEVnhEf/dYhU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyc6gQACgkQ9TYGna5E
T6D+7RAAjHPBIbWYyfNkOYImE/yHutUuc052BW6KYYZEzrzIlbj+TweTiHxUjkfq
6mGQYUZa5BeI08pzPViTZ5HsTPUlTJ0zIDWlnkkAO/78WE2TvD92TSgMUMe6l+0Y
ydCM9LiwdVEkrcBqpfZwfILFBt7l3IuSz6JA1kVdzDCWQQZfiH+7FDroh1pTcAvO
gYaWHwRopkrWIPttIpCTJSnzL4luIkI9GslAhi5Lp7x00U+DUbW3w9ycLu0gVsuA
dcGocdY0widnn4wY0hr6gFKQ599DQPfm0j92+uUtj/v3EmqzoXEN3O+TxP62qcVg
CiH20BFWohBmuPPKnoc5zy9Odze7r8iLziJr04q7HgEXtaBoHI2FYQAS3m+S2hKb
X5IlN+XntpjT2jomFv4+N7I3XhpKL7TowUX0OOHKIVLx1wiZtZ5aYgqcikLTW4DY
VTjmVpvOw3akWyVP3OYp2pHTrsYAyV7JrDvn2PdilPoOBJus2pBKTUHNKcZLnjRQ
TO3UOtuzhOAgPjSzHZp0yMAom0V1GDtkSK7HDPNjjhVYvmncevI2iE3TjKHGs+C8
gEzSO20q7Hrvbp1fFlpDXT212qWt450HU8uiPBf4DfCt9SID2HD4zT+9IRWGaH7h
1aEa0ANptpIReHj/mX399fen9AgUUvIS3a1y+b4ICGCbQ8zGXk0=
=jvjB
-----END PGP SIGNATURE-----

--rFUhhEVnhEf/dYhU--
