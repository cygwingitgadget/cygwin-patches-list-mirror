Return-Path: <cygwin-patches-return-9382-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 71901 invoked by alias); 26 Apr 2019 08:23:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71887 invoked by uid 89); 26 Apr 2019 08:23:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=hoods, maintainers, H*R:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 26 Apr 2019 08:23:19 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Md6dH-1gkK4V46AV-00aAy1 for <cygwin-patches@cygwin.com>; Fri, 26 Apr 2019 10:23:17 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 354E8A80776; Fri, 26 Apr 2019 10:23:16 +0200 (CEST)
Date: Fri, 26 Apr 2019 08:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190426082316.GC13355@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com> <20190401145658.GA6331@calimero.vinschen.de> <20190401155636.GN3337@calimero.vinschen.de> <837bc171-eb6f-681e-5167-103f5e9e8523@ssi-schaefer.com> <20190403122216.GX3337@calimero.vinschen.de> <20190412174031.GC4248@calimero.vinschen.de> <96a07e1e-8fe3-8264-7c26-ba09acf8bad3@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <96a07e1e-8fe3-8264-7c26-ba09acf8bad3@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00089.txt.bz2


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2482

On Apr 24 17:09, Michael Haubenwallner wrote:
> On 4/12/19 7:40 PM, Corinna Vinschen wrote:
> > Hi Michael,
>=20
> > Nick Clifton, one of the binutils maintainers, made the following
> > suggestion in PM:
> >=20
> > Allow the ld flag --enable-auto-image-base to take a filename as
> > argument.>=20
> > The idea: The file is used by ld to generate the start address
> > for the next built DLL.  Mechanism:
> >=20
> > 1.1. If ld links a DLL and if the file given to --enable-auto-image-base
> >      doesn't exist, ld will give the DLL the start address of the
> >      auto image base range.
> >=20
> > 1.2: Next time, if ld links a DLL and if the file given to
> >      --enable-auto-image-base exists, it will use the address in that
> >      file as the start address for th just built DLL.
> >=20
> > 2. It will store that address, plus the size of the DLL, rounded up to
> >    64K, in that file.
>=20
> The rounding up is fine to get some alignment for the base address itself,
> but it feels irrelevant if it was for "finding the next base" only.

Well,DLLs always start at a 64K boundary, so it makes sesne to round
immediately.

> > 3. If the auto image base range is at an end, ld will wrap back to
> >    the start address of the auto image base range.>=20
> > TBD: A way to enable this feature without having to change all
> >      packages' build systems.
>=20
> As the --enable-auto-image-base flag does not name any method for finding
> the image base beyond "automatic", IMHO using some predefined control file
> under the hoods should be fine.

The current preliminary solution is to check if a file
~/.ld-pe-auto-image-base exists.  If it doesn't, ld uses the usual
hashing to compute the base address.  If the file exists and is empty,
the base address range start address is used (i.e. 0x4:00000000),
otherwise the address is taken from the file and the next free address
after that is written back to the file.

The problem is that auto-image-basing occurs *so* early in ld,
that the size of the built DLL isn't known when writing the file back.
To do this right there needs to be a bigger change to ld, the current
infrastructure around image basing doesn't allow to call saving the file
content deferred.

So ATM, ld just adds ~38 Megs to the current DLL address, which is
1 Meg more than the largest Cygwin DLL on my system.

There's already a bit more in terms of settings, but that's still
in the works.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlzCv/QACgkQ9TYGna5E
T6BEQA/+O4FosrOgqlRYkN8UZ9Jgd3JAygAK94AIm+XNHTmfkhAiTBOmhamvvxjQ
UdqhU8mPK+d0k0dX+kdWdBbcYh4z5B91eYSRVv103j/nKqEKH31e4dJY+VmC1ScQ
Xylah8JQYUDJXOi7/TS8AMOtMK7nMTUT4keXKBpZW7Bj5rwpPuGCLvoR8O+IcQnd
0kAUHbebfHauI3bic9e7O5KGb/Z92EZ+M1nHPY5/jee1F62BV2QwbqxKHKdsi9dV
n6JQVdYz2mCnCfJF3N2RWgjHLuxZWDGr0WA/onFFJEjaBug6ol3xoiQC/sa4Z6Ym
1cp7S6wZ9UhUAD6Tyi5nzschok6BYJmvvh0ieijb8aLkhNNZxaW8/8+aQoU+OwAJ
4DpoM/e1/Y5ISwA+1OMpwwHptKZXnGusVFvxJbzQMO0Bw7xeCEZPxpbwxvr1DnCk
Q9KsIHRKtt8jR8Q1n+GXnLJgzmjbtvl5Ij+YdjU2l0yisj7mwpSuKJDen3r9ai1R
Qc/mAW/ymTkhwv4CBXUECqoyoEgp51Cfqst5sh4y/zkLr9qgiBd1qEdwjXGZy4Fo
Pfa7cKa7g/+u+ovfVYmU+ztOu50iJKJqPESWJGeCrt6DOQwYk1BShZZ5gEGZbMMa
mYV99Xve+2fRUgj7u9mdnyOB1Jex2TpXos+d6HxpegZuzNKoR/8=
=7isd
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
