Return-Path: <cygwin-patches-return-9330-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99678 invoked by alias); 12 Apr 2019 17:40:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99665 invoked by uid 89); 12 Apr 2019 17:40:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=intercepted, 1.1, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Apr 2019 17:40:36 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M5x9B-1hDdW71vwp-007YeX; Fri, 12 Apr 2019 19:40:32 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A9EC0A806DE; Fri, 12 Apr 2019 19:40:31 +0200 (CEST)
Date: Fri, 12 Apr 2019 17:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190412174031.GC4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	cygwin-patches@cygwin.com
References: <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com> <20190401145658.GA6331@calimero.vinschen.de> <20190401155636.GN3337@calimero.vinschen.de> <837bc171-eb6f-681e-5167-103f5e9e8523@ssi-schaefer.com> <20190403122216.GX3337@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="asNXdz5DenlsLVVk"
Content-Disposition: inline
In-Reply-To: <20190403122216.GX3337@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00037.txt.bz2


--asNXdz5DenlsLVVk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2519

Hi Michael,

On Apr  3 14:22, Corinna Vinschen wrote:
> On Apr  3 11:18, Michael Haubenwallner wrote:
> > On 4/1/19 5:56 PM, Corinna Vinschen wrote:
> > > On Apr  1 16:56, Corinna Vinschen wrote:
> > >> On Apr  1 16:28, Michael Haubenwallner wrote:
> > >>> On 3/28/19 9:30 PM, Corinna Vinschen wrote:
> > >>>> can you please collect the base addresses of all DLLs generated du=
ring
> > >>>> the build, plus their size and make a sorted list?  It would be
> > >>>> interesting to know if the hash algorithm in ld is actually as bad
> > >>>> as I conjecture.
> > >>>
> > >>> Please find attached the output of rebase -i for the dlls after boo=
tstrap
> > >>> on Cygwin 3.0.4, each built with ld from binutils-2.31.1.
> > >=20
> > > Oh, wait.  That's not what I was looking for.  The addresses are ok, =
but
> > > the paths *must* be the ones at the time the DLLs have been created,
> > > because that's what ld uses when creating the image base addresses.  =
The
> > > addresses combined with the installation paths don't make sense anymo=
re.
> >=20
> > So I have intercepted the ld.exe to show 'rebase -i' on any just create=
d dll,
> > tell about the exact -o argument to ld, and the current directory.
> >=20
> > This is with binutils-2.31.1
> >=20
> > Anything else needed?
>=20
> No, that should be sufficient, thanks for collecting this!

Nick Clifton, one of the binutils maintainers, made the following
suggestion in PM:

Allow the ld flag --enable-auto-image-base to take a filename as
argument.

The idea: The file is used by ld to generate the start address
for the next built DLL.  Mechanism:

1.1. If ld links a DLL and if the file given to --enable-auto-image-base
     doesn't exist, ld will give the DLL the start address of the
     auto image base range.

1.2: Next time, if ld links a DLL and if the file given to
     --enable-auto-image-base exists, it will use the address in that
     file as the start address for th just built DLL.

2. It will store that address, plus the size of the DLL, rounded up to
   64K, in that file.

3. If the auto image base range is at an end, ld will wrap back to
   the start address of the auto image base range.

TBD: A way to enable this feature without having to change all
     packages' build systems.

That way you could build hundreds of DLLs in a project and use them
immediately without having to rebase.

This is just in a discussion state, nothing has happend yet, but
what do you think in general?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--asNXdz5DenlsLVVk
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlywzY8ACgkQ9TYGna5E
T6BWYA//aWMCKtzK9xC19bJxoOpCgOXo2EjD/OwgwFkaAEU3xOgQeLhFbb5b0FWC
z7TYIBYjEoSKJKjsTqUhHTno1KY9wVpYGOpDH4ZLV1I1c3pCB9rAzNQeE/0w+u4c
PM9nkIM4AG05NnqMYN4GAFKq9adN7zBkbjYD4Rq9Bb6wUMsOe2JPbnPWyPFtbK9A
Fx+lcnYd1pWKKBlqRGHgavgI5wpNDdDXSeZDB28kOTwP/B6NBw6vXFyMFew2B4tP
0r0DClros2N5QulocdK6iNJ+AU3ympBO0sO83Bk7zCBbFraJB5//HTyxWuregl90
G0HeXRTSu+CxpnNm3Lkmv7Mkz6YjDn3yXqd7+V+gb30dKeRLnWzOy+wVAmO84ooL
tld3rdVsAjKxszPwGSS73pKLGRfPglRp6q582wfEis5N3to5PqeDjoC99ZUb3jQb
aigmom0JrukYxx+seWOSlX8rfKmWaNvHh3tDfKqVtiyKsgbsVnHoiw4wWhj3nEUx
JlYmowEOhui7jlVd+/viDNWLGsnGoVu6jlKm2Yh3Rya9vYtcNvCYy/aMf6T+D+u5
zi+y/slcDOkmhyDP+LwYj1kDNGvRUNBb18l+xNNwyfQ4iU4Pqg2ul0WTZP94iFPW
7gfduFzFambbAOBzYK8HpqmH8JVaIg4Z+1wlNCNbcATcB+kSE9w=
=dBA0
-----END PGP SIGNATURE-----

--asNXdz5DenlsLVVk--
