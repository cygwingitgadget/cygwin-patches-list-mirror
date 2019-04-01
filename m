Return-Path: <cygwin-patches-return-9295-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108806 invoked by alias); 1 Apr 2019 15:56:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108791 invoked by uid 89); 1 Apr 2019 15:56:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=installation, combined, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 01 Apr 2019 15:56:40 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MeTHG-1gd1ST1R4e-00aXYg; Mon, 01 Apr 2019 17:56:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2FE02A806B0; Mon,  1 Apr 2019 17:56:36 +0200 (CEST)
Date: Mon, 01 Apr 2019 15:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190401155636.GN3337@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	cygwin-patches@cygwin.com
References: <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com> <20190401145658.GA6331@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="0FM4RQAc0jwHekq5"
Content-Disposition: inline
In-Reply-To: <20190401145658.GA6331@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00002.txt.bz2


--0FM4RQAc0jwHekq5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1041

On Apr  1 16:56, Corinna Vinschen wrote:
> On Apr  1 16:28, Michael Haubenwallner wrote:
> > Hi Corinna,
> >=20
> > On 3/28/19 9:30 PM, Corinna Vinschen wrote:
> > > can you please collect the base addresses of all DLLs generated during
> > > the build, plus their size and make a sorted list?  It would be
> > > interesting to know if the hash algorithm in ld is actually as bad
> > > as I conjecture.
> >=20
> > Please find attached the output of rebase -i for the dlls after bootstr=
ap
> > on Cygwin 3.0.4, each built with ld from binutils-2.31.1.

Oh, wait.  That's not what I was looking for.  The addresses are ok, but
the paths *must* be the ones at the time the DLLs have been created,
because that's what ld uses when creating the image base addresses.  The
addresses combined with the installation paths don't make sense anymore.

Apart from that, since you seem to be installing the DLLs anyway, can't
you combine every crucial point during installation with a rebase?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--0FM4RQAc0jwHekq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyiNLQACgkQ9TYGna5E
T6D8Qg/+MVAjhV0Eljubdc6/JPx5SNLYTIZe98ouGRQ6I74fDd0gWh1gzGW7iYB/
MB3Y5pICHdN8D8TbbO6PpEvwrIFXH/v8Au9ffMea8/ZdrF456vFdlSJMTyUuLis8
1vesFqpVrdv0V8bpITUegSFbdIfHYKb9FH3cwNcagwTEXUAY9SahebU2VWmCa2yG
pAyLZaOE59f09YZqL2G3aI78oJRRPewUpqY4FdMR8x+kWrcXa5d9SC3p6dFpBjLn
oWU26pWUDXIHkBJ1bzApASLDXdBWvPY43swkQ0gWGHeWXXSVLEDZfchRmlSWQptn
q8OEAFYzbDjz6yZIdgCJi8EiXcMMUwhp9ApbX+w+bKT/5VDqUOQYddUawUvaYnZ/
g7DgvxD+oW/AMJyytB10TQ02p85lmB408WQH6uQ5wtPs7vplhMb6vpkRVuVtO3pu
e3MkV59XZ1qG1YWZjOqXu5D1njLlivYwjY+k3x8fyXKNry8hm7rCMzSaRgH2ndmD
iupQ4G4G9Ol5mgkMhY157F4BusREPNMsyiJR5+41MagL4m7RWsZtRGt1Z5o/x8i8
2XX8s/U6q2+5Ibuds+jTRkMrZ07U3i/j9pApyXAH8f/YzpaqxYf8n7hgAub7Sg5l
Qu6Oe86OZguCpfaw89QL6LFS8cEPC8fwiKfCQpvrErs3FPUMl0E=
=tupt
-----END PGP SIGNATURE-----

--0FM4RQAc0jwHekq5--
