Return-Path: <cygwin-patches-return-9130-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92092 invoked by alias); 18 Jul 2018 11:26:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92017 invoked by uid 89); 18 Jul 2018 11:26:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=dig, H*c:sk:HHHHHHv
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Jul 2018 11:26:31 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Mha0w-1fS5Kw34gk-00McEe for <cygwin-patches@cygwin.com>; Wed, 18 Jul 2018 13:26:28 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 507D5A80773; Wed, 18 Jul 2018 13:26:28 +0200 (CEST)
Date: Wed, 18 Jul 2018 11:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/3] POSIX Asynchronous I/O support: aio files
Message-ID: <20180718112628.GI27673@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-2-mark@maxrnd.com> <20180717145146.GA23667@calimero.vinschen.de> <20180717155122.GF27673@calimero.vinschen.de> <eb9734df-74e8-8245-5763-a5a262cb594d@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DHd0DHvhbdljNSqO"
Content-Disposition: inline
In-Reply-To: <eb9734df-74e8-8245-5763-a5a262cb594d@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00025.txt.bz2


--DHd0DHvhbdljNSqO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 716

On Jul 18 00:33, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > Mark,
> >=20
> > I think there's a bug in sigtimedwait.  I just found the problem while
> > looking into this aio_suspend stuff:
> > [...]
> > So bottom line is, shouldn't timeout be converted to a negative waittime
> > value in sigtimedwait?
>=20
> Yes, you are correct.  I did not dig deeply enough into cygwait to notice=
 my error.
>=20
> Is it OK for me to fix this as part of the AIO patch set or should it be
> separate?  Either way is fine with me.

Separate patch is better.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--DHd0DHvhbdljNSqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltPI+QACgkQ9TYGna5E
T6D/gg//Ugjy0IJJ7zgEkTRJ1r0N+/RlGm50dcS3vucuCHdsriSu8D8YvDHfDDCR
TnE2WauHZquqjK/SFrJySnfR8hB2/BSrQJBP8svT3iK0M160MEPAk8/O5Ovc9aeZ
sQaLhYlp8cX+QbrUNVTOAiVgyN6D2B0FHnb4x7r8+sppchL0llvMMNml9+W7wWkM
+Di+1VzB7hqEw/bzSOBV5L5Ahe43lntKsOJuWakCQ6ue2VXI7/EUF1auFTJaRNiw
PUVpyXi7VW/A8bcTg52mdnRHjUTtnq/KwD7uwQidM5SnWseuQvLJwPNYgCWuEuZR
3mNLTmNg+xipTLndQwgApfJM7POSPFmAPe//c4SqWJkF7bjA4UdnXVTuNGvj7qL/
naboDjkk6cKmMPttqnoCUZJZZ9mJ0CaRzHtgAFyTzWBEiuZcXwowhEBa1zLzGPxV
VFG5BA7p7dADpw/jA83eH6vhCllyzF4BfIDLISmvMe4uNK2i8XtPfYrZFnA7BdPX
BXgBnGtBZmpYGxlnvfls0BNhcSF64Uss3n4TegbUBiprYiq8RGDHX2rCZu/VBLvv
VA738dzbIhS2DV5vIbM4AVLjxYP+Y9VqJb6CRlt8wnkby3M59GNXxhqY3F8aEO2Z
K2ZMJDcAxM/HHluBIP+AYstAP1vPB98Lk9jc1Q3WVXTIQsG8NE0=
=sxGq
-----END PGP SIGNATURE-----

--DHd0DHvhbdljNSqO--
