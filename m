Return-Path: <cygwin-patches-return-9256-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29107 invoked by alias); 28 Mar 2019 12:37:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28882 invoked by uid 89); 28 Mar 2019 12:37:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 12:37:35 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N2E9Y-1gxmZ00dYM-013eki for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 13:37:32 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2AA75A8057D; Thu, 28 Mar 2019 13:37:31 +0100 (CET)
Date: Thu, 28 Mar 2019 12:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190328123731.GQ4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Tnj+unmjHTqEM5y0"
Content-Disposition: inline
In-Reply-To: <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00066.txt.bz2


--Tnj+unmjHTqEM5y0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1327

On Mar 28 12:48, Michael Haubenwallner wrote:
> On 3/28/19 10:58 AM, Corinna Vinschen wrote:
> > On Mar 28 10:17, Michael Haubenwallner wrote:
> >> As it is not some other dll being loaded at the colliding adress: any
> >> idea how to find out _what_ is allocated there (in the forked child),
> >> to find out whether we can reserve these areas even more early?
> >=20
> > I'm not sure what addresses you're talking about ATM.  The addresses in
> > the 0x4:00000000 - 0x6:00000000 range?
>=20
> No, I'm thinking about the lower address that collides after relocation,
> if there is some cygwin allocated object we may allocate later...
>=20
> > These are the interesting ones.
> > The relocation to some random low address should only occur if there's
> > a collision in this range.
>=20
> This should be easier to find out (by inspecting the loaded dlls).
>=20
> >=20
> > I'm not quite sure how to find out what happens, unless you stop the
> > process in reserve_space and inspect the memory layout with sysinternal=
's
> > vmmap tool:
> >=20
> > https://docs.microsoft.com/en-us/sysinternals/downloads/vmmap
>=20
> Maybe I will try that one - thanks for the pointer!
>=20
> Are you about to apply the patch?

https://sourceware.org/ml/cygwin-patches/2019-q1/msg00061.html


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Tnj+unmjHTqEM5y0
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlycwAsACgkQ9TYGna5E
T6DIfQ//QfdccEal/iA2o+4YMBYEbc8V4HytcYWUrSrKYa9XNj475PqoVh6/aaRA
TvrmXqILXekrNNZRbFZVfjjop8fMR610AxtygGE7nFpsOA7Qi2ASIp10aUHtCFVD
OunyNT1G0ZNAKXz+r0hwKZ2Fsl5S1V6K2RbJqF9uEV1OSDTCc2v7XBFI7WYMTnkI
Y7xVBKQKsM2t2EmXLlZW+C4Z676X7a79NVollmnwS9uY/4pdaSjw0KCsFc2wBNZL
I/yI8+lgdIKID/7kpWGGqov0L/KL+1YRstv7QL+4lzvaIZCDuxVbzrCFXseRepDG
7ts3A0e7Bp4bd2HlX5tKq0VA7yG17UcvF3JUGIKvnnS3imZKjIBOkh488rIPNTHW
w964HFXmHGRKK3Ww8P6esRq4Sk61rfS6UgtyTHkFrmShfRza8fP27PTQGiIuGTgs
YJBO1Hs6JaZBzgKfNrvNAf5GPIVYJhVFmHO/4u+LAaCvqPWqhzJhW/EdsBPCPVjK
wlmZNE4Q0z2E6SO1ytTtOhLpoiqh3pUpVnxtfosru+wS3Via2gpuawRu/gqhJJkr
tG6qpd4Qv39BDqwFsPxGSaaJg+jiz1klDz3r28WJBTZIww0Vhxj9xkKmvjZOs91n
cjyieFm1m1LcIWh5WhUsT6OrUtY10H9GANTsEidXz65ADfQHwQw=
=vixT
-----END PGP SIGNATURE-----

--Tnj+unmjHTqEM5y0--
