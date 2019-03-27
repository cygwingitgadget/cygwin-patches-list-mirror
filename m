Return-Path: <cygwin-patches-return-9243-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124538 invoked by alias); 27 Mar 2019 13:31:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124528 invoked by uid 89); 27 Mar 2019 13:31:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1194, H*F:D*cygwin.com, tomorrow
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 Mar 2019 13:31:03 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mbzdn-1gY98N1JU7-00dSXd for <cygwin-patches@cygwin.com>; Wed, 27 Mar 2019 14:31:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A6B54A80562; Wed, 27 Mar 2019 14:30:59 +0100 (CET)
Date: Wed, 27 Mar 2019 13:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Message-ID: <20190327133059.GG4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190325230556.2219-1-kbrown@cornell.edu> <20190326083620.GI3471@calimero.vinschen.de> <1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu> <20190326190136.GC4096@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <20190326190136.GC4096@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00053.txt.bz2


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1185

On Mar 26 20:01, Corinna Vinschen wrote:
> On Mar 26 17:24, Ken Brown wrote:
> > Hi Corinna,
> >=20
> > On 3/26/2019 4:36 AM, Corinna Vinschen wrote:
> > > Hi Ken,
> > >=20
> > > On Mar 25 23:06, Ken Brown wrote:
> > >> The second patch in this series enables opening a FIFO with O_RDWR
> > >> access.  The underlying Windows named pipe is creted with duplex
> > >> access, and its handle is made the I/O handle of the first client.
> > >>
> > >> While testing this, I had some mysterious crashes, which are fixed by
> > >> the first patch.
> > >=20
> > > I rebased the topic/fifo branch on top of master and force-pushed with
> > > your patches.  Make sure to reset your working tree to origin/topic/f=
ifo
> > > and add any further patches on top.
> >=20
> > I'm comfortable now with merging topic/fifo into master.  I've tested t=
he new=20
> > select and fork code [*], and they seem to work as expected.  That was =
the last=20
> > thing holding me up.
> >=20
> > As soon as the merge is done, ...
>=20
> Will do tomorrow.
>=20
> > ..., I'll send a patch with release notes.

Done.  I also pushed out new dev snapshots.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlybexMACgkQ9TYGna5E
T6DasQ/8CeMCbzwp9kiu/L9uHCdV3Y25m6259h7kk/pKjaQV6HchqLnH935wWnQA
qBPBcUWIDVC5ygEvp601VLbtWJ1CwnroID6eMdNOlp14ont9rf944mKTn48DGEkF
g1eeaNT1aQRLuGiu+uK0TYam5J6bN35X16TWMKXrISQHIhrwmknZkahmVBCdtHXK
1XPyMfgoYJyNAQ08M3JJn+OaoPTXBNQWERIfwLJ9k1UkOclAdGifXgNK7LiNLWMr
NS5pOsKBNY0fhe9bqIGZYDAd+K8Rb7wYBHMgC02O2nto0dfIIckUJIh3yW/vQyae
bDaYYYAzNdCPcSGXSg3zdyndfMGcQiiNQQJoEQKG0LdeS1yEymABUDCdElal2X0p
7lcKNJqtGFT+SI5ZdbO56t39pZw4UkN6a0TdAsWtUap8z24P4RYWR0l6j6D4Nehi
by+MpDgS7D/9E2HtfInXdMJZokb70Snu8/eBjYjxRvnscJnbM3LIgOjJppj6eaha
RPLYllvpgHK6UBO+qO6Nlqeh6v9WAvpYR/1XG1Zfzb5dfGwhzbouRFVzv9+o+n3e
8w62Z8axSP0VqEsFn/PMvwBAwAIAqFqkAJFb3TYU6OogqSHnydgOMWMBedPjeOpl
n+u/eaaOJt5JwXKk0UqanjDk7PnfSErFfUM44HACwpJ4eOkom7M=
=ho1R
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
