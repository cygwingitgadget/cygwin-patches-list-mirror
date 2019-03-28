Return-Path: <cygwin-patches-return-9251-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82831 invoked by alias); 28 Mar 2019 09:16:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81539 invoked by uid 89); 28 Mar 2019 09:15:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=vor, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 09:15:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MBDvU-1hFXGs1IrO-00CeaE for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 10:15:08 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E2CD3A8057D; Thu, 28 Mar 2019 10:15:07 +0100 (CET)
Date: Thu, 28 Mar 2019 09:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190328091507.GM4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Content-Disposition: inline
In-Reply-To: <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00061.txt.bz2


--uJWb33pM2TcUAXIl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2975

On Mar 28 09:34, Michael Haubenwallner wrote:
> Hi Corinna,
>=20
> On 3/27/19 10:16 AM, Corinna Vinschen wrote:
> > On Mar 27 09:26, Michael Haubenwallner wrote:
> >> On 3/26/19 7:28 PM, Corinna Vinschen wrote:
> > Wait, let me understand what's going on.  IIUC you're building DLLs
> > which are then used during the build job itself, right?
>=20
> Exactly.
> FWIW, the CI builds also set up a Cygwin instance from scratch,
> as I'm also after testing Cygwin (v3) itself to some degree:
> https://dev.azure.com/gentoo-prefix/ci-builds/_build
>=20
> However, I've not found a commandline option for setup.exe to install
> "test" versions...
>=20
> > As you know, 64 bit has a defined memory layout.  Binutils ld is
> > supposed to base the DLLs to a pseudo-random address in the area between
> > 0x4:00000000 and 0x6:00000000.  This area is occupied by un-rebased DLLs
> > only.  8 Gigs is a *lot* of space for DLLs.
> >=20
> > That also means that the DLLs should not at all collide with windows
> > objects (typically reserved in the lesser 2 Gigs area), unless they
> > collide with themselves.  At least that's the idea.
> >=20
> > Can you check what addresses the freshly built DLLs are based on by LD?
> > Is there a chance that the algorithm used in LD is too dumb?
>=20
> I've also added system_printf to dll_list::reserve_space() when a dynload=
ed
> dll was relocated, and each new address was below 0x0:01000000. The attac=
hed
> output also contains the preferred address, above 0x4:00000000 each.

Do they actually collide with each other?  Did you check the addresses?

> > Or, hmm.  Is there a chance that newer Windows loads dynamically loaded
> > DLLs whereever it likes, ignoring the base address, ASLR-like, even
> > if the DLL is marked as non-ASLR-aware?  But then again, we should have
> > a lot more complaints on the list...
>=20
> I've done this test on Windows Server 2012R2, but the problem exists on
> 2016 and 2019 as well (I'm not testing with other Windows versions).

I wrote an STC:

---
#include <stdio.h>
#include <dlfcn.h>

int main ()
{
  void *a, *b, *c;

  printf ("vor 1. dlopen\n");
  getchar ();
  a =3D dlopen ("/usr/bin/cyggomp-1.dll", RTLD_NOW);
  printf ("loaded cyggomp-1.dll\n");
  getchar ();
  b =3D dlopen ("/usr/bin/cyggs-9.dll", RTLD_NOW);
  printf ("loaded cyggs-9.dll\n");
  getchar ();
  c =3D dlopen ("/usr/bin/cyggtk-3-0.dll", RTLD_NOW);
  printf ("loaded cyggtk-3-0.dll\n");
  getchar ();
  return 0;
}
---

Checking the DLL addresses after each step in the /proc maps file.

The weird thing here is, *all* DLLs, not only the directly loaded,
but also all indirectly loaded dependencies are loaded to their
expected base address between 0x2:00000000 and 0x4:00000000.

There must be collisions in your case.  Can you please check if
Achim's solution works for you?

In the meantime I pushed your patch to the master branch (but not
yet to the 3.0 branch).


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyckJsACgkQ9TYGna5E
T6A+4BAAmzReMjWRZHc/LS8SknMLm1Ed+sdLVJg9GxmjgMsWHs/J4Wo6NxtesluB
ALegu83DXw+SHyodD6/tWKLweCG7vuYYLzLxMKdChpq7HcXqygLqpUKqVmQ1mAdL
3YU4fXWisAvgKfbJWBBZ0l07r0+yHN3sEZgArnuJoPWC8gIoxLYSc7638p6ileq5
U8BmCUoo9ciyqyrLq3TEPzoth46RwYzSgNC/nwnIxYOnfWaTfcxhvopmWWl1re6h
cz6xFRmZkVRiiPjcicfpyRpqNRfmka6vsARz67CF1ukE+vYIgkvCpwovPYXtScy0
KkeexLmcCfEzIsPSiUnKQDH8ThJcRLRqlz6XSw33uoNAxMiLpm5uEV+yWmH4dbwK
mWXlGFUAaIpKgGuP24gWKwJ+NuSwqvdBPMO8TyQQy7Qom/tVlU5QPUsxu52RZye3
Vlz76hCI+xXHIR/fRqBL6OJGo2Ee+WW3xtw2fgej1a3rDVIraK08X8ZjBJL5m6R9
5fXyFNgY8Gxv8CAFEYLQ5OFk8/eMnwYGZHDwrbqOFIVKdqhmJuzbp5QUQx2ImW8C
+w3xNBKBxB+8RtH6bYix87G2WK+SroNrFGhDGAOFHHSymthNMlysL4ebkNFf0fY+
Dh7mOqX6uL050lL2FbFASW6ghKbfWwsvIJTwR8C4w36azycVf5A=
=XS1y
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--
